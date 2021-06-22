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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F21C2B9F4
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 03:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56CBB6120D
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 03:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbhFVDXc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 23:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbhFVDXU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 23:23:20 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0608C06175F
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 20:21:03 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id j1so4619860wrn.9
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 20:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bPs2ZTkKuIloxbLgDbfmgVnjMKKTEk/kD+fB5CyaL+Q=;
        b=em6ICg2zQA52AjIfgY4gazxWyjKInF/b9BTz+gSb68RRUQvheQBtupHDCRhK5urImU
         HY/L7BSpjx6nIxpmaDMtiatRBHjBJHR/cMsma2yWeqh4GPjSPAhIHjrq/qwS7VjJdExz
         MccT49R9g1LCHEKSyKAFVQGLChgtLNVhBxAGuXKqzt5rirydtSd5FLQVYY6QrdDjF8UK
         fd60qqgS18xxum7il7e03vYaAbmvUut89yvenG4gCW+v84FfjGSe+BaeEkKIP32s9RMr
         VE0vXIyUL1PN2QqTFKKCkwjnf1Y1LWwp1C5ir+OgoU1F17WhnvYUxyF1a+ex48M8Q0tG
         Nofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bPs2ZTkKuIloxbLgDbfmgVnjMKKTEk/kD+fB5CyaL+Q=;
        b=GUCBKGswOc9x5S4sYSesBF9R0IF4jgrdvNxfJSxttDgi4oUM3EH+v0p3bv4YPUtlI4
         HhMtmaik/Es+Svy83OD+ugpWz9EDa7D6rh53bcaXJJxJaZGpIblaj2NxUB+UYs3IURQ3
         TXzT6dywFj0iyDtjJhTuaAa18sz/8YIIFETys1Kfzy2ZzxpCQcguBdY9DK7CGWvMxtxk
         BeXL6wqfh3hw19ReII1mVefFMNuLaZmWB9qV2HyaaHQcVDsREFkUG48pPpl6eL8UK7fM
         Xe4KypPyr0fpxXhBWJHwJp+yQjUxVwEwlgthOL7PMabh2+xoFfTcH7eNH6np4xw/UUtx
         6GTA==
X-Gm-Message-State: AOAM532m56lH7uFW4qLE4tiP0bhw9tcIw7rWn4+14ItWA7azis2hAd6g
        BYSJ7Ujm1m+uPTwP9axPzVpYkA4YluY=
X-Google-Smtp-Source: ABdhPJy9q/fGafLyqkgaf58hvoiYGUaLiCsZERh+nSrZLo/CPPYbI9pNX4964lfZwD6xWSZE3RI0rw==
X-Received: by 2002:a05:6000:1a41:: with SMTP id t1mr1835133wry.175.1624332062427;
        Mon, 21 Jun 2021 20:21:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p20sm799437wma.19.2021.06.21.20.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 20:21:02 -0700 (PDT)
Message-Id: <069aa203666a4701e22078e9bc35a8c1ff4d5f15.1624332055.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.980.v4.git.1624332054.gitgitgadget@gmail.com>
References: <pull.980.v3.git.1624086181.gitgitgadget@gmail.com>
        <pull.980.v4.git.1624332054.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Jun 2021 03:20:51 +0000
Subject: [PATCH v4 11/14] [GSOC] cat-file: change batch_objects parameter name
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

Since cat-file reuses ref-filter logic later will add the
formal parameter "const struct option *options" to
batch_objects(), the two synonymous parameters of "opt"
and "options" may confuse readers, so change batch_options
parameter of batch_objects() from "opt" to "batch".

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 builtin/cat-file.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 9fd3c04ff20b..cd84c39df968 100644
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

