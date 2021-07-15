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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43CE3C1B08C
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 15:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3134061374
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 15:40:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239289AbhGOPne (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 11:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239190AbhGOPna (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 11:43:30 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7715CC061765
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 08:40:36 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id b14-20020a1c1b0e0000b02901fc3a62af78so6325860wmb.3
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 08:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wxw28PT0y1HD093q1CN4MSHFbLeN7akEybJmased0TU=;
        b=n/S9bfuPkifb98E/49SW6byugHahOxjzfXEzebfN6ZFFtHkbPhO7AzCqtdvOZ4xi8W
         NMY2HZgC8bbmcTJ4ttbveUaKJVvtrW2LwP6iZDsplTFmBLmF1yG7P4w09PWUDb+TBylR
         t4jdobny1zVVYw/mkQDhkACwcDtCKB8r56frdK2yKxDcBqGJpEDZmqEmGtyVm8Ety9B6
         cskciW1mG/78qgt+K06zD5yDVqEMK6tlAgNJychIxwkn/a2l7OYlJiOX/aTxPLKS3TKL
         qjC2Fdj8EPOvYJIrFhaLSc2aErkRmvjQUtPZd5+x4Wkeyb/KCJIqCNLuDSAjaqdA3kjH
         cYMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wxw28PT0y1HD093q1CN4MSHFbLeN7akEybJmased0TU=;
        b=OSBdj4KVHyKjVgHDclH+SNmiWcl3RpMQPUoGTZHO1nRHx0lPDxB1XxmW7yThNH75BG
         +iVQY7IAW1/jww0KiQsnWIBjVqyjZXlsTDZWBPmRRIqFm4MDYjlpDjyUjbwvWJ4ra5AX
         yck0yg/TDINxWkJLuMsxB89rFzpeii7PBOPiix/5H5yoBrTRPc5YzQ5TnRezxVOnPXKh
         LcjLpnYhidVx3G9fcgNnscHNHSxhC3f30azLEb1+TKwRQmPqDuM62qbWuWdTCqkcYj6P
         njoP1O+M9Y2IorZ1ACiGUbP4UaQ9cYPceWwckQDJUzeUE6XSL9+AGNv1USC4lqMcSL4/
         Mluw==
X-Gm-Message-State: AOAM53175CCr9zN5P3CE7Z5MLrkM+yeJzYfTufaxdC30BVuKwU3Xfamd
        OqnUHq15LtkJLzOW+O1sXFngMvMPd4M=
X-Google-Smtp-Source: ABdhPJzVRE1VRd7yWzboNpOdhzbf2pNHWmCTs84C2/abmFj+9H5133IMbkXbrbmlUHGqJpfoxlhA+A==
X-Received: by 2002:a05:600c:4e92:: with SMTP id f18mr11246062wmq.62.1626363635032;
        Thu, 15 Jul 2021 08:40:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p16sm7108171wrs.52.2021.07.15.08.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 08:40:34 -0700 (PDT)
Message-Id: <c445fa6520b296673b5e559dfb4d1c678e722b0d.1626363626.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.993.v2.git.1626363626.gitgitgadget@gmail.com>
References: <pull.993.git.1626090419.gitgitgadget@gmail.com>
        <pull.993.v2.git.1626363626.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 15 Jul 2021 15:40:19 +0000
Subject: [PATCH v2 11/17] [GSOC] cat-file: change batch_objects parameter name
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
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

Because later cat-file reuses ref-filter logic that will add
parameter "const struct option *options" to batch_objects(),
the two synonymous parameters of "opt" and "options" may
confuse readers, so change batch_options parameter of
batch_objects() from "opt" to "batch".

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 builtin/cat-file.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 59a86412fd0..41d407638d5 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -495,7 +495,7 @@ static int batch_unordered_packed(const struct object_id *oid,
 	return batch_unordered_object(oid, data);
 }
 
-static int batch_objects(struct batch_options *opt)
+static int batch_objects(struct batch_options *batch)
 {
 	struct strbuf input = STRBUF_INIT;
 	struct strbuf output = STRBUF_INIT;
@@ -503,8 +503,8 @@ static int batch_objects(struct batch_options *opt)
 	int save_warning;
 	int retval = 0;
 
-	if (!opt->format)
-		opt->format = "%(objectname) %(objecttype) %(objectsize)";
+	if (!batch->format)
+		batch->format = "%(objectname) %(objecttype) %(objectsize)";
 
 	/*
 	 * Expand once with our special mark_query flag, which will prime the
@@ -513,20 +513,20 @@ static int batch_objects(struct batch_options *opt)
 	 */
 	memset(&data, 0, sizeof(data));
 	data.mark_query = 1;
-	strbuf_expand(&output, opt->format, expand_format, &data);
+	strbuf_expand(&output, batch->format, expand_format, &data);
 	data.mark_query = 0;
 	strbuf_release(&output);
-	if (opt->cmdmode)
+	if (batch->cmdmode)
 		data.split_on_whitespace = 1;
 
 	/*
 	 * If we are printing out the object, then always fill in the type,
 	 * since we will want to decide whether or not to stream.
 	 */
-	if (opt->print_contents)
+	if (batch->print_contents)
 		data.info.typep = &data.type;
 
-	if (opt->all_objects) {
+	if (batch->all_objects) {
 		struct object_cb_data cb;
 		struct object_info empty = OBJECT_INFO_INIT;
 
@@ -536,11 +536,11 @@ static int batch_objects(struct batch_options *opt)
 		if (has_promisor_remote())
 			warning("This repository uses promisor remotes. Some objects may not be loaded.");
 
-		cb.opt = opt;
+		cb.opt = batch;
 		cb.expand = &data;
 		cb.scratch = &output;
 
-		if (opt->unordered) {
+		if (batch->unordered) {
 			struct oidset seen = OIDSET_INIT;
 
 			cb.seen = &seen;
@@ -590,7 +590,7 @@ static int batch_objects(struct batch_options *opt)
 			data.rest = p;
 		}
 
-		batch_one_object(input.buf, &output, opt, &data);
+		batch_one_object(input.buf, &output, batch, &data);
 	}
 
 	strbuf_release(&input);
-- 
gitgitgadget

