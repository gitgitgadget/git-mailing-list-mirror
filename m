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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA2DC49EAF
	for <git@archiver.kernel.org>; Sun, 27 Jun 2021 12:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B62CE61C20
	for <git@archiver.kernel.org>; Sun, 27 Jun 2021 12:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbhF0Mif (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Jun 2021 08:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbhF0MiZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jun 2021 08:38:25 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E22BC061767
        for <git@vger.kernel.org>; Sun, 27 Jun 2021 05:36:00 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id l12so16313732wrt.3
        for <git@vger.kernel.org>; Sun, 27 Jun 2021 05:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HluKIvI8PnxXFef46ukO9OSyoyTW6LZ2nDr1+/IAdRM=;
        b=QFpc0NZ1sV2FuClqcA9GbbR/LJjHpuz4t3mF/R19Pw2dLhWSzJLcJmInNzQOy129qR
         oKKB4sBNuwsL/sHUgGDEtJDp9yK/wtTp2l5qqcI3PBFRPuIAQdmu1gBoJ+0VatV2Jdlk
         RtNl99ydNMijRdqlMzZvoHJ5s8wO7Jsg+VV8wFhHbGjTYboIBXaz8c6dUdQUPz7pjyT/
         VmFXamg22GTCEzR+aHpTjg7Poo07F0N5PEEdpgaE8I9mcUrEC1xDmtTkcQeMlhK+Vw09
         IVAIXtatUfz0wfcA7azByzJEahRok0qbNKIpdNr1VSn1OHpGkym3l5dAXq4RzDKKSIKz
         VF+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HluKIvI8PnxXFef46ukO9OSyoyTW6LZ2nDr1+/IAdRM=;
        b=h1HyPFy4sexjtpmohZM65wuhRr6vTMz95VawlR40ENTPHWGlRyPOMyrQ/GA7G7ZfQo
         wSENrVYZU6obWSCoNpf+vD6G5yOH1zmSoBt1pxfkAZxYMMpmOY/qh0577yddkWSDtCYg
         DOUKyhtiBnpxpnA+gSFYdH7xQtP9FOWotmpaPxLvwxNl5ciXgFWMBra2AEFPjuQwUsgo
         jgtUoCKGeMvAX5BLtGQXs7DqF5xZaEMY4kSe9M15bXneYhG8GxICnMsSu9Q0/QZNbNLw
         1kAmNOmZrJo79NjmgKsjBRXJR297EIzl8XogmyfHM6DG3IjPQtWyHvmwZRsZIb9sO7xj
         Ur3w==
X-Gm-Message-State: AOAM5316Dhql2UE6H2C2d9dDJ4ibZDArZGjgH1qvq3iXzWWDtEMMphv9
        zOJpU712sRdcIvx6cF7Oxxg+8aBCFng=
X-Google-Smtp-Source: ABdhPJxx2w0r1lrCruVYuBW0yyhKYAYrzmAmEAYTxjKPQMC7d932xmfgLfQSKIqPSaGvAPceXZUJLw==
X-Received: by 2002:a5d:6d06:: with SMTP id e6mr22874260wrq.28.1624797358980;
        Sun, 27 Jun 2021 05:35:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f2sm1868111wrd.64.2021.06.27.05.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jun 2021 05:35:58 -0700 (PDT)
Message-Id: <32e1ca5638917eca4855bee5a248dc268168465a.1624797351.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.980.v6.git.1624797350.gitgitgadget@gmail.com>
References: <pull.980.v5.git.1624636945.gitgitgadget@gmail.com>
        <pull.980.v6.git.1624797350.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 27 Jun 2021 12:35:46 +0000
Subject: [PATCH v6 11/15] [GSOC] cat-file: change batch_objects parameter name
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
 builtin/cat-file.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 9fd3c04ff20..cd84c39df96 100644
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
@@ -513,13 +513,13 @@ static int batch_objects(struct batch_options *opt)
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
 
-	if (opt->all_objects) {
+	if (batch->all_objects) {
 		struct object_info empty = OBJECT_INFO_INIT;
 		if (!memcmp(&data.info, &empty, sizeof(empty)))
 			data.skip_object_info = 1;
@@ -529,20 +529,20 @@ static int batch_objects(struct batch_options *opt)
 	 * If we are printing out the object, then always fill in the type,
 	 * since we will want to decide whether or not to stream.
 	 */
-	if (opt->print_contents)
+	if (batch->print_contents)
 		data.info.typep = &data.type;
 
-	if (opt->all_objects) {
+	if (batch->all_objects) {
 		struct object_cb_data cb;
 
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
@@ -592,7 +592,7 @@ static int batch_objects(struct batch_options *opt)
 			data.rest = p;
 		}
 
-		batch_one_object(input.buf, &output, opt, &data);
+		batch_one_object(input.buf, &output, batch, &data);
 	}
 
 	strbuf_release(&input);
-- 
gitgitgadget

