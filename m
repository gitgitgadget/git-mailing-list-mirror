From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 0/5] {checkout,reset,stash} --patch
Date: Sun, 9 Aug 2009 02:52:07 -0400
Message-ID: <20090809065207.GA14093@coredump.intra.peff.net>
References: <200907271210.40001.trast@student.ethz.ch>
 <cover.1248815580.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Aug 09 08:52:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ma2Ga-0007Kj-Sq
	for gcvg-git-2@gmane.org; Sun, 09 Aug 2009 08:52:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752005AbZHIGwJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2009 02:52:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751985AbZHIGwJ
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Aug 2009 02:52:09 -0400
Received: from peff.net ([208.65.91.99]:53349 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751511AbZHIGwI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2009 02:52:08 -0400
Received: (qmail 2184 invoked by uid 107); 9 Aug 2009 06:54:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 09 Aug 2009 02:54:21 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 09 Aug 2009 02:52:07 -0400
Content-Disposition: inline
In-Reply-To: <cover.1248815580.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125322>

On Tue, Jul 28, 2009 at 11:20:06PM +0200, Thomas Rast wrote:

> Thomas Rast (6):
>   git-apply--interactive: Refactor patch mode code
>   builtin-add: refactor the meat of interactive_add()
>   Implement 'git reset --patch'
>   Implement 'git checkout --patch'
>   Implement 'git stash save --patch'
>   DWIM 'git stash save -p' for 'git stash -p'

I finally got a few minutes to look at this. I tried "checkout --patch"
first, which was very confusing:

  $ echo old content >file && git add file && git commit -m old
  $ echo new content >>file
  $ git checkout --patch file
  diff --git a/file b/file
  index 33194a0..805c3b0 100644
  --- a/file
  +++ b/file
  @@ -1 +1,2 @@
   old content
   +new content
  Check out this hunk [y,n,q,a,d,/,e,?]?

Shouldn't the diff be reversed? That is, I think what users would like
to see is "bring this hunk over from the index to the working tree". But
we have the opposite (a hunk that is in the working tree that we would
like to undo).

Maybe it is just the use of the verb "check out". I think of it as
bringing _this_ hunk out. But it is really about erasing this hunk. "git
reset --patch" has the same behavior, but I don't find it as bothersome,
since it says "Reset this hunk".

And "stash --patch" doesn't have the issue because it goes from the
working tree to the stash already.

-Peff
