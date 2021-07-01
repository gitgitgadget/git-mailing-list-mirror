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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E96BC11F69
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 16:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1662A6141A
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 16:08:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbhGAQLA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 12:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbhGAQKz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 12:10:55 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99B3C0613E1
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 09:08:22 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id u6so8921709wrs.5
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 09:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wxw28PT0y1HD093q1CN4MSHFbLeN7akEybJmased0TU=;
        b=jDfsBzhAT7MOY3zqzIUPXuCVud1GhF0SizlcIoRptg5glIKz74WOk9b6othc+CZG++
         i6F8S9ugzLBbBZX4JHNprW4aod43r59afMMC3GklcJ4mZK93Dplw8q/0goISZAEoMBv8
         LvtEYzaST63R+ccPgGpuMxUZOAtYX5E3QKX8wQ9hXVGNlGZSHCD1j6ouDIDlwazL9OvS
         A4Ok6lIoZGvpd5vMn/+nUARYyy3kAZr360BMdx+IQYFl38gK2eKbbKJVFNuMwpt0Z8D8
         BRaWqdLfv9N1Bt6KmB+Wj+nr2DrcKCEtiz1Rxh6PFKtaDLaz0It26FKg20hfvLdjxXFo
         lVtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wxw28PT0y1HD093q1CN4MSHFbLeN7akEybJmased0TU=;
        b=BWg9qOz9M08p/wumvnKGVg10OLdz7s7ntAgQJT2o+na9Vw29Lo4jLKZf+jXCKa+bjq
         4LzybTWf7ZzxqdwQCm7SnEPivnVefHoD7cQz5z7qKkww+NBzwfwpR3eX8KLZhevd/HvK
         BZs4vYG+2OCp4iRKMk78WMBZ7u420Q/dhoIO2dP9A4Nq9gxoQalxuqLR6PWDf9IOYgFQ
         LPunY11VhqhyusNsjHAgaaBSJRnRojjGo+lzB7FbYz+tM+7SmJXNxiCJ5DgxTxPSKaHj
         02QwYYUFlhx7u23DSw8UltYq9Vex0FnKJCWh5bYT9OSQECXGLHjB9Qt0KIr3oezJPxuI
         kBZg==
X-Gm-Message-State: AOAM532ROrNcmeeCmHtD+ZCdN+Tynv923trgLOk6/HcA1Fcx9y0NHcrR
        mLQoKYri03bR/p6XjTXmjm/2or0WM80=
X-Google-Smtp-Source: ABdhPJy5ou4u3U2SJaU+9Zc8zMWMG1wja2zweahTSsW2uUzgajYtQ/gXrhz9fYq0x6+R3eHPUPeNgg==
X-Received: by 2002:adf:cd8e:: with SMTP id q14mr522457wrj.192.1625155701603;
        Thu, 01 Jul 2021 09:08:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e8sm427232wrq.10.2021.07.01.09.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 09:08:21 -0700 (PDT)
Message-Id: <0bef02ce5a465a3c968b975a9ba75afb335e6a53.1625155693.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.989.git.1625155693.gitgitgadget@gmail.com>
References: <pull.989.git.1625155693.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Jul 2021 16:08:09 +0000
Subject: [PATCH 11/15] [GSOC] cat-file: change batch_objects parameter name
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
        <avarab@gmail.com>, ZheNing Hu <adlternative@gmail.com>,
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

