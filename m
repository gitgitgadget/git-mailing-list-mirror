Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55B771F406
	for <e@80x24.org>; Tue,  9 Jan 2018 13:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757211AbeAINGE (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 08:06:04 -0500
Received: from a7-17.smtp-out.eu-west-1.amazonses.com ([54.240.7.17]:38574
        "EHLO a7-17.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1757007AbeAINFZ (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 9 Jan 2018 08:05:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1515503123;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=ApaChL99tduSwDd/iljahi5q6ko9i3tMBB7G4QIIEtg=;
        b=h0QHJ3ZB8U5es8JqolG7gWz3+3Ij5uij9Cj7jC0/IhAfaJ676WRijUize0Lvx32y
        e2ipVxCteLYcrEqvdULeHIv8pTApeyl0FbF1n2iBNRkj48+4sZGGNAUSwIrsBRewqVS
        BhtezbvTdkH2OuTQU0QgeCu6ekyUAHU8/U4EI09c=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020160db067bde-7f500636-b80e-4099-a84e-2613126c9aa1-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020160db0679c9-799a0bc4-b6d1-43e2-ad3b-80be4e4c55e9-000000@eu-west-1.amazonses.com>
References: <01020160db0679c9-799a0bc4-b6d1-43e2-ad3b-80be4e4c55e9-000000@eu-west-1.amazonses.com>
Subject: [PATCH 03/20] cat-file: rename variables in ref-filter
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Tue, 9 Jan 2018 13:05:23 +0000
X-SES-Outgoing: 2018.01.09-54.240.7.17
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename some variables for easier reading.
They point not to values, but to arrays.
Added "s" ending so that it could be obvious.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored by: Jeff King <peff@peff.net>
---
 ref-filter.c | 60 ++++++++++++++++++++++++++++++------------------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 3f9161707e66b..1426f0c28bce7 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -98,7 +98,7 @@ static struct used_atom {
 		struct refname_atom refname;
 		char *head;
 	} u;
-} *used_atom;
+} *used_atoms;
 static int used_atom_cnt, need_tagged, need_symref;
 
 static void color_atom_parser(const struct ref_format *format, struct used_atom *atom, const char *color_value)
@@ -325,11 +325,11 @@ static void head_atom_parser(const struct ref_format *format, struct used_atom *
 	atom->u.head = resolve_refdup("HEAD", RESOLVE_REF_READING, NULL, NULL);
 }
 
-static struct {
+static struct valid_atom {
 	const char *name;
 	cmp_type cmp_type;
 	void (*parser)(const struct ref_format *format, struct used_atom *atom, const char *arg);
-} valid_atom[] = {
+} valid_atoms[] = {
 	{ "refname" , FIELD_STR, refname_atom_parser },
 	{ "objecttype" },
 	{ "objectsize", FIELD_ULONG },
@@ -410,38 +410,38 @@ static int parse_ref_filter_atom(const struct ref_format *format,
 
 	/* Do we have the atom already used elsewhere? */
 	for (i = 0; i < used_atom_cnt; i++) {
-		int len = strlen(used_atom[i].name);
-		if (len == ep - atom && !memcmp(used_atom[i].name, atom, len))
+		int len = strlen(used_atoms[i].name);
+		if (len == ep - atom && !memcmp(used_atoms[i].name, atom, len))
 			return i;
 	}
 
 	/*
 	 * If the atom name has a colon, strip it and everything after
 	 * it off - it specifies the format for this entry, and
-	 * shouldn't be used for checking against the valid_atom
+	 * shouldn't be used for checking against the valid_atoms
 	 * table.
 	 */
 	arg = memchr(sp, ':', ep - sp);
 	atom_len = (arg ? arg : ep) - sp;
 
 	/* Is the atom a valid one? */
-	for (i = 0; i < ARRAY_SIZE(valid_atom); i++) {
-		int len = strlen(valid_atom[i].name);
-		if (len == atom_len && !memcmp(valid_atom[i].name, sp, len))
+	for (i = 0; i < ARRAY_SIZE(valid_atoms); i++) {
+		int len = strlen(valid_atoms[i].name);
+		if (len == atom_len && !memcmp(valid_atoms[i].name, sp, len))
 			break;
 	}
 
-	if (ARRAY_SIZE(valid_atom) <= i)
+	if (ARRAY_SIZE(valid_atoms) <= i)
 		die(_("unknown field name: %.*s"), (int)(ep-atom), atom);
 
 	/* Add it in, including the deref prefix */
 	at = used_atom_cnt;
 	used_atom_cnt++;
-	REALLOC_ARRAY(used_atom, used_atom_cnt);
-	used_atom[at].name = xmemdupz(atom, ep - atom);
-	used_atom[at].type = valid_atom[i].cmp_type;
+	REALLOC_ARRAY(used_atoms, used_atom_cnt);
+	used_atoms[at].name = xmemdupz(atom, ep - atom);
+	used_atoms[at].type = valid_atoms[i].cmp_type;
 	if (arg) {
-		arg = used_atom[at].name + (arg - atom) + 1;
+		arg = used_atoms[at].name + (arg - atom) + 1;
 		if (!*arg) {
 			/*
 			 * Treat empty sub-arguments list as NULL (i.e.,
@@ -450,12 +450,12 @@ static int parse_ref_filter_atom(const struct ref_format *format,
 			arg = NULL;
 		}
 	}
-	memset(&used_atom[at].u, 0, sizeof(used_atom[at].u));
-	if (valid_atom[i].parser)
-		valid_atom[i].parser(format, &used_atom[at], arg);
+	memset(&used_atoms[at].u, 0, sizeof(used_atoms[at].u));
+	if (valid_atoms[i].parser)
+		valid_atoms[i].parser(format, &used_atoms[at], arg);
 	if (*atom == '*')
 		need_tagged = 1;
-	if (!strcmp(valid_atom[i].name, "symref"))
+	if (!strcmp(valid_atoms[i].name, "symref"))
 		need_symref = 1;
 	return at;
 }
@@ -711,7 +711,7 @@ int verify_ref_format(struct ref_format *format)
 		at = parse_ref_filter_atom(format, sp + 2, ep);
 		cp = ep + 1;
 
-		if (skip_prefix(used_atom[at].name, "color:", &color))
+		if (skip_prefix(used_atoms[at].name, "color:", &color))
 			format->need_color_reset_at_eol = !!strcmp(color, "reset");
 	}
 	if (format->need_color_reset_at_eol && !want_color(format->use_color))
@@ -762,7 +762,7 @@ static void grab_common_values(struct atom_value *val, int deref, struct object
 	int i;
 
 	for (i = 0; i < used_atom_cnt; i++) {
-		const char *name = used_atom[i].name;
+		const char *name = used_atoms[i].name;
 		struct atom_value *v = &val[i];
 		if (!!deref != (*name == '*'))
 			continue;
@@ -775,7 +775,7 @@ static void grab_common_values(struct atom_value *val, int deref, struct object
 			v->s = xstrfmt("%lu", sz);
 		}
 		else if (deref)
-			grab_objectname(name, obj->oid.hash, v, &used_atom[i]);
+			grab_objectname(name, obj->oid.hash, v, &used_atoms[i]);
 	}
 }
 
@@ -786,7 +786,7 @@ static void grab_tag_values(struct atom_value *val, int deref, struct object *ob
 	struct tag *tag = (struct tag *) obj;
 
 	for (i = 0; i < used_atom_cnt; i++) {
-		const char *name = used_atom[i].name;
+		const char *name = used_atoms[i].name;
 		struct atom_value *v = &val[i];
 		if (!!deref != (*name == '*'))
 			continue;
@@ -808,7 +808,7 @@ static void grab_commit_values(struct atom_value *val, int deref, struct object
 	struct commit *commit = (struct commit *) obj;
 
 	for (i = 0; i < used_atom_cnt; i++) {
-		const char *name = used_atom[i].name;
+		const char *name = used_atoms[i].name;
 		struct atom_value *v = &val[i];
 		if (!!deref != (*name == '*'))
 			continue;
@@ -938,7 +938,7 @@ static void grab_person(const char *who, struct atom_value *val, int deref, stru
 	const char *wholine = NULL;
 
 	for (i = 0; i < used_atom_cnt; i++) {
-		const char *name = used_atom[i].name;
+		const char *name = used_atoms[i].name;
 		struct atom_value *v = &val[i];
 		if (!!deref != (*name == '*'))
 			continue;
@@ -976,7 +976,7 @@ static void grab_person(const char *who, struct atom_value *val, int deref, stru
 	if (!wholine)
 		return;
 	for (i = 0; i < used_atom_cnt; i++) {
-		const char *name = used_atom[i].name;
+		const char *name = used_atoms[i].name;
 		struct atom_value *v = &val[i];
 		if (!!deref != (*name == '*'))
 			continue;
@@ -1066,7 +1066,7 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct obj
 	unsigned long sublen = 0, bodylen = 0, nonsiglen = 0, siglen = 0;
 
 	for (i = 0; i < used_atom_cnt; i++) {
-		struct used_atom *atom = &used_atom[i];
+		struct used_atom *atom = &used_atoms[i];
 		const char *name = atom->name;
 		struct atom_value *v = &val[i];
 		if (!!deref != (*name == '*'))
@@ -1127,7 +1127,7 @@ static void fill_missing_values(struct atom_value *val)
 
 /*
  * val is a list of atom_value to hold returned values.  Extract
- * the values for atoms in used_atom array out of (obj, buf, sz).
+ * the values for atoms in used_atoms array out of (obj, buf, sz).
  * when deref is false, (obj, buf, sz) is the object that is
  * pointed at by the ref itself; otherwise it is the object the
  * ref (which is a tag) refers to.
@@ -1376,8 +1376,8 @@ static void populate_value(struct ref_array_item *ref)
 
 	/* Fill in specials first */
 	for (i = 0; i < used_atom_cnt; i++) {
-		struct used_atom *atom = &used_atom[i];
-		const char *name = used_atom[i].name;
+		struct used_atom *atom = &used_atoms[i];
+		const char *name = used_atoms[i].name;
 		struct atom_value *v = &ref->value[i];
 		int deref = 0;
 		const char *refname;
@@ -2059,7 +2059,7 @@ static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, stru
 {
 	struct atom_value *va, *vb;
 	int cmp;
-	cmp_type cmp_type = used_atom[s->atom].type;
+	cmp_type cmp_type = used_atoms[s->atom].type;
 	int (*cmp_fn)(const char *, const char *);
 
 	get_ref_atom_value(a, s->atom, &va);

--
https://github.com/git/git/pull/450
