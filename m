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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51E6C2B9F4
	for <git@archiver.kernel.org>; Sat, 19 Jun 2021 07:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA5386120A
	for <git@archiver.kernel.org>; Sat, 19 Jun 2021 07:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232949AbhFSHF3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Jun 2021 03:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234080AbhFSHFU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Jun 2021 03:05:20 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A30AC06175F
        for <git@vger.kernel.org>; Sat, 19 Jun 2021 00:03:09 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id e22so9669819wrc.1
        for <git@vger.kernel.org>; Sat, 19 Jun 2021 00:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5YDrUdAqJgTftIEBvWMw8EGvGULve/Lxl/u/1QtAv5A=;
        b=hcSyl6/W6eF126tSjLtY+JPkMrtpSNd/JhK4KZOCv5+yZPx5m6ujEb9o40u3aDPkUF
         So3uOId4CZb2y+auc0viH+nWWX4rixLnGnhjFtsswH+OPWS2BDXXmWyuGrdM82cRqhMx
         ZaKjfMyonyUakqsUI+k+iIxeTFnLrlCjdfLc4Xm/dVKpjaoGv1rlJwMP1CmgC4BucwKD
         p04DhqRL0NY6PQVOMvOrJD3/9HSXIFHr5fj8z7H+YLfy5gEXHYleq/PzxW+98KDUWAH2
         CDmCB99vNjz8NQb1vdxStdD4EDEllclG4DvtxivWYqEDJeugUeBffM6ilczQAdGvZuJ5
         m2kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5YDrUdAqJgTftIEBvWMw8EGvGULve/Lxl/u/1QtAv5A=;
        b=e/tcB/OR6GXE7Mpqouk/RsYwbrHKZozs4z4SafcS6WvYEGy+TmVSWmxwcVzvU2WtC+
         y1ecU/tdNjufB9HuZuAWurTgEUAtTDqD0yixLMX6a7gPpXeCJtj34hnhn/0V9mJGqcdO
         qji5MTHFCkln5mlhpRj6npf2pklwgmS6JL+jirxM7iqdQet4TyPapgwNMxrMEN+7xle7
         ltFgP055J47ghpZpSSz5wEqWLPU9wzWviiZfYzGt6H6lPvjAcwU4OMsCX1scm9+qIorc
         r8ZjBI1zwp8quzzKrblLXMtHO5JGjD1cg29kCIl6s0R7U0BTMYAlYpCyzjhH45pkuGx3
         Eofw==
X-Gm-Message-State: AOAM5333xlvHiSrl1nKXXvN/jOEdBnSPPCqGwmtGXNhH5QoDPf633Ghr
        WhyEvVsjMRIHpfhSBwGhIvz43PA/O+E=
X-Google-Smtp-Source: ABdhPJzlTLwhiz6zijH1jrpsca2pBEB89cvE3XMo0P4FC9iFga+N1fkd5bHsm0Tmzvp1SL5U/8gI7g==
X-Received: by 2002:a5d:47ce:: with SMTP id o14mr16045254wrc.273.1624086188272;
        Sat, 19 Jun 2021 00:03:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f12sm12885705wru.81.2021.06.19.00.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jun 2021 00:03:08 -0700 (PDT)
Message-Id: <b66ab0f2d5699a8b48220bebaa9e2cc2ccfad4fa.1624086181.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.980.v3.git.1624086181.gitgitgadget@gmail.com>
References: <pull.980.v2.git.1623763746.gitgitgadget@gmail.com>
        <pull.980.v3.git.1624086181.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 19 Jun 2021 07:02:59 +0000
Subject: [PATCH v3 09/10] [GSOC] cat-file: reuse err buf in
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
index cbedb8e1c471..b5204493bd56 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -212,32 +212,33 @@ static void batch_write(struct batch_options *opt, const void *data, int len)
 
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
 	if (!ret) {
 		strbuf_addch(scratch, '\n');
 		batch_write(opt, scratch->buf, scratch->len);
 	} else if (ret < 0) {
-		die("%s\n", err.buf);
+		die("%s\n", err->buf);
 	} else {
 		/* when ret > 0 , don't call die and print the err to stdout*/
-		printf("%s\n", err.buf);
+		printf("%s\n", err->buf);
 		fflush(stdout);
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
@@ -291,7 +292,7 @@ static void batch_one_object(const char *obj_name,
 		return;
 	}
 
-	batch_object_write(obj_name, scratch, opt, data);
+	batch_object_write(obj_name, scratch, err, opt, data);
 }
 
 struct object_cb_data {
@@ -299,13 +300,14 @@ struct object_cb_data {
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
 
@@ -361,6 +363,7 @@ static int batch_objects(struct batch_options *opt, const struct option *options
 {
 	struct strbuf input = STRBUF_INIT;
 	struct strbuf output = STRBUF_INIT;
+	struct strbuf err = STRBUF_INIT;
 	struct strbuf format = STRBUF_INIT;
 	struct expand_data data;
 	int save_warning;
@@ -389,6 +392,7 @@ static int batch_objects(struct batch_options *opt, const struct option *options
 		cb.opt = opt;
 		cb.expand = &data;
 		cb.scratch = &output;
+		cb.err = &err;
 
 		if (opt->unordered) {
 			struct oidset seen = OIDSET_INIT;
@@ -413,6 +417,7 @@ static int batch_objects(struct batch_options *opt, const struct option *options
 
 		strbuf_release(&format);
 		strbuf_release(&output);
+		strbuf_release(&err);
 		return 0;
 	}
 
@@ -441,12 +446,13 @@ static int batch_objects(struct batch_options *opt, const struct option *options
 			data.rest = p;
 		}
 
-		batch_one_object(input.buf, &output, opt, &data);
+		batch_one_object(input.buf, &output, &err, opt, &data);
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

