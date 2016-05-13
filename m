From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 5/5] pathspec: record labels
Date: Fri, 13 May 2016 16:13:26 -0700
Message-ID: <20160513231326.8994-6-sbeller@google.com>
References: <20160513231326.8994-1-sbeller@google.com>
Cc: pclouds@gmail.com, gitster@pobox.com, git@vger.kernel.org,
	Jens.Lehmann@web.de, jrnieder@gmail.com,
	Stefan Beller <sbeller@google.com>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Sat May 14 01:13:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1MHE-0008KZ-DT
	for gcvg-git-2@plane.gmane.org; Sat, 14 May 2016 01:13:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753662AbcEMXNn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2016 19:13:43 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:34287 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753606AbcEMXNm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 19:13:42 -0400
Received: by mail-pf0-f172.google.com with SMTP id y69so46513807pfb.1
        for <git@vger.kernel.org>; Fri, 13 May 2016 16:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K2atxQWvoNgwBTTIypwfPNcaOKvSoHQuqt8bd3WuHiU=;
        b=ja0GT3Tvky/1dzdItTJzuAfWULPJJ5EuZeTZubWL35aymf5suYk9RpWjrFMqcGR/bw
         PwW/oxIgIlWqiKK9/8/LAkWbwW/B729x712bgeAf4Q+LdP3DUwMafdP3nWZOav2yQk1Y
         /RjGk1o+bO9Sr7M25KdS3VXkkR/WMKqzBKo6dkQD0vgqieoXukuVi7s3hpa4vwlRC2A/
         SEKLslJByscrD4sq2LWD3FJzOgLzg5gQqpOv3XbXmrpjaKUZkOKYwNgaYMFiD/r7P+e8
         P904zlRVdPFpZbnNktaw91ziH9Et8GlgL9Zh/3pHNqdJ/iSm3PhpKBxfT5AsNtxES3kW
         QP6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=K2atxQWvoNgwBTTIypwfPNcaOKvSoHQuqt8bd3WuHiU=;
        b=mMnVp1XvDMPa3uE8L13Zt4EWBa+pKeSjCCKpsmPr5/lC8Q8AZl6zZuKFcGiUfPNj/4
         Pi8F0ftC38GnEVWZORPd7ioITU4rejwzRbzJ03ScDq0t3xq5dLMTMuM4LIFLxbil1kbn
         5Kt6gWGNkdvi9426hY+WJyZvcoPRdBizLuNyxuaDXXpqqMJmLqY4EAYggUK1fTJiePRa
         bDOCYleTvnO1WVlQdkY4Hc/bnUDpWrMTp7DdW1Q6q1ezVOoJ8JJrkvUvhCnGjAsVJjSN
         MQo3dCpopOqlGazkmF350qVadoebN2ssZcSGzPZWWKMCXr9nfXUhIPjL+nCGblgnz6+0
         2Wnw==
X-Gm-Message-State: AOPr4FWG+qovatefChonveBBcdAYZPQ3eJNL+DdOo3D6X+jXQE3tyY7GD8gqM0JgGrBiLTvg
X-Received: by 10.98.27.129 with SMTP id b123mr26949998pfb.111.1463181220878;
        Fri, 13 May 2016 16:13:40 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:e84e:cb12:277e:4f09])
        by smtp.gmail.com with ESMTPSA id w187sm29848023pfw.50.2016.05.13.16.13.39
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 13 May 2016 16:13:40 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.401.g6647087.dirty
In-Reply-To: <20160513231326.8994-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294597>

Labels were originally designed to manage large amount of
submodules, the discussion steered this in a more general
direction, such that other files can be labeled as well.

Labels are meant to describe arbitrary set of files, which
is not described via the tree layout.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/gitattributes.txt    |  12 +++
 Documentation/glossary-content.txt |   4 +
 dir.c                              |  50 +++++++++++
 pathspec.c                         |  64 ++++++++++++++-
 pathspec.h                         |   1 +
 t/t6134-pathspec-with-labels.sh    | 164 +++++++++++++++++++++++++++++++++++++
 6 files changed, 291 insertions(+), 4 deletions(-)
 create mode 100755 t/t6134-pathspec-with-labels.sh

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index af2c682..7fd764f 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -906,6 +906,18 @@ If this attribute is not set or has an invalid value, the value of the
 (See linkgit:git-config[1]).
 
 
+
+Attaching labels to path
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+`label`
+^^^^^^^^^^
+By the value of this attribute you can specify a list of arbitrary strings
+to be attached to a path as labels. These labels can be used for
+easier paths matching using pathspecs (linkgit:gitglossary[1]).
+It is recommended to use only alphanumeric characters, dashes and
+underscores for the labels.
+
 USING MACRO ATTRIBUTES
 ----------------------
 
diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index 8ad29e6..f990017 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -384,6 +384,10 @@ full pathname may have special meaning:
 +
 Glob magic is incompatible with literal magic.
 
+label:<white space separated list>;;
+	Additionally to matching the pathspec, the path must habe a 'label'
+	attribute having set all labels listed here.
+
 exclude;;
 	After a path matches any non-exclude pathspec, it will be run
 	through all exclude pathspec (magic signature: `!`). If it
diff --git a/dir.c b/dir.c
index 656f272..a86e3ff 100644
--- a/dir.c
+++ b/dir.c
@@ -9,6 +9,7 @@
  */
 #include "cache.h"
 #include "dir.h"
+#include "attr.h"
 #include "refs.h"
 #include "wildmatch.h"
 #include "pathspec.h"
@@ -208,6 +209,52 @@ int within_depth(const char *name, int namelen,
 	return 1;
 }
 
+static int has_all_labels(const char *name, int namelen,
+			   const struct string_list *required_labels)
+{
+	static struct git_attr *attr;
+
+	struct git_attr_check check;
+	char *path;
+	int ret;
+
+	if (!attr)
+		attr = git_attr("label");
+	check.attr = attr;
+
+	path = xmemdupz(name, namelen);
+	if (git_check_attr(path, 1, &check))
+		die("internal bug: git_check_attr died.");
+	free(path);
+
+	if (ATTR_TRUE(check.value))
+		ret = 1; /* has all the labels */
+	else if (ATTR_FALSE(check.value))
+		ret = 0; /* has no labels */
+	else if (ATTR_UNSET(check.value))
+		/*
+		 * If no label was specified this matches, otherwise
+		 * there is a missing label.
+		 */
+		ret = (required_labels->nr > 0) ? 0 : 1;
+	else {
+		struct string_list_item *si;
+		struct string_list attr_labels = STRING_LIST_INIT_DUP;
+		string_list_split(&attr_labels, check.value, ',', -1);
+		string_list_sort(&attr_labels);
+		ret = 1;
+		for_each_string_list_item(si, required_labels) {
+			if (!string_list_has_string(&attr_labels, si->string)) {
+				ret = 0;
+				break;
+			}
+		}
+		string_list_clear(&attr_labels, 0);
+	}
+
+	return ret;
+}
+
 #define DO_MATCH_EXCLUDE   1
 #define DO_MATCH_DIRECTORY 2
 
@@ -263,6 +310,9 @@ static int match_pathspec_item(const struct pathspec_item *item, int prefix,
 	    strncmp(item->match, name - prefix, item->prefix))
 		return 0;
 
+	if (item->labels && !has_all_labels(name, namelen, item->labels))
+		return 0;
+
 	/* If the match was just the prefix, we matched */
 	if (!*match)
 		return MATCHED_RECURSIVELY;
diff --git a/pathspec.c b/pathspec.c
index 4dff252..c65428a 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -88,12 +88,40 @@ static void prefix_short_magic(struct strbuf *sb, int prefixlen,
 	strbuf_addf(sb, ",prefix:%d)", prefixlen);
 }
 
+static int check_valid_label_name(const char *label)
+{
+	if (!label || !strlen(label))
+		return -1;
+
+	if (!isalpha(*label))
+		return -1;
+
+	while (*label) {
+		if (!(isalnum(*label) ||
+			*label == '-' ||
+			*label == '_'))
+			return -1;
+		label++;
+	}
+
+	return 0;
+}
+
+static void validate_label_name(const char *label)
+{
+	if (check_valid_label_name(label))
+		warning(_("Label '%s' discouraged. Recommended label names start "
+			"with an alphabetic character and use only alphanumeric "
+			"characters, dashes and underscores."), label);
+}
+
 static void eat_long_magic(struct pathspec_item *item, const char *elt,
 		unsigned *magic, int *pathspec_prefix,
 		const char **copyfrom_, const char **long_magic_end)
 {
 	int i;
 	const char *copyfrom = *copyfrom_;
+	const char *body;
 	/* longhand */
 	const char *nextat;
 	for (copyfrom = elt + 2;
@@ -108,15 +136,30 @@ static void eat_long_magic(struct pathspec_item *item, const char *elt,
 		if (!len)
 			continue;
 
-		if (starts_with(copyfrom, "prefix:")) {
+		if (skip_prefix(copyfrom, "prefix:", &body)) {
 			char *endptr;
-			*pathspec_prefix = strtol(copyfrom + 7,
-						  &endptr, 10);
+			*pathspec_prefix = strtol(body, &endptr, 10);
 			if (endptr - copyfrom != len)
 				die(_("invalid parameter for pathspec magic 'prefix'"));
 			continue;
 		}
 
+		/* The label token may have no argument, so no trailing ':' */
+		if (skip_prefix(copyfrom, "label", &body)) {
+			struct strbuf sb = STRBUF_INIT;
+			skip_prefix(body, ":", &body);
+			strbuf_add(&sb, body, nextat - body);
+			if (!item->labels) {
+				item->labels = xmalloc(sizeof(*item->labels));
+				string_list_init(item->labels, 1);
+			} else
+				die(_("multiple labels not supported in pathspec magic"));
+			string_list_split(item->labels, sb.buf, ' ', -1);
+			string_list_remove_empty_items(item->labels, 0);
+			strbuf_release(&sb);
+			continue;
+		}
+
 		for (i = 0; i < ARRAY_SIZE(pathspec_magic); i++) {
 			if (strlen(pathspec_magic[i].name) == len &&
 			    !strncmp(pathspec_magic[i].name, copyfrom, len)) {
@@ -425,7 +468,7 @@ void parse_pathspec(struct pathspec *pathspec,
 	for (i = 0; i < n; i++) {
 		unsigned short_magic;
 		entry = argv[i];
-
+		item[i].labels = NULL;
 		item[i].magic = prefix_pathspec(item + i, &short_magic,
 						argv + i, flags,
 						prefix, prefixlen, entry);
@@ -447,6 +490,12 @@ void parse_pathspec(struct pathspec *pathspec,
 		if (item[i].nowildcard_len < item[i].len)
 			pathspec->has_wildcard = 1;
 		pathspec->magic |= item[i].magic;
+
+		if (item[i].labels) {
+			struct string_list_item *si;
+			for_each_string_list_item(si, item[i].labels)
+				validate_label_name(si->string);
+		}
 	}
 
 	if (nr_exclude == n)
@@ -502,6 +551,13 @@ void copy_pathspec(struct pathspec *dst, const struct pathspec *src)
 
 void free_pathspec(struct pathspec *pathspec)
 {
+	int i;
+	for (i = 0; i < pathspec->nr; i++) {
+		if (pathspec->items[i].labels)
+			string_list_clear(pathspec->items[i].labels, 1);
+		free(pathspec->items[i].labels);
+	}
+
 	free(pathspec->items);
 	pathspec->items = NULL;
 }
diff --git a/pathspec.h b/pathspec.h
index 0c11262..12ed2b8 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -32,6 +32,7 @@ struct pathspec {
 		int len, prefix;
 		int nowildcard_len;
 		int flags;
+		struct string_list *labels;
 	} *items;
 };
 
diff --git a/t/t6134-pathspec-with-labels.sh b/t/t6134-pathspec-with-labels.sh
new file mode 100755
index 0000000..1fe5ed7
--- /dev/null
+++ b/t/t6134-pathspec-with-labels.sh
@@ -0,0 +1,164 @@
+#!/bin/sh
+
+test_description='test labels in pathspecs'
+. ./test-lib.sh
+
+test_expect_success 'setup a tree' '
+	mkdir sub &&
+	for p in fileA fileB fileC fileAB fileAC fileBC fileNoLabel fileUnsetLabel fileSetLabel; do
+		: >$p &&
+		git add $p &&
+		: >sub/$p
+		git add sub/$p
+	done &&
+	git commit -m $p &&
+	git ls-files >actual &&
+	cat <<EOF >expect &&
+fileA
+fileAB
+fileAC
+fileB
+fileBC
+fileC
+fileNoLabel
+fileSetLabel
+fileUnsetLabel
+sub/fileA
+sub/fileAB
+sub/fileAC
+sub/fileB
+sub/fileBC
+sub/fileC
+sub/fileNoLabel
+sub/fileSetLabel
+sub/fileUnsetLabel
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'pathspec with labels and non existent .gitattributes' '
+	git ls-files ":(label)" >actual &&
+	git ls-files >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'pathspec with labels and non existent .gitattributes' '
+	git ls-files ":(label:a)" >actual &&
+	test_must_be_empty actual
+'
+
+test_expect_success 'setup .gitattributes' '
+	cat <<EOF >.gitattributes &&
+fileA label=labelA
+fileB label=labelB
+fileC label=labelC
+fileAB label=labelA,labelB
+fileAC label=labelA,labelC
+fileBC label=labelB,labelC
+fileUnsetLabel -label
+fileSetLabel label
+EOF
+	git add .gitattributes &&
+	git commit -m "add attributes"
+'
+
+test_expect_success 'check for any label' '
+	cat <<EOF >expect &&
+.gitattributes
+fileA
+fileAB
+fileAC
+fileB
+fileBC
+fileC
+fileNoLabel
+fileSetLabel
+sub/fileA
+sub/fileAB
+sub/fileAC
+sub/fileB
+sub/fileBC
+sub/fileC
+sub/fileNoLabel
+sub/fileSetLabel
+EOF
+	git ls-files ":(label)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'check specific label' '
+	cat <<EOF >expect &&
+fileA
+fileAB
+fileAC
+fileSetLabel
+sub/fileA
+sub/fileAB
+sub/fileAC
+sub/fileSetLabel
+EOF
+	git ls-files ":(label:labelA)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'check label with 2 labels' '
+	cat <<EOF >expect &&
+fileAB
+fileSetLabel
+sub/fileAB
+sub/fileSetLabel
+EOF
+	git ls-files ":(label:labelA labelB)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'check label with more labels' '
+	test_must_fail git ls-files ":(label:labelA,label:labelB)" 2>actual &&
+	test_i18ngrep "not supported" actual
+'
+
+test_expect_success 'check label with more labels but excluded path' '
+	cat <<EOF >expect &&
+fileAB
+fileB
+fileBC
+fileSetLabel
+EOF
+	git ls-files ":(label:labelB)" ":(exclude)sub/" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'check label excluding other labels' '
+	cat <<EOF >expect &&
+fileAB
+fileB
+fileBC
+fileSetLabel
+sub/fileAB
+sub/fileB
+EOF
+	git ls-files ":(label:labelB)" ":(exclude,label:labelC)sub/" >actual &&
+	test_cmp expect actual
+'
+
+
+test_expect_success 'check for explicit unlabeled paths' '
+	cat <<EOF >expect &&
+fileUnsetLabel
+sub/fileUnsetLabel
+EOF
+	git ls-files . ":(exclude,label)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'check for paths that have no label' '
+	cat <<EOF >expect &&
+.gitattributes
+fileNoLabel
+sub/fileNoLabel
+EOF
+	git ls-files ":(label)" ":(exclude,label:labelA)" ":(exclude,label:labelB)"  ":(exclude,label:labelC)"  >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
2.8.2.401.g6647087.dirty
