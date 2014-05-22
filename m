From: Jeff King <peff@peff.net>
Subject: Re: git reset for index restoration?
Date: Thu, 22 May 2014 12:46:34 -0400
Message-ID: <20140522164634.GB30419@sigill.intra.peff.net>
References: <1400775763.1933.5.camel@stross>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git mailing list <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu May 22 18:46:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnW8e-0003Yh-Dd
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 18:46:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752476AbaEVQqh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 12:46:37 -0400
Received: from cloud.peff.net ([50.56.180.127]:57474 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752057AbaEVQqf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 12:46:35 -0400
Received: (qmail 6656 invoked by uid 102); 22 May 2014 16:46:35 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 22 May 2014 11:46:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 May 2014 12:46:34 -0400
Content-Disposition: inline
In-Reply-To: <1400775763.1933.5.camel@stross>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249915>

On Thu, May 22, 2014 at 12:22:43PM -0400, David Turner wrote:

> If I have a git repository with a clean working tree, and I delete the
> index, then I can use git reset (with no arguments) to recreate it.
> However, when I do recreate it, it doesn't come back the same.  I have
> not analyzed this in detail, but the effect is that commands like git
> status take much longer because they must read objects out of a pack
> file.  In other words, the index seems to not realize that the index (or
> at least most of it) represents the same state as HEAD.  If I do git
> reset --hard, the index is restored to the original state (it's
> byte-for-byte identical), and the pack file is no longer read.

Are you sure it's reading a packfile? I would expect that it is rather
reading the files in the working tree. One of the functions of the index
is to maintain a cache of the sha1 of the working tree file content and
the stat information. Once that is populated, a subsequent "git status"
can then just lstat() the files to see that its sha1 cache is up to
date.

-Peff
