Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CBB1C2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 11:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64B6B613BF
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 11:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbhFQLYD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 07:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbhFQLYB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 07:24:01 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08885C06175F
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 04:21:54 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id r7so3439458edv.12
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 04:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZcXxzf2L2wZCrJU8+zniLttskGhTcm/BqidTkJU7Rr4=;
        b=iiqgWPR5gryndhu+8XZdaUlMkESN0KGebSHipVhLsJ49HAcUCOmPfG5pDG2CZgG2tR
         lej9Tk4xQN7d83kwP7hRIZSOWiK9LrwlXJNv5XTc2kZihRhRvBq/R2AWogviw0j+b6nQ
         lKhLT7t703BxlVxcghi2kwHZNMmZdAR+eFxFXT6x8z+QK+e8W+ZrJteaejs/d6ztVOyi
         rVDk9CX15tRK89psT9FxWusJ6e6PI0mVcu2iTh3L2X/pEewrMGGjqp8yxQds7VQgzsZi
         +zMvDBseteOzccHW0ldDwmDUFvnwm7o4zytpUDCXkJq99EprGYgX5I4YTkJ1M6yoETH3
         0Tfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZcXxzf2L2wZCrJU8+zniLttskGhTcm/BqidTkJU7Rr4=;
        b=skLWN2EvuAUviwDDk+0AfuqqpkyFIKoJ5lbVXHXjazeoEJOZU4312fTQN4P19atK//
         o+crgj0TUHsyajeo6Oy8tXXPCCEW1iG5L62c+vzaJblKRTfG4EpAqAh+5idT6mqYl8/7
         JXzHOKGw52Ld0NXVoAx6VOryaafjYf+IZducea+Fm6hadHX6Hbk4eo4eMkAQKIRPh+uU
         bj4b8oHwTzrTgczd4W/h/fS7wGws6G77yQTaPCImRUdRtdWbZ27ikjpxgRl2H5IQHPDe
         3KKIY3mDSgSr6rtGe52HP1MqpaYID7OSl2qx5yuQG6w4Mfr4zDeFbg3vnU0Pt/dTkHwj
         /eeg==
X-Gm-Message-State: AOAM532JyWXesqxEQ7EGiHa8nQAeTDByKVkd4Do+/8t1X0MXuLWZY9GR
        q08UeQ8SMWwRczmu3If0rbyMIhJX+a1URw==
X-Google-Smtp-Source: ABdhPJwPFkBl+gtl4gRzU38WWD9a/viM65Xs8Ap8vBucastsfPmyBkBDVdWScMN0umP6VphS2FaIMg==
X-Received: by 2002:a05:6402:6d1:: with SMTP id n17mr5825952edy.116.1623928912419;
        Thu, 17 Jun 2021 04:21:52 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id cw10sm3583153ejb.62.2021.06.17.04.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 04:21:51 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/3] bundle cmd: stop leaking memory from parse_options_cmd_bundle()
Date:   Thu, 17 Jun 2021 13:21:47 +0200
Message-Id: <patch-1.3-f4191088ac-20210617T111934Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.571.gdba276db2c
In-Reply-To: <cover-0.3-0000000000-20210617T111934Z-avarab@gmail.com>
References: <cover-0.3-0000000000-20210617T111934Z-avarab@gmail.com>
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
index ea6948110b..7778297277 100644
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
2.32.0.571.gdba276db2c

