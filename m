From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/4] Rename resolve_ref() to resolve_ref_unsafe()
Date: Mon, 12 Dec 2011 18:20:32 +0700
Message-ID: <1323688832-32016-4-git-send-email-pclouds@gmail.com>
References: <1323688832-32016-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 12 12:22:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ra3xj-0000Q0-DO
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 12:22:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752665Ab1LLLWW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Dec 2011 06:22:22 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:52734 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752085Ab1LLLWV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 06:22:21 -0500
Received: by mail-iy0-f174.google.com with SMTP id h11so3065808iae.19
        for <git@vger.kernel.org>; Mon, 12 Dec 2011 03:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=rhvBbJwnJKQ0QLNPloWDtofp98zR957pO2au47ApEf0=;
        b=JldQnNBCwqnw/IybsAgW5JmK97XuQObW8rjTLuQvNZBQOOQFXOzhE8TdmO7y37Q4Uc
         1z3fVC2imuftXLRO7ouAcqB6XSCDJx02U8/QFw6EznMc/L20tw/imSbL40dLTZzp32uD
         +evZFXCHfndXC9U8DJ8IGPve4o/uXaE8vqd0M=
Received: by 10.42.189.5 with SMTP id dc5mr11326352icb.51.1323688941080;
        Mon, 12 Dec 2011 03:22:21 -0800 (PST)
Received: from tre ([115.74.36.175])
        by mx.google.com with ESMTPS id mb4sm40117873igc.1.2011.12.12.03.22.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 12 Dec 2011 03:22:19 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Mon, 12 Dec 2011 18:20:55 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1323688832-32016-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186908>

resolve_ref() may return a pointer to a shared buffer and can be
overwritten by the next resolve_ref() calls. Callers need to
pay attention, not to keep the pointer when the next call happens.

Rename with "_unsafe" suffix to warn developers (or reviewers) before
introducing new call sites.

This patch is generated using the following command

git grep -l 'resolve_ref(' -- '*.[ch]'|xargs sed -i 's/resolve_ref(/res=
olve_ref_unsafe(/g'

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 branch.c               |    2 +-
 builtin/branch.c       |    2 +-
 builtin/commit.c       |    2 +-
 builtin/fsck.c         |    2 +-
 builtin/log.c          |    4 ++--
 builtin/receive-pack.c |    2 +-
 builtin/remote.c       |    2 +-
 builtin/show-branch.c  |    2 +-
 builtin/symbolic-ref.c |    2 +-
 cache.h                |    2 +-
 refs.c                 |   20 ++++++++++----------
 remote.c               |    6 +++---
 test-resolve-ref.c     |    4 ++--
 transport.c            |    2 +-
 14 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/branch.c b/branch.c
index d91a099..772a4c2 100644
--- a/branch.c
+++ b/branch.c
@@ -182,7 +182,7 @@ int validate_new_branchname(const char *name, struc=
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
index 72c4c31..641bee1 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -251,7 +251,7 @@ static char *resolve_symref(const char *src, const =
char *prefix)
 	int flag;
 	const char *dst, *cp;
=20
-	dst =3D resolve_ref(src, sha1, 0, &flag);
+	dst =3D resolve_ref_unsafe(src, sha1, 0, &flag);
 	if (!(dst && (flag & REF_ISSYMREF)))
 		return NULL;
 	if (prefix && (cp =3D skip_prefix(dst, prefix)))
diff --git a/builtin/commit.c b/builtin/commit.c
index e36e9ad..4d39d25 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1304,7 +1304,7 @@ static void print_summary(const char *prefix, con=
st unsigned char *sha1,
 	rev.diffopt.break_opt =3D 0;
 	diff_setup_done(&rev.diffopt);
=20
-	head =3D resolve_ref("HEAD", junk_sha1, 0, NULL);
+	head =3D resolve_ref_unsafe("HEAD", junk_sha1, 0, NULL);
 	printf("[%s%s ",
 		!prefixcmp(head, "refs/heads/") ?
 			head + 11 :
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 30d0dc8..8c479a7 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -563,7 +563,7 @@ static int fsck_head_link(void)
 	if (verbose)
 		fprintf(stderr, "Checking HEAD link\n");
=20
-	head_points_at =3D resolve_ref("HEAD", head_sha1, 0, &flag);
+	head_points_at =3D resolve_ref_unsafe("HEAD", head_sha1, 0, &flag);
 	if (!head_points_at)
 		return error("Invalid HEAD");
 	if (!strcmp(head_points_at, "HEAD"))
diff --git a/builtin/log.c b/builtin/log.c
index 4395f3e..89d0cc0 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1040,7 +1040,7 @@ static char *find_branch_name(struct rev_info *re=
v)
 	if (positive < 0)
 		return NULL;
 	strbuf_addf(&buf, "refs/heads/%s", rev->cmdline.rev[positive].name);
-	branch =3D resolve_ref(buf.buf, branch_sha1, 1, NULL);
+	branch =3D resolve_ref_unsafe(buf.buf, branch_sha1, 1, NULL);
 	if (!branch ||
 	    prefixcmp(branch, "refs/heads/") ||
 	    hashcmp(rev->cmdline.rev[positive].item->sha1, branch_sha1))
@@ -1268,7 +1268,7 @@ int cmd_format_patch(int argc, const char **argv,=
 const char *prefix)
=20
 			rev.pending.objects[0].item->flags |=3D UNINTERESTING;
 			add_head_to_pending(&rev);
-			ref =3D resolve_ref("HEAD", sha1, 1, NULL);
+			ref =3D resolve_ref_unsafe("HEAD", sha1, 1, NULL);
 			if (ref && !prefixcmp(ref, "refs/heads/"))
 				branch_name =3D xstrdup(ref + strlen("refs/heads/"));
 			else
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 5cd6fc7..a1a4b09 100644
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
index a1f148e..a59e088 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -789,7 +789,7 @@ int cmd_show_branch(int ac, const char **av, const =
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
index ba5e911..051e7ee 100644
--- a/cache.h
+++ b/cache.h
@@ -865,7 +865,7 @@ extern int read_ref(const char *filename, unsigned =
char *sha1);
  *
  * errno is sometimes set on errors, but not always.
  */
-#define resolve_ref(ref, sha1, reading, flag) resolve_ref_real(ref, sh=
a1, reading, flag, __FILE__, __LINE__)
+#define resolve_ref_unsafe(ref, sha1, reading, flag) resolve_ref_real(=
ref, sha1, reading, flag, __FILE__, __LINE__)
 extern const char *resolve_ref_real(const char *ref, unsigned char *sh=
a1, int reading, int *flag, const char *file, int line);
 extern char *resolve_refdup(const char *ref, unsigned char *sha1, int =
reading, int *flag);
=20
diff --git a/refs.c b/refs.c
index cf8dfcc..010bb72 100644
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
@@ -616,7 +616,7 @@ const char *resolve_ref_real(const char *ref, unsig=
ned char *sha1,
=20
 char *resolve_refdup(const char *ref, unsigned char *sha1, int reading=
, int *flag)
 {
-	const char *ret =3D resolve_ref(ref, sha1, reading, flag);
+	const char *ret =3D resolve_ref_unsafe(ref, sha1, reading, flag);
 	return ret ? xstrdup(ret) : NULL;
 }
=20
@@ -629,7 +629,7 @@ struct ref_filter {
=20
 int read_ref_full(const char *ref, unsigned char *sha1, int reading, i=
nt *flags)
 {
-	if (resolve_ref(ref, sha1, reading, flags))
+	if (resolve_ref_unsafe(ref, sha1, reading, flags))
 		return 0;
 	return -1;
 }
@@ -1126,7 +1126,7 @@ int dwim_ref(const char *str, int len, unsigned c=
har *sha1, char **ref)
=20
 		this_result =3D refs_found ? sha1_from_ref : sha1;
 		mksnpath(fullref, sizeof(fullref), *p, len, str);
-		r =3D resolve_ref(fullref, this_result, 1, &flag);
+		r =3D resolve_ref_unsafe(fullref, this_result, 1, &flag);
 		if (r) {
 			if (!refs_found++)
 				*ref =3D xstrdup(r);
@@ -1156,7 +1156,7 @@ int dwim_log(const char *str, int len, unsigned c=
har *sha1, char **log)
 		const char *ref, *it;
=20
 		mksnpath(path, sizeof(path), *p, len, str);
-		ref =3D resolve_ref(path, hash, 1, NULL);
+		ref =3D resolve_ref_unsafe(path, hash, 1, NULL);
 		if (!ref)
 			continue;
 		if (!stat(git_path("logs/%s", path), &st) &&
@@ -1192,7 +1192,7 @@ static struct ref_lock *lock_ref_sha1_basic(const=
 char *ref, const unsigned char
 	lock =3D xcalloc(1, sizeof(struct ref_lock));
 	lock->lock_fd =3D -1;
=20
-	ref =3D resolve_ref(ref, lock->old_sha1, mustexist, &type);
+	ref =3D resolve_ref_unsafe(ref, lock->old_sha1, mustexist, &type);
 	if (!ref && errno =3D=3D EISDIR) {
 		/* we are trying to lock foo but we used to
 		 * have foo/bar which now does not exist;
@@ -1205,7 +1205,7 @@ static struct ref_lock *lock_ref_sha1_basic(const=
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
@@ -1368,7 +1368,7 @@ int rename_ref(const char *oldref, const char *ne=
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
@@ -1657,7 +1657,7 @@ int write_ref_sha1(struct ref_lock *lock,
 		unsigned char head_sha1[20];
 		int head_flag;
 		const char *head_ref;
-		head_ref =3D resolve_ref("HEAD", head_sha1, 1, &head_flag);
+		head_ref =3D resolve_ref_unsafe("HEAD", head_sha1, 1, &head_flag);
 		if (head_ref && (head_flag & REF_ISSYMREF) &&
 		    !strcmp(head_ref, lock->ref_name))
 			log_ref_write("HEAD", lock->old_sha1, sha1, logmsg);
@@ -1994,7 +1994,7 @@ int update_ref(const char *action, const char *re=
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
diff --git a/test-resolve-ref.c b/test-resolve-ref.c
index b772038..59d04e0 100644
--- a/test-resolve-ref.c
+++ b/test-resolve-ref.c
@@ -11,8 +11,8 @@ int main(int argc, char **argv)
 	 * function returns a shared buffer, so by the time the second
 	 * call is made, ref1 must _not_ be accessed any more.
 	 */
-	ref1 =3D resolve_ref("HEAD", sha1, 0, NULL);
-	ref2 =3D resolve_ref("HEAD", sha1, 0, NULL);
+	ref1 =3D resolve_ref_unsafe("HEAD", sha1, 0, NULL);
+	ref2 =3D resolve_ref_unsafe("HEAD", sha1, 0, NULL);
 	printf("ref1 =3D %s\nref2 =3D %s\n", ref1, ref2);
 	return 0;
 }
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
--=20
1.7.8.36.g69ee2
