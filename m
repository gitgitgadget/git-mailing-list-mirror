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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2181C49EA7
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 16:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4D6961976
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 16:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbhFYQFQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Jun 2021 12:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbhFYQE6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jun 2021 12:04:58 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53884C061766
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 09:02:37 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id b3so11126520wrm.6
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 09:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+bsFc6e3DqMp3rf/hPSj63ldu2+jiHin07ZYcR5fSM4=;
        b=GcazcYlxL8Z7B/kN73dn3MW0kgOkxj+sl6DKeOH6UAWS2mFkdmSTg1D/Ba6vVAyVMa
         ipy8MZ5hKUAs3R6MHsOyqIL1wz83Y7p4Mug0ki67H8gFx/lVzzA2dETzeJwngDztIxvC
         tvl2Mg7I3O+sNeSOfn/OKmg9QOy0zMaXeZSVFA5nxIRZ8U2Nixj5tHmAtn2U9BIspGLB
         Xm4xAllfTRucPvH2ezbgVQeACOD5AZt+QDNrOlaCiRB1xvU+bPyMzYUcRrj7/e9Jpprp
         5DW/lB7CqFNqjmDxkw3IDtAjdG32avSpShAT1X+0YKODKluvKRpxFKwFpzSMmib6MHiQ
         h7Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+bsFc6e3DqMp3rf/hPSj63ldu2+jiHin07ZYcR5fSM4=;
        b=dZLsr65KC1viBnABNRYR/252A/aACfTC7t6fJFTyK/Fon8UXdqjC9M44zRyBQXTUJ3
         xcmFlm52uR3mQkGXiA/GQF7Rtzqlo6/zHWZ4eWbrh8foK619Ct8FNpMfwhY50Sj82kfV
         FjF8hFft10Yth6VF2Xv0dyY7DsnjtJg6gEGTFBkA48pM3TWujLX+oxSGYIrYZMGTNxm3
         vYWtvIKtHfNv8csdPDnl0FJnKpXs8Wg6PkzlQ2YDkn6q7Iym9mQ7w5UwkRr6Snc3fcTl
         7dEW1fuMngF5qub5Dd+TEurorbJIy2pqUTMbFdKUWwQycVCSf8J8r7t2hxZOKdP6srn4
         /WwA==
X-Gm-Message-State: AOAM533YQi4LRChk6zUgTT+RewNTw/ZzZVTurWLL5nzqpgAc93K4R5d6
        VcV8eWoWJ0oeHdrx9oc9RagjpdsoHcA=
X-Google-Smtp-Source: ABdhPJy42mqtiQ60MY/eTl5jpqhnVLLcPwZvf0Uyxb+QT0le2avfEpSnhZBjbTvh71KLIdmhTc+XzQ==
X-Received: by 2002:a5d:6d8b:: with SMTP id l11mr11786633wrs.21.1624636956033;
        Fri, 25 Jun 2021 09:02:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o203sm6786252wmo.36.2021.06.25.09.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 09:02:35 -0700 (PDT)
Message-Id: <69eef47065d27cc997a26c853691534c5d84df6d.1624636945.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.980.v5.git.1624636945.gitgitgadget@gmail.com>
References: <pull.980.v4.git.1624332054.gitgitgadget@gmail.com>
        <pull.980.v5.git.1624636945.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Jun 2021 16:02:23 +0000
Subject: [PATCH v5 13/15] [GSOC] cat-file: reuse err buf in
 batch_object_write()
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
index 0e7ad038e5f..27403326e7a 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -212,35 +212,36 @@ static void batch_write(struct batch_options *opt, const void *data, int len)
 
 static void batch_object_write(const char *obj_name,
 			       struct strbuf *scratch,
+			       struct strbuf *err,
 			       struct batch_options *opt,
 			       struct expand_data *data)
 {
 	int ret = 0;
-	struct strbuf err = STRBUF_INIT;
 	struct ref_array_item item = { data->oid, data->rest };
 
 	strbuf_reset(scratch);
+	strbuf_reset(err);
 
-	ret = format_ref_array_item(&item, &opt->format, scratch, &err);
+	ret = format_ref_array_item(&item, &opt->format, scratch, err);
 	if (ret < 0) {
-		die("%s\n", err.buf);
+		die("%s\n", err->buf);
 	} if (ret) {
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
+		strbuf_release(&err);
 		return 0;
 	}
 
@@ -444,12 +449,13 @@ static int batch_objects(struct batch_options *batch, const struct option *optio
 			data.rest = p;
 		}
 
-		batch_one_object(input.buf, &output, batch, &data);
+		batch_one_object(input.buf, &output, &err, batch, &data);
 	}
 
 	strbuf_release(&format);
 	strbuf_release(&input);
 	strbuf_release(&output);
+	strbuf_release(&err);
 	warn_on_object_refname_ambiguity = save_warning;
 	return retval;
 }
-- 
gitgitgadget

