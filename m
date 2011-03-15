From: Yann Dirson <dirson@bertin.fr>
Subject: Re: [PATCH] Document 'git bisect fix'.
Date: Tue, 15 Mar 2011 11:16:20 +0100
Organization: Bertin Technologies
Message-ID: <20110315111620.73108597@chalon.bertin.fr>
References: <20110314210001.GE4586@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git list <git@vger.kernel.org>,
	Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 15 11:35:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzRbS-0000SG-S2
	for gcvg-git-2@lo.gmane.org; Tue, 15 Mar 2011 11:35:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757164Ab1COKfp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2011 06:35:45 -0400
Received: from blois.bertin.fr ([195.68.26.9]:41277 "EHLO blois.bertin.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756192Ab1COKfo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2011 06:35:44 -0400
Received: from blois.bertin.fr (localhost [127.0.0.1])
	by postfix.imss70 (Postfix) with ESMTP id 26F75542E8
	for <git@vger.kernel.org>; Tue, 15 Mar 2011 11:35:43 +0100 (CET)
Received: from yport1.innovation.bertin.fr (yport1.bertin.fr [192.168.1.13])
	by blois.bertin.fr (Postfix) with ESMTP id 01E3D542D5
	for <git@vger.kernel.org>; Tue, 15 Mar 2011 11:35:43 +0100 (CET)
Received: from chalon.bertin.fr ([172.16.1.1]) by yport1.innovation.bertin.fr
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPPA id <0LI300MLDHFII4B0@yport1.innovation.bertin.fr> for
 git@vger.kernel.org; Tue, 15 Mar 2011 11:35:42 +0100 (CET)
In-reply-to: <20110314210001.GE4586@gmx.de>
X-Mailer: Claws Mail 3.7.8 (GTK+ 2.20.1; i486-pc-linux-gnu)
X-TM-AS-Product-Ver: IMSS-7.0.0.8220-6.5.0.1024-18012.004
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169060>

Hi Ralf,

Maybe you should have made it more obvious that this patch is a RFC
for a proposed feature (say, in subject line).

>'git bisect fix' teaches bisect about when some known bug was
>introduced and when it was fixed, so that bisect can merge in
>the fix when needed into new test candidates.

This sounds like a great idea.  I do have myself to do conditional
cherry-picks from bisect scripts, to deal with this problem.

>If some bug was fixed by a merge only, the more general notation
>"f_1 ^b_1 ^b_1' ..." could apply.

Some more precise example may make this case more clear.


+Fixing up known bugs
+~~~~~~~~~~~~~~~~~~~~
+
+If many revisions are broken due to some unrelated but known issue that
+is easily fixed, you might want to prefer fixing it up temporarily.

It seems natural for "bisect run" to use this mechanism.  What about
the non-automated process ?  We may want to get the fixes applied, or
to only list available fixes to the user so he can "git merge" them
manually, or maybe an interactive selection mode ?  Probably something
to be chosen via some config variable and flags, in a separate patch
of the would-be series.  But what happens initially will be a good thing
to document.

+If `<commit1>` introduces a bug fixed by `<commit2>`, instruct bisect
+to merge the latter before testing a commit that contains the former:
+
+------------
+$ git bisect fix <commit1>..<commit2>
+------------

Usually, a bug also gets fixed by an official commit which does not
fulfill the constraint of being branched at the faulty one.  In this
case you don't want to merge the fix if such a fix is already included,
and thus you will need a way to specify "alternate fixes" to control
this.

+A single `<commit>` acts as if `<commit>^..<commit>` was specified.
+Fix statements can be repeated for every known bug, and are valid until
+the bisection state is cleaned up with reset.

That is on the safe side, but we may at some point want some sort of
"repository of fixes", where this info gets stored for easy reuse on
subsequent bisections.

+Any bisect action that causes a new commit to be chosen will try to merge
+the needed fixes and fail if they do not merge cleanly.

maybe "... similar to what happens when a bisect-run script terminates with exit code
greated than 127." ?

-- 
Yann Dirson - Bertin Technologies
