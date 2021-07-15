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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F41A9C47E48
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 15:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D638B613E0
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 15:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239367AbhGOPnh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 11:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239183AbhGOPnc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 11:43:32 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA8DC061764
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 08:40:38 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id u8-20020a7bcb080000b02901e44e9caa2aso3929120wmj.4
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 08:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2wAhzEz1dqFEFD7ZYTaOKtiC0HQ3bg2FSnbAhq07rRM=;
        b=AFDrZaezJhEldE+ZuVxT/XEERZo8RX5DzU5u2vVO6qtxcmBsXPXNUejseR8b7Jr5VZ
         kNQAhr9XA3ow7cAK8kftbsc0/bfmz5NIf5c/HxUlZRfGqvR2yuoUmELxcTu6kTQjR+or
         uUTjNhJ3KrjHYiuTkJ+QGEmOt0TNxEklf0IxSwTxIF5iNp1JXPelGowrq/95mh8RdUVB
         9MdjCo1p+myw4fUg1mSr6r8Y+LrKi2aRmJQvkxCBQYxXVlE5nJe0z9beuPOrEFfr/o3K
         3mBDsh6fZxDnwPzxKWS33I81oZYOBp4baIR3FPF8buGB9na2cnjDGpvUyqWHklm4hphI
         D1fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2wAhzEz1dqFEFD7ZYTaOKtiC0HQ3bg2FSnbAhq07rRM=;
        b=RaxFDw3XX7try/Z8ExXM18SM9umthaTawGPBZe6NVAn1OhorFfpC0bJt515xOSQEi2
         Bs5BEAcURFHE71Ejqw4I+Rv7vQdQObVQ29F61o1Fl+3AY2LuqN8/CLGiZU2AEkwQfpgB
         uwTCejHTJ9RKLSc9PWvTPqxBUxoiUzxU1uWSXw6Pl5V+ErUqzYV/BEb1J4vIJ4mJjl7E
         AMCw30dB+Cu107YYrgb6Zr8hE3utHN9gEnhY0Fzw+QAL1HCrvmI0DJ3SClZhRlwuiM5W
         bJintQ16nfcEEeziMUlfMSJfeIIHYonk96lFEIN1lJDv0Wa5XTYhJPLc/foxBvwIb3ns
         R/yw==
X-Gm-Message-State: AOAM533y+1qJvFtnY3UKTyjPsfrGfD6H1R/7XaKuoP7Q81eZvQ7ZH9Al
        n1YIYtNpOkSN1+HnqA8gM1YNtVutScI=
X-Google-Smtp-Source: ABdhPJxrB4muB7Ad75UR/FUoOKLLx9gUktL5bgwfUCFqoAaFzmqpxhAI8eAehl01XF9gduXNPYvYgw==
X-Received: by 2002:a05:600c:4c96:: with SMTP id g22mr11018447wmp.70.1626363637543;
        Thu, 15 Jul 2021 08:40:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a10sm6688328wrm.12.2021.07.15.08.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 08:40:37 -0700 (PDT)
Message-Id: <ed556e5f31e6398d1733cf9639c454b04978ab3a.1626363626.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.993.v2.git.1626363626.gitgitgadget@gmail.com>
References: <pull.993.git.1626090419.gitgitgadget@gmail.com>
        <pull.993.v2.git.1626363626.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 15 Jul 2021 15:40:23 +0000
Subject: [PATCH v2 15/17] [GSOC] cat-file: re-implement --textconv, --filters
 options
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

After cat-file reuses the ref-filter logic, we re-implement the
functions of --textconv and --filters options.

Add members `cat_file_cmdmode` to struct `ref_array_item`,
so that struct `batch_option` member `cmdmode` will be passed
to ref-filter, and then ref-filter will take use of it to filter
the content of the object in get_object().

Use `actual_oi` to record the real expand_data: it may point to the
original `oi` or the `act_oi` processed by `textconv_object()` or
`convert_to_working_tree()`. `grab_values()` will grab the contents
of `actual_oi` and `grab_common_values()` to grab the contents of origin
`oi`, this ensures that `%(objectsize)` still uses the size of the
unfiltered data.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 builtin/cat-file.c |  2 +-
 ref-filter.c       | 35 +++++++++++++++++++++++++++++++++--
 ref-filter.h       |  1 +
 3 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index dc604a9879d..3a6153e778f 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -217,7 +217,7 @@ static void batch_object_write(const char *obj_name,
 			       struct expand_data *data)
 {
 	int ret;
-	struct ref_array_item item = { data->oid, data->rest };
+	struct ref_array_item item = { data->oid, data->rest, opt->cmdmode };
 
 	strbuf_reset(scratch);
 	strbuf_reset(err);
diff --git a/ref-filter.c b/ref-filter.c
index b4f41fec871..91e26c9aba3 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1,3 +1,4 @@
+#define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "builtin.h"
 #include "cache.h"
 #include "parse-options.h"
@@ -1755,6 +1756,9 @@ static int get_object(struct ref_array_item *ref, int deref, struct object **obj
 {
 	/* parse_object_buffer() will set eaten to 0 if free() will be needed */
 	int eaten = 1;
+	struct expand_data *actual_oi = oi;
+	struct expand_data act_oi = {0};
+
 	if (oi->info.contentp) {
 		/* We need to know that to use parse_object_buffer properly */
 		oi->info.sizep = &oi->size;
@@ -1768,19 +1772,45 @@ static int get_object(struct ref_array_item *ref, int deref, struct object **obj
 		BUG("Object size is less than zero.");
 
 	if (oi->info.contentp) {
-		*obj = parse_object_buffer(the_repository, &oi->oid, oi->type, oi->size, oi->content, &eaten);
+		if ((ref->cat_file_cmdmode == 'c' || ref->cat_file_cmdmode == 'w') && !ref->rest)
+			return strbuf_addf_ret(err, -1, _("missing path for '%s'"),
+					       oid_to_hex(&act_oi.oid));
+		if (oi->type == OBJ_BLOB) {
+			if (ref->cat_file_cmdmode == 'c') {
+				act_oi = *oi;
+				if (textconv_object(the_repository,
+						    ref->rest, 0100644, &act_oi.oid,
+						    1, (char **)(&act_oi.content), &act_oi.size))
+					actual_oi = &act_oi;
+			} else if (ref->cat_file_cmdmode == 'w') {
+				struct strbuf strbuf = STRBUF_INIT;
+				struct checkout_metadata meta;
+				act_oi = *oi;
+
+				init_checkout_metadata(&meta, NULL, NULL, &act_oi.oid);
+				if (!convert_to_working_tree(&the_index, ref->rest, act_oi.content, act_oi.size, &strbuf, &meta))
+					die("could not convert '%s' %s",
+					    oid_to_hex(&oi->oid), ref->rest);
+				act_oi.size = strbuf.len;
+				act_oi.content = strbuf_detach(&strbuf, NULL);
+				actual_oi = &act_oi;
+			}
+		}
+		*obj = parse_object_buffer(the_repository, &actual_oi->oid, actual_oi->type, actual_oi->size, actual_oi->content, &eaten);
 		if (!*obj) {
 			if (!eaten)
 				free(oi->content);
 			return strbuf_addf_ret(err, -1, _("parse_object_buffer failed on %s for %s"),
 					       oid_to_hex(&oi->oid), ref->refname);
 		}
-		grab_values(ref->value, deref, *obj, oi);
+		grab_values(ref->value, deref, *obj, actual_oi);
 	}
 
 	grab_common_values(ref->value, deref, oi);
 	if (!eaten)
 		free(oi->content);
+	if (actual_oi != oi)
+		free(actual_oi->content);
 	return 0;
 }
 
@@ -2189,6 +2219,7 @@ static struct ref_array_item *new_ref_array_item(const char *refname,
 	FLEX_ALLOC_STR(ref, refname, refname);
 	oidcpy(&ref->objectname, oid);
 	ref->rest = NULL;
+	ref->cat_file_cmdmode = 0;
 
 	return ref;
 }
diff --git a/ref-filter.h b/ref-filter.h
index 053980a6a42..a93d5e4dd61 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -39,6 +39,7 @@ struct ref_sorting {
 struct ref_array_item {
 	struct object_id objectname;
 	const char *rest;
+	int cat_file_cmdmode;
 	int flag;
 	unsigned int kind;
 	const char *symref;
-- 
gitgitgadget

