Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C9B6C433DB
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 07:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17A1564EB8
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 07:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbhBIHaZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 02:30:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbhBIH3z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 02:29:55 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1764C06178B
        for <git@vger.kernel.org>; Mon,  8 Feb 2021 23:29:15 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id nm1so1064924pjb.3
        for <git@vger.kernel.org>; Mon, 08 Feb 2021 23:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fa4WF191om12EiQOY/vS3OYpTRVsVVT2Ao7zH3DjI8U=;
        b=SUGbEO0LvwwPrtXkJZRLXHs1DF/8wIL35319m5QYgvOvqIh1wx0oD5aG2q0EXsfJeJ
         Z1+6/rEOnoRz8ZNI3AaPlph12vip9BRurqhheBwRlpEn3LIdh6x7OLFC7yhbHVsr7TfO
         GEHGc8IPB0DUSZkLOVcOGs0+NhXQMScos16tVwjIPuTBiNQc26/woTtAVpILqpL/OYUb
         Rx4AE8P7oS+6ryKzes8SZxC/v8f4fhHPrOH5qMZW7DCy7+7CwrFgnsTqB13HL1Qimcba
         F7NCW0zErVB7nfWoBaFJy+TGh6BKWg5IelIYJ2yvyVi81RyYFDBaubanPEWebJfOhRGU
         t2Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fa4WF191om12EiQOY/vS3OYpTRVsVVT2Ao7zH3DjI8U=;
        b=QoIWF8zFMjJ6YlIcrZjLVRUinu/ROq/gIlhN5ZEVtRrMV/u1d7sKo4I3ZcGO+F5PxH
         P7iNXU/DNLBaOFsK2ojcSjKdL/kiyOgNStdegMimilrDXQWdM74W7XoBTbYQdTDpkyJa
         LXy9hM6+eUjlWYh3jbuu0GaDeCQA+7IpnQksKrEkMjNG9YShjNfSKJNdF5u0NQ++ImWr
         ADmNh10CV1PwvS79a0reDU/+oDcdW1cvReocusmi5AROLcZam3xgpKZhR7tY1BAW0OPy
         9QmKIHdVjyTf6ISNf7WVDXwtVHk0JIS0N/YPsik/zv4c8Lxw1nPi6YmFjFlJb/vFjQxM
         J92A==
X-Gm-Message-State: AOAM530kRmgCdvv5Zdn+tZkYx19JyZWkqnVcv6LR1ETuxmIqzUTdy87T
        k4f+vxsYglnFqu3yq59JGsp2HWMaMtw=
X-Google-Smtp-Source: ABdhPJzc4syi3CZ0vWZ4tEq9XvmcMol3GMA6zkByPIiip/WzQL6kYdz+G0jOGjMenE/exLEu1ousAg==
X-Received: by 2002:a17:90a:4546:: with SMTP id r6mr2767610pjm.213.1612855755042;
        Mon, 08 Feb 2021 23:29:15 -0800 (PST)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id w4sm5670443pfn.45.2021.02.08.23.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 23:29:14 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 3/9] t3905: move all commands into test cases
Date:   Mon,  8 Feb 2021 23:28:49 -0800
Message-Id: <5bda09b4bd55168f6e69f20026d0112b1a43f45f.1612855690.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01
In-Reply-To: <cover.1612855690.git.liu.denton@gmail.com>
References: <cover.1612258145.git.liu.denton@gmail.com> <cover.1612855690.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order to modernize the tests, move commands that currently run
outside of test cases into a test case. Where possible, clean up files
that are produced using test_when_finished() but in the case where files
persist over multiple test cases, create a new test case to perform
cleanup.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t3905-stash-include-untracked.sh | 147 +++++++++++++++--------------
 1 file changed, 75 insertions(+), 72 deletions(-)

diff --git a/t/t3905-stash-include-untracked.sh b/t/t3905-stash-include-untracked.sh
index 1d416944b7..892a2c8057 100755
--- a/t/t3905-stash-include-untracked.sh
+++ b/t/t3905-stash-include-untracked.sh
@@ -25,48 +25,48 @@ test_expect_success 'stash save --include-untracked some dirty working directory
 	git diff-index --cached --quiet HEAD
 '
 
-cat >expect <<EOF
-?? actual
-?? expect
-EOF
-
 test_expect_success 'stash save --include-untracked cleaned the untracked files' '
+	cat >expect <<-EOF &&
+	?? actual
+	?? expect
+	EOF
+
 	git status --porcelain >actual &&
 	test_cmp expect actual
 '
 
-tracked=$(git rev-parse --short $(echo 1 | git hash-object --stdin))
-untracked=$(git rev-parse --short $(echo untracked | git hash-object --stdin))
-cat >expect.diff <<EOF
-diff --git a/HEAD b/HEAD
-new file mode 100644
-index 0000000..$tracked
---- /dev/null
-+++ b/HEAD
-@@ -0,0 +1 @@
-+1
-diff --git a/file2 b/file2
-new file mode 100644
-index 0000000..$tracked
---- /dev/null
-+++ b/file2
-@@ -0,0 +1 @@
-+1
-diff --git a/untracked/untracked b/untracked/untracked
-new file mode 100644
-index 0000000..$untracked
---- /dev/null
-+++ b/untracked/untracked
-@@ -0,0 +1 @@
-+untracked
-EOF
-cat >expect.lstree <<EOF
-HEAD
-file2
-untracked
-EOF
-
 test_expect_success 'stash save --include-untracked stashed the untracked files' '
+	tracked=$(git rev-parse --short $(echo 1 | git hash-object --stdin)) &&
+	untracked=$(git rev-parse --short $(echo untracked | git hash-object --stdin)) &&
+	cat >expect.diff <<-EOF &&
+	diff --git a/HEAD b/HEAD
+	new file mode 100644
+	index 0000000..$tracked
+	--- /dev/null
+	+++ b/HEAD
+	@@ -0,0 +1 @@
+	+1
+	diff --git a/file2 b/file2
+	new file mode 100644
+	index 0000000..$tracked
+	--- /dev/null
+	+++ b/file2
+	@@ -0,0 +1 @@
+	+1
+	diff --git a/untracked/untracked b/untracked/untracked
+	new file mode 100644
+	index 0000000..$untracked
+	--- /dev/null
+	+++ b/untracked/untracked
+	@@ -0,0 +1 @@
+	+untracked
+	EOF
+	cat >expect.lstree <<-EOF &&
+	HEAD
+	file2
+	untracked
+	EOF
+
 	test_path_is_missing file2 &&
 	test_path_is_missing untracked &&
 	test_path_is_missing HEAD &&
@@ -83,18 +83,21 @@ test_expect_success 'stash save --patch --all fails' '
 	test_must_fail git stash --patch --all
 '
 
-git clean --force --quiet
+test_expect_success 'clean up untracked/untracked file to prepare for next tests' '
+	git clean --force --quiet
 
-cat >expect <<EOF
- M file
-?? HEAD
-?? actual
-?? expect
-?? file2
-?? untracked/
-EOF
+'
 
 test_expect_success 'stash pop after save --include-untracked leaves files untracked again' '
+	cat >expect <<-EOF &&
+	 M file
+	?? HEAD
+	?? actual
+	?? expect
+	?? file2
+	?? untracked/
+	EOF
+
 	git stash pop &&
 	git status --porcelain >actual &&
 	test_cmp expect actual &&
@@ -102,7 +105,9 @@ test_expect_success 'stash pop after save --include-untracked leaves files untra
 	test untracked = "$(cat untracked/untracked)"
 '
 
-git clean --force --quiet -d
+test_expect_success 'clean up untracked/ directory to prepare for next tests' '
+	git clean --force --quiet -d
+'
 
 test_expect_success 'stash save -u dirty index' '
 	echo 4 >file3 &&
@@ -111,25 +116,24 @@ test_expect_success 'stash save -u dirty index' '
 	git stash -u
 '
 
-blob=$(git rev-parse --short $(echo 4 | git hash-object --stdin))
-cat >expect <<EOF
-diff --git a/file3 b/file3
-new file mode 100644
-index 0000000..$blob
---- /dev/null
-+++ b/file3
-@@ -0,0 +1 @@
-+4
-EOF
-
 test_expect_success 'stash save --include-untracked dirty index got stashed' '
+	blob=$(git rev-parse --short $(echo 4 | git hash-object --stdin)) &&
+	cat >expect <<-EOF &&
+	diff --git a/file3 b/file3
+	new file mode 100644
+	index 0000000..$blob
+	--- /dev/null
+	+++ b/file3
+	@@ -0,0 +1 @@
+	+4
+	EOF
+
 	git stash pop --index &&
+	test_when_finished "git reset" &&
 	git diff --cached >actual &&
 	test_cmp expect actual
 '
 
-git reset >/dev/null
-
 # Must direct output somewhere where it won't be considered an untracked file
 test_expect_success 'stash save --include-untracked -q is quiet' '
 	echo 1 >file5 &&
@@ -142,23 +146,22 @@ test_expect_success 'stash save --include-untracked removed files' '
 	rm -f file &&
 	git stash save --include-untracked &&
 	echo 1 >expect &&
+	test_when_finished "rm -f expect" &&
 	test_cmp expect file
 '
 
-rm -f expect
-
 test_expect_success 'stash save --include-untracked removed files got stashed' '
 	git stash pop &&
 	test_path_is_missing file
 '
 
-cat >.gitignore <<EOF
-.gitignore
-ignored
-ignored.d/
-EOF
-
 test_expect_success 'stash save --include-untracked respects .gitignore' '
+	cat >.gitignore <<-EOF &&
+	.gitignore
+	ignored
+	ignored.d/
+	EOF
+
 	echo ignored >ignored &&
 	mkdir ignored.d &&
 	echo ignored >ignored.d/untracked &&
@@ -214,12 +217,12 @@ test_expect_success 'stash push with $IFS character' '
 	test_path_is_file bar
 '
 
-cat >.gitignore <<EOF
-ignored
-ignored.d/*
-EOF
-
 test_expect_success 'stash previously ignored file' '
+	cat >.gitignore <<-EOF &&
+	ignored
+	ignored.d/*
+	EOF
+
 	git reset HEAD &&
 	git add .gitignore &&
 	git commit -m "Add .gitignore" &&
-- 
2.30.0.478.g8a0d178c01

