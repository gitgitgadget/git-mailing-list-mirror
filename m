From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 05/25] list-files: command skeleton
Date: Mon,  6 Apr 2015 20:52:14 +0700
Message-ID: <1428328354-14897-6-git-send-email-pclouds@gmail.com>
References: <1428328354-14897-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: 1425896314-10941-1-git-send-email-pclouds@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 06 15:53:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yf7Sk-0004xy-Cq
	for gcvg-git-2@plane.gmane.org; Mon, 06 Apr 2015 15:53:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753390AbbDFNxK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Apr 2015 09:53:10 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36476 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753328AbbDFNxI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2015 09:53:08 -0400
Received: by pabsx10 with SMTP id sx10so45090028pab.3
        for <git@vger.kernel.org>; Mon, 06 Apr 2015 06:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=nXy7l7bTsOCxKrVNazJy6MrA2RowT5kv+blKHZHFehI=;
        b=06F3Z1Am06kTNSksmTubXINilYMk6Ejc+aB1mBD8Rc7h0XXucr60yErBVt4b3Hhc1z
         ZSTCBgwvwn4hs5VjLNHxwDQeiNFk0+0YsFEyeQj+q58OHIz27fpMZAD/ileqALX9zmvG
         95b3K6zeXUepUJRF7yE9OL5JuEzVuijljZ6amJRgkR3zRWHNaS3dHmY1fy6EbR2aiYND
         8WB/+bW/oaRgKHpE+a9nTLJeEnlY3VccxsjobsJrY5NfoP4IGeRtdzXVIUxMh4FbXkFO
         llOdIuWt2X9Ca5D9DfNLq9xL2qfubU97xF7TnGoG1eZNTEi0bWS+Zd4DjzpG5+NvU3vT
         ZBYQ==
X-Received: by 10.68.205.226 with SMTP id lj2mr27247372pbc.52.1428328388366;
        Mon, 06 Apr 2015 06:53:08 -0700 (PDT)
Received: from lanh ([115.73.245.217])
        by mx.google.com with ESMTPSA id v5sm4794493pdc.41.2015.04.06.06.53.05
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Apr 2015 06:53:07 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 06 Apr 2015 20:53:19 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1428328354-14897-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266850>

list-files is supposed to be the user friendly version of ls-files, or
an alternative to git-status. Nothing fancy in this patch yet.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 .gitignore                     |   1 +
 Makefile                       |   1 +
 builtin.h                      |   1 +
 builtin/list-files.c (new)     | 107 +++++++++++++++++++++++++++++++++=
++++++++
 git.c                          |   1 +
 t/t7013-list-files.sh (new +x) |  35 ++++++++++++++
 6 files changed, 146 insertions(+)
 create mode 100644 builtin/list-files.c
 create mode 100755 t/t7013-list-files.sh

diff --git a/.gitignore b/.gitignore
index a052419..0534225 100644
--- a/.gitignore
+++ b/.gitignore
@@ -77,6 +77,7 @@
 /git-interpret-trailers
 /git-instaweb
 /git-log
+/git-list-files
 /git-ls-files
 /git-ls-remote
 /git-ls-tree
diff --git a/Makefile b/Makefile
index 459121d..17f52b2 100644
--- a/Makefile
+++ b/Makefile
@@ -832,6 +832,7 @@ BUILTIN_OBJS +=3D builtin/index-pack.o
 BUILTIN_OBJS +=3D builtin/init-db.o
 BUILTIN_OBJS +=3D builtin/interpret-trailers.o
 BUILTIN_OBJS +=3D builtin/log.o
+BUILTIN_OBJS +=3D builtin/list-files.o
 BUILTIN_OBJS +=3D builtin/ls-files.o
 BUILTIN_OBJS +=3D builtin/ls-remote.o
 BUILTIN_OBJS +=3D builtin/ls-tree.o
diff --git a/builtin.h b/builtin.h
index b87df70..afc29e7 100644
--- a/builtin.h
+++ b/builtin.h
@@ -76,6 +76,7 @@ extern int cmd_init_db(int argc, const char **argv, c=
onst char *prefix);
 extern int cmd_interpret_trailers(int argc, const char **argv, const c=
har *prefix);
 extern int cmd_log(int argc, const char **argv, const char *prefix);
 extern int cmd_log_reflog(int argc, const char **argv, const char *pre=
fix);
+extern int cmd_list_files(int argc, const char **argv, const char *pre=
fix);
 extern int cmd_ls_files(int argc, const char **argv, const char *prefi=
x);
 extern int cmd_ls_tree(int argc, const char **argv, const char *prefix=
);
 extern int cmd_ls_remote(int argc, const char **argv, const char *pref=
ix);
diff --git a/builtin/list-files.c b/builtin/list-files.c
new file mode 100644
index 0000000..8b74d79
--- /dev/null
+++ b/builtin/list-files.c
@@ -0,0 +1,107 @@
+#include "cache.h"
+#include "builtin.h"
+#include "parse-options.h"
+#include "pathspec.h"
+#include "dir.h"
+
+enum item_type {
+	FROM_INDEX
+};
+
+struct item {
+	enum item_type type;
+	const char *path;
+	const struct cache_entry *ce;
+};
+
+struct item_list {
+	struct item *items;
+	int nr, alloc;
+};
+
+static struct pathspec pathspec;
+static const char *prefix;
+static int prefix_length;
+
+static const char * const ls_usage[] =3D {
+	N_("git list-files [options] [<pathspec>...]"),
+	NULL
+};
+
+struct option ls_options[] =3D {
+	OPT_END()
+};
+
+static void populate_cached_entries(struct item_list *result,
+				    const struct index_state *istate)
+{
+	int i;
+
+	for (i =3D 0; i < istate->cache_nr; i++) {
+		const struct cache_entry *ce =3D istate->cache[i];
+		struct item *item;
+
+		if (!match_pathspec(&pathspec, ce->name, ce_namelen(ce),
+				    0, NULL,
+				    S_ISDIR(ce->ce_mode) ||
+				    S_ISGITLINK(ce->ce_mode)))
+			continue;
+
+		ALLOC_GROW(result->items, result->nr + 1, result->alloc);
+		item =3D result->items + result->nr++;
+		item->type =3D FROM_INDEX;
+		item->path =3D ce->name;
+		item->ce =3D ce;
+	}
+}
+
+static void display(const struct item_list *result)
+{
+	int i;
+
+	for (i =3D 0; i < result->nr; i++) {
+		const struct item *item =3D result->items + i;
+
+		printf("%s\n", item->path);
+	}
+}
+
+static int ls_config(const char *var, const char *value, void *cb)
+{
+	return git_default_config(var, value, cb);
+}
+
+int cmd_list_files(int argc, const char **argv, const char *cmd_prefix=
)
+{
+	struct item_list result;
+
+	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
+		usage_with_options(ls_usage, ls_options);
+
+	prefix =3D cmd_prefix;
+	if (prefix)
+		prefix_length =3D strlen(prefix);
+
+	if (read_cache() < 0)
+		die(_("index file corrupt"));
+
+	git_config(ls_config, NULL);
+
+	argc =3D parse_options(argc, argv, prefix, ls_options, ls_usage, 0);
+
+	parse_pathspec(&pathspec, 0,
+		       PATHSPEC_PREFER_CWD |
+		       PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP,
+		       cmd_prefix, argv);
+	pathspec.max_depth =3D 0;
+	pathspec.recursive =3D 1;
+
+	refresh_index(&the_index, REFRESH_QUIET | REFRESH_UNMERGED,
+		      &pathspec, NULL, NULL);
+
+	memset(&result, 0, sizeof(result));
+	populate_cached_entries(&result, &the_index);
+	display(&result);
+	/* free-ing result seems unnecessary */
+	return 0;
+}
diff --git a/git.c b/git.c
index 18fbf79..ae7fe77 100644
--- a/git.c
+++ b/git.c
@@ -418,6 +418,7 @@ static struct cmd_struct commands[] =3D {
 	{ "init", cmd_init_db, NO_SETUP },
 	{ "init-db", cmd_init_db, NO_SETUP },
 	{ "interpret-trailers", cmd_interpret_trailers, RUN_SETUP },
+	{ "list-files", cmd_list_files, RUN_SETUP | USE_PAGER | NEED_WORK_TRE=
E },
 	{ "log", cmd_log, RUN_SETUP },
 	{ "ls-files", cmd_ls_files, RUN_SETUP },
 	{ "ls-remote", cmd_ls_remote, RUN_SETUP_GENTLY },
diff --git a/t/t7013-list-files.sh b/t/t7013-list-files.sh
new file mode 100755
index 0000000..f43776e
--- /dev/null
+++ b/t/t7013-list-files.sh
@@ -0,0 +1,35 @@
+#!/bin/sh
+
+test_description=3D'list-files'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	mkdir sa sa/sb sc &&
+	touch a b c sa/a sa/sb/b sc/c &&
+	git add .
+'
+
+test_expect_success 'list-files from index' '
+	git list-files >actual &&
+	cat >expect <<-\EOF &&
+	a
+	b
+	c
+	sa/a
+	sa/sb/b
+	sc/c
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'list-files selectively from index' '
+	git list-files "*a" >actual &&
+	cat >expect <<-\EOF &&
+	a
+	sa/a
+	EOF
+	test_cmp expect actual
+'
+
+test_done
--=20
2.3.0.rc1.137.g477eb31
