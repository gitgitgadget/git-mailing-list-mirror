Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94AFDC1B08C
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 15:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EA5961374
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 15:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239465AbhGOPnm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 11:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239286AbhGOPnd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 11:43:33 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216A7C061768
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 08:40:40 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id g16so8375688wrw.5
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 08:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=IzJopMreD03mb0H5DzVSKa/vpC4rGACWQqE7utDtPrg=;
        b=nmmqPKfT6h8bOyszT0nDHGHoU78EbZGvJbaprQveR1BLqkJFCMPjwPHP8Gc8WlwwgZ
         laWBctZKGlgcux8tPce5+mc0QUZEizXdkotoalZPWG0EZqx+YB+7n2pUNW4KDlu3dhUG
         rZWLXBjEPHFiZ3T004ujq8QzHw77MZL1+UaSeibnHeygzW3/jQeaDfdz5MZ2E0NnT2zk
         PEE2RAIFyKMrY5zA32MqB7E6e0d4tMXYNi+1BQnZx7KwMRgRIqFvwxFgXZWNAPDpuB9p
         WpxTpjRoyeHvZ3eZcFf4WkdF0d5D+Edm7YQwNe3LBFMSrAsxgFTl/aSDPna44rF4wSCx
         0+qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=IzJopMreD03mb0H5DzVSKa/vpC4rGACWQqE7utDtPrg=;
        b=UAwC/3ercuLl6GXldoCuQYKmtHOcdN/qcPihFNSoINBOWGFOF07TzUcjNGhnvxLHDm
         8qSLGEmeYommKrrId778I6Nh2zLE2KeLBiLuoUl37PbCbcaDAX8bmhiaoSzKO1wr+BKZ
         XVI/GXzMSjFajA3jSyq5HCTOM/Xka8Hu+N/gaVvFUebwjsy6yMpdJlkh6xSOJKha40d/
         bWrisySXzrziCK2CAP0GW3hSEry0Y3TL9W+IxBH5f24nhmc71ePRUTxy0KGBtIbaLNcU
         4iJg+EdG9Veg/DiiR4DCWOeDU8nJhhYRx/ujBUUXBZ8We4XRB2Zk1MmHffLZFLPxzxGA
         bFbQ==
X-Gm-Message-State: AOAM531Xg7Xs8dLNKykNwJVVgeKfXGrdCzIzpngg3qZbh0VLeIoaoWFg
        dj/UCOr6/DXweb5SOva6Idf1u1bWmeI=
X-Google-Smtp-Source: ABdhPJwrnWaG2dlOaXoPs46zPnrVdRg0Ksn6ewr3r1ovbynbuYvr79SXjZCFelZk0zsv2dVym3zgbQ==
X-Received: by 2002:adf:f74f:: with SMTP id z15mr6485222wrp.54.1626363638748;
        Thu, 15 Jul 2021 08:40:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z25sm5530128wmf.9.2021.07.15.08.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 08:40:38 -0700 (PDT)
Message-Id: <5903d02324f3275b3aa442bb3ca2602564c543dc.1626363626.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.993.v2.git.1626363626.gitgitgadget@gmail.com>
References: <pull.993.git.1626090419.gitgitgadget@gmail.com>
        <pull.993.v2.git.1626363626.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 15 Jul 2021 15:40:25 +0000
Subject: [PATCH v2 17/17] [GSOC] cat-file: use fast path when using
 default_format
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.email>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

Add the member `default_format` to struct `batch_options`,
when we are using the default format on `git cat-file --batch`,
or `git cat-file --batch-check`, `default_format` will be set,
if we don't use `--textconv` or `--filter`, then we will not call
verify_ref_format(), has_object_file() and format_ref_array_item().
Instead, we get the object data directly through
oid_object_info_extended() and then output the data directly.

By using this fast path, we can reduce some of the extra overhead
when `cat-file --batch` using ref-filter. The running time of
`git cat-file --batch-check` will be similar to before, and the
running time of `git cat-file --batch` will be 9.1% less than before.

Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 builtin/cat-file.c | 79 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 57 insertions(+), 22 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 3a6153e778f..8edc19f2d5a 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -26,6 +26,7 @@ struct batch_options {
 	int all_objects;
 	int unordered;
 	int cmdmode; /* may be 'w' or 'c' for --filters or --textconv */
+	int default_format;
 	struct ref_format format;
 };
 
@@ -196,6 +197,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 
 struct expand_data {
 	struct object_id oid;
+	struct object_info info;
 	const char *rest;
 	int split_on_whitespace;
 };
@@ -216,27 +218,58 @@ static void batch_object_write(const char *obj_name,
 			       struct batch_options *opt,
 			       struct expand_data *data)
 {
-	int ret;
-	struct ref_array_item item = { data->oid, data->rest, opt->cmdmode };
-
-	strbuf_reset(scratch);
-	strbuf_reset(err);
-
-	ret = format_ref_array_item(&item, &opt->format, scratch, err);
-	if (ret < 0)
-		die("%s\n", err->buf);
-	if (ret) {
-		/* ret > 0 means when the object corresponding to oid
-		 * cannot be found in format_ref_array_item(), we only print
-		 * the error message.
-		 */
-		printf("%s\n", err->buf);
+	if (opt->default_format && !opt->cmdmode) {
+		struct strbuf type_name = STRBUF_INIT;
+		unsigned long size;
+		void *content;
+
+		if (opt->print_contents)
+			data->info.contentp = &content;
+
+		data->info.type_name = &type_name;
+		data->info.sizep = &size;
+
+		if (oid_object_info_extended(the_repository, &data->oid, &data->info,
+					     OBJECT_INFO_LOOKUP_REPLACE) < 0) {
+			printf("%s missing\n",
+			       obj_name ? obj_name : oid_to_hex(&data->oid));
+			fflush(stdout);
+			return;
+		}
+
+		fprintf(stdout, "%s %s %"PRIuMAX"\n", oid_to_hex(&data->oid),
+			data->info.type_name->buf,
+			(uintmax_t)*data->info.sizep);
 		fflush(stdout);
+		strbuf_release(&type_name);
+		if (opt->print_contents) {
+			batch_write(opt, content, *data->info.sizep);
+			batch_write(opt, "\n", 1);
+			free(content);
+		}
 	} else {
-		strbuf_addch(scratch, '\n');
-		batch_write(opt, scratch->buf, scratch->len);
+		int ret;
+		struct ref_array_item item = { data->oid, data->rest, opt->cmdmode };
+
+		strbuf_reset(scratch);
+		strbuf_reset(err);
+
+		ret = format_ref_array_item(&item, &opt->format, scratch, err);
+		if (ret < 0)
+			die("%s\n", err->buf);
+		if (ret) {
+			/* ret > 0 means when the object corresponding to oid
+			 * cannot be found in format_ref_array_item(), we only print
+			 * the error message.
+			 */
+			printf("%s\n", err->buf);
+			fflush(stdout);
+		} else {
+			strbuf_addch(scratch, '\n');
+			batch_write(opt, scratch->buf, scratch->len);
+		}
+		free_ref_array_item_value(&item);
 	}
-	free_ref_array_item_value(&item);
 }
 
 static void batch_one_object(const char *obj_name,
@@ -288,7 +321,7 @@ static void batch_one_object(const char *obj_name,
 		return;
 	}
 
-	if (!has_object_file(&data->oid)) {
+	if ((!opt->default_format || opt->cmdmode) && !has_object_file(&data->oid)) {
 		printf("%s missing\n",
 		       obj_name ? obj_name : oid_to_hex(&data->oid));
 		fflush(stdout);
@@ -380,7 +413,7 @@ static int batch_objects(struct batch_options *batch, const struct option *optio
 	if (batch->print_contents)
 		strbuf_addstr(&format, "\n%(raw)");
 	batch->format.format = format.buf;
-	if (verify_ref_format(&batch->format))
+	if ((!batch->default_format || batch->cmdmode) && verify_ref_format(&batch->format))
 		usage_with_options(cat_file_usage, options);
 
 	if (batch->cmdmode || batch->format.use_rest)
@@ -483,7 +516,8 @@ static int batch_option_callback(const struct option *opt,
 	bo->enabled = 1;
 	bo->print_contents = !strcmp(opt->long_name, "batch");
 	bo->format.format = arg;
-
+	if (arg)
+		bo->default_format = 0;
 	return 0;
 }
 
@@ -492,7 +526,8 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 	int opt = 0;
 	const char *exp_type = NULL, *obj_name = NULL;
 	struct batch_options batch = {
-		.format = REF_FORMAT_INIT
+		.format = REF_FORMAT_INIT,
+		.default_format = 1
 	};
 	int unknown_type = 0;
 
-- 
gitgitgadget
