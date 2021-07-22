Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03197C6377D
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 14:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D20076128A
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 14:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbhGVN1K (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 09:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbhGVN1J (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 09:27:09 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B72C061575
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 07:07:43 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id a23-20020a05600c2257b0290236ec98bebaso3045379wmm.1
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 07:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E4lOD+QeSwKK49JP7MDC50FnYUopLFYVapzOzLHYI2w=;
        b=CfMYgheQzZ16zLvnUXgvqHYPrkeFSTAx3h+kfDlqUr4ZqPSNu92Ts493+n5Oxe+cQA
         N7n+Y7EOoRMrTY2EDyBwMaQ8+aqMLF7sGkfkRkW30dpl8kYBqZGQYBhENB4BRYzspWD7
         xVS12jAGg9O7FjgvoQ6CLRJ6riYNOcfHudYf55q0rRxnDuCJVJ4v83W6DuWs0GIVmvMH
         tu1Lazji1+NB/MR5t+mXmw/flDRGWDjkrsVIVeKSvZircYUwLAvtA5scCo20wRV4PLi6
         D5GKiskoCXxrFfZaaPEL5qUnyh8bGVWTSlb0W0Ng2TQSKoW4HlatAt65CUoadz0mjOG2
         yM8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E4lOD+QeSwKK49JP7MDC50FnYUopLFYVapzOzLHYI2w=;
        b=RSJKwOyohGpPiRHaQyEiVI0SQNSaFleMYXnpiHr/jkBXYCLGIEwttahEDIakKkqmB3
         Io5W2SW6TmMPUF/OcEXVNIMqRDzInNbt42vndB4oXQkSCMHEHJ0KT941m0/m0KHaOv75
         6GO2nZIrvbooXCDZ9aHPzAoF6zDl4lLT4mQ36k0VlM76xWiHDcIN+P6L6m1Bnz4h3SIp
         ue2BjBQWABRGP0Bqn2NR4vQ2/zip1a3R9dTtkzLAaTtUJy6ynH8JL8OqIQCiedSGcRIx
         UGvbgFMaWwjnEdnwcXt5GuLqQzr09s8mOw9kIXbBm32OLSbXX6pDe2n/9UWt8GQIsqxS
         qq1w==
X-Gm-Message-State: AOAM530tWtys0dcdfsohiS/R6RRt+i0voMkNoFkp2D3br56aHCvFm7dB
        B95itpM1QmS7FvrafRn6XzPpTw5OYVqC4A==
X-Google-Smtp-Source: ABdhPJzdRB9vG99LoLDjATeqT9z/07eqGvKR2A7RlwrcdBHmWYQtLsN0cpCbW61hc18L1AEH3W+ozA==
X-Received: by 2002:a7b:c042:: with SMTP id u2mr42101155wmc.86.1626962861785;
        Thu, 22 Jul 2021 07:07:41 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d14sm30304687wrs.49.2021.07.22.07.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 07:07:41 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Tom Cook <tom.k.cook@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] setup: only die on invalid .git under RUN_SETUP
Date:   Thu, 22 Jul 2021 16:07:39 +0200
Message-Id: <patch-1.1-fc26c46d39-20210722T140648Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.954.g5a3a1483ade
In-Reply-To: <CAFSh4Uyr5v9Ao-j0j7yO_HkUZSovBmSg7ADia7XCNZfsspFUYg@mail.gmail.com>
References: <CAFSh4Uyr5v9Ao-j0j7yO_HkUZSovBmSg7ADia7XCNZfsspFUYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change RUN_SETUP_GENTLY to stop dying if e.g. the .git is "not a
repo". This means that we now recover in cases like:

    $ echo "gitdir: /foo/bar" > .git
    $ git ls-remote https://github.com/torvalds/linux
    [... ls-remote output ...]

But not (as intended):

    $ git rev-parse HEAD
    fatal: not a git repository: /foo/bar

The relevant setup_git_directory_gently_1() invocation was added in
01017dce546 (setup_git_directory_gently_1(): avoid die()ing,
2017-03-13), but I could reproduce this as far back as Git v1.8.0. I
don't know if this ever worked, but it should.

Let's also use the compiler to check enum arms for us, instead of
having a "default" fall-though case, this changes code added in
ce9b8aab5d9 (setup_git_directory_1(): avoid changing global state,
2017-03-13).

Reported-by: Tom Cook <tom.k.cook@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 setup.c            | 27 ++++++++++++++++++++++-----
 t/t0002-gitfile.sh |  8 ++++++--
 2 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/setup.c b/setup.c
index eb9367ca5c..6ff145d58b 100644
--- a/setup.c
+++ b/setup.c
@@ -1033,7 +1033,8 @@ enum discovery_result {
 	/* these are errors */
 	GIT_DIR_HIT_CEILING = -1,
 	GIT_DIR_HIT_MOUNT_POINT = -2,
-	GIT_DIR_INVALID_GITFILE = -3
+	GIT_DIR_INVALID_GITFILE = -3,
+	GIT_DIR_GITFILE_NOT_A_REPO = -4,
 };
 
 /*
@@ -1118,8 +1119,11 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
 				/* NEEDSWORK: fail if .git is not file nor dir */
 				if (is_git_directory(dir->buf))
 					gitdirenv = DEFAULT_GIT_DIR_ENVIRONMENT;
-			} else if (error_code != READ_GITFILE_ERR_STAT_FAILED)
+			} else if (error_code == READ_GITFILE_ERR_NOT_A_REPO) {
+				return GIT_DIR_GITFILE_NOT_A_REPO;
+			} else if (error_code != READ_GITFILE_ERR_STAT_FAILED) {
 				return GIT_DIR_INVALID_GITFILE;
+			}
 		}
 		strbuf_setlen(dir, offset);
 		if (gitdirenv) {
@@ -1209,6 +1213,8 @@ const char *setup_git_directory_gently(int *nongit_ok)
 	struct strbuf dir = STRBUF_INIT, gitdir = STRBUF_INIT;
 	const char *prefix = NULL;
 	struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
+	int die_on_error = !nongit_ok;
+	enum discovery_result discovery;
 
 	/*
 	 * We may have read an incomplete configuration before
@@ -1231,7 +1237,9 @@ const char *setup_git_directory_gently(int *nongit_ok)
 		die_errno(_("Unable to read current working directory"));
 	strbuf_addbuf(&dir, &cwd);
 
-	switch (setup_git_directory_gently_1(&dir, &gitdir, 1)) {
+	discovery = setup_git_directory_gently_1(&dir, &gitdir, die_on_error);
+
+	switch (discovery) {
 	case GIT_DIR_EXPLICIT:
 		prefix = setup_explicit_git_dir(gitdir.buf, &cwd, &repo_fmt, nongit_ok);
 		break;
@@ -1259,6 +1267,16 @@ const char *setup_git_directory_gently(int *nongit_ok)
 			    dir.buf);
 		*nongit_ok = 1;
 		break;
+	case GIT_DIR_GITFILE_NOT_A_REPO:
+		if (!nongit_ok)
+			die(_("not a git repository: %s"), dir.buf);
+		*nongit_ok = 1;
+		break;
+	case GIT_DIR_INVALID_GITFILE:
+		if (!nongit_ok)
+			die(_("invalid .git file: %s"), dir.buf);
+		*nongit_ok = 1;
+		break;
 	case GIT_DIR_NONE:
 		/*
 		 * As a safeguard against setup_git_directory_gently_1 returning
@@ -1266,8 +1284,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 		 * set startup_info->have_repository to 1 when we did nothing to
 		 * find a repository.
 		 */
-	default:
-		BUG("unhandled setup_git_directory_1() result");
+		BUG("setup_git_directory_1() should not return GIT_DIR_NONE");
 	}
 
 	/*
diff --git a/t/t0002-gitfile.sh b/t/t0002-gitfile.sh
index 8440e6add1..176dc8c9dc 100755
--- a/t/t0002-gitfile.sh
+++ b/t/t0002-gitfile.sh
@@ -21,13 +21,17 @@ test_expect_success 'initial setup' '
 test_expect_success 'bad setup: invalid .git file format' '
 	echo "gitdir $REAL" >.git &&
 	test_must_fail git rev-parse 2>.err &&
-	test_i18ngrep "invalid gitfile format" .err
+	test_i18ngrep "invalid gitfile format" .err &&
+
+	git ls-remote "file://$REAL"
 '
 
 test_expect_success 'bad setup: invalid .git file path' '
 	echo "gitdir: $REAL.not" >.git &&
 	test_must_fail git rev-parse 2>.err &&
-	test_i18ngrep "not a git repository" .err
+	test_i18ngrep "not a git repository" .err &&
+
+	git ls-remote "file://$REAL"
 '
 
 test_expect_success 'final setup + check rev-parse --git-dir' '
-- 
2.32.0.954.g5a3a1483ade

