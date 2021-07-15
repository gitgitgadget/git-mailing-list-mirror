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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A98D8C47E4D
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 15:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91A6461396
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 15:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239415AbhGOPnj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 11:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239191AbhGOPnc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 11:43:32 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50614C061766
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 08:40:38 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id t5so8347078wrw.12
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 08:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qAwXHcrowoAV1ZvkfF6sVHaTDEdBOu0rUNJ1Ia1vdCk=;
        b=exgEU1v3Lm82T2w4+e1YjUmHDTOUxFPxuEK6G2lmveTeryrKDvbrRRhxJZFf6QFtAJ
         uk+i52lVvuAhZXA5Cn7jGZ+wS6A1+FXfM+j/rM3XHw6/BCgNhaWf33WAMgQOiu4RHCAo
         +5Z/0+ksmNgMcYHDcRtUCzh/f3VGg8bNF2x1n6kEMnS69WCV0kLeuS1LeVn1fzlYZ9fs
         Hu9jUKiHcnTl9sgXM1x6GsJvk17L48nSCMbjCUl4RiRVAT9+2PY4JFhFxM3G66fPjZVB
         xdoR+4vb+m/O+MBqnnDBWSiUIisbp9iBkuM9bVeycszq7x+NCzw2ELTX7XAc6sj2Dvb3
         6Fzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qAwXHcrowoAV1ZvkfF6sVHaTDEdBOu0rUNJ1Ia1vdCk=;
        b=tpX+d2+VcAXNqMyZraedhqQ28U4pTh+ayxZS8BfsZsaNL7WRSwqrlSmYK++rEZFYx2
         9h9OsFZW5BlUn6j8bg71ncGZYSaUsVEn51gMVoB2qp2D+dG3tnSvf2AlpEsvgzlFKCsT
         wI4ezgRSY+0bYzD/9/VbdmIibbF0LSVdARy1c7XWqDpqk1vrHjWHKdIm8/eZng4l42i8
         vpnqLn6tRWeT88HaDnHAc6m74B0bVQPSRHqMKOk063Dm/Zd35yhpN1XZAiiqg77wrVqA
         Z5aNqVfrlD0itG15tCSjl9esLNtQgP4dsxbecvV055FpzGdofFQpvMKDv3HRmysSmXh8
         9UCw==
X-Gm-Message-State: AOAM532ez6DT9hiCybSAt3fZMCYmPYXc7DtjLowT6N8fMPPOdiPwhgkz
        ZI/vmLw+fmsvQfM2XF/X6+7jHbkHL4Y=
X-Google-Smtp-Source: ABdhPJyK4wVW2N7svnSpeqp9JLkNq8hwUVTbrGjIgKQ5Y+4z6cjlRzlDIPUf/xdqOK+5ODTm+WTa2A==
X-Received: by 2002:adf:f60a:: with SMTP id t10mr6213920wrp.127.1626363636987;
        Thu, 15 Jul 2021 08:40:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f11sm387615wmb.14.2021.07.15.08.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 08:40:36 -0700 (PDT)
Message-Id: <fd3901dfee6bc4046a83011ab74ad6292dfe3e85.1626363626.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.993.v2.git.1626363626.gitgitgadget@gmail.com>
References: <pull.993.git.1626090419.gitgitgadget@gmail.com>
        <pull.993.v2.git.1626363626.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 15 Jul 2021 15:40:22 +0000
Subject: [PATCH v2 14/17] [GSOC] cat-file: reuse err buf in
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
index 5b163551fc6..dc604a9879d 100644
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

