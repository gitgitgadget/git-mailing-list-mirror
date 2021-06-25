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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E0BC48BC2
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 16:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD0776196E
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 16:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbhFYQFO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Jun 2021 12:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbhFYQE5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jun 2021 12:04:57 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402B5C0617A8
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 09:02:36 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id a13so11113984wrf.10
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 09:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HluKIvI8PnxXFef46ukO9OSyoyTW6LZ2nDr1+/IAdRM=;
        b=Em1zyPS711Qc3kizOFYQTEUbvN3BQrXnD/02o4FVTL1cPF0W5ogvgQeNsYyCiSpQCT
         yB1OdGl/pVwoSD0JwLiUVFRFBPV/uheIeoP3lkM61MHJar1rLyRYtMjaQFLcj3GRt6zD
         hEtwCcexLuc5nkh1F8OwD8tXEPnlNrlk9LGWVKhlCqBwo3P4voBjp9K0f9aoGwnFV0Iz
         uz5+1+YX0LihGiTKtKOrXPnNy+svaVK4de8eZ5g0DX/IZBmlMayQQ94tEGhJD/SuyjoB
         onxzyxtWXQ43YSjrNjUk6ab8IOAP/tNNa7zgcJ+thwqNK5OXOOGDwSDdNmUwxpUN/8rh
         gWnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HluKIvI8PnxXFef46ukO9OSyoyTW6LZ2nDr1+/IAdRM=;
        b=uNqzwsPnIvMY6R8Qf/FcuOrnpiTX5buVQPubDUT54gmPphu23uQD5u/3MfgudPGQcQ
         BPWRviy4OPCjD2D1ENlCfc1VOyBnCfkGbKk4e2UfcBIMaUjDQr94O3GDfRGL6QyJAsox
         DgbJ0/qTDT7yquZfmilkyr3JC8geOE+bT0Ptee8VoxJjCIFq7nmr91jDxfwJlIyEEgDY
         J8Ifhx5N/VHUPb2oFC4Pwr6uP2TPDlEIgInWy+QOGYTIO+H9R1gsBC9NrwJdS5t3CqeO
         VK3tasEhu2sY/Ztwf5jcYgQ+cHac1jJSkq7zbqBgvqsmyzzUx2J5pq4OeyokrUx/bYfg
         6bIw==
X-Gm-Message-State: AOAM530HCzRZ6sX9NVhRhoNnre3geNVNRSp8LcpbMtshfKUPz9B2QLMX
        CP3rwHXL9CFxb7bEhRkm/qPdMpPPFOI=
X-Google-Smtp-Source: ABdhPJzsPMZGacx/ocsSWVJ/ZD42urhs6VG5oXbvB0a+xpLi/37k9PIYmBOF7mX+HDPbtWC0HNtcKw==
X-Received: by 2002:adf:bd84:: with SMTP id l4mr12035279wrh.346.1624636954693;
        Fri, 25 Jun 2021 09:02:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r1sm11720842wmn.10.2021.06.25.09.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 09:02:34 -0700 (PDT)
Message-Id: <bf5c0a017ad28c587e6d54304202a17d2bc0f1fd.1624636945.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.980.v5.git.1624636945.gitgitgadget@gmail.com>
References: <pull.980.v4.git.1624332054.gitgitgadget@gmail.com>
        <pull.980.v5.git.1624636945.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Jun 2021 16:02:21 +0000
Subject: [PATCH v5 11/15] [GSOC] cat-file: change batch_objects parameter name
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

