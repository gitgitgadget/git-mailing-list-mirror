From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Segmentation fault in git-svn
Date: Tue, 17 Apr 2007 02:37:43 -0700
Message-ID: <20070417093743.GA9222@muzzle>
References: <4623F613.5010108@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 11:37:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hdk8D-0001nD-BZ
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 11:37:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753086AbXDQJhq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 05:37:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753105AbXDQJhq
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 05:37:46 -0400
Received: from hand.yhbt.net ([66.150.188.102]:54779 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753086AbXDQJhp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 05:37:45 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id ACF757DC09F;
	Tue, 17 Apr 2007 02:37:43 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 17 Apr 2007 02:37:43 -0700
Content-Disposition: inline
In-Reply-To: <4623F613.5010108@midwinter.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44747>

Steven Grimm <koreth@midwinter.com> wrote:
> I expect this is really a libsvn bug, but git-svn triggers it, so I'm 
> hoping someone else has run into and solved it, or at least that someone 
> can reproduce it.

I've also been working with another user off-list the past few
days on tracking down on a segmentation fault in git-svn.

> If I try to clone the "memcached" public repository with the command line
> 
>  git-svn clone --branches=branches --trunk=trunk 
> http://code.sixapart.com/svn/memcached

I just ran this several (6?) times got a segmentation fault once
with Junio's master @ f948792990f82a35bf0c98510e7511ef8acb9cd3.

Trying it again with the same file that segfaulted earlier, it was
successful, spooky...

I also tried some other patches (see replies) which I've been testing to
fix the other user's problem.

> it cranks along fine until revision 299, then dies with SIGSEGV. If I 
> run it again, it appears to pick up where it left off, then dies again 
> at revision 399, then again at revision 499. (There are fewer than 600 
> revisions in that repo so it's anyone's guess if it'd die at 599 given 
> the chance.)

I have definitely not seen this pattern before.

However, the following clone has been problematic at times

git svn clone svn://svn.debian.org/svn/pkg-glibc/glibc-package \
  -T trunk -b branches -t tags

> This happens on both a Linux box (amd64, FC4, svn version 1.4.3) and my 
> Mac (Intel OS 10.4, svn version 1.2.3 from Fink), so at the very least 
> it's not platform-specific. It also happens periodically on the private 
> svn repository at my company, though not as predictably. On my Mac, I'm 
> using the very latest git code from "master".

I'm running x86, Debian Etch, SVN 1.4.2 from Debian Etch or
1.4.3 from Debian experimental + do_switch patch[1]

Thanks for the stack trace.  This is segfaulting at
a different place (expected, being an http:// repo while
the other is svn://)

[1] - http://svn.haxx.se/dev/archive-2007-01/0936.shtml

-- 
Eric Wong
