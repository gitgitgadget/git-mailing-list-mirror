From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 3/6] completion: simplify tests using test_completion_long()
Date: Sun, 11 Nov 2012 15:35:55 +0100
Message-ID: <1352644558-9410-4-git-send-email-felipe.contreras@gmail.com>
References: <1352644558-9410-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 11 15:36:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXYeO-0005xu-1A
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 15:36:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752957Ab2KKOg1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 09:36:27 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:41620 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751752Ab2KKOg0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 09:36:26 -0500
Received: by mail-bk0-f46.google.com with SMTP id jk13so2066470bkc.19
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 06:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=qNqJpEHbrlG8G+ytBMBW2HCDgN9J8aWJAdKDSp0AMyI=;
        b=nyUhdfkHHO+U7SlpGtGY+lYv2ULG2bb5uAlxbLaH/SwUIM/3RWWF5vYLtJU0V9wP9v
         Hzst17Y22fJUMUTCHWDLoO//dBtXLnAU86iKOGsKryTYjMPvRf0fB65wSK3NZ9J9Oq4U
         owvO/xW84677yM8HrnurBS0m3tvwFaO8ElLRjfibaXdiTEaSidapBAHR8ebX9pvoe4cu
         s3/9T/nc18Aq+r2c+fjTR+7FDu/Ls9n7VyAAwMkFPWueNKRil1nlBfbFX787EKYFgNQ9
         pI+jPHv/eEKFnwrstwDk6Wjv9zN+xsz5bHggcXRrMmuEPE8LCXpXRXsHRuDBwf1SgIGe
         /T7A==
Received: by 10.204.13.25 with SMTP id z25mr6148600bkz.119.1352644585831;
        Sun, 11 Nov 2012 06:36:25 -0800 (PST)
Received: from localhost (ip-109-43-0-127.web.vodafone.de. [109.43.0.127])
        by mx.google.com with ESMTPS id k21sm1522507bkv.1.2012.11.11.06.36.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 11 Nov 2012 06:36:24 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1352644558-9410-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209385>

No need to duplicate that functionality.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t9902-completion.sh | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index aff7e44..204c92a 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -172,7 +172,7 @@ test_expect_success 'basic' '
 '
 
 test_expect_success 'double dash "git" itself' '
-	sed -e "s/Z$//" >expected <<-\EOF &&
+	test_completion_long "git --" <<-\EOF
 	--paginate Z
 	--no-pager Z
 	--git-dir=
@@ -187,11 +187,10 @@ test_expect_success 'double dash "git" itself' '
 	--no-replace-objects Z
 	--help Z
 	EOF
-	test_completion "git --"
 '
 
 test_expect_success 'double dash "git checkout"' '
-	sed -e "s/Z$//" >expected <<-\EOF &&
+	test_completion_long "git checkout --" <<-\EOF
 	--quiet Z
 	--ours Z
 	--theirs Z
@@ -202,17 +201,15 @@ test_expect_success 'double dash "git checkout"' '
 	--orphan Z
 	--patch Z
 	EOF
-	test_completion "git checkout --"
 '
 
 test_expect_success 'general options' '
 	test_completion "git --ver" "--version " &&
 	test_completion "git --hel" "--help " &&
-	sed -e "s/Z$//" >expected <<-\EOF &&
+	test_completion_long "git --exe" <<-\EOF &&
 	--exec-path Z
 	--exec-path=
 	EOF
-	test_completion "git --exe" &&
 	test_completion "git --htm" "--html-path " &&
 	test_completion "git --pag" "--paginate " &&
 	test_completion "git --no-p" "--no-pager " &&
-- 
1.8.0
