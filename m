Return-Path: <SRS0=G+lC=4P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28AB1C4BA34
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 00:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0029724650
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 00:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EpnIRgHP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbgB0AOe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 19:14:34 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37370 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728062AbgB0AOb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 19:14:31 -0500
Received: by mail-wr1-f65.google.com with SMTP id l5so1113819wrx.4
        for <git@vger.kernel.org>; Wed, 26 Feb 2020 16:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8mQW4nlUR7Lf/YAxoUONue/r8BwiAuFSiH8DfLUwBLU=;
        b=EpnIRgHPKcdoO7HDo1V47CUf/C5cUTCyz2mNtAPleLk00Wjp4h7S847gwM9mp5cjZQ
         0ltdXlxjOjaaDtFkffS/DmK60AQ6a+NC/f4MpR5nFT6IBY4XbHMqpMVfSqlAFFr1PSJV
         MJJuCCF+ggd/8kG/7eF/7p4dan78oaNN1gRepNCGz3DUMHVNOzWsiA3JXgJ8DJZYEt+a
         Woi1VeeIRILTNgy0hNvi87tjqnRwfbVG0pu3q3E3fEDKh5Z3+2UmtoxKD0L94bvqKTgF
         kxF5RRY45CVg2RdVKfk6/oonXfg95ctUOa/yPNwS8kYCKnVT3hNdQzd7Bm0pqFI1dGvp
         W1kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8mQW4nlUR7Lf/YAxoUONue/r8BwiAuFSiH8DfLUwBLU=;
        b=A/FKrS41iaSFPxU+4JJHNcXRdIVM610lNfB6+4A8IOhSbn0sGz0qfBt6gnPOCDOJ4u
         LuqEibxiZzUrGBhIFJJo8KvU0RuKy/5Yt35bImfeBKNo58o5zaS7zF+rgApYVeNOPpvn
         R5p/nv8sQJAqqUZ9YIo+WJfcXxQuPLpnq8duZ9JM5kl6nYa191Dff/+FDf8otm8s2/1a
         WBpwEh3eDShWjS1sxDFuA/++0IPhxwkP1qFwYOr7VvfxzjTaBvNvGpT5yEN6ig3yoytA
         dnpmJSv7ngWDnhhIt/uV6HleNoUZ2gXNXb2sHwamtAjhB1F/Qs0JhL3024oD/4KvjF0I
         JWuA==
X-Gm-Message-State: APjAAAVVEVcOtRjLSw9W4MGtgHcfh820zYfPGkCUpHhHvUBK5N8kUN/J
        EN/MNgEe/RnDcEpJb22hA2ll2Ye1
X-Google-Smtp-Source: APXvYqxfbKm0Lxx8zzMU+9Qk8AvN08e5cT2BbNW/7Fzt852PL9xcV1BQKN0W45MOfll/kKYOj/XzPA==
X-Received: by 2002:a5d:610a:: with SMTP id v10mr1147663wrt.267.1582762468931;
        Wed, 26 Feb 2020 16:14:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v16sm5063248wml.11.2020.02.26.16.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 16:14:28 -0800 (PST)
Message-Id: <26d0c34cd1d4a54dab28d0c9c2242336244e8a3c.1582762465.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.716.git.git.1582762465.gitgitgadget@gmail.com>
References: <pull.716.git.git.1582762465.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 27 Feb 2020 00:14:23 +0000
Subject: [PATCH 4/5] t6022, t6046: test expected behavior instead of testing a
 proxy for it
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

In t6022, we were testing for file being overwritten (or not) based on
an output message instead of checking for the file being overwritten.
Since we can check for the file being overwritten via mtime updates,
check that instead.

In t6046, we were largely checking for both the expected behavior and a
proxy for it, which is unnecessary.  The calls to test-tool also were a
bit cryptic.  Make them a little clearer.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6022-merge-rename.sh                | 15 ++++-
 t/t6046-merge-skip-unneeded-updates.sh | 89 +++++++++++++++++---------
 2 files changed, 70 insertions(+), 34 deletions(-)

diff --git a/t/t6022-merge-rename.sh b/t/t6022-merge-rename.sh
index 6f196aaf276..d97cf48495b 100755
--- a/t/t6022-merge-rename.sh
+++ b/t/t6022-merge-rename.sh
@@ -242,12 +242,23 @@ test_expect_success 'merge of identical changes in a renamed file' '
 	rm -f A M N &&
 	git reset --hard &&
 	git checkout change+rename &&
+
+	test-tool chmtime =31337 B &&
+	test-tool chmtime --get B >old-mtime &&
 	GIT_MERGE_VERBOSITY=3 git merge change >out &&
-	test_i18ngrep "^Skipped B" out &&
+
+	test-tool chmtime --get B >new-mtime &&
+	test_cmp old-mtime new-mtime &&
+
 	git reset --hard HEAD^ &&
 	git checkout change &&
+
+	test-tool chmtime =-1 M &&
+	test-tool chmtime --get M >old-mtime &&
 	GIT_MERGE_VERBOSITY=3 git merge change+rename >out &&
-	test_i18ngrep ! "^Skipped B" out
+
+	test-tool chmtime --get B >new-mtime &&
+	test $(cat old-mtime) -lt $(cat new-mtime)
 '
 
 test_expect_success 'setup for rename + d/f conflicts' '
diff --git a/t/t6046-merge-skip-unneeded-updates.sh b/t/t6046-merge-skip-unneeded-updates.sh
index b7e46698321..962030ecdb6 100755
--- a/t/t6046-merge-skip-unneeded-updates.sh
+++ b/t/t6046-merge-skip-unneeded-updates.sh
@@ -71,16 +71,16 @@ test_expect_success '1a-L: Modify(A)/Modify(B), change on B subset of A' '
 
 		git checkout A^0 &&
 
-		test-tool chmtime =31337 b &&
-		test-tool chmtime -v +0 b >expected-mtime &&
+		test-tool chmtime =-1 b &&
+		test-tool chmtime --get b >old-mtime &&
 
 		GIT_MERGE_VERBOSITY=3 git merge -s recursive B^0 >out 2>err &&
 
-		test_i18ngrep "Skipped b" out &&
 		test_must_be_empty err &&
 
-		test-tool chmtime -v +0 b >actual-mtime &&
-		test_cmp expected-mtime actual-mtime &&
+		# Make sure b was NOT updated
+		test-tool chmtime --get b >new-mtime &&
+		test_cmp old-mtime new-mtime &&
 
 		git ls-files -s >index_files &&
 		test_line_count = 1 index_files &&
@@ -102,9 +102,14 @@ test_expect_success '1a-R: Modify(A)/Modify(B), change on B subset of A' '
 
 		git checkout B^0 &&
 
+		test-tool chmtime =-1 b &&
+		test-tool chmtime --get b >old-mtime &&
 		GIT_MERGE_VERBOSITY=3 git merge -s recursive A^0 >out 2>err &&
 
-		test_i18ngrep "Auto-merging b" out &&
+		# Make sure b WAS updated
+		test-tool chmtime --get b >new-mtime &&
+		test $(cat old-mtime) -lt $(cat new-mtime) &&
+
 		test_must_be_empty err &&
 
 		git ls-files -s >index_files &&
@@ -165,10 +170,10 @@ test_expect_success '2a-L: Modify/rename, merge into modify side' '
 
 		git checkout A^0 &&
 
+		test_path_is_missing c &&
 		GIT_MERGE_VERBOSITY=3 git merge -s recursive B^0 >out 2>err &&
 
-		test_i18ngrep ! "Skipped c" out &&
-		test_must_be_empty err &&
+		test_path_is_file c &&
 
 		git ls-files -s >index_files &&
 		test_line_count = 1 index_files &&
@@ -193,9 +198,14 @@ test_expect_success '2a-R: Modify/rename, merge into rename side' '
 
 		git checkout B^0 &&
 
+		test-tool chmtime =-1 c &&
+		test-tool chmtime --get c >old-mtime &&
 		GIT_MERGE_VERBOSITY=3 git merge -s recursive A^0 >out 2>err &&
 
-		test_i18ngrep ! "Skipped c" out &&
+		# Make sure c WAS updated
+		test-tool chmtime --get c >new-mtime &&
+		test $(cat old-mtime) -lt $(cat new-mtime) &&
+
 		test_must_be_empty err &&
 
 		git ls-files -s >index_files &&
@@ -256,16 +266,15 @@ test_expect_success '2b-L: Rename+Mod(A)/Mod(B), B mods subset of A' '
 
 		git checkout A^0 &&
 
-		test-tool chmtime =31337 c &&
-		test-tool chmtime -v +0 c >expected-mtime &&
-
+		test-tool chmtime =-1 c &&
+		test-tool chmtime --get c >old-mtime &&
 		GIT_MERGE_VERBOSITY=3 git merge -s recursive B^0 >out 2>err &&
 
-		test_i18ngrep "Skipped c" out &&
 		test_must_be_empty err &&
 
-		test-tool chmtime -v +0 c >actual-mtime &&
-		test_cmp expected-mtime actual-mtime &&
+		# Make sure c WAS updated
+		test-tool chmtime --get c >new-mtime &&
+		test_cmp old-mtime new-mtime &&
 
 		git ls-files -s >index_files &&
 		test_line_count = 1 index_files &&
@@ -290,9 +299,12 @@ test_expect_success '2b-R: Rename+Mod(A)/Mod(B), B mods subset of A' '
 
 		git checkout B^0 &&
 
+		test_path_is_missing c &&
 		GIT_MERGE_VERBOSITY=3 git merge -s recursive A^0 >out 2>err &&
 
-		test_i18ngrep "Auto-merging c" out &&
+		# Make sure c now present (and thus was updated)
+		test_path_is_file c &&
+
 		test_must_be_empty err &&
 
 		git ls-files -s >index_files &&
@@ -361,13 +373,18 @@ test_expect_success '2c: Modify b & add c VS rename b->c' '
 
 		git checkout A^0 &&
 
+		test-tool chmtime =-1 c &&
+		test-tool chmtime --get c >old-mtime &&
 		GIT_MERGE_VERBOSITY=3 &&
 		export GIT_MERGE_VERBOSITY &&
 		test_must_fail git merge -s recursive B^0 >out 2>err &&
 
 		test_i18ngrep "CONFLICT (rename/add): Rename b->c" out &&
-		test_i18ngrep ! "Skipped c" out &&
-		test_must_be_empty err
+		test_must_be_empty err &&
+
+		# Make sure c WAS updated
+		test-tool chmtime --get c >new-mtime &&
+		test $(cat old-mtime) -lt $(cat new-mtime)
 
 		# FIXME: rename/add conflicts are horribly broken right now;
 		# when I get back to my patch series fixing it and
@@ -460,11 +477,13 @@ test_expect_success '3a-L: bq_1->foo/bq_2 on A, foo/->bar/ on B' '
 
 		git checkout A^0 &&
 
+		test_path_is_missing bar/bq &&
 		GIT_MERGE_VERBOSITY=3 git -c merge.directoryRenames=true merge -s recursive B^0 >out 2>err &&
 
-		test_i18ngrep ! "Skipped bar/bq" out &&
 		test_must_be_empty err &&
 
+		test_path_is_file bar/bq &&
+
 		git ls-files -s >index_files &&
 		test_line_count = 2 index_files &&
 
@@ -488,11 +507,13 @@ test_expect_success '3a-R: bq_1->foo/bq_2 on A, foo/->bar/ on B' '
 
 		git checkout B^0 &&
 
+		test_path_is_missing bar/bq &&
 		GIT_MERGE_VERBOSITY=3 git -c merge.directoryRenames=true merge -s recursive A^0 >out 2>err &&
 
-		test_i18ngrep ! "Skipped bar/bq" out &&
 		test_must_be_empty err &&
 
+		test_path_is_file bar/bq &&
+
 		git ls-files -s >index_files &&
 		test_line_count = 2 index_files &&
 
@@ -552,11 +573,13 @@ test_expect_success '3b-L: bq_1->foo/bq_2 on A, foo/->bar/ on B' '
 
 		git checkout A^0 &&
 
+		test_path_is_missing bar/bq &&
 		GIT_MERGE_VERBOSITY=3 git -c merge.directoryRenames=true merge -s recursive B^0 >out 2>err &&
 
-		test_i18ngrep ! "Skipped bar/bq" out &&
 		test_must_be_empty err &&
 
+		test_path_is_file bar/bq &&
+
 		git ls-files -s >index_files &&
 		test_line_count = 2 index_files &&
 
@@ -580,11 +603,13 @@ test_expect_success '3b-R: bq_1->foo/bq_2 on A, foo/->bar/ on B' '
 
 		git checkout B^0 &&
 
+		test_path_is_missing bar/bq &&
 		GIT_MERGE_VERBOSITY=3 git -c merge.directoryRenames=true merge -s recursive A^0 >out 2>err &&
 
-		test_i18ngrep ! "Skipped bar/bq" out &&
 		test_must_be_empty err &&
 
+		test_path_is_file bar/bq &&
+
 		git ls-files -s >index_files &&
 		test_line_count = 2 index_files &&
 
@@ -654,16 +679,16 @@ test_expect_failure '4a: Change on A, change on B subset of A, dirty mods presen
 		git checkout A^0 &&
 		echo "File rewritten" >b &&
 
-		test-tool chmtime =31337 b &&
-		test-tool chmtime -v +0 b >expected-mtime &&
+		test-tool chmtime =-1 b &&
+		test-tool chmtime --get b >old-mtime &&
 
 		GIT_MERGE_VERBOSITY=3 git merge -s recursive B^0 >out 2>err &&
 
-		test_i18ngrep "Skipped b" out &&
 		test_must_be_empty err &&
 
-		test-tool chmtime -v +0 b >actual-mtime &&
-		test_cmp expected-mtime actual-mtime &&
+		# Make sure b was NOT updated
+		test-tool chmtime --get b >new-mtime &&
+		test_cmp old-mtime new-mtime &&
 
 		git ls-files -s >index_files &&
 		test_line_count = 1 index_files &&
@@ -722,16 +747,16 @@ test_expect_success '4b: Rename+Mod(A)/Mod(B), change on B subset of A, dirty mo
 		git checkout A^0 &&
 		echo "File rewritten" >c &&
 
-		test-tool chmtime =31337 c &&
-		test-tool chmtime -v +0 c >expected-mtime &&
+		test-tool chmtime =-1 c &&
+		test-tool chmtime --get c >old-mtime &&
 
 		GIT_MERGE_VERBOSITY=3 git merge -s recursive B^0 >out 2>err &&
 
-		test_i18ngrep "Skipped c" out &&
 		test_must_be_empty err &&
 
-		test-tool chmtime -v +0 c >actual-mtime &&
-		test_cmp expected-mtime actual-mtime &&
+		# Make sure c was NOT updated
+		test-tool chmtime --get c >new-mtime &&
+		test_cmp old-mtime new-mtime &&
 
 		git ls-files -s >index_files &&
 		test_line_count = 1 index_files &&
-- 
gitgitgadget

