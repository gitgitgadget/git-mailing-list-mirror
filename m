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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E72C11F69
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 14:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 567EB6144C
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 14:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235328AbhF3OI6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Jun 2021 10:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235047AbhF3OIv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jun 2021 10:08:51 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61FBC061756
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 07:06:21 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id r9-20020a7bc0890000b02901f347b31d55so1655028wmh.2
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 07:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SnfDXt5sm+2eDtRCNo6bqj+fhnJFVLyFuY1GMHqWLIQ=;
        b=kxXVQZXfEzqWIFvzrp2flvZXkwSbVPGf3jsToZQqM9Pk5O5hMZ9Jz2CtEHYlfa1tZM
         IupW5PGB5nPju8kUt0wDDyyh58iNfuYC2HDG1v99RsMx4S6/t47/FpaHHXxN0YwF0DvO
         swHhAQzpZiliw7FIVszUAMbJxHTOJXWwADFCxIoGz2gnJx7NIK9+z042OO0KxNaCAYnq
         3jUoKI7EAdOMlakRYJ9JwmmIr28hvRS/Yldr4YVIZ9TwmrYRJaykbnvbBxbcROQTZFOF
         kSuREKdGxhN2+1qsLWSRNmRQgDumJA4CTzQqANESTAvgcuxcyEdSydRZWS6Pzs05TRcN
         jf8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SnfDXt5sm+2eDtRCNo6bqj+fhnJFVLyFuY1GMHqWLIQ=;
        b=JtuOoMrvpXBUl9iuRLvgK6356nTnddM9aFDJ7gVH+UBSh3MLemRU4kbatLVNGRrmY9
         /0HyGXlnd5hB5hcV3cnOrqNmalBp8Wp6BNpIjPrEJuVoaOR6O2LNylf3VJvdmgRT/E3i
         JmXsejFH6AwLMpx53ILt1rYdn9l58qJ4j00Z//T+SkIUH15xltspIOORdvytKKAexBUp
         beuR+KuT2O5WKlhR7Mv0ORJj/zLgNlQhK1D/KaA+/Xj0XpDM/Js0qtvVXJJE7cmqaqKM
         elQOEu624Sr91mVzfcGqIN5ZolXNDzI9TsxVKAN/IXgxJsbjZwjgCznaKG+vBc0pklb2
         96Ig==
X-Gm-Message-State: AOAM530J3GTet9LtiyMIFCQRRnTpyAqgcph2EP5zH9dZMGkp1hgR7w3S
        lF9Sqx4l7hTToeC2aLBgLvXVgHpRRqbgaw==
X-Google-Smtp-Source: ABdhPJwttmvcwQopBJdvL37ozNbQKMEMWb37hu8i3fQAYZyyHCRpKfWnAtoacmCtI4ycOonHZIddOw==
X-Received: by 2002:a05:600c:3658:: with SMTP id y24mr4781054wmq.6.1625061980230;
        Wed, 30 Jun 2021 07:06:20 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b20sm4763814wmj.7.2021.06.30.07.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 07:06:19 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 1/3] bundle cmd: stop leaking memory from parse_options_cmd_bundle()
Date:   Wed, 30 Jun 2021 16:06:14 +0200
Message-Id: <patch-1.3-3d0d7a8e8b5-20210630T140339Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.613.g8e17abc2eb
In-Reply-To: <cover-0.3-00000000000-20210630T140339Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20210621T151357Z-avarab@gmail.com> <cover-0.3-00000000000-20210630T140339Z-avarab@gmail.com>
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

An earlier version of this change went out of its way to not leak
memory on the die() codepaths here, but that was deemed too verbose to
worry about in a built-in that's dying anyway. The only reason we'd
need that is to appease a mode like SANITIZE=leak within the scope of
an entire test file.

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
2.32.0.613.g8e17abc2eb

