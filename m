Return-Path: <SRS0=DNff=2R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5FCFC2D0C6
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 13:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2C8520882
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 13:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u9zNLwao"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfL0Nrr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Dec 2019 08:47:47 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46227 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbfL0Nrp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Dec 2019 08:47:45 -0500
Received: by mail-qt1-f193.google.com with SMTP id g1so17686490qtr.13
        for <git@vger.kernel.org>; Fri, 27 Dec 2019 05:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Whc5IlrY5zqdJDuhdyeykwzTk5NIvs/QmaybdZm/sHw=;
        b=u9zNLwao9ScjC9UHeT4CNXo8KE3Lg8g4gCVXetZ3L/IhEOoHQUCiqwo3aJDJfd6t8R
         Kewz3AhTsgQ2DU4YFEkCJaWFKpeM0WpnFUJFeGpFXoUZj15enlqZqn2JQ7OdZlYG5aoG
         Wcuzq0bPscW3nNaKIsXbz7uQ65OH+GUYsibDBxQ99dB5UTh0b77Y/dxJIF8n7rv4FjMA
         pjIMK23iopB8GSGTB6gdBe+VCPm/GQg65xIQpSUqZg55uEBW2/t/M6VIPrvg2zpn3pyz
         CwQf8ZtMm+Lq+B+pX4MEZnuEJ/r8i6xlxUlkNh7X4Ib04AcP0ElEp+noEdesTy6sl9cx
         ONyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Whc5IlrY5zqdJDuhdyeykwzTk5NIvs/QmaybdZm/sHw=;
        b=UX9iZwoJRAw6Dhz+9hhuAN6r9I0QCDqqzY3c8P3YCnZjfcxD5FGROKXjJoKKQrsxwL
         h/SdztQVpnvvDJxNq/kVfnm90YCVa4ySK0QxBYW8sBt9C5ESpKHuFKECQo8yVM96GgXA
         9M+MG+eRSP6GWsV+l20KMRQcGwUUM78ngdYpCXhEQc6ieTXgexoGEgFEfDBs2qXH2FsH
         mg2aSk3mJzLOipRI33XRZDOckeHX7tR9A+XYz5MxmwP78FoZoQBrDkdg532cEGndFG5n
         3taS4mzGavC/JhJWYKKs5C0Ofy5cnvZh99Vya57QETlHBQaL87tka49wJUVDFdGh9K6J
         /9Hw==
X-Gm-Message-State: APjAAAUpQhzwu2LL0UPDeOqHxWb/TX2heeKfG++aQ+dBrfi7dFB9tOR9
        UgVmPwZpgtAgHZUvYBKdD8SD76k8
X-Google-Smtp-Source: APXvYqw8ytTLE0J5uomh8jeG2zSTmclcbMtByeBKiVdFVEqo0X7Y3rmCIaFwJjieULnX1McPrzAhjA==
X-Received: by 2002:ac8:6c5:: with SMTP id j5mr38985798qth.284.1577454464249;
        Fri, 27 Dec 2019 05:47:44 -0800 (PST)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id d9sm10510184qth.34.2019.12.27.05.47.43
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2019 05:47:43 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 10/16] t3415: increase granularity of test_auto_{fixup,squash}()
Date:   Fri, 27 Dec 2019 08:47:19 -0500
Message-Id: <a991117b36e8a765e3323065e90fbfe2d63b710c.1577454401.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.1.810.g65a2f617f4
In-Reply-To: <cover.1577454401.git.liu.denton@gmail.com>
References: <cover.1577454401.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We used to use `test_must_fail test_auto_{fixup,squash}` which would
ensure that the function failed. However, this is a little ham-fisted as
there is no way of ensuring that the expected part of the function
actually fails.

Increase the granularity by accepting an optional `!` first argument
which will check that the rebase does not squash in any commits by
ensuring that there are still 4 commits. If `!` is not provided, the old
logic is run.

This patch may be better reviewed with `--ignore-all-space`.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t3415-rebase-autosquash.sh | 64 +++++++++++++++++++++++++-----------
 1 file changed, 44 insertions(+), 20 deletions(-)

diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
index b0add36f82..093de9005b 100755
--- a/t/t3415-rebase-autosquash.sh
+++ b/t/t3415-rebase-autosquash.sh
@@ -25,6 +25,13 @@ test_expect_success setup '
 '
 
 test_auto_fixup () {
+	no_squash= &&
+	if test "x$1" = 'x!'
+	then
+		no_squash=true
+		shift
+	fi &&
+
 	git reset --hard base &&
 	echo 1 >file1 &&
 	git add -u &&
@@ -35,14 +42,19 @@ test_auto_fixup () {
 	test_tick &&
 	git rebase $2 -i HEAD^^^ &&
 	git log --oneline >actual &&
-	test_line_count = 3 actual &&
-	git diff --exit-code $1 &&
-	echo 1 >expect &&
-	git cat-file blob HEAD^:file1 >actual &&
-	test_cmp expect actual &&
-	git cat-file commit HEAD^ >commit &&
-	grep first commit >actual &&
-	test_line_count = 1 actual
+	if test -n "$no_squash"
+	then
+		test_line_count = 4 actual
+	else
+		test_line_count = 3 actual &&
+		git diff --exit-code $1 &&
+		echo 1 >expect &&
+		git cat-file blob HEAD^:file1 >actual &&
+		test_cmp expect actual &&
+		git cat-file commit HEAD^ >commit &&
+		grep first commit >actual &&
+		test_line_count = 1 actual
+	fi
 }
 
 test_expect_success 'auto fixup (option)' '
@@ -52,12 +64,19 @@ test_expect_success 'auto fixup (option)' '
 test_expect_success 'auto fixup (config)' '
 	git config rebase.autosquash true &&
 	test_auto_fixup final-fixup-config-true &&
-	test_must_fail test_auto_fixup fixup-config-true-no --no-autosquash &&
+	test_auto_fixup ! fixup-config-true-no --no-autosquash &&
 	git config rebase.autosquash false &&
-	test_must_fail test_auto_fixup final-fixup-config-false
+	test_auto_fixup ! final-fixup-config-false
 '
 
 test_auto_squash () {
+	no_squash= &&
+	if test "x$1" = 'x!'
+	then
+		no_squash=true
+		shift
+	fi &&
+
 	git reset --hard base &&
 	echo 1 >file1 &&
 	git add -u &&
@@ -68,14 +87,19 @@ test_auto_squash () {
 	test_tick &&
 	git rebase $2 -i HEAD^^^ &&
 	git log --oneline >actual &&
-	test_line_count = 3 actual &&
-	git diff --exit-code $1 &&
-	echo 1 >expect &&
-	git cat-file blob HEAD^:file1 >actual &&
-	test_cmp expect actual &&
-	git cat-file commit HEAD^ >commit &&
-	grep first commit >actual &&
-	test_line_count = 2 actual
+	if test -n "$no_squash"
+	then
+		test_line_count = 4 actual
+	else
+		test_line_count = 3 actual &&
+		git diff --exit-code $1 &&
+		echo 1 >expect &&
+		git cat-file blob HEAD^:file1 >actual &&
+		test_cmp expect actual &&
+		git cat-file commit HEAD^ >commit &&
+		grep first commit >actual &&
+		test_line_count = 2 actual
+	fi
 }
 
 test_expect_success 'auto squash (option)' '
@@ -85,9 +109,9 @@ test_expect_success 'auto squash (option)' '
 test_expect_success 'auto squash (config)' '
 	git config rebase.autosquash true &&
 	test_auto_squash final-squash-config-true &&
-	test_must_fail test_auto_squash squash-config-true-no --no-autosquash &&
+	test_auto_squash ! squash-config-true-no --no-autosquash &&
 	git config rebase.autosquash false &&
-	test_must_fail test_auto_squash final-squash-config-false
+	test_auto_squash ! final-squash-config-false
 '
 
 test_expect_success 'misspelled auto squash' '
-- 
2.24.1.810.g65a2f617f4

