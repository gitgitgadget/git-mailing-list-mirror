From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/6] prompt: don't scream continuation state
Date: Sun,  2 Jun 2013 19:33:37 +0530
Message-ID: <1370181822-23450-2-git-send-email-artagnon@gmail.com>
References: <1370181822-23450-1-git-send-email-artagnon@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 02 16:06:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uj8vB-0000qM-Sm
	for gcvg-git-2@plane.gmane.org; Sun, 02 Jun 2013 16:06:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752563Ab3FBOGE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Jun 2013 10:06:04 -0400
Received: from mail-pb0-f53.google.com ([209.85.160.53]:54453 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752065Ab3FBOGC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jun 2013 10:06:02 -0400
Received: by mail-pb0-f53.google.com with SMTP id un4so4513995pbc.12
        for <git@vger.kernel.org>; Sun, 02 Jun 2013 07:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=6hQh0zn/BDjzf12IN8kxGP3517yU3REiYIPutkUzDMI=;
        b=RWcFoEDuKXZeJy7vjNxoxHdwhfz32LTh3548L2/mSZ2LsQSVsW0F1oOVhM7LS7IT4v
         wWFAHaH7g/ePBbW2ko1dqM6oYxFxaTJexDypXFhEYvsCePlXcAbnVCK4ijBhobAKOz5m
         GT+Vm0aXCQEufa9G+iOSF1BagYxzg8u9vpFcQ2uScWr9D7SnnbuMAApJ1U0kqiSYyhUg
         edszl3Hmwp9NJtdUH6OwiIQUe2jtZ6yi9h/JZWcaLs8MYgChQDEJjFj0BJl1PazzlWiF
         UmSeYfDt8qQLfVZNE4BJZ87chpiEjZ/DQrk5CHVsMs5Lzo8bzyRfypPcHdaEMEWdeN7X
         O48w==
X-Received: by 10.66.190.234 with SMTP id gt10mr21324798pac.136.1370181960799;
        Sun, 02 Jun 2013 07:06:00 -0700 (PDT)
Received: from localhost.localdomain ([122.164.162.188])
        by mx.google.com with ESMTPSA id aj2sm55150689pbc.1.2013.06.02.07.05.58
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 02 Jun 2013 07:06:00 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.457.g2410d5e
In-Reply-To: <1370181822-23450-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226152>

Currently, when performing any operation that saves the state and
expects the user the continue (like rebase, bisect, am), the prompt
screams:

  artagnon|completion|REBASE-i 2/2:~/src/git$

Lowercase the words, so we get a more pleasant

  artagnon|completion|rebase-i 2/2:~/src/git$

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 contrib/completion/git-prompt.sh | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index eaf5c36..f99d1f2 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -270,29 +270,29 @@ __git_ps1 ()
 			step=$(cat "$g/rebase-merge/msgnum")
 			total=$(cat "$g/rebase-merge/end")
 			if [ -f "$g/rebase-merge/interactive" ]; then
-				r="|REBASE-i"
+				r="|rebase-i"
 			else
-				r="|REBASE-m"
+				r="|rebase-m"
 			fi
 		else
 			if [ -d "$g/rebase-apply" ]; then
 				step=$(cat "$g/rebase-apply/next")
 				total=$(cat "$g/rebase-apply/last")
 				if [ -f "$g/rebase-apply/rebasing" ]; then
-					r="|REBASE"
+					r="|rebase"
 				elif [ -f "$g/rebase-apply/applying" ]; then
-					r="|AM"
+					r="|am"
 				else
-					r="|AM/REBASE"
+					r="|am/rebase"
 				fi
 			elif [ -f "$g/MERGE_HEAD" ]; then
-				r="|MERGING"
+				r="|merge"
 			elif [ -f "$g/CHERRY_PICK_HEAD" ]; then
-				r="|CHERRY-PICKING"
+				r="|cherry-pick"
 			elif [ -f "$g/REVERT_HEAD" ]; then
-				r="|REVERTING"
+				r="|revert"
 			elif [ -f "$g/BISECT_LOG" ]; then
-				r="|BISECTING"
+				r="|bisect"
 			fi
 
 			b="$(git symbolic-ref HEAD 2>/dev/null)" || {
-- 
1.8.3.457.g2410d5e
