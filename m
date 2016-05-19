From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv9 4/4] pathspec: allow querying for attributes
Date: Thu, 19 May 2016 16:23:23 -0700
Message-ID: <20160519232323.12775-5-sbeller@google.com>
References: <20160519232323.12775-1-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Fri May 20 01:23:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3XID-0005uF-2D
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 01:23:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755241AbcESXXh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 May 2016 19:23:37 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:34512 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753824AbcESXXf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2016 19:23:35 -0400
Received: by mail-pa0-f41.google.com with SMTP id qo8so33639067pab.1
        for <git@vger.kernel.org>; Thu, 19 May 2016 16:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4Oe5z824GDJDuoEnN5HOTn2xhUKZwzuPveWzh1298eE=;
        b=eEiMMtcnNKJc4/SaR9PC8GEGyi7a8CcPKlSWcrQN9INQvECgnT23Jw/ce00BTdaiZM
         3Y5ZSZcCcIe/z0UpZaxllTGr+4/6nNwUlPVcDjlPSkKwdDXZKJed6rL8DgdAazRFoV8W
         2UUtfaGcYgMilTIRmQIl219ym9xask2xelA0Wi/5STiBwPJ2FSZBXKwF9lJey/IabVdy
         OXNN4wxULLPlMnWVs0rCK3D3ne85L+4YwG1X4ZVoxrIpwmt2j3/zRXGcTbUBbb7jidJ6
         rFnuPM6NCLEyI8+rdkoLh6f8pHb8Zn4QA6ZOsVM0XF4SkyK05nWB3Rfp4+yaRB22MtfO
         9BZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4Oe5z824GDJDuoEnN5HOTn2xhUKZwzuPveWzh1298eE=;
        b=CO99OqW7amVH5THJPxMZac1edH97G0leDRUQWhk0t1S9xcRkE5GDmW534CVW9vMnOi
         cfLdOKjYHmbOPxYFAGzhajdCSG2KGu/ju77ug0xqv6uvaNdbpmTaNn3QHgzJ+xfoq7wI
         abefcg2w/QaNGmNZnpjHwnTT7yEXogDegYgByqqyC3MxeRU481gc1Ka0jM4QWhmHIHaC
         Z2Ntmd1DGopblOjO6MArdDyjoSuacEnK9Hq2B8KGIDYIcbkaOprGbuCP/Df7KQvCDk7T
         txWX9bUmkLigys6sKO8tPz6GUD8o/fq9KFlK+NtKNXjkQRorCIXvZjNN1NDY9UmDgJ0p
         7jIQ==
X-Gm-Message-State: AOPr4FVfU5bvI07Fnuq3THPsah4C+2Frf5Api2e9S6CqelSCtOBK0NwSmoV3CnPYcVj9YfD8
X-Received: by 10.66.6.98 with SMTP id z2mr23486969paz.95.1463700214561;
        Thu, 19 May 2016 16:23:34 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:acf4:8121:b728:8fc4])
        by smtp.gmail.com with ESMTPSA id o2sm22253403pfi.85.2016.05.19.16.23.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 19 May 2016 16:23:33 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.123.gb4ad9b6.dirty
In-Reply-To: <20160519232323.12775-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295132>

The pathspec mechanism is extended via the new
":(attr:eol=3Dinput)pattern/to/match" syntax to filter paths so that it
requires paths to not just match the given pattern but also have the
specified attrs attached for them to be chosen.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/glossary-content.txt |  20 +++++
 dir.c                              |  35 ++++++++
 pathspec.c                         | 101 ++++++++++++++++++++++-
 pathspec.h                         |  16 ++++
 t/t6134-pathspec-with-labels.sh    | 163 +++++++++++++++++++++++++++++=
++++++++
 5 files changed, 331 insertions(+), 4 deletions(-)
 create mode 100755 t/t6134-pathspec-with-labels.sh

diff --git a/Documentation/glossary-content.txt b/Documentation/glossar=
y-content.txt
index cafc284..e06520b 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -384,6 +384,26 @@ full pathname may have special meaning:
 +
 Glob magic is incompatible with literal magic.
=20
+attr;;
+After `attr:` comes a space separated list of "attribute
+requirements", all of which must be met in order for the
+path to be considered a match; this is in addition to the
+usual non-magic pathspec pattern matching.
+
+Each of the attribute requirements for the path takes one of
+these forms:
+
+- "`ATTR`" requires that the attribute `ATTR` must be set.
+
+- "`-ATTR`" requires that the attribute `ATTR` must be unset.
+
+- "`ATTR=3DVALUE`" requires that the attribute `ATTR` must be
+  set to the string `VALUE`.
+
+- "`!ATTR`" requires that the attribute `ATTR` must be
+  unspecified.
++
+
 exclude;;
 	After a path matches any non-exclude pathspec, it will be run
 	through all exclude pathspec (magic signature: `!`). If it
diff --git a/dir.c b/dir.c
index 996653b..fc071af 100644
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
@@ -215,6 +216,37 @@ int within_depth(const char *name, int namelen,
 	return 1;
 }
=20
+static int match_attrs(const char *name, int namelen,
+		       const struct pathspec_item *item)
+{
+	int i;
+
+	git_check_attr_counted(name, namelen, item->attr_check);
+	for (i =3D 0; i < item->attr_match_nr; i++) {
+		const char *value;
+		int matched;
+		enum attr_match_mode match_mode;
+
+		value =3D item->attr_check->check[i].value;
+		match_mode =3D item->attr_match[i].match_mode;
+
+		if (ATTR_TRUE(value))
+			matched =3D (match_mode =3D=3D MATCH_SET);
+		else if (ATTR_FALSE(value))
+			matched =3D (match_mode =3D=3D MATCH_UNSET);
+		else if (ATTR_UNSET(value))
+			matched =3D (match_mode =3D=3D MATCH_UNSPECIFIED);
+		else
+			matched =3D (match_mode =3D=3D MATCH_VALUE &&
+				   !strcmp(item->attr_match[i].value, value));
+
+		if (!matched)
+			return 0;
+	}
+
+	return 1;
+}
+
 #define DO_MATCH_EXCLUDE   1
 #define DO_MATCH_DIRECTORY 2
=20
@@ -270,6 +302,9 @@ static int match_pathspec_item(const struct pathspe=
c_item *item, int prefix,
 	    strncmp(item->match, name - prefix, item->prefix))
 		return 0;
=20
+	if (item->attr_match_nr && !match_attrs(name, namelen, item))
+		return 0;
+
 	/* If the match was just the prefix, we matched */
 	if (!*match)
 		return MATCHED_RECURSIVELY;
diff --git a/pathspec.c b/pathspec.c
index 4dff252..693a5e7 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "dir.h"
 #include "pathspec.h"
+#include "attr.h"
=20
 /*
  * Finds which of the given pathspecs match items in the index.
@@ -88,12 +89,78 @@ static void prefix_short_magic(struct strbuf *sb, i=
nt prefixlen,
 	strbuf_addf(sb, ",prefix:%d)", prefixlen);
 }
=20
+static void parse_pathspec_attr_match(struct pathspec_item *item, cons=
t char *value)
+{
+	struct string_list_item *si;
+	struct string_list list =3D STRING_LIST_INIT_DUP;
+
+
+	if (!value || !strlen(value))
+		die(_("attr spec must not be empty"));
+
+	string_list_split(&list, value, ' ', -1);
+	string_list_remove_empty_items(&list, 0);
+
+	if (!item->attr_check)
+		item->attr_check =3D git_attr_check_alloc();
+	else
+		die(_("Only one 'attr:' specification is allowed."));
+
+	ALLOC_GROW(item->attr_match, item->attr_match_nr + list.nr, item->att=
r_match_alloc);
+
+	for_each_string_list_item(si, &list) {
+		size_t attr_len;
+
+		int j =3D item->attr_match_nr++;
+		const char *attr =3D si->string;
+		struct attr_match *am =3D &item->attr_match[j];
+
+		attr_len =3D strcspn(attr, "=3D");
+		switch (*attr) {
+		case '!':
+			am->match_mode =3D MATCH_UNSPECIFIED;
+			attr++;
+			attr_len--;
+			break;
+		case '-':
+			am->match_mode =3D MATCH_UNSET;
+			attr++;
+			attr_len--;
+			break;
+		default:
+			if (attr[attr_len] !=3D '=3D')
+				am->match_mode =3D MATCH_SET;
+			else {
+				am->match_mode =3D MATCH_VALUE;
+				am->value =3D xstrdup(&attr[attr_len + 1]);
+				if (strchr(am->value, '\\'))
+					die(_("attr spec values must not contain backslashes"));
+			}
+			break;
+		}
+
+		am->attr =3D git_attr_counted(attr, attr_len);
+		if (!am->attr) {
+			struct strbuf sb =3D STRBUF_INIT;
+			am->match_mode =3D INVALID_ATTR;
+			invalid_attr_name_message(&sb, attr, attr_len);
+			die(_("invalid attribute in '%s': '%s'"), value, sb.buf);
+		}
+
+		git_attr_check_append(item->attr_check, am->attr);
+	}
+
+	string_list_clear(&list, 0);
+	return;
+}
+
 static void eat_long_magic(struct pathspec_item *item, const char *elt=
,
 		unsigned *magic, int *pathspec_prefix,
 		const char **copyfrom_, const char **long_magic_end)
 {
 	int i;
 	const char *copyfrom =3D *copyfrom_;
+	const char *body;
 	/* longhand */
 	const char *nextat;
 	for (copyfrom =3D elt + 2;
@@ -108,15 +175,21 @@ static void eat_long_magic(struct pathspec_item *=
item, const char *elt,
 		if (!len)
 			continue;
=20
-		if (starts_with(copyfrom, "prefix:")) {
+		if (skip_prefix(copyfrom, "prefix:", &body)) {
 			char *endptr;
-			*pathspec_prefix =3D strtol(copyfrom + 7,
-						  &endptr, 10);
+			*pathspec_prefix =3D strtol(body, &endptr, 10);
 			if (endptr - copyfrom !=3D len)
 				die(_("invalid parameter for pathspec magic 'prefix'"));
 			continue;
 		}
=20
+		if (skip_prefix(copyfrom, "attr:", &body)) {
+			char *attr_body =3D xmemdupz(body, len - strlen("attr:"));
+			parse_pathspec_attr_match(item, attr_body);
+			free(attr_body);
+			continue;
+		}
+
 		for (i =3D 0; i < ARRAY_SIZE(pathspec_magic); i++) {
 			if (strlen(pathspec_magic[i].name) =3D=3D len &&
 			    !strncmp(pathspec_magic[i].name, copyfrom, len)) {
@@ -425,7 +498,10 @@ void parse_pathspec(struct pathspec *pathspec,
 	for (i =3D 0; i < n; i++) {
 		unsigned short_magic;
 		entry =3D argv[i];
-
+		item[i].attr_check =3D NULL;
+		item[i].attr_match =3D NULL;
+		item[i].attr_match_nr =3D 0;
+		item[i].attr_match_alloc =3D 0;
 		item[i].magic =3D prefix_pathspec(item + i, &short_magic,
 						argv + i, flags,
 						prefix, prefixlen, entry);
@@ -447,6 +523,13 @@ void parse_pathspec(struct pathspec *pathspec,
 		if (item[i].nowildcard_len < item[i].len)
 			pathspec->has_wildcard =3D 1;
 		pathspec->magic |=3D item[i].magic;
+
+		if (item[i].attr_match_nr) {
+			int j;
+			for (j =3D 0; j < item[i].attr_match_nr; j++)
+				if (item[i].attr_match[j].match_mode =3D=3D INVALID_ATTR)
+					die(_("attribute spec in the wrong syntax are prohibited."));
+		}
 	}
=20
 	if (nr_exclude =3D=3D n)
@@ -502,6 +585,16 @@ void copy_pathspec(struct pathspec *dst, const str=
uct pathspec *src)
=20
 void free_pathspec(struct pathspec *pathspec)
 {
+	int i, j;
+	for (i =3D 0; i < pathspec->nr; i++) {
+		if (!pathspec->items[i].attr_match_nr)
+			continue;
+		for (j =3D 0; j < pathspec->items[j].attr_match_nr; j++)
+			free(pathspec->items[i].attr_match[j].value);
+		free(pathspec->items[i].attr_match);
+		git_attr_check_free(pathspec->items[i].attr_check);
+	}
+
 	free(pathspec->items);
 	pathspec->items =3D NULL;
 }
diff --git a/pathspec.h b/pathspec.h
index 0c11262..5308137 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -32,6 +32,22 @@ struct pathspec {
 		int len, prefix;
 		int nowildcard_len;
 		int flags;
+		int attr_match_nr;
+		int attr_match_alloc;
+		struct attr_match {
+			struct git_attr *attr;
+			char *value;
+			enum attr_match_mode {
+				MATCH_SET,
+				MATCH_UNSET,
+				MATCH_VALUE,
+				MATCH_UNSPECIFIED,
+				MATCH_NOT_UNSPECIFIED,
+				MATCH_SET_OR_VALUE,
+				INVALID_ATTR
+			} match_mode;
+		} *attr_match;
+		struct git_attr_check *attr_check;
 	} *items;
 };
=20
diff --git a/t/t6134-pathspec-with-labels.sh b/t/t6134-pathspec-with-la=
bels.sh
new file mode 100755
index 0000000..5da1a63
--- /dev/null
+++ b/t/t6134-pathspec-with-labels.sh
@@ -0,0 +1,163 @@
+#!/bin/sh
+
+test_description=3D'test labels in pathspecs'
+. ./test-lib.sh
+
+test_expect_success 'setup a tree' '
+	cat <<-EOF >expect &&
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
+	test_must_fail git ls-files ":(attr:)" 2>actual &&
+	test_i18ngrep fatal actual
+'
+
+test_expect_success 'pathspec with labels and non existent .gitattribu=
tes' '
+	git ls-files ":(attr:label)" >actual &&
+	test_must_be_empty actual
+'
+
+test_expect_success 'setup .gitattributes' '
+	cat <<-EOF >.gitattributes &&
+	fileA labelA
+	fileB labelB
+	fileC labelC
+	fileAB labelA labelB
+	fileAC labelA labelC
+	fileBC labelB labelC
+	fileUnsetLabel -label
+	fileSetLabel label
+	fileValue label=3Dfoo
+	fileWrongLabel label=E2=98=BA
+	EOF
+	git add .gitattributes &&
+	git commit -m "add attributes"
+'
+
+test_expect_success 'check specific set attr' '
+	cat <<-EOF >expect &&
+	fileSetLabel
+	sub/fileSetLabel
+	EOF
+	git ls-files ":(attr:label)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'check specific unset attr' '
+	cat <<-EOF >expect &&
+	fileUnsetLabel
+	sub/fileUnsetLabel
+	EOF
+	git ls-files ":(attr:-label)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'check specific value attr' '
+	cat <<-EOF >expect &&
+	fileValue
+	sub/fileValue
+	EOF
+	git ls-files ":(attr:label=3Dfoo)" >actual &&
+	test_cmp expect actual &&
+	git ls-files ":(attr:label=3Dbar)" >actual &&
+	test_must_be_empty actual
+'
+
+test_expect_success 'check unspecified attr' '
+	cat <<-EOF >expect &&
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
+	cat <<-EOF >expect &&
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
+	cat <<-EOF >expect &&
+	fileAB
+	fileB
+	fileBC
+	EOF
+	git ls-files ":(attr:labelB)" ":(exclude)sub/" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'check label excluding other labels' '
+	cat <<-EOF >expect &&
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
+test_expect_success 'abort on giving invalid label on the command line=
' '
+	test_must_fail git ls-files . ":(attr:=E2=98=BA)" 2>actual &&
+	test_i18ngrep "fatal" actual
+'
+
+test_done
--=20
2.8.2.123.gb4ad9b6.dirty
