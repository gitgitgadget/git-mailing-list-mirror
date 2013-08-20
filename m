From: Jeff King <peff@peff.net>
Subject: [PATCH 0/2] git-config and large integers
Date: Tue, 20 Aug 2013 18:39:54 -0400
Message-ID: <20130820223953.GA3429@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 21 00:40:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBuar-0002TE-BH
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 00:40:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443Ab3HTWkA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 18:40:00 -0400
Received: from cloud.peff.net ([50.56.180.127]:41034 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751322Ab3HTWj7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 18:39:59 -0400
Received: (qmail 13285 invoked by uid 102); 20 Aug 2013 22:39:59 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 20 Aug 2013 17:39:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Aug 2013 18:39:54 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232659>

I was playing with a hook for file size limits that wanted to store the
limit in git-config. It turns out we don't do a very good job of big
integers:

  $ git config foo.size 2g
  $ git config --int foo.size
  -2147483648

Oops. After this series, we properly notice the error:

  $ git config --int foo.size
  fatal: bad config value for 'foo.size' in .git/config

and even better, provide a way to access large values:

  $ git config --ulong foo.size
  2147483648

The patches are:

  [1/2]: config: properly range-check integer values
  [2/2]: teach git-config to output large integers

-Peff
