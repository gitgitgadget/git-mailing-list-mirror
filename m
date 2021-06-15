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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A6FC48BDF
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 13:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE53A61468
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 13:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbhFONbv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 09:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbhFONbT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 09:31:19 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC776C061226
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 06:29:14 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id f16-20020a05600c1550b02901b00c1be4abso1778083wmg.2
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 06:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Q6K7fgnkRbVYQeT3TbU5ef9TdEvqMaSZB6p/nSr5cyM=;
        b=NxKkowyRhqB/53yIlQDf8hx37g1VtSxBVjEBNSQdjsBWGg873RFcOzB1WnbHvaLdnJ
         Bzdz5d+qCNoqci/Fwsj/8lQ4XdBOHYSIgDjZV55fnyTPLUh2r1em1qlbnsWbLQphZMnp
         uHDVNDtoJV2/sXTcoCBu1r0yvrRcoVFMcpJLeVHFRIbDxkMWnqrMdwk45YaTSsYrNIo5
         JcrUttOgm4wcE/IycmgiJ175M7011m2K6tqceKUQz4Tbbu3EPyni7qYDDsJhBLdRF140
         S+RnZiuQ/JhcU5Th6xXewSxpDKXtAyAzaxGZbZnWqiVIXSInqHwjoDnA97PN3xgHH8NQ
         o7Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Q6K7fgnkRbVYQeT3TbU5ef9TdEvqMaSZB6p/nSr5cyM=;
        b=oEHht42oLCJ7kogQpQz7OFx2c1vqbV5XQt50mHM/s65ezx8vE+dK4HsGZQHT2G8vwN
         gWXvDfIfX/wW9bpVG7Evfq4u4Zdj19Is0lKsDS8ocmEnyL1nASSkdrV9kkngLDxIJRLZ
         7wgkQAz3L/5FNyg2gqDwbYODQ0m3L4HIyRqiKS4Q8sZ+4A4oYokpfjc8RhCGiwLq9OQA
         7C0VHOwFiRyplyqpvUjHGYqZO9lNvkBJ6CmvpFbt1xYThcgV9Ifvx56OuZ06Cj3Ff12D
         l3bZi9BRBYX3JzKUwI5cb/QhfHQTLy5REAv06LcMaZhzf2CO3bz3+/8tS3qkO4TmG/le
         aDBw==
X-Gm-Message-State: AOAM532vbc3yxckCmv46oF8kVIt9q3YybrmOJNYCaSr8iGGA+eFQJUDt
        hwx7ALPzKIZvpEpxUpkeEr5e8CDHWUw=
X-Google-Smtp-Source: ABdhPJxFfQIwk/ymjEMJmNxXjU7ClhpeuQdNOQnwn2KBb2sVZdGw4kW+h+auwDgOQM4oIwAY1DJs8A==
X-Received: by 2002:a05:600c:1ca6:: with SMTP id k38mr5466903wms.49.1623763753585;
        Tue, 15 Jun 2021 06:29:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u7sm22584481wrt.18.2021.06.15.06.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 06:29:13 -0700 (PDT)
Message-Id: <058b304686fdd97f1cdd81f4d5eb22f2b08ce987.1623763747.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.980.v2.git.1623763746.gitgitgadget@gmail.com>
References: <pull.980.git.1623496458.gitgitgadget@gmail.com>
        <pull.980.v2.git.1623763746.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Jun 2021 13:29:04 +0000
Subject: [PATCH v2 8/9] [GSOC] cat-file: reuse err buf in batch_objet_write()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>, ZheNing Hu <adlternative@gmail.com>,
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
index 026d9405636a..6766efb06f41 100644
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
 	free_array_item_internal(&item);
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

