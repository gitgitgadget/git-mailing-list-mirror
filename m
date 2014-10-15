From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 4/5] t7610-mergetool: prefer test_config over git config
Date: Wed, 15 Oct 2014 01:35:20 -0700
Message-ID: <1413362121-17361-4-git-send-email-davvid@gmail.com>
References: <1413362121-17361-1-git-send-email-davvid@gmail.com>
 <1413362121-17361-2-git-send-email-davvid@gmail.com>
 <1413362121-17361-3-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Charles Bailey <charles@hashpling.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 15 10:35:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeK38-0004sz-SH
	for gcvg-git-2@plane.gmane.org; Wed, 15 Oct 2014 10:35:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751544AbaJOIfG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2014 04:35:06 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34174 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751289AbaJOIfE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2014 04:35:04 -0400
Received: by mail-pa0-f42.google.com with SMTP id bj1so908376pad.29
        for <git@vger.kernel.org>; Wed, 15 Oct 2014 01:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3X+MEOox/2RbE3Om0/DFg4F3qzDPPMuNRfuZU1ZVE/U=;
        b=YeVuI9ez8YRegGYxlZI231bJwZIela33DmJc5sWJWgtaDZmf6UL/qh5vj59PLtn62L
         RyCopC7Orcr6CufYt8Bz6Criid59O8HrMgYxMpkNQjaVgS5j9ce6F93mE1tqRl38b/yT
         1/HFaX9F2YRAA+5ruT4lX8bEoaU8jHB+5UMJm++woJnz+PWGgLGCnNzGm5yaNwLgZSL4
         vfRKEurfJPD6Cd/Zr3HCbxq1nEmh/sNmAIv9dNgW+CCL9cxdXpa/IeulqrvRZ+PoCbZD
         lni2DkKSzsVzz/9DCgXj9I8C2+2oDbvIlYs2miE8ySqqhNOHH0osUc3n01XzzRdG5x1S
         PVLg==
X-Received: by 10.70.35.111 with SMTP id g15mr682941pdj.155.1413362104192;
        Wed, 15 Oct 2014 01:35:04 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id o4sm16371416pdh.56.2014.10.15.01.35.02
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 15 Oct 2014 01:35:03 -0700 (PDT)
X-Mailer: git-send-email 2.1.2.453.g1b015e3
In-Reply-To: <1413362121-17361-3-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 t/t7610-mergetool.sh | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index 1a15e06..7eeb207 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -14,7 +14,7 @@ Testing basic merge tool invocation'
 # running mergetool
 
 test_expect_success 'setup' '
-	git config rerere.enabled true &&
+	test_config rerere.enabled true &&
 	echo master >file1 &&
 	echo master spaced >"spaced name" &&
 	echo master file11 >file11 &&
@@ -112,7 +112,7 @@ test_expect_success 'custom mergetool' '
 '
 
 test_expect_success 'mergetool crlf' '
-	git config core.autocrlf true &&
+	test_config core.autocrlf true &&
 	git checkout -b test2 branch1 &&
 	test_must_fail git merge master >/dev/null 2>&1 &&
 	( yes "" | git mergetool file1 >/dev/null 2>&1 ) &&
@@ -129,7 +129,7 @@ test_expect_success 'mergetool crlf' '
 	git submodule update -N &&
 	test "$(cat submod/bar)" = "master submodule" &&
 	git commit -m "branch1 resolved with mergetool - autocrlf" &&
-	git config core.autocrlf false &&
+	test_config core.autocrlf false &&
 	git reset --hard
 '
 
@@ -176,7 +176,7 @@ test_expect_success 'mergetool skips autoresolved' '
 test_expect_success 'mergetool merges all from subdir' '
 	(
 		cd subdir &&
-		git config rerere.enabled false &&
+		test_config rerere.enabled false &&
 		test_must_fail git merge master &&
 		( yes "r" | git mergetool ../submod ) &&
 		( yes "d" "d" | git mergetool --no-prompt ) &&
@@ -190,7 +190,7 @@ test_expect_success 'mergetool merges all from subdir' '
 '
 
 test_expect_success 'mergetool skips resolved paths when rerere is active' '
-	git config rerere.enabled true &&
+	test_config rerere.enabled true &&
 	rm -rf .git/rr-cache &&
 	git checkout -b test5 branch1 &&
 	git submodule update -N &&
@@ -204,7 +204,7 @@ test_expect_success 'mergetool skips resolved paths when rerere is active' '
 '
 
 test_expect_success 'conflicted stash sets up rerere'  '
-	git config rerere.enabled true &&
+	test_config rerere.enabled true &&
 	git checkout stash1 &&
 	echo "Conflicting stash content" >file11 &&
 	git stash &&
@@ -232,7 +232,7 @@ test_expect_success 'conflicted stash sets up rerere'  '
 
 test_expect_success 'mergetool takes partial path' '
 	git reset --hard &&
-	git config rerere.enabled false &&
+	test_config rerere.enabled false &&
 	git checkout -b test12 branch1 &&
 	git submodule update -N &&
 	test_must_fail git merge master &&
@@ -505,14 +505,12 @@ test_expect_success 'file with no base' '
 
 test_expect_success 'custom commands override built-ins' '
 	git checkout -b test14 branch1 &&
-	git config mergetool.defaults.cmd "cat \"\$REMOTE\" >\"\$MERGED\"" &&
-	git config mergetool.defaults.trustExitCode true &&
+	test_config mergetool.defaults.cmd "cat \"\$REMOTE\" >\"\$MERGED\"" &&
+	test_config mergetool.defaults.trustExitCode true &&
 	test_must_fail git merge master &&
 	git mergetool --no-prompt --tool defaults -- both &&
 	echo master both added >expected &&
 	test_cmp both expected &&
-	git config --unset mergetool.defaults.cmd &&
-	git config --unset mergetool.defaults.trustExitCode &&
 	git reset --hard master >/dev/null 2>&1
 '
 
-- 
2.1.2.453.g1b015e3
