Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF02BC4320E
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 08:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCB5C610CC
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 08:23:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238796AbhHMIX5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 04:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238535AbhHMIXq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 04:23:46 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB9CC061756
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 01:23:20 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id w21-20020a7bc1150000b02902e69ba66ce6so6380186wmi.1
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 01:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wxw28PT0y1HD093q1CN4MSHFbLeN7akEybJmased0TU=;
        b=EKaLUUdqnVXOsrl6190CvEWcqcGBsvlmRGaBvFR4OqRZJi8V97Oo+H25C67I6DLoQ9
         iMciaW/YWZwFFiCK3N5Hj+go7R80sMeLhoN+C5H6QupyHyiShUyId3uDIK7rAQLwzJaB
         iN4pyjvSLeQPfbKrpkAauxjQR4yNfD1mibcY4JNRI+grFS8f3KWOH9GZpny8XdSa7kQf
         TZoBSUiJ+z7k+S2x6HsLgbsDA3+wDqd9pwsU2XI3yA9JsES9GpYlOXjRvw5oxvaPJsN/
         ozo1zeMFzSDiMQfdXZwDh8VfBgMLpLxM2fLS5nnaTI6gxCgRfvFJ5WpbjuESwZhhd9Bn
         /tIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wxw28PT0y1HD093q1CN4MSHFbLeN7akEybJmased0TU=;
        b=ZZTWYFlDaDPCUhw4fFhmevX85fGc8Fs6J7uZOYTP5iFb/AEj71cwb2yRJ7WkT7Bbgr
         FDcVWFB9zH9VyHzbN7gjYH9LPU28nYKPMBqwVqcE6CQgfew5Kd3tVLf1GqPPFbPp86zN
         qQzyB8syK06RefdPKxBRg5e0ySXmY6NivtztaHXWP28yTbqm3KXAJ3Dr5jqvf/fD+dvi
         hl28Znfqm4us5OoOO1kWp14rNLHFOanR++pgRTAmx40rDMctpb3PFQaBVVfk5U4UPl83
         sJ5/p1YtRanEIiU2pUoDm7cmXxIwZPXB4RXJ+BFdcHFtOO4X/U8CrA2JjcQwS5PidpUP
         0sTQ==
X-Gm-Message-State: AOAM530TCP64t1ibsPZ5/jNe73NYgsro35DgZy2S/uZCCDaD08zgTTN7
        o/9P8rAZMWWBf0n0VLd8R4UrAdbFlPM=
X-Google-Smtp-Source: ABdhPJxD0woBmo7VVJuVNtK4XSfbFInjArh6UfyuX4f6aCwFOzVZy2taf4oh5epkmHFcFkAr91HBrg==
X-Received: by 2002:a05:600c:2290:: with SMTP id 16mr1459893wmf.26.1628842998795;
        Fri, 13 Aug 2021 01:23:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y21sm716579wma.38.2021.08.13.01.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 01:23:18 -0700 (PDT)
Message-Id: <a7aaf18357e615ea35f3933d098a11d78495081a.1628842990.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1016.git.1628842990.gitgitgadget@gmail.com>
References: <pull.1016.git.1628842990.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 13 Aug 2021 08:22:54 +0000
Subject: [PATCH 11/27] [GSOC] cat-file: change batch_objects parameter name
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

