From: Damien Robert <damien.olivier.robert+gmane@gmail.com>
Subject: git rebase -p and patch equivalent commits
Date: Tue, 16 Oct 2012 19:58:50 +0000 (UTC)
Message-ID: <k5ke9q$gom$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 16 22:05:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TODOA-0003oS-3h
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 22:05:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754212Ab2JPUFF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2012 16:05:05 -0400
Received: from plane.gmane.org ([80.91.229.3]:46021 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752251Ab2JPUFD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2012 16:05:03 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TODNw-0003aa-Kb
	for git@vger.kernel.org; Tue, 16 Oct 2012 22:05:04 +0200
Received: from phare.normalesup.org ([129.199.129.80])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 16 Oct 2012 22:05:04 +0200
Received: from damien.olivier.robert+gmane by phare.normalesup.org with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 16 Oct 2012 22:05:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: phare.normalesup.org
X-Newsreader: Flrn (0.9.20070704)
X-Start-date: Tue, 16 Oct 2012 21:45:35 +0200 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207877>

Hi all,
I was wondering if you had any tips on the following workflow:
I work on an experimental feature branch of a project. I have some patches
that I implement in branch patch1 and patch2 on top of the feature branch.
I test if they both work together by merging patch1 and patch2 into a build
branch:
    mkdir build && cd build
    git init
    echo a > a && git add a && git commit -am a
    git branch feature
    git co -b patch1
    echo b > b && git add b && git commit -am b
    git co -b patch2 feature
    echo c > c && git add c && git commit -am c
    git co -b build feature
    git merge --no-edit patch1 patch2
Now feature is rebased against master. How would you rebase the branches
patch1, patch2 and build so that they keep the same layout?

I tried to rebase patch1 and patch2, hoping that rebase -p build would use
the rebased commits for the merge but it creates new commits (that are
patch equivalents to patch1 and patch2) and merge them.

So I can think of two ways to proceed:
1) only rebase patch1 and patch2, and then remerge them again in build.
   This start to get complicated if I have some commits in build after the
   merge, I will then need to rebase them on top of the new merge. And for
   a more complicated layout it will get pretty hard to recreate it
   automatically.
2) I can rebase -p the build branch first, and then reset --soft patch1 and
   patch2 so that they point to the right commits in the rebased branch.
   This way looks easier to do with more complicated layout, I just need to
   find a good way of finding where the rebased commits for patch1 and
   patch2 are, and I was thinking of using notes for that.

So my question is: does it look like a sensible approach? Is there an
easier way I am missing?

Thanks!
