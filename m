Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F2A02027C
	for <e@80x24.org>; Tue, 30 May 2017 17:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750954AbdE3RbW (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 13:31:22 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:32828 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750871AbdE3RbT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 13:31:19 -0400
Received: by mail-pf0-f177.google.com with SMTP id e193so78457194pfh.0
        for <git@vger.kernel.org>; Tue, 30 May 2017 10:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yVKwCF8gFp+lXVmwd9w7mk0Rr52Psj4l21HmbujnCqY=;
        b=TpGj5BWo9CmZn1S1KD/+QJN3UsX7qsgeVnlzCLXnHYZdAiXGr9fXDWCMPdmWoYwiKk
         TN/2nqMDtiaGPy1XYxQGdaj5UeTdwOBCunZc6xr+u3FkOzvRJK13fyrklCTaVwJ+/mcj
         7ulSbw459VeDx5au/cASu5x9dfPzqCG/Wiw1AmSfnD9AqwViGqqomEfDODDl7mDR6Y+m
         9fmjVWNtO+W8ZHI6A3hU2wkf6MjMTzNyHGoWEVz4OGQ3tT9/yNpRSungGTmPatRjRnHM
         v0ewul4gRmH4guhFDMJwBLhhrR9ap9NJ094ruAz4RV8/6u3HALMilTFniSOSLdMjx300
         87Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yVKwCF8gFp+lXVmwd9w7mk0Rr52Psj4l21HmbujnCqY=;
        b=ueQIl0V+V2al1HJ3ZFT2boXEQLE7UE1Qx5yJR2DFi8LL+fHTtZZZPbO6LKSCitcIAl
         3CB9HLJSbh2LFUUgEwM0NGFYRfsXNYMMXeQuKsB0HGiebB14EESUphHMA4TpcwWXxDoy
         tptMRPi0Fl2daMAMcRAApKDVkYYS6Okc5mYR3FmPAx17dMUEgpWfWhkhNydTfdm46gJO
         IHO34av9LvoeWNU0SoxRDRprhzuNQCs4WSbvFCwBSR699kIsPsz3lVm8fDSkY26AWXFG
         x0sm76BnfffsVctS25iWiByha5KlauzCgtVhFTLitZUw/FfJxW0RM5/kslZMqltl6uER
         Wd2w==
X-Gm-Message-State: AODbwcDERYJJwSCfeYsYVsxWt+xKNbYYj8hxAtXBTjQAwx7rl9+lkKZS
        hXp06v/68fBWH8qI
X-Received: by 10.84.160.197 with SMTP id v5mr83374777plg.30.1496165478287;
        Tue, 30 May 2017 10:31:18 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id t19sm24940187pfg.31.2017.05.30.10.31.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 May 2017 10:31:16 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sandals@crustytoothpaste.net,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 02/33] notes: convert internal parts to struct object_id
Date:   Tue, 30 May 2017 10:30:38 -0700
Message-Id: <20170530173109.54904-3-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.219.gdb65acc882-goog
In-Reply-To: <20170530173109.54904-1-bmwill@google.com>
References: <20170530173109.54904-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "brian m. carlson" <sandals@crustytoothpaste.net>

Convert several portions of the internals of the code to struct
object_id.  Introduce two macros to denote the different constants in
the code: KEY_INDEX for the last byte of the object ID, and
FANOUT_PATH_SEPARATORS for the number of possible path separators (on
Unix, "/").  While these constants are both 19 (one less than the number
of bytes in the hash), distinguish them to make the code more
understandable, and define them logically based on their intended
purpose.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Brandon Williams <bmwill@google.com>
---
 notes.c | 64 +++++++++++++++++++++++++++++++++-------------------------------
 1 file changed, 33 insertions(+), 31 deletions(-)

diff --git a/notes.c b/notes.c
index 251cf11c9..babe0c0eb 100644
--- a/notes.c
+++ b/notes.c
@@ -65,8 +65,10 @@ struct non_note {
 
 #define GET_NIBBLE(n, sha1) (((sha1[(n) >> 1]) >> ((~(n) & 0x01) << 2)) & 0x0f)
 
+#define KEY_INDEX (GIT_SHA1_RAWSZ - 1)
+#define FANOUT_PATH_SEPARATORS ((GIT_SHA1_HEXSZ / 2) - 1)
 #define SUBTREE_SHA1_PREFIXCMP(key_sha1, subtree_sha1) \
-	(memcmp(key_sha1, subtree_sha1, subtree_sha1[19]))
+	(memcmp(key_sha1, subtree_sha1, subtree_sha1[KEY_INDEX]))
 
 struct notes_tree default_notes_tree;
 
@@ -194,7 +196,7 @@ static void note_tree_remove(struct notes_tree *t,
 		struct leaf_node *entry)
 {
 	struct leaf_node *l;
-	struct int_node *parent_stack[20];
+	struct int_node *parent_stack[GIT_SHA1_RAWSZ];
 	unsigned char i, j;
 	void **p = note_tree_search(t, &tree, &n, entry->key_oid.hash);
 
@@ -341,21 +343,21 @@ static void note_tree_free(struct int_node *tree)
  * Otherwise, returns number of bytes written to sha1 (i.e. hex_len / 2).
  * Pads sha1 with NULs up to sha1_len (not included in returned length).
  */
-static int get_sha1_hex_segment(const char *hex, unsigned int hex_len,
-		unsigned char *sha1, unsigned int sha1_len)
+static int get_oid_hex_segment(const char *hex, unsigned int hex_len,
+		unsigned char *oid, unsigned int oid_len)
 {
 	unsigned int i, len = hex_len >> 1;
-	if (hex_len % 2 != 0 || len > sha1_len)
+	if (hex_len % 2 != 0 || len > oid_len)
 		return -1;
 	for (i = 0; i < len; i++) {
 		unsigned int val = (hexval(hex[0]) << 4) | hexval(hex[1]);
 		if (val & ~0xff)
 			return -1;
-		*sha1++ = val;
+		*oid++ = val;
 		hex += 2;
 	}
-	for (; i < sha1_len; i++)
-		*sha1++ = 0;
+	for (; i < oid_len; i++)
+		*oid++ = 0;
 	return len;
 }
 
@@ -413,7 +415,7 @@ static void add_non_note(struct notes_tree *t, char *path,
 static void load_subtree(struct notes_tree *t, struct leaf_node *subtree,
 		struct int_node *node, unsigned int n)
 {
-	unsigned char object_sha1[20];
+	struct object_id object_oid;
 	unsigned int prefix_len;
 	void *buf;
 	struct tree_desc desc;
@@ -427,13 +429,13 @@ static void load_subtree(struct notes_tree *t, struct leaf_node *subtree,
 		die("Could not read %s for notes-index",
 		     oid_to_hex(&subtree->val_oid));
 
-	prefix_len = subtree->key_oid.hash[19];
+	prefix_len = subtree->key_oid.hash[KEY_INDEX];
 	assert(prefix_len * 2 >= n);
-	memcpy(object_sha1, subtree->key_oid.hash, prefix_len);
+	memcpy(object_oid.hash, subtree->key_oid.hash, prefix_len);
 	while (tree_entry(&desc, &entry)) {
 		path_len = strlen(entry.path);
-		len = get_sha1_hex_segment(entry.path, path_len,
-				object_sha1 + prefix_len, 20 - prefix_len);
+		len = get_oid_hex_segment(entry.path, path_len,
+				object_oid.hash + prefix_len, GIT_SHA1_RAWSZ - prefix_len);
 		if (len < 0)
 			goto handle_non_note; /* entry.path is not a SHA1 */
 		len += prefix_len;
@@ -443,16 +445,16 @@ static void load_subtree(struct notes_tree *t, struct leaf_node *subtree,
 		 * If object SHA1 is incomplete (len < 20), and current
 		 * component consists of 2 hex chars, assume note subtree
 		 */
-		if (len <= 20) {
+		if (len <= GIT_SHA1_RAWSZ) {
 			type = PTR_TYPE_NOTE;
 			l = (struct leaf_node *)
 				xcalloc(1, sizeof(struct leaf_node));
-			hashcpy(l->key_oid.hash, object_sha1);
+			oidcpy(&l->key_oid, &object_oid);
 			oidcpy(&l->val_oid, entry.oid);
-			if (len < 20) {
+			if (len < GIT_SHA1_RAWSZ) {
 				if (!S_ISDIR(entry.mode) || path_len != 2)
 					goto handle_non_note; /* not subtree */
-				l->key_oid.hash[19] = (unsigned char) len;
+				l->key_oid.hash[KEY_INDEX] = (unsigned char) len;
 				type = PTR_TYPE_SUBTREE;
 			}
 			if (note_tree_insert(t, node, n, l, type,
@@ -542,14 +544,14 @@ static unsigned char determine_fanout(struct int_node *tree, unsigned char n,
 }
 
 /* hex SHA1 + 19 * '/' + NUL */
-#define FANOUT_PATH_MAX 40 + 19 + 1
+#define FANOUT_PATH_MAX GIT_SHA1_HEXSZ + FANOUT_PATH_SEPARATORS + 1
 
 static void construct_path_with_fanout(const unsigned char *sha1,
 		unsigned char fanout, char *path)
 {
 	unsigned int i = 0, j = 0;
 	const char *hex_sha1 = sha1_to_hex(sha1);
-	assert(fanout < 20);
+	assert(fanout < GIT_SHA1_RAWSZ);
 	while (fanout) {
 		path[i++] = hex_sha1[j++];
 		path[i++] = hex_sha1[j++];
@@ -599,7 +601,7 @@ static int for_each_note_helper(struct notes_tree *t, struct int_node *tree,
 			    flags & FOR_EACH_NOTE_YIELD_SUBTREES) {
 				/* invoke callback with subtree */
 				unsigned int path_len =
-					l->key_oid.hash[19] * 2 + fanout;
+					l->key_oid.hash[KEY_INDEX] * 2 + fanout;
 				assert(path_len < FANOUT_PATH_MAX - 1);
 				construct_path_with_fanout(l->key_oid.hash,
 							   fanout,
@@ -654,7 +656,7 @@ static void write_tree_entry(struct strbuf *buf, unsigned int mode,
 		unsigned char *sha1)
 {
 	strbuf_addf(buf, "%o %.*s%c", mode, path_len, path, '\0');
-	strbuf_add(buf, sha1, 20);
+	strbuf_add(buf, sha1, GIT_SHA1_RAWSZ);
 }
 
 static void tree_write_stack_init_subtree(struct tree_write_stack *tws,
@@ -666,7 +668,7 @@ static void tree_write_stack_init_subtree(struct tree_write_stack *tws,
 	n = (struct tree_write_stack *)
 		xmalloc(sizeof(struct tree_write_stack));
 	n->next = NULL;
-	strbuf_init(&n->buf, 256 * (32 + 40)); /* assume 256 entries per tree */
+	strbuf_init(&n->buf, 256 * (32 + GIT_SHA1_HEXSZ)); /* assume 256 entries per tree */
 	n->path[0] = n->path[1] = '\0';
 	tws->next = n;
 	tws->path[0] = path[0];
@@ -677,18 +679,18 @@ static int tree_write_stack_finish_subtree(struct tree_write_stack *tws)
 {
 	int ret;
 	struct tree_write_stack *n = tws->next;
-	unsigned char s[20];
+	struct object_id s;
 	if (n) {
 		ret = tree_write_stack_finish_subtree(n);
 		if (ret)
 			return ret;
-		ret = write_sha1_file(n->buf.buf, n->buf.len, tree_type, s);
+		ret = write_sha1_file(n->buf.buf, n->buf.len, tree_type, s.hash);
 		if (ret)
 			return ret;
 		strbuf_release(&n->buf);
 		free(n);
 		tws->next = NULL;
-		write_tree_entry(&tws->buf, 040000, tws->path, 2, s);
+		write_tree_entry(&tws->buf, 040000, tws->path, 2, s.hash);
 		tws->path[0] = tws->path[1] = '\0';
 	}
 	return 0;
@@ -771,7 +773,7 @@ static int write_each_note(const unsigned char *object_sha1,
 		note_path[note_path_len] = '\0';
 		mode = 040000;
 	}
-	assert(note_path_len <= 40 + 19);
+	assert(note_path_len <= GIT_SHA1_HEXSZ + FANOUT_PATH_SEPARATORS);
 
 	/* Weave non-note entries into note entries */
 	return  write_each_non_note_until(note_path, d) ||
@@ -946,8 +948,8 @@ void string_list_add_refs_by_glob(struct string_list *list, const char *glob)
 	if (has_glob_specials(glob)) {
 		for_each_glob_ref(string_list_add_one_ref, glob, list);
 	} else {
-		unsigned char sha1[20];
-		if (get_sha1(glob, sha1))
+		struct object_id oid;
+		if (get_oid(glob, &oid))
 			warning("notes ref %s is invalid", glob);
 		if (!unsorted_string_list_has_string(list, glob))
 			string_list_append(list, glob);
@@ -1150,7 +1152,7 @@ int write_notes_tree(struct notes_tree *t, unsigned char *result)
 
 	/* Prepare for traversal of current notes tree */
 	root.next = NULL; /* last forward entry in list is grounded */
-	strbuf_init(&root.buf, 256 * (32 + 40)); /* assume 256 entries */
+	strbuf_init(&root.buf, 256 * (32 + GIT_SHA1_HEXSZ)); /* assume 256 entries */
 	root.path[0] = root.path[1] = '\0';
 	cb_data.root = &root;
 	cb_data.next_non_note = t->first_non_note;
@@ -1315,9 +1317,9 @@ void expand_notes_ref(struct strbuf *sb)
 
 void expand_loose_notes_ref(struct strbuf *sb)
 {
-	unsigned char object[20];
+	struct object_id object;
 
-	if (get_sha1(sb->buf, object)) {
+	if (get_oid(sb->buf, &object)) {
 		/* fallback to expand_notes_ref */
 		expand_notes_ref(sb);
 	}
-- 
2.13.0.219.gdb65acc882-goog

