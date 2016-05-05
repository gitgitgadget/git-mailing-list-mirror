From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH v16 6/7] t7507-commit-verbose: improve test coverage by testing number of diffs
Date: Thu,  5 May 2016 15:20:01 +0530
Message-ID: <1462441802-4768-7-git-send-email-pranit.bauva@gmail.com>
References: <1462046616-2582-1-git-send-email-pranit.bauva@gmail.com>
 <1462441802-4768-1-git-send-email-pranit.bauva@gmail.com>
Cc: sunshine@sunshineco.com, szeder@ira.uka.de, git@vger.kernel.org,
	Pranit Bauva <pranit.bauva@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu May 05 11:51:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayFwX-0007uH-OU
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 11:51:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757144AbcEEJva (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 05:51:30 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:36042 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756734AbcEEJv3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 05:51:29 -0400
Received: by mail-pf0-f180.google.com with SMTP id c189so37266617pfb.3
        for <git@vger.kernel.org>; Thu, 05 May 2016 02:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Wx26GMukzCyQovb9iDMhesywAXU72YBVvVw4oi6ZULM=;
        b=D+okDYStJBNavjRJfsnhJDhmjpfC6xXI4A+WymxXiijeVlf/h7fmr3g32/gkK+3uFy
         hGbQ4vTmU3xXzLWDn8u/QHsjX6YelY4CTY1Mlr2ugMGm29dWfcCnU/VPb1vR03DloUiA
         bpLqDO3/OgdTwbkGGRejiSQtoKTnDRKQhilYfmbHSH6F0vXa8/Xsgj7BpS8bccL8ZF9j
         3eIytR24Es8CHelOdiAQDouMv03hVB4ufNKrT6BPP97PG5Bj5qSap4++HKWmk5HSKq97
         ZKJFNGyPM7MPNlbN1N3PcbxHUU6DZU2ZEr2H4g2imgnjdOG2RbS4flQbDVGvJX7Mvb4d
         p7vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Wx26GMukzCyQovb9iDMhesywAXU72YBVvVw4oi6ZULM=;
        b=dHNLWddrp0fL5118JsIU4qHt1Vs1hX1sL+IX1yUH3/RDVpB9e9nmFT4IGcIaLvRtd/
         gzqEW5DEXt4H4DQyew/vCC4H4qRqEk4JkECtiovKSWJTqBv+ad9fA9ZPBPswTK4jxO8m
         3NI05bjzQQhsNSNC7KnG/qzctf7P793/C2iL9MA3IQosRz6rc/+cglQY1P6iDj5cFTAd
         HzrPF8jBMGje3eQOCmCZheQ3muZW9a5p30f8DPSJFMBXbSQqVdXTPkOWX+OvJuc1OIIs
         v8R+pIo9j5hjWOJVPgfhJ6xULbyOYU9Mcvnec52pGEi8tOIpLrbIcwIWVxMYa2C6+crU
         JT+A==
X-Gm-Message-State: AOPr4FX068mb3BJr/PJ/njSdqY3q7VyCMGKhelwDzrFrTuFSAlz7k6AdyT0qvkjZR6cp3Q==
X-Received: by 10.98.66.80 with SMTP id p77mr19182657pfa.75.1462441888465;
        Thu, 05 May 2016 02:51:28 -0700 (PDT)
Received: from localhost.localdomain ([111.119.199.22])
        by smtp.gmail.com with ESMTPSA id zn12sm12255111pab.14.2016.05.05.02.51.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 May 2016 02:51:27 -0700 (PDT)
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1462441802-4768-1-git-send-email-pranit.bauva@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293642>

Make the fake "editor" store output of grep in a file so that we can
see how many diffs were contained in the message and use them in
individual tests where ever it is required. A subsequent commit will
introduce scenarios where it is important to be able to exactly
determine how many diffs were present.

The fake "editor" is always made to succeed regardless of whether grep
found diff headers or not so that we don't have to use 'test_must_fail'
for which 'test_line_count = 0' is an easy substitute and also helps in
maintaining the consistency.

Also use write_script() to create the fake "editor".

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>

---
 t/t7507-commit-verbose.sh | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
index a3c8582..5a81181 100755
--- a/t/t7507-commit-verbose.sh
+++ b/t/t7507-commit-verbose.sh
@@ -3,11 +3,10 @@
 test_description='verbose commit template'
 . ./test-lib.sh
 
-cat >check-for-diff <<EOF
-#!$SHELL_PATH
-exec grep '^diff --git' "\$1"
+write_script "check-for-diff" <<\EOF &&
+grep '^diff --git' "$1" >out
+exit 0
 EOF
-chmod +x check-for-diff
 test_set_editor "$PWD/check-for-diff"
 
 cat >message <<'EOF'
@@ -23,7 +22,8 @@ test_expect_success 'setup' '
 '
 
 test_expect_success 'initial commit shows verbose diff' '
-	git commit --amend -v
+	git commit --amend -v &&
+	test_line_count = 1 out
 '
 
 test_expect_success 'second commit' '
@@ -39,13 +39,15 @@ check_message() {
 
 test_expect_success 'verbose diff is stripped out' '
 	git commit --amend -v &&
-	check_message message
+	check_message message &&
+	test_line_count = 1 out
 '
 
 test_expect_success 'verbose diff is stripped out (mnemonicprefix)' '
 	git config diff.mnemonicprefix true &&
 	git commit --amend -v &&
-	check_message message
+	check_message message &&
+	test_line_count = 1 out
 '
 
 cat >diff <<'EOF'
-- 
2.8.1
