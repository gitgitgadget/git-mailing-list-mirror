Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A8DC433ED
	for <git@archiver.kernel.org>; Thu, 13 May 2021 15:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04C1961438
	for <git@archiver.kernel.org>; Thu, 13 May 2021 15:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234793AbhEMPQ7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 11:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234742AbhEMPQy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 11:16:54 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E00C06175F
        for <git@vger.kernel.org>; Thu, 13 May 2021 08:15:43 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id f75-20020a1c1f4e0000b0290171001e7329so34229wmf.1
        for <git@vger.kernel.org>; Thu, 13 May 2021 08:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=T56PRDoWfFLugIME2TSY/f3480iv8uH3yBtf/ChLyvY=;
        b=hIZgND4vuDt6gFzDG5N9Isor8jOmDNImKtg2AXnSaBe37vFVfFEKtXAQ64x4//Teep
         YDUr4SXBmqz0hRXdj9XRJdNXB5Dd28KEj6HQe8lv5AGMCt40tlnCT94BSC4PtHlc447T
         NFPX7kBv7BV0ekiOgUc70HQN3Htw6tXpMJGN2g9nlVj1r++uVrehTi3xqeYt5KUCqLc+
         A7ixylEFWG4osY5pRFnJhVG49whRoWePUtxDSS/Im3Tzr4wrhLDPOKK30TyA706PqV60
         RIX7wp/5gYD3gWwrMYXzdihD28Q0GPVgEY7pKQmk3oTKcnsDWTZrXRvp1zbyxeSiAfQ2
         9nNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=T56PRDoWfFLugIME2TSY/f3480iv8uH3yBtf/ChLyvY=;
        b=Vc3VGqQQ+HrgrqDaIIDhtv81SqIbniMuksqKGjVUo3rxqnP6NPSRxzdOIXtLdkFDCA
         IJUaayr9PJy1MsvBg09FkAyEqzSgjc+hqXeDjc8tG4//JFtBxHaSpPt/Ikzc284ooVrX
         kXemyjpLUm4N88MthTl+Jfisko01vsQeiGBCDqXd8aIMnL8uM6U/P0b3xCe9xHJqy/Bh
         oYrG1kB8qfbyibH+8kcvFyPTgpDB8cLL+bLREBlEW2BXsphijRZkROCYR05w1jfH2gKG
         b73/+LSJPGCC/KpRwTfBDivCYgpHTnakGntCM7+syVyi9XEQIL8t1CMOe4YA29tlfNzs
         5X3A==
X-Gm-Message-State: AOAM530/TUoaoGuG2T9HECFmqZTCxriga530AzbppD+nLx/bugl+K9j6
        Olk+bJDtnimO7Wwn0hMdeBVHtiguVKw=
X-Google-Smtp-Source: ABdhPJwx/5tbSKBUj/vNka5aUDPSrBA8AYAtRqHMgOEXxRROlqw4sHBJ4dDUAzaYB8h85ipGuMmOcA==
X-Received: by 2002:a05:600c:2cd2:: with SMTP id l18mr21309514wmc.142.1620918942282;
        Thu, 13 May 2021 08:15:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p1sm3114168wrs.50.2021.05.13.08.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 08:15:41 -0700 (PDT)
Message-Id: <50cfe1f0c6c1394c8b3729cb603ea7ab071f9676.1620918939.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.951.v4.git.1620918939.gitgitgadget@gmail.com>
References: <pull.951.v3.git.1620821464.gitgitgadget@gmail.com>
        <pull.951.v4.git.1620918939.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 13 May 2021 15:15:38 +0000
Subject: [PATCH v4 2/2] [GSOC] ref-filter: introduce enum atom_type
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Hariom Verma <hariom18599@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
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

Introduce the enum "atom_type", each enum value is named
as `ATOM_*`, which is the index of each corresponding
valid_atom entry. In the first step of the atom parsing,
`used_atom.atom_type` will record corresponding enum value
from valid_atom entry index, and then in specific reference
attribute filling step, only need to compare the value of
the `used_atom[i].atom_type` to check the atom type.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Christian Couder <christian.couder@gmail.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 ref-filter.c | 197 +++++++++++++++++++++++++++++++++------------------
 1 file changed, 128 insertions(+), 69 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index f420bae6e5ba..e7a48d428547 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -108,6 +108,56 @@ static struct ref_to_worktree_map {
 	struct worktree **worktrees;
 } ref_to_worktree_map;
 
+/*
+ * The enum atom_type is used as the index of valid_atom array.
+ * In the atom parsing stage, it will be passed to used_atom.atom_type
+ * as the identifier of the atom type. We can check the type of used_atom
+ * entry by `if (used_atom[i].atom_type == ATOM_*)`.
+ */
+enum atom_type {
+	ATOM_REFNAME,
+	ATOM_OBJECTTYPE,
+	ATOM_OBJECTSIZE,
+	ATOM_OBJECTNAME,
+	ATOM_DELTABASE,
+	ATOM_TREE,
+	ATOM_PARENT,
+	ATOM_NUMPARENT,
+	ATOM_OBJECT,
+	ATOM_TYPE,
+	ATOM_TAG,
+	ATOM_AUTHOR,
+	ATOM_AUTHORNAME,
+	ATOM_AUTHOREMAIL,
+	ATOM_AUTHORDATE,
+	ATOM_COMMITTER,
+	ATOM_COMMITTERNAME,
+	ATOM_COMMITTEREMAIL,
+	ATOM_COMMITTERDATE,
+	ATOM_TAGGER,
+	ATOM_TAGGERNAME,
+	ATOM_TAGGEREMAIL,
+	ATOM_TAGGERDATE,
+	ATOM_CREATOR,
+	ATOM_CREATORDATE,
+	ATOM_SUBJECT,
+	ATOM_BODY,
+	ATOM_TRAILERS,
+	ATOM_CONTENTS,
+	ATOM_UPSTREAM,
+	ATOM_PUSH,
+	ATOM_SYMREF,
+	ATOM_FLAG,
+	ATOM_HEAD,
+	ATOM_COLOR,
+	ATOM_WORKTREEPATH,
+	ATOM_ALIGN,
+	ATOM_END,
+	ATOM_IF,
+	ATOM_THEN,
+	ATOM_ELSE,
+};
+
 /*
  * An atom is a valid field atom listed below, possibly prefixed with
  * a "*" to denote deref_tag().
@@ -119,6 +169,7 @@ static struct ref_to_worktree_map {
  * array.
  */
 static struct used_atom {
+	enum atom_type atom_type;
 	const char *name;
 	cmp_type type;
 	info_source source;
@@ -506,47 +557,47 @@ static struct {
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
+	[ATOM_REFNAME] = { "refname", SOURCE_NONE, FIELD_STR, refname_atom_parser },
+	[ATOM_OBJECTTYPE] = { "objecttype", SOURCE_OTHER, FIELD_STR, objecttype_atom_parser },
+	[ATOM_OBJECTSIZE] = { "objectsize", SOURCE_OTHER, FIELD_ULONG, objectsize_atom_parser },
+	[ATOM_OBJECTNAME] = { "objectname", SOURCE_OTHER, FIELD_STR, oid_atom_parser },
+	[ATOM_DELTABASE] = { "deltabase", SOURCE_OTHER, FIELD_STR, deltabase_atom_parser },
+	[ATOM_TREE] = { "tree", SOURCE_OBJ, FIELD_STR, oid_atom_parser },
+	[ATOM_PARENT] = { "parent", SOURCE_OBJ, FIELD_STR, oid_atom_parser },
+	[ATOM_NUMPARENT] = { "numparent", SOURCE_OBJ, FIELD_ULONG },
+	[ATOM_OBJECT] = { "object", SOURCE_OBJ },
+	[ATOM_TYPE] = { "type", SOURCE_OBJ },
+	[ATOM_TAG] = { "tag", SOURCE_OBJ },
+	[ATOM_AUTHOR] = { "author", SOURCE_OBJ },
+	[ATOM_AUTHORNAME] = { "authorname", SOURCE_OBJ },
+	[ATOM_AUTHOREMAIL] = { "authoremail", SOURCE_OBJ, FIELD_STR, person_email_atom_parser },
+	[ATOM_AUTHORDATE] = { "authordate", SOURCE_OBJ, FIELD_TIME },
+	[ATOM_COMMITTER] = { "committer", SOURCE_OBJ },
+	[ATOM_COMMITTERNAME] = { "committername", SOURCE_OBJ },
+	[ATOM_COMMITTEREMAIL] = { "committeremail", SOURCE_OBJ, FIELD_STR, person_email_atom_parser },
+	[ATOM_COMMITTERDATE] = { "committerdate", SOURCE_OBJ, FIELD_TIME },
+	[ATOM_TAGGER] = { "tagger", SOURCE_OBJ },
+	[ATOM_TAGGERNAME] = { "taggername", SOURCE_OBJ },
+	[ATOM_TAGGEREMAIL] = { "taggeremail", SOURCE_OBJ, FIELD_STR, person_email_atom_parser },
+	[ATOM_TAGGERDATE] = { "taggerdate", SOURCE_OBJ, FIELD_TIME },
+	[ATOM_CREATOR] = { "creator", SOURCE_OBJ },
+	[ATOM_CREATORDATE] = { "creatordate", SOURCE_OBJ, FIELD_TIME },
+	[ATOM_SUBJECT] = { "subject", SOURCE_OBJ, FIELD_STR, subject_atom_parser },
+	[ATOM_BODY] = { "body", SOURCE_OBJ, FIELD_STR, body_atom_parser },
+	[ATOM_TRAILERS] = { "trailers", SOURCE_OBJ, FIELD_STR, trailers_atom_parser },
+	[ATOM_CONTENTS] = { "contents", SOURCE_OBJ, FIELD_STR, contents_atom_parser },
+	[ATOM_UPSTREAM] = { "upstream", SOURCE_NONE, FIELD_STR, remote_ref_atom_parser },
+	[ATOM_PUSH] = { "push", SOURCE_NONE, FIELD_STR, remote_ref_atom_parser },
+	[ATOM_SYMREF] = { "symref", SOURCE_NONE, FIELD_STR, refname_atom_parser },
+	[ATOM_FLAG] = { "flag", SOURCE_NONE },
+	[ATOM_HEAD] = { "HEAD", SOURCE_NONE, FIELD_STR, head_atom_parser },
+	[ATOM_COLOR] = { "color", SOURCE_NONE, FIELD_STR, color_atom_parser },
+	[ATOM_WORKTREEPATH] = { "worktreepath", SOURCE_NONE },
+	[ATOM_ALIGN] = { "align", SOURCE_NONE, FIELD_STR, align_atom_parser },
+	[ATOM_END] = { "end", SOURCE_NONE },
+	[ATOM_IF] = { "if", SOURCE_NONE, FIELD_STR, if_atom_parser },
+	[ATOM_THEN] = { "then", SOURCE_NONE },
+	[ATOM_ELSE] = { "else", SOURCE_NONE },
 	/*
 	 * Please update $__git_ref_fieldlist in git-completion.bash
 	 * when you add new atoms
@@ -628,6 +679,7 @@ static int parse_ref_filter_atom(const struct ref_format *format,
 	at = used_atom_cnt;
 	used_atom_cnt++;
 	REALLOC_ARRAY(used_atom, used_atom_cnt);
+	used_atom[at].atom_type = i;
 	used_atom[at].name = xmemdupz(atom, ep - atom);
 	used_atom[at].type = valid_atom[i].cmp_type;
 	used_atom[at].source = valid_atom[i].source;
@@ -652,7 +704,7 @@ static int parse_ref_filter_atom(const struct ref_format *format,
 		return -1;
 	if (*atom == '*')
 		need_tagged = 1;
-	if (!strcmp(valid_atom[i].name, "symref"))
+	if (i == ATOM_SYMREF)
 		need_symref = 1;
 	return at;
 }
@@ -965,14 +1017,15 @@ static void grab_common_values(struct atom_value *val, int deref, struct expand_
 
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
@@ -980,9 +1033,9 @@ static void grab_common_values(struct atom_value *val, int deref, struct expand_
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
@@ -995,16 +1048,17 @@ static void grab_tag_values(struct atom_value *val, int deref, struct object *ob
 
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
@@ -1017,18 +1071,20 @@ static void grab_commit_values(struct atom_value *val, int deref, struct object
 
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
@@ -1208,15 +1264,16 @@ static void grab_person(const char *who, struct atom_value *val, int deref, void
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
@@ -1696,6 +1753,7 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 	/* Fill in specials first */
 	for (i = 0; i < used_atom_cnt; i++) {
 		struct used_atom *atom = &used_atom[i];
+		enum atom_type atom_type = atom->atom_type;
 		const char *name = used_atom[i].name;
 		struct atom_value *v = &ref->value[i];
 		int deref = 0;
@@ -1710,18 +1768,18 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
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
@@ -1737,7 +1795,7 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 			else
 				v->s = xstrdup("");
 			continue;
-		} else if (atom->u.remote_ref.push) {
+		} else if (atom_type == ATOM_PUSH && atom->u.remote_ref.push) {
 			const char *branch_name;
 			v->s = xstrdup("");
 			if (!skip_prefix(ref->refname, "refs/heads/",
@@ -1756,10 +1814,10 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
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
@@ -1772,23 +1830,24 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
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
@@ -1796,11 +1855,11 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
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
