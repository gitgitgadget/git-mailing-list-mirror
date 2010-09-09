From: "Neal Kreitzinger" <neal@rsss.com>
Subject: interactive rebase "reword" runs pre-commit hook but ignores non-zero exit status
Date: Wed, 8 Sep 2010 19:26:58 -0500
Message-ID: <i699mo$8jd$1@dough.gmane.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 09 02:28:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtV08-0002qn-IA
	for gcvg-git-2@lo.gmane.org; Thu, 09 Sep 2010 02:28:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755653Ab0IIA2X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Sep 2010 20:28:23 -0400
Received: from lo.gmane.org ([80.91.229.12]:54171 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753194Ab0IIA2V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Sep 2010 20:28:21 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OtUzx-0002o0-DB
	for git@vger.kernel.org; Thu, 09 Sep 2010 02:28:17 +0200
Received: from 67.63.162.200 ([67.63.162.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 09 Sep 2010 02:28:17 +0200
Received: from neal by 67.63.162.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 09 Sep 2010 02:28:17 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 67.63.162.200
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-RFC2646: Format=Flowed; Original
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5931
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155826>

I've isolated what seems to be a loophole in interactive rebase by rebasing 
a branch for the sole purpose of rewording some commits:

(I just finished performing a rebase for the sole purpose of squashing 
several commits into 2 commits)
(Now I want to reword those 2 commits)

$ git --version = 1.7.1
$ git rebase -i --onto BranchA~2 BranchA~2 BranchA
(change "pick" to "reword" in rebase-stack editor)
reword Abbrsha1 some-commit-message
reword Bbbrsha1 some-other-commit-message
# Rebase Cbbrsha1..Dbbrsha1 onto Cbbrsha1
(save changes in editor)
".git/rebase-merge/git-rebase-todo" 15L, 580C written
(shows output from pre-commit hook and the corresponding non-zero exit)
Start of pre-commit hook...
checking for something I don't like...
ERROR: I found something I don't like!
Commit Aborted!
Start of pre-commit hook...
checking for something I don't like...
ERROR: I found something I don't like!
Commit Aborted!
Successfully rebased and updated refs/heads/BranchA.
$ _

In this case, the thing that caused the pre-commit to error-out was that the 
format of a report that it runs was changed.  So in this case, I will 
rebase -i and "edit" the commits and git-add the new report format so the 
pre-commit doesn't complain.  However, I originally tried to do the reword 
and squash in a single rebase and it gave the same errors, but performed the 
squashes.  Is this the intended behavior?  On the one hand, you shouldn't be 
changing content in a "reword", but on the other hand if you're going to run 
the pre-commit hook then shouldn't you abort the rebase if the pre-commit 
hook exits with non-zero status?

I admit that a workflow in which content changes on a reword may not be a 
valid scenario that you should care about in your rebase exception handling, 
but shouldn't you care that the pre-commit hook exited with non-zero status 
regardless of the reason why it exited with non-zero status?  Just a 
question.

v/r,
Neal
