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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0E4C433ED
	for <git@archiver.kernel.org>; Sat,  8 May 2021 15:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB4F561261
	for <git@archiver.kernel.org>; Sat,  8 May 2021 15:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbhEHPXj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 May 2021 11:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhEHPXi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 May 2021 11:23:38 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02754C061574
        for <git@vger.kernel.org>; Sat,  8 May 2021 08:22:37 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id a4so12147922wrr.2
        for <git@vger.kernel.org>; Sat, 08 May 2021 08:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Jt+HstnTPth8kXdnTmoeYGuysb5li5GYdWd1/JW0Df0=;
        b=bruhOD22aLAOBacUBkYjHEucEKYi/dqInjsNjvzp8FpWnRCVvOgMxlMY22nLQmfkVf
         lvkzgd4O6/oAFeKTovm0mZp3VepIHz5zCl2ohqQ9JTpnpW0ZbbqLbbn+Vm38tmc9Nx/h
         J6bdcVZhNYmq5UmhPkRpR0Upn7dRPDzUZzfVIPGVAVmnScFxQQ9O/EycIPltPv82jY6b
         BYOdKzPlhMrn6/R0Q1n0tLdh+0ML6bztlLhMPNcPCs4H7T5Szg8IvGEgbAWR3leRkqWN
         Nq2SM4jWXArsi6K4xXqUqcax+SNXYn6PKG3JF/fPnGOlepVdTDbA9rX+lU7yv8tgxfhm
         9Geg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Jt+HstnTPth8kXdnTmoeYGuysb5li5GYdWd1/JW0Df0=;
        b=PkQnmujxGVhnRQyGseg3nEO65runVJ3pwtMtCLgZ+vmaQ1+UJXNP1ux+Ul1miNDJlx
         H8K2pvtBTnD/wYDEj+GMqawmie/9XSyPlR6kudZXuOU7Pr+vU2kuBjdyQ0OrG3FCUO9x
         ygkbyri/O0iCXaacTpzw1aFN8KKXEdGLLWEWMW781VyrI3mn7BHG6rWuDVVUCJA07NAH
         LS9imsLO1nIA46tn7ye++5GyJV1Vzj223fM7SzR8B5a3Ih1tPdMqC+1XsEuSbYiovt5C
         o7gzR844XTs5DMIPm8xD/s3kw/YOhmt3jQ6waKv0I5d70l2gN4w4Q3Nq/WVWSzd0Ciok
         km1g==
X-Gm-Message-State: AOAM530/bKEIrAdgnHePVswj3ihW9S+8tqddzgPmPJd+7iyM3nDDn17I
        C3X5wnpdG/xN1Q0oTu/vj68IFKk8ABo=
X-Google-Smtp-Source: ABdhPJwiv04CKmZaiFOQ7SxZpcIHxg/9TLkEDz02zfzG/M6QgSKbSKHOb2U4h+bjf3RnMsnIdVRwTA==
X-Received: by 2002:a5d:58d8:: with SMTP id o24mr20091701wrf.288.1620487355726;
        Sat, 08 May 2021 08:22:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q16sm11647628wmj.24.2021.05.08.08.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 May 2021 08:22:35 -0700 (PDT)
Message-Id: <3770df1829830229e768607b699730d2a7c21c5e.1620487353.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.951.git.1620487353.gitgitgadget@gmail.com>
References: <pull.951.git.1620487353.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 08 May 2021 15:22:32 +0000
Subject: [PATCH 2/2] [GSOC][RFC] ref-filter: introduce enum atom_type
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Hariom Verma <hariom18599@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

In the original ref-filter design, it will copy the parsed
atom's name and attributes to `used_atom[i].name` in the
atom's parsing step, and use it again for string matching
in the later specific ref attributes filling step. It use
a lot of string matching to determine which atom we need.

Introduce the enum member `valid_atom.atom_type` which
record type of each valid_atom, in the first step of the
atom parsing, `used_atom.atom_type` will record corresponding
enum value from `valid_atom.atom_type`, and then in specific
reference attribute filling step, only need to compare the
value of the `used_atom.atom_type` to judge the atom type.

At the same time, The value of an atom_type is the coordinate
of its corresponding valid_atom entry, we can quickly index
to the corresponding valid_atom entry by the atom_type value.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 ref-filter.c | 192 +++++++++++++++++++++++++++++++++------------------
 1 file changed, 123 insertions(+), 69 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index f420bae6e5ba..4ce46e70dc99 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -108,6 +108,50 @@ static struct ref_to_worktree_map {
 	struct worktree **worktrees;
 } ref_to_worktree_map;
 
+enum atom_type {
+ATOM_REFNAME,
+ATOM_OBJECTTYPE,
+ATOM_OBJECTSIZE,
+ATOM_OBJECTNAME,
+ATOM_DELTABASE,
+ATOM_TREE,
+ATOM_PARENT,
+ATOM_NUMPARENT,
+ATOM_OBJECT,
+ATOM_TYPE,
+ATOM_TAG,
+ATOM_AUTHOR,
+ATOM_AUTHORNAME,
+ATOM_AUTHOREMAIL,
+ATOM_AUTHORDATE,
+ATOM_COMMITTER,
+ATOM_COMMITTERNAME,
+ATOM_COMMITTEREMAIL,
+ATOM_COMMITTERDATE,
+ATOM_TAGGER,
+ATOM_TAGGERNAME,
+ATOM_TAGGEREMAIL,
+ATOM_TAGGERDATE,
+ATOM_CREATOR,
+ATOM_CREATORDATE,
+ATOM_SUBJECT,
+ATOM_BODY,
+ATOM_TRAILERS,
+ATOM_CONTENTS,
+ATOM_UPSTREAM,
+ATOM_PUSH,
+ATOM_SYMREF,
+ATOM_FLAG,
+ATOM_HEAD,
+ATOM_COLOR,
+ATOM_WORKTREEPATH,
+ATOM_ALIGN,
+ATOM_END,
+ATOM_IF,
+ATOM_THEN,
+ATOM_ELSE,
+};
+
 /*
  * An atom is a valid field atom listed below, possibly prefixed with
  * a "*" to denote deref_tag().
@@ -122,6 +166,7 @@ static struct used_atom {
 	const char *name;
 	cmp_type type;
 	info_source source;
+	enum atom_type atom_type;
 	union {
 		char color[COLOR_MAXLEN];
 		struct align align;
@@ -500,53 +545,54 @@ static int head_atom_parser(const struct ref_format *format, struct used_atom *a
 }
 
 static struct {
+	enum atom_type atom_type;
 	const char *name;
 	info_source source;
 	cmp_type cmp_type;
 	int (*parser)(const struct ref_format *format, struct used_atom *atom,
 		      const char *arg, struct strbuf *err);
 } valid_atom[] = {
-	{ "refname", SOURCE_NONE, FIELD_STR, refname_atom_parser },
-	{ "objecttype", SOURCE_OTHER, FIELD_STR, objecttype_atom_parser },
-	{ "objectsize", SOURCE_OTHER, FIELD_ULONG, objectsize_atom_parser },
-	{ "objectname", SOURCE_OTHER, FIELD_STR, oid_atom_parser },
-	{ "deltabase", SOURCE_OTHER, FIELD_STR, deltabase_atom_parser },
-	{ "tree", SOURCE_OBJ, FIELD_STR, oid_atom_parser },
-	{ "parent", SOURCE_OBJ, FIELD_STR, oid_atom_parser },
-	{ "numparent", SOURCE_OBJ, FIELD_ULONG },
-	{ "object", SOURCE_OBJ },
-	{ "type", SOURCE_OBJ },
-	{ "tag", SOURCE_OBJ },
-	{ "author", SOURCE_OBJ },
-	{ "authorname", SOURCE_OBJ },
-	{ "authoremail", SOURCE_OBJ, FIELD_STR, person_email_atom_parser },
-	{ "authordate", SOURCE_OBJ, FIELD_TIME },
-	{ "committer", SOURCE_OBJ },
-	{ "committername", SOURCE_OBJ },
-	{ "committeremail", SOURCE_OBJ, FIELD_STR, person_email_atom_parser },
-	{ "committerdate", SOURCE_OBJ, FIELD_TIME },
-	{ "tagger", SOURCE_OBJ },
-	{ "taggername", SOURCE_OBJ },
-	{ "taggeremail", SOURCE_OBJ, FIELD_STR, person_email_atom_parser },
-	{ "taggerdate", SOURCE_OBJ, FIELD_TIME },
-	{ "creator", SOURCE_OBJ },
-	{ "creatordate", SOURCE_OBJ, FIELD_TIME },
-	{ "subject", SOURCE_OBJ, FIELD_STR, subject_atom_parser },
-	{ "body", SOURCE_OBJ, FIELD_STR, body_atom_parser },
-	{ "trailers", SOURCE_OBJ, FIELD_STR, trailers_atom_parser },
-	{ "contents", SOURCE_OBJ, FIELD_STR, contents_atom_parser },
-	{ "upstream", SOURCE_NONE, FIELD_STR, remote_ref_atom_parser },
-	{ "push", SOURCE_NONE, FIELD_STR, remote_ref_atom_parser },
-	{ "symref", SOURCE_NONE, FIELD_STR, refname_atom_parser },
-	{ "flag", SOURCE_NONE },
-	{ "HEAD", SOURCE_NONE, FIELD_STR, head_atom_parser },
-	{ "color", SOURCE_NONE, FIELD_STR, color_atom_parser },
-	{ "worktreepath", SOURCE_NONE },
-	{ "align", SOURCE_NONE, FIELD_STR, align_atom_parser },
-	{ "end", SOURCE_NONE },
-	{ "if", SOURCE_NONE, FIELD_STR, if_atom_parser },
-	{ "then", SOURCE_NONE },
-	{ "else", SOURCE_NONE },
+	{ ATOM_REFNAME, "refname", SOURCE_NONE, FIELD_STR, refname_atom_parser },
+	{ ATOM_OBJECTTYPE, "objecttype", SOURCE_OTHER, FIELD_STR, objecttype_atom_parser },
+	{ ATOM_OBJECTSIZE, "objectsize", SOURCE_OTHER, FIELD_ULONG, objectsize_atom_parser },
+	{ ATOM_OBJECTNAME, "objectname", SOURCE_OTHER, FIELD_STR, oid_atom_parser },
+	{ ATOM_DELTABASE, "deltabase", SOURCE_OTHER, FIELD_STR, deltabase_atom_parser },
+	{ ATOM_TREE, "tree", SOURCE_OBJ, FIELD_STR, oid_atom_parser },
+	{ ATOM_PARENT, "parent", SOURCE_OBJ, FIELD_STR, oid_atom_parser },
+	{ ATOM_NUMPARENT, "numparent", SOURCE_OBJ, FIELD_ULONG },
+	{ ATOM_OBJECT, "object", SOURCE_OBJ },
+	{ ATOM_TYPE, "type", SOURCE_OBJ },
+	{ ATOM_TAG, "tag", SOURCE_OBJ },
+	{ ATOM_AUTHOR, "author", SOURCE_OBJ },
+	{ ATOM_AUTHORNAME, "authorname", SOURCE_OBJ },
+	{ ATOM_AUTHOREMAIL, "authoremail", SOURCE_OBJ, FIELD_STR, person_email_atom_parser },
+	{ ATOM_AUTHORDATE, "authordate", SOURCE_OBJ, FIELD_TIME },
+	{ ATOM_COMMITTER, "committer", SOURCE_OBJ },
+	{ ATOM_COMMITTERNAME, "committername", SOURCE_OBJ },
+	{ ATOM_COMMITTEREMAIL, "committeremail", SOURCE_OBJ, FIELD_STR, person_email_atom_parser },
+	{ ATOM_COMMITTERDATE, "committerdate", SOURCE_OBJ, FIELD_TIME },
+	{ ATOM_TAGGER, "tagger", SOURCE_OBJ },
+	{ ATOM_TAGGERNAME, "taggername", SOURCE_OBJ },
+	{ ATOM_TAGGEREMAIL, "taggeremail", SOURCE_OBJ, FIELD_STR, person_email_atom_parser },
+	{ ATOM_TAGGERDATE, "taggerdate", SOURCE_OBJ, FIELD_TIME },
+	{ ATOM_CREATOR, "creator", SOURCE_OBJ },
+	{ ATOM_CREATORDATE, "creatordate", SOURCE_OBJ, FIELD_TIME },
+	{ ATOM_SUBJECT, "subject", SOURCE_OBJ, FIELD_STR, subject_atom_parser },
+	{ ATOM_BODY, "body", SOURCE_OBJ, FIELD_STR, body_atom_parser },
+	{ ATOM_TRAILERS, "trailers", SOURCE_OBJ, FIELD_STR, trailers_atom_parser },
+	{ ATOM_CONTENTS, "contents", SOURCE_OBJ, FIELD_STR, contents_atom_parser },
+	{ ATOM_UPSTREAM, "upstream", SOURCE_NONE, FIELD_STR, remote_ref_atom_parser },
+	{ ATOM_PUSH, "push", SOURCE_NONE, FIELD_STR, remote_ref_atom_parser },
+	{ ATOM_SYMREF, "symref", SOURCE_NONE, FIELD_STR, refname_atom_parser },
+	{ ATOM_FLAG, "flag", SOURCE_NONE },
+	{ ATOM_HEAD, "HEAD", SOURCE_NONE, FIELD_STR, head_atom_parser },
+	{ ATOM_COLOR, "color", SOURCE_NONE, FIELD_STR, color_atom_parser },
+	{ ATOM_WORKTREEPATH, "worktreepath", SOURCE_NONE },
+	{ ATOM_ALIGN, "align", SOURCE_NONE, FIELD_STR, align_atom_parser },
+	{ ATOM_END, "end", SOURCE_NONE },
+	{ ATOM_IF, "if", SOURCE_NONE, FIELD_STR, if_atom_parser },
+	{ ATOM_THEN, "then", SOURCE_NONE },
+	{ ATOM_ELSE, "else", SOURCE_NONE },
 	/*
 	 * Please update $__git_ref_fieldlist in git-completion.bash
 	 * when you add new atoms
@@ -628,6 +674,7 @@ static int parse_ref_filter_atom(const struct ref_format *format,
 	at = used_atom_cnt;
 	used_atom_cnt++;
 	REALLOC_ARRAY(used_atom, used_atom_cnt);
+	used_atom[at].atom_type = valid_atom[i].atom_type;
 	used_atom[at].name = xmemdupz(atom, ep - atom);
 	used_atom[at].type = valid_atom[i].cmp_type;
 	used_atom[at].source = valid_atom[i].source;
@@ -652,7 +699,7 @@ static int parse_ref_filter_atom(const struct ref_format *format,
 		return -1;
 	if (*atom == '*')
 		need_tagged = 1;
-	if (!strcmp(valid_atom[i].name, "symref"))
+	if (valid_atom[i].atom_type == ATOM_SYMREF)
 		need_symref = 1;
 	return at;
 }
@@ -965,14 +1012,15 @@ static void grab_common_values(struct atom_value *val, int deref, struct expand_
 
 	for (i = 0; i < used_atom_cnt; i++) {
 		const char *name = used_atom[i].name;
+		enum atom_type atom_type = used_atom[i].atom_type;
 		struct atom_value *v = &val[i];
 		if (!!deref != (*name == '*'))
 			continue;
 		if (deref)
 			name++;
-		if (!strcmp(name, "objecttype"))
+		if (atom_type == ATOM_OBJECTTYPE)
 			v->s = xstrdup(type_name(oi->type));
-		else if (starts_with(name, "objectsize")) {
+		else if (atom_type == ATOM_OBJECTSIZE) {
 			if (used_atom[i].u.objectsize.option == O_SIZE_DISK) {
 				v->value = oi->disk_size;
 				v->s = xstrfmt("%"PRIuMAX, (uintmax_t)oi->disk_size);
@@ -980,9 +1028,9 @@ static void grab_common_values(struct atom_value *val, int deref, struct expand_
 				v->value = oi->size;
 				v->s = xstrfmt("%"PRIuMAX , (uintmax_t)oi->size);
 			}
-		} else if (!strcmp(name, "deltabase"))
+		} else if (atom_type == ATOM_DELTABASE)
 			v->s = xstrdup(oid_to_hex(&oi->delta_base_oid));
-		else if (deref)
+		else if (atom_type == ATOM_OBJECTNAME && deref)
 			grab_oid(name, "objectname", &oi->oid, v, &used_atom[i]);
 	}
 }
@@ -995,16 +1043,17 @@ static void grab_tag_values(struct atom_value *val, int deref, struct object *ob
 
 	for (i = 0; i < used_atom_cnt; i++) {
 		const char *name = used_atom[i].name;
+		enum atom_type atom_type = used_atom[i].atom_type;
 		struct atom_value *v = &val[i];
 		if (!!deref != (*name == '*'))
 			continue;
 		if (deref)
 			name++;
-		if (!strcmp(name, "tag"))
+		if (atom_type == ATOM_TAG)
 			v->s = xstrdup(tag->tag);
-		else if (!strcmp(name, "type") && tag->tagged)
+		else if (atom_type == ATOM_TYPE && tag->tagged)
 			v->s = xstrdup(type_name(tag->tagged->type));
-		else if (!strcmp(name, "object") && tag->tagged)
+		else if (atom_type == ATOM_OBJECT && tag->tagged)
 			v->s = xstrdup(oid_to_hex(&tag->tagged->oid));
 	}
 }
@@ -1017,18 +1066,20 @@ static void grab_commit_values(struct atom_value *val, int deref, struct object
 
 	for (i = 0; i < used_atom_cnt; i++) {
 		const char *name = used_atom[i].name;
+		enum atom_type atom_type = used_atom[i].atom_type;
 		struct atom_value *v = &val[i];
 		if (!!deref != (*name == '*'))
 			continue;
 		if (deref)
 			name++;
-		if (grab_oid(name, "tree", get_commit_tree_oid(commit), v, &used_atom[i]))
+		if (atom_type == ATOM_TREE &&
+		    grab_oid(name, "tree", get_commit_tree_oid(commit), v, &used_atom[i]))
 			continue;
-		if (!strcmp(name, "numparent")) {
+		if (atom_type == ATOM_NUMPARENT) {
 			v->value = commit_list_count(commit->parents);
 			v->s = xstrfmt("%lu", (unsigned long)v->value);
 		}
-		else if (starts_with(name, "parent")) {
+		else if (atom_type == ATOM_PARENT) {
 			struct commit_list *parents;
 			struct strbuf s = STRBUF_INIT;
 			for (parents = commit->parents; parents; parents = parents->next) {
@@ -1208,15 +1259,16 @@ static void grab_person(const char *who, struct atom_value *val, int deref, void
 		return;
 	for (i = 0; i < used_atom_cnt; i++) {
 		const char *name = used_atom[i].name;
+		enum atom_type atom_type = used_atom[i].atom_type;
 		struct atom_value *v = &val[i];
 		if (!!deref != (*name == '*'))
 			continue;
 		if (deref)
 			name++;
 
-		if (starts_with(name, "creatordate"))
+		if (atom_type == ATOM_CREATORDATE)
 			grab_date(wholine, v, name);
-		else if (!strcmp(name, "creator"))
+		else if (atom_type == ATOM_CREATOR)
 			v->s = copy_line(wholine);
 	}
 }
@@ -1696,6 +1748,7 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 	/* Fill in specials first */
 	for (i = 0; i < used_atom_cnt; i++) {
 		struct used_atom *atom = &used_atom[i];
+		enum atom_type atom_type = atom->atom_type;
 		const char *name = used_atom[i].name;
 		struct atom_value *v = &ref->value[i];
 		int deref = 0;
@@ -1710,18 +1763,18 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 			name++;
 		}
 
-		if (starts_with(name, "refname"))
+		if (atom_type == ATOM_REFNAME)
 			refname = get_refname(atom, ref);
-		else if (!strcmp(name, "worktreepath")) {
+		else if (atom_type == ATOM_WORKTREEPATH) {
 			if (ref->kind == FILTER_REFS_BRANCHES)
 				v->s = get_worktree_path(atom, ref);
 			else
 				v->s = xstrdup("");
 			continue;
 		}
-		else if (starts_with(name, "symref"))
+		else if (atom_type == ATOM_SYMREF)
 			refname = get_symref(atom, ref);
-		else if (starts_with(name, "upstream")) {
+		else if (atom_type == ATOM_UPSTREAM) {
 			const char *branch_name;
 			/* only local branches may have an upstream */
 			if (!skip_prefix(ref->refname, "refs/heads/",
@@ -1737,7 +1790,7 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 			else
 				v->s = xstrdup("");
 			continue;
-		} else if (atom->u.remote_ref.push) {
+		} else if (atom_type == ATOM_PUSH && atom->u.remote_ref.push) {
 			const char *branch_name;
 			v->s = xstrdup("");
 			if (!skip_prefix(ref->refname, "refs/heads/",
@@ -1756,10 +1809,10 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 			free((char *)v->s);
 			fill_remote_ref_details(atom, refname, branch, &v->s);
 			continue;
-		} else if (starts_with(name, "color:")) {
+		} else if (atom_type == ATOM_COLOR) {
 			v->s = xstrdup(atom->u.color);
 			continue;
-		} else if (!strcmp(name, "flag")) {
+		} else if (atom_type == ATOM_FLAG) {
 			char buf[256], *cp = buf;
 			if (ref->flag & REF_ISSYMREF)
 				cp = copy_advance(cp, ",symref");
@@ -1772,23 +1825,24 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 				v->s = xstrdup(buf + 1);
 			}
 			continue;
-		} else if (!deref && grab_oid(name, "objectname", &ref->objectname, v, atom)) {
-			continue;
-		} else if (!strcmp(name, "HEAD")) {
+		} else if (!deref && atom_type == ATOM_OBJECTNAME &&
+			   grab_oid(name, "objectname", &ref->objectname, v, atom)) {
+				continue;
+		} else if (atom_type == ATOM_HEAD) {
 			if (atom->u.head && !strcmp(ref->refname, atom->u.head))
 				v->s = xstrdup("*");
 			else
 				v->s = xstrdup(" ");
 			continue;
-		} else if (starts_with(name, "align")) {
+		} else if (atom_type == ATOM_ALIGN) {
 			v->handler = align_atom_handler;
 			v->s = xstrdup("");
 			continue;
-		} else if (!strcmp(name, "end")) {
+		} else if (atom_type == ATOM_END) {
 			v->handler = end_atom_handler;
 			v->s = xstrdup("");
 			continue;
-		} else if (starts_with(name, "if")) {
+		} else if (atom_type == ATOM_IF) {
 			const char *s;
 			if (skip_prefix(name, "if:", &s))
 				v->s = xstrdup(s);
@@ -1796,11 +1850,11 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 				v->s = xstrdup("");
 			v->handler = if_atom_handler;
 			continue;
-		} else if (!strcmp(name, "then")) {
+		} else if (atom_type == ATOM_THEN) {
 			v->handler = then_atom_handler;
 			v->s = xstrdup("");
 			continue;
-		} else if (!strcmp(name, "else")) {
+		} else if (atom_type == ATOM_ELSE) {
 			v->handler = else_atom_handler;
 			v->s = xstrdup("");
 			continue;
-- 
gitgitgadget
