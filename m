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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E43C4320A
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 08:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0B1A6056B
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 08:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239075AbhHMIYH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 04:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238671AbhHMIXu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 04:23:50 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABB6C061292
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 01:23:23 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id h13so12174501wrp.1
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 01:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ejOQzbNvR0GgKnTzUw0qecz84LDsr6+RdcltC+eMp0A=;
        b=Gx1aYjHK4nm84V3XsCca9qmIsz0MoUNbTN6j0TIr+TbLyhkhi4ZoI2B1LcqgsPEDuu
         THv66+6YtF1AUtMjxxDzKlSY5cj35f/Hbknp+wOLSXj3hPDBLrttu8byFPnGlv1WXptI
         +AS2Rby+QUGacImOo/gCZIvDM0KRxpW93Pi0ZpxS1LaAEYq0Qinu8ZUo736Tsvupc910
         4ZTqR1w4Wyr5yve/m+DQ/ei1vD+Yik4dkPrvHSD+Ka3CCK0BRKbj1t3KGChqsbSXMMRn
         JSRC3sSznsquw20lLvn/wWXO4xswlfTdYlmBIw2XCxhSeQr2YvTcMgIqZ0+tm/1AvVf5
         2fVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ejOQzbNvR0GgKnTzUw0qecz84LDsr6+RdcltC+eMp0A=;
        b=eSaMlwa6MlLZyIuhf51Rykpl+z9lu1199Ivtpb5RzGdljf0Tx1pqTf9mYcixTkkFCo
         zA3sKfGwUp0ycxLTM0Z4Nrtk9PTDeZJrXZSrag1z7wzpYsyyWOedvR1KtOLTyKZfUl6N
         46r/dQgB1We/pIKSa4S/m7wopB1Lwvf+S1cHmt4Dq9vVoi7QSIOD0mRUdc4lVlxSATFQ
         H9hSpi+DMLhFbYohYHSqer6UvAp+gEhgBN4sMCaZ/UGtGUGNsRIYjKMVG4ZFLazWL5QE
         8DIWWUvrzpTn0BgZYByJKjJiwB4xuUoVVnx6KvE4IbpsbJfWPYZDiRg/3VYJAot9OVhK
         pCiA==
X-Gm-Message-State: AOAM530th+yvQDe4rJIdvtZkS9OtyMWfRR9U7RPNOt1Ne5v6cZnGAuW2
        FshBWIjE/Oa1HcvPkjHxzIkUmpj3EFc=
X-Google-Smtp-Source: ABdhPJwQj+EchRBRbUYAhX89NKFsfd4p28XJh53a3hPezSdfxnsUjCwUlC5DNemXkn0QylB5Z7RcVQ==
X-Received: by 2002:a5d:668f:: with SMTP id l15mr1694858wru.390.1628843002518;
        Fri, 13 Aug 2021 01:23:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t8sm762525wmj.5.2021.08.13.01.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 01:23:22 -0700 (PDT)
Message-Id: <2c6ce95c8278710b43bf9b7a2fe09732a3172b09.1628842990.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1016.git.1628842990.gitgitgadget@gmail.com>
References: <pull.1016.git.1628842990.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 13 Aug 2021 08:23:00 +0000
Subject: [PATCH 17/27] [GSOC] ref-filter: performance optimization by skip
 parse_object_buffer
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

When we are using some atoms such as %(raw), %(objectname),
%(objecttype), we don't need to parse the content of the object,
so we can skip parse_object_buffer() for performance optimization.

It is worth noting that in these cases, we still need to call
parse_object_buffer() for parsing:

1. The atom type is one of %(tag), %(type), %(object), %(tree),
%(numparent) or %(parent).
2. The type of the object is tag and the atom need to be
dereferenced e.g. %(*objecttype).

With this patch, `git cat-file --batch` has a 12.5% performance
improvement. But there is still a certain gap with
`git cat-file --batch` before using the logic of ref-filter.
`git cat-file --batch` is 10% worse, `git cat-file --batch-check`
is 30% worse.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 ref-filter.c | 53 ++++++++++++++++++++++++++++++++++++++--------------
 ref-filter.h |  5 +++--
 2 files changed, 42 insertions(+), 16 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 8664d9a6f4e..1251e062ff8 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1025,6 +1025,20 @@ static int reject_atom(int cat_file_mode, enum atom_type atom_type)
 	}
 }
 
+static int need_parse_buffer(enum atom_type atom_type) {
+	switch (atom_type) {
+	case ATOM_TAG:
+	case ATOM_TYPE:
+	case ATOM_OBJECT:
+	case ATOM_TREE:
+	case ATOM_NUMPARENT:
+	case ATOM_PARENT:
+		return 1;
+	default:
+		return 0;
+	}
+}
+
 /*
  * Make sure the format string is well formed, and parse out
  * the used atoms.
@@ -1045,6 +1059,8 @@ int verify_ref_format(struct ref_format *format)
 		at = parse_ref_filter_atom(format, sp + 2, ep, &err);
 		if (at < 0)
 			die("%s", err.buf);
+		if (need_parse_buffer(used_atom[at].atom_type))
+			format->can_skip_parse_buffer = 0;
 		if (reject_atom(format->cat_file_mode, used_atom[at].atom_type))
 			die(_("this command reject atom %%(%.*s)"), (int)(ep - sp - 2), sp + 2);
 
@@ -1532,14 +1548,16 @@ static void grab_values(struct atom_value *val, int deref, struct object *obj, s
 {
 	void *buf = data->content;
 
-	switch (obj->type) {
+	switch (data->type) {
 	case OBJ_TAG:
-		grab_tag_values(val, deref, obj);
+		if (obj)
+			grab_tag_values(val, deref, obj);
 		grab_sub_body_contents(val, deref, data);
 		grab_person("tagger", val, deref, buf);
 		break;
 	case OBJ_COMMIT:
-		grab_commit_values(val, deref, obj);
+		if (obj)
+			grab_commit_values(val, deref, obj);
 		grab_sub_body_contents(val, deref, data);
 		grab_person("author", val, deref, buf);
 		grab_person("committer", val, deref, buf);
@@ -1792,16 +1810,23 @@ static int get_object(struct ref_array_item *ref, int deref, struct object **obj
 				actual_oi = &act_oi;
 			}
 		}
-		*obj = parse_object_buffer(the_repository, &actual_oi->oid, actual_oi->type, actual_oi->size, actual_oi->content, &eaten);
-		if (!*obj) {
-			if (!eaten)
-				free(actual_oi->content);
-			if (actual_oi != oi)
-				free(oi->content);
-			return strbuf_addf_ret(err, -1, _("parse_object_buffer failed on %s for %s"),
-					       oid_to_hex(&oi->oid), ref->refname);
+		if (ref->can_skip_parse_buffer &&
+		    ((!deref &&
+		     (!need_tagged || oi->type != OBJ_TAG)) ||
+		    deref)) {
+			grab_values(ref->value, deref, NULL, actual_oi);
+		} else {
+			*obj = parse_object_buffer(the_repository, &actual_oi->oid, actual_oi->type, actual_oi->size, actual_oi->content, &eaten);
+			if (!*obj) {
+				if (!eaten)
+					free(actual_oi->content);
+				if (actual_oi != oi)
+					free(oi->content);
+				return strbuf_addf_ret(err, -1, _("parse_object_buffer failed on %s for %s"),
+						       oid_to_hex(&oi->oid), ref->refname);
+			}
+			grab_values(ref->value, deref, *obj, actual_oi);
 		}
-		grab_values(ref->value, deref, *obj, actual_oi);
 	}
 
 	grab_common_values(ref->value, deref, oi);
@@ -2029,7 +2054,7 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 	 * If there is no atom that wants to know about tagged
 	 * object, we are done.
 	 */
-	if (!need_tagged || (obj->type != OBJ_TAG))
+	if (!need_tagged || (oi.type != OBJ_TAG))
 		return 0;
 
 	/*
@@ -2651,7 +2676,7 @@ int format_ref_array_item(struct ref_array_item *info,
 
 	state.quote_style = format->quote_style;
 	push_stack_element(&state.stack);
-
+	info->can_skip_parse_buffer = format->can_skip_parse_buffer;
 	for (cp = format->format; *cp && (sp = find_next(cp)); cp = ep + 1) {
 		struct atom_value *atomv;
 		int pos;
diff --git a/ref-filter.h b/ref-filter.h
index 853eb554a5b..8cae9f576d5 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -41,6 +41,7 @@ struct ref_array_item {
 	const char *rest;
 	int cat_file_cmdmode;
 	int flag;
+	int can_skip_parse_buffer;
 	unsigned int kind;
 	const char *symref;
 	struct commit *commit;
@@ -83,12 +84,12 @@ struct ref_format {
 	int quote_style;
 	int use_rest;
 	int use_color;
-
+	int can_skip_parse_buffer;
 	/* Internal state to ref-filter */
 	int need_color_reset_at_eol;
 };
 
-#define REF_FORMAT_INIT { .use_color = -1 }
+#define REF_FORMAT_INIT { .use_color = -1, .can_skip_parse_buffer = 1 }
 
 /*  Macros for checking --merged and --no-merged options */
 #define _OPT_MERGED_NO_MERGED(option, filter, h) \
-- 
gitgitgadget

