From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/3] Make commit_tree() take message length in addition to the commit message
Date: Wed, 14 Dec 2011 21:08:17 +0700
Message-ID: <1323871699-8839-2-git-send-email-pclouds@gmail.com>
References: <1323777368-19697-1-git-send-email-pclouds@gmail.com>
 <1323871699-8839-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Miles Bader <miles@gnu.org>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 14 15:08:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RapVj-0002DL-2g
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 15:08:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757308Ab1LNOIi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Dec 2011 09:08:38 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:62916 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757207Ab1LNOIh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2011 09:08:37 -0500
Received: by iaeh11 with SMTP id h11so1289113iae.19
        for <git@vger.kernel.org>; Wed, 14 Dec 2011 06:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=3cfu7WbZ6H64wUUjjgbSW3nbdy9PlyQT2bIaC4LDHis=;
        b=GiX7GzA6IA2+V8Si5+xhFuSEq6VtrIsW2YSZ4V4efG4KwV6gQGskTC43w6VEvcmN2M
         EbI1spfklz/2YOJ3C/ommMz1eFQo+7qbvmtcU/zjsfTwjj1IRfmAnu/A2824WATIjsKQ
         WlbPr35IxeSTx7od1Is7HlORNYSlsr2+YWLU4=
Received: by 10.50.219.135 with SMTP id po7mr19777072igc.11.1323871716579;
        Wed, 14 Dec 2011 06:08:36 -0800 (PST)
Received: from tre ([115.74.57.162])
        by mx.google.com with ESMTPS id z22sm9425808ibg.5.2011.12.14.06.08.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 14 Dec 2011 06:08:35 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Wed, 14 Dec 2011 21:08:32 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1323871699-8839-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187118>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/commit-tree.c |    2 +-
 builtin/commit.c      |    2 +-
 builtin/merge.c       |    4 ++--
 builtin/notes.c       |    2 +-
 commit.c              |    4 ++--
 commit.h              |    2 +-
 notes-cache.c         |    2 +-
 notes-merge.c         |    8 ++++----
 notes-merge.h         |    2 +-
 9 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index d083795..8fa384f 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -56,7 +56,7 @@ int cmd_commit_tree(int argc, const char **argv, cons=
t char *prefix)
 	if (strbuf_read(&buffer, 0, 0) < 0)
 		die_errno("git commit-tree: failed to read");
=20
-	if (commit_tree(buffer.buf, tree_sha1, parents, commit_sha1, NULL)) {
+	if (commit_tree(buffer.buf, buffer.len, tree_sha1, parents, commit_sh=
a1, NULL)) {
 		strbuf_release(&buffer);
 		return 1;
 	}
diff --git a/builtin/commit.c b/builtin/commit.c
index 8f2bebe..ce0e47f 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1483,7 +1483,7 @@ int cmd_commit(int argc, const char **argv, const=
 char *prefix)
 		exit(1);
 	}
=20
-	if (commit_tree(sb.buf, active_cache_tree->sha1, parents, sha1,
+	if (commit_tree(sb.buf, sb.len, active_cache_tree->sha1, parents, sha=
1,
 			author_ident.buf)) {
 		rollback_index_files();
 		die(_("failed to write commit object"));
diff --git a/builtin/merge.c b/builtin/merge.c
index 2870a6a..df4548a 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -913,7 +913,7 @@ static int merge_trivial(struct commit *head)
 	parent->next->item =3D remoteheads->item;
 	parent->next->next =3D NULL;
 	prepare_to_commit();
-	commit_tree(merge_msg.buf, result_tree, parent, result_commit, NULL);
+	commit_tree(merge_msg.buf, merge_msg.len, result_tree, parent, result=
_commit, NULL);
 	finish(head, result_commit, "In-index merge");
 	drop_save();
 	return 0;
@@ -944,7 +944,7 @@ static int finish_automerge(struct commit *head,
 	strbuf_addch(&merge_msg, '\n');
 	prepare_to_commit();
 	free_commit_list(remoteheads);
-	commit_tree(merge_msg.buf, result_tree, parents, result_commit, NULL)=
;
+	commit_tree(merge_msg.buf, merge_msg.len, result_tree, parents, resul=
t_commit, NULL);
 	strbuf_addf(&buf, "Merge made by the '%s' strategy.", wt_strategy);
 	finish(head, result_commit, buf.buf);
 	strbuf_release(&buf);
diff --git a/builtin/notes.c b/builtin/notes.c
index f8e437d..d665459 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -306,7 +306,7 @@ void commit_notes(struct notes_tree *t, const char =
*msg)
 	if (buf.buf[buf.len - 1] !=3D '\n')
 		strbuf_addch(&buf, '\n'); /* Make sure msg ends with newline */
=20
-	create_notes_commit(t, NULL, buf.buf + 7, commit_sha1);
+	create_notes_commit(t, NULL, buf.buf + 7, buf.len - 7, commit_sha1);
 	update_ref(buf.buf, t->ref, commit_sha1, NULL, 0, DIE_ON_ERR);
=20
 	strbuf_release(&buf);
diff --git a/commit.c b/commit.c
index 73b7e00..d67b8c7 100644
--- a/commit.c
+++ b/commit.c
@@ -845,7 +845,7 @@ static const char commit_utf8_warn[] =3D
 "You may want to amend it after fixing the message, or set the config\=
n"
 "variable i18n.commitencoding to the encoding your project uses.\n";
=20
-int commit_tree(const char *msg, unsigned char *tree,
+int commit_tree(const char *msg, size_t msg_len, unsigned char *tree,
 		struct commit_list *parents, unsigned char *ret,
 		const char *author)
 {
@@ -884,7 +884,7 @@ int commit_tree(const char *msg, unsigned char *tre=
e,
 	strbuf_addch(&buffer, '\n');
=20
 	/* And add the comment */
-	strbuf_addstr(&buffer, msg);
+	strbuf_add(&buffer, msg, msg_len);
=20
 	/* And check the encoding */
 	if (encoding_is_utf8 && !is_utf8(buffer.buf))
diff --git a/commit.h b/commit.h
index 009b113..1acaf53 100644
--- a/commit.h
+++ b/commit.h
@@ -181,7 +181,7 @@ static inline int single_parent(struct commit *comm=
it)
=20
 struct commit_list *reduce_heads(struct commit_list *heads);
=20
-extern int commit_tree(const char *msg, unsigned char *tree,
+extern int commit_tree(const char *msg, size_t msg_len, unsigned char =
*tree,
 		struct commit_list *parents, unsigned char *ret,
 		const char *author);
=20
diff --git a/notes-cache.c b/notes-cache.c
index 4c8984e..04a5698 100644
--- a/notes-cache.c
+++ b/notes-cache.c
@@ -56,7 +56,7 @@ int notes_cache_write(struct notes_cache *c)
=20
 	if (write_notes_tree(&c->tree, tree_sha1))
 		return -1;
-	if (commit_tree(c->validity, tree_sha1, NULL, commit_sha1, NULL) < 0)
+	if (commit_tree(c->validity, strlen(c->validity), tree_sha1, NULL, co=
mmit_sha1, NULL) < 0)
 		return -1;
 	if (update_ref("update notes cache", c->tree.ref, commit_sha1, NULL,
 		       0, QUIET_ON_ERR) < 0)
diff --git a/notes-merge.c b/notes-merge.c
index ce10aac..b3baaf4 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -530,7 +530,7 @@ static int merge_from_diffs(struct notes_merge_opti=
ons *o,
 }
=20
 void create_notes_commit(struct notes_tree *t, struct commit_list *par=
ents,
-			 const char *msg, unsigned char *result_sha1)
+			 const char *msg, size_t msg_len, unsigned char *result_sha1)
 {
 	unsigned char tree_sha1[20];
=20
@@ -551,7 +551,7 @@ void create_notes_commit(struct notes_tree *t, stru=
ct commit_list *parents,
 		/* else: t->ref points to nothing, assume root/orphan commit */
 	}
=20
-	if (commit_tree(msg, tree_sha1, parents, result_sha1, NULL))
+	if (commit_tree(msg, msg_len, tree_sha1, parents, result_sha1, NULL))
 		die("Failed to commit notes tree to database");
 }
=20
@@ -669,7 +669,7 @@ int notes_merge(struct notes_merge_options *o,
 		commit_list_insert(remote, &parents); /* LIFO order */
 		commit_list_insert(local, &parents);
 		create_notes_commit(local_tree, parents, o->commit_msg.buf,
-				    result_sha1);
+				    o->commit_msg.len, result_sha1);
 	}
=20
 found_result:
@@ -734,7 +734,7 @@ int notes_merge_commit(struct notes_merge_options *=
o,
 	}
=20
 	create_notes_commit(partial_tree, partial_commit->parents, msg,
-			    result_sha1);
+			    strlen(msg), result_sha1);
 	if (o->verbosity >=3D 4)
 		printf("Finalized notes merge commit: %s\n",
 			sha1_to_hex(result_sha1));
diff --git a/notes-merge.h b/notes-merge.h
index 168a672..fd52988 100644
--- a/notes-merge.h
+++ b/notes-merge.h
@@ -37,7 +37,7 @@ void init_notes_merge_options(struct notes_merge_opti=
ons *o);
  * The resulting commit SHA1 is stored in result_sha1.
  */
 void create_notes_commit(struct notes_tree *t, struct commit_list *par=
ents,
-			 const char *msg, unsigned char *result_sha1);
+			 const char *msg, size_t msg_len, unsigned char *result_sha1);
=20
 /*
  * Merge notes from o->remote_ref into o->local_ref
--=20
1.7.8.36.g69ee2
