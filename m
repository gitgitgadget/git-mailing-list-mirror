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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36005C4338F
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 07:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1565C60F5E
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 07:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238112AbhHQHP0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 03:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233996AbhHQHPZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 03:15:25 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8BE5C0613C1
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 00:14:52 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id q11-20020a7bce8b0000b02902e6880d0accso1168231wmj.0
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 00:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=iX2L3ncslySytNVuPS1S0N4xVePIhQxVLRAfBjepfl4=;
        b=Nzy7t744HlRlak4XPUeNvtFwA+0Wpc7+KO36inImlH881wx1YMa/PxccFPr7Wi3WKY
         Hv/Tsh8pS6WmZKJvX/BeK3Bf5RxQrkwKKlS2sSm+Pcg89Tp5R3bGFcBBbM8TfhkgEGU/
         u2J8ijqDqEZME9oISoeBylDWJaX4vSzBAxtLmrHJQDjyuBViHGS69huV4ed4r+YT9so0
         hJxvd3cCyBoIl+nzzuYHh2CwnkI0NqP/G4IMZvw7uPSVPLdryQeH1VCkzyF9ayskdw2P
         sXzDitt9amIPSzo7wr1mmKmqzHbiX4yrQ+nB0Zq0gYS4ioeeASdPLwGIU5JsFzz9U64k
         e4/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=iX2L3ncslySytNVuPS1S0N4xVePIhQxVLRAfBjepfl4=;
        b=IqK+VENKz27GjM6aDPA+rOlkMliP8yd2C9TZovdS/rzX8iX+lV4IYacw5jAXPSqjDN
         lHVYCvU5JkP3+Pt4CRBuyqaLHKdyYOt51yu7lUpLiCKG8DgciDqDtnHLWiIi6EtE3+Nb
         N1wuUG069wY2kp8e5sGEpbX0b7y21JjJ1wndMJZtoX2apauR8EjLimYYvWleDvk4WyG0
         OzlF3LzAqdpeJ6mbV9SsXgJ6/QMFIWIhKi8/IC0oYBUl0zqQFIxpgiedPOh82+lYHUSK
         52VVsTu5kw+rSfkwj/lOD4MqjSp2DJmjyKgjxIRShM4LPDjgNoS4I0M0zLJIt1sEg93c
         wYJw==
X-Gm-Message-State: AOAM532/yF0Oit/yfc9eac+Kqa5PJbsuI3xBmE9uTt3F1QUhMy6u3WCn
        nwT5n96HqskUkCEWTpGWmfV9QxsqIB0=
X-Google-Smtp-Source: ABdhPJw8UB2MLJbrhXXRk/pXSRz+/5oDi2kRhQieUUTiCrB6ErnNnWDL5/UNFT9S45duxGxgXO9j1w==
X-Received: by 2002:a05:600c:210a:: with SMTP id u10mr1863272wml.162.1629184491248;
        Tue, 17 Aug 2021 00:14:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r12sm1352212wrv.96.2021.08.17.00.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 00:14:50 -0700 (PDT)
Message-Id: <da3ba91c61a80c73d5c47abac3d807753e243288.1629184489.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1020.git.1629184489.gitgitgadget@gmail.com>
References: <pull.1020.git.1629184489.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Aug 2021 07:14:45 +0000
Subject: [PATCH 1/5] [GSOC] ref-filter: skip parse_object_buffer in some cases
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

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 ref-filter.c | 49 +++++++++++++++++++++++++++++++++++++------------
 ref-filter.h |  5 +++--
 2 files changed, 40 insertions(+), 14 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 93ce2a6ef2e..65ba00633dc 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1009,6 +1009,20 @@ static int reject_atom(enum atom_type atom_type)
 	return atom_type == ATOM_REST;
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
@@ -1029,6 +1043,8 @@ int verify_ref_format(struct ref_format *format)
 		at = parse_ref_filter_atom(format, sp + 2, ep, &err);
 		if (at < 0)
 			die("%s", err.buf);
+		if (need_parse_buffer(used_atom[at].atom_type))
+			format->can_skip_parse_buffer = 0;
 		if (reject_atom(used_atom[at].atom_type))
 			die(_("this command reject atom %%(%.*s)"), (int)(ep - sp - 2), sp + 2);
 
@@ -1524,14 +1540,16 @@ static void grab_values(struct atom_value *val, int deref, struct object *obj, s
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
@@ -1757,14 +1775,21 @@ static int get_object(struct ref_array_item *ref, int deref, struct object **obj
 		BUG("Object size is less than zero.");
 
 	if (oi->info.contentp) {
-		*obj = parse_object_buffer(the_repository, &oi->oid, oi->type, oi->size, oi->content, &eaten);
-		if (!*obj) {
-			if (!eaten)
-				free(oi->content);
-			return strbuf_addf_ret(err, -1, _("parse_object_buffer failed on %s for %s"),
-					       oid_to_hex(&oi->oid), ref->refname);
+		if (ref->can_skip_parse_buffer &&
+		    ((!deref &&
+		     (!need_tagged || oi->type != OBJ_TAG)) ||
+		    deref)) {
+			grab_values(ref->value, deref, NULL, oi);
+		} else {
+			*obj = parse_object_buffer(the_repository, &oi->oid, oi->type, oi->size, oi->content, &eaten);
+			if (!*obj) {
+				if (!eaten)
+					free(oi->content);
+				return strbuf_addf_ret(err, -1, _("parse_object_buffer failed on %s for %s"),
+						       oid_to_hex(&oi->oid), ref->refname);
+			}
+			grab_values(ref->value, deref, *obj, oi);
 		}
-		grab_values(ref->value, deref, *obj, oi);
 	}
 
 	grab_common_values(ref->value, deref, oi);
@@ -1988,7 +2013,7 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 	 * If there is no atom that wants to know about tagged
 	 * object, we are done.
 	 */
-	if (!need_tagged || (obj->type != OBJ_TAG))
+	if (!need_tagged || (oi.type != OBJ_TAG))
 		return 0;
 
 	/*
@@ -2595,7 +2620,7 @@ int format_ref_array_item(struct ref_array_item *info,
 
 	state.quote_style = format->quote_style;
 	push_stack_element(&state.stack);
-
+	info->can_skip_parse_buffer = format->can_skip_parse_buffer;
 	for (cp = format->format; *cp && (sp = find_next(cp)); cp = ep + 1) {
 		struct atom_value *atomv;
 		int pos;
diff --git a/ref-filter.h b/ref-filter.h
index c15dee8d6b9..5bceae1dac9 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -40,6 +40,7 @@ struct ref_array_item {
 	struct object_id objectname;
 	const char *rest;
 	int flag;
+	int can_skip_parse_buffer;
 	unsigned int kind;
 	const char *symref;
 	struct commit *commit;
@@ -81,12 +82,12 @@ struct ref_format {
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

