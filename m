From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 03/21] Export parse_pathspec() and convert some get_pathspec() calls
Date: Fri, 11 Jan 2013 18:20:57 +0700
Message-ID: <1357903275-16804-4-git-send-email-pclouds@gmail.com>
References: <1357903275-16804-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 11 12:21:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtcgC-0006XB-Rl
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 12:21:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753183Ab3AKLVW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Jan 2013 06:21:22 -0500
Received: from mail-da0-f52.google.com ([209.85.210.52]:42245 "EHLO
	mail-da0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753098Ab3AKLVV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2013 06:21:21 -0500
Received: by mail-da0-f52.google.com with SMTP id f10so737137dak.39
        for <git@vger.kernel.org>; Fri, 11 Jan 2013 03:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=etIMMeZw7usSiD+Zo/Ea8kzoJCW5gHJCWSc+xf4Mflw=;
        b=NE0or4H4q9jw3R3To53oi7kScaJ7CCBK7YtOtasSv7gO/OMQZhZIBWbE5Vxg6btZly
         vJtVO/ULmOJslXDDGEKA5DhY+x454wwmqykRrBeNdkbpDjRuFczE4d9X4HCD241I92ks
         lBLS+rOeeuenBIaluqCRXqxUM6xN6TZDJWmhb2eTp8hPONjj3unrfJlosqHmKGpdi/t6
         xx+bZDV6VRtARAPetR8FGECjZM324t0/9bt6DTg59KL7fwK27PQ9lRQA0UnYCfWfuAiC
         sYkqg9P3Rv5wH15b2sDrC3145wtqaN+wvE2xynzWB1WSxnP3yRfXrrgPPLRJ0pOuGBmi
         k/bA==
X-Received: by 10.66.74.2 with SMTP id p2mr207537480pav.55.1357903280357;
        Fri, 11 Jan 2013 03:21:20 -0800 (PST)
Received: from lanh ([115.74.46.148])
        by mx.google.com with ESMTPS id uk9sm2631793pbc.63.2013.01.11.03.21.17
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 11 Jan 2013 03:21:19 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Fri, 11 Jan 2013 18:21:35 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1357903275-16804-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213196>

These call sites follow the pattern:

   paths =3D get_pathspec(prefix, argv);
   init_pathspec(&pathspec, paths);

which can be converted into a single parse_pathspec() call.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/grep.c         | 4 +---
 builtin/ls-tree.c      | 2 +-
 builtin/update-index.c | 3 +--
 cache.h                | 6 ++++++
 revision.c             | 4 ++--
 setup.c                | 6 +++---
 6 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 0e1b6c8..705f9ff 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -630,7 +630,6 @@ int cmd_grep(int argc, const char **argv, const cha=
r *prefix)
 	const char *show_in_pager =3D NULL, *default_pager =3D "dummy";
 	struct grep_opt opt;
 	struct object_array list =3D OBJECT_ARRAY_INIT;
-	const char **paths =3D NULL;
 	struct pathspec pathspec;
 	struct string_list path_list =3D STRING_LIST_INIT_NODUP;
 	int i;
@@ -857,8 +856,7 @@ int cmd_grep(int argc, const char **argv, const cha=
r *prefix)
 			verify_filename(prefix, argv[j], j =3D=3D i);
 	}
=20
-	paths =3D get_pathspec(prefix, argv + i);
-	init_pathspec(&pathspec, paths);
+	parse_pathspec(&pathspec, PATHSPEC_FROMTOP, 0, prefix, argv + i);
 	pathspec.max_depth =3D opt.max_depth;
 	pathspec.recursive =3D 1;
=20
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index fb76e38..a78ba53 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -166,7 +166,7 @@ int cmd_ls_tree(int argc, const char **argv, const =
char *prefix)
 	if (get_sha1(argv[0], sha1))
 		die("Not a valid object name %s", argv[0]);
=20
-	init_pathspec(&pathspec, get_pathspec(prefix, argv + 1));
+	parse_pathspec(&pathspec, PATHSPEC_FROMTOP, 0, prefix, argv + 1);
 	for (i =3D 0; i < pathspec.nr; i++)
 		pathspec.items[i].nowildcard_len =3D pathspec.items[i].len;
 	pathspec.has_wildcard =3D 0;
diff --git a/builtin/update-index.c b/builtin/update-index.c
index ada1dff..6728e59 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -546,10 +546,9 @@ static int do_reupdate(int ac, const char **av,
 	 */
 	int pos;
 	int has_head =3D 1;
-	const char **paths =3D get_pathspec(prefix, av + 1);
 	struct pathspec pathspec;
=20
-	init_pathspec(&pathspec, paths);
+	parse_pathspec(&pathspec, PATHSPEC_FROMTOP, 0, prefix, av + 1);
=20
 	if (read_ref("HEAD", head_sha1))
 		/* If there is no HEAD, that means it is an initial
diff --git a/cache.h b/cache.h
index 9304d91..e52365d 100644
--- a/cache.h
+++ b/cache.h
@@ -473,6 +473,9 @@ extern int index_name_is_other(const struct index_s=
tate *, const char *, int);
 extern int ie_match_stat(const struct index_state *, struct cache_entr=
y *, struct stat *, unsigned int);
 extern int ie_modified(const struct index_state *, struct cache_entry =
*, struct stat *, unsigned int);
=20
+/* Pathspec magic */
+#define PATHSPEC_FROMTOP    (1<<0)
+
 struct pathspec {
 	const char **raw; /* get_pathspec() result, not freed by free_pathspe=
c() */
 	int nr;
@@ -487,6 +490,9 @@ struct pathspec {
 };
=20
 extern int init_pathspec(struct pathspec *, const char **);
+extern void parse_pathspec(struct pathspec *pathspec, unsigned magic,
+			   unsigned flags, const char *prefix,
+			   const char **args);
 extern void free_pathspec(struct pathspec *);
 extern int ce_path_match(const struct cache_entry *ce, const struct pa=
thspec *pathspec);
=20
diff --git a/revision.c b/revision.c
index 95d21e6..a044242 100644
--- a/revision.c
+++ b/revision.c
@@ -1851,8 +1851,8 @@ int setup_revisions(int argc, const char **argv, =
struct rev_info *revs, struct s
 		 */
 		ALLOC_GROW(prune_data.path, prune_data.nr+1, prune_data.alloc);
 		prune_data.path[prune_data.nr++] =3D NULL;
-		init_pathspec(&revs->prune_data,
-			      get_pathspec(revs->prefix, prune_data.path));
+		parse_pathspec(&revs->prune_data, PATHSPEC_FROMTOP, 0,
+			       revs->prefix, prune_data.path);
 	}
=20
 	if (revs->def =3D=3D NULL)
diff --git a/setup.c b/setup.c
index 4fcdae6..6e960b9 100644
--- a/setup.c
+++ b/setup.c
@@ -266,9 +266,9 @@ static int pathspec_item_cmp(const void *a_, const =
void *b_)
  * Given command line arguments and a prefix, convert the input to
  * pathspec. die() if any magic other than ones in magic_mask.
  */
-static void parse_pathspec(struct pathspec *pathspec,
-			   unsigned magic_mask, unsigned flags,
-			   const char *prefix, const char **argv)
+void parse_pathspec(struct pathspec *pathspec,
+		    unsigned magic_mask, unsigned flags,
+		    const char *prefix, const char **argv)
 {
 	struct pathspec_item *item;
 	const char *entry =3D *argv;
--=20
1.8.0.rc2.23.g1fb49df
