Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7376220A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 23:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbeLKXtf (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 18:49:35 -0500
Received: from mail-qt1-f172.google.com ([209.85.160.172]:41010 "EHLO
        mail-qt1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbeLKXtd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 18:49:33 -0500
Received: by mail-qt1-f172.google.com with SMTP id d18so18563697qto.8
        for <git@vger.kernel.org>; Tue, 11 Dec 2018 15:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ThpFVe+gpyhdsQf3kolYFImGfjyCYdur5lE+CcfoR+4=;
        b=OrKPDi1B6lmW+aWoQPgacrvcnhFKYoUSReJMma5M8UgwRTy6ticTeLhHabMHa7Yzq5
         Y9rDpSDNbJY65/YWpG4p7dpGVBHjIUkkC8dxP1/N2AmQ0ohJF4GAdbdWBbOY1UV64jgt
         FE432FxRotZwqtZUdet6U+NMYGl3gIPnhjnG3DJS4KLJs1w8NQ/l888Y5if3U0PkjFVV
         ICalwAsDDdTsV5DMM+aDyziPTHUejEPrSXv8o4uen9k0RGBT3Ym2Fzx1F4PWpTbpfTeP
         CBnVcHb8I7L7FtFmu2lFNLMulnp/tUUeHyTAw/IthBXTm06GvQlVUNlu1rCqnbGEqwZf
         A0iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=ThpFVe+gpyhdsQf3kolYFImGfjyCYdur5lE+CcfoR+4=;
        b=A6aKCTzPwIf+COgZYmnRgqy3unP7ZodIDyqsl6k8pkfVX+/f8bvCJz0Zt1ba8HRDnR
         P4rlpYuMH/ujXNR1tDwVj+AzJ3puBiVAGX8RAKMHLtveZ2riPQfTS05gCeOSSfA7O7DR
         rWvJvxBrmrFW2KqfTC1C75AZK/jBdytXW/PPPco96mzgFcvuFCIxys4Tu+ohdm6STMje
         w83/cOnKv0w5D+1aV2987Popl/Sxr7cMKPL3EgX0fIq6rZs1y/XzfQRqGxKkzn6UyO5l
         kKMscE8qVzP2aCH1uycf0KMLedaE40TWvzHJI6/wDTmrDCVZsuhhyQZ9hU6llEsgZsVp
         lhdA==
X-Gm-Message-State: AA+aEWZlT32mj7UFsrdoidXziTh8eng19ImE2O4axCSBA7r37GgF1Kg+
        QR/IkoPdaUGp1Gd1XIn55DG/E+LI
X-Google-Smtp-Source: AFSGD/XklddEnMGh/QUBrW6wHLtGj+uQk34Ixwn7pmU2y0eGo4rrLnjucaDTTW3aHwVrSeskpgXteQ==
X-Received: by 2002:a0c:f787:: with SMTP id s7mr17271081qvn.167.1544572172252;
        Tue, 11 Dec 2018 15:49:32 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::7:fd8f])
        by smtp.gmail.com with ESMTPSA id s36sm11869645qth.17.2018.12.11.15.49.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 15:49:31 -0800 (PST)
From:   Tejun Heo <tj@kernel.org>
To:     git@vger.kernel.org, Junio C Hamano <jch2355@gmail.com>,
        Jeff King <peff@peff.net>
Cc:     kernel-team@fb.com, Tejun Heo <htejun@fb.com>
Subject: [PATCH 2/5] notes: Implement special handlings for refs/notes/xref-
Date:   Tue, 11 Dec 2018 15:49:06 -0800
Message-Id: <20181211234909.2855638-3-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181211234909.2855638-1-tj@kernel.org>
References: <20181211234909.2855638-1-tj@kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tejun Heo <htejun@fb.com>

Some trailers refer to other commits.  Let's call them xrefs
(cross-references).  For example, a cherry pick trailer points to the
source commit.  It is sometimes useful to build a reverse map of these
xrefs - ie. source -> cherry-pick instead of cherry-pick -> source.

These reverse-maps will be recorded in special notes whose refs start
with refs/notes/xref-.  This patch implements the following special
handling for the xref notes.

* When xref notes are appended to an existing one, both parts get
  parsed and dead or dupliate references are dropped, so that the
  merged note contains only valid and unique xrefs.

* When xref notes are formatted for printing, the formatter recurses
  into each xref and prints the nested xrefs with increasing
  indentation to show the comprehensive xref chains.

The latter part will be documented by a future patch with the actual
use case.

Signed-off-by: Tejun Heo <htejun@fb.com>
---
 Documentation/git-notes.txt |   8 ++
 notes-merge.c               |   9 ++
 notes-utils.c               |   2 +
 notes-utils.h               |   3 +-
 notes.c                     | 260 +++++++++++++++++++++++++++++++++++-
 notes.h                     |   9 ++
 6 files changed, 288 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index df2b64dbb..872919ad4 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -88,6 +88,10 @@ the command can read the input given to the `post-rewrite` hook.)
 	Append to the notes of an existing object (defaults to HEAD).
 	Creates a new notes object if needed.
 
+	If the notes ref starts with `/refs/notes/xref-`, each
+	line is expected to contain `<tag>: <commit-id>` and
+	only lines with reachable unique commit IDs are kept.
+
 edit::
 	Edit the notes for a given object (defaults to HEAD).
 
@@ -273,6 +277,10 @@ Note that if either the local or remote version contain duplicate lines
 prior to the merge, these will also be removed by this notes merge
 strategy.
 
+"cat_xrefs" is similar to "union" but expects each line to contain
+`<tag>: <commit-id>`. Only lines with reachable unique commit IDs are
+kept.
+
 
 EXAMPLES
 --------
diff --git a/notes-merge.c b/notes-merge.c
index bd05d50b0..3fe2389a1 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -464,6 +464,15 @@ static int merge_one_change(struct notes_merge_options *o,
 			die("failed to concatenate notes "
 			    "(combine_notes_cat_sort_uniq)");
 		return 0;
+	case NOTES_MERGE_RESOLVE_CAT_XREFS:
+		if (o->verbosity >= 2)
+			printf("Concatenating unique and valid cross-references "
+			       "in local and remote notes for %s\n",
+			       oid_to_hex(&p->obj));
+		if (add_note(t, &p->obj, &p->remote, combine_notes_cat_xrefs))
+			die("failed to concatenate notes "
+			    "(combine_notes_cat_xrefs)");
+		return 0;
 	}
 	die("Unknown strategy (%i).", o->strategy);
 }
diff --git a/notes-utils.c b/notes-utils.c
index 14ea03178..db6363c39 100644
--- a/notes-utils.c
+++ b/notes-utils.c
@@ -70,6 +70,8 @@ int parse_notes_merge_strategy(const char *v, enum notes_merge_strategy *s)
 		*s = NOTES_MERGE_RESOLVE_UNION;
 	else if (!strcmp(v, "cat_sort_uniq"))
 		*s = NOTES_MERGE_RESOLVE_CAT_SORT_UNIQ;
+	else if (!strcmp(v, "cat_xrefs"))
+		*s = NOTES_MERGE_RESOLVE_CAT_XREFS;
 	else
 		return -1;
 
diff --git a/notes-utils.h b/notes-utils.h
index 540830652..b604f9b51 100644
--- a/notes-utils.h
+++ b/notes-utils.h
@@ -28,7 +28,8 @@ enum notes_merge_strategy {
 		NOTES_MERGE_RESOLVE_OURS,
 		NOTES_MERGE_RESOLVE_THEIRS,
 		NOTES_MERGE_RESOLVE_UNION,
-		NOTES_MERGE_RESOLVE_CAT_SORT_UNIQ
+		NOTES_MERGE_RESOLVE_CAT_SORT_UNIQ,
+		NOTES_MERGE_RESOLVE_CAT_XREFS,
 };
 
 struct notes_rewrite_cfg {
diff --git a/notes.c b/notes.c
index 25cdce28b..835466787 100644
--- a/notes.c
+++ b/notes.c
@@ -9,6 +9,7 @@
 #include "tree-walk.h"
 #include "string-list.h"
 #include "refs.h"
+#include "hashmap.h"
 
 /*
  * Use a non-balancing simple 16-tree structure with struct int_node as
@@ -996,8 +997,12 @@ void init_notes(struct notes_tree *t, const char *notes_ref,
 	if (!notes_ref)
 		notes_ref = default_notes_ref();
 
-	if (!combine_notes)
-		combine_notes = combine_notes_concatenate;
+	if (!combine_notes) {
+		if (starts_with(notes_ref, "refs/notes/xref-"))
+			combine_notes = combine_notes_cat_xrefs;
+		else
+			combine_notes = combine_notes_concatenate;
+	}
 
 	t->root = (struct int_node *) xcalloc(1, sizeof(struct int_node));
 	t->first_non_note = NULL;
@@ -1189,6 +1194,76 @@ void free_notes(struct notes_tree *t)
 	memset(t, 0, sizeof(struct notes_tree));
 }
 
+/*
+ * Parse a "[TAG:]HEX" line.  @line is trimmed.  If @tag_p is not NULL and
+ * TAG exists, the string is split.  Returns the pointer to OID and updates
+ * *@tag_p to point to TAG.
+ */
+static char *parse_xref(char *line, char **tag_p)
+{
+	char *p, *hex;
+
+	/* ltrim */
+	while (isspace(*line))
+		line++;
+
+	p = strchr(line, ':');
+	if (p) {
+		if (tag_p) {
+			/* split and store TAG */
+			*tag_p = line;
+			*p = '\0';
+		}
+		/* trim whitespaces after ':' */
+		p++;
+		while (isspace(*p))
+			p++;
+		hex = p;
+	} else {
+		if (tag_p)
+			*tag_p = NULL;
+		hex = line;
+	}
+
+	/* rtrim */
+	p = hex;
+	while (*p != '\0' && !isspace(*p))
+		p++;
+	*p = '\0';
+	return hex;
+}
+
+static void walk_xrefs(const char *tree_ref, struct object_id *from_oid,
+		       struct strbuf *sb, int level)
+{
+	struct object_array xrefs = OBJECT_ARRAY_INIT;
+	struct string_list lines = STRING_LIST_INIT_DUP;
+	int i;
+
+	read_xref_note(tree_ref, from_oid, &xrefs, &lines);
+
+	for (i = 0; i < xrefs.nr; i++) {
+		char *line = lines.items[i].string;
+		char *tag;
+
+		parse_xref(line, &tag);
+		strbuf_addf(sb, "    %s%s%*s%s\n",
+			    tag ?: "", tag ? ": " : "", 2 * level, "",
+			    xrefs.objects[i].name);
+		if (xrefs.objects[i].item) {
+			if (level < 32)
+				walk_xrefs(tree_ref, &xrefs.objects[i].item->oid,
+					   sb, level + 1);
+			else
+				warning("xref nested deeper than %d levels, terminating walk",
+					level);
+		}
+	}
+
+	object_array_clear(&xrefs);
+	string_list_clear(&lines, 0);
+}
+
 /*
  * Fill the given strbuf with the notes associated with the given object.
  *
@@ -1208,6 +1283,7 @@ static void format_note(struct notes_tree *t, const struct object_id *object_oid
 	char *msg, *msg_p;
 	unsigned long linelen, msglen;
 	enum object_type type;
+	int format_xrefs;
 
 	if (!t)
 		t = &default_notes_tree;
@@ -1250,6 +1326,8 @@ static void format_note(struct notes_tree *t, const struct object_id *object_oid
 		}
 	}
 
+	format_xrefs = !raw && starts_with(t->ref, "refs/notes/xref-");
+
 	for (msg_p = msg; msg_p < msg + msglen; msg_p += linelen + 1) {
 		linelen = strchrnul(msg_p, '\n') - msg_p;
 
@@ -1257,6 +1335,14 @@ static void format_note(struct notes_tree *t, const struct object_id *object_oid
 			strbuf_addstr(sb, "    ");
 		strbuf_add(sb, msg_p, linelen);
 		strbuf_addch(sb, '\n');
+
+		if (format_xrefs) {
+			struct object_id oid;
+
+			msg_p[linelen] = '\0';
+			if (!get_oid_hex(parse_xref(msg_p, NULL), &oid))
+				walk_xrefs(t->ref, &oid, sb, 1);
+		}
 	}
 
 	free(msg);
@@ -1309,3 +1395,173 @@ void expand_loose_notes_ref(struct strbuf *sb)
 		expand_notes_ref(sb);
 	}
 }
+
+/*
+ * Parse a cross-referencing note.
+ *
+ * @note contains lines of "[TAG:]HEX" pointing to other commits.  Read the
+ * target commits and add the objects to @result.  If @result_lines is not
+ * NULL, it should point to a strdup'ing string_list.  The verbatim note
+ * lines matching the target commits are appened to the list.
+ */
+static void parse_xref_note(const char *note, unsigned long size,
+			    const struct object_id *commit_oid,
+			    struct object_array *result,
+			    struct string_list *result_lines)
+{
+	struct strbuf **lines, **pline;
+
+	lines = strbuf_split_buf(note, size, '\n', 0);
+
+	for (pline = lines; *pline; pline++) {
+		struct strbuf *line = *pline;
+		const char *target_hex;
+		struct object_id target_oid;
+		struct object *target_obj;
+
+		target_hex = parse_xref(line->buf, NULL);
+		if (get_oid_hex(target_hex, &target_oid)) {
+			if (commit_oid)
+				warning("read invalid sha1 on %s: %s",
+					oid_to_hex(commit_oid), line->buf);
+			continue;
+		}
+
+		target_obj = parse_object(the_repository, &target_oid);
+		if (!target_obj || target_obj->type != OBJ_COMMIT) {
+			if (commit_oid)
+				warning("read invalid commit on %s: %s",
+					oid_to_hex(commit_oid), line->buf);
+			continue;
+		}
+
+		add_object_array(target_obj, target_hex, result);
+		if (result_lines) {
+			assert(result_lines->strdup_strings);
+			string_list_append(result_lines, line->buf);
+		}
+	}
+
+	strbuf_list_free(lines);
+}
+
+struct notes_tree_entry {
+	struct hashmap_entry ent;
+	struct notes_tree tree;
+};
+
+static int notes_tree_cmp(const void *hashmap_cmp_fn_data,
+			  const void *entry, const void *entry_or_key,
+			  const void *keydata)
+{
+	const struct notes_tree_entry *e1 = entry;
+	const struct notes_tree_entry *e2 = entry_or_key;
+
+	return strcmp(e1->tree.ref, e2->tree.ref);
+}
+
+/*
+ * Read and parse a cross-referencing note.
+ *
+ * Read the @notes_ref note of @commit_oid and parse it with
+ * parse_xref_note().
+ */
+void read_xref_note(const char *notes_ref, const struct object_id *commit_oid,
+		    struct object_array *result,
+		    struct string_list *result_lines)
+{
+	static struct hashmap *notes_tree_map = NULL;
+	unsigned hash = memhash(notes_ref, strlen(notes_ref));
+	struct notes_tree_entry key, *ent;
+	const struct object_id *note_oid;
+	unsigned long size;
+	enum object_type type;
+	char *note;
+
+	if (!notes_tree_map) {
+		notes_tree_map = xcalloc(1, sizeof(struct hashmap));
+		hashmap_init(notes_tree_map, notes_tree_cmp, NULL, 0);
+	}
+
+	hashmap_entry_init(&key.ent, hash);
+	key.tree.ref = (char *)notes_ref;
+	ent = hashmap_get(notes_tree_map, &key, NULL);
+	if (!ent) {
+		ent = xcalloc(1, sizeof(struct notes_tree_entry));
+		init_notes(&ent->tree, notes_ref, NULL, 0);
+		hashmap_entry_init(&ent->ent, hash);
+		hashmap_put(notes_tree_map, ent);
+	}
+
+	note_oid = get_note(&ent->tree, commit_oid);
+	if (!note_oid)
+		return;
+
+	note = read_object_file(note_oid, &type, &size);
+	if (!size) {
+		free(note);
+		return;
+	}
+
+	parse_xref_note(note, size, commit_oid, result, result_lines);
+	free(note);
+}
+
+/*
+ * Combine a xref note in @new_oid into @cur_oid.  Unreachable or duplicate
+ * xrefs are dropped.  This is the default combine_notes callback for
+ * refs/notes/xref-.
+ */
+int combine_notes_cat_xrefs(struct object_id *cur_oid,
+			    const struct object_id *new_oid)
+{
+	char *cur_msg = NULL, *new_msg = NULL;
+	unsigned long cur_len, new_len;
+	enum object_type cur_type, new_type;
+	struct object_array xrefs = OBJECT_ARRAY_INIT;
+	struct string_list lines = STRING_LIST_INIT_DUP;
+	struct strbuf output = STRBUF_INIT;
+	int i, j, cur_nr, ret;
+
+	/* read in both note blob objects */
+	if (!is_null_oid(new_oid))
+		new_msg = read_object_file(new_oid, &new_type, &new_len);
+	if (!new_msg || !new_len || new_type != OBJ_BLOB) {
+		free(new_msg);
+		return 0;
+	}
+	if (!is_null_oid(cur_oid))
+		cur_msg = read_object_file(cur_oid, &cur_type, &cur_len);
+	if (!cur_msg || !cur_len || cur_type != OBJ_BLOB) {
+		free(cur_msg);
+		free(new_msg);
+		oidcpy(cur_oid, new_oid);
+		return 0;
+	}
+
+	/* parse xrefs and de-dup */
+	parse_xref_note(cur_msg, cur_len, NULL, &xrefs, &lines);
+	cur_nr = xrefs.nr;
+	parse_xref_note(new_msg, new_len, NULL, &xrefs, &lines);
+
+	for (i = 0; i < cur_nr; i++)
+		for (j = cur_nr; j < xrefs.nr; j++)
+			if (!strcmp(xrefs.objects[i].name,
+				    xrefs.objects[j].name))
+				lines.items[j].string[0] = '\0';
+
+	/* write out the combined object */
+	for (i = 0; i < lines.nr; i++)
+		if (lines.items[i].string[0] != '\0')
+			strbuf_addf(&output, "%s\n", lines.items[i].string);
+
+	ret = write_object_file(output.buf, output.len, blob_type, cur_oid);
+
+	strbuf_release(&output);
+	object_array_clear(&xrefs);
+	string_list_clear(&lines, 0);
+	free(cur_msg);
+	free(new_msg);
+
+	return ret;
+}
diff --git a/notes.h b/notes.h
index 414bc6855..09ca92f36 100644
--- a/notes.h
+++ b/notes.h
@@ -2,6 +2,7 @@
 #define NOTES_H
 
 #include "string-list.h"
+#include "object.h"
 
 struct object_id;
 struct strbuf;
@@ -317,4 +318,12 @@ void expand_notes_ref(struct strbuf *sb);
  */
 void expand_loose_notes_ref(struct strbuf *sb);
 
+/* For refs/notes/xref- */
+void read_xref_note(const char *notes_ref, const struct object_id *commit_oid,
+		    struct object_array *result,
+		    struct string_list *result_lines);
+
+int combine_notes_cat_xrefs(struct object_id *cur_oid,
+			    const struct object_id *new_oid);
+
 #endif
-- 
2.17.1

