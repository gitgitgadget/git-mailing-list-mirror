From: "Eduardo R. D'Avila" <erdavila@gmail.com>
Subject: [PATCH 3/4] git-prompt.sh: do not print duplicate clean color code
Date: Thu, 20 Jun 2013 23:25:28 -0300
Message-ID: <a44fecc0b75c3eacc24675aa4ec4e3a3c95c84ad.1371780085.git.erdavila@gmail.com>
References: <cover.1371780085.git.erdavila@gmail.com>
Cc: felipe.contreras@gmail.com, artagnon@gmail.com,
	s.oosthoek@xs4all.nl, gitster@pobox.com, szeder@ira.uka.de,
	"Eduardo R. D'Avila" <erdavila@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 21 04:26:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Upr3p-0006lF-97
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 04:26:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758140Ab3FUC0m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 22:26:42 -0400
Received: from mail-yh0-f42.google.com ([209.85.213.42]:48498 "EHLO
	mail-yh0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757878Ab3FUC0l (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 22:26:41 -0400
Received: by mail-yh0-f42.google.com with SMTP id c41so2902169yho.29
        for <git@vger.kernel.org>; Thu, 20 Jun 2013 19:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=G8494ezfipw1WgjY69PeK2spkKTYtPCeX7BoCZR0IWs=;
        b=dfTncoHIAIfKuPXqK72Pz4VMdeZ2tFb8O4753isn7h+h/CdNXNMKb6BCwCxA5tXTB9
         iHBEpCHp1KSsNmw2h7YY1ASongsv8UZVuULIzfovt85qiwvELTIHqZhHzx+a8TTKnLgE
         5Utp1U8CF2tilW+MspKDZaG0651701sNAH0n1vjjNdvel/Sv1DyF0/GbhfLWd2IrvtDT
         Cc+wZVFzrNr+dI+DWfyUPy635mnjgPqv0MmLtcrf0dbxiKkRLI7u28LdFKGE4U02KDA2
         MVLafZO8VxI0j/YYZ403paaXGS3dZUhzvVHg0FuTSF1thfZDMUL2zDDxf7Rwy0u+Boe/
         tsOQ==
X-Received: by 10.236.168.129 with SMTP id k1mr6389893yhl.142.1371781600759;
        Thu, 20 Jun 2013 19:26:40 -0700 (PDT)
Received: from localhost.localdomain (201.86.243.62.dynamic.adsl.gvt.net.br. [201.86.243.62])
        by mx.google.com with ESMTPSA id s65sm4968400yhs.14.2013.06.20.19.26.38
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 20 Jun 2013 19:26:40 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.487.g28387b2
In-Reply-To: <cover.1371780085.git.erdavila@gmail.com>
In-Reply-To: <cover.1371780085.git.erdavila@gmail.com>
References: <cover.1371780085.git.erdavila@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228565>

Do not print a duplicate clean color code when there
is no other indicators other than the current branch
in colored prompt.

Signed-off-by: Eduardo R. D'Avila <erdavila@gmail.com>
---
1	1	contrib/completion/git-prompt.sh
6	6	t/t9903-bash-prompt.sh
 contrib/completion/git-prompt.sh |  2 +-
 t/t9903-bash-prompt.sh           | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index b02b7b2..70515cc 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -253,8 +253,8 @@ __git_ps1_colorize_gitstring ()
 		branch_color="$bad_color"
 	fi
 	c="$branch_color$c"
-	b="$b$c_clear"
 
+	z="$c_clear$z"
 	if [ "$w" = "*" ]; then
 		w="$bad_color$w"
 	fi
diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index 6a88778..1101adf 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -551,7 +551,7 @@ test_expect_success 'prompt - pc mode' '
 '
 
 test_expect_success 'prompt - bash color pc mode - branch name' '
-	printf "BEFORE: (${c_green}master${c_clear}${c_clear}):AFTER" >expected &&
+	printf "BEFORE: (${c_green}master${c_clear}):AFTER" >expected &&
 	(
 		GIT_PS1_SHOWCOLORHINTS=y &&
 		__git_ps1 "BEFORE:" ":AFTER" >"$actual"
@@ -561,7 +561,7 @@ test_expect_success 'prompt - bash color pc mode - branch name' '
 '
 
 test_expect_success 'prompt - bash color pc mode - detached head' '
-	printf "BEFORE: (${c_red}(%s...)${c_clear}${c_clear}):AFTER" $(git log -1 --format="%h" b1^) >expected &&
+	printf "BEFORE: (${c_red}(%s...)${c_clear}):AFTER" $(git log -1 --format="%h" b1^) >expected &&
 	git checkout b1^ &&
 	test_when_finished "git checkout master" &&
 	(
@@ -627,7 +627,7 @@ test_expect_success 'prompt - bash color pc mode - dirty status indicator - befo
 '
 
 test_expect_success 'prompt - bash color pc mode - inside .git directory' '
-	printf "BEFORE: (${c_green}GIT_DIR!${c_clear}${c_clear}):AFTER" >expected &&
+	printf "BEFORE: (${c_green}GIT_DIR!${c_clear}):AFTER" >expected &&
 	echo "dirty" >file &&
 	test_when_finished "git reset --hard" &&
 	(
@@ -666,7 +666,7 @@ test_expect_success 'prompt - bash color pc mode - untracked files status indica
 '
 
 test_expect_success 'prompt - zsh color pc mode - branch name' '
-	printf "BEFORE: (%%F{green}master%%f%%f):AFTER" >expected &&
+	printf "BEFORE: (%%F{green}master%%f):AFTER" >expected &&
 	(
 		ZSH_VERSION=5.0.0 &&
 		GIT_PS1_SHOWCOLORHINTS=y &&
@@ -677,7 +677,7 @@ test_expect_success 'prompt - zsh color pc mode - branch name' '
 '
 
 test_expect_success 'prompt - zsh color pc mode - detached head' '
-	printf "BEFORE: (%%F{red}(%s...)%%f%%f):AFTER" $(git log -1 --format="%h" b1^) >expected &&
+	printf "BEFORE: (%%F{red}(%s...)%%f):AFTER" $(git log -1 --format="%h" b1^) >expected &&
 	git checkout b1^ &&
 	test_when_finished "git checkout master" &&
 	(
@@ -748,7 +748,7 @@ test_expect_success 'prompt - zsh color pc mode - dirty status indicator - befor
 '
 
 test_expect_success 'prompt - zsh color pc mode - inside .git directory' '
-	printf "BEFORE: (%%F{green}GIT_DIR!%%f%%f):AFTER" >expected &&
+	printf "BEFORE: (%%F{green}GIT_DIR!%%f):AFTER" >expected &&
 	echo "dirty" >file &&
 	test_when_finished "git reset --hard" &&
 	(
-- 
1.8.3.1.487.g28387b2
