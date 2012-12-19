From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/3] Convert all fnmatch() calls to wildmatch()
Date: Wed, 19 Dec 2012 20:08:08 +0700
Message-ID: <1355922488-20976-4-git-send-email-pclouds@gmail.com>
References: <1355922488-20976-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 19 14:13:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlJT7-0005cK-AE
	for gcvg-git-2@plane.gmane.org; Wed, 19 Dec 2012 14:13:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753163Ab2LSNNg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Dec 2012 08:13:36 -0500
Received: from mail-da0-f41.google.com ([209.85.210.41]:49793 "EHLO
	mail-da0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752327Ab2LSNNe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2012 08:13:34 -0500
X-Greylist: delayed 362 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 Dec 2012 08:13:34 EST
Received: by mail-da0-f41.google.com with SMTP id e20so926826dak.0
        for <git@vger.kernel.org>; Wed, 19 Dec 2012 05:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=6BsQBkbzWuE2N+JLk9tdlyfonxuzO4pI2IY/oknRM2k=;
        b=ZCrbLwoNTdGDs2WCW66labk+XOrc7gWSKOex+AFaDvjfWLH7CIXOHzTv25A1xoigr/
         1/eTKOjZn2Mh//P2ScfdeGgjbm4BnY1JWWyNURa2B0aUpicLZLA43wCkXQjQUCn29o2Z
         ejUGuSCoOw6MT0U0uYLjVdkRK9nZtLwHPM1Ld6QzCbB/J2j4b48tW+ZfKWp72QYsHDfv
         zZiyPSR55TusVIL1u5x8g4B0d7wyz11p/nCMeg5f7phUF7Lkb2O/8Ce6OSVJ6bbpmyZE
         AF5A4cRtCrsquOsg4ExJ4VLELxHPjvh182RBuQYKIu5RRrbFsS5qs/Qoutyxz0DvZDH0
         1q4g==
X-Received: by 10.66.52.79 with SMTP id r15mr17272452pao.46.1355922482211;
        Wed, 19 Dec 2012 05:08:02 -0800 (PST)
Received: from lanh ([115.74.42.11])
        by mx.google.com with ESMTPS id o6sm3411333paw.37.2012.12.19.05.07.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 19 Dec 2012 05:08:01 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 19 Dec 2012 20:08:42 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1355922488-20976-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211819>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/apply.c        | 3 ++-
 builtin/branch.c       | 3 ++-
 builtin/describe.c     | 3 ++-
 builtin/for-each-ref.c | 3 ++-
 builtin/ls-remote.c    | 3 ++-
 builtin/name-rev.c     | 3 ++-
 builtin/reflog.c       | 3 ++-
 builtin/replace.c      | 3 ++-
 builtin/show-branch.c  | 3 ++-
 builtin/tag.c          | 3 ++-
 diffcore-order.c       | 3 ++-
 dir.c                  | 4 ++--
 refs.c                 | 3 ++-
 tree-walk.c            | 5 +++--
 14 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index d2180b0..86ff51d 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -16,6 +16,7 @@
 #include "dir.h"
 #include "diff.h"
 #include "parse-options.h"
+#include "wildmatch.h"
=20
 /*
  *  --check turns on checking that the working tree matches the
@@ -3786,7 +3787,7 @@ static int use_patch(struct patch *p)
 	/* See if it matches any of exclude/include rule */
 	for (i =3D 0; i < limit_by_name.nr; i++) {
 		struct string_list_item *it =3D &limit_by_name.items[i];
-		if (!fnmatch(it->string, pathname, 0))
+		if (!wildmatch(it->string, pathname, 0))
 			return (it->util !=3D NULL);
 	}
=20
diff --git a/builtin/branch.c b/builtin/branch.c
index 0e060f2..81257c1 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -17,6 +17,7 @@
 #include "revision.h"
 #include "string-list.h"
 #include "column.h"
+#include "wildmatch.h"
=20
 static const char * const builtin_branch_usage[] =3D {
 	"git branch [options] [-r | -a] [--merged | --no-merged]",
@@ -286,7 +287,7 @@ static int match_patterns(const char **pattern, con=
st char *refname)
 	if (!*pattern)
 		return 1; /* no pattern always matches */
 	while (*pattern) {
-		if (!fnmatch(*pattern, refname, 0))
+		if (!wildmatch(*pattern, refname, 0))
 			return 1;
 		pattern++;
 	}
diff --git a/builtin/describe.c b/builtin/describe.c
index 9f63067..1f55802 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -7,6 +7,7 @@
 #include "parse-options.h"
 #include "diff.h"
 #include "hash.h"
+#include "wildmatch.h"
=20
 #define SEEN		(1u<<0)
 #define MAX_TAGS	(FLAG_BITS - 1)
@@ -161,7 +162,7 @@ static int get_name(const char *path, const unsigne=
d char *sha1, int flag, void
 		else
 			prio =3D 1;
=20
-		if (pattern && fnmatch(pattern, path + 10, 0))
+		if (pattern && wildmatch(pattern, path + 10, 0))
 			prio =3D 0;
 	}
 	else
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 0c5294e..85f87dd 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -9,6 +9,7 @@
 #include "quote.h"
 #include "parse-options.h"
 #include "remote.h"
+#include "wildmatch.h"
=20
 /* Quoting styles */
 #define QUOTE_NONE 0
@@ -794,7 +795,7 @@ static int grab_single_ref(const char *refname, con=
st unsigned char *sha1, int f
 			     refname[plen] =3D=3D '/' ||
 			     p[plen-1] =3D=3D '/'))
 				break;
-			if (!fnmatch(p, refname, FNM_PATHNAME))
+			if (!wildmatch(p, refname, FNM_PATHNAME))
 				break;
 		}
 		if (!*pattern)
diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index 41c88a9..8271fbb 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -2,6 +2,7 @@
 #include "cache.h"
 #include "transport.h"
 #include "remote.h"
+#include "wildmatch.h"
=20
 static const char ls_remote_usage[] =3D
 "git ls-remote [--heads] [--tags]  [-u <exec> | --upload-pack <exec>]\=
n"
@@ -22,7 +23,7 @@ static int tail_match(const char **pattern, const cha=
r *path)
 	if (snprintf(pathbuf, sizeof(pathbuf), "/%s", path) > sizeof(pathbuf)=
)
 		return error("insanely long ref %.*s...", 20, path);
 	while ((p =3D *(pattern++)) !=3D NULL) {
-		if (!fnmatch(p, pathbuf, 0))
+		if (!wildmatch(p, pathbuf, 0))
 			return 1;
 	}
 	return 0;
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 1b37458..0cc3141 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -4,6 +4,7 @@
 #include "tag.h"
 #include "refs.h"
 #include "parse-options.h"
+#include "wildmatch.h"
=20
 #define CUTOFF_DATE_SLOP 86400 /* one day */
=20
@@ -97,7 +98,7 @@ static int name_ref(const char *path, const unsigned =
char *sha1, int flags, void
 	if (data->tags_only && prefixcmp(path, "refs/tags/"))
 		return 0;
=20
-	if (data->ref_filter && fnmatch(data->ref_filter, path, 0))
+	if (data->ref_filter && wildmatch(data->ref_filter, path, 0))
 		return 0;
=20
 	while (o && o->type =3D=3D OBJ_TAG) {
diff --git a/builtin/reflog.c b/builtin/reflog.c
index 062d7da..39dd8b4 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -7,6 +7,7 @@
 #include "diff.h"
 #include "revision.h"
 #include "reachable.h"
+#include "wildmatch.h"
=20
 /*
  * reflog expire
@@ -561,7 +562,7 @@ static void set_reflog_expiry_param(struct cmd_refl=
og_expire_cb *cb, int slot, c
 		return; /* both given explicitly -- nothing to tweak */
=20
 	for (ent =3D reflog_expire_cfg; ent; ent =3D ent->next) {
-		if (!fnmatch(ent->pattern, ref, 0)) {
+		if (!wildmatch(ent->pattern, ref, 0)) {
 			if (!(slot & EXPIRE_TOTAL))
 				cb->expire_total =3D ent->expire_total;
 			if (!(slot & EXPIRE_UNREACH))
diff --git a/builtin/replace.c b/builtin/replace.c
index 4a8970e..7fdefa8 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -12,6 +12,7 @@
 #include "builtin.h"
 #include "refs.h"
 #include "parse-options.h"
+#include "wildmatch.h"
=20
 static const char * const git_replace_usage[] =3D {
 	"git replace [-f] <object> <replacement>",
@@ -25,7 +26,7 @@ static int show_reference(const char *refname, const =
unsigned char *sha1,
 {
 	const char *pattern =3D cb_data;
=20
-	if (!fnmatch(pattern, refname, 0))
+	if (!wildmatch(pattern, refname, 0))
 		printf("%s\n", refname);
=20
 	return 0;
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index a59e088..f4fa165 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -4,6 +4,7 @@
 #include "builtin.h"
 #include "color.h"
 #include "parse-options.h"
+#include "wildmatch.h"
=20
 static const char* show_branch_usage[] =3D {
     "git show-branch [-a|--all] [-r|--remotes] [--topo-order | --date-=
order] [--current] [--color[=3D<when>] | --no-color] [--sparse] [--more=
=3D<n> | --list | --independent | --merge-base] [--no-name | --sha1-nam=
e] [--topics] [(<rev> | <glob>)...]",
@@ -452,7 +453,7 @@ static int append_matching_ref(const char *refname,=
 const unsigned char *sha1, i
 			slash--;
 	if (!*tail)
 		return 0;
-	if (fnmatch(match_ref_pattern, tail, 0))
+	if (wildmatch(match_ref_pattern, tail, 0))
 		return 0;
 	if (!prefixcmp(refname, "refs/heads/"))
 		return append_head_ref(refname, sha1, flag, cb_data);
diff --git a/builtin/tag.c b/builtin/tag.c
index 7b1be85..89aead3 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -17,6 +17,7 @@
 #include "gpg-interface.h"
 #include "sha1-array.h"
 #include "column.h"
+#include "wildmatch.h"
=20
 static const char * const git_tag_usage[] =3D {
 	"git tag [-a|-s|-u <key-id>] [-f] [-m <msg>|-F <file>] <tagname> [<he=
ad>]",
@@ -42,7 +43,7 @@ static int match_pattern(const char **patterns, const=
 char *ref)
 	if (!*patterns)
 		return 1;
 	for (; *patterns; patterns++)
-		if (!fnmatch(*patterns, ref, 0))
+		if (!wildmatch(*patterns, ref, 0))
 			return 1;
 	return 0;
 }
diff --git a/diffcore-order.c b/diffcore-order.c
index 23e9385..21eb30c 100644
--- a/diffcore-order.c
+++ b/diffcore-order.c
@@ -4,6 +4,7 @@
 #include "cache.h"
 #include "diff.h"
 #include "diffcore.h"
+#include "wildmatch.h"
=20
 static char **order;
 static int order_cnt;
@@ -79,7 +80,7 @@ static int match_order(const char *path)
 		strcpy(p, path);
 		while (p[0]) {
 			char *cp;
-			if (!fnmatch(order[i], p, 0))
+			if (!wildmatch(order[i], p, 0))
 				return i;
 			cp =3D strrchr(p, '/');
 			if (!cp)
diff --git a/dir.c b/dir.c
index 7bbd6f8..c1339c4 100644
--- a/dir.c
+++ b/dir.c
@@ -32,7 +32,7 @@ int strncmp_icase(const char *a, const char *b, size_=
t count)
=20
 int fnmatch_icase(const char *pattern, const char *string, int flags)
 {
-	return fnmatch(pattern, string, flags | (ignore_case ? FNM_CASEFOLD :=
 0));
+	return wildmatch(pattern, string, flags | (ignore_case ? FNM_CASEFOLD=
 : 0));
 }
=20
 static size_t common_prefix_len(const char **pathspec)
@@ -231,7 +231,7 @@ static int match_pathspec_item(const struct pathspe=
c_item *item, int prefix,
 			return MATCHED_RECURSIVELY;
 	}
=20
-	if (item->use_wildcard && !fnmatch(match, name, 0))
+	if (item->use_wildcard && !wildmatch(match, name, 0))
 		return MATCHED_FNMATCH;
=20
 	return 0;
diff --git a/refs.c b/refs.c
index da74a2b..47929d9 100644
--- a/refs.c
+++ b/refs.c
@@ -3,6 +3,7 @@
 #include "object.h"
 #include "tag.h"
 #include "dir.h"
+#include "wildmatch.h"
=20
 /*
  * Make sure "ref" is something reasonable to have under ".git/refs/";
@@ -1188,7 +1189,7 @@ static int filter_refs(const char *refname, const=
 unsigned char *sha1, int flags
 		       void *data)
 {
 	struct ref_filter *filter =3D (struct ref_filter *)data;
-	if (fnmatch(filter->pattern, refname, 0))
+	if (wildmatch(filter->pattern, refname, 0))
 		return 0;
 	return filter->fn(refname, sha1, flags, filter->cb_data);
 }
diff --git a/tree-walk.c b/tree-walk.c
index 492c7cd..c729e89 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -3,6 +3,7 @@
 #include "unpack-trees.h"
 #include "dir.h"
 #include "tree.h"
+#include "wildmatch.h"
=20
 static const char *get_mode(const char *str, unsigned int *modep)
 {
@@ -627,7 +628,7 @@ enum interesting tree_entry_interesting(const struc=
t name_entry *entry,
 				return entry_interesting;
=20
 			if (item->use_wildcard) {
-				if (!fnmatch(match + baselen, entry->path, 0))
+				if (!wildmatch(match + baselen, entry->path, 0))
 					return entry_interesting;
=20
 				/*
@@ -652,7 +653,7 @@ match_wildcards:
=20
 		strbuf_add(base, entry->path, pathlen);
=20
-		if (!fnmatch(match, base->buf + base_offset, 0)) {
+		if (!wildmatch(match, base->buf + base_offset, 0)) {
 			strbuf_setlen(base, base_offset + baselen);
 			return entry_interesting;
 		}
--=20
1.8.0.rc2.23.g1fb49df
