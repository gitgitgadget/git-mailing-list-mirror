Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C19C63777
	for <git@archiver.kernel.org>; Sat, 28 Nov 2020 22:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9752222256
	for <git@archiver.kernel.org>; Sat, 28 Nov 2020 22:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7ZgcA5f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbgK1Vtu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Nov 2020 16:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733032AbgK1TFA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Nov 2020 14:05:00 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4CDC09424A
        for <git@vger.kernel.org>; Fri, 27 Nov 2020 22:44:44 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id a3so8272424wmb.5
        for <git@vger.kernel.org>; Fri, 27 Nov 2020 22:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7WetoMbnRellC+XuUdQeCzscRpJJO2DEGkFC7ize0EY=;
        b=F7ZgcA5fnxm/55VFeB30OWxh4nBEI9Smg22+RhL9LfEalDBzix+dG7+4kMCPYnVm8e
         uBj4b6mExmP+MozVbxNCsqLxySpSAc1UUHLwFr69XO+p6YmO7H1saxILm549wkkOBNxK
         ClHo9FN1zO6Ssyoqe4Rdfb9UExb14flVJnvW4TF7vibxKq0rx+epQPzXbN7xy20IICFz
         yuNk477WDzAD3XwWRIPDdaI1yaTBEeFJEwP01H2uzEWASPPimB0QUl3p6K4W865+akNK
         xSs1uVlLAbDtbd6k8rnImTQNY3D0J8Woa600LTuqEywUNhy/FCiWCKglMd0msVHUz496
         ws1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7WetoMbnRellC+XuUdQeCzscRpJJO2DEGkFC7ize0EY=;
        b=O9XNJnqNIHasKkuRmhxGTWOlxVomTIOyVK4q+WOQ3hnOLC8CoYe4DbbbgcJm93+Nt3
         0yFuC1HIMpNMKhiuPP8W1i8FpXQ8x5hZcxNcuCM+5Hdv8AbMpU0Pn2e7qakzgPrKraAN
         TRugEbqU2vXuYy5GDCAGtXJH0k7nGug2Dh0LfMc8x5a78RmraX4zXuGAd7IskZU38jYg
         8BA3AN/opf6cNcaEXYXzq5zH2smYWB0DZNpTnZAyEmWEJMNV4og+Ov5YXQ1jcTxIubD4
         mokejZVsC9aPmN28QUijRl8WwDj5mnNhY7fd+BwDXlFC8jWmsAEncXV+xf3gbL5qDdwE
         sJWQ==
X-Gm-Message-State: AOAM531KIrqHNtfbjYPJoBsIc6385NpUaRhC2h4jMwPps2ecLxzEMn2D
        0gLMYNkYTMWDJeo+HafzcoPYHaN7Afo=
X-Google-Smtp-Source: ABdhPJy6Ti1v1QAOdDAdnq0teyffWAVwWHFIXIb6mX0GWg+kPUAxWFbW+KhZoTMb6OLLIQ9XhN+DlA==
X-Received: by 2002:a1c:28c4:: with SMTP id o187mr13118829wmo.40.1606545883369;
        Fri, 27 Nov 2020 22:44:43 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s4sm18408046wro.10.2020.11.27.22.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 22:44:42 -0800 (PST)
Message-Id: <5c3bdc212962a24f8f23207c6b1b3504c53903ad.1606545878.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.801.git.1606545878.gitgitgadget@gmail.com>
References: <pull.801.git.1606545878.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 28 Nov 2020 06:44:36 +0000
Subject: [PATCH 4/6] fixup! reftable: rest of library
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Avoid using `getopt()`: it might be POSIX, but Git's audience is much
larger than POSIX. MSVC, for example, does not support `getopt()`.

Without this patch, the `vs-build` job of our CI/PR builds would simply
fail completely.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 reftable/dump.c | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/reftable/dump.c b/reftable/dump.c
index 0bd7a1cfa6..e990bffe0c 100644
--- a/reftable/dump.c
+++ b/reftable/dump.c
@@ -167,40 +167,34 @@ static void print_help(void)
 int reftable_dump_main(int argc, char *const *argv)
 {
 	int err = 0;
-	int opt;
 	int opt_dump_table = 0;
 	int opt_dump_stack = 0;
 	int opt_compact = 0;
-	const char *arg = NULL;
-	while ((opt = getopt(argc, argv, "2chts")) != -1) {
-		switch (opt) {
-		case '2':
-			hash_id = 0x73323536;
+	const char *arg = NULL, *argv0 = argv[0];
+
+	for (; argc > 1; argv++, argc--)
+		if (*argv[1] != '-')
 			break;
-		case 't':
+		else if (!strcmp("-2", argv[1]))
+			hash_id = 0x73323536;
+		else if (!strcmp("-t", argv[1]))
 			opt_dump_table = 1;
-			break;
-		case 's':
+		else if (!strcmp("-s", argv[1]))
 			opt_dump_stack = 1;
-			break;
-		case 'c':
+		else if (!strcmp("-c", argv[1]))
 			opt_compact = 1;
-			break;
-		case '?':
-		case 'h':
+		else if (!strcmp("-?", argv[1]) || !strcmp("-h", argv[1])) {
 			print_help();
 			return 2;
-			break;
 		}
-	}
 
-	if (argv[optind] == NULL) {
+	if (argc != 2) {
 		fprintf(stderr, "need argument\n");
 		print_help();
 		return 2;
 	}
 
-	arg = argv[optind];
+	arg = argv[1];
 
 	if (opt_dump_table) {
 		err = dump_table(arg);
@@ -211,7 +205,7 @@ int reftable_dump_main(int argc, char *const *argv)
 	}
 
 	if (err < 0) {
-		fprintf(stderr, "%s: %s: %s\n", argv[0], arg,
+		fprintf(stderr, "%s: %s: %s\n", argv0, arg,
 			reftable_error_str(err));
 		return 1;
 	}
-- 
gitgitgadget

