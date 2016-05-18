From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv7 5/5] pathspec: allow querying for attributes
Date: Wed, 18 May 2016 12:02:22 -0700
Message-ID: <20160518190222.28105-6-sbeller@google.com>
References: <20160518190222.28105-1-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Wed May 18 21:02:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b36k1-0002BJ-Ny
	for gcvg-git-2@plane.gmane.org; Wed, 18 May 2016 21:02:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753966AbcERTCj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 May 2016 15:02:39 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:32853 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753961AbcERTCg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 15:02:36 -0400
Received: by mail-pf0-f172.google.com with SMTP id 206so21472480pfu.0
        for <git@vger.kernel.org>; Wed, 18 May 2016 12:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UkxqCQ1Hj4FDLx77mxHkQSXfW15wH52ufJwDF9IT+Kk=;
        b=Zh7ZjAAsQfbXtsCUyoMQdB+CySODsrMNpwGECKxMYYSCAfWNvmQwm/fDUEhlTk0rOe
         nyMzFXfSRbVpA4kbmVy0IsLgtKjzriI8IGvR5OYc+OHAKG9Qcht2uzmlCzz9qBz0Kjzm
         c7gxx6azmJmQCvK9MlVMHV0H0g/cAZG0DWIdeNPbrOevUNQOUYudWWXIoByuyoZunG+r
         QoeCPEk/8lyJSDO63k8/KgOCSTgs16+u6wV04mozvhetcZe/6bXpLhe+e6nds94h8qfB
         0OiULB8wrXfZVe5fG36Jit6GwCRrpFbIoyPp6noFPUIhzSKKBtBWzYIzEEUAR2poL7gX
         Ul2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UkxqCQ1Hj4FDLx77mxHkQSXfW15wH52ufJwDF9IT+Kk=;
        b=R7jyItgM429s03V+zBD+SeBOJrjL4IbEPvMFkE/vp7q9Pju9FsvrG2wYutDnVdTDVX
         hoaAr0dF/3EmyV4Gq9xP97w3K96yMdlkIXlTTexWuCEvVoTY6vabDros6c+l4r6Dg1/h
         2KstFOXr3fSBfuLTKTVhsxHN0qIcEQaAvbTyrmHMHhhUyciuhVbmb6rM618CAkufKmCO
         WFuFUBzaVUZ5r3yA7UA0MHoxAyhq/+DSSlcPGcjytiNq7ZOMJehkrTPgLNq6FTt2palw
         b3zNpx9qmX0MTeFYyhiITplNT2O3xquuEg2MItFFn9czj0W0jTflTfmPQNxJvLDWvXMe
         5rVQ==
X-Gm-Message-State: AOPr4FVtiwfrYdvR8wA0HlrP0ISXQOOTCEuKfhuunrC9HRnmmLHhCMlF8asMY50TygAqUV4g
X-Received: by 10.98.22.193 with SMTP id 184mr13074104pfw.116.1463598155192;
        Wed, 18 May 2016 12:02:35 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:d468:afb3:b0f0:947e])
        by smtp.gmail.com with ESMTPSA id fn3sm14050100pab.20.2016.05.18.12.02.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 18 May 2016 12:02:34 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.121.ga97fb08
In-Reply-To: <20160518190222.28105-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294990>

The pathspec mechanism is extended via the new
":(attr:eol=3Dinput)pattern/to/match" syntax to filter paths so that it
requires paths to not just match the given pattern but also have the
specified attrs attached for them to be chosen.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/glossary-content.txt |  19 ++++
 attr.c                             |   2 +-
 attr.h                             |   2 +
 dir.c                              |  46 ++++++++++
 pathspec.c                         | 103 ++++++++++++++++++++-
 pathspec.h                         |  16 ++++
 t/t6134-pathspec-with-labels.sh    | 177 +++++++++++++++++++++++++++++=
++++++++
 7 files changed, 360 insertions(+), 5 deletions(-)
 create mode 100755 t/t6134-pathspec-with-labels.sh

diff --git a/Documentation/glossary-content.txt b/Documentation/glossar=
y-content.txt
index cafc284..866e8d8 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -384,6 +384,25 @@ full pathname may have special meaning:
 +
 Glob magic is incompatible with literal magic.
=20
+attr;;
+	Additionally to matching the pathspec, the path must have the
+	attribute as specified. The syntax for specifying the required
+	attributes is "`attr: [mode] <attribute name> [=3Dvalue]`"
++
+Attributes can have 4 states (Set, Unset, Set to a value, unspecified)=
 and
+you can query each attribute for certain states. The "`[mode]`" is a s=
pecial
+character to indicate which attribute states are looked for. The follo=
wing
+modes are available:
+
+ - "`+`" the attribute must be set
+ - "`-`" the attribute must be unset
+ - "`~`" the attribute must be unspecified
+ - "`?`" the attribute must not be unspecified, i.e. set, unset or val=
ue matches
+ - an empty "`[mode]`" matches if the attribute is set or has a value
+ - an empty "`[mode]`" combined with "`[=3Dvalue]`" matches if the att=
ribute has
+   the given value.
++
+
 exclude;;
 	After a path matches any non-exclude pathspec, it will be run
 	through all exclude pathspec (magic signature: `!`). If it
diff --git a/attr.c b/attr.c
index e0f7965..65cffd8 100644
--- a/attr.c
+++ b/attr.c
@@ -59,7 +59,7 @@ static unsigned hash_name(const char *name, int namel=
en)
 	return val;
 }
=20
-static int invalid_attr_name(const char *name, int namelen)
+int invalid_attr_name(const char *name, int namelen)
 {
 	/*
 	 * Attribute name cannot begin with '-' and must consist of
diff --git a/attr.h b/attr.h
index 51ca36d..4bb4848 100644
--- a/attr.h
+++ b/attr.h
@@ -45,6 +45,8 @@ extern void git_attr_check_append(struct git_attr_che=
ck *, const struct git_attr
 extern void git_attr_check_clear(struct git_attr_check *);
 extern void git_attr_check_free(struct git_attr_check *);
=20
+extern int invalid_attr_name(const char *name, int namelen);
+
 /*
  * Return the name of the attribute represented by the argument.  The
  * return value is a pointer to a null-delimited string that is part
diff --git a/dir.c b/dir.c
index 996653b..3141a5a 100644
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
@@ -215,6 +216,48 @@ int within_depth(const char *name, int namelen,
 	return 1;
 }
=20
+static int match_attrs(const char *name, int namelen,
+		       const struct pathspec_item *item)
+{
+	char *path;
+	int i;
+
+	path =3D xmemdupz(name, namelen);
+	git_check_attr(path, item->attr_check);
+
+	for (i =3D 0; i < item->attr_match_nr; i++) {
+		const char *value;
+		int matched;
+		enum attr_match_mode match_mode;
+
+		value =3D item->attr_check->check[i].value;
+
+		match_mode =3D item->attr_match[i].match_mode;
+
+		if (ATTR_TRUE(value)) {
+			matched =3D match_mode =3D=3D MATCH_SET ||
+				  match_mode =3D=3D MATCH_SET_OR_VALUE ||
+				  match_mode =3D=3D MATCH_NOT_UNSPECIFIED;
+		} else if (ATTR_FALSE(value)) {
+			matched =3D match_mode =3D=3D MATCH_UNSET ||
+				  match_mode =3D=3D MATCH_NOT_UNSPECIFIED;
+		} else if (ATTR_UNSET(value)) {
+			matched =3D match_mode =3D=3D MATCH_UNSPECIFIED;
+		} else {
+			matched =3D match_mode =3D=3D MATCH_NOT_UNSPECIFIED ||
+				  match_mode =3D=3D MATCH_SET_OR_VALUE ||
+				  (match_mode =3D=3D MATCH_VALUE &&
+				   !strcmp(item->attr_match[i].value, value));
+		}
+		if (!matched)
+			return 0;
+	}
+
+	free(path);
+
+	return 1;
+}
+
 #define DO_MATCH_EXCLUDE   1
 #define DO_MATCH_DIRECTORY 2
=20
@@ -270,6 +313,9 @@ static int match_pathspec_item(const struct pathspe=
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
index 4dff252..32fb6a8 100644
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
@@ -88,12 +89,82 @@ static void prefix_short_magic(struct strbuf *sb, i=
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
+		goto err;
+
+	string_list_split(&list, value, ' ', -1);
+	string_list_remove_empty_items(&list, 0);
+
+	if (!item->attr_check)
+		item->attr_check =3D git_attr_check_alloc();
+
+	ALLOC_GROW(item->attr_match, item->attr_match_nr + list.nr, item->att=
r_match_alloc);
+
+	for_each_string_list_item(si, &list) {
+		size_t val_len;
+
+		int j =3D item->attr_match_nr++;
+		const char *val =3D si->string;
+		struct attr_match *am =3D &item->attr_match[j];
+
+		if (val[0] =3D=3D '?')
+			am->match_mode =3D MATCH_NOT_UNSPECIFIED;
+		else if (val[0] =3D=3D '~')
+			am->match_mode =3D MATCH_UNSPECIFIED;
+		else if (val[0] =3D=3D '+')
+			am->match_mode =3D MATCH_SET;
+		else if (val[0] =3D=3D '-')
+			am->match_mode =3D MATCH_UNSET;
+		else
+			am->match_mode =3D MATCH_SET_OR_VALUE;
+
+		if (am->match_mode !=3D MATCH_SET_OR_VALUE)
+			/* skip first character */
+			val++;
+
+		val_len =3D strcspn(val, "=3D,)");
+		if (val[val_len] =3D=3D '=3D') {
+			am->match_mode =3D MATCH_VALUE;
+			am->value =3D xstrdup(&val[val_len + 1]);
+			/*
+			 * NEEDSWORK:
+			 * Do we want to allow escaped commas to search
+			 * for comma separated values?
+			 */
+			if (strchr(am->value, '\\'))
+				die(_("attr spec values must not contain backslashes"));
+		} else
+			am->value =3D NULL;
+
+		if (invalid_attr_name(val, val_len)) {
+			am->match_mode =3D INVALID_ATTR;
+			goto err;
+		}
+
+		am->attr =3D git_attr(xmemdupz(val, val_len));
+		git_attr_check_append(item->attr_check, am->attr);
+	}
+
+	string_list_clear(&list, 0);
+	return;
+err:
+	die(_("attr spec '%s': attrs must not start with '-' and "
+	      "be composed of [-A-Za-z0-9_.]."), value);
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
@@ -108,15 +179,21 @@ static void eat_long_magic(struct pathspec_item *=
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
+			char *pass =3D xmemdupz(body, len - strlen("attr:"));
+			parse_pathspec_attr_match(item, pass);
+			free(pass);
+			continue;
+		}
+
 		for (i =3D 0; i < ARRAY_SIZE(pathspec_magic); i++) {
 			if (strlen(pathspec_magic[i].name) =3D=3D len &&
 			    !strncmp(pathspec_magic[i].name, copyfrom, len)) {
@@ -425,7 +502,10 @@ void parse_pathspec(struct pathspec *pathspec,
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
@@ -447,6 +527,13 @@ void parse_pathspec(struct pathspec *pathspec,
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
@@ -502,6 +589,14 @@ void copy_pathspec(struct pathspec *dst, const str=
uct pathspec *src)
=20
 void free_pathspec(struct pathspec *pathspec)
 {
+	int i, j;
+	for (i =3D 0; i < pathspec->nr; i++) {
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
index 0000000..35b3ab2
--- /dev/null
+++ b/t/t6134-pathspec-with-labels.sh
@@ -0,0 +1,177 @@
+#!/bin/sh
+
+test_description=3D'test labels in pathspecs'
+. ./test-lib.sh
+
+test_expect_success 'setup a tree' '
+	mkdir sub &&
+	for p in fileA fileB fileC fileAB fileAC fileBC fileNoLabel fileUnset=
Label fileSetLabel fileValue fileWrongLabel; do
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
+fileValue
+fileWrongLabel
+sub/fileA
+sub/fileAB
+sub/fileAC
+sub/fileB
+sub/fileBC
+sub/fileC
+sub/fileNoLabel
+sub/fileSetLabel
+sub/fileUnsetLabel
+sub/fileValue
+sub/fileWrongLabel
+EOF
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
+	cat <<EOF >.gitattributes &&
+fileA labelA
+fileB labelB
+fileC labelC
+fileAB labelA labelB
+fileAC labelA labelC
+fileBC labelB labelC
+fileUnsetLabel -label
+fileSetLabel label
+fileValue label=3Dfoo
+fileWrongLabel label=E2=98=BA
+EOF
+	git add .gitattributes &&
+	git commit -m "add attributes"
+'
+
+sq=3D"'"
+
+test_expect_success 'check specific set attr' '
+	cat <<EOF >expect &&
+fileSetLabel
+sub/fileSetLabel
+EOF
+	git ls-files ":(attr:+label)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'check specific unset attr' '
+	cat <<EOF >expect &&
+fileUnsetLabel
+sub/fileUnsetLabel
+EOF
+	git ls-files ":(attr:-label)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'check specific value attr' '
+	cat <<EOF >expect &&
+fileValue
+sub/fileValue
+EOF
+	git ls-files ":(attr:label=3Dfoo)" >actual &&
+	test_cmp expect actual &&
+	git ls-files ":(attr:label=3Dbar)" >actual &&
+	test_must_be_empty actual
+'
+
+test_expect_success 'check set or value attr' '
+	cat <<EOF >expect &&
+fileSetLabel
+fileValue
+sub/fileSetLabel
+sub/fileValue
+EOF
+	git ls-files ":(attr:label)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'check unspecified attr' '
+	cat <<EOF >expect &&
+.gitattributes
+fileC
+fileNoLabel
+fileWrongLabel
+sub/fileC
+sub/fileNoLabel
+sub/fileWrongLabel
+EOF
+	git ls-files ":(attr:~label,attr:~labelA,attr:~labelB)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'check not unspecified attr' '
+	cat <<EOF >expect &&
+fileSetLabel
+fileUnsetLabel
+fileValue
+sub/fileSetLabel
+sub/fileUnsetLabel
+sub/fileValue
+EOF
+	git ls-files ":(attr:?label)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'check label with 2 labels' '
+	cat <<EOF >expect &&
+fileAB
+sub/fileAB
+EOF
+	git ls-files ":(attr:labelA labelB)" >actual &&
+	test_cmp expect actual &&
+	git ls-files ":(attr:labelA,attr:labelB)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'check label with more labels but excluded path' '
+	cat <<EOF >expect &&
+fileAB
+fileB
+fileBC
+EOF
+	git ls-files ":(attr:labelB)" ":(exclude)sub/" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'check label excluding other labels' '
+	cat <<EOF >expect &&
+fileAB
+fileB
+fileBC
+sub/fileAB
+sub/fileB
+EOF
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
2.8.2.121.ga97fb08
