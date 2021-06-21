Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1AC6C49EA2
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 15:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 889BE6113E
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 15:16:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbhFUPSp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 11:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbhFUPSk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 11:18:40 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C76C061756
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 08:16:22 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id y7so20024556wrh.7
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 08:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YeHJII5CilxTA5dSTtoqnO1BrsU1pKRkDI9AYfxcSZ8=;
        b=eCG0C+x94IVkwg0iaKg0JIwdZdCXbZF7ghGpyT3MRTRTAfjmg1N4pQjcuFfnG5bsT0
         NMxt4j5mnR1JFpytcGWfG1pvVmeRQ0FPy9aTy10dBUM2qhj+3LsY7UEL89lE5/yPIwEh
         r/cgwrAohoy5W8tzJsEb//OOjptU3KPyQfT60u0GtWQG6WmvLxSAfiPf0QAl0q4N8QDb
         cybS8lHJbbkOi77OvH/+TqZWHAzcF6XkUmo5nbs4w873v5x27lo+R/BtFNAZKU9ZUDZA
         eJWotI5h2o1fvh3B0JOzzty7jdSBwGPAhkD3ltU/cXNgEX1qnRv+vzy4wJ6TM3wcD2Mc
         saWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YeHJII5CilxTA5dSTtoqnO1BrsU1pKRkDI9AYfxcSZ8=;
        b=Mak1fBfTMQPMuSmvq88e7AhA9fcChasR2iLwIW433bNyGWUqZHphOPsZGNynZykev6
         vtvZaj71eOKp8qXdn6dMLw/ufIa+oUiMRz77GOFFDV1XIyREsU9+5sgWUwhAUtbIk0K1
         qbwZlaUxm/8fqhTWu1Ea1Y8wUXCAx2MuCozfH3Fk+VMrD+uUhWn+7XrIK7uZRB7P3nKy
         qn7zK3rNiCmmqasQilnYVSSJSXuKyManTQcqYrBFq+faPHdUheXbo4ZMXT0vJVn9F8JI
         GKHu5WW42GR/2koExFeTHsKRfJDhmqy0BF/iC+HzxMYnuPnAyinBVA1PMzl2SJZAicoC
         zFyw==
X-Gm-Message-State: AOAM532qmp9vN685LhbijX80tElbBi6kNSzlTC5GPhHKg2TMjaC9zQiU
        A+8EpN1h0+abz/zLWxK3dKzeoj1l0dZttw==
X-Google-Smtp-Source: ABdhPJzf3wfkSGZLSbwUIRA/ozXku3khOSg2cDJ9FEYO4aY2cIl8V0lgEz6awXv0mQxMr0dcSerihg==
X-Received: by 2002:adf:e109:: with SMTP id t9mr29000468wrz.372.1624288580780;
        Mon, 21 Jun 2021 08:16:20 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u15sm15716019wmq.1.2021.06.21.08.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 08:16:20 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/3] bundle cmd: stop leaking memory from parse_options_cmd_bundle()
Date:   Mon, 21 Jun 2021 17:16:12 +0200
Message-Id: <patch-1.3-932c0883ce0-20210621T151357Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.599.g3967b4fa4ac
In-Reply-To: <cover-0.3-00000000000-20210621T151357Z-avarab@gmail.com>
References: <cover-0.3-0000000000-20210617T111934Z-avarab@gmail.com> <cover-0.3-00000000000-20210621T151357Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak from the prefix_filename() function introduced with
its use in 3b754eedd5 (bundle: use prefix_filename with bundle path,
2017-03-20).

As noted in that commit the leak was intentional as a part of being
sloppy about freeing resources just before we exit, I'm changing this
because I'll be fixing other memory leaks in the bundle API (including
the library version) in subsequent commits. It's easier to reason
about those fixes if valgrind runs cleanly at the end without any
leaks whatsoever.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/bundle.c | 79 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 55 insertions(+), 24 deletions(-)

diff --git a/builtin/bundle.c b/builtin/bundle.c
index ea6948110b0..7778297277a 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -46,7 +46,7 @@ static int parse_options_cmd_bundle(int argc,
 		const char* prefix,
 		const char * const usagestr[],
 		const struct option options[],
-		const char **bundle_file) {
+		char **bundle_file) {
 	int newargc;
 	newargc = parse_options(argc, argv, NULL, options, usagestr,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
@@ -61,7 +61,8 @@ static int cmd_bundle_create(int argc, const char **argv, const char *prefix) {
 	int progress = isatty(STDERR_FILENO);
 	struct strvec pack_opts;
 	int version = -1;
-
+	int die_no_repo = 0;
+	int ret;
 	struct option options[] = {
 		OPT_SET_INT('q', "quiet", &progress,
 			    N_("do not show progress meter"), 0),
@@ -76,7 +77,7 @@ static int cmd_bundle_create(int argc, const char **argv, const char *prefix) {
 			    N_("specify bundle format version")),
 		OPT_END()
 	};
-	const char* bundle_file;
+	char *bundle_file;
 
 	argc = parse_options_cmd_bundle(argc, argv, prefix,
 			builtin_bundle_create_usage, options, &bundle_file);
@@ -92,77 +93,107 @@ static int cmd_bundle_create(int argc, const char **argv, const char *prefix) {
 	if (progress && all_progress_implied)
 		strvec_push(&pack_opts, "--all-progress-implied");
 
-	if (!startup_info->have_repository)
+	if (!startup_info->have_repository) {
+		die_no_repo = 1;
+		goto cleanup;
+	}
+	ret = !!create_bundle(the_repository, bundle_file, argc, argv, &pack_opts, version);
+cleanup:
+	free(bundle_file);
+	if (die_no_repo)
 		die(_("Need a repository to create a bundle."));
-	return !!create_bundle(the_repository, bundle_file, argc, argv, &pack_opts, version);
+	return ret;
 }
 
 static int cmd_bundle_verify(int argc, const char **argv, const char *prefix) {
 	struct bundle_header header;
 	int bundle_fd = -1;
 	int quiet = 0;
-
+	int ret;
 	struct option options[] = {
 		OPT_BOOL('q', "quiet", &quiet,
 			    N_("do not show bundle details")),
 		OPT_END()
 	};
-	const char* bundle_file;
+	char *bundle_file;
 
 	argc = parse_options_cmd_bundle(argc, argv, prefix,
 			builtin_bundle_verify_usage, options, &bundle_file);
 	/* bundle internals use argv[1] as further parameters */
 
 	memset(&header, 0, sizeof(header));
-	if ((bundle_fd = read_bundle_header(bundle_file, &header)) < 0)
-		return 1;
+	if ((bundle_fd = read_bundle_header(bundle_file, &header)) < 0) {
+		ret = 1;
+		goto cleanup;
+	}
 	close(bundle_fd);
-	if (verify_bundle(the_repository, &header, !quiet))
-		return 1;
+	if (verify_bundle(the_repository, &header, !quiet)) {
+		ret = 1;
+		goto cleanup;
+	}
+
 	fprintf(stderr, _("%s is okay\n"), bundle_file);
-	return 0;
+	ret = 0;
+cleanup:
+	free(bundle_file);
+	return ret;
 }
 
 static int cmd_bundle_list_heads(int argc, const char **argv, const char *prefix) {
 	struct bundle_header header;
 	int bundle_fd = -1;
-
+	int ret;
 	struct option options[] = {
 		OPT_END()
 	};
-	const char* bundle_file;
+	char *bundle_file;
 
 	argc = parse_options_cmd_bundle(argc, argv, prefix,
 			builtin_bundle_list_heads_usage, options, &bundle_file);
 	/* bundle internals use argv[1] as further parameters */
 
 	memset(&header, 0, sizeof(header));
-	if ((bundle_fd = read_bundle_header(bundle_file, &header)) < 0)
-		return 1;
+	if ((bundle_fd = read_bundle_header(bundle_file, &header)) < 0) {
+		ret = 1;
+		goto cleanup;
+	}
 	close(bundle_fd);
-	return !!list_bundle_refs(&header, argc, argv);
+	ret = !!list_bundle_refs(&header, argc, argv);
+cleanup:
+	free(bundle_file);
+	return ret;
 }
 
 static int cmd_bundle_unbundle(int argc, const char **argv, const char *prefix) {
 	struct bundle_header header;
 	int bundle_fd = -1;
-
+	int die_no_repo = 0;
+	int ret;
 	struct option options[] = {
 		OPT_END()
 	};
-	const char* bundle_file;
+	char *bundle_file;
 
 	argc = parse_options_cmd_bundle(argc, argv, prefix,
 			builtin_bundle_unbundle_usage, options, &bundle_file);
 	/* bundle internals use argv[1] as further parameters */
 
 	memset(&header, 0, sizeof(header));
-	if ((bundle_fd = read_bundle_header(bundle_file, &header)) < 0)
-		return 1;
-	if (!startup_info->have_repository)
-		die(_("Need a repository to unbundle."));
-	return !!unbundle(the_repository, &header, bundle_fd, 0) ||
+	if ((bundle_fd = read_bundle_header(bundle_file, &header)) < 0) {
+		ret = 1;
+		goto cleanup;
+	}
+	if (!startup_info->have_repository) {
+		die_no_repo = 1;
+		goto cleanup;
+	}
+	ret = !!unbundle(the_repository, &header, bundle_fd, 0) ||
 		list_bundle_refs(&header, argc, argv);
+cleanup:
+	if (die_no_repo)
+		die(_("Need a repository to unbundle."));
+	free(bundle_file);
+	return ret;
 }
 
 int cmd_bundle(int argc, const char **argv, const char *prefix)
-- 
2.32.0.599.g3967b4fa4ac

