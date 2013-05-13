From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/3] prompt: introduce GIT_PS1_STATESEPARATOR
Date: Mon, 13 May 2013 19:19:16 +0530
Message-ID: <1368452958-31090-2-git-send-email-artagnon@gmail.com>
References: <1368452958-31090-1-git-send-email-artagnon@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 13 15:47:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ubt6Z-0000G7-8M
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 15:47:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753302Ab3EMNro (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 09:47:44 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:41410 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753081Ab3EMNro (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 09:47:44 -0400
Received: by mail-pa0-f53.google.com with SMTP id kq12so4616142pab.40
        for <git@vger.kernel.org>; Mon, 13 May 2013 06:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=2b8M3M8cENCsg+ZzxREQAFbAK7Gqp8+yPxTu8tFPv8E=;
        b=HuXdeP1R6Q4efq7Q2KFoj4erhNISXB2QufUKBqJ3vU9blynZCvsV6Zc/Q3vhZ6iAxq
         qEhRR6W4yanYnwSmFItJ64GqwprsLx9g4lhTcWflR3dd9D1Yz0GU6UE0X/xX07BV8PXr
         TKBC4atxWrS02ozapnnyaSETqfPRML6gkindU5GnyVTrBrffRzDRNfRhISFKmzx/t7/g
         LKSnkLChughNwJovW//pUKBBiojQOKekRsoYxjwYXfgZHCTO62EeAkEubIeKPLke8sQZ
         HtLxJgep1ernt5wTbRk2o2ghJtDdL27rI0+Dhcy7g0RFLzA1Hlsi6JOUAZkh3v4LRN/5
         DOXg==
X-Received: by 10.66.8.138 with SMTP id r10mr29903011paa.55.1368452863294;
        Mon, 13 May 2013 06:47:43 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id sq9sm15114287pab.5.2013.05.13.06.47.40
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 13 May 2013 06:47:42 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.57.g4ac1522
In-Reply-To: <1368452958-31090-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224137>

A typical prompt looks like:

    artagnon|master *=:~/src/git$
                   ^
                   why do we have this space?

Nobody has branch names that end with +, *, =, < or > anyway, so it
doesn't serve the purpose of disambiguation.

Make this separator configurable via GIT_PS1_STATESEPARATOR.  This means
that you can set it to "" and get this prompt:

    artagnon|master*=:~/src/git$

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 contrib/completion/git-prompt.sh | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index eaf5c36..5d8b745 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -359,6 +359,11 @@ __git_ps1 ()
 			fi
 		fi
 
+		local z=" "
+		if [ -n "${GIT_PS1_STATESEPARATOR+set}" ]; then
+			z="${GIT_PS1_STATESEPARATOR}"
+		fi
+
 		local f="$w$i$s$u"
 		if [ $pcmode = yes ]; then
 			local gitstring=
@@ -384,7 +389,7 @@ __git_ps1 ()
 				gitstring="\[$branch_color\]$branchstring\[$c_clear\]"
 
 				if [ -n "$w$i$s$u$r$p" ]; then
-					gitstring="$gitstring "
+					gitstring="$gitstring$z"
 				fi
 				if [ "$w" = "*" ]; then
 					gitstring="$gitstring\[$bad_color\]$w"
@@ -400,13 +405,13 @@ __git_ps1 ()
 				fi
 				gitstring="$gitstring\[$c_clear\]$r$p"
 			else
-				gitstring="$c${b##refs/heads/}${f:+ $f}$r$p"
+				gitstring="$c${b##refs/heads/}${f:+$z$f}$r$p"
 			fi
 			gitstring=$(printf -- "$printf_format" "$gitstring")
 			PS1="$ps1pc_start$gitstring$ps1pc_end"
 		else
 			# NO color option unless in PROMPT_COMMAND mode
-			printf -- "$printf_format" "$c${b##refs/heads/}${f:+ $f}$r$p"
+			printf -- "$printf_format" "$c${b##refs/heads/}${f:+$z$f}$r$p"
 		fi
 	fi
 }
-- 
1.8.3.rc1.57.g4ac1522
