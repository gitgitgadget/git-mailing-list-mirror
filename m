From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] git builtin "push"
Date: Sun, 30 Apr 2006 13:07:42 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604301303010.5231@g5.osdl.org>
References: <Pine.LNX.4.64.0604292111570.9901@g5.osdl.org> <445516F5.1090204@garzik.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 30 22:08:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FaID3-0000tp-E3
	for gcvg-git@gmane.org; Sun, 30 Apr 2006 22:08:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751026AbWD3UHv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Apr 2006 16:07:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751034AbWD3UHv
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Apr 2006 16:07:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51385 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751024AbWD3UHu (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Apr 2006 16:07:50 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3UK7htH018159
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 30 Apr 2006 13:07:43 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3UK7g3w010110;
	Sun, 30 Apr 2006 13:07:42 -0700
To: Jeff Garzik <jeff@garzik.org>
In-Reply-To: <445516F5.1090204@garzik.org>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19354>



On Sun, 30 Apr 2006, Jeff Garzik wrote:

> Linus Torvalds wrote:
> > Now, the reason I did it as a built-in is partly because it's yet another
> > step on relying less on shell, but it's actually mostly because I've wanted
> > to be able to push to _multiple_ repositories, and the most obvious and
> > simplest interface for that would seem be to just have a "remotes" file that
> > has multiple URL entries.
> 
> Thanks!  This is why I still use rsync, even though everybody and their mother
> tells me "Linus says rsync is deprecated."

No. You're using rsync because you're actively doing something _wrong_.

> Fact is, rsync is still the best to push a _bunch_ of branches, in the same
> tree, all in one command.

Not so. My builtin thing doesn't help at all, because it doesn't _need_ to 
help that case. You can already push as many branches as you want with the 
old "git push".

My builtin thing helps push to multiple _repositories_, not to multiple 
branches. I push out my stuff to two separate repos at master.kernel.org, 
and one at an osdl.org server machine, because if I lose my tree, I want 
to be sure I have alternate backups.

> In an attempt to get away from rsync, I even tried putting multiple 
> git:// entries into .git/remotes/origin, then doing "git push" with no 
> args, without success.

That's not how it works, and not how it has ever worked.

The way it works is that

	"git push repo"

with no branch specs will update all branches that are IN COMMON between 
your tree and the repository you're pushing to. In other words, it's meant 
to sync up the branches that you have already pushed.

If you want to push other branches, you need to do

	git push repo branch1 branch2 branch3 ...

or

	git push --all repo

where the latter does exactly what it says (use "--tags" instead of 
"--all" to just send all tags).

In all cases you will find that it's a hell of a lot more efficient than 
rsync ever has been.

		Linus
