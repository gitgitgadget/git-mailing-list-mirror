From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv9] pathspec: allow querying for attributes
Date: Fri, 20 May 2016 12:00:34 -0700
Message-ID: <20160520190034.12681-1-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri May 20 21:01:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3pfO-00009g-1F
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 21:00:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751009AbcETTAl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 May 2016 15:00:41 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34169 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750795AbcETTAk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2016 15:00:40 -0400
Received: by mail-pa0-f53.google.com with SMTP id qo8so42443808pab.1
        for <git@vger.kernel.org>; Fri, 20 May 2016 12:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xpgiZNH6HfaXBw4+qdwUCL4dhRlOAPUTNuj8Rd1nhn8=;
        b=nB8Ro5Kpx8xbMI0pvlbaBa7pq9mGziWX8u1treo/pj/6AMyxt/tXeZAPCXvKkqyFdY
         N6/LV+HeCE40U3r5LK03BmqBT/UDItcxADzstsn+LByPhy1HXZi481QJBrlwpE+xXV9F
         l2PWzdqlOrneMi9FdVljhFEgvuyNHKOczbr5CHPexi0cLkylUUBQC6uZ4EllAKgfM2SI
         zHofMlzgsBm82Y89MPc+AZ0+u76c0E2Sr44wyf+z+YIh9zQzKMvGMjQd3axNaTRc2D10
         3slCnOpf9ynRlfUtUBe9/NBxlXmCf+nwM1EJA7MvmdJb0lGQIBaPY/2e7ic7SemswKN0
         6K/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xpgiZNH6HfaXBw4+qdwUCL4dhRlOAPUTNuj8Rd1nhn8=;
        b=LSzqSjXsMuNHEP39T474Rybz3v0HSRIwutj/YCj9bHiemPoaa95251qAeKxPmTlSr0
         farbEQWewWRrv375mLz6Vxpmv2KCtVMTFXpypG8ay8hewKWcyN3WADfWZAxYI1SqtYgI
         oUJzsgMwcVJUbUQNV6b9g06KwL3gxqzPHOsSboQw9kJgbulA4LWCYX4d03FcAPIopjSu
         BzO5IxIxoTqjMU5gXZIyh7BUrtO8boR3tEBXkZ3PsB0vN6r1Ik5H/nEmOD7M1YuIWQS8
         BdX5xh/dTgTInfoNZf3HdHMzbwTAVrNZJV9DUeVOy8tPg+Y54P7JxZ4klVP36Jk+5Izl
         mNWg==
X-Gm-Message-State: AOPr4FVHg08iUOrfWP8cbR4k7MRrd0hh4A7MjUsS7TH1EP+2yhhTkxeV0boFgMZMVTZxELHE
X-Received: by 10.66.65.133 with SMTP id x5mr7350441pas.108.1463770838481;
        Fri, 20 May 2016 12:00:38 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:104:6ffe:257d:9a11])
        by smtp.gmail.com with ESMTPSA id h88sm28918909pfd.10.2016.05.20.12.00.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 20 May 2016 12:00:37 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.123.gb4ad9b6.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295205>

The pathspec mechanism is extended via the new
":(attr:eol=3Dinput)pattern/to/match" syntax to filter paths so that it
requires paths to not just match the given pattern but also have the
specified attrs attached for them to be chosen.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Junio, please replace the last patch of sb/pathspec-label with this one=
=2E

diff to last round:
#	diff --git a/Documentation/glossary-content.txt b/Documentation/gloss=
ary-content.txt
#	index e06520b..181f52e 100644
#	--- a/Documentation/glossary-content.txt
#	+++ b/Documentation/glossary-content.txt
#	@@ -389,7 +389,7 @@ After `attr:` comes a space separated list of "at=
tribute
#	 requirements", all of which must be met in order for the
#	 path to be considered a match; this is in addition to the
#	 usual non-magic pathspec pattern matching.
#	-
#	++
#	 Each of the attribute requirements for the path takes one of
#	 these forms:
#	=20
#	diff --git a/pathspec.c b/pathspec.c
#	index 693a5e7..0a02255 100644
#	--- a/pathspec.c
#	+++ b/pathspec.c
#	@@ -115,19 +115,19 @@ static void parse_pathspec_attr_match(struct pa=
thspec_item *item, const char *va
#	 		const char *attr =3D si->string;
#	 		struct attr_match *am =3D &item->attr_match[j];
#	=20
#	-		attr_len =3D strcspn(attr, "=3D");
#	 		switch (*attr) {
#	 		case '!':
#	 			am->match_mode =3D MATCH_UNSPECIFIED;
#	 			attr++;
#	-			attr_len--;
#	+			attr_len =3D strlen(attr);
#	 			break;
#	 		case '-':
#	 			am->match_mode =3D MATCH_UNSET;
#	 			attr++;
#	-			attr_len--;
#	+			attr_len =3D strlen(attr);
#	 			break;
#	 		default:
#	+			attr_len =3D strcspn(attr, "=3D");
#	 			if (attr[attr_len] !=3D '=3D')
#	 				am->match_mode =3D MATCH_SET;
#	 			else {
#	diff --git a/t/t6134-pathspec-with-labels.sh b/t/t6134-pathspec-with-=
labels.sh
#	index 5da1a63..a5c9632 100755
#	--- a/t/t6134-pathspec-with-labels.sh
#	+++ b/t/t6134-pathspec-with-labels.sh
#	@@ -40,8 +40,7 @@ test_expect_success 'setup a tree' '
#	 '
#	=20
#	 test_expect_success 'pathspec with no attr' '
#	-	test_must_fail git ls-files ":(attr:)" 2>actual &&
#	-	test_i18ngrep fatal actual
#	+	test_must_fail git ls-files ":(attr:)"
#	 '
#	=20
#	 test_expect_success 'pathspec with labels and non existent .gitattri=
butes' '
#	@@ -156,8 +155,12 @@ test_expect_success 'check label excluding other=
 labels' '
#	 '
#	=20
#	 test_expect_success 'abort on giving invalid label on the command li=
ne' '
#	-	test_must_fail git ls-files . ":(attr:=E2=98=BA)" 2>actual &&
#	-	test_i18ngrep "fatal" actual
#	+	test_must_fail git ls-files . ":(attr:=E2=98=BA)"
#	+'
#	+
#	+test_expect_success 'abort on asking for wrong magic' '
#	+	test_must_fail git ls-files . ":(attr:-label=3Dfoo)" &&
#	+	test_must_fail git ls-files . ":(attr:!label=3Dfoo)"
#	 '
#	=20
#	 test_done

 Documentation/glossary-content.txt |  20 +++++
 dir.c                              |  35 ++++++++
 pathspec.c                         | 101 +++++++++++++++++++++-
 pathspec.h                         |  16 ++++
 t/t6134-pathspec-with-labels.sh    | 166 +++++++++++++++++++++++++++++=
++++++++
 5 files changed, 334 insertions(+), 4 deletions(-)
 create mode 100755 t/t6134-pathspec-with-labels.sh

diff --git a/Documentation/glossary-content.txt b/Documentation/glossar=
y-content.txt
index cafc284..181f52e 100644
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
++
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
index 4dff252..0a02255 100644
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
+		switch (*attr) {
+		case '!':
+			am->match_mode =3D MATCH_UNSPECIFIED;
+			attr++;
+			attr_len =3D strlen(attr);
+			break;
+		case '-':
+			am->match_mode =3D MATCH_UNSET;
+			attr++;
+			attr_len =3D strlen(attr);
+			break;
+		default:
+			attr_len =3D strcspn(attr, "=3D");
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
index 0000000..a5c9632
--- /dev/null
+++ b/t/t6134-pathspec-with-labels.sh
@@ -0,0 +1,166 @@
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
+	test_must_fail git ls-files ":(attr:)"
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
+	test_must_fail git ls-files . ":(attr:=E2=98=BA)"
+'
+
+test_expect_success 'abort on asking for wrong magic' '
+	test_must_fail git ls-files . ":(attr:-label=3Dfoo)" &&
+	test_must_fail git ls-files . ":(attr:!label=3Dfoo)"
+'
+
+test_done
--=20
2.8.2.123.gb4ad9b6.dirty
