From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH 1/3] Change "refs/" references to symbolic constants
Date: Thu, 4 Oct 2007 22:10:13 +0100
Message-ID: <200710042210.13877.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 04 23:10:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdXxy-0000zg-6J
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 23:10:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761015AbXJDVKd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2007 17:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760693AbXJDVKc
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 17:10:32 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:13731 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759294AbXJDVK3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 17:10:29 -0400
Received: by nf-out-0910.google.com with SMTP id g13so407331nfb
        for <git@vger.kernel.org>; Thu, 04 Oct 2007 14:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        bh=FwF/dvQZzRbcbU5fOgdnKM7dhEOioEiB/PP/bTGXDOM=;
        b=B/N9kbN9GZ7kpnzhjA7TjISfaAaZBoYjCaXbdZH1yMBW5x5T+lhH7kCp2yUvo7mCduVIZ1hlwTYBxJ7OEPlD9IqUGttPnUBi02ZNw4X4X/VZBKLhri+z86OLgc57pByYYwTF43YE/GMcKZoA6Frj/nrrhgkw5oFMmBYjNy0Z7+0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=EdT4y2vj5hj7isfDclD6wPmxXvhbS1MUpAqNc7TpWhfj0yKd7apN1y5CWGcgsHiJYsIwoJOFNzs2UZHyA0NwYIi+/4WsHAf9L5h5IODBk045Bkv8NXA7PaIbPZLaE9qWdSXDNNUg0mkZa+EcIEVjAFq+Wphq3GGct0vPpAFl4cQ=
Received: by 10.82.172.10 with SMTP id u10mr216177bue.1191532225926;
        Thu, 04 Oct 2007 14:10:25 -0700 (PDT)
Received: from grissom.local ( [84.201.153.164])
        by mx.google.com with ESMTPS id i7sm1578716nfh.2007.10.04.14.10.22
        (version=SSLv3 cipher=OTHER);
        Thu, 04 Oct 2007 14:10:24 -0700 (PDT)
X-TUID: 8ed703c2e2601630
X-UID: 349
X-Length: 40119
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60004>

Changed repeated use of the same constants for the ref paths to be
symbolic constants.  I've defined them in refs.h

  refs/ is now PATH_REFS
  refs/heads/ is now PATH_REFS_HEADS
  refs/tags/ is now PATH_REFS_TAGS
  refs/remotes/ is now PATH_REFS_REMOTES

I've changed all references to them and made constants for the string
lengths as well.  This has clarified the code in some places; for
example:

 - len = strlen(refs[i]) + 11;
 + len = strlen(refs[i]) + STRLEN_PATH_REFS_TAGS + 1;

In this case 11 isn't STRLEN_PATH_REFS_HEADS, as it is in most other
cases, it's TAGS + 1.  With the change to symbolic constants it's much
clearer what is happening.

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
 builtin-branch.c        |   28 ++++++++++++++--------------
 builtin-describe.c      |    2 +-
 builtin-fetch--tool.c   |   10 +++++-----
 builtin-fmt-merge-msg.c |    5 +++--
 builtin-fsck.c          |    4 ++--
 builtin-init-db.c       |   15 ++++++++-------
 builtin-name-rev.c      |   14 +++++++-------
 builtin-pack-refs.c     |    2 +-
 builtin-push.c          |    6 +++---
 builtin-show-branch.c   |   34 +++++++++++++++++-----------------
 builtin-show-ref.c      |    6 +++---
 builtin-tag.c           |    4 ++--
 connect.c               |   10 +++++-----
 fetch-pack.c            |    6 +++---
 http-fetch.c            |   33 +++++++++++++++++----------------
 http-push.c             |   42 +++++++++++++++++++++---------------------
 local-fetch.c           |   13 +++++++------
 path.c                  |    5 +++--
 receive-pack.c          |    4 ++--
 reflog-walk.c           |    6 +++---
 refs.c                  |   18 +++++++++---------
 refs.h                  |   17 +++++++++++++++++
 remote.c                |   14 +++++++-------
 setup.c                 |    5 +++--
 sha1_name.c             |   10 +++++-----
 wt-status.c             |    5 +++--
 26 files changed, 171 insertions(+), 147 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index 3da8b55..3cb8aee 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -92,12 +92,12 @@ static int delete_branches(int argc, const char **argv, int force, int kinds)
 
 	switch (kinds) {
 	case REF_REMOTE_BRANCH:
-		fmt = "refs/remotes/%s";
+		fmt = PATH_REFS_REMOTES "%s";
 		remote = "remote ";
 		force = 1;
 		break;
 	case REF_LOCAL_BRANCH:
-		fmt = "refs/heads/%s";
+		fmt = PATH_REFS_HEADS "%s";
 		remote = "";
 		break;
 	default:
@@ -189,15 +189,15 @@ static int append_ref(const char *refname, const unsigned char *sha1, int flags,
 	int len;
 
 	/* Detect kind */
-	if (!prefixcmp(refname, "refs/heads/")) {
+	if (!prefixcmp(refname, PATH_REFS_HEADS)) {
 		kind = REF_LOCAL_BRANCH;
-		refname += 11;
-	} else if (!prefixcmp(refname, "refs/remotes/")) {
+		refname += STRLEN_PATH_REFS_HEADS;
+	} else if (!prefixcmp(refname, PATH_REFS_REMOTES)) {
 		kind = REF_REMOTE_BRANCH;
-		refname += 13;
-	} else if (!prefixcmp(refname, "refs/tags/")) {
+		refname += STRLEN_PATH_REFS_REMOTES;
+	} else if (!prefixcmp(refname, PATH_REFS_TAGS)) {
 		kind = REF_TAG;
-		refname += 10;
+		refname += STRLEN_PATH_REFS_TAGS;
 	}
 
 	/* Don't add types the caller doesn't want */
@@ -399,7 +399,7 @@ static void create_branch(const char *name, const char *start_name,
 	char *real_ref, ref[PATH_MAX], msg[PATH_MAX + 20];
 	int forcing = 0;
 
-	snprintf(ref, sizeof ref, "refs/heads/%s", name);
+	snprintf(ref, sizeof ref, PATH_REFS_HEADS "%s", name);
 	if (check_ref_format(ref))
 		die("'%s' is not a valid branch name.", name);
 
@@ -468,13 +468,13 @@ static void rename_branch(const char *oldname, const char *newname, int force)
 	if (!oldname)
 		die("cannot rename the current branch while not on any.");
 
-	if (snprintf(oldref, sizeof(oldref), "refs/heads/%s", oldname) > sizeof(oldref))
+	if (snprintf(oldref, sizeof(oldref), PATH_REFS_HEADS "%s", oldname) > sizeof(oldref))
 		die("Old branchname too long");
 
 	if (check_ref_format(oldref))
 		die("Invalid branch name: %s", oldref);
 
-	if (snprintf(newref, sizeof(newref), "refs/heads/%s", newname) > sizeof(newref))
+	if (snprintf(newref, sizeof(newref), PATH_REFS_HEADS "%s", newname) > sizeof(newref))
 		die("New branchname too long");
 
 	if (check_ref_format(newref))
@@ -601,9 +601,9 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		detached = 1;
 	}
 	else {
-		if (prefixcmp(head, "refs/heads/"))
-			die("HEAD not found below refs/heads!");
-		head += 11;
+		if (prefixcmp(head, PATH_REFS_HEADS))
+			die("HEAD not found below " PATH_REFS_HEADS "!");
+		head += STRLEN_PATH_REFS_HEADS;
 	}
 
 	if (delete)
diff --git a/builtin-describe.c b/builtin-describe.c
index 669110c..b6f5b45 100644
--- a/builtin-describe.c
+++ b/builtin-describe.c
@@ -53,7 +53,7 @@ static int get_name(const char *path, const unsigned char *sha1, int flag, void
 	 * If --tags, then any tags are used.
 	 * Otherwise only annotated tags are used.
 	 */
-	if (!prefixcmp(path, "refs/tags/")) {
+	if (!prefixcmp(path, PATH_REFS_TAGS)) {
 		if (object->type == OBJ_TAG)
 			prio = 2;
 		else
diff --git a/builtin-fetch--tool.c b/builtin-fetch--tool.c
index 1e43d79..cdb64cc 100644
--- a/builtin-fetch--tool.c
+++ b/builtin-fetch--tool.c
@@ -64,7 +64,7 @@ static int update_local_ref(const char *name,
 		char *msg;
 	just_store:
 		/* new ref */
-		if (!strncmp(name, "refs/tags/", 10))
+		if (!prefixcmp(name, PATH_REFS_TAGS))
 			msg = "storing tag";
 		else
 			msg = "storing head";
@@ -82,7 +82,7 @@ static int update_local_ref(const char *name,
 		return 0;
 	}
 
-	if (!strncmp(name, "refs/tags/", 10)) {
+	if (!prefixcmp(name, PATH_REFS_TAGS)) {
 		fprintf(stderr, "* %s: updating with %s\n", name, note);
 		show_new(type, sha1_new);
 		return update_ref_env("updating tag", name, sha1_new, NULL);
@@ -139,15 +139,15 @@ static int append_fetch_head(FILE *fp,
 		kind = "";
 		what = "";
 	}
-	else if (!strncmp(remote_name, "refs/heads/", 11)) {
+	else if (!prefixcmp(remote_name, PATH_REFS_HEADS)) {
 		kind = "branch";
 		what = remote_name + 11;
 	}
-	else if (!strncmp(remote_name, "refs/tags/", 10)) {
+	else if (!prefixcmp(remote_name, PATH_REFS_TAGS)) {
 		kind = "tag";
 		what = remote_name + 10;
 	}
-	else if (!strncmp(remote_name, "refs/remotes/", 13)) {
+	else if (!prefixcmp(remote_name, PATH_REFS_REMOTES)) {
 		kind = "remote branch";
 		what = remote_name + 13;
 	}
diff --git a/builtin-fmt-merge-msg.c b/builtin-fmt-merge-msg.c
index 8a3c962..98a1fab 100644
--- a/builtin-fmt-merge-msg.c
+++ b/builtin-fmt-merge-msg.c
@@ -4,6 +4,7 @@
 #include "diff.h"
 #include "revision.h"
 #include "tag.h"
+#include "refs.h"
 
 static const char *fmt_merge_msg_usage =
 	"git-fmt-merge-msg [--summary] [--no-summary] [--file <file>]";
@@ -277,8 +278,8 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 	current_branch = resolve_ref("HEAD", head_sha1, 1, NULL);
 	if (!current_branch)
 		die("No current branch");
-	if (!prefixcmp(current_branch, "refs/heads/"))
-		current_branch += 11;
+	if (!prefixcmp(current_branch, PATH_REFS_HEADS))
+		current_branch += STRLEN_PATH_REFS_HEADS;
 
 	while (fgets(line, sizeof(line), in)) {
 		i++;
diff --git a/builtin-fsck.c b/builtin-fsck.c
index 8d12287..83a2d0c 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -629,14 +629,14 @@ static int fsck_head_link(void)
 	if (!strcmp(head_points_at, "HEAD"))
 		/* detached HEAD */
 		null_is_error = 1;
-	else if (prefixcmp(head_points_at, "refs/heads/"))
+	else if (prefixcmp(head_points_at, PATH_REFS_HEADS))
 		return error("HEAD points to something strange (%s)",
 			     head_points_at);
 	if (is_null_sha1(sha1)) {
 		if (null_is_error)
 			return error("HEAD: detached HEAD points at nothing");
 		fprintf(stderr, "notice: HEAD points to an unborn branch (%s)\n",
-			head_points_at + 11);
+			head_points_at + STRLEN_PATH_REFS_HEADS);
 	}
 	return 0;
 }
diff --git a/builtin-init-db.c b/builtin-init-db.c
index 763fa55..1f3c0dd 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -5,6 +5,7 @@
  */
 #include "cache.h"
 #include "builtin.h"
+#include "refs.h"
 
 #ifndef DEFAULT_GIT_TEMPLATE_DIR
 #define DEFAULT_GIT_TEMPLATE_DIR "/usr/share/git-core/templates"
@@ -194,11 +195,11 @@ static int create_default_files(const char *git_dir, const char *template_path)
 	/*
 	 * Create .git/refs/{heads,tags}
 	 */
-	strcpy(path + len, "refs");
+	strcpy(path + len, PATH_REFS);
 	safe_create_dir(path, 1);
-	strcpy(path + len, "refs/heads");
+	strcpy(path + len, PATH_REFS_HEADS);
 	safe_create_dir(path, 1);
-	strcpy(path + len, "refs/tags");
+	strcpy(path + len, PATH_REFS_TAGS);
 	safe_create_dir(path, 1);
 
 	/* First copy the templates -- we might have the default
@@ -217,11 +218,11 @@ static int create_default_files(const char *git_dir, const char *template_path)
 	if (shared_repository) {
 		path[len] = 0;
 		adjust_shared_perm(path);
-		strcpy(path + len, "refs");
+		strcpy(path + len, PATH_REFS);
 		adjust_shared_perm(path);
-		strcpy(path + len, "refs/heads");
+		strcpy(path + len, PATH_REFS_HEADS);
 		adjust_shared_perm(path);
-		strcpy(path + len, "refs/tags");
+		strcpy(path + len, PATH_REFS_TAGS);
 		adjust_shared_perm(path);
 	}
 
@@ -232,7 +233,7 @@ static int create_default_files(const char *git_dir, const char *template_path)
 	strcpy(path + len, "HEAD");
 	reinit = !read_ref("HEAD", sha1);
 	if (!reinit) {
-		if (create_symref("HEAD", "refs/heads/master", NULL) < 0)
+		if (create_symref("HEAD", PATH_REFS_HEADS "master", NULL) < 0)
 			exit(1);
 	}
 
diff --git a/builtin-name-rev.c b/builtin-name-rev.c
index 03083e9..56c13d0 100644
--- a/builtin-name-rev.c
+++ b/builtin-name-rev.c
@@ -96,7 +96,7 @@ static int name_ref(const char *path, const unsigned char *sha1, int flags, void
 	struct name_ref_data *data = cb_data;
 	int deref = 0;
 
-	if (data->tags_only && prefixcmp(path, "refs/tags/"))
+	if (data->tags_only && prefixcmp(path, PATH_REFS_TAGS))
 		return 0;
 
 	if (data->ref_filter && fnmatch(data->ref_filter, path, 0))
@@ -112,14 +112,14 @@ static int name_ref(const char *path, const unsigned char *sha1, int flags, void
 	if (o && o->type == OBJ_COMMIT) {
 		struct commit *commit = (struct commit *)o;
 
-		if (!prefixcmp(path, "refs/heads/"))
-			path = path + 11;
+		if (!prefixcmp(path, PATH_REFS_HEADS))
+			path = path + STRLEN_PATH_REFS_HEADS;
 		else if (data->tags_only
 		    && data->name_only
-		    && !prefixcmp(path, "refs/tags/"))
-			path = path + 10;
-		else if (!prefixcmp(path, "refs/"))
-			path = path + 5;
+		    && !prefixcmp(path, PATH_REFS_TAGS))
+			path = path + STRLEN_PATH_REFS_TAGS;
+		else if (!prefixcmp(path, PATH_REFS))
+			path = path + STRLEN_PATH_REFS;
 
 		name_rev(commit, xstrdup(path), 0, 0, deref);
 	}
diff --git a/builtin-pack-refs.c b/builtin-pack-refs.c
index 09df4e1..23b4c4e 100644
--- a/builtin-pack-refs.c
+++ b/builtin-pack-refs.c
@@ -39,7 +39,7 @@ static int handle_one_ref(const char *path, const unsigned char *sha1,
 	/* Do not pack the symbolic refs */
 	if ((flags & REF_ISSYMREF))
 		return 0;
-	is_tag_ref = !prefixcmp(path, "refs/tags/");
+	is_tag_ref = !prefixcmp(path, PATH_REFS_TAGS);
 
 	/* ALWAYS pack refs that were already packed or are tags */
 	if (!(cb->flags & PACK_REFS_ALL) && !is_tag_ref && !(flags & REF_ISPACKED))
diff --git a/builtin-push.c b/builtin-push.c
index 88c5024..2fdae7a 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -33,9 +33,9 @@ static void set_refspecs(const char **refs, int nr)
 			int len;
 			if (nr <= ++i)
 				die("tag shorthand without <tag>");
-			len = strlen(refs[i]) + 11;
+			len = strlen(refs[i]) + STRLEN_PATH_REFS_TAGS + 1;
 			tag = xmalloc(len);
-			strcpy(tag, "refs/tags/");
+			strcpy(tag, PATH_REFS_TAGS);
 			strcat(tag, refs[i]);
 			ref = tag;
 		}
@@ -148,7 +148,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 		if (!strcmp(arg, "--tags")) {
-			add_refspec("refs/tags/*");
+			add_refspec(PATH_REFS_TAGS "*");
 			continue;
 		}
 		if (!strcmp(arg, "--force") || !strcmp(arg, "-f")) {
diff --git a/builtin-show-branch.c b/builtin-show-branch.c
index 07a0c23..c01acdb 100644
--- a/builtin-show-branch.c
+++ b/builtin-show-branch.c
@@ -379,36 +379,36 @@ static int append_ref(const char *refname, const unsigned char *sha1,
 static int append_head_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
 {
 	unsigned char tmp[20];
-	int ofs = 11;
-	if (prefixcmp(refname, "refs/heads/"))
+	int ofs = STRLEN_PATH_REFS_HEADS;
+	if (prefixcmp(refname, PATH_REFS_HEADS))
 		return 0;
 	/* If both heads/foo and tags/foo exists, get_sha1 would
 	 * get confused.
 	 */
 	if (get_sha1(refname + ofs, tmp) || hashcmp(tmp, sha1))
-		ofs = 5;
+		ofs = STRLEN_PATH_REFS;
 	return append_ref(refname + ofs, sha1, 0);
 }
 
 static int append_remote_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
 {
 	unsigned char tmp[20];
-	int ofs = 13;
-	if (prefixcmp(refname, "refs/remotes/"))
+	int ofs = STRLEN_PATH_REFS_REMOTES;
+	if (prefixcmp(refname, PATH_REFS_REMOTES))
 		return 0;
 	/* If both heads/foo and tags/foo exists, get_sha1 would
 	 * get confused.
 	 */
 	if (get_sha1(refname + ofs, tmp) || hashcmp(tmp, sha1))
-		ofs = 5;
+		ofs = STRLEN_PATH_REFS;
 	return append_ref(refname + ofs, sha1, 0);
 }
 
 static int append_tag_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
 {
-	if (prefixcmp(refname, "refs/tags/"))
+	if (prefixcmp(refname, PATH_REFS_TAGS))
 		return 0;
-	return append_ref(refname + 5, sha1, 0);
+	return append_ref(refname + STRLEN_PATH_REFS, sha1, 0);
 }
 
 static const char *match_ref_pattern = NULL;
@@ -437,9 +437,9 @@ static int append_matching_ref(const char *refname, const unsigned char *sha1, i
 		return 0;
 	if (fnmatch(match_ref_pattern, tail, 0))
 		return 0;
-	if (!prefixcmp(refname, "refs/heads/"))
+	if (!prefixcmp(refname, PATH_REFS_HEADS))
 		return append_head_ref(refname, sha1, flag, cb_data);
-	if (!prefixcmp(refname, "refs/tags/"))
+	if (!prefixcmp(refname, PATH_REFS_TAGS))
 		return append_tag_ref(refname, sha1, flag, cb_data);
 	return append_ref(refname, sha1, 0);
 }
@@ -464,12 +464,12 @@ static int rev_is_head(char *head, int headlen, char *name,
 	if ((!head[0]) ||
 	    (head_sha1 && sha1 && hashcmp(head_sha1, sha1)))
 		return 0;
-	if (!prefixcmp(head, "refs/heads/"))
-		head += 11;
-	if (!prefixcmp(name, "refs/heads/"))
-		name += 11;
-	else if (!prefixcmp(name, "heads/"))
-		name += 6;
+	if (!prefixcmp(head, PATH_REFS_HEADS))
+		head += STRLEN_PATH_REFS_HEADS;
+	if (!prefixcmp(name, PATH_REFS_HEADS))
+		name += STRLEN_PATH_REFS_HEADS;
+	else if (!prefixcmp(name, PATH_HEADS))
+		name += STRLEN_PATH_HEADS;
 	return !strcmp(head, name);
 }
 
@@ -780,7 +780,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 				has_head++;
 		}
 		if (!has_head) {
-			int pfxlen = strlen("refs/heads/");
+			int pfxlen = STRLEN_PATH_REFS_HEADS;
 			append_one_rev(head + pfxlen);
 		}
 	}
diff --git a/builtin-show-ref.c b/builtin-show-ref.c
index 65051d1..d463d80 100644
--- a/builtin-show-ref.c
+++ b/builtin-show-ref.c
@@ -29,8 +29,8 @@ static int show_ref(const char *refname, const unsigned char *sha1, int flag, vo
 	if (tags_only || heads_only) {
 		int match;
 
-		match = heads_only && !prefixcmp(refname, "refs/heads/");
-		match |= tags_only && !prefixcmp(refname, "refs/tags/");
+		match = heads_only && !prefixcmp(refname, PATH_REFS_HEADS);
+		match |= tags_only && !prefixcmp(refname, PATH_REFS_TAGS);
 		if (!match)
 			return 0;
 	}
@@ -227,7 +227,7 @@ int cmd_show_ref(int argc, const char **argv, const char *prefix)
 		while (*pattern) {
 			unsigned char sha1[20];
 
-			if (!prefixcmp(*pattern, "refs/") &&
+			if (!prefixcmp(*pattern, PATH_REFS) &&
 			    resolve_ref(*pattern, sha1, 1, NULL)) {
 				if (!quiet)
 					show_one(*pattern, sha1);
diff --git a/builtin-tag.c b/builtin-tag.c
index 66e5a58..7cf7e02 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -139,7 +139,7 @@ static int for_each_tag_name(const char **argv, each_tag_name_fn fn)
 	unsigned char sha1[20];
 
 	for (p = argv; *p; p++) {
-		if (snprintf(ref, sizeof(ref), "refs/tags/%s", *p)
+		if (snprintf(ref, sizeof(ref), PATH_REFS_TAGS "%s", *p)
 					>= sizeof(ref)) {
 			error("tag name too long: %.*s...", 50, *p);
 			had_error = 1;
@@ -408,7 +408,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	if (get_sha1(object_ref, object))
 		die("Failed to resolve '%s' as a valid ref.", object_ref);
 
-	if (snprintf(ref, sizeof(ref), "refs/tags/%s", tag) > sizeof(ref) - 1)
+	if (snprintf(ref, sizeof(ref), PATH_REFS_TAGS "%s", tag) > sizeof(ref) - 1)
 		die("tag name too long: %.*s...", 50, tag);
 	if (check_ref_format(ref))
 		die("'%s' is not a valid tag name.", tag);
diff --git a/connect.c b/connect.c
index 06d279e..94c2d60 100644
--- a/connect.c
+++ b/connect.c
@@ -13,23 +13,23 @@ static int check_ref(const char *name, int len, unsigned int flags)
 	if (!flags)
 		return 1;
 
-	if (len < 5 || memcmp(name, "refs/", 5))
+	if (len < STRLEN_PATH_REFS || memcmp(name, PATH_REFS, STRLEN_PATH_REFS))
 		return 0;
 
 	/* Skip the "refs/" part */
-	name += 5;
-	len -= 5;
+	name += STRLEN_PATH_REFS;
+	len -= STRLEN_PATH_REFS;
 
 	/* REF_NORMAL means that we don't want the magic fake tag refs */
 	if ((flags & REF_NORMAL) && check_ref_format(name) < 0)
 		return 0;
 
 	/* REF_HEADS means that we want regular branch heads */
-	if ((flags & REF_HEADS) && !memcmp(name, "heads/", 6))
+	if ((flags & REF_HEADS) && !memcmp(name, PATH_HEADS, STRLEN_PATH_HEADS))
 		return 1;
 
 	/* REF_TAGS means that we want tags */
-	if ((flags & REF_TAGS) && !memcmp(name, "tags/", 5))
+	if ((flags & REF_TAGS) && !memcmp(name, PATH_TAGS, STRLEN_PATH_TAGS))
 		return 1;
 
 	/* All type bits clear means that we are ok with anything */
diff --git a/fetch-pack.c b/fetch-pack.c
index 9c81305..c3b7ef6 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -344,11 +344,11 @@ static void filter_refs(struct ref **refs, int nr_match, char **match)
 
 	for (ref = *refs; ref; ref = next) {
 		next = ref->next;
-		if (!memcmp(ref->name, "refs/", 5) &&
-		    check_ref_format(ref->name + 5))
+		if (!memcmp(ref->name, PATH_REFS, STRLEN_PATH_REFS) &&
+		    check_ref_format(ref->name + STRLEN_PATH_REFS))
 			; /* trash */
 		else if (fetch_all &&
-			 (!depth || prefixcmp(ref->name, "refs/tags/") )) {
+			 (!depth || prefixcmp(ref->name, PATH_REFS_TAGS) )) {
 			*newtail = ref;
 			ref->next = NULL;
 			newtail = &ref->next;
diff --git a/http-fetch.c b/http-fetch.c
index 202fae0..2680fbd 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -3,6 +3,7 @@
 #include "pack.h"
 #include "fetch.h"
 #include "http.h"
+#include "refs.h"
 
 #define PREV_BUF_SIZE 4096
 #define RANGE_HEADER_SIZE 30
@@ -157,12 +158,12 @@ static void start_object_request(struct object_request *obj_req)
 
 	SHA1_Init(&obj_req->c);
 
-	url = xmalloc(strlen(obj_req->repo->base) + 51);
-	obj_req->url = xmalloc(strlen(obj_req->repo->base) + 51);
+	url = xmalloc(strlen(obj_req->repo->base) + STRLEN_PATH_OBJECTS + 43);
+	obj_req->url = xmalloc(strlen(obj_req->repo->base) + STRLEN_PATH_OBJECTS + 43);
 	strcpy(url, obj_req->repo->base);
 	posn = url + strlen(obj_req->repo->base);
-	strcpy(posn, "/objects/");
-	posn += 9;
+	strcpy(posn, "/" PATH_OBJECTS);
+	posn += 1 + STRLEN_PATH_OBJECTS;
 	memcpy(posn, hex, 2);
 	posn += 2;
 	*(posn++) = '/';
@@ -398,8 +399,8 @@ static int fetch_index(struct alt_base *repo, unsigned char *sha1)
 	if (get_verbosely)
 		fprintf(stderr, "Getting index for pack %s\n", hex);
 
-	url = xmalloc(strlen(repo->base) + 64);
-	sprintf(url, "%s/objects/pack/pack-%s.idx", repo->base, hex);
+	url = xmalloc(strlen(repo->base) + STRLEN_PATH_OBJECTS + 56);
+	sprintf(url, "%s/" PATH_OBJECTS "pack/pack-%s.idx", repo->base, hex);
 
 	filename = sha1_pack_index_name(sha1);
 	snprintf(tmpfile, sizeof(tmpfile), "%s.temp", filename);
@@ -478,7 +479,7 @@ static void process_alternates_response(void *callback_data)
 
 			/* Try reusing the slot to get non-http alternates */
 			alt_req->http_specific = 0;
-			sprintf(alt_req->url, "%s/objects/info/alternates",
+			sprintf(alt_req->url, "%s/" PATH_OBJECTS "info/alternates",
 				base);
 			curl_easy_setopt(slot->curl, CURLOPT_URL,
 					 alt_req->url);
@@ -625,8 +626,8 @@ static void fetch_alternates(const char *base)
 	if (get_verbosely)
 		fprintf(stderr, "Getting alternates list for %s\n", base);
 
-	url = xmalloc(strlen(base) + 31);
-	sprintf(url, "%s/objects/info/http-alternates", base);
+	url = xmalloc(strlen(base) + STRLEN_PATH_OBJECTS + 23);
+	sprintf(url, "%s/" PATH_OBJECTS "info/http-alternates", base);
 
 	/* Use a callback to process the result, since another request
 	   may fail and need to have alternates loaded before continuing */
@@ -675,8 +676,8 @@ static int fetch_indices(struct alt_base *repo)
 	if (get_verbosely)
 		fprintf(stderr, "Getting pack list for %s\n", repo->base);
 
-	url = xmalloc(strlen(repo->base) + 21);
-	sprintf(url, "%s/objects/info/packs", repo->base);
+	url = xmalloc(strlen(repo->base) + STRLEN_PATH_OBJECTS + 13);
+	sprintf(url, "%s/" PATH_OBJECTS "info/packs", repo->base);
 
 	slot = get_active_slot();
 	slot->results = &results;
@@ -757,8 +758,8 @@ static int fetch_pack(struct alt_base *repo, unsigned char *sha1)
 			sha1_to_hex(sha1));
 	}
 
-	url = xmalloc(strlen(repo->base) + 65);
-	sprintf(url, "%s/objects/pack/pack-%s.pack",
+	url = xmalloc(strlen(repo->base) + STRLEN_PATH_OBJECTS + 57);
+	sprintf(url, "%s/" PATH_OBJECTS "pack/pack-%s.pack",
 		repo->base, sha1_to_hex(target->sha1));
 
 	filename = sha1_pack_name(target->sha1);
@@ -930,14 +931,14 @@ static char *quote_ref_url(const char *base, const char *ref)
 	int len, baselen, ch;
 
 	baselen = strlen(base);
-	len = baselen + 7; /* "/refs/" + NUL */
+	len = baselen + STRLEN_PATH_REFS + 2; /* "/" + "refs/" + NUL */
 	for (cp = ref; (ch = *cp) != 0; cp++, len++)
 		if (needs_quote(ch))
 			len += 2; /* extra two hex plus replacement % */
 	qref = xmalloc(len);
 	memcpy(qref, base, baselen);
-	memcpy(qref + baselen, "/refs/", 6);
-	for (cp = ref, dp = qref + baselen + 6; (ch = *cp) != 0; cp++) {
+	memcpy(qref + baselen, "/" PATH_REFS, STRLEN_PATH_REFS + 1);
+	for (cp = ref, dp = qref + baselen + STRLEN_PATH_REFS + 1; (ch = *cp) != 0; cp++) {
 		if (needs_quote(ch)) {
 			*dp++ = '%';
 			*dp++ = hex((ch >> 4) & 0xF);
diff --git a/http-push.c b/http-push.c
index 276e1eb..e70c4ea 100644
--- a/http-push.c
+++ b/http-push.c
@@ -272,12 +272,12 @@ static void start_fetch_loose(struct transfer_request *request)
 
 	SHA1_Init(&request->c);
 
-	url = xmalloc(strlen(remote->url) + 50);
-	request->url = xmalloc(strlen(remote->url) + 50);
+	url = xmalloc(strlen(remote->url) + 42 + STRLEN_PATH_OBJECTS);
+	request->url = xmalloc(strlen(remote->url) + 42 + STRLEN_PATH_OBJECTS);
 	strcpy(url, remote->url);
 	posn = url + strlen(remote->url);
-	strcpy(posn, "objects/");
-	posn += 8;
+	strcpy(posn, PATH_OBJECTS);
+	posn += STRLEN_PATH_OBJECTS;
 	memcpy(posn, hex, 2);
 	posn += 2;
 	*(posn++) = '/';
@@ -357,11 +357,11 @@ static void start_mkcol(struct transfer_request *request)
 	struct active_request_slot *slot;
 	char *posn;
 
-	request->url = xmalloc(strlen(remote->url) + 13);
+	request->url = xmalloc(strlen(remote->url) + STRLEN_PATH_OBJECTS + 5);
 	strcpy(request->url, remote->url);
 	posn = request->url + strlen(remote->url);
-	strcpy(posn, "objects/");
-	posn += 8;
+	strcpy(posn, PATH_OBJECTS);
+	posn += STRLEN_PATH_OBJECTS;
 	memcpy(posn, hex, 2);
 	posn += 2;
 	strcpy(posn, "/");
@@ -415,8 +415,8 @@ static void start_fetch_packed(struct transfer_request *request)
 	snprintf(request->tmpfile, sizeof(request->tmpfile),
 		 "%s.temp", filename);
 
-	url = xmalloc(strlen(remote->url) + 64);
-	sprintf(url, "%sobjects/pack/pack-%s.pack",
+	url = xmalloc(strlen(remote->url) + STRLEN_PATH_OBJECTS + 56);
+	sprintf(url, "%s" PATH_OBJECTS "pack/pack-%s.pack",
 		remote->url, sha1_to_hex(target->sha1));
 
 	/* Make sure there isn't another open request for this pack */
@@ -519,11 +519,11 @@ static void start_put(struct transfer_request *request)
 	request->buffer.posn = 0;
 
 	request->url = xmalloc(strlen(remote->url) +
-			       strlen(request->lock->token) + 51);
+			       strlen(request->lock->token) + STRLEN_PATH_OBJECTS + 43);
 	strcpy(request->url, remote->url);
 	posn = request->url + strlen(remote->url);
-	strcpy(posn, "objects/");
-	posn += 8;
+	strcpy(posn, PATH_OBJECTS);
+	posn += STRLEN_PATH_OBJECTS;
 	memcpy(posn, hex, 2);
 	posn += 2;
 	*(posn++) = '/';
@@ -922,8 +922,8 @@ static int fetch_index(unsigned char *sha1)
 	struct slot_results results;
 
 	/* Don't use the index if the pack isn't there */
-	url = xmalloc(strlen(remote->url) + 64);
-	sprintf(url, "%sobjects/pack/pack-%s.pack", remote->url, hex);
+	url = xmalloc(strlen(remote->url) + STRLEN_PATH_OBJECTS + 56);
+	sprintf(url, "%s" PATH_OBJECTS "pack/pack-%s.pack", remote->url, hex);
 	slot = get_active_slot();
 	slot->results = &results;
 	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
@@ -945,7 +945,7 @@ static int fetch_index(unsigned char *sha1)
 	if (push_verbosely)
 		fprintf(stderr, "Getting index for pack %s\n", hex);
 
-	sprintf(url, "%sobjects/pack/pack-%s.idx", remote->url, hex);
+	sprintf(url, "%s" PATH_OBJECTS "pack/pack-%s.idx", remote->url, hex);
 
 	filename = sha1_pack_index_name(sha1);
 	snprintf(tmpfile, sizeof(tmpfile), "%s.temp", filename);
@@ -1029,8 +1029,8 @@ static int fetch_indices(void)
 	if (push_verbosely)
 		fprintf(stderr, "Getting pack list\n");
 
-	url = xmalloc(strlen(remote->url) + 20);
-	sprintf(url, "%sobjects/info/packs", remote->url);
+	url = xmalloc(strlen(remote->url) + STRLEN_PATH_OBJECTS + 12);
+	sprintf(url, "%s" PATH_OBJECTS "info/packs", remote->url);
 
 	slot = get_active_slot();
 	slot->results = &results;
@@ -1612,7 +1612,7 @@ static void remote_ls(const char *path, int flags,
 
 static void get_remote_object_list(unsigned char parent)
 {
-	char path[] = "objects/XX/";
+	char path[] = PATH_OBJECTS "XX/";
 	static const char hex[] = "0123456789abcdef";
 	unsigned int val = parent;
 
@@ -1922,7 +1922,7 @@ static void get_local_heads(void)
 static void get_dav_remote_heads(void)
 {
 	remote_tail = &remote_refs;
-	remote_ls("refs/", (PROCESS_FILES | PROCESS_DIRS | RECURSIVE), process_ls_ref, NULL);
+	remote_ls(PATH_REFS, (PROCESS_FILES | PROCESS_DIRS | RECURSIVE), process_ls_ref, NULL);
 }
 
 static int is_zero_sha1(const unsigned char *sha1)
@@ -2066,7 +2066,7 @@ static void update_remote_info_refs(struct remote_lock *lock)
 	buffer.buffer = xcalloc(1, 4096);
 	buffer.size = 4096;
 	buffer.posn = 0;
-	remote_ls("refs/", (PROCESS_FILES | RECURSIVE),
+	remote_ls(PATH_REFS, (PROCESS_FILES | RECURSIVE),
 		  add_remote_info_ref, &buffer);
 	if (!aborted) {
 		if_header = xmalloc(strlen(lock->token) + 25);
@@ -2370,7 +2370,7 @@ int main(int argc, char **argv)
 	/* Check whether the remote has server info files */
 	remote->can_update_info_refs = 0;
 	remote->has_info_refs = remote_exists("info/refs");
-	remote->has_info_packs = remote_exists("objects/info/packs");
+	remote->has_info_packs = remote_exists(PATH_OBJECTS "info/packs");
 	if (remote->has_info_refs) {
 		info_ref_lock = lock_remote("info/refs", LOCK_TIME);
 		if (info_ref_lock)
diff --git a/local-fetch.c b/local-fetch.c
index bf7ec6c..67dc065 100644
--- a/local-fetch.c
+++ b/local-fetch.c
@@ -4,6 +4,7 @@
 #include "cache.h"
 #include "commit.h"
 #include "fetch.h"
+#include "refs.h"
 
 static int use_link;
 static int use_symlink;
@@ -23,7 +24,7 @@ static void setup_index(unsigned char *sha1)
 	struct packed_git *new_pack;
 	char filename[PATH_MAX];
 	strcpy(filename, path);
-	strcat(filename, "/objects/pack/pack-");
+	strcat(filename, "/" PATH_OBJECTS "pack/pack-");
 	strcat(filename, sha1_to_hex(sha1));
 	strcat(filename, ".idx");
 	new_pack = parse_pack_index_file(sha1, filename);
@@ -37,7 +38,7 @@ static int setup_indices(void)
 	struct dirent *de;
 	char filename[PATH_MAX];
 	unsigned char sha1[20];
-	sprintf(filename, "%s/objects/pack/", path);
+	sprintf(filename, "%s/" PATH_OBJECTS "pack/", path);
 	dir = opendir(filename);
 	if (!dir)
 		return -1;
@@ -122,11 +123,11 @@ static int fetch_pack(const unsigned char *sha1)
 		fprintf(stderr, " which contains %s\n",
 			sha1_to_hex(sha1));
 	}
-	sprintf(filename, "%s/objects/pack/pack-%s.pack",
+	sprintf(filename, "%s/" PATH_OBJECTS "pack/pack-%s.pack",
 		path, sha1_to_hex(target->sha1));
 	copy_file(filename, sha1_pack_name(target->sha1),
 		  sha1_to_hex(target->sha1), 1);
-	sprintf(filename, "%s/objects/pack/pack-%s.idx",
+	sprintf(filename, "%s/" PATH_OBJECTS "pack/pack-%s.idx",
 		path, sha1_to_hex(target->sha1));
 	copy_file(filename, sha1_pack_index_name(target->sha1),
 		  sha1_to_hex(target->sha1), 1);
@@ -143,7 +144,7 @@ static int fetch_file(const unsigned char *sha1)
 
 	if (object_name_start < 0) {
 		strcpy(filename, path); /* e.g. git.git */
-		strcat(filename, "/objects/");
+		strcat(filename, "/" PATH_OBJECTS);
 		object_name_start = strlen(filename);
 	}
 	filename[object_name_start+0] = hex[0];
@@ -169,7 +170,7 @@ int fetch_ref(char *ref, unsigned char *sha1)
 	int ifd;
 
 	if (ref_name_start < 0) {
-		sprintf(filename, "%s/refs/", path);
+		sprintf(filename, "%s/" PATH_REFS, path);
 		ref_name_start = strlen(filename);
 	}
 	strcpy(filename + ref_name_start, ref);
diff --git a/path.c b/path.c
index 4260952..d330bbc 100644
--- a/path.c
+++ b/path.c
@@ -11,6 +11,7 @@
  * which is what it's designed for.
  */
 #include "cache.h"
+#include "refs.h"
 
 static char bad_path[] = "/bad-path/";
 
@@ -99,7 +100,7 @@ int validate_headref(const char *path)
 	/* Make sure it is a "refs/.." symlink */
 	if (S_ISLNK(st.st_mode)) {
 		len = readlink(path, buffer, sizeof(buffer)-1);
-		if (len >= 5 && !memcmp("refs/", buffer, 5))
+		if (len >= STRLEN_PATH_REFS && !memcmp(PATH_REFS, buffer, STRLEN_PATH_REFS))
 			return 0;
 		return -1;
 	}
@@ -123,7 +124,7 @@ int validate_headref(const char *path)
 		len -= 4;
 		while (len && isspace(*buf))
 			buf++, len--;
-		if (len >= 5 && !memcmp("refs/", buf, 5))
+		if (len >= STRLEN_PATH_REFS && !memcmp(PATH_REFS, buf, STRLEN_PATH_REFS))
 			return 0;
 	}
 
diff --git a/receive-pack.c b/receive-pack.c
index d3c422b..114ea38 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -165,7 +165,7 @@ static const char *update(struct command *cmd)
 	unsigned char *new_sha1 = cmd->new_sha1;
 	struct ref_lock *lock;
 
-	if (!prefixcmp(name, "refs/") && check_ref_format(name + 5)) {
+	if (!prefixcmp(name, PATH_REFS) && check_ref_format(name + STRLEN_PATH_REFS)) {
 		error("refusing to create funny ref '%s' locally", name);
 		return "funny refname";
 	}
@@ -177,7 +177,7 @@ static const char *update(struct command *cmd)
 	}
 	if (deny_non_fast_forwards && !is_null_sha1(new_sha1) &&
 	    !is_null_sha1(old_sha1) &&
-	    !prefixcmp(name, "refs/heads/")) {
+	    !prefixcmp(name, PATH_REFS_HEADS)) {
 		struct commit *old_commit, *new_commit;
 		struct commit_list *bases, *ent;
 
diff --git a/reflog-walk.c b/reflog-walk.c
index ee1456b..98cf8ef 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -55,11 +55,11 @@ static struct complete_reflogs *read_complete_reflog(const char *ref)
 	}
 	if (reflogs->nr == 0) {
 		int len = strlen(ref);
-		char *refname = xmalloc(len + 12);
-		sprintf(refname, "refs/%s", ref);
+		char *refname = xmalloc(len + STRLEN_PATH_REFS_HEADS + 1);
+		sprintf(refname, PATH_REFS "%s", ref);
 		for_each_reflog_ent(refname, read_one_reflog, reflogs);
 		if (reflogs->nr == 0) {
-			sprintf(refname, "refs/heads/%s", ref);
+			sprintf(refname, PATH_REFS_HEADS "%s", ref);
 			for_each_reflog_ent(refname, read_one_reflog, reflogs);
 		}
 		free(refname);
diff --git a/refs.c b/refs.c
index 07e260c..5891609 100644
--- a/refs.c
+++ b/refs.c
@@ -409,7 +409,7 @@ const char *resolve_ref(const char *ref, unsigned char *sha1, int reading, int *
 		/* Follow "normalized" - ie "refs/.." symlinks by hand */
 		if (S_ISLNK(st.st_mode)) {
 			len = readlink(path, buffer, sizeof(buffer)-1);
-			if (len >= 5 && !memcmp("refs/", buffer, 5)) {
+			if (len >= STRLEN_PATH_REFS && !memcmp(PATH_REFS, buffer, STRLEN_PATH_REFS)) {
 				buffer[len] = 0;
 				strcpy(ref_buffer, buffer);
 				ref = ref_buffer;
@@ -561,22 +561,22 @@ int head_ref(each_ref_fn fn, void *cb_data)
 
 int for_each_ref(each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref("refs/", fn, 0, cb_data);
+	return do_for_each_ref(PATH_REFS, fn, 0, cb_data);
 }
 
 int for_each_tag_ref(each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref("refs/tags/", fn, 10, cb_data);
+	return do_for_each_ref(PATH_REFS_TAGS, fn, STRLEN_PATH_REFS_TAGS, cb_data);
 }
 
 int for_each_branch_ref(each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref("refs/heads/", fn, 11, cb_data);
+	return do_for_each_ref(PATH_REFS_HEADS, fn, STRLEN_PATH_REFS_HEADS, cb_data);
 }
 
 int for_each_remote_ref(each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref("refs/remotes/", fn, 13, cb_data);
+	return do_for_each_ref(PATH_REFS_REMOTES, fn, STRLEN_PATH_REFS_REMOTES, cb_data);
 }
 
 /* NEEDSWORK: This is only used by ssh-upload and it should go; the
@@ -588,7 +588,7 @@ int get_ref_sha1(const char *ref, unsigned char *sha1)
 {
 	if (check_ref_format(ref))
 		return -1;
-	return read_ref(mkpath("refs/%s", ref), sha1);
+	return read_ref(mkpath(PATH_REFS "%s", ref), sha1);
 }
 
 /*
@@ -824,7 +824,7 @@ struct ref_lock *lock_ref_sha1(const char *ref, const unsigned char *old_sha1)
 	char refpath[PATH_MAX];
 	if (check_ref_format(ref))
 		return NULL;
-	strcpy(refpath, mkpath("refs/%s", ref));
+	strcpy(refpath, mkpath(PATH_REFS "%s", ref));
 	return lock_ref_sha1_basic(refpath, old_sha1, 0, NULL);
 }
 
@@ -1078,8 +1078,8 @@ static int log_ref_write(const char *ref_name, const unsigned char *old_sha1,
 	log_file = git_path("logs/%s", ref_name);
 
 	if (log_all_ref_updates &&
-	    (!prefixcmp(ref_name, "refs/heads/") ||
-	     !prefixcmp(ref_name, "refs/remotes/") ||
+	    (!prefixcmp(ref_name,  PATH_REFS_HEADS) ||
+	     !prefixcmp(ref_name, PATH_REFS_REMOTES) ||
 	     !strcmp(ref_name, "HEAD"))) {
 		if (safe_create_leading_directories(log_file) < 0)
 			return error("unable to create directory for %s",
diff --git a/refs.h b/refs.h
index 6eb98a4..1025d04 100644
--- a/refs.h
+++ b/refs.h
@@ -13,6 +13,23 @@ struct ref_lock {
 #define REF_ISSYMREF 01
 #define REF_ISPACKED 02
 
+#define PATH_OBJECTS             "objects/"
+#define STRLEN_PATH_OBJECTS      8
+#define PATH_REFS                "refs/"
+#define STRLEN_PATH_REFS         5
+#define PATH_HEADS               "heads/"
+#define STRLEN_PATH_HEADS        6
+#define PATH_TAGS                "tags/"
+#define STRLEN_PATH_TAGS         5
+#define PATH_REMOTES             "remotes/"
+#define STRLEN_PATH_REMOTES      8
+#define PATH_REFS_HEADS          PATH_REFS PATH_HEADS
+#define STRLEN_PATH_REFS_HEADS   (STRLEN_PATH_REFS+STRLEN_PATH_HEADS)
+#define PATH_REFS_TAGS           PATH_REFS PATH_TAGS
+#define STRLEN_PATH_REFS_TAGS    (STRLEN_PATH_REFS+STRLEN_PATH_TAGS)
+#define PATH_REFS_REMOTES        PATH_REFS PATH_REMOTES
+#define STRLEN_PATH_REFS_REMOTES (STRLEN_PATH_REFS+STRLEN_PATH_REMOTES)
+
 /*
  * Calls the specified function for each ref file until it returns nonzero,
  * and returns the value
diff --git a/remote.c b/remote.c
index bb774d0..b8922c7 100644
--- a/remote.c
+++ b/remote.c
@@ -211,8 +211,8 @@ static void read_config(void)
 	current_branch = NULL;
 	head_ref = resolve_ref("HEAD", sha1, 0, &flag);
 	if (head_ref && (flag & REF_ISSYMREF) &&
-	    !prefixcmp(head_ref, "refs/heads/")) {
-		current_branch = head_ref + strlen("refs/heads/");
+	    !prefixcmp(head_ref, PATH_REFS_HEADS)) {
+		current_branch = head_ref + STRLEN_PATH_REFS_HEADS;
 		current_branch_len = strlen(current_branch);
 	}
 	git_config(handle_config);
@@ -398,9 +398,9 @@ static int count_refspec_match(const char *pattern,
 		 * at the remote site.
 		 */
 		if (namelen != patlen &&
-		    patlen != namelen - 5 &&
-		    prefixcmp(name, "refs/heads/") &&
-		    prefixcmp(name, "refs/tags/")) {
+		    patlen != namelen - STRLEN_PATH_REFS &&
+		    prefixcmp(name, PATH_REFS_HEADS) &&
+		    prefixcmp(name, PATH_REFS_TAGS)) {
 			/* We want to catch the case where only weak
 			 * matches are found and there are multiple
 			 * matches, and where more than one strong
@@ -511,7 +511,7 @@ static int match_explicit(struct ref *src, struct ref *dst,
 	case 1:
 		break;
 	case 0:
-		if (!memcmp(dst_value, "refs/", 5))
+		if (!prefixcmp(dst_value, PATH_REFS))
 			matched_dst = make_linked_ref(dst_value, dst_tail);
 		else
 			error("dst refspec %s does not match any "
@@ -594,7 +594,7 @@ int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
 			if (!pat)
 				continue;
 		}
-		else if (prefixcmp(src->name, "refs/heads/"))
+		else if (prefixcmp(src->name, PATH_REFS_HEADS))
 			/*
 			 * "matching refs"; traditionally we pushed everything
 			 * including refs outside refs/heads/ hierarchy, but
diff --git a/setup.c b/setup.c
index 06004f1..c8912d2 100644
--- a/setup.c
+++ b/setup.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "dir.h"
+#include "refs.h"
 
 static int inside_git_dir = -1;
 static int inside_work_tree = -1;
@@ -158,12 +159,12 @@ static int is_git_directory(const char *suspect)
 			return 0;
 	}
 	else {
-		strcpy(path + len, "/objects");
+		strcpy(path + len, "/" PATH_OBJECTS);
 		if (access(path, X_OK))
 			return 0;
 	}
 
-	strcpy(path + len, "/refs");
+	strcpy(path + len, "/" PATH_REFS);
 	if (access(path, X_OK))
 		return 0;
 
diff --git a/sha1_name.c b/sha1_name.c
index 2d727d5..649e438 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -241,11 +241,11 @@ static int ambiguous_path(const char *path, int len)
 
 static const char *ref_fmt[] = {
 	"%.*s",
-	"refs/%.*s",
-	"refs/tags/%.*s",
-	"refs/heads/%.*s",
-	"refs/remotes/%.*s",
-	"refs/remotes/%.*s/HEAD",
+	PATH_REFS "%.*s",
+	PATH_REFS_TAGS "%.*s",
+	PATH_REFS_HEADS "%.*s",
+	PATH_REFS_REMOTES "%.*s",
+	PATH_REFS_REMOTES "%.*s/HEAD",
 	NULL
 };
 
diff --git a/wt-status.c b/wt-status.c
index 10ce6ee..93dee72 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -7,6 +7,7 @@
 #include "diff.h"
 #include "revision.h"
 #include "diffcore.h"
+#include "refs.h"
 
 int wt_status_use_color = 0;
 static char wt_status_colors[][COLOR_MAXLEN] = {
@@ -311,8 +312,8 @@ void wt_status_print(struct wt_status *s)
 	if (s->branch) {
 		const char *on_what = "On branch ";
 		const char *branch_name = s->branch;
-		if (!prefixcmp(branch_name, "refs/heads/"))
-			branch_name += 11;
+		if (!prefixcmp(branch_name, PATH_REFS_HEADS))
+			branch_name += STRLEN_PATH_REFS_HEADS;
 		else if (!strcmp(branch_name, "HEAD")) {
 			branch_name = "";
 			on_what = "Not currently on any branch.";
-- 
1.5.3.rc5.11.g312e
