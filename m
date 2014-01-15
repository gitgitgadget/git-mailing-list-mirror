From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/6] read-cache: connect to file watcher
Date: Wed, 15 Jan 2014 05:58:42 -0500
Message-ID: <20140115105842.GG14335@sigill.intra.peff.net>
References: <1389524622-6702-1-git-send-email-pclouds@gmail.com>
 <1389524622-6702-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 15 11:58:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3OBN-0006ZA-4V
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jan 2014 11:58:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbaAOK6p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Jan 2014 05:58:45 -0500
Received: from cloud.peff.net ([50.56.180.127]:32783 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750933AbaAOK6o (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jan 2014 05:58:44 -0500
Received: (qmail 16035 invoked by uid 102); 15 Jan 2014 10:58:44 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 15 Jan 2014 04:58:44 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Jan 2014 05:58:42 -0500
Content-Disposition: inline
In-Reply-To: <1389524622-6702-4-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240452>

On Sun, Jan 12, 2014 at 06:03:39PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:

> This patch establishes a connection between a new file watcher daemon
> and git. Each index file may have at most one file watcher attached t=
o
> it. The file watcher maintains a UNIX socket at
> $GIT_DIR/index.watcher. Any process that has write access to $GIT_DIR
> can talk to the file watcher.

IIRC, this is not portable. Some systems (not Linux) will allow anyone
to connect to the socket if it the file is accessible to them (so
anybody with read access to $GIT_DIR can talk to the file watcher). The
usual trick is to put it in a sub-directory that only the connectors ca=
n
access (e.g., put it in "$GIT_DIR/watcher/index", and create "watcher"
mode 0700).

-Peff
