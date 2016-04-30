From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH v15 5/7] t7507-commit-verbose: improve test coverage by testing number of diffs
Date: Sun,  1 May 2016 01:33:34 +0530
Message-ID: <1462046616-2582-5-git-send-email-pranit.bauva@gmail.com>
References: <1462046616-2582-1-git-send-email-pranit.bauva@gmail.com>
Cc: sunshine@sunshineco.com, gitster@pobox.com,
	Pranit Bauva <pranit.bauva@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 30 22:04:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awb7z-00019D-Gj
	for gcvg-git-2@plane.gmane.org; Sat, 30 Apr 2016 22:04:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752330AbcD3UEb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Apr 2016 16:04:31 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35799 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752199AbcD3UEa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Apr 2016 16:04:30 -0400
Received: by mail-pf0-f194.google.com with SMTP id r187so18013340pfr.2
        for <git@vger.kernel.org>; Sat, 30 Apr 2016 13:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yyD4UlXtHuqc7oiNyBQdxymu510JEKtobc7ubkcE5go=;
        b=UZ2a1GaggOpUNEGxLm1nqwxVG8JM0W5itT+MB1WcuhED9gGPN14cJw1whnmb2wiA+c
         yGEmUoANkP819ANJwHViTIKA2sLGZp5Eoq5AKJhEzRVmcj/TcjNOivmbhbqarmf54S0n
         Sy51zZGvT6rhXlZLu2liEYbg3ZlXqwv3g1GcmBUF3unTjmpYrvu9hH9NHFyLRpe83gCq
         r0TZmN/R0xjBPfeFnwA9jC2X9MrwQsYJaqifa8nE/DHKF33tZ9v8MOk+EarPa7lVN1o3
         wIW6IZ5FRUKOENEP/KBV/W2PvQIE6rxiookM0rb4QCb7msxz1EOKa9vvUiWVFbcwXnMU
         mGpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yyD4UlXtHuqc7oiNyBQdxymu510JEKtobc7ubkcE5go=;
        b=cVXKgmBJx30lm/c8YN+LPWx2tqnG3GZU8jHey2KZgH2is2jAHSrCcfvlolmDa+nSoh
         6hSyJbEN4O6Wr4Fa/HbYBfs6+9tlUhYASTZWTHb4Lpr0oN8YmCVKTJCMrRe8FIibVs42
         09xCYjJU2OAppNCQHfBvFpASKHH4j9gMZpLZk+OgCRSX7D7j6JD7hdOLEVePZpXvaTN8
         bmH8xucvawmemmeSUhVqSTxImQwSq4tGxJnupxLTSsW4+HUkSk09h6wEtuzLdoF09ESj
         w+1YUqxhC9c9yShTE5vHa3pDlExixR9BQttmpwHqitNAGnkvL9M811BIAruvINBqZfF3
         SN6w==
X-Gm-Message-State: AOPr4FUexBp3H7ujE0KIrdioD3hwUa59286mK5VjS+bgvukhSv5deX2aIgtThD/ymS8LlA==
X-Received: by 10.98.12.213 with SMTP id 82mr38812544pfm.90.1462046669916;
        Sat, 30 Apr 2016 13:04:29 -0700 (PDT)
Received: from localhost.localdomain ([27.106.101.191])
        by smtp.gmail.com with ESMTPSA id h85sm33329025pfj.52.2016.04.30.13.04.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 30 Apr 2016 13:04:29 -0700 (PDT)
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1462046616-2582-1-git-send-email-pranit.bauva@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293131>

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
Previous version of this patch:
 - [v12] : $gmane/288820
 - [v11] : $gmane/288820
 - [v10]: $gmane/288820

Changes this version wrt previous one:
Change the commit message as suggested by Eric

Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 t/t7507-commit-verbose.sh | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
index 2ddf28c..0f28a86 100755
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
