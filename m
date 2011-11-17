From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/8] Rename resolve_ref() to resolve_ref_unsafe()
Date: Thu, 17 Nov 2011 16:32:09 +0700
Message-ID: <1321522335-24193-3-git-send-email-pclouds@gmail.com>
References: <1321522335-24193-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 17 10:29:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQyHN-0002cr-3D
	for gcvg-git-2@lo.gmane.org; Thu, 17 Nov 2011 10:29:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756130Ab1KQJ3A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Nov 2011 04:29:00 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:44094 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754693Ab1KQJ25 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2011 04:28:57 -0500
Received: by mail-iy0-f174.google.com with SMTP id e36so1839093iag.19
        for <git@vger.kernel.org>; Thu, 17 Nov 2011 01:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=fPQB0k+Ft/aX1vq0FNxaaJA0miK7fSpWmY7tapS5oNY=;
        b=dGB0TLSnyYHyixAa3iyvZ+BhJELJ++SbT4GSXYl0KWCYKdYCU1fdmaYWww14mVqeF1
         TUoP2VNfVMdPBOU/8wSL+zNFJF2fvUln3NxFWEQwdgrtHGd0ZYCB+/mIJW8ckp71hfNE
         HgKI/yhLjR+xbizPtT4LHFVeauKEIO+7w1GJM=
Received: by 10.42.156.9 with SMTP id x9mr39900589icw.42.1321522137441;
        Thu, 17 Nov 2011 01:28:57 -0800 (PST)
Received: from tre ([115.74.43.88])
        by mx.google.com with ESMTPS id l28sm14553817ibc.3.2011.11.17.01.28.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 Nov 2011 01:28:56 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Thu, 17 Nov 2011 16:32:33 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
In-Reply-To: <1321522335-24193-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185582>

resolve_ref() may return a pointer to a shared buffer and can be
overwritten by the next resolve_ref() calls. Callers need to
pay attention, not to keep the pointer when the next call happens.

Rename with "_unsafe" suffix to warn developers (or reviewers) before
introducing new call sites.

This patch is generated using this command

git grep -l 'resolve_ref(' -- '*.[ch]'|xargs sed -i 's/resolve_ref(/res=
olve_ref_unsafe(/g'

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 branch.c                |    2 +-
 builtin/branch.c        |    6 +++---
 builtin/checkout.c      |    2 +-
 builtin/commit.c        |    2 +-
 builtin/fmt-merge-msg.c |    2 +-
 builtin/for-each-ref.c  |    2 +-
 builtin/fsck.c          |    2 +-
 builtin/merge.c         |    2 +-
 builtin/notes.c         |    2 +-
 builtin/receive-pack.c  |    4 ++--
 builtin/remote.c        |    2 +-
 builtin/show-branch.c   |    4 ++--
 builtin/symbolic-ref.c  |    2 +-
 cache.h                 |    2 +-
 reflog-walk.c           |    4 ++--
 refs.c                  |   20 ++++++++++----------
 remote.c                |    6 +++---
 transport.c             |    2 +-
 wt-status.c             |    2 +-
 19 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/branch.c b/branch.c
index d809876..243355b 100644
--- a/branch.c
+++ b/branch.c
@@ -151,7 +151,7 @@ int validate_new_branchname(const char *name, struc=
t strbuf *ref,
 		const char *head;
 		unsigned char sha1[20];
=20
-		head =3D resolve_ref("HEAD", sha1, 0, NULL);
+		head =3D resolve_ref_unsafe("HEAD", sha1, 0, NULL);
 		if (!is_bare_repository() && head && !strcmp(head, ref->buf))
 			die("Cannot force update the current branch.");
 	}
diff --git a/builtin/branch.c b/builtin/branch.c
index 0fe9c4d..6903b0d 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -115,7 +115,7 @@ static int branch_merged(int kind, const char *name=
,
 		    branch->merge[0] &&
 		    branch->merge[0]->dst &&
 		    (reference_name =3D
-		     resolve_ref(branch->merge[0]->dst, sha1, 1, NULL)) !=3D NULL)
+		     resolve_ref_unsafe(branch->merge[0]->dst, sha1, 1, NULL)) !=3D =
NULL)
 			reference_rev =3D lookup_commit_reference(sha1);
 	}
 	if (!reference_rev)
@@ -250,7 +250,7 @@ static char *resolve_symref(const char *src, const =
char *prefix)
 	int flag;
 	const char *dst, *cp;
=20
-	dst =3D resolve_ref(src, sha1, 0, &flag);
+	dst =3D resolve_ref_unsafe(src, sha1, 0, &flag);
 	if (!(dst && (flag & REF_ISSYMREF)))
 		return NULL;
 	if (prefix && (cp =3D skip_prefix(dst, prefix)))
@@ -688,7 +688,7 @@ int cmd_branch(int argc, const char **argv, const c=
har *prefix)
=20
 	track =3D git_branch_track;
=20
-	head =3D resolve_ref("HEAD", head_sha1, 0, NULL);
+	head =3D resolve_ref_unsafe("HEAD", head_sha1, 0, NULL);
 	if (!head)
 		die(_("Failed to resolve HEAD as a valid ref."));
 	head =3D xstrdup(head);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index beeaee4..2b8e73b 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -699,7 +699,7 @@ static int switch_branches(struct checkout_opts *op=
ts, struct branch_info *new)
 	unsigned char rev[20];
 	int flag;
 	memset(&old, 0, sizeof(old));
-	old.path =3D xstrdup(resolve_ref("HEAD", rev, 0, &flag));
+	old.path =3D xstrdup(resolve_ref_unsafe("HEAD", rev, 0, &flag));
 	old.commit =3D lookup_commit_reference_gently(rev, 1);
 	if (!(flag & REF_ISSYMREF)) {
 		free((char *)old.path);
diff --git a/builtin/commit.c b/builtin/commit.c
index c46f2d1..0be3b45 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1259,7 +1259,7 @@ static void print_summary(const char *prefix, con=
st unsigned char *sha1,
 	struct commit *commit;
 	struct strbuf format =3D STRBUF_INIT;
 	unsigned char junk_sha1[20];
-	const char *head =3D resolve_ref("HEAD", junk_sha1, 0, NULL);
+	const char *head =3D resolve_ref_unsafe("HEAD", junk_sha1, 0, NULL);
 	struct pretty_print_context pctx =3D {0};
 	struct strbuf author_ident =3D STRBUF_INIT;
 	struct strbuf committer_ident =3D STRBUF_INIT;
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 7e2f225..5c9b40e 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -263,7 +263,7 @@ static int do_fmt_merge_msg(int merge_title, struct=
 strbuf *in,
 	const char *current_branch;
=20
 	/* get current branch */
-	current_branch =3D resolve_ref("HEAD", head_sha1, 1, NULL);
+	current_branch =3D resolve_ref_unsafe("HEAD", head_sha1, 1, NULL);
 	if (!current_branch)
 		die("No current branch");
 	if (!prefixcmp(current_branch, "refs/heads/"))
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index d90e5d2..b954ca8 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -629,7 +629,7 @@ static void populate_value(struct refinfo *ref)
 	if (need_symref && (ref->flag & REF_ISSYMREF) && !ref->symref) {
 		unsigned char unused1[20];
 		const char *symref;
-		symref =3D resolve_ref(ref->refname, unused1, 1, NULL);
+		symref =3D resolve_ref_unsafe(ref->refname, unused1, 1, NULL);
 		if (symref)
 			ref->symref =3D xstrdup(symref);
 		else
diff --git a/builtin/fsck.c b/builtin/fsck.c
index df1a88b..0e0e17a 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -532,7 +532,7 @@ static int fsck_head_link(void)
 	if (verbose)
 		fprintf(stderr, "Checking HEAD link\n");
=20
-	head_points_at =3D resolve_ref("HEAD", head_sha1, 0, &flag);
+	head_points_at =3D resolve_ref_unsafe("HEAD", head_sha1, 0, &flag);
 	if (!head_points_at)
 		return error("Invalid HEAD");
 	if (!strcmp(head_points_at, "HEAD"))
diff --git a/builtin/merge.c b/builtin/merge.c
index 42b4f9e..519e3c5 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1095,7 +1095,7 @@ int cmd_merge(int argc, const char **argv, const =
char *prefix)
 	 * Check if we are _not_ on a detached HEAD, i.e. if there is a
 	 * current branch.
 	 */
-	branch =3D resolve_ref("HEAD", head_sha1, 0, &flag);
+	branch =3D resolve_ref_unsafe("HEAD", head_sha1, 0, &flag);
 	if (branch && !prefixcmp(branch, "refs/heads/"))
 		branch +=3D 11;
 	if (!branch || is_null_sha1(head_sha1))
diff --git a/builtin/notes.c b/builtin/notes.c
index f8e437d..e191ce6 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -825,7 +825,7 @@ static int merge_commit(struct notes_merge_options =
*o)
 	t =3D xcalloc(1, sizeof(struct notes_tree));
 	init_notes(t, "NOTES_MERGE_PARTIAL", combine_notes_overwrite, 0);
=20
-	o->local_ref =3D resolve_ref("NOTES_MERGE_REF", sha1, 0, NULL);
+	o->local_ref =3D resolve_ref_unsafe("NOTES_MERGE_REF", sha1, 0, NULL)=
;
 	if (!o->local_ref)
 		die("Failed to resolve NOTES_MERGE_REF");
=20
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 7ec68a1..333f2b0 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -571,7 +571,7 @@ static void check_aliased_update(struct command *cm=
d, struct string_list *list)
 	int flag;
=20
 	strbuf_addf(&buf, "%s%s", get_git_namespace(), cmd->ref_name);
-	dst_name =3D resolve_ref(buf.buf, sha1, 0, &flag);
+	dst_name =3D resolve_ref_unsafe(buf.buf, sha1, 0, &flag);
 	strbuf_release(&buf);
=20
 	if (!(flag & REF_ISSYMREF))
@@ -695,7 +695,7 @@ static void execute_commands(struct command *comman=
ds, const char *unpacker_erro
=20
 	check_aliased_updates(commands);
=20
-	head_name =3D resolve_ref("HEAD", sha1, 0, NULL);
+	head_name =3D resolve_ref_unsafe("HEAD", sha1, 0, NULL);
=20
 	for (cmd =3D commands; cmd; cmd =3D cmd->next)
 		if (!cmd->skip_update)
diff --git a/builtin/remote.c b/builtin/remote.c
index 407abfb..583eec9 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -573,7 +573,7 @@ static int read_remote_branches(const char *refname=
,
 	strbuf_addf(&buf, "refs/remotes/%s/", rename->old);
 	if (!prefixcmp(refname, buf.buf)) {
 		item =3D string_list_append(rename->remote_branches, xstrdup(refname=
));
-		symref =3D resolve_ref(refname, orig_sha1, 1, &flag);
+		symref =3D resolve_ref_unsafe(refname, orig_sha1, 1, &flag);
 		if (flag & REF_ISSYMREF)
 			item->util =3D xstrdup(symref);
 		else
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 4b480d7..1e7bd31 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -728,7 +728,7 @@ int cmd_show_branch(int ac, const char **av, const =
char *prefix)
 			static const char *fake_av[2];
 			const char *refname;
=20
-			refname =3D resolve_ref("HEAD", sha1, 1, NULL);
+			refname =3D resolve_ref_unsafe("HEAD", sha1, 1, NULL);
 			fake_av[0] =3D xstrdup(refname);
 			fake_av[1] =3D NULL;
 			av =3D fake_av;
@@ -791,7 +791,7 @@ int cmd_show_branch(int ac, const char **av, const =
char *prefix)
 		}
 	}
=20
-	head_p =3D resolve_ref("HEAD", head_sha1, 1, NULL);
+	head_p =3D resolve_ref_unsafe("HEAD", head_sha1, 1, NULL);
 	if (head_p) {
 		head_len =3D strlen(head_p);
 		memcpy(head, head_p, head_len + 1);
diff --git a/builtin/symbolic-ref.c b/builtin/symbolic-ref.c
index dea849c..2ef5962 100644
--- a/builtin/symbolic-ref.c
+++ b/builtin/symbolic-ref.c
@@ -12,7 +12,7 @@ static void check_symref(const char *HEAD, int quiet)
 {
 	unsigned char sha1[20];
 	int flag;
-	const char *refs_heads_master =3D resolve_ref(HEAD, sha1, 0, &flag);
+	const char *refs_heads_master =3D resolve_ref_unsafe(HEAD, sha1, 0, &=
flag);
=20
 	if (!refs_heads_master)
 		die("No such ref: %s", HEAD);
diff --git a/cache.h b/cache.h
index 5badece..61f023a 100644
--- a/cache.h
+++ b/cache.h
@@ -866,7 +866,7 @@ extern int read_ref(const char *filename, unsigned =
char *sha1);
  *
  * errno is sometimes set on errors, but not always.
  */
-extern const char *resolve_ref(const char *ref, unsigned char *sha1, i=
nt reading, int *flag);
+extern const char *resolve_ref_unsafe(const char *ref, unsigned char *=
sha1, int reading, int *flag);
=20
 extern int dwim_ref(const char *str, int len, unsigned char *sha1, cha=
r **ref);
 extern int dwim_log(const char *str, int len, unsigned char *sha1, cha=
r **ref);
diff --git a/reflog-walk.c b/reflog-walk.c
index 5d81d39..b9b2453 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -50,7 +50,7 @@ static struct complete_reflogs *read_complete_reflog(=
const char *ref)
 	for_each_reflog_ent(ref, read_one_reflog, reflogs);
 	if (reflogs->nr =3D=3D 0) {
 		unsigned char sha1[20];
-		const char *name =3D resolve_ref(ref, sha1, 1, NULL);
+		const char *name =3D resolve_ref_unsafe(ref, sha1, 1, NULL);
 		if (name)
 			for_each_reflog_ent(name, read_one_reflog, reflogs);
 	}
@@ -168,7 +168,7 @@ int add_reflog_for_walk(struct reflog_walk_info *in=
fo,
 	else {
 		if (*branch =3D=3D '\0') {
 			unsigned char sha1[20];
-			const char *head =3D resolve_ref("HEAD", sha1, 0, NULL);
+			const char *head =3D resolve_ref_unsafe("HEAD", sha1, 0, NULL);
 			if (!head)
 				die ("No current branch");
 			free(branch);
diff --git a/refs.c b/refs.c
index 44c1c86..9e42e36 100644
--- a/refs.c
+++ b/refs.c
@@ -361,7 +361,7 @@ static int warn_if_dangling_symref(const char *refn=
ame, const unsigned char *sha
 	if (!(flags & REF_ISSYMREF))
 		return 0;
=20
-	resolves_to =3D resolve_ref(refname, junk, 0, NULL);
+	resolves_to =3D resolve_ref_unsafe(refname, junk, 0, NULL);
 	if (!resolves_to || strcmp(resolves_to, d->refname))
 		return 0;
=20
@@ -497,7 +497,7 @@ static int get_packed_ref(const char *ref, unsigned=
 char *sha1)
 	return -1;
 }
=20
-const char *resolve_ref(const char *ref, unsigned char *sha1, int read=
ing, int *flag)
+const char *resolve_ref_unsafe(const char *ref, unsigned char *sha1, i=
nt reading, int *flag)
 {
 	int depth =3D MAXDEPTH;
 	ssize_t len;
@@ -614,7 +614,7 @@ struct ref_filter {
=20
 int read_ref_full(const char *ref, unsigned char *sha1, int reading, i=
nt *flags)
 {
-	if (resolve_ref(ref, sha1, reading, flags))
+	if (resolve_ref_unsafe(ref, sha1, reading, flags))
 		return 0;
 	return -1;
 }
@@ -1118,7 +1118,7 @@ int dwim_ref(const char *str, int len, unsigned c=
har *sha1, char **ref)
=20
 		this_result =3D refs_found ? sha1_from_ref : sha1;
 		mksnpath(fullref, sizeof(fullref), *p, len, str);
-		r =3D resolve_ref(fullref, this_result, 1, &flag);
+		r =3D resolve_ref_unsafe(fullref, this_result, 1, &flag);
 		if (r) {
 			if (!refs_found++)
 				*ref =3D xstrdup(r);
@@ -1148,7 +1148,7 @@ int dwim_log(const char *str, int len, unsigned c=
har *sha1, char **log)
 		const char *ref, *it;
=20
 		mksnpath(path, sizeof(path), *p, len, str);
-		ref =3D resolve_ref(path, hash, 1, NULL);
+		ref =3D resolve_ref_unsafe(path, hash, 1, NULL);
 		if (!ref)
 			continue;
 		if (!stat(git_path("logs/%s", path), &st) &&
@@ -1184,7 +1184,7 @@ static struct ref_lock *lock_ref_sha1_basic(const=
 char *ref, const unsigned char
 	lock =3D xcalloc(1, sizeof(struct ref_lock));
 	lock->lock_fd =3D -1;
=20
-	ref =3D resolve_ref(ref, lock->old_sha1, mustexist, &type);
+	ref =3D resolve_ref_unsafe(ref, lock->old_sha1, mustexist, &type);
 	if (!ref && errno =3D=3D EISDIR) {
 		/* we are trying to lock foo but we used to
 		 * have foo/bar which now does not exist;
@@ -1197,7 +1197,7 @@ static struct ref_lock *lock_ref_sha1_basic(const=
 char *ref, const unsigned char
 			error("there are still refs under '%s'", orig_ref);
 			goto error_return;
 		}
-		ref =3D resolve_ref(orig_ref, lock->old_sha1, mustexist, &type);
+		ref =3D resolve_ref_unsafe(orig_ref, lock->old_sha1, mustexist, &typ=
e);
 	}
 	if (type_p)
 	    *type_p =3D type;
@@ -1360,7 +1360,7 @@ int rename_ref(const char *oldref, const char *ne=
wref, const char *logmsg)
 	if (log && S_ISLNK(loginfo.st_mode))
 		return error("reflog for %s is a symlink", oldref);
=20
-	symref =3D resolve_ref(oldref, orig_sha1, 1, &flag);
+	symref =3D resolve_ref_unsafe(oldref, orig_sha1, 1, &flag);
 	if (flag & REF_ISSYMREF)
 		return error("refname %s is a symbolic ref, renaming it is not suppo=
rted",
 			oldref);
@@ -1649,7 +1649,7 @@ int write_ref_sha1(struct ref_lock *lock,
 		unsigned char head_sha1[20];
 		int head_flag;
 		const char *head_ref;
-		head_ref =3D resolve_ref("HEAD", head_sha1, 1, &head_flag);
+		head_ref =3D resolve_ref_unsafe("HEAD", head_sha1, 1, &head_flag);
 		if (head_ref && (head_flag & REF_ISSYMREF) &&
 		    !strcmp(head_ref, lock->ref_name))
 			log_ref_write("HEAD", lock->old_sha1, sha1, logmsg);
@@ -1986,7 +1986,7 @@ int update_ref(const char *action, const char *re=
fname,
 int ref_exists(const char *refname)
 {
 	unsigned char sha1[20];
-	return !!resolve_ref(refname, sha1, 1, NULL);
+	return !!resolve_ref_unsafe(refname, sha1, 1, NULL);
 }
=20
 struct ref *find_ref_by_name(const struct ref *list, const char *name)
diff --git a/remote.c b/remote.c
index 6655bb0..73a3809 100644
--- a/remote.c
+++ b/remote.c
@@ -482,7 +482,7 @@ static void read_config(void)
 		return;
 	default_remote_name =3D xstrdup("origin");
 	current_branch =3D NULL;
-	head_ref =3D resolve_ref("HEAD", sha1, 0, &flag);
+	head_ref =3D resolve_ref_unsafe("HEAD", sha1, 0, &flag);
 	if (head_ref && (flag & REF_ISSYMREF) &&
 	    !prefixcmp(head_ref, "refs/heads/")) {
 		current_branch =3D
@@ -1007,7 +1007,7 @@ static char *guess_ref(const char *name, struct r=
ef *peer)
 	struct strbuf buf =3D STRBUF_INIT;
 	unsigned char sha1[20];
=20
-	const char *r =3D resolve_ref(peer->name, sha1, 1, NULL);
+	const char *r =3D resolve_ref_unsafe(peer->name, sha1, 1, NULL);
 	if (!r)
 		return NULL;
=20
@@ -1058,7 +1058,7 @@ static int match_explicit(struct ref *src, struct=
 ref *dst,
 		unsigned char sha1[20];
 		int flag;
=20
-		dst_value =3D resolve_ref(matched_src->name, sha1, 1, &flag);
+		dst_value =3D resolve_ref_unsafe(matched_src->name, sha1, 1, &flag);
 		if (!dst_value ||
 		    ((flag & REF_ISSYMREF) &&
 		     prefixcmp(dst_value, "refs/heads/")))
diff --git a/transport.c b/transport.c
index 51814b5..e9797c0 100644
--- a/transport.c
+++ b/transport.c
@@ -163,7 +163,7 @@ static void set_upstreams(struct transport *transpo=
rt, struct ref *refs,
 		/* Follow symbolic refs (mainly for HEAD). */
 		localname =3D ref->peer_ref->name;
 		remotename =3D ref->name;
-		tmp =3D resolve_ref(localname, sha, 1, &flag);
+		tmp =3D resolve_ref_unsafe(localname, sha, 1, &flag);
 		if (tmp && flag & REF_ISSYMREF &&
 			!prefixcmp(tmp, "refs/heads/"))
 			localname =3D tmp;
diff --git a/wt-status.c b/wt-status.c
index 70fdb76..cc6dad5 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -119,7 +119,7 @@ void wt_status_prepare(struct wt_status *s)
 	s->show_untracked_files =3D SHOW_NORMAL_UNTRACKED_FILES;
 	s->use_color =3D -1;
 	s->relative_paths =3D 1;
-	head =3D resolve_ref("HEAD", sha1, 0, NULL);
+	head =3D resolve_ref_unsafe("HEAD", sha1, 0, NULL);
 	s->branch =3D head ? xstrdup(head) : NULL;
 	s->reference =3D "HEAD";
 	s->fp =3D stdout;
--=20
1.7.4.74.g639db
