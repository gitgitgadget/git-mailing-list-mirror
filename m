From: Joel Becker <Joel.Becker@oracle.com>
Subject: Re: git versus CVS (versus bk)
Date: Mon, 31 Oct 2005 16:42:55 -0800
Message-ID: <20051101004255.GQ11488@ca-server1.us.oracle.com>
References: <Pine.LNX.4.64.0510301720390.14972@x2.ybpnyarg> <Pine.LNX.4.64.0510301811390.27915@g5.osdl.org> <Pine.LNX.4.63.0510311111340.2916@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0510310804400.27915@g5.osdl.org> <20051031195010.GM11488@ca-server1.us.oracle.com> <7vr7a1e719.fsf@assigned-by-dhcp.cox.net> <20051031213616.GO11488@ca-server1.us.oracle.com> <7vk6ftcp0d.fsf@assigned-by-dhcp.cox.net> <20051031224246.GP11488@ca-server1.us.oracle.com> <7vbr15b4m4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Nov 01 01:43:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWkF9-0000T0-2M
	for gcvg-git@gmane.org; Tue, 01 Nov 2005 01:43:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbVKAAnM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Oct 2005 19:43:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751367AbVKAAnM
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Oct 2005 19:43:12 -0500
Received: from rgminet02.oracle.com ([148.87.122.31]:18655 "EHLO
	rgminet02.oracle.com") by vger.kernel.org with ESMTP
	id S1751362AbVKAAnL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Oct 2005 19:43:11 -0500
Received: from rgmsgw01.us.oracle.com (rgmsgw01.us.oracle.com [138.1.186.51])
	by rgminet02.oracle.com (Switch-3.1.6/Switch-3.1.7) with ESMTP id jA10gwjU002339;
	Mon, 31 Oct 2005 17:42:58 -0700
Received: from rgmsgw01.us.oracle.com (localhost.localdomain [127.0.0.1])
	by rgmsgw01.us.oracle.com (Switch-3.1.7/Switch-3.1.7) with ESMTP id jA10gwa8020357;
	Mon, 31 Oct 2005 17:42:58 -0700
Received: from ca-server1.us.oracle.com (ca-server1.us.oracle.com [139.185.118.41])
	by rgmsgw01.us.oracle.com (Switch-3.1.7/Switch-3.1.7) with ESMTP id jA10guQ9020327
	(version=TLSv1/SSLv3 cipher=DES-CBC3-SHA bits=168 verify=NO);
	Mon, 31 Oct 2005 17:42:56 -0700
Received: from jlbec by ca-server1.us.oracle.com with local (Exim 4.53)
	id 1EWkEp-0007Tc-Ug; Mon, 31 Oct 2005 16:42:55 -0800
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vbr15b4m4.fsf@assigned-by-dhcp.cox.net>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.10i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10911>

On Mon, Oct 31, 2005 at 04:20:51PM -0800, Junio C Hamano wrote:
> After extracting a sequence of the dirty commits using
> git-format-patch, I would say:
> 	for i in 0*.txt; do git-apply --index $i; done
> to bring my tree up to date, and then just say "git commit".

	Yeah, but this is a lot of by-hand (as you note below).

> Typically when I do this, I have one "significant" commit among
> them, usually early in the series, which is followed by smaller
> "fix this, fix that, oops fix that too" commits.  So I edit the
> log message using the log of the significant commit, and add
> some missing bits.

	When I work, regardless of SCM, I generally have many
checkpoints along the way.  It might be a particular subfeature is
complete (and probably deserves a split-out patch of its own when I do
the "clean" merge), but it could also just be "I changed a lot today,
and I'd really like to save that off."  So, while somtimes it looks just
like your "significant commit + fixes" model, it might also be "1/4 the
work", "compile fix on other platform, "1/2 the work", "fix", "the rest
of the work", all over the course of two days.

>         $ git-read-tree -m -u master mytopic
>         $ git-commit -c <that-significant-commit-in-mytopic-branch>

	Replace <that-...> with <overall-concept-of-the-change> and you
have the workflow I'm talking about.
	You know, this is a simpler command set than I am using.  I've
been using Cogito, because it makes many of the 5-step git operations a
single step, more like some other tools.  But I know no way to tell
Cogito to merge all the changes of the branch into the master without
also pulling in the commit history.  That's the thing here.  Petr, do
you have a way of doing this that I don't know about?
	What I mean is, for the "naive" Cogito workflow:

	cg-clone repo working
	cd working
	hack hack hack, commit commit commit
	cd mainline
	cg-pull working

the cg-pull command merges the changes back, but it also includes the
full commit history.  Not what we want.  Compare the "identical"
workflow:

	cg-clone repo working
	cd working
	hack hack hack, commit commit commit
	cg-diff mainline working > patch
	cd mainline
	cg-apply < patch
	cg-commit

My basic premise is that I shouldn't have to deal with diff/patch as an
external step, especially since git knows more about the tree than
diff/patch do.  It's a useless hoop to jump through.
	Maybe Cogito contains something like what you describe above, a
way to get all the file changes without actually pulling in the commit
history.  I don't care that the read-tree and the commit are separate
stages.  I just have to type them.


> is possible) offhand.  Sometimes, when you want truly logical
> steps, you would end up needing intermediate steps that never
> existed in your true history (i.e. "in the hindsight, my
> development should have progressed in these steps.")

	Yes, I always do.  But I'm not talking about that sort of large
feature add or whatever.  I'm talking about merely doing something on a
small scale, but in a temporary repository.

Joel

-- 

Life's Little Instruction Book #510

	"Count your blessings."

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
