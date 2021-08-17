Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC40C4338F
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 08:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C413B60F39
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 08:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239423AbhHQImX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 04:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239383AbhHQImU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 04:42:20 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFB0C061796
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 01:41:47 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id k5-20020a05600c1c85b02902e699a4d20cso1600979wms.2
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 01:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PKmZcXQH+W69ExH0bRTUl7cjmuufxLGZEjBt7W0TDX8=;
        b=rUYATxMTx2X3xxsU0C6vympp6DtUbAuKbGZEBDN6tyS7wZQ9+NpKQOlEDez4xcLrki
         JDhmvc4bReIzuVqWv01RTtlD7538ZRwKXueNtNAQWwWQ58IGgWNFLwvgWS1zbQAWMYqu
         5ieqGJklWUiuWEH11p5+HrG3iQSb3kGfpZrH+7ktyz9ZuLBQMTHtC+XCcixul9TAC6s6
         4638J4ACIkQA1sKYwebCJ1dgfTWT5tiQURioQ2PDjd/PKx2XrRAPa937MqVD5Zl2fYUK
         9sTolRp0mKFzq7Xst1QUEF+BSBuiUDs0IgNkSqrw54kAERK1ZYsruvXfkdFDBOcP9abB
         lejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PKmZcXQH+W69ExH0bRTUl7cjmuufxLGZEjBt7W0TDX8=;
        b=Z9n8CCG9CqS3SPELZ2Ux5m0b8GH1yL+XZ9U62b7cxhqR2VPMUzmTHSkkHkfxoM+xSz
         W2dKluJ4KFv7UAGeW8D63k/FzCHovG2/o17Uulqjs6NbIy0x6xBMflM391x8DPqEOsdW
         7HS0eDLfoui8bJ76xKf1oUXBEgF/FyrBdb/NEGJgFhsoR9nVkYRKWDVwfbN9zz6+FJer
         7B5rjrGuaHl0BtKugn/pWHoEhLBui4pZWVQk3LHq5HXd27wuMJWrrOcI+YFdhkJJ7j3Z
         jtUGWPyQKSEx0GTMORVIT+X39W4gkJddX3ySaMjJf6WTxzNTYsQr7O5ZiBp51/uhsHdy
         qTnw==
X-Gm-Message-State: AOAM533uGDYl5YcV9TdwuWHKPc3gBLP6yT88/WZ6UlLUy497OjUxKDqd
        odpBqCp9xANiMEvYcjGXrjHprmcra70=
X-Google-Smtp-Source: ABdhPJypTloPGRGMXaK3ZjYbz4TVPMjPXFZ2QAmjNT3mLvzz7JfIziGjOk5707oNj9wUKGCbwp+eZg==
X-Received: by 2002:a7b:ce0b:: with SMTP id m11mr2260126wmc.150.1629189706178;
        Tue, 17 Aug 2021 01:41:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d4sm1598593wrz.35.2021.08.17.01.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 01:41:45 -0700 (PDT)
Message-Id: <33b227e5fdf60c28392ef9660e9ae6f149a905bf.1629189701.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1021.git.1629189701.gitgitgadget@gmail.com>
References: <pull.1021.git.1629189701.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Aug 2021 08:41:39 +0000
Subject: [PATCH 6/8] [GSOC] ref-filter: add deref member to struct used_atom
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

In the ref-filter logic, the dereference flag '*' is stored
at the beginning of used_atom[i].name (e.g. '*objectname:short'),
this leads us to make some check on used_atom[i].name[0] to
know if the atom need to be dereferenced. This is not only
cumbersome to use, but also poor in readability.

So add `deref` flag to struct used_atom used to indicate
whether the atom needs to be dereferenced and let used_atom
record only the rest part (i.e. 'objectname:short').

This can make the logic of the program clearer and easy to use.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 ref-filter.c | 55 ++++++++++++++++++++--------------------------------
 1 file changed, 21 insertions(+), 34 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index b74fcbb4806..5abcbbf10ac 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -173,6 +173,7 @@ enum atom_type {
  * array.
  */
 static struct used_atom {
+	unsigned int deref : 1;
 	enum atom_type atom_type;
 	const char *name;
 	cmp_type type;
@@ -343,7 +344,7 @@ static int objecttype_atom_parser(struct ref_format *format, struct used_atom *a
 {
 	if (arg)
 		return strbuf_addf_ret(err, -1, _("%%(objecttype) does not take arguments"));
-	if (*atom->name == '*')
+	if (atom->deref)
 		oi_deref.info.typep = &oi_deref.type;
 	else
 		oi.info.typep = &oi.type;
@@ -355,13 +356,13 @@ static int objectsize_atom_parser(struct ref_format *format, struct used_atom *a
 {
 	if (!arg) {
 		atom->u.objectsize.option = O_SIZE;
-		if (*atom->name == '*')
+		if (atom->deref)
 			oi_deref.info.sizep = &oi_deref.size;
 		else
 			oi.info.sizep = &oi.size;
 	} else if (!strcmp(arg, "disk")) {
 		atom->u.objectsize.option = O_SIZE_DISK;
-		if (*atom->name == '*')
+		if (atom->deref)
 			oi_deref.info.disk_sizep = &oi_deref.disk_size;
 		else
 			oi.info.disk_sizep = &oi.disk_size;
@@ -375,7 +376,7 @@ static int deltabase_atom_parser(struct ref_format *format, struct used_atom *at
 {
 	if (arg)
 		return strbuf_addf_ret(err, -1, _("%%(deltabase) does not take arguments"));
-	if (*atom->name == '*')
+	if (atom->deref)
 		oi_deref.info.delta_base_oid = &oi_deref.delta_base_oid;
 	else
 		oi.info.delta_base_oid = &oi.delta_base_oid;
@@ -697,10 +698,13 @@ static int parse_ref_filter_atom(struct ref_format *format,
 	const char *sp;
 	const char *arg;
 	int i, at, atom_len;
+	int deref = 0;
 
 	sp = atom;
-	if (*sp == '*' && sp < ep)
+	if (*sp == '*' && sp < ep) {
 		sp++; /* deref */
+		deref = 1;
+	}
 	if (ep <= sp)
 		return strbuf_addf_ret(err, -1, _("malformed field name: %.*s"),
 				       (int)(ep-atom), atom);
@@ -717,7 +721,7 @@ static int parse_ref_filter_atom(struct ref_format *format,
 	/* Do we have the atom already used elsewhere? */
 	for (i = 0; i < used_atom_cnt; i++) {
 		int len = strlen(used_atom[i].name);
-		if (len == ep - atom && !memcmp(used_atom[i].name, atom, len))
+		if (len == ep - sp && !memcmp(used_atom[i].name, sp, len))
 			return i;
 	}
 
@@ -741,17 +745,18 @@ static int parse_ref_filter_atom(struct ref_format *format,
 	used_atom_cnt++;
 	REALLOC_ARRAY(used_atom, used_atom_cnt);
 	used_atom[at].atom_type = i;
-	used_atom[at].name = xmemdupz(atom, ep - atom);
+	used_atom[at].deref = deref;
+	used_atom[at].name = xmemdupz(sp, ep - sp);
 	used_atom[at].type = valid_atom[i].cmp_type;
 	used_atom[at].source = valid_atom[i].source;
 	if (used_atom[at].source == SOURCE_OBJ) {
-		if (*atom == '*')
+		if (deref)
 			oi_deref.info.contentp = &oi_deref.content;
 		else
 			oi.info.contentp = &oi.content;
 	}
 	if (arg) {
-		arg = used_atom[at].name + (arg - atom) + 1;
+		arg = used_atom[at].name + (arg - sp) + 1;
 		if (!*arg) {
 			/*
 			 * Treat empty sub-arguments list as NULL (i.e.,
@@ -763,7 +768,7 @@ static int parse_ref_filter_atom(struct ref_format *format,
 	memset(&used_atom[at].u, 0, sizeof(used_atom[at].u));
 	if (valid_atom[i].parser && valid_atom[i].parser(format, &used_atom[at], arg, err))
 		return -1;
-	if (*atom == '*')
+	if (deref)
 		need_tagged = 1;
 	if (i == ATOM_SYMREF)
 		need_symref = 1;
@@ -1096,13 +1101,10 @@ static void grab_common_values(struct atom_value *val, int deref, struct expand_
 	int i;
 
 	for (i = 0; i < used_atom_cnt; i++) {
-		const char *name = used_atom[i].name;
 		enum atom_type atom_type = used_atom[i].atom_type;
 		struct atom_value *v = &val[i];
-		if (!!deref != (*name == '*'))
+		if (!!deref != used_atom[i].deref)
 			continue;
-		if (deref)
-			name++;
 		if (atom_type == ATOM_OBJECTTYPE)
 			v->s = xstrdup(type_name(oi->type));
 		else if (atom_type == ATOM_OBJECTSIZE) {
@@ -1128,13 +1130,10 @@ static void grab_tag_values(struct atom_value *val, int deref, struct object *ob
 	struct tag *tag = (struct tag *) obj;
 
 	for (i = 0; i < used_atom_cnt; i++) {
-		const char *name = used_atom[i].name;
 		enum atom_type atom_type = used_atom[i].atom_type;
 		struct atom_value *v = &val[i];
-		if (!!deref != (*name == '*'))
+		if (!!deref != used_atom[i].deref)
 			continue;
-		if (deref)
-			name++;
 		if (atom_type == ATOM_TAG)
 			v->s = xstrdup(tag->tag);
 		else if (atom_type == ATOM_TYPE && tag->tagged)
@@ -1151,13 +1150,10 @@ static void grab_commit_values(struct atom_value *val, int deref, struct object
 	struct commit *commit = (struct commit *) obj;
 
 	for (i = 0; i < used_atom_cnt; i++) {
-		const char *name = used_atom[i].name;
 		enum atom_type atom_type = used_atom[i].atom_type;
 		struct atom_value *v = &val[i];
-		if (!!deref != (*name == '*'))
+		if (!!deref != used_atom[i].deref)
 			continue;
-		if (deref)
-			name++;
 		if (atom_type == ATOM_TREE) {
 			v->s = xstrdup(do_grab_oid("tree", get_commit_tree_oid(commit), &used_atom[i]));
 			continue;
@@ -1311,10 +1307,8 @@ static void grab_person(enum atom_type type, struct atom_value *val, int deref,
 		const char *name = used_atom[i].name;
 		enum atom_type atom_type = used_atom[i].atom_type;
 		struct atom_value *v = &val[i];
-		if (!!deref != (*name == '*'))
+		if (!!deref != used_atom[i].deref)
 			continue;
-		if (deref)
-			name++;
 		if ((atom_type < type || atom_type > type + 3) &&
 		    /*
 		    * For a tag or a commit object, if "creator" or "creatordate" is
@@ -1430,10 +1424,8 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct exp
 		struct atom_value *v = &val[i];
 		enum atom_type atom_type = atom->atom_type;
 
-		if (!!deref != (*name == '*'))
+		if (!!deref != used_atom[i].deref)
 			continue;
-		if (deref)
-			name++;
 
 		if (atom_type == ATOM_RAW) {
 			unsigned long buf_size = data->size;
@@ -1838,7 +1830,7 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 		enum atom_type atom_type = atom->atom_type;
 		const char *name = used_atom[i].name;
 		struct atom_value *v = &ref->value[i];
-		int deref = 0;
+		int deref = atom->deref;
 		const char *refname;
 		struct branch *branch = NULL;
 
@@ -1846,11 +1838,6 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 		v->handler = append_atom;
 		v->atom = atom;
 
-		if (*name == '*') {
-			deref = 1;
-			name++;
-		}
-
 		if (atom_type == ATOM_REFNAME)
 			refname = get_refname(atom, ref);
 		else if (atom_type == ATOM_WORKTREEPATH) {
-- 
gitgitgadget

