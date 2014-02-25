From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3] tag: support --sort=<spec>
Date: Tue, 25 Feb 2014 19:22:15 +0700
Message-ID: <1393330935-22229-1-git-send-email-pclouds@gmail.com>
References: <1393039762-4843-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 25 13:22:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIH1R-00066O-II
	for gcvg-git-2@plane.gmane.org; Tue, 25 Feb 2014 13:22:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752505AbaBYMWA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Feb 2014 07:22:00 -0500
Received: from mail-pa0-f42.google.com ([209.85.220.42]:44722 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751912AbaBYMV7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Feb 2014 07:21:59 -0500
Received: by mail-pa0-f42.google.com with SMTP id kl14so8063529pab.1
        for <git@vger.kernel.org>; Tue, 25 Feb 2014 04:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=zf4KFh5XMdM1P7SFZH6x9mM+B384O+My1lUA8Z6A6+Q=;
        b=Zg8Emr4EZX2Kd+ElRM3Gwhvwq1f5CqgDBsgt7oFEo7QXQZ3zHFAsIsTjASYwc6EvdW
         Vi+1FdKIEwQabkajg/uhIt86WHqx/4OEl1eYkeQP3xCf7JbhIWM41Wv0fFq2/7hVmEvT
         hJY9jlpdodCPnVP7+LguDJGdbUBw64lMniddqPHCs4X9objqwZzP6fHmFyzYID5t/INl
         cA+Za192yLBqIAoaeKC7GDcIcfKZgTUgxxqnTPKitw0vIy9sX6ko7sop2cwv6xjfkCap
         XXxzeFhjqVc77dCkwJ9JYK9fsI5cju79HlkmZvdjCUVdOUnIIaRpJZYb1We+h7fBZEm+
         Fi5g==
X-Received: by 10.68.203.102 with SMTP id kp6mr6362025pbc.14.1393330917663;
        Tue, 25 Feb 2014 04:21:57 -0800 (PST)
Received: from lanh ([115.73.218.244])
        by mx.google.com with ESMTPSA id ug2sm142236387pac.21.2014.02.25.04.21.54
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Feb 2014 04:21:56 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 25 Feb 2014 19:22:18 +0700
X-Mailer: git-send-email 1.9.0.40.gaa8c3ea
In-Reply-To: <1393039762-4843-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242662>

--sort=3Dversion:refname (or --sort=3Dv:refname for short) sorts tags a=
s
if they are versions. --sort=3D-refname reverses the order (with or
without ":version").

versioncmp() is copied from string/strverscmp.c in glibc commit
ee9247c38a8def24a59eb5cfb7196a98bef8cfdc, reformatted to Git coding
style. The implementation is under LGPL-2.1 and according to [1] I can
relicense it to GPLv2.

[1] http://www.gnu.org/licenses/gpl-faq.html#AllCompatibility

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 v3 tweaks the sorting syntax a bit (version:refname vs refname:version=
)
 and embed strverscmp() to git code (instead of relying on one from gli=
bc).

 Documentation/git-tag.txt |  6 ++++
 Makefile                  |  1 +
 builtin/tag.c             | 68 ++++++++++++++++++++++++++++++++++---
 cache.h                   |  2 ++
 t/t7004-tag.sh            | 43 ++++++++++++++++++++++++
 versioncmp.c (new)        | 85 +++++++++++++++++++++++++++++++++++++++=
++++++++
 6 files changed, 200 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 404257d..9b05931 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -95,6 +95,12 @@ OPTIONS
 	using fnmatch(3)).  Multiple patterns may be given; if any of
 	them matches, the tag is shown.
=20
+--sort=3D<type>::
+	Sort in a specific order. Supported type is "refname"
+	(lexicographic order), "version:refname" or "v:refname" (tags
+	name are treated as versions). Prepend "-" to reverse sort
+	order.
+
 --column[=3D<options>]::
 --no-column::
 	Display tag listing in columns. See configuration variable
diff --git a/Makefile b/Makefile
index dddaf4f..16b00a5 100644
--- a/Makefile
+++ b/Makefile
@@ -884,6 +884,7 @@ LIB_OBJS +=3D userdiff.o
 LIB_OBJS +=3D utf8.o
 LIB_OBJS +=3D varint.o
 LIB_OBJS +=3D version.o
+LIB_OBJS +=3D versioncmp.o
 LIB_OBJS +=3D walker.o
 LIB_OBJS +=3D wildmatch.o
 LIB_OBJS +=3D wrapper.o
diff --git a/builtin/tag.c b/builtin/tag.c
index 74d3780..73b8a24 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -27,9 +27,16 @@ static const char * const git_tag_usage[] =3D {
 	NULL
 };
=20
+#define STRCMP_SORT     0	/* must be zero */
+#define VERCMP_SORT     1
+#define SORT_MASK       0x7fff
+#define REVERSE_SORT    0x8000
+
 struct tag_filter {
 	const char **patterns;
 	int lines;
+	int sort;
+	struct string_list tags;
 	struct commit_list *with_commit;
 };
=20
@@ -166,7 +173,10 @@ static int show_reference(const char *refname, con=
st unsigned char *sha1,
 			return 0;
=20
 		if (!filter->lines) {
-			printf("%s\n", refname);
+			if (filter->sort)
+				string_list_append(&filter->tags, refname);
+			else
+				printf("%s\n", refname);
 			return 0;
 		}
 		printf("%-15s ", refname);
@@ -177,17 +187,39 @@ static int show_reference(const char *refname, co=
nst unsigned char *sha1,
 	return 0;
 }
=20
+static int sort_by_version(const void *a_, const void *b_)
+{
+	const struct string_list_item *a =3D a_;
+	const struct string_list_item *b =3D b_;
+	return versioncmp(a->string, b->string);
+}
+
 static int list_tags(const char **patterns, int lines,
-			struct commit_list *with_commit)
+		     struct commit_list *with_commit, int sort)
 {
 	struct tag_filter filter;
=20
 	filter.patterns =3D patterns;
 	filter.lines =3D lines;
+	filter.sort =3D sort;
 	filter.with_commit =3D with_commit;
+	memset(&filter.tags, 0, sizeof(filter.tags));
+	filter.tags.strdup_strings =3D 1;
=20
 	for_each_tag_ref(show_reference, (void *) &filter);
-
+	if (sort) {
+		int i;
+		if ((sort & SORT_MASK) =3D=3D VERCMP_SORT)
+			qsort(filter.tags.items, filter.tags.nr,
+			      sizeof(struct string_list_item), sort_by_version);
+		if (sort & REVERSE_SORT)
+			for (i =3D filter.tags.nr - 1; i >=3D 0; i--)
+				printf("%s\n", filter.tags.items[i].string);
+		else
+			for (i =3D 0; i < filter.tags.nr; i++)
+				printf("%s\n", filter.tags.items[i].string);
+		string_list_clear(&filter.tags, 0);
+	}
 	return 0;
 }
=20
@@ -427,6 +459,26 @@ static int parse_opt_points_at(const struct option=
 *opt __attribute__((unused)),
 	return 0;
 }
=20
+static int parse_opt_sort(const struct option *opt, const char *arg, i=
nt unset)
+{
+	int *sort =3D opt->value;
+	if (*arg =3D=3D '-') {
+		*sort =3D REVERSE_SORT;
+		arg++;
+	} else
+		*sort =3D STRCMP_SORT;
+	if (starts_with(arg, "version:")) {
+		*sort |=3D VERCMP_SORT;
+		arg +=3D 8;
+	} else if (starts_with(arg, "v:")) {
+		*sort |=3D VERCMP_SORT;
+		arg +=3D 2;
+	}
+	if (strcmp(arg, "refname"))
+		die(_("unsupported sort specification %s"), arg);
+	return 0;
+}
+
 int cmd_tag(int argc, const char **argv, const char *prefix)
 {
 	struct strbuf buf =3D STRBUF_INIT;
@@ -437,7 +489,7 @@ int cmd_tag(int argc, const char **argv, const char=
 *prefix)
 	struct create_tag_options opt;
 	char *cleanup_arg =3D NULL;
 	int annotate =3D 0, force =3D 0, lines =3D -1;
-	int cmdmode =3D 0;
+	int cmdmode =3D 0, sort =3D 0;
 	const char *msgfile =3D NULL, *keyid =3D NULL;
 	struct msg_arg msg =3D { 0, STRBUF_INIT };
 	struct commit_list *with_commit =3D NULL;
@@ -462,6 +514,10 @@ int cmd_tag(int argc, const char **argv, const cha=
r *prefix)
 					N_("use another key to sign the tag")),
 		OPT__FORCE(&force, N_("replace the tag if exists")),
 		OPT_COLUMN(0, "column", &colopts, N_("show tag list in columns")),
+		{
+			OPTION_CALLBACK, 0, "sort", &sort, N_("type"), N_("sort tags"),
+			PARSE_OPT_NONEG, parse_opt_sort
+		},
=20
 		OPT_GROUP(N_("Tag listing options")),
 		{
@@ -509,7 +565,9 @@ int cmd_tag(int argc, const char **argv, const char=
 *prefix)
 			copts.padding =3D 2;
 			run_column_filter(colopts, &copts);
 		}
-		ret =3D list_tags(argv, lines =3D=3D -1 ? 0 : lines, with_commit);
+		if (lines !=3D -1 && sort)
+			die(_("--sort and -n are incompatible"));
+		ret =3D list_tags(argv, lines =3D=3D -1 ? 0 : lines, with_commit, so=
rt);
 		if (column_active(colopts))
 			stop_column_filter();
 		return ret;
diff --git a/cache.h b/cache.h
index dc040fb..082a783 100644
--- a/cache.h
+++ b/cache.h
@@ -1367,4 +1367,6 @@ int stat_validity_check(struct stat_validity *sv,=
 const char *path);
  */
 void stat_validity_update(struct stat_validity *sv, int fd);
=20
+int versioncmp(const char *s1, const char *s2);
+
 #endif /* CACHE_H */
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index c8d6e9f..143a8ea 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1380,4 +1380,47 @@ test_expect_success 'multiple --points-at are OR=
-ed together' '
 	test_cmp expect actual
 '
=20
+test_expect_success 'lexical sort' '
+	git tag foo1.3 &&
+	git tag foo1.6 &&
+	git tag foo1.10 &&
+	git tag -l --sort=3Drefname "foo*" >actual &&
+	cat >expect <<EOF &&
+foo1.10
+foo1.3
+foo1.6
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'version sort' '
+	git tag -l --sort=3Dversion:refname "foo*" >actual &&
+	cat >expect <<EOF &&
+foo1.3
+foo1.6
+foo1.10
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'reverse version sort' '
+	git tag -l --sort=3D-version:refname "foo*" >actual &&
+	cat >expect <<EOF &&
+foo1.10
+foo1.6
+foo1.3
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'reverse lexical sort' '
+	git tag -l --sort=3D-refname "foo*" >actual &&
+	cat >expect <<EOF &&
+foo1.6
+foo1.3
+foo1.10
+EOF
+	test_cmp expect actual
+'
+
 test_done
diff --git a/versioncmp.c b/versioncmp.c
new file mode 100644
index 0000000..18a9632
--- /dev/null
+++ b/versioncmp.c
@@ -0,0 +1,85 @@
+#include "git-compat-util.h"
+
+/*
+ * states: S_N: normal, S_I: comparing integral part, S_F: comparing
+ * fractionnal parts, S_Z: idem but with leading Zeroes only
+ */
+#define  S_N    0x0
+#define  S_I    0x3
+#define  S_F    0x6
+#define  S_Z    0x9
+
+/* result_type: CMP: return diff; LEN: compare using len_diff/diff */
+#define  CMP    2
+#define  LEN    3
+
+
+/*
+ * Compare S1 and S2 as strings holding indices/version numbers,
+ * returning less than, equal to or greater than zero if S1 is less
+ * than, equal to or greater than S2 (for more info, see the texinfo
+ * doc).
+ */
+
+int versioncmp(const char *s1, const char *s2)
+{
+	const unsigned char *p1 =3D (const unsigned char *) s1;
+	const unsigned char *p2 =3D (const unsigned char *) s2;
+
+	/*
+	 * Symbol(s)    0       [1-9]   others
+	 * Transition   (10) 0  (01) d  (00) x
+	 */
+	static const uint8_t next_state[] =3D {
+		/* state    x    d    0  */
+		/* S_N */  S_N, S_I, S_Z,
+		/* S_I */  S_N, S_I, S_I,
+		/* S_F */  S_N, S_F, S_F,
+		/* S_Z */  S_N, S_F, S_Z
+	};
+
+	static const int8_t result_type[] =3D {
+		/* state   x/x  x/d  x/0  d/x  d/d  d/0  0/x  0/d  0/0  */
+
+		/* S_N */  CMP, CMP, CMP, CMP, LEN, CMP, CMP, CMP, CMP,
+		/* S_I */  CMP, -1,  -1,  +1,  LEN, LEN, +1,  LEN, LEN,
+		/* S_F */  CMP, CMP, CMP, CMP, CMP, CMP, CMP, CMP, CMP,
+		/* S_Z */  CMP, +1,  +1,  -1,  CMP, CMP, -1,  CMP, CMP
+	};
+
+	if (p1 =3D=3D p2)
+		return 0;
+
+	unsigned char c1 =3D *p1++;
+	unsigned char c2 =3D *p2++;
+	/* Hint: '0' is a digit too.  */
+	int state =3D S_N + ((c1 =3D=3D '0') + (isdigit (c1) !=3D 0));
+
+	int diff;
+	while ((diff =3D c1 - c2) =3D=3D 0) {
+		if (c1 =3D=3D '\0')
+			return diff;
+
+		state =3D next_state[state];
+		c1 =3D *p1++;
+		c2 =3D *p2++;
+		state +=3D (c1 =3D=3D '0') + (isdigit (c1) !=3D 0);
+	}
+
+	state =3D result_type[state * 3 + (((c2 =3D=3D '0') + (isdigit (c2) !=
=3D 0)))];
+
+	switch (state) {
+	case CMP:
+		return diff;
+
+	case LEN:
+		while (isdigit (*p1++))
+			if (!isdigit (*p2++))
+				return 1;
+
+		return isdigit (*p2) ? -1 : diff;
+
+	default:
+		return state;
+	}
+}
--=20
1.9.0.40.gaa8c3ea
