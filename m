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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A120C07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 11:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E258360C3F
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 11:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232991AbhGLLuJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 07:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbhGLLt6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 07:49:58 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C72C0613DD
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 04:47:09 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id p8so25198441wrr.1
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 04:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wxw28PT0y1HD093q1CN4MSHFbLeN7akEybJmased0TU=;
        b=bR5t0U8kfFTuQXlj7u60MZnrmY7WA3DrM9E0RgvTHMCKxT55NYx3jvuVOyYguFXFpG
         WAcvE0YYSRBwVqDH0OoO9vlu+haIQFucgiyrqV4tegKrcz7LBg8imuPJrDVZMLTgoMJV
         nn0e2FoYdKex6XjqbOXgTJ5etzOWJttYor+c8SBpkAoABogexfAzqHFYDBlTGrRMaKml
         eEP7BAVL5Y15mNh915ezDsSp18XS4OvRQwZo+ut3rWJ4P4jx3uOFgFD5if8GlK2S6M/G
         XpnOrcgJ2SQkegfgLVnLbBKVdZgGVh+aRS+LlxVVMV0NVLF015IjyY3P49oBIfFnWk11
         WFeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wxw28PT0y1HD093q1CN4MSHFbLeN7akEybJmased0TU=;
        b=oheD+RJiIlI3d0lJOS+S23keUXG4Wp9Bmu6jbtgVdBgIxGtxM29E1+pNU5EuU/Wfxp
         ZcTGf4t6+67DnEGzAoZ7e+UyxeNoCxQzMHXUvQa2JXtTk7i7gKrmW99Gd4a5VsaEDGVL
         1HV2SBVraopY9eca7yZy23Yw00Snu3HoQgpAs97i4g/6o1gfyRVZcuSYDhqRuXhoaTHZ
         QZhHqBOIjrr3n2Ddtr7gPdLQ1a42z4bOPdRWuTWnwfr+VHuDuRpea09/t1fQDnnJvmAZ
         6y9MK8qz5T5bKXFZ1v6w+b5seW5dq0DhVZUoZcXzzbm+ofrf/qIxEO9BMMDXD6bHSCsb
         atMw==
X-Gm-Message-State: AOAM532CEQ+B706xdJLcGzjUBRLG2MZswi3OrKh0QBnFDLxdtMucX3zJ
        wWJYRwkrNV7t2AX6wIwMCdit+6O8vWg=
X-Google-Smtp-Source: ABdhPJy/tglofjRj9L5EZZDGFpNWZFAJNhXGCBAOqaHmWXZX0chql1SbxsAlsBI8jMAHCrZ/L5yLVw==
X-Received: by 2002:adf:f592:: with SMTP id f18mr19601359wro.179.1626090428253;
        Mon, 12 Jul 2021 04:47:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f82sm18437452wmf.25.2021.07.12.04.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 04:47:07 -0700 (PDT)
Message-Id: <43ce6bf26269dc80f87dabb52cbd2af63d24fd69.1626090419.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.993.git.1626090419.gitgitgadget@gmail.com>
References: <pull.993.git.1626090419.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Jul 2021 11:46:53 +0000
Subject: [PATCH 13/19] [GSOC] cat-file: change batch_objects parameter name
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

