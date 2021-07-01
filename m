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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 150A7C11F69
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 16:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F305C6141C
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 16:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbhGAQLE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 12:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbhGAQKz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 12:10:55 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B75C0613E6
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 09:08:24 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id m9-20020a05600c3b09b02901f246b43bbeso4449000wms.3
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 09:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qAwXHcrowoAV1ZvkfF6sVHaTDEdBOu0rUNJ1Ia1vdCk=;
        b=eYIkyQjpOY4J9gAbXBd68LkxGM2pDVg1a+NKfI406M+HB9vAxfkkAHjAnlGMtKQ5Xz
         kOGZzyccJ4zxxJaMfFguEvBdr9LzGLvuXRoinjK70qb82n4C89py2y9cVV7IZGy4lNhQ
         yoeDKC8d/Ua0A7ziSCteihqojOn9PhpdAgLEIdsTFRFUIWZozKWgbTJex+8B9tVLO0wY
         C7zRgQXKHlpbFo8kTWGT70MqHmWqMlNy4s7HnFfPWwsedxhAOvuLkN1vLavi3URtyvC6
         YqpSF5AAzSyyCZf5C04Zk6R/JdsroH08eSedsK66+jkpSv3a56nMUWrgmD1QrqdjNpu+
         Df5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qAwXHcrowoAV1ZvkfF6sVHaTDEdBOu0rUNJ1Ia1vdCk=;
        b=RdYUuy7++xg6GT6yX3H4kz6Ni/Ho0Wq1IbAgSCqk4NgpxVsjGNOvMyjoMOkArx/Ydv
         SpxK99rdH/kZ5xEy4rWq1jVR9crDEDdMvd/1LjrpeFuQJboU7F5N/98M22dnnrGooEfw
         WVEa5PE9sT2W4ipiXOlPfIhRpmQbjJVi4pnNEo+MV7ylQYGFr/vyGINMoC4IJGEsfL56
         G7IlB7TQBBpkwbUQf/nR3eOJrhvZEjbbZzRhthu2xwi/beI6pkB82FPVZMbJlBZaF3ZE
         td/XAOL4VDINdEWeSYfZpw7WxHFA8TUQtFDQFATG4dPX26ll/zeERlPi7whMDhRCMPPq
         nt3A==
X-Gm-Message-State: AOAM532xTv4vAeQEJvCqarpl+2GEHH1ggKZaFh1DyfdVmk2k8rWFqyua
        NcIqkgSD1sNXQEfatdLPglxYDGGyJmQ=
X-Google-Smtp-Source: ABdhPJwdtwl8h9BZ26UEdUv/03Mvz0PNeLvs1L7rJsgJJ8brgPHz4+Zm+p6CNJyZj4lPVNyZpCxezA==
X-Received: by 2002:a05:600c:190a:: with SMTP id j10mr11602886wmq.44.1625155702815;
        Thu, 01 Jul 2021 09:08:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t9sm464463wmq.14.2021.07.01.09.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 09:08:22 -0700 (PDT)
Message-Id: <86e4620663e012b12abfc6b0850c4611f607d2b9.1625155693.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.989.git.1625155693.gitgitgadget@gmail.com>
References: <pull.989.git.1625155693.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Jul 2021 16:08:11 +0000
Subject: [PATCH 13/15] [GSOC] cat-file: reuse err buf in batch_object_write()
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

