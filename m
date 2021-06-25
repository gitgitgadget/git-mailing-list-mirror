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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27614C2B9F4
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 16:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 112B361976
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 16:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbhFYQFS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Jun 2021 12:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbhFYQFA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jun 2021 12:05:00 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A15C061574
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 09:02:38 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id j2so11117064wrs.12
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 09:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=I1siE7gIfw4HR3UIZz1G6rr97pPh2jQSzQNQqQn4Rpc=;
        b=Z+zpLqYfE7q9hCl5b7ZRP2czHa+tn+dgSdH5hL5nLxncNNcOpUEfoGnVx2ZXVV6in9
         MJ4wPdX6Hbk3mfZcbtc9m/qV0P6NUmX2VyVpUsp8M1OT8Dyb5GDQp1ALhOSGvi4/1vVh
         3jeyyGwYuwW2MOgB/z59rRYN7GpPXY82MDxKKu7oLIpKwBGCszbtigAVsldldJHVG1zP
         104RbCI40fSiWn83tcbmjto1tmj2u/Pq7u5CgpfnXRai6nYpsP47q2rb6+JsGpAONNYx
         ApGYLsOsA4BIoj3SkghZDERuwPrDmDrwQ0mPIkqQkmN2iOiPE3VvJRzC6fQMphePmxIO
         M3jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=I1siE7gIfw4HR3UIZz1G6rr97pPh2jQSzQNQqQn4Rpc=;
        b=PDA/2piI76UaKAF1UoisCX3XFEoVyYsnT6tI8Q9yJ/IoF1XHsEGOI8IJQmDcDkkgfL
         kIVb7dyU7E/Xvupjeh8vcNhfVrJS0r7bhmBGigp/gQKxWXCDMhURFafXoaNf050DNoL8
         uXN9gjn/1ubVUR+Gg6dP7ZlUUVH8aDWFpT3GEMzWpnbNzd5TAraSnm6q1BBuKQkavan0
         P/3qRowXYd/OaT272lCIf4gomYtzuqT8r/6/3gEhviR4IG06jyo86XJksjVL9+4JVjdd
         VMU9GvHkkdo8GnDVShp5hNE8PItsHfzUM8SKM4f2jj92p9TnA/oza/G5P48oTJ4OLGhL
         gcmw==
X-Gm-Message-State: AOAM532chuVTlGwE1HmYn4PV/Sx0bgQ8+guA1kArLcWguHvbqaQ//lN/
        yfVOh9pkQEg5VYjpWirSZHiPP5lxGZk=
X-Google-Smtp-Source: ABdhPJwCpbGiq8teTsaypsXxVxV9CyEIFrw9NENcZwKxuh5JdOqkECKxqMTceUvUVlrCpN93Pi309A==
X-Received: by 2002:a5d:4a91:: with SMTP id o17mr12001236wrq.335.1624636956678;
        Fri, 25 Jun 2021 09:02:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v22sm5585718wmh.40.2021.06.25.09.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 09:02:36 -0700 (PDT)
Message-Id: <a7ac037a94686585f1f91e74ff1ecc8402dc28a7.1624636945.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.980.v5.git.1624636945.gitgitgadget@gmail.com>
References: <pull.980.v4.git.1624332054.gitgitgadget@gmail.com>
        <pull.980.v5.git.1624636945.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Jun 2021 16:02:24 +0000
Subject: [PATCH v5 14/15] [GSOC] cat-file: re-implement --textconv, --filters
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
        <avarab@gmail.com>, ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

After cat-file reuses the ref-filter logic, we re-implement the
functions of --textconv and --filters options.

Add members `use_textconv` and `use_filters` in struct `ref_format`,
and use global variables `use_filters` and `use_textconv` in
`ref-filter.c`, so that we can filter the content of the object
in get_object(). Use `actual_oi` to record the real expand_data:
it may point to the original `oi` or the `act_oi` processed by
`textconv_object()` or `convert_to_working_tree()`. `grab_values()`
will grab the contents of `actual_oi` and `grab_common_values()`
to grab the contents of origin `oi`, this ensures that `%(objectsize)`
still uses the size of the unfiltered data.

In `get_object()`, we made an optimization: Firstly, get the size and
type of the object instead of directly getting the object data.
If using --textconv, after successfully obtaining the filtered object
data, an extra oid_object_info_extended() will be skipped, which can
reduce the cost of object data copy; If using --filter, the data of
the object first will be getted first, and then convert_to_working_tree()
will be used to get the filtered object data.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 builtin/cat-file.c |  6 +++++
 ref-filter.c       | 59 ++++++++++++++++++++++++++++++++++++++++++++--
 ref-filter.h       |  2 ++
 3 files changed, 65 insertions(+), 2 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 27403326e7a..f3140d927f7 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -380,6 +380,12 @@ static int batch_objects(struct batch_options *batch, const struct option *optio
 	if (batch->print_contents)
 		strbuf_addstr(&format, "\n%(raw)");
 	batch->format.format = format.buf;
+
+	if (batch->cmdmode == 'c')
+		batch->format.use_textconv = 1;
+	else if (batch->cmdmode == 'w')
+		batch->format.use_filters = 1;
+
 	if (verify_ref_format(&batch->format))
 		usage_with_options(cat_file_usage, options);
 
diff --git a/ref-filter.c b/ref-filter.c
index 181d99c9273..99b87742b0f 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1,3 +1,4 @@
+#define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "builtin.h"
 #include "cache.h"
 #include "parse-options.h"
@@ -84,6 +85,9 @@ static struct expand_data {
 	struct object_info info;
 } oi, oi_deref;
 
+int use_filters;
+int use_textconv;
+
 struct ref_to_worktree_entry {
 	struct hashmap_entry ent;
 	struct worktree *wt; /* key is wt->head_ref */
@@ -1031,6 +1035,9 @@ int verify_ref_format(struct ref_format *format)
 					       used_atom[at].atom_type == ATOM_WORKTREEPATH)))
 			die(_("this command reject atom %%(%.*s)"), (int)(ep - sp - 2), sp + 2);
 
+		use_filters = format->use_filters;
+		use_textconv = format->use_textconv;
+
 		if ((format->quote_style == QUOTE_PYTHON ||
 		     format->quote_style == QUOTE_SHELL ||
 		     format->quote_style == QUOTE_TCL) &&
@@ -1742,10 +1749,38 @@ static int get_object(struct ref_array_item *ref, int deref, struct object **obj
 {
 	/* parse_object_buffer() will set eaten to 0 if free() will be needed */
 	int eaten = 1;
+	struct expand_data *actual_oi = oi;
+	struct expand_data act_oi = {0};
+
 	if (oi->info.contentp) {
 		/* We need to know that to use parse_object_buffer properly */
+		void **temp_contentp = oi->info.contentp;
+		oi->info.contentp = NULL;
 		oi->info.sizep = &oi->size;
 		oi->info.typep = &oi->type;
+
+		/* get the type and size */
+		if (oid_object_info_extended(the_repository, &oi->oid, &oi->info,
+					OBJECT_INFO_LOOKUP_REPLACE))
+			return strbuf_addf_ret(err, 1, _("%s missing"),
+					       oid_to_hex(&oi->oid));
+
+		oi->info.sizep = NULL;
+		oi->info.typep = NULL;
+		oi->info.contentp = temp_contentp;
+
+		if (use_textconv && !ref->rest)
+			return strbuf_addf_ret(err, -1, _("missing path for '%s'"),
+					       oid_to_hex(&act_oi.oid));
+		if (use_textconv && oi->type == OBJ_BLOB) {
+			act_oi = *oi;
+			if (textconv_object(the_repository,
+					    ref->rest, 0100644, &act_oi.oid,
+					    1, (char **)(&act_oi.content), &act_oi.size)) {
+				actual_oi = &act_oi;
+				goto success;
+			}
+		}
 	}
 	if (oid_object_info_extended(the_repository, &oi->oid, &oi->info,
 				     OBJECT_INFO_LOOKUP_REPLACE))
@@ -1755,19 +1790,39 @@ static int get_object(struct ref_array_item *ref, int deref, struct object **obj
 		BUG("Object size is less than zero.");
 
 	if (oi->info.contentp) {
-		*obj = parse_object_buffer(the_repository, &oi->oid, oi->type, oi->size, oi->content, &eaten);
+		if (use_filters && !ref->rest)
+			return strbuf_addf_ret(err, -1, _("missing path for '%s'"),
+					       oid_to_hex(&oi->oid));
+		if (use_filters && oi->type == OBJ_BLOB) {
+			struct strbuf strbuf = STRBUF_INIT;
+			struct checkout_metadata meta;
+			act_oi = *oi;
+
+			init_checkout_metadata(&meta, NULL, NULL, &act_oi.oid);
+			if (!convert_to_working_tree(&the_index, ref->rest, act_oi.content, act_oi.size, &strbuf, &meta))
+				die("could not convert '%s' %s",
+					oid_to_hex(&oi->oid), ref->rest);
+			act_oi.size = strbuf.len;
+			act_oi.content = strbuf_detach(&strbuf, NULL);
+			actual_oi = &act_oi;
+		}
+
+success:
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
 
diff --git a/ref-filter.h b/ref-filter.h
index 053980a6a42..497e3e93632 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -80,6 +80,8 @@ struct ref_format {
 	const char *rest;
 	int cat_file_mode;
 	int quote_style;
+	int use_textconv;
+	int use_filters;
 	int use_rest;
 	int use_color;
 
-- 
gitgitgadget

