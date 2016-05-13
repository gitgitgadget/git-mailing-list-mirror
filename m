From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 4/4] pathspec: record labels
Date: Thu, 12 May 2016 17:19:36 -0700
Message-ID: <20160513001936.7623-5-sbeller@google.com>
References: <20160513001936.7623-1-sbeller@google.com>
Cc: pclouds@gmail.com, git@vger.kernel.org, jrnieder@gmail.com,
	Jens.Lehmann@web.de, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri May 13 02:19:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b10pd-0006f2-Kt
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 02:19:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751609AbcEMATv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 20:19:51 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36040 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751504AbcEMATr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 20:19:47 -0400
Received: by mail-pa0-f49.google.com with SMTP id bt5so34090913pac.3
        for <git@vger.kernel.org>; Thu, 12 May 2016 17:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nbt/l9HWnvY/Kuzb9kh3lGRzMVCdTx4kw52acnKaWK0=;
        b=OeAcGIjvSgTSVdNhDlSBbL1xZED42X+0ZA667V5s3ShTWyALKLGivoHutF7kXoGubV
         JmJxcz8stXbuesmtOvJvWyRtGUyFJW2IXxh9hBxuUOXlGN0ANzWOypc81JHR/wjv2QU2
         odUWoQglTNRZeleO7z0OalGB0wUcDhOTu+5rK9p5eqCEv/PsiKnLQPlJzWBGV9pAIuxa
         7sLnoOsxR292vKfRr5Vrlxc6rpECtbv4iWrE4wR1nhRqKmkg+gpS9i7oGOz7iZLhN5P4
         nXmVAXcQIpeyWJwu51IKOezOMe+v0lArMM67qZJcJMKES6M4fdFlUEL1UyoJeqQwxXoL
         RECg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nbt/l9HWnvY/Kuzb9kh3lGRzMVCdTx4kw52acnKaWK0=;
        b=SobYF6Zi2xNbEmxP+JPRQVSjt4555WVQ685R7OVVCIAL1yTyaO8QFG0cl1d9bhPoOA
         V3m2EEHDzWYVVXQytk1+03o7VF+8LnEMmvl1bhXqSqbBeKe7ZFppLRpfi0vPfcY1j/nW
         6P7SU1IfPOIh5JsgOa0flM2GFEkc1meEQUHKqbUosQniG2aunKcV1OETBF5H4xSnGabE
         rPsY2BnbKn3kGcWNmrgr/w4QpW50GP1uW8o7W5sGCSMm9ac7AqkfK/NFJpZtqg17N5t1
         DqpwSvAthdvK9yPo56bKPWgvS7CJghRYAXE3/jrL0KnwErCvdOWyVnckCKn0BiWy8bJv
         bekw==
X-Gm-Message-State: AOPr4FVGObpbmi6N5dBjOwFwayA/Fr3iJn8CbKhro1Xiym4BHQ2ixw5gir6EAKEs6rUQT1nL
X-Received: by 10.66.237.66 with SMTP id va2mr18210061pac.2.1463098786556;
        Thu, 12 May 2016 17:19:46 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:c9fc:8b37:8cb7:4400])
        by smtp.gmail.com with ESMTPSA id k65sm22488407pfj.31.2016.05.12.17.19.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 12 May 2016 17:19:45 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.400.g8bfb85c.dirty
In-Reply-To: <20160513001936.7623-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294496>

Labels were originally designed to manage large amount of
submodules, the discussion steered this in a more general
direction, such that other files can be labeled as well.

Labels are meant to describe arbitrary set of files, which
is not described via the tree layout.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/glossary-content.txt |  5 +++
 attr.h                             |  1 +
 dir.c                              | 31 +++++++++++++
 pathspec.c                         | 24 +++++++++-
 pathspec.h                         |  1 +
 t/t6134-pathspec-with-labels.sh    | 91 ++++++++++++++++++++++++++++++++++++++
 6 files changed, 152 insertions(+), 1 deletion(-)
 create mode 100755 t/t6134-pathspec-with-labels.sh

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index 8ad29e6..a1fc9e0 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -362,6 +362,11 @@ glob;;
 	For example, "Documentation/{asterisk}.html" matches
 	"Documentation/git.html" but not "Documentation/ppc/ppc.html"
 	or "tools/perf/Documentation/perf.html".
+
+label:<white space separated list>;;
+	Labels can be assigned to pathspecs in the .gitattributes file.
+	By specifying a list of labels the pattern will match only
+	files which have all of the listed labels.
 +
 Two consecutive asterisks ("`**`") in patterns matched against
 full pathname may have special meaning:
diff --git a/attr.h b/attr.h
index 8b08d33..f6fc7c3 100644
--- a/attr.h
+++ b/attr.h
@@ -18,6 +18,7 @@ extern const char git_attr__false[];
 #define ATTR_TRUE(v) ((v) == git_attr__true)
 #define ATTR_FALSE(v) ((v) == git_attr__false)
 #define ATTR_UNSET(v) ((v) == NULL)
+#define ATTR_CUSTOM(v) (!(ATTR_UNSET(v) || ATTR_FALSE(v) || ATTR_TRUE(v)))
 
 /*
  * Send one or more git_attr_check to git_check_attr(), and
diff --git a/dir.c b/dir.c
index 656f272..51d5965 100644
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
@@ -208,6 +209,27 @@ int within_depth(const char *name, int namelen,
 	return 1;
 }
 
+void load_labels(const char *name, int namelen, struct string_list *list)
+{
+	static struct git_attr *attr;
+	struct git_attr_check check;
+	char *path = xmemdupz(name, namelen);
+
+	if (!attr)
+		attr = git_attr("label");
+	check.attr = attr;
+
+	if (git_check_attr(path, 1, &check))
+		die("git_check_attr died");
+
+	if (ATTR_CUSTOM(check.value)) {
+		string_list_split(list, check.value, ',', -1);
+		string_list_sort(list);
+	}
+
+	free(path);
+}
+
 #define DO_MATCH_EXCLUDE   1
 #define DO_MATCH_DIRECTORY 2
 
@@ -263,6 +285,15 @@ static int match_pathspec_item(const struct pathspec_item *item, int prefix,
 	    strncmp(item->match, name - prefix, item->prefix))
 		return 0;
 
+	if (item->group) {
+		struct string_list has_labels = STRING_LIST_INIT_DUP;
+		struct string_list_item *si;
+		load_labels(name, namelen, &has_labels);
+		for_each_string_list_item(si, item->group)
+			if (!string_list_has_string(&has_labels, si->string))
+				return 0;
+	}
+
 	/* If the match was just the prefix, we matched */
 	if (!*match)
 		return MATCHED_RECURSIVELY;
diff --git a/pathspec.c b/pathspec.c
index 4dff252..c227c25 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -94,6 +94,7 @@ static void eat_long_magic(struct pathspec_item *item, const char *elt,
 {
 	int i;
 	const char *copyfrom = *copyfrom_;
+	const char *out;
 	/* longhand */
 	const char *nextat;
 	for (copyfrom = elt + 2;
@@ -117,6 +118,20 @@ static void eat_long_magic(struct pathspec_item *item, const char *elt,
 			continue;
 		}
 
+		if (skip_prefix(copyfrom, "label:", &out)) {
+			struct strbuf sb = STRBUF_INIT;
+			size_t l = nextat - out;
+			strbuf_add(&sb, out, l);
+			if (!item->group) {
+				item->group = xmalloc(sizeof(*item->group));
+				string_list_init(item->group, 1);
+			}
+			string_list_split(item->group, sb.buf, ' ', -1);
+			string_list_remove_empty_items(item->group, 0);
+			strbuf_release(&sb);
+			continue;
+		}
+
 		for (i = 0; i < ARRAY_SIZE(pathspec_magic); i++) {
 			if (strlen(pathspec_magic[i].name) == len &&
 			    !strncmp(pathspec_magic[i].name, copyfrom, len)) {
@@ -425,7 +440,7 @@ void parse_pathspec(struct pathspec *pathspec,
 	for (i = 0; i < n; i++) {
 		unsigned short_magic;
 		entry = argv[i];
-
+		item[i].group = NULL;
 		item[i].magic = prefix_pathspec(item + i, &short_magic,
 						argv + i, flags,
 						prefix, prefixlen, entry);
@@ -502,6 +517,13 @@ void copy_pathspec(struct pathspec *dst, const struct pathspec *src)
 
 void free_pathspec(struct pathspec *pathspec)
 {
+	int i;
+	for (i = 0; i < pathspec->nr; i++) {
+		if (pathspec->items[i].group)
+			string_list_clear(pathspec->items[i].group, 1);
+		free(pathspec->items[i].group);
+	}
+
 	free(pathspec->items);
 	pathspec->items = NULL;
 }
diff --git a/pathspec.h b/pathspec.h
index 0c11262..e3f7ebf 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -32,6 +32,7 @@ struct pathspec {
 		int len, prefix;
 		int nowildcard_len;
 		int flags;
+		struct string_list *group;
 	} *items;
 };
 
diff --git a/t/t6134-pathspec-with-labels.sh b/t/t6134-pathspec-with-labels.sh
new file mode 100755
index 0000000..0c061ce
--- /dev/null
+++ b/t/t6134-pathspec-with-labels.sh
@@ -0,0 +1,91 @@
+#!/bin/sh
+
+test_description='test labels in pathspecs'
+. ./test-lib.sh
+
+test_expect_success 'setup a tree' '
+	for p in file sub/file sub/sub/file sub/file2 sub/sub/sub/file sub2/file; do
+		if echo $p | grep /; then
+			mkdir -p $(dirname $p)
+		fi &&
+		: >$p &&
+		git add $p &&
+		git commit -m $p
+	done &&
+	git log --oneline --format=%s >actual &&
+	cat <<EOF >expect &&
+sub2/file
+sub/sub/sub/file
+sub/file2
+sub/sub/file
+sub/file
+file
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'pathspec with labels and no .gitattributes exists' '
+	git ls-files ":(label:a)" >actual &&
+	test_must_be_empty actual
+'
+
+test_expect_success 'setup .gitattributes' '
+	cat <<-EOF >.gitattributes &&
+	/file label=b
+	sub/file label=a
+	sub/sub/* label=b,c
+	EOF
+	git add .gitattributes &&
+	git commit -m "add attributes"
+'
+
+test_expect_success 'check label' '
+	cat <<-EOF >expect &&
+	sub/file
+	EOF
+	git ls-files ":(label:a)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'check label from label list' '
+	cat <<-EOF >expect &&
+	sub/sub/file
+	EOF
+	git ls-files ":(label:c)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'check label with more labels' '
+	cat <<-EOF >expect &&
+	file
+	sub/sub/file
+	EOF
+	git ls-files ":(label:b)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'check label with more labels but excluded path' '
+	cat <<-EOF >expect &&
+	sub/sub/file
+	EOF
+	git ls-files ":(label:b)" ":(exclude)./file" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'check label specifying more labels' '
+	cat <<-EOF >expect &&
+	sub/sub/file
+	EOF
+	git ls-files ":(label:b c)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'check label specifying more labels' '
+	cat <<-EOF >expect &&
+	sub/file
+	sub/sub/file
+	EOF
+	git ls-files ":(label:b c)" ":(label:a)" >actual &&
+	test_cmp expect actual
+'
+test_done
-- 
2.8.2.400.g66c4903.dirty
