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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2682C48BCF
	for <git@archiver.kernel.org>; Sat, 12 Jun 2021 11:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 891AA60FE5
	for <git@archiver.kernel.org>; Sat, 12 Jun 2021 11:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhFLLQ0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Jun 2021 07:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbhFLLQZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Jun 2021 07:16:25 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333F6C0613A2
        for <git@vger.kernel.org>; Sat, 12 Jun 2021 04:14:26 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id y7so8754714wrh.7
        for <git@vger.kernel.org>; Sat, 12 Jun 2021 04:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+Gj/5slRCNm1ugwYLXxY3m9qTDg3ZVwm9LJP9cr+S5Y=;
        b=IqmrjDEgZ2t0d/OBHev9Gc9gYJMqoVZSOmkKzK911MnNmCMploO8O7R66j8TFbs3Cp
         aIDrHvKqvh602v6+qDJ38ZKVhHDl1ShIZQd+WD9Q9WYoYOmv5DqjLFfZaVEPlqmKJqUB
         /594RlDzyT13PMFlolc9TQ5Rr+Qqz3whmmiaZ7SM5cGtHEhHmgvVUcjt+PHoveWgog60
         4nQ3tmuUkQ7BFk2ZsLFh32e2uHoA4c4/2fn57HjpD6qBHfu51uJkXqfehXeh2U+M3G+o
         wwyeH8ukTn9wXT+pZCyffbNytAyNVeorejithAUt+vWHqrwA2T930fekL2D9KmMKJW1o
         IiOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+Gj/5slRCNm1ugwYLXxY3m9qTDg3ZVwm9LJP9cr+S5Y=;
        b=UEfSkI3p8GrZyrekk/w/c53Vb+TEezq7uu5iaPYgixKRaeiit1DJ0XoHZafZWiu46+
         Wz7OSi9g5+oiT0FX6UyQMAssZOYeac2Yg8nBXNyNjq9lNzL0PgoTACKtpCAhmfmhHUf0
         zODnmeSruUY7/Fp7iGZYWGJ5yeBW5MRjbwDX1X50gAN4pNbO1U6uv2Wzjan0dC7pqX6N
         ipt8Bp8POYm2dVCfL5S70BzvT6QV0F5TY7xe+LDnWkNMuO1QO8VbeXZ1a7tYZxxXaPH1
         rflVmIyCNOt3anvDbGm6lhdKYsJM3yk6X8j4ajRMrV94VTqX/CTYvneLGjdy1XMTk/oH
         9z9Q==
X-Gm-Message-State: AOAM531eK+U+szuHfs2cxXd1bea4BGikCRndZgFVljkfNL7N+j1vscBu
        6mThGa6aV6wPOYAZFH/RVpwWe6csfls=
X-Google-Smtp-Source: ABdhPJwsCNhhYVs4EfPe041aZBxAZwrwJrabld+6Cw/qlzm2Waee/sFJFKWEq7O/IhSUuUBoVGN7bA==
X-Received: by 2002:adf:9ccf:: with SMTP id h15mr3330167wre.217.1623496464865;
        Sat, 12 Jun 2021 04:14:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k5sm9943793wmk.11.2021.06.12.04.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jun 2021 04:14:24 -0700 (PDT)
Message-Id: <0004d5b24a0fb735d7fa9cb9a8e214d6e838baeb.1623496458.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.980.git.1623496458.gitgitgadget@gmail.com>
References: <pull.980.git.1623496458.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 12 Jun 2021 11:14:17 +0000
Subject: [PATCH 8/8] [GSOC] cat-file: re-implement --textconv, --filters
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
        Jeff King <peff@peff.net>, ZheNing Hu <adlternative@gmail.com>,
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
 builtin/cat-file.c |  5 ++++
 ref-filter.c       | 66 ++++++++++++++++++++++++++++++++++++++++++++--
 ref-filter.h       |  5 ++--
 3 files changed, 72 insertions(+), 4 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 1a73c3d23dde..3fde2587201b 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -376,6 +376,11 @@ static int batch_objects(struct batch_options *opt, const struct option *options
 	if (opt->print_contents)
 		strbuf_addstr(&format, "\n%(raw)");
 	opt->format.format = format.buf;
+	if (opt->cmdmode == 'c')
+		opt->format.use_textconv = 1;
+	if (opt->cmdmode == 'w')
+		opt->format.use_filters = 1;
+
 	if (verify_ref_format(&opt->format))
 		usage_with_options(cat_file_usage, options);
 
diff --git a/ref-filter.c b/ref-filter.c
index d4c88d496698..8264ef7d2786 100644
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
@@ -1027,6 +1031,9 @@ int verify_ref_format(struct ref_format *format)
 					       used_atom[at].atom_type == ATOM_WORKTREEPATH)))
 			die(_("this command reject atom %%(%.*s)"), (int)(ep - sp - 2), sp + 2);
 
+		use_filters = format->use_filters;
+		use_textconv = format->use_textconv;
+
 		if (format->quote_style && used_atom[at].atom_type == ATOM_RAW &&
 		    used_atom[at].u.raw_data.option == RAW_BARE)
 			die(_("--format=%.*s cannot be used with"
@@ -1735,10 +1742,41 @@ static int get_object(struct ref_array_item *ref, int deref, struct object **obj
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
+		if (use_textconv) {
+			act_oi = *oi;
+
+			if(!ref->rest)
+				return strbuf_addf_ret(err, -1, _("missing path for '%s'"),
+						       oid_to_hex(&act_oi.oid));
+			if (act_oi.type == OBJ_BLOB) {
+				if (textconv_object(the_repository,
+						    ref->rest, 0100644, &act_oi.oid,
+						    1, (char **)(&act_oi.content), &act_oi.size)) {
+					actual_oi = &act_oi;
+					goto success;
+				}
+			}
+		}
 	}
 	if (oid_object_info_extended(the_repository, &oi->oid, &oi->info,
 				     OBJECT_INFO_LOOKUP_REPLACE))
@@ -1748,19 +1786,43 @@ static int get_object(struct ref_array_item *ref, int deref, struct object **obj
 		BUG("Object size is less than zero.");
 
 	if (oi->info.contentp) {
-		*obj = parse_object_buffer(the_repository, &oi->oid, oi->type, oi->size, oi->content, &eaten);
+		if (use_filters) {
+			if(!ref->rest)
+				return strbuf_addf_ret(err, -1, _("missing path for '%s'"),
+						       oid_to_hex(&oi->oid));
+			if (oi->type == OBJ_BLOB) {
+				struct strbuf strbuf = STRBUF_INIT;
+				struct checkout_metadata meta;
+				act_oi = *oi;
+
+				init_checkout_metadata(&meta, NULL, NULL, &act_oi.oid);
+				if (convert_to_working_tree(&the_index, ref->rest, act_oi.content, act_oi.size, &strbuf, &meta)) {
+					act_oi.size = strbuf.len;
+					act_oi.content = strbuf_detach(&strbuf, NULL);
+					actual_oi = &act_oi;
+				} else {
+					die("could not convert '%s' %s",
+					    oid_to_hex(&oi->oid), ref->rest);
+				}
+			}
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
index bece9583cf18..cf7bad4e8b49 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -80,14 +80,15 @@ struct ref_format {
 	const char *rest;
 	int cat_file_mode;
 	int quote_style;
+	int use_textconv;
+	int use_filters;
 	int use_rest;
 	int use_color;
-
 	/* Internal state to ref-filter */
 	int need_color_reset_at_eol;
 };
 
-#define REF_FORMAT_INIT { NULL, NULL, 0, 0, 0, -1 }
+#define REF_FORMAT_INIT { NULL, NULL, 0, 0, 0, 0, 0, -1 }
 
 /*  Macros for checking --merged and --no-merged options */
 #define _OPT_MERGED_NO_MERGED(option, filter, h) \
-- 
gitgitgadget
