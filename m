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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E47EFC11F68
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 09:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C21D3613BC
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 09:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbhGBKAK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jul 2021 06:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbhGBKAK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jul 2021 06:00:10 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39436C061764
        for <git@vger.kernel.org>; Fri,  2 Jul 2021 02:57:38 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id q18-20020a1ce9120000b02901f259f3a250so5968785wmc.2
        for <git@vger.kernel.org>; Fri, 02 Jul 2021 02:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jll18OVzZewk75+GFM5FnqX7JXR7rlReOsSpV1sOg+U=;
        b=Z4cYMhWijzFIXVMT5qouFXTwYiU1TXvyaY459jxbzznlX58MIbAu0ve53gzStRvsK1
         v08dQJw2GekJZzmfFB+4C6nm0jtLTYjkXdJIoRbfU+VIxOqoZlF8eTLQ70t6DipqTdIJ
         VQJ6JLVONIkUB1p+90vXCDYsC5H04FqXAoz36HwAtqiFJfLQ//0F25G3atpsVxI9pqVA
         woKjM3xjqBrxrkC2iAgrPN0XwtWx77J0GqyPP4/4L1ElOfbXpH5ZcXv871ENMWLUXMZ4
         Fy48+CEB10KNr3VDYEnuh90LA1EMaUR1qwOhLw8pGnEKMEnpFn5Nr5ZVaH8MQlg8mpfw
         lRpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jll18OVzZewk75+GFM5FnqX7JXR7rlReOsSpV1sOg+U=;
        b=eu3BUUcfT/qnECA5HWEmXs80rjzhWnrDrAT8pQOT9ba3kCWY5ON/UnVNOcCXVUjW4f
         RatFj11XaZxivqqmTmign/Ic8Thd7Rcx46Pv3x182qadLg22vc7oQM0RrRpziSE0woGm
         jomBsgNOSw0RUi/9ekzDLgk6xH/XOISIDwuDb5j8llLtqFo5UFgQkZk2kxjAhBbOUjoP
         uzy20VW/MoN5OpzO25oSJugY0ngwH3y+8VfENKln4/FteLG/2VHNWngmwML/jXkScMmc
         wLd7hbL8w9ypDhBUqWtWW6iSSrxwk/NguXjBhCfTEXsBN0MCwLJBVVxI5MYNWyUL1Png
         zYiQ==
X-Gm-Message-State: AOAM532kaBJ+jcDxE3QNwsuOwBDfdjYhn7PJUKvlmuKDwZcf/ohlQkFm
        C4N7uk4x882mi0B2Mr6OEoS8r5tDnaldKA==
X-Google-Smtp-Source: ABdhPJxHyk6J3PPxmV56VjqHStzUfEYbsjTAZdi+Vc4R5wnUtvDob8UkHDr8/zUXxNm0E2nG2tRHoQ==
X-Received: by 2002:a7b:c39a:: with SMTP id s26mr4594415wmj.115.1625219856646;
        Fri, 02 Jul 2021 02:57:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m6sm3307713wrw.9.2021.07.02.02.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 02:57:36 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 1/3] bundle cmd: stop leaking memory from parse_options_cmd_bundle()
Date:   Fri,  2 Jul 2021 11:57:30 +0200
Message-Id: <patch-1.3-8e1d08113e5-20210702T095450Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.632.g49a94b9226d
In-Reply-To: <cover-0.3-00000000000-20210702T095450Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20210630T140339Z-avarab@gmail.com> <cover-0.3-00000000000-20210702T095450Z-avarab@gmail.com>
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

An earlier version of this change[1] went out of its way to not leak
memory on the die() codepaths here, but doing so will only avoid
reports of potential leaks under heap-only leak trackers such as
valgrind, not the SANITIZE=leak mode.

Avoiding those leaks as well might be useful to enable us to run
cleanly under the likes of valgrind in the future. But for now the
relative verbosity of the resulting code, and the fact that we don't
have some valgrind or SANITIZE=leak mode as part of our CI (it's only
run ad-hoc, see [2]), means we're not worrying about that for now.

1. https://lore.kernel.org/git/87v95vdxrc.fsf@evledraar.gmail.com/
2. https://lore.kernel.org/git/87czsv2idy.fsf@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/bundle.c | 62 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 41 insertions(+), 21 deletions(-)

diff --git a/builtin/bundle.c b/builtin/bundle.c
index ea6948110b0..15e2bd61965 100644
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
@@ -61,7 +61,7 @@ static int cmd_bundle_create(int argc, const char **argv, const char *prefix) {
 	int progress = isatty(STDERR_FILENO);
 	struct strvec pack_opts;
 	int version = -1;
-
+	int ret;
 	struct option options[] = {
 		OPT_SET_INT('q', "quiet", &progress,
 			    N_("do not show progress meter"), 0),
@@ -76,7 +76,7 @@ static int cmd_bundle_create(int argc, const char **argv, const char *prefix) {
 			    N_("specify bundle format version")),
 		OPT_END()
 	};
-	const char* bundle_file;
+	char *bundle_file;
 
 	argc = parse_options_cmd_bundle(argc, argv, prefix,
 			builtin_bundle_create_usage, options, &bundle_file);
@@ -94,75 +94,95 @@ static int cmd_bundle_create(int argc, const char **argv, const char *prefix) {
 
 	if (!startup_info->have_repository)
 		die(_("Need a repository to create a bundle."));
-	return !!create_bundle(the_repository, bundle_file, argc, argv, &pack_opts, version);
+	ret = !!create_bundle(the_repository, bundle_file, argc, argv, &pack_opts, version);
+	free(bundle_file);
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
+	if ((bundle_fd = read_bundle_header(bundle_file, &header)) < 0) {
+		ret = 1;
+		goto cleanup;
+	}
 	if (!startup_info->have_repository)
 		die(_("Need a repository to unbundle."));
-	return !!unbundle(the_repository, &header, bundle_fd, 0) ||
+	ret = !!unbundle(the_repository, &header, bundle_fd, 0) ||
 		list_bundle_refs(&header, argc, argv);
+cleanup:
+	free(bundle_file);
+	return ret;
 }
 
 int cmd_bundle(int argc, const char **argv, const char *prefix)
-- 
2.32.0.632.g49a94b9226d

