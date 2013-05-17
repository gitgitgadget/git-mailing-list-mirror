From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/3] prompt: introduce GIT_PS1_STATESEPARATOR
Date: Fri, 17 May 2013 14:25:46 +0530
Message-ID: <1368780948-28917-2-git-send-email-artagnon@gmail.com>
References: <1368780948-28917-1-git-send-email-artagnon@gmail.com>
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 17 10:54:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdGQh-0000XC-RX
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 10:54:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755459Ab3EQIyO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 04:54:14 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:59100 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753545Ab3EQIyM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 04:54:12 -0400
Received: by mail-pa0-f50.google.com with SMTP id fb10so3341001pad.9
        for <git@vger.kernel.org>; Fri, 17 May 2013 01:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=Drqjv2Keqi/qo/QpuPYF9d6wRSBpnPaKUb7M9UNQkaM=;
        b=iHoMuY25o2Yt3lxSJ4qp4f+mTZb3wiWS3K+3Ws5etxO8L5uB8IyS0kc1g4vOw7+see
         XggoGViI6kBJgmqDF8pMcoabRspPVosZ0tWaILQPvjJgaAbhDvlOD6VSQ3AoorHoXJNF
         6p/pfsM3sUjo113DXLnW5UnS7ZDmIhmffz/kLlCRqJZqk5gEp7LTmUeTGHcwJWoNRk6j
         O/MzPCLT7hgi1o39l9VTShO61r79f9si6dv9m9I8KzizPZ28tZDvNxim3t4RhY7RPXj3
         F+vE/fAqcqCJPQmyyy0Zs0DehSP1q16JX9apoAwell57DL13Sudnl4+Sk6jXUjOYZM1l
         H4Gw==
X-Received: by 10.68.232.42 with SMTP id tl10mr47092207pbc.72.1368780851562;
        Fri, 17 May 2013 01:54:11 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id do4sm10438933pbc.8.2013.05.17.01.54.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 17 May 2013 01:54:10 -0700 (PDT)
X-Mailer: git-send-email 1.8.1.2.432.g070c57d
In-Reply-To: <1368780948-28917-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224660>

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
 contrib/completion/git-prompt.sh | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index eaf5c36..fb9296b 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -359,6 +359,7 @@ __git_ps1 ()
 			fi
 		fi
 
+		local z="${GIT_PS1_STATESEPARATOR-" "}"
 		local f="$w$i$s$u"
 		if [ $pcmode = yes ]; then
 			local gitstring=
@@ -384,7 +385,7 @@ __git_ps1 ()
 				gitstring="\[$branch_color\]$branchstring\[$c_clear\]"
 
 				if [ -n "$w$i$s$u$r$p" ]; then
-					gitstring="$gitstring "
+					gitstring="$gitstring$z"
 				fi
 				if [ "$w" = "*" ]; then
 					gitstring="$gitstring\[$bad_color\]$w"
@@ -400,13 +401,13 @@ __git_ps1 ()
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
1.8.1.2.432.g070c57d
