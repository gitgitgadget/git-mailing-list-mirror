Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC5BC433F5
	for <git@archiver.kernel.org>; Sat, 22 Jan 2022 10:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbiAVKHR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Jan 2022 05:07:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbiAVKHQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Jan 2022 05:07:16 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18614C06173B
        for <git@vger.kernel.org>; Sat, 22 Jan 2022 02:07:16 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id r82so96781wma.0
        for <git@vger.kernel.org>; Sat, 22 Jan 2022 02:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=19wkjbftJ5kU7071nsMUz9k4evculK/sPDh1BBJPo3E=;
        b=PvYFop2GkkBIoR9FMUA0dR4aMmJVeFE3AlYQDLorG5XQ2/2TKq9QXpsOd+tC7WzTn3
         miq6nDElnukjm5BJvHn4L6ZnAeLZV4hu6kBtfHNSW5L/fqn+UcbnvFQO/vijzj+2iDk9
         2/Ie1k79QoPNSBnDbS1dfrCcrkqGq3buTU90fTVn2hsIgOO2lT9jd2rfIV3EG83vYtPY
         LLrHDytDp0DS6H6iGZhVwD/xMOVwmeVxaoh7jfMRXB6B4PncDzwwuTU70KBttZVSGGQt
         Z8r6kmGEaJuuxzPnl8qSxOV1TGD6rybHRsbcY+9F683IiKswd2JONhTJGDQX9c/leXMd
         apVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=19wkjbftJ5kU7071nsMUz9k4evculK/sPDh1BBJPo3E=;
        b=ttD5l+AjaWkzD7FvU6asXSkKhoCYf4qmr7DEMSTxZB+nQOxnRhllujjk4NgSXNllXm
         DhK9MPx3HcRWirJzPdAXrnTX0tveXLy4A2bH/RZMsLVOah/KUe8G+tCjgT1mPsA9vCsO
         jCqrfufXceGbs4EOUhe6k3fopreCi/HBpWD+FpK2NjBVG+7BF6bbLNRxUXvR6fT1W+rF
         dnK6zq53wfi5Bj5b0A2+L64kIrbLTvFe7K/t4ituKX7F2WyhPy2OGdO8n2JVWx+rw0TO
         UvdcivOdQnJ3KSPQhDsgO9r0qPkoRIGCcEFSe3vei3oJJwlfPBHBQmU9RRwOv/u4o9n0
         SPtw==
X-Gm-Message-State: AOAM532rSBBTiCOxz0VqllPa9m/nOyex72PtYoqYoPC/187rajMdMM35
        n8KmGSjWnjlTsPdGI5tZgL/LvpXeIYs=
X-Google-Smtp-Source: ABdhPJzvALXuQ7lIt+pDkzZQkd95KauF92MEO7NaqFtb/IWzYyflMvKO8EUqEkzZn0ncnNOWO24KOQ==
X-Received: by 2002:a05:600c:3485:: with SMTP id a5mr4081517wmq.13.1642846034312;
        Sat, 22 Jan 2022 02:07:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v5sm10546373wrx.114.2022.01.22.02.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jan 2022 02:07:13 -0800 (PST)
Message-Id: <pull.1204.git.git.1642846032807.gitgitgadget@gmail.com>
From:   "David Barr via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 22 Jan 2022 10:07:12 +0000
Subject: [PATCH] blame: add --ignore-revs-blob and blame.ignoreRevsBlob
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, David Barr <git@davebarr.dev>,
        David Barr <git@davebarr.dev>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: David Barr <git@davebarr.dev>

In a bare repository, there isn't a simple way to
ignore revisions via a file without extracting it
to a temporary file.

This patch provides a command-line option and
config variable, similar to --ignore-revs-file
and blame.ignoreRevsFile, which reads the list
of revisions to ignore from a blob in the
repository.

Signed-off-by: David Barr <git@davebarr.dev>
---
    blame: Add --ignore-revs-blob and blame.ignoreRevsBlob
    
    In a bare repository, there isn't a simple way to ignore revisions via a
    file without extracting it to a temporary file.
    
    This patch provides a command-line option and config variable, similar
    to --ignore-revs-file and blame.ignoreRevsFile, which reads the list of
    revisions to ignore from a blob in the repository.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1204%2Fdavebarrau%2Fadd-ignore-revs-blob-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1204/davebarrau/add-ignore-revs-blob-v1
Pull-Request: https://github.com/git/git/pull/1204

 Documentation/blame-options.txt | 10 ++--
 Documentation/config/blame.txt  |  7 ++-
 builtin/blame.c                 | 23 ++++++++-
 oidset.c                        | 84 ++++++++++++++++++++++++++-------
 oidset.h                        |  2 +
 t/t8013-blame-ignore-revs.sh    | 19 ++++++++
 6 files changed, 124 insertions(+), 21 deletions(-)

diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
index 9a663535f44..d6e59c57983 100644
--- a/Documentation/blame-options.txt
+++ b/Documentation/blame-options.txt
@@ -132,9 +132,13 @@ take effect.
 --ignore-revs-file <file>::
 	Ignore revisions listed in `file`, which must be in the same format as an
 	`fsck.skipList`.  This option may be repeated, and these files will be
-	processed after any files specified with the `blame.ignoreRevsFile` config
-	option.  An empty file name, `""`, will clear the list of revs from
-	previously processed files.
+	processed after any files specified with the `blame.ignoreRevsFile` or
+	`blame.ignoreRevsBlob` config options.  An empty file name, `""`, will
+	clear the list of revs from previously processed files.
+
+--ignore-revs-blob <blob>::
+	Like `--ignore-revs-file`, but consider the value as a reference to a blob
+	in the repository.
 
 --color-lines::
 	Color line annotations in the default format differently if they come from
diff --git a/Documentation/config/blame.txt b/Documentation/config/blame.txt
index 4d047c17908..109ca796de0 100644
--- a/Documentation/config/blame.txt
+++ b/Documentation/config/blame.txt
@@ -25,7 +25,12 @@ blame.ignoreRevsFile::
 	line, in linkgit:git-blame[1].  Whitespace and comments beginning with
 	`#` are ignored.  This option may be repeated multiple times.  Empty
 	file names will reset the list of ignored revisions.  This option will
-	be handled before the command line option `--ignore-revs-file`.
+	be handled before the command line options `--ignore-revs-file` and
+	`--ignore-revs-blob`.
+
+blame.ignoreRevsBlob::
+	Like `blame.ignoreRevsFile`, but consider the value as a reference to
+	a blob in the repository.
 
 blame.markUnblamableLines::
 	Mark lines that were changed by an ignored revision that we could not
diff --git a/builtin/blame.c b/builtin/blame.c
index 7fafeac4081..c70c99cfda5 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -54,6 +54,7 @@ static int show_progress;
 static char repeated_meta_color[COLOR_MAXLEN];
 static int coloring_mode;
 static struct string_list ignore_revs_file_list = STRING_LIST_INIT_NODUP;
+static struct string_list ignore_revs_blob_list = STRING_LIST_INIT_NODUP;
 static int mark_unblamable_lines;
 static int mark_ignored_lines;
 
@@ -711,6 +712,16 @@ static int git_blame_config(const char *var, const char *value, void *cb)
 		string_list_insert(&ignore_revs_file_list, str);
 		return 0;
 	}
+	if (!strcmp(var, "blame.ignorerevsblob")) {
+		const char *str;
+		int ret;
+
+		ret = git_config_string(&str, var, value);
+		if (ret)
+			return ret;
+		string_list_insert(&ignore_revs_blob_list, str);
+		return 0;
+	}
 	if (!strcmp(var, "blame.markunblamablelines")) {
 		mark_unblamable_lines = git_config_bool(var, value);
 		return 0;
@@ -822,6 +833,7 @@ static int peel_to_commit_oid(struct object_id *oid_ret, void *cbdata)
 
 static void build_ignorelist(struct blame_scoreboard *sb,
 			     struct string_list *ignore_revs_file_list,
+			     struct string_list *ignore_revs_blob_list,
 			     struct string_list *ignore_rev_list)
 {
 	struct string_list_item *i;
@@ -835,6 +847,13 @@ static void build_ignorelist(struct blame_scoreboard *sb,
 			oidset_parse_file_carefully(&sb->ignore_list, i->string,
 						    peel_to_commit_oid, sb);
 	}
+	for_each_string_list_item(i, ignore_revs_blob_list) {
+		if (!strcmp(i->string, ""))
+			oidset_clear(&sb->ignore_list);
+		else
+			oidset_parse_blob(&sb->ignore_list, i->string,
+						    peel_to_commit_oid, sb);
+	}
 	for_each_string_list_item(i, ignore_rev_list) {
 		if (get_oid_committish(i->string, &oid) ||
 		    peel_to_commit_oid(&oid, sb))
@@ -878,6 +897,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		OPT_BIT('w', NULL, &xdl_opts, N_("ignore whitespace differences"), XDF_IGNORE_WHITESPACE),
 		OPT_STRING_LIST(0, "ignore-rev", &ignore_rev_list, N_("rev"), N_("ignore <rev> when blaming")),
 		OPT_STRING_LIST(0, "ignore-revs-file", &ignore_revs_file_list, N_("file"), N_("ignore revisions from <file>")),
+		OPT_STRING_LIST(0, "ignore-revs-blob", &ignore_revs_blob_list, N_("blob"), N_("ignore revisions from <blob>")),
 		OPT_BIT(0, "color-lines", &output_option, N_("color redundant metadata from previous line differently"), OUTPUT_COLOR_LINE),
 		OPT_BIT(0, "color-by-age", &output_option, N_("color lines by age"), OUTPUT_SHOW_AGE_WITH_COLOR),
 		OPT_BIT(0, "minimal", &xdl_opts, N_("spend extra cycles to find better match"), XDF_NEED_MINIMAL),
@@ -1084,8 +1104,9 @@ parse_done:
 	sb.reverse = reverse;
 	sb.repo = the_repository;
 	sb.path = path;
-	build_ignorelist(&sb, &ignore_revs_file_list, &ignore_rev_list);
+	build_ignorelist(&sb, &ignore_revs_file_list, &ignore_revs_blob_list, &ignore_rev_list);
 	string_list_clear(&ignore_revs_file_list, 0);
+	string_list_clear(&ignore_revs_blob_list, 0);
 	string_list_clear(&ignore_rev_list, 0);
 	setup_scoreboard(&sb, &o);
 
diff --git a/oidset.c b/oidset.c
index b36a2bae864..0cca63700da 100644
--- a/oidset.c
+++ b/oidset.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "oidset.h"
+#include "object-store.h"
 
 void oidset_init(struct oidset *set, size_t initial_size)
 {
@@ -41,6 +42,29 @@ void oidset_parse_file(struct oidset *set, const char *path)
 	oidset_parse_file_carefully(set, path, NULL, NULL);
 }
 
+static int read_oidset_line(struct strbuf sb, struct object_id *oid)
+{
+       const char *p;
+       const char *name;
+
+       /*
+	* Allow trailing comments, leading whitespace
+	* (including before commits), and empty or whitespace
+	* only lines.
+	*/
+       name = strchr(sb.buf, '#');
+       if (name)
+	       strbuf_setlen(&sb, name - sb.buf);
+       strbuf_trim(&sb);
+       if (!sb.len)
+	       return 0;
+
+       if (parse_oid_hex(sb.buf, oid, &p) || *p != '\0')
+	       die("invalid object name: %s", sb.buf);
+
+       return 1;
+}
+
 void oidset_parse_file_carefully(struct oidset *set, const char *path,
 				 oidset_parse_tweak_fn fn, void *cbdata)
 {
@@ -52,23 +76,8 @@ void oidset_parse_file_carefully(struct oidset *set, const char *path,
 	if (!fp)
 		die("could not open object name list: %s", path);
 	while (!strbuf_getline(&sb, fp)) {
-		const char *p;
-		const char *name;
-
-		/*
-		 * Allow trailing comments, leading whitespace
-		 * (including before commits), and empty or whitespace
-		 * only lines.
-		 */
-		name = strchr(sb.buf, '#');
-		if (name)
-			strbuf_setlen(&sb, name - sb.buf);
-		strbuf_trim(&sb);
-		if (!sb.len)
+		if (!read_oidset_line(sb, &oid))
 			continue;
-
-		if (parse_oid_hex(sb.buf, &oid, &p) || *p != '\0')
-			die("invalid object name: %s", sb.buf);
 		if (fn && fn(&oid, cbdata))
 			continue;
 		oidset_insert(set, &oid);
@@ -78,3 +87,46 @@ void oidset_parse_file_carefully(struct oidset *set, const char *path,
 	fclose(fp);
 	strbuf_release(&sb);
 }
+
+static void read_oidset_string(struct oidset *set, oidset_parse_tweak_fn fn,
+			       void *cbdata, const char *buf, unsigned long size)
+{
+	struct object_id oid;
+	struct strbuf **lines;
+	struct strbuf **line;
+
+	lines = strbuf_split_buf(buf, size, '\n', 0);
+
+	for (line = lines; *line; line++) {
+		if (!read_oidset_line(**line, &oid))
+			continue;
+		if (fn && fn(&oid, cbdata))
+			continue;
+		oidset_insert(set, &oid);
+	}
+	strbuf_list_free(lines);
+}
+
+void oidset_parse_blob(struct oidset *set, const char *name,
+				 oidset_parse_tweak_fn fn, void *cbdata)
+{
+	struct object_id oid;
+	char *buf;
+	unsigned long size;
+	enum object_type type;
+
+	if (!name) {
+		return;
+	}
+	if (get_oid(name, &oid) < 0) {
+		die("unable to read object id for %s", name);
+	}
+	buf = read_object_file(&oid, &type, &size);
+	if (!buf)
+		die("unable to read oidset file at %s", name);
+	if (type != OBJ_BLOB)
+		die("oidset file is not a blob: %s", name);
+
+	read_oidset_string(set, fn, cbdata, buf, size);
+	free(buf);
+}
diff --git a/oidset.h b/oidset.h
index ba4a5a2cd3a..bad9246a150 100644
--- a/oidset.h
+++ b/oidset.h
@@ -84,6 +84,8 @@ void oidset_parse_file(struct oidset *set, const char *path);
 typedef int (*oidset_parse_tweak_fn)(struct object_id *, void *);
 void oidset_parse_file_carefully(struct oidset *set, const char *path,
 				 oidset_parse_tweak_fn fn, void *cbdata);
+void oidset_parse_blob(struct oidset *set, const char *path,
+				 oidset_parse_tweak_fn fn, void *cbdata);
 
 struct oidset_iter {
 	kh_oid_set_t *set;
diff --git a/t/t8013-blame-ignore-revs.sh b/t/t8013-blame-ignore-revs.sh
index b18633dee1b..9d38a473a39 100755
--- a/t/t8013-blame-ignore-revs.sh
+++ b/t/t8013-blame-ignore-revs.sh
@@ -115,6 +115,25 @@ test_expect_success ignore_revs_from_configs_and_files '
 	test_cmp expect actual
 '
 
+# Ignore X from the config option, Y from a file.
+test_expect_success ignore_revs_from_configs_and_blobs '
+	git rev-parse X >ignore_x &&
+	git rev-parse Y >ignore_y &&
+	git add ignore_x ignore_y &&
+	git commit -m ignore &&
+	git config --add blame.ignoreRevsBlob HEAD:ignore_x &&
+	git blame --line-porcelain file --ignore-revs-blob HEAD:ignore_y >blame_raw 2>&1 &&
+	git config --unset blame.ignoreRevsBlob HEAD:ignore_x &&
+
+	grep -E "^[0-9a-f]+ [0-9]+ 1" blame_raw | sed -e "s/ .*//" >actual &&
+	git rev-parse A >expect &&
+	test_cmp expect actual &&
+
+	grep -E "^[0-9a-f]+ [0-9]+ 2" blame_raw | sed -e "s/ .*//" >actual &&
+	git rev-parse B >expect &&
+	test_cmp expect actual
+'
+
 # Override blame.ignoreRevsFile (ignore_x) with an empty string.  X should be
 # blamed now for lines 1 and 2, since we are no longer ignoring X.
 test_expect_success override_ignore_revs_file '

base-commit: 297ca895a27a6bbdb7906371d533f72a12ad25b2
-- 
gitgitgadget
