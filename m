Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C55601FADF
	for <e@80x24.org>; Thu, 18 Jan 2018 14:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932500AbeAROv0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 09:51:26 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:37810 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932352AbeAROvV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 09:51:21 -0500
Received: by mail-lf0-f68.google.com with SMTP id f3so27019632lfe.4
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 06:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
         :references;
        bh=VBnV51gqJz2gmnvFs8+ZIB5znRScYAPp7gF/kkoM5UE=;
        b=X/hNymkoHYp+qO8jyz+S/Ntv0KGfVeLg25omsO+Yb2JR7hCL6Ov24a1hzx6YUZZ/id
         ZUcjftLVg+AZxMVGmwEhS4iD283yh9OYtI1FpjcPoDmcdGYwzYjuQMWdpkF+k7SeuqRW
         PwcTmvyfget2sNNA69+Em6MuoD9ojVyxuPIQlSgQuQbjfpE90WcOvwQ2kB6CM13qHQER
         rt6QnLk08gEC8E+tiH2gJfvxv1bjIRxIHhOjApHpzhUJehdohQu7LE1788roBmyU5j6y
         ao8z6EgA1LGkbU1BT+63cJi5mJcYTFwIybFMnYj688wyp6wPrHGwS+r0FBywI67Ni1cM
         deYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=VBnV51gqJz2gmnvFs8+ZIB5znRScYAPp7gF/kkoM5UE=;
        b=JGdTxssqJd3ND2zCBRAXGFbHqPBvw9NAx0Xlm/6b0yp4LMsthYFutETPJ/JdITFnh4
         lTAEDaHg6etrN9S+7fHmeELI7/B8xbqtEvy3c/ecbrwW/KgQQmX3B+XnHl/gqRKswQqB
         P/Q8fHUOMvW9hFaD2NkfCeXeBIzu38WWJsW5at+xwAesDYVUVLPJQ5XkAs0XvWvzzweQ
         zFo9mPOCqLoq9OUzDtKfZi8nyekCXlpaNIFPGBYTyFWdwQO3Hhs779nh2SjRww17JTkn
         47JyYolz9tpuBx9+34+Tqu2PssF11SLb6+9lvr0LP9+WPlc84Xka5nGTV5ho2kKs3XOI
         pVNA==
X-Gm-Message-State: AKwxytd4W4zoZzRVwRUOkr9tXAN2EF+do6RLD/fB/AFRl6Qtlfs/G8hY
        1emI0f+7X1d0qbfHkUMeBvAyjIpeyQc=
X-Google-Smtp-Source: ACJfBovoEbzMDKsnZqXiNbduFPK+TZWlqdXez+mkv6hozPootMtNtcv5rbI9/abrtOvF2S6ojqDmbg==
X-Received: by 10.46.112.6 with SMTP id l6mr7471601ljc.32.1516287079457;
        Thu, 18 Jan 2018 06:51:19 -0800 (PST)
Received: from localhost.localdomain ([188.121.16.104])
        by smtp.gmail.com with ESMTPSA id 23sm560988lju.28.2018.01.18.06.51.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Jan 2018 06:51:18 -0800 (PST)
From:   Patryk Obara <patryk.obara@gmail.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.ath.cx>
Subject: [PATCH 08/11] commit: convert commit_tree* to object_id
Date:   Thu, 18 Jan 2018 15:51:00 +0100
Message-Id: <69c85a0cd881b6ff1195f261bdcf6f92b637dc5e.1516282880.git.patryk.obara@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <cover.1516282880.git.patryk.obara@gmail.com>
References: <cover.1516282880.git.patryk.obara@gmail.com>
In-Reply-To: <cover.1516282880.git.patryk.obara@gmail.com>
References: <cover.1516282880.git.patryk.obara@gmail.com>
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

