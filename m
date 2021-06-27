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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA49C49EA6
	for <git@archiver.kernel.org>; Sun, 27 Jun 2021 12:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37F9661AC0
	for <git@archiver.kernel.org>; Sun, 27 Jun 2021 12:36:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbhF0Mih (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Jun 2021 08:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbhF0MiZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jun 2021 08:38:25 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1553C061787
        for <git@vger.kernel.org>; Sun, 27 Jun 2021 05:36:01 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id l8so8264906wry.13
        for <git@vger.kernel.org>; Sun, 27 Jun 2021 05:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qAwXHcrowoAV1ZvkfF6sVHaTDEdBOu0rUNJ1Ia1vdCk=;
        b=dI9RkV6mSJDCdw0XhOrkE/LHrUbcpcaX28hKfrQ7K02xX+fbhp58WEW8n+aZ6+URIZ
         ink1IG1/JAgglIC0U/4gBd4bzOcijDDUd/dhlel+IxdDfy+nLx+kdSjQYpdDlrpeQEVY
         IM3Z+4w922VRzbur5t7LDcvSAmWfr0rJTenIjzJ4hgIB1LCyqKX/vMxBcE8Jl7pcNkBK
         +HqO8gQN8YC6dnbm6G/3ffXBZN8JQ2KfenDDgIRa8cc8QWdPsazifvfIH2oNFuLn8OmO
         vH/qsmMD/B8T+BFEOsVMRza0HhlG2tq30Tb52jMZHlrd003/yr6zDGGIKq9Kx9hVdiVH
         LaCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qAwXHcrowoAV1ZvkfF6sVHaTDEdBOu0rUNJ1Ia1vdCk=;
        b=hRJNI6taSwauvgVgDtFoEU0lMOczOgJmQEgxapk0Ud54DC4/0705AeFun0vWUFs+2h
         Bfc2qKUI7EXS8ExG4GURAaViaxF1rUpF7/0sixWRP6KLfJA8CW9+N0Yfv1ANetJ0/AFT
         z9whPVWpxmVuevLHRGDVScHExYXcf+UUbGvkp47lTpqZ9HvuGYYeY0x4EL/AFha5O6xU
         Po6MigWwNeZ6Jx/VFE+oBaVcF8YPC4bZK2PJhBnSDApwYwmBrYr6TUudHQhNZcxk5DjE
         6k0VguaxLIjCQFKq5Hf4pq92fZ95MDH6pbMFrfa9hyGIBOhK6VjXXOjxDCrsryvzXBXz
         vyQg==
X-Gm-Message-State: AOAM530v1/mwkEzadM1XAjcc7u7LzTG1dGRU3G5S5t6+NSNcEcn2Oa8N
        o+OhxDVACFiWXGntUQm7LgftWcy4Hwo=
X-Google-Smtp-Source: ABdhPJx41L9fbecSDHgHsm+RXRQMzf/InZE73YhnkaM6hBV1I3wwwz7FQ41MROszkq3xU2rYawaGeg==
X-Received: by 2002:a5d:4b88:: with SMTP id b8mr21610129wrt.95.1624797360296;
        Sun, 27 Jun 2021 05:36:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u18sm7289541wrt.76.2021.06.27.05.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jun 2021 05:36:00 -0700 (PDT)
Message-Id: <3fb47584924522e0bb32f667bb215b7d3223015f.1624797351.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.980.v6.git.1624797350.gitgitgadget@gmail.com>
References: <pull.980.v5.git.1624636945.gitgitgadget@gmail.com>
        <pull.980.v6.git.1624797350.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 27 Jun 2021 12:35:48 +0000
Subject: [PATCH v6 13/15] [GSOC] cat-file: reuse err buf in
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

