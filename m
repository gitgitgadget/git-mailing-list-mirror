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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C0D7C432BE
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 08:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66EA06056B
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 08:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238840AbhHMIYC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 04:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238621AbhHMIXs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 04:23:48 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDC2C0617AF
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 01:23:22 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id l34-20020a05600c1d22b02902573c214807so9080134wms.2
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 01:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GGTmZhBe5osAznIE5fPt/loNnyl3SsJoiQDMpWQZxU0=;
        b=vHiHahJYDljiS0V5PNpxPU0zQePkrP4ISBIRTtxFB4CF7bf/6DyH25jr1PbEGoH1Ft
         ch2PYDFcqBza9gFkwanhYUO3Uj5kvNsIKLriZlA/JbzJXHRHt+GCEfy1y/l6B8uZ9zgl
         VJMu6tiqLm0ak4yUSzZklOXk5013fE6nsQwvLf01+x2+O/nS4Fg3ApZLVNz+Nrder8tb
         IPIPODceXowZeET2RPBO2jLjTQF6pqbkxKosYlsgdcHNY5Q7o7qskEosTeu9hfzPFNbW
         YZlY+XgTPBebECWjSUoF0ujd7aIIfqPQFTFl8XFMrv/4wytZPWEQI0XZ29hGJueLfJ6u
         iEVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GGTmZhBe5osAznIE5fPt/loNnyl3SsJoiQDMpWQZxU0=;
        b=tlzyas0aqewtUKqIJJDM4yVEiMOSsCyGDaABUGnz4wDfXxK1MpJwf7dRmkZI0U5Pw0
         kxdyE/OBIZRrml7vSuqj0zdHXiKhbEf4qC43Yn7hHy+3pAsiQwCbF2rxfYWIe/QBBRsW
         EqiBgGwPWB88jFZJfWxfavgrLOpLK7eBheZIKX/onMuthKCtFMjUhX1E9T81+HUnuPvn
         tBNJm72uPWgvuW6lXUYEHCiM5Mi2y67sGcG3iDaR8yI0Tbpb6OOL0lreuy/Osx+edImf
         nj2X3UqdHd3ohX3UfeAbvs8UxymDPnENeR8/oJF+fNpbWNexNxxcGmmOVqpu87Q1ov9B
         S4LA==
X-Gm-Message-State: AOAM5305nOvrjIRfLge/kn3Ts9a3AWCjYAfXvR9ReOPxYZaUN78D1m4E
        nMB/xx829WvsWdaSkgXC2p8iShJpQqU=
X-Google-Smtp-Source: ABdhPJznrAm2KoZW4MMog/F4EdxJiTYE+LmaHj6TsgPh5fAYEXuAz0KJaiYl7OCmn0GxGO/8AQsx3g==
X-Received: by 2002:a05:600c:2147:: with SMTP id v7mr1406891wml.124.1628843000767;
        Fri, 13 Aug 2021 01:23:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z5sm678596wmp.26.2021.08.13.01.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 01:23:20 -0700 (PDT)
Message-Id: <69493864d535941d31a41c145eb594fe38ea361d.1628842990.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1016.git.1628842990.gitgitgadget@gmail.com>
References: <pull.1016.git.1628842990.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 13 Aug 2021 08:22:57 +0000
Subject: [PATCH 14/27] [GSOC] cat-file: reuse err buf in batch_object_write()
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

Reuse the `err` buffer in batch_object_write(), as the
buffer `scratch` does. This will reduce the overhead
of multiple allocations of memory of the err buffer.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 builtin/cat-file.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 306b4d49493..034094dc640 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -212,35 +212,36 @@ static void batch_write(struct batch_options *opt, const void *data, int len)
 
 static void batch_object_write(const char *obj_name,
 			       struct strbuf *scratch,
+			       struct strbuf *err,
 			       struct batch_options *opt,
 			       struct expand_data *data)
 {
 	int ret;
-	struct strbuf err = STRBUF_INIT;
 	struct ref_array_item item = { data->oid, data->rest };
 
 	strbuf_reset(scratch);
+	strbuf_reset(err);
 
-	ret = format_ref_array_item(&item, &opt->format, scratch, &err);
+	ret = format_ref_array_item(&item, &opt->format, scratch, err);
 	if (ret < 0)
-		die("%s\n", err.buf);
+		die("%s\n", err->buf);
 	if (ret) {
 		/* ret > 0 means when the object corresponding to oid
 		 * cannot be found in format_ref_array_item(), we only print
 		 * the error message.
 		 */
-		printf("%s\n", err.buf);
+		printf("%s\n", err->buf);
 		fflush(stdout);
 	} else {
 		strbuf_addch(scratch, '\n');
 		batch_write(opt, scratch->buf, scratch->len);
 	}
 	free_ref_array_item_value(&item);
-	strbuf_release(&err);
 }
 
 static void batch_one_object(const char *obj_name,
 			     struct strbuf *scratch,
+			     struct strbuf *err,
 			     struct batch_options *opt,
 			     struct expand_data *data)
 {
@@ -294,7 +295,7 @@ static void batch_one_object(const char *obj_name,
 		return;
 	}
 
-	batch_object_write(obj_name, scratch, opt, data);
+	batch_object_write(obj_name, scratch, err, opt, data);
 }
 
 struct object_cb_data {
@@ -302,13 +303,14 @@ struct object_cb_data {
 	struct expand_data *expand;
 	struct oidset *seen;
 	struct strbuf *scratch;
+	struct strbuf *err;
 };
 
 static int batch_object_cb(const struct object_id *oid, void *vdata)
 {
 	struct object_cb_data *data = vdata;
 	oidcpy(&data->expand->oid, oid);
-	batch_object_write(NULL, data->scratch, data->opt, data->expand);
+	batch_object_write(NULL, data->scratch, data->err, data->opt, data->expand);
 	return 0;
 }
 
@@ -364,6 +366,7 @@ static int batch_objects(struct batch_options *batch, const struct option *optio
 {
 	struct strbuf input = STRBUF_INIT;
 	struct strbuf output = STRBUF_INIT;
+	struct strbuf err = STRBUF_INIT;
 	struct strbuf format = STRBUF_INIT;
 	struct expand_data data;
 	int save_warning;
@@ -392,6 +395,7 @@ static int batch_objects(struct batch_options *batch, const struct option *optio
 		cb.opt = batch;
 		cb.expand = &data;
 		cb.scratch = &output;
+		cb.err = &err;
 
 		if (batch->unordered) {
 			struct oidset seen = OIDSET_INIT;
@@ -416,6 +420,7 @@ static int batch_objects(struct batch_options *batch, const struct option *optio
 		strbuf_release(&format);
 		strbuf_release(&output);
 		free_global_resource();
+		strbuf_release(&err);
 		return 0;
 	}
 
@@ -444,13 +449,14 @@ static int batch_objects(struct batch_options *batch, const struct option *optio
 			data.rest = p;
 		}
 
-		batch_one_object(input.buf, &output, batch, &data);
+		batch_one_object(input.buf, &output, &err, batch, &data);
 	}
 
 	strbuf_release(&format);
 	strbuf_release(&input);
 	strbuf_release(&output);
 	free_global_resource();
+	strbuf_release(&err);
 	warn_on_object_refname_ambiguity = save_warning;
 	return retval;
 }
-- 
gitgitgadget

