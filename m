From: arQon <arqon@gmx.com>
Subject: Re: [BUG] git checkout <branch> allowed with uncommitted changes
Date: Thu, 13 Oct 2011 11:51:12 +0000 (UTC)
Message-ID: <loom.20111013T130924-792@post.gmane.org>
References: <loom.20111013T094053-111@post.gmane.org> <CACsJy8Dzy5-kOZAjwdx=ooUdnN0L2F3EiNQ7b==3AGQZYjEUXQ@mail.gmail.com> <20111013145924.2113c142@ashu.dyn.rarus.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 13 13:51:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REJoy-00057r-Lx
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 13:51:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753282Ab1JMLv1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Oct 2011 07:51:27 -0400
Received: from lo.gmane.org ([80.91.229.12]:35952 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751384Ab1JMLv1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2011 07:51:27 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1REJoq-00053m-Gd
	for git@vger.kernel.org; Thu, 13 Oct 2011 13:51:24 +0200
Received: from 24-180-45-63.dhcp.crcy.nv.charter.com ([24.180.45.63])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 13 Oct 2011 13:51:24 +0200
Received: from arqon by 24-180-45-63.dhcp.crcy.nv.charter.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 13 Oct 2011 13:51:24 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 24.180.45.63 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Ubuntu/10.04 (lucid) Firefox/3.6.23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183470>

Snipping the bug and focusing on one of the after-effects of the bug is,
unfortunately, not helpful to me unless I'm missing your point (which is
certainly possible).

git switched branches while there were uncommitted files. It's not supposed to
do this, ever, unless given -f or -m, and it broke the tree as a result. Even
*with* -f or -m, the behavior I described is incorrect.
The git docs seem to agree with me, which is why there's git stash. If the docs
are wrong, fine, though it seems pretty strange to have a change on BranchA
appear by magic "in" BranchB without any merging.

What I'm after is an understanding / explanation of how something that isn't
supposed to happen, does. I don't care if it's "Because I'm an idiot", "Because
git is broken", or even "Make sure your config has 'git.makebranchesworkproperly
= true' in it, the default is false". If there is no explanation for why git
switches branches when there are still uncommitted files, and there doesn't seem
to be, then it's a pretty catastrophic bug and fixing it would be a Good Thing.

*AFAICT*, committing *a* file is what triggers it.
If you commit -a, which is what all the commits prior to this were, it works
properly. You change branches, and the files on the disk become what they should
be.
If you commit nothing, you correctly get the "uncommitted files" error.
If you do a partial commit though, your tree breaks.

Like I say, if the man page, quote:
"If you have local modifications to one or more files that are different between
the current branch and the branch to which you are switching, the command
refuses to switch branches in order to preserve your modifications in context."
is wrong, and this behavior is deliberate, that's fine. Bizarre, but fine in
the sense that git is doing what it's supposed to (regardless of how
counterintuitive and destructive it is).
If the man page is right though, this is a bug. Maybe it's only in msysgit,
but this is the second time it's happened, so hopefully it's fairly easy to
reproduce.
