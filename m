Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5866D1F424
	for <e@80x24.org>; Mon, 22 Jan 2018 11:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751208AbeAVLFS (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 06:05:18 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:45536 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751149AbeAVLEw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 06:04:52 -0500
Received: by mail-wm0-f65.google.com with SMTP id i186so15495373wmi.4
        for <git@vger.kernel.org>; Mon, 22 Jan 2018 03:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
         :references;
        bh=VBnV51gqJz2gmnvFs8+ZIB5znRScYAPp7gF/kkoM5UE=;
        b=Pvz0MayambYUu5geEgEgX+wDr3+mBNg4Mq935pLtXtl7lAYHsNEhuuelWAaqZtd5vp
         J+9zDmF5Pot1OSVmqpPGLSxkFZTKzpIYB3i4r20sE/5CbWxApS4sFsSFj6rIiU/g/rNY
         tIooh8Etdfbk8CtBvgNqc1a2b5WSyfDgTUvARcebz3+DCGOZeXP1t0hHS7PH1T6ttEEM
         rDZnv53L+3d2qH2JyLy8GYUK42wjdZRW5L4smklD+msN2Z9jX7AFfhGuJbtRDTYV34Ez
         57Jz30EqQ/RyiGJ4+YjD7eGXSjynHhRSfQdrovvV70xrJc6HfKvC4fOzOlZH2tLJEBfL
         hTtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=VBnV51gqJz2gmnvFs8+ZIB5znRScYAPp7gF/kkoM5UE=;
        b=VZ/XnCxp/nGDeCjiOnyxqXjKQ0iSIYqXuhitszf35HoqmNYLJu0hcUBZaocJsyB1Ob
         qdXkMQOmekduwDfWu63PwUtv561L1C8GhhJWPXFjD8hv2WHnmiCTYpACP9/3bMlNZ0XM
         fjlNE1a4b5S3lDR5m5fIdpAePzQjUUxjAPdC5wBKDbiej90cOQPlimu/yX9ZRi02f/ni
         2hhXNOaiCz4Ur0MGBmMLFbWo+Q/YmZ4HdKhed12LUl0e4eru5AJC1FpHlAFEKUYRCZ0f
         SIrjj7VBm5MgWl2oDta57fEWrHsgaL67V2jV3eGZB1NWZRYWqZr5MdHQHpSLw7SWa7H5
         Ak3g==
X-Gm-Message-State: AKwxytcHncrvqrj5HMRBTWGL8o8O/kIG+WQabMJV6ufnw9p6fiBwEILI
        ePDwfSmtDNVbMk+6usopUeykX+UJ
X-Google-Smtp-Source: AH8x226duWOhZjeEtwhzGgAMbzbobRPjWn/T3LS721JSunKzDSczdWF3kGR5VmKhIDi0XVYF//hDqw==
X-Received: by 10.80.177.67 with SMTP id l3mr12501845edd.267.1516619090990;
        Mon, 22 Jan 2018 03:04:50 -0800 (PST)
Received: from localhost.localdomain ([188.121.16.104])
        by smtp.gmail.com with ESMTPSA id e12sm10833591edm.42.2018.01.22.03.04.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jan 2018 03:04:49 -0800 (PST)
From:   Patryk Obara <patryk.obara@gmail.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        sandals@crustytoothpaste.ath.cx,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH v2 08/14] commit: convert commit_tree* to object_id
Date:   Mon, 22 Jan 2018 12:04:31 +0100
Message-Id: <c03bc2a397412aaf4ef0ba8fa8dce07b59da809e.1516617960.git.patryk.obara@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <cover.1516617960.git.patryk.obara@gmail.com>
References: <cover.1516282880.git.patryk.obara@gmail.com>
 <cover.1516617960.git.patryk.obara@gmail.com>
In-Reply-To: <cover.1516617960.git.patryk.obara@gmail.com>
References: <cover.1516617960.git.patryk.obara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the definitions and declarations of commit_tree and
commit_tree_extended to use struct object_id and adjust all usages of
these functions.

Signed-off-by: Patryk Obara <patryk.obara@gmail.com>
---
 builtin/am.c          |  4 ++--
 builtin/commit-tree.c |  4 ++--
 builtin/commit.c      |  5 +++--
 builtin/merge.c       |  8 ++++----
 commit.c              | 15 +++++++--------
 commit.h              | 11 ++++++-----
 notes-cache.c         |  4 ++--
 notes-merge.c         |  9 ++++-----
 notes-utils.c         |  7 ++++---
 notes-utils.h         |  3 ++-
 10 files changed, 36 insertions(+), 34 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index acfe9d3c8c..6e6abb05cd 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1641,8 +1641,8 @@ static void do_commit(const struct am_state *state)
 		setenv("GIT_COMMITTER_DATE",
 			state->ignore_date ? "" : state->author_date, 1);
 
-	if (commit_tree(state->msg, state->msg_len, tree.hash, parents, commit.hash,
-				author, state->sign_commit))
+	if (commit_tree(state->msg, state->msg_len, &tree, parents, &commit,
+			author, state->sign_commit))
 		die(_("failed to write commit object"));
 
 	reflog_msg = getenv("GIT_REFLOG_ACTION");
diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index 2177251e24..e5bdf57b1e 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -117,8 +117,8 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 			die_errno("git commit-tree: failed to read");
 	}
 
-	if (commit_tree(buffer.buf, buffer.len, tree_oid.hash, parents,
-			commit_oid.hash, NULL, sign_commit)) {
+	if (commit_tree(buffer.buf, buffer.len, &tree_oid, parents, &commit_oid,
+			NULL, sign_commit)) {
 		strbuf_release(&buffer);
 		return 1;
 	}
diff --git a/builtin/commit.c b/builtin/commit.c
index 8a87701414..c14878302e 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1792,8 +1792,9 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		append_merge_tag_headers(parents, &tail);
 	}
 
-	if (commit_tree_extended(sb.buf, sb.len, active_cache_tree->oid.hash,
-			 parents, oid.hash, author_ident.buf, sign_commit, extra)) {
+	if (commit_tree_extended(sb.buf, sb.len, &active_cache_tree->oid,
+				 parents, &oid, author_ident.buf, sign_commit,
+				 extra)) {
 		rollback_index_files();
 		die(_("failed to write commit object"));
 	}
diff --git a/builtin/merge.c b/builtin/merge.c
index 30264cfd7c..92ba99a1a5 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -820,8 +820,8 @@ static int merge_trivial(struct commit *head, struct commit_list *remoteheads)
 	pptr = commit_list_append(head, pptr);
 	pptr = commit_list_append(remoteheads->item, pptr);
 	prepare_to_commit(remoteheads);
-	if (commit_tree(merge_msg.buf, merge_msg.len, result_tree.hash, parents,
-			result_commit.hash, NULL, sign_commit))
+	if (commit_tree(merge_msg.buf, merge_msg.len, &result_tree, parents,
+			&result_commit, NULL, sign_commit))
 		die(_("failed to write commit object"));
 	finish(head, remoteheads, &result_commit, "In-index merge");
 	drop_save();
@@ -845,8 +845,8 @@ static int finish_automerge(struct commit *head,
 		commit_list_insert(head, &parents);
 	strbuf_addch(&merge_msg, '\n');
 	prepare_to_commit(remoteheads);
-	if (commit_tree(merge_msg.buf, merge_msg.len, result_tree->hash, parents,
-			result_commit.hash, NULL, sign_commit))
+	if (commit_tree(merge_msg.buf, merge_msg.len, result_tree, parents,
+			&result_commit, NULL, sign_commit))
 		die(_("failed to write commit object"));
 	strbuf_addf(&buf, "Merge made by the '%s' strategy.", wt_strategy);
 	finish(head, remoteheads, &result_commit, buf.buf);
diff --git a/commit.c b/commit.c
index cab8d4455b..760137e54b 100644
--- a/commit.c
+++ b/commit.c
@@ -1395,9 +1395,8 @@ void free_commit_extra_headers(struct commit_extra_header *extra)
 	}
 }
 
-int commit_tree(const char *msg, size_t msg_len,
-		const unsigned char *tree,
-		struct commit_list *parents, unsigned char *ret,
+int commit_tree(const char *msg, size_t msg_len, const struct object_id *tree,
+		struct commit_list *parents, struct object_id *ret,
 		const char *author, const char *sign_commit)
 {
 	struct commit_extra_header *extra = NULL, **tail = &extra;
@@ -1526,8 +1525,8 @@ N_("Warning: commit message did not conform to UTF-8.\n"
    "variable i18n.commitencoding to the encoding your project uses.\n");
 
 int commit_tree_extended(const char *msg, size_t msg_len,
-			 const unsigned char *tree,
-			 struct commit_list *parents, unsigned char *ret,
+			 const struct object_id *tree,
+			 struct commit_list *parents, struct object_id *ret,
 			 const char *author, const char *sign_commit,
 			 struct commit_extra_header *extra)
 {
@@ -1535,7 +1534,7 @@ int commit_tree_extended(const char *msg, size_t msg_len,
 	int encoding_is_utf8;
 	struct strbuf buffer;
 
-	assert_sha1_type(tree, OBJ_TREE);
+	assert_sha1_type(tree->hash, OBJ_TREE);
 
 	if (memchr(msg, '\0', msg_len))
 		return error("a NUL byte in commit log message not allowed.");
@@ -1544,7 +1543,7 @@ int commit_tree_extended(const char *msg, size_t msg_len,
 	encoding_is_utf8 = is_encoding_utf8(git_commit_encoding);
 
 	strbuf_init(&buffer, 8192); /* should avoid reallocs for the headers */
-	strbuf_addf(&buffer, "tree %s\n", sha1_to_hex(tree));
+	strbuf_addf(&buffer, "tree %s\n", oid_to_hex(tree));
 
 	/*
 	 * NOTE! This ordering means that the same exact tree merged with a
@@ -1583,7 +1582,7 @@ int commit_tree_extended(const char *msg, size_t msg_len,
 		goto out;
 	}
 
-	result = write_sha1_file(buffer.buf, buffer.len, commit_type, ret);
+	result = write_sha1_file(buffer.buf, buffer.len, commit_type, ret->hash);
 out:
 	strbuf_release(&buffer);
 	return result;
diff --git a/commit.h b/commit.h
index 8c68ca1a5a..5dd9df4448 100644
--- a/commit.h
+++ b/commit.h
@@ -263,14 +263,15 @@ extern void append_merge_tag_headers(struct commit_list *parents,
 				     struct commit_extra_header ***tail);
 
 extern int commit_tree(const char *msg, size_t msg_len,
-		       const unsigned char *tree,
-		       struct commit_list *parents, unsigned char *ret,
+		       const struct object_id *tree,
+		       struct commit_list *parents, struct object_id *ret,
 		       const char *author, const char *sign_commit);
 
 extern int commit_tree_extended(const char *msg, size_t msg_len,
-				const unsigned char *tree,
-				struct commit_list *parents, unsigned char *ret,
-				const char *author, const char *sign_commit,
+				const struct object_id *tree,
+				struct commit_list *parents,
+				struct object_id *ret, const char *author,
+				const char *sign_commit,
 				struct commit_extra_header *);
 
 extern struct commit_extra_header *read_commit_extra_headers(struct commit *, const char **);
diff --git a/notes-cache.c b/notes-cache.c
index 17ee8602b3..d2f87147cc 100644
--- a/notes-cache.c
+++ b/notes-cache.c
@@ -56,8 +56,8 @@ int notes_cache_write(struct notes_cache *c)
 
 	if (write_notes_tree(&c->tree, tree_oid.hash))
 		return -1;
-	if (commit_tree(c->validity, strlen(c->validity), tree_oid.hash, NULL,
-			commit_oid.hash, NULL, NULL) < 0)
+	if (commit_tree(c->validity, strlen(c->validity), &tree_oid, NULL,
+			&commit_oid, NULL, NULL) < 0)
 		return -1;
 	if (update_ref("update notes cache", c->tree.update_ref, &commit_oid,
 		       NULL, 0, UPDATE_REFS_QUIET_ON_ERR) < 0)
diff --git a/notes-merge.c b/notes-merge.c
index 0f6573cb17..c09c5e0e47 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -642,9 +642,8 @@ int notes_merge(struct notes_merge_options *o,
 		struct commit_list *parents = NULL;
 		commit_list_insert(remote, &parents); /* LIFO order */
 		commit_list_insert(local, &parents);
-		create_notes_commit(local_tree, parents,
-				    o->commit_msg.buf, o->commit_msg.len,
-				    result_oid->hash);
+		create_notes_commit(local_tree, parents, o->commit_msg.buf,
+				    o->commit_msg.len, result_oid);
 	}
 
 found_result:
@@ -718,8 +717,8 @@ int notes_merge_commit(struct notes_merge_options *o,
 		strbuf_setlen(&path, baselen);
 	}
 
-	create_notes_commit(partial_tree, partial_commit->parents,
-			    msg, strlen(msg), result_oid->hash);
+	create_notes_commit(partial_tree, partial_commit->parents, msg,
+			    strlen(msg), result_oid);
 	unuse_commit_buffer(partial_commit, buffer);
 	if (o->verbosity >= 4)
 		printf("Finalized notes merge commit: %s\n",
diff --git a/notes-utils.c b/notes-utils.c
index 5c8e70c98f..058c642dac 100644
--- a/notes-utils.c
+++ b/notes-utils.c
@@ -6,7 +6,7 @@
 
 void create_notes_commit(struct notes_tree *t, struct commit_list *parents,
 			 const char *msg, size_t msg_len,
-			 unsigned char *result_sha1)
+			 struct object_id *result_oid)
 {
 	struct object_id tree_oid;
 
@@ -27,7 +27,8 @@ void create_notes_commit(struct notes_tree *t, struct commit_list *parents,
 		/* else: t->ref points to nothing, assume root/orphan commit */
 	}
 
-	if (commit_tree(msg, msg_len, tree_oid.hash, parents, result_sha1, NULL, NULL))
+	if (commit_tree(msg, msg_len, &tree_oid, parents, result_oid, NULL,
+			NULL))
 		die("Failed to commit notes tree to database");
 }
 
@@ -47,7 +48,7 @@ void commit_notes(struct notes_tree *t, const char *msg)
 	strbuf_addstr(&buf, msg);
 	strbuf_complete_line(&buf);
 
-	create_notes_commit(t, NULL, buf.buf, buf.len, commit_oid.hash);
+	create_notes_commit(t, NULL, buf.buf, buf.len, &commit_oid);
 	strbuf_insert(&buf, 0, "notes: ", 7); /* commit message starts at index 7 */
 	update_ref(buf.buf, t->update_ref, &commit_oid, NULL, 0,
 		   UPDATE_REFS_DIE_ON_ERR);
diff --git a/notes-utils.h b/notes-utils.h
index 1190578398..5d79cbef51 100644
--- a/notes-utils.h
+++ b/notes-utils.h
@@ -15,7 +15,8 @@
  * The resulting commit SHA1 is stored in result_sha1.
  */
 void create_notes_commit(struct notes_tree *t, struct commit_list *parents,
-			 const char *msg, size_t msg_len, unsigned char *result_sha1);
+			 const char *msg, size_t msg_len,
+			 struct object_id *result_oid);
 
 void commit_notes(struct notes_tree *t, const char *msg);
 
-- 
2.14.3

