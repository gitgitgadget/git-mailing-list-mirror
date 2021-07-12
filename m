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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644C1C07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 11:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F6C9610CD
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 11:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233253AbhGLLuM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 07:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbhGLLt7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 07:49:59 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57108C0613DD
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 04:47:11 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id g8-20020a1c9d080000b02901f13dd1672aso9637797wme.0
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 04:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2wAhzEz1dqFEFD7ZYTaOKtiC0HQ3bg2FSnbAhq07rRM=;
        b=lZSNedqBeFR+oswlDJGWZwI1XgE64xoC38lrK9ixAfTEDv0BedVCpZXu3OZk+b1WiR
         DcqZ2PCTQ5B8+eFBqVthkP1gzbC3XY40p+T6qcnprzvIkBWXnXC11dQ4dDbVjkfu1Xz2
         8mPaYIUJ/5h0zFQwhoySZ7vfIJsOtPpTFhIXZ4+rfi8ipr6dgjT7CBY36oHmoKQBnJyF
         0mwNys31jY8bd7R8tGfKTfroBZbd3YB9wA/BuWe840NxrDp2KDdyf++NHcdr3m/ahblj
         vbkpcAtNKwuKPDF3STpnEYnpyKG9Asikki21HeEuynaK+nuSeQ7yZgeNDfWbOlAzCEqM
         5BaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2wAhzEz1dqFEFD7ZYTaOKtiC0HQ3bg2FSnbAhq07rRM=;
        b=HsLxuSF/V7fj6RVRuf6yNUjLjSVF5oGPypAkafJ9QjZqVCNLMshleRVSHo6baIxJRq
         QG9UFZ9tnl4bXy98E7yy7w6ss9Zuh020O7xGn+FBJOGTk4aTc2KqAVCvOul4+1G3jW4R
         wUfxaENXQ2ip9thQwVi7SCAQk4K94nWpKCv19dTAbC7u7AM2kZnquSI/eeembvZ2C1QZ
         OoneolqmarhXxtF8URI8Y5tvgorMkGsSenXyBm9M8XU6xbP+w91NPDDaujD/5ac4V5e5
         kJZ4FwysmDsMl+YLURddajEcDAvT1yRw/hK2gXGomTnqEiHwt090jFWnG7D9NFTxmFPQ
         m6ug==
X-Gm-Message-State: AOAM5310UXxfgvKzgQxw35l3/Jp+zznu4v+o75DFC2OUlFrLmvSnjJ9M
        noH6okPh6QCvCgd2SCbLxcXff/ZFzbk=
X-Google-Smtp-Source: ABdhPJxStX9rfqqdrn6xXfXjOkRvVqxlvSBh0dtFbViPBiP+GwkyRsnQ4uctovNCowNnXTEw783TpQ==
X-Received: by 2002:a7b:c4d3:: with SMTP id g19mr12796631wmk.78.1626090430018;
        Mon, 12 Jul 2021 04:47:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w22sm19908909wmc.4.2021.07.12.04.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 04:47:09 -0700 (PDT)
Message-Id: <fa74bf9451cb452ced0e49a6ad5accb984449c06.1626090419.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.993.git.1626090419.gitgitgadget@gmail.com>
References: <pull.993.git.1626090419.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Jul 2021 11:46:56 +0000
Subject: [PATCH 16/19] [GSOC] cat-file: re-implement --textconv, --filters
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

