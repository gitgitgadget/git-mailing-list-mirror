Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56C9E1FC43
	for <e@80x24.org>; Mon, 13 Mar 2017 18:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752062AbdCMSXd (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 14:23:33 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:36170 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751102AbdCMSXa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 14:23:30 -0400
Received: by mail-pg0-f41.google.com with SMTP id g2so49557978pge.3
        for <git@vger.kernel.org>; Mon, 13 Mar 2017 11:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p5hQwspilu5RTmJs8QXe07s+j28G4Hr6onqFKalSezY=;
        b=Iu/Z2GqXq9qmLJkuXk3gL7jlROKIvWrbJu+pxgTd5Vfsg0r//ybSgX533fwuLOX4IP
         +l1nXUqgrQAlpa+xRyBDgPCVGBh4aSAqkxpcmCzQ/YnbqXvrbFs1O5RLcTfVg4h/EI5J
         /jnmZPD9z4QRe7ixxLH/fO2JzQVOElkMEs4IwelkSJQYStWxGhy+MccQ7+7FtZ1rDKB3
         bBXoZMSDz0SB9y98Xl7GmK3aqbVdWONzB6VtFB9K7M5tZmD+MTPihazpM6YpAAMNciM2
         tbqy4vECjTS5zC50O+YDqREpOH+WsZbtxKkYtTuqoH9tC8iHkYBzGwcVeBAkD4+UZEgE
         qfmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p5hQwspilu5RTmJs8QXe07s+j28G4Hr6onqFKalSezY=;
        b=sKMMNEAmjyV8njqsQOFTmX1xsMdiLeTfBBmHb7SvNgJc6ZX9rgxZr0tGBnLcFTNdjP
         f0ObKxP3NjTUPivf/vQaBy1Pu/DJcr/uC6Z7Zs4lHOTEn2D4lrYjNbCavn1ytdKEumIb
         ppkuftse5Ej3SaFY8myrpKhfppSogP7WWGBurxPmvW7KDnNXtgEwqgq4H0pJfhtBDGsv
         dZxot3F6kxlk2KqSgMyLb2tavWDkd2SeS3K2HLN27+ZQBm9gnRImG1xfSvrWLOzboSjt
         g/JmHedEKd9ik46xpFTeuyBnt85kEkhAER0WpIPwx9Nrj8BRYQlpI5L3cwg2nFfAAQYE
         zqMA==
X-Gm-Message-State: AMke39ndMIpfwfnttPavGrM3LksixDPcoacSLjCSYRDCEq+2g7FXfZN3j502t5iFOjJLBnyo
X-Received: by 10.99.112.75 with SMTP id a11mr38016158pgn.7.1489429408683;
        Mon, 13 Mar 2017 11:23:28 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id z4sm22875320pge.49.2017.03.13.11.23.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Mar 2017 11:23:27 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        pclouds@gmail.com, jonathantanmy@google.com
Subject: [PATCH v3 1/2] pathspec: allow querying for attributes
Date:   Mon, 13 Mar 2017 11:23:21 -0700
Message-Id: <20170313182322.27539-2-bmwill@google.com>
X-Mailer: git-send-email 2.12.0.246.ga2ecc84866-goog
In-Reply-To: <20170313182322.27539-1-bmwill@google.com>
References: <20170310185908.171589-1-bmwill@google.com>
 <20170313182322.27539-1-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The pathspec mechanism is extended via the new
":(attr:eol=input)pattern/to/match" syntax to filter paths so that it
requires paths to not just match the given pattern but also have the
specified attrs attached for them to be chosen.

Based on a patch by Stefan Beller <sbeller@google.com>
Signed-off-by: Brandon Williams <bmwill@google.com>
---
 Documentation/glossary-content.txt |  21 +++++
 attr.c                             |  17 ++++
 attr.h                             |   1 +
 dir.c                              |  43 ++++++++-
 pathspec.c                         | 113 ++++++++++++++++++++++-
 pathspec.h                         |  15 ++-
 t/t6135-pathspec-with-attrs.sh     | 181 +++++++++++++++++++++++++++++++++++++
 7 files changed, 382 insertions(+), 9 deletions(-)
 create mode 100755 t/t6135-pathspec-with-attrs.sh

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index fc9320e59..6e991c246 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -384,6 +384,27 @@ full pathname may have special meaning:
 +
 Glob magic is incompatible with literal magic.
 
+attr;;
+After `attr:` comes a space separated list of "attribute
+requirements", all of which must be met in order for the
+path to be considered a match; this is in addition to the
+usual non-magic pathspec pattern matching.
+See linkgit:gitattributes[5].
++
+Each of the attribute requirements for the path takes one of
+these forms:
+
+- "`ATTR`" requires that the attribute `ATTR` be set.
+
+- "`-ATTR`" requires that the attribute `ATTR` be unset.
+
+- "`ATTR=VALUE`" requires that the attribute `ATTR` be
+  set to the string `VALUE`.
+
+- "`!ATTR`" requires that the attribute `ATTR` be
+  unspecified.
++
+
 exclude;;
 	After a path matches any non-exclude pathspec, it will be run
 	through all exclude pathspec (magic signature: `!` or its
diff --git a/attr.c b/attr.c
index 5493bff22..7e2134471 100644
--- a/attr.c
+++ b/attr.c
@@ -603,6 +603,23 @@ struct attr_check *attr_check_initl(const char *one, ...)
 	return check;
 }
 
+struct attr_check *attr_check_dup(const struct attr_check *check)
+{
+	struct attr_check *ret;
+
+	if (!check)
+		return NULL;
+
+	ret = attr_check_alloc();
+
+	ret->nr = check->nr;
+	ret->alloc = check->alloc;
+	ALLOC_ARRAY(ret->items, ret->nr);
+	COPY_ARRAY(ret->items, check->items, ret->nr);
+
+	return ret;
+}
+
 struct attr_check_item *attr_check_append(struct attr_check *check,
 					  const struct git_attr *attr)
 {
diff --git a/attr.h b/attr.h
index 48ab3e1c2..442d464db 100644
--- a/attr.h
+++ b/attr.h
@@ -44,6 +44,7 @@ struct attr_check {
 
 extern struct attr_check *attr_check_alloc(void);
 extern struct attr_check *attr_check_initl(const char *, ...);
+extern struct attr_check *attr_check_dup(const struct attr_check *check);
 
 extern struct attr_check_item *attr_check_append(struct attr_check *check,
 						 const struct git_attr *attr);
diff --git a/dir.c b/dir.c
index 4541f9e14..2fe7acbcf 100644
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
@@ -134,7 +135,8 @@ static size_t common_prefix_len(const struct pathspec *pathspec)
 		       PATHSPEC_LITERAL |
 		       PATHSPEC_GLOB |
 		       PATHSPEC_ICASE |
-		       PATHSPEC_EXCLUDE);
+		       PATHSPEC_EXCLUDE |
+		       PATHSPEC_ATTR);
 
 	for (n = 0; n < pathspec->nr; n++) {
 		size_t i = 0, len = 0, item_len;
@@ -209,6 +211,36 @@ int within_depth(const char *name, int namelen,
 #define DO_MATCH_DIRECTORY (1<<1)
 #define DO_MATCH_SUBMODULE (1<<2)
 
+static int match_attrs(const char *name, int namelen,
+		       const struct pathspec_item *item)
+{
+	int i;
+
+	git_check_attr(name, item->attr_check);
+	for (i = 0; i < item->attr_match_nr; i++) {
+		const char *value;
+		int matched;
+		enum attr_match_mode match_mode;
+
+		value = item->attr_check->items[i].value;
+		match_mode = item->attr_match[i].match_mode;
+
+		if (ATTR_TRUE(value))
+			matched = (match_mode == MATCH_SET);
+		else if (ATTR_FALSE(value))
+			matched = (match_mode == MATCH_UNSET);
+		else if (ATTR_UNSET(value))
+			matched = (match_mode == MATCH_UNSPECIFIED);
+		else
+			matched = (match_mode == MATCH_VALUE &&
+				   !strcmp(item->attr_match[i].value, value));
+		if (!matched)
+			return 0;
+	}
+
+	return 1;
+}
+
 /*
  * Does 'match' match the given name?
  * A match is found if
@@ -261,6 +293,9 @@ static int match_pathspec_item(const struct pathspec_item *item, int prefix,
 	    strncmp(item->match, name - prefix, item->prefix))
 		return 0;
 
+	if (item->attr_match_nr && !match_attrs(name, namelen, item))
+		return 0;
+
 	/* If the match was just the prefix, we matched */
 	if (!*match)
 		return MATCHED_RECURSIVELY;
@@ -339,7 +374,8 @@ static int do_match_pathspec(const struct pathspec *ps,
 		       PATHSPEC_LITERAL |
 		       PATHSPEC_GLOB |
 		       PATHSPEC_ICASE |
-		       PATHSPEC_EXCLUDE);
+		       PATHSPEC_EXCLUDE |
+		       PATHSPEC_ATTR);
 
 	if (!ps->nr) {
 		if (!ps->recursive ||
@@ -1361,7 +1397,8 @@ static int simplify_away(const char *path, int pathlen,
 		       PATHSPEC_LITERAL |
 		       PATHSPEC_GLOB |
 		       PATHSPEC_ICASE |
-		       PATHSPEC_EXCLUDE);
+		       PATHSPEC_EXCLUDE |
+		       PATHSPEC_ATTR);
 
 	for (i = 0; i < pathspec->nr; i++) {
 		const struct pathspec_item *item = &pathspec->items[i];
diff --git a/pathspec.c b/pathspec.c
index b961f00c8..608511c52 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "dir.h"
 #include "pathspec.h"
+#include "attr.h"
 
 /*
  * Finds which of the given pathspecs match items in the index.
@@ -72,6 +73,7 @@ static struct pathspec_magic {
 	{ PATHSPEC_GLOB,    '\0', "glob" },
 	{ PATHSPEC_ICASE,   '\0', "icase" },
 	{ PATHSPEC_EXCLUDE,  '!', "exclude" },
+	{ PATHSPEC_ATTR,    '\0', "attr" },
 };
 
 static void prefix_magic(struct strbuf *sb, int prefixlen, unsigned magic)
@@ -87,6 +89,72 @@ static void prefix_magic(struct strbuf *sb, int prefixlen, unsigned magic)
 	strbuf_addf(sb, ",prefix:%d)", prefixlen);
 }
 
+static void parse_pathspec_attr_match(struct pathspec_item *item, const char *value)
+{
+	struct string_list_item *si;
+	struct string_list list = STRING_LIST_INIT_DUP;
+
+	if (item->attr_check || item->attr_match)
+		die(_("Only one 'attr:' specification is allowed."));
+
+	if (!value || !*value)
+		die(_("attr spec must not be empty"));
+
+	string_list_split(&list, value, ' ', -1);
+	string_list_remove_empty_items(&list, 0);
+
+	item->attr_check = attr_check_alloc();
+	item->attr_match = xcalloc(list.nr, sizeof(struct attr_match));
+
+	for_each_string_list_item(si, &list) {
+		size_t attr_len;
+		char *attr_name;
+		const struct git_attr *a;
+
+		int j = item->attr_match_nr++;
+		const char *attr = si->string;
+		struct attr_match *am = &item->attr_match[j];
+
+		switch (*attr) {
+		case '!':
+			am->match_mode = MATCH_UNSPECIFIED;
+			attr++;
+			attr_len = strlen(attr);
+			break;
+		case '-':
+			am->match_mode = MATCH_UNSET;
+			attr++;
+			attr_len = strlen(attr);
+			break;
+		default:
+			attr_len = strcspn(attr, "=");
+			if (attr[attr_len] != '=')
+				am->match_mode = MATCH_SET;
+			else {
+				am->match_mode = MATCH_VALUE;
+				am->value = xstrdup(&attr[attr_len + 1]);
+				if (strchr(am->value, '\\'))
+					die(_("attr spec values must not contain backslashes"));
+			}
+			break;
+		}
+
+		attr_name = xmemdupz(attr, attr_len);
+		a = git_attr(attr_name);
+		if (!a)
+			die(_("invalid attribute name %s"), attr_name);
+
+		attr_check_append(item->attr_check, a);
+
+		free(attr_name);
+	}
+
+	if (item->attr_check->nr != item->attr_match_nr)
+		die("BUG: should have same number of entries");
+
+	string_list_clear(&list, 0);
+}
+
 static inline int get_literal_global(void)
 {
 	static int literal = -1;
@@ -164,6 +232,7 @@ static int get_global_magic(int element_magic)
  * returns the position in 'elem' after all magic has been parsed
  */
 static const char *parse_long_magic(unsigned *magic, int *prefix_len,
+				    struct pathspec_item *item,
 				    const char *elem)
 {
 	const char *pos;
@@ -189,6 +258,14 @@ static const char *parse_long_magic(unsigned *magic, int *prefix_len,
 			continue;
 		}
 
+		if (starts_with(pos, "attr:")) {
+			char *attr_body = xmemdupz(pos + 5, len - 5);
+			parse_pathspec_attr_match(item, attr_body);
+			*magic |= PATHSPEC_ATTR;
+			free(attr_body);
+			continue;
+		}
+
 		for (i = 0; i < ARRAY_SIZE(pathspec_magic); i++) {
 			if (strlen(pathspec_magic[i].name) == len &&
 			    !strncmp(pathspec_magic[i].name, pos, len)) {
@@ -252,13 +329,14 @@ static const char *parse_short_magic(unsigned *magic, const char *elem)
 }
 
 static const char *parse_element_magic(unsigned *magic, int *prefix_len,
+				       struct pathspec_item *item,
 				       const char *elem)
 {
 	if (elem[0] != ':' || get_literal_global())
 		return elem; /* nothing to do */
 	else if (elem[1] == '(')
 		/* longhand */
-		return parse_long_magic(magic, prefix_len, elem);
+		return parse_long_magic(magic, prefix_len, item, elem);
 	else
 		/* shorthand */
 		return parse_short_magic(magic, elem);
@@ -335,12 +413,17 @@ static void init_pathspec_item(struct pathspec_item *item, unsigned flags,
 	char *match;
 	int pathspec_prefix = -1;
 
+	item->attr_check = NULL;
+	item->attr_match = NULL;
+	item->attr_match_nr = 0;
+
 	/* PATHSPEC_LITERAL_PATH ignores magic */
 	if (flags & PATHSPEC_LITERAL_PATH) {
 		magic = PATHSPEC_LITERAL;
 	} else {
 		copyfrom = parse_element_magic(&element_magic,
 					       &pathspec_prefix,
+					       item,
 					       elt);
 		magic |= element_magic;
 		magic |= get_global_magic(element_magic);
@@ -565,26 +648,46 @@ void parse_pathspec(struct pathspec *pathspec,
 
 void copy_pathspec(struct pathspec *dst, const struct pathspec *src)
 {
-	int i;
+	int i, j;
 
 	*dst = *src;
 	ALLOC_ARRAY(dst->items, dst->nr);
 	COPY_ARRAY(dst->items, src->items, dst->nr);
 
 	for (i = 0; i < dst->nr; i++) {
-		dst->items[i].match = xstrdup(src->items[i].match);
-		dst->items[i].original = xstrdup(src->items[i].original);
+		struct pathspec_item *d = &dst->items[i];
+		struct pathspec_item *s = &src->items[i];
+
+		d->match = xstrdup(s->match);
+		d->original = xstrdup(s->original);
+
+		ALLOC_ARRAY(d->attr_match, d->attr_match_nr);
+		COPY_ARRAY(d->attr_match, s->attr_match, d->attr_match_nr);
+		for (j = 0; j < d->attr_match_nr; j++) {
+			const char *value = s->attr_match[j].value;
+			d->attr_match[j].value = xstrdup_or_null(value);
+		}
+
+		d->attr_check = attr_check_dup(s->attr_check);
 	}
 }
 
 void clear_pathspec(struct pathspec *pathspec)
 {
-	int i;
+	int i, j;
 
 	for (i = 0; i < pathspec->nr; i++) {
 		free(pathspec->items[i].match);
 		free(pathspec->items[i].original);
+
+		for (j = 0; j < pathspec->items[j].attr_match_nr; j++)
+			free(pathspec->items[i].attr_match[j].value);
+		free(pathspec->items[i].attr_match);
+
+		if (pathspec->items[i].attr_check)
+			attr_check_free(pathspec->items[i].attr_check);
 	}
+
 	free(pathspec->items);
 	pathspec->items = NULL;
 	pathspec->nr = 0;
diff --git a/pathspec.h b/pathspec.h
index 49fd823dd..55e976972 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -8,13 +8,15 @@
 #define PATHSPEC_GLOB		(1<<3)
 #define PATHSPEC_ICASE		(1<<4)
 #define PATHSPEC_EXCLUDE	(1<<5)
+#define PATHSPEC_ATTR		(1<<6)
 #define PATHSPEC_ALL_MAGIC	  \
 	(PATHSPEC_FROMTOP	| \
 	 PATHSPEC_MAXDEPTH	| \
 	 PATHSPEC_LITERAL	| \
 	 PATHSPEC_GLOB		| \
 	 PATHSPEC_ICASE		| \
-	 PATHSPEC_EXCLUDE)
+	 PATHSPEC_EXCLUDE	| \
+	 PATHSPEC_ATTR)
 
 #define PATHSPEC_ONESTAR 1	/* the pathspec pattern satisfies GFNM_ONESTAR */
 
@@ -31,6 +33,17 @@ struct pathspec {
 		int len, prefix;
 		int nowildcard_len;
 		int flags;
+		int attr_match_nr;
+		struct attr_match {
+			char *value;
+			enum attr_match_mode {
+				MATCH_SET,
+				MATCH_UNSET,
+				MATCH_VALUE,
+				MATCH_UNSPECIFIED
+			} match_mode;
+		} *attr_match;
+		struct attr_check *attr_check;
 	} *items;
 };
 
diff --git a/t/t6135-pathspec-with-attrs.sh b/t/t6135-pathspec-with-attrs.sh
new file mode 100755
index 000000000..3f06fcf8d
--- /dev/null
+++ b/t/t6135-pathspec-with-attrs.sh
@@ -0,0 +1,181 @@
+#!/bin/sh
+
+test_description='test labels in pathspecs'
+. ./test-lib.sh
+
+test_expect_success 'setup a tree' '
+	cat <<-\EOF >expect &&
+	fileA
+	fileAB
+	fileAC
+	fileB
+	fileBC
+	fileC
+	fileNoLabel
+	fileSetLabel
+	fileUnsetLabel
+	fileValue
+	fileWrongLabel
+	sub/fileA
+	sub/fileAB
+	sub/fileAC
+	sub/fileB
+	sub/fileBC
+	sub/fileC
+	sub/fileNoLabel
+	sub/fileSetLabel
+	sub/fileUnsetLabel
+	sub/fileValue
+	sub/fileWrongLabel
+	EOF
+	mkdir sub &&
+	while read path
+	do
+		: >$path &&
+		git add $path || return 1
+	done <expect &&
+	git commit -m "initial commit" &&
+	git ls-files >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'pathspec with no attr' '
+	test_must_fail git ls-files ":(attr:)"
+'
+
+test_expect_success 'pathspec with labels and non existent .gitattributes' '
+	git ls-files ":(attr:label)" >actual &&
+	test_must_be_empty actual
+'
+
+test_expect_success 'setup .gitattributes' '
+	cat <<-\EOF >.gitattributes &&
+	fileA labelA
+	fileB labelB
+	fileC labelC
+	fileAB labelA labelB
+	fileAC labelA labelC
+	fileBC labelB labelC
+	fileUnsetLabel -label
+	fileSetLabel label
+	fileValue label=foo
+	fileWrongLabel label☺
+	EOF
+	git add .gitattributes &&
+	git commit -m "add attributes"
+'
+
+test_expect_success 'check specific set attr' '
+	cat <<-\EOF >expect &&
+	fileSetLabel
+	sub/fileSetLabel
+	EOF
+	git ls-files ":(attr:label)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'check specific unset attr' '
+	cat <<-\EOF >expect &&
+	fileUnsetLabel
+	sub/fileUnsetLabel
+	EOF
+	git ls-files ":(attr:-label)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'check specific value attr' '
+	cat <<-\EOF >expect &&
+	fileValue
+	sub/fileValue
+	EOF
+	git ls-files ":(attr:label=foo)" >actual &&
+	test_cmp expect actual &&
+	git ls-files ":(attr:label=bar)" >actual &&
+	test_must_be_empty actual
+'
+
+test_expect_success 'check unspecified attr' '
+	cat <<-\EOF >expect &&
+	.gitattributes
+	fileA
+	fileAB
+	fileAC
+	fileB
+	fileBC
+	fileC
+	fileNoLabel
+	fileWrongLabel
+	sub/fileA
+	sub/fileAB
+	sub/fileAC
+	sub/fileB
+	sub/fileBC
+	sub/fileC
+	sub/fileNoLabel
+	sub/fileWrongLabel
+	EOF
+	git ls-files ":(attr:!label)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'check multiple unspecified attr' '
+	cat <<-\EOF >expect &&
+	.gitattributes
+	fileC
+	fileNoLabel
+	fileWrongLabel
+	sub/fileC
+	sub/fileNoLabel
+	sub/fileWrongLabel
+	EOF
+	git ls-files ":(attr:!labelB !labelA !label)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'check label with more labels but excluded path' '
+	cat <<-\EOF >expect &&
+	fileAB
+	fileB
+	fileBC
+	EOF
+	git ls-files ":(attr:labelB)" ":(exclude)sub/" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'check label excluding other labels' '
+	cat <<-\EOF >expect &&
+	fileAB
+	fileB
+	fileBC
+	sub/fileAB
+	sub/fileB
+	EOF
+	git ls-files ":(attr:labelB)" ":(exclude,attr:labelC)sub/" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'fail on multiple attr specifiers in one pathspec item' '
+	test_must_fail git ls-files . ":(attr:labelB,attr:labelC)" 2>actual &&
+	test_i18ngrep "Only one" actual
+'
+
+test_expect_success 'fail if attr magic is used places not implemented' '
+	# The main purpose of this test is to check that we actually fail
+	# when you attempt to use attr magic in commands that do not implement
+	# attr magic. This test does not advocate git-add to stay that way,
+	# though, but git-add is convenient as it has its own internal pathspec
+	# parsing.
+	test_must_fail git add ":(attr:labelB)" 2>actual &&
+	test_i18ngrep "unsupported magic" actual
+'
+
+test_expect_success 'abort on giving invalid label on the command line' '
+	test_must_fail git ls-files . ":(attr:☺)"
+'
+
+test_expect_success 'abort on asking for wrong magic' '
+	test_must_fail git ls-files . ":(attr:-label=foo)" &&
+	test_must_fail git ls-files . ":(attr:!label=foo)"
+'
+
+test_done
-- 
2.12.0.246.ga2ecc84866-goog

