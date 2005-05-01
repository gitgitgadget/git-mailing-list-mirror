From: Daniel Jacobowitz <dan@debian.org>
Subject: Re: [PATCH] Resurrect diff-tree-helper -R
Date: Sat, 30 Apr 2005 21:47:26 -0400
Message-ID: <20050501014726.GA15220@nevyn.them.org>
References: <7v7jij3htp.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504301805300.2296@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 03:58:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DS3in-0001qL-Mp
	for gcvg-git@gmane.org; Sun, 01 May 2005 03:58:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261502AbVEABro (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Apr 2005 21:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261503AbVEABrn
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Apr 2005 21:47:43 -0400
Received: from nevyn.them.org ([66.93.172.17]:21154 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S261502AbVEABrb (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Apr 2005 21:47:31 -0400
Received: from drow by nevyn.them.org with local (Exim 4.50 #1 (Debian))
	id 1DS3YM-0003yJ-Sg; Sat, 30 Apr 2005 21:47:26 -0400
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504301805300.2296@ppc970.osdl.org>
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 30, 2005 at 06:09:53PM -0700, Linus Torvalds wrote:
> So it would be much nicer (I think) if mode changes are handled 
> separately, with a simple separate line before the diff saying
> 
> 	"Mode change: %o->%o %s", oldmode, newmode, path
> 
> and not mess up the diff header. That way, you only see it when it
> actually makes any difference, and it's more readable both for humans
> _and_ machines as a result.
> 
> Normal "patch" will just ignore the extra lines before the diff anyway, so 
> it won't matter there.
> 
> Comments?

It sounds good - but could you efficiently collect them before any diff
output?  If you have something like this, it'll be easy to read:

Mode change: 644->755 foo.sh
Mode change: 644->755 bar.sh

--- ChangeLog
+++ ChangeLog
@@ -1,0 +1,1 @@
+New line
--- copyright
+++ copyright
@@ -1,0 +1,1 @@
+New line


But if you generate this then you might as well not generate the mode
lines at all, for all a human looking at the diff is going to notice
them:

--- ChangeLog
+++ ChangeLog
@@ -1,0 +1,1 @@
+New line
Mode change: 644->755 foo.sh
--- copyright
+++ copyright
@@ -1,0 +1,1 @@
+New line
Mode change: 644->755 bar.sh


The latter is how diff does its "Only in" messages.  I never see them
when I'm looking through a diff of any size; only via diffstat, where
they're clearly disambiguated.

-- 
Daniel Jacobowitz
CodeSourcery, LLC
