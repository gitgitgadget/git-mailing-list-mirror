From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/7] Add column layout
Date: Tue,  8 Feb 2011 22:22:16 +0700
Message-ID: <1297178541-31124-3-git-send-email-pclouds@gmail.com>
References: <1297178541-31124-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 08 16:24:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmpQS-0006js-1V
	for gcvg-git-2@lo.gmane.org; Tue, 08 Feb 2011 16:24:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754798Ab1BHPYK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Feb 2011 10:24:10 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:56065 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753860Ab1BHPYJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Feb 2011 10:24:09 -0500
Received: by pva4 with SMTP id 4so1139311pva.19
        for <git@vger.kernel.org>; Tue, 08 Feb 2011 07:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=w43uU6VR10gkmtIuTT30/RN81XZ72a1FGYEiONa542Q=;
        b=V9j6CkgP/wH4PTFhhOza/vXR6aqwVZO2a6I+eKgshkkLvO61wACM5/mme26HKhWTR0
         tgf2ku79kINbOBlyWqVk0AreNokPMSv+tPk/omo4AOQcW+PthuDAsTq91HIKSXAibHrF
         6H5gSwe73TQhpnjyBJkUsF1hFbkpE/6A7slRY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=tkD+pGr/VsVnaap5Um0WZfrbo/0p8+qEdkGZg6Gg56Qzg7D6XEP6O3qAL3MyJ7EDOg
         45IsXWN4tK+KgLfJdKYpJT7MqniOmORsT7a9Q2Y+hjGg83gHSAH1umgApNuDeteVr9KA
         RHiLKN1daQHBTdj3RJlkMJr2rFuhm2QMNwXhU=
Received: by 10.142.126.20 with SMTP id y20mr4674651wfc.114.1297178648505;
        Tue, 08 Feb 2011 07:24:08 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.232.10])
        by mx.google.com with ESMTPS id v19sm7717172wfh.0.2011.02.08.07.24.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 08 Feb 2011 07:24:07 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 08 Feb 2011 22:22:39 +0700
X-Mailer: git-send-email 1.7.3.4.878.g439c7
In-Reply-To: <1297178541-31124-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166355>

This mainly add display_columns() that will display a table of items,
filling columns before rows.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 .gitignore        |    1 +
 Makefile          |    3 +
 column.c          |  177 +++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 column.h          |   20 ++++++
 t/t9002-column.sh |  108 ++++++++++++++++++++++++++++++++
 test-column.c     |   59 ++++++++++++++++++
 6 files changed, 368 insertions(+), 0 deletions(-)
 create mode 100644 column.c
 create mode 100644 column.h
 create mode 100755 t/t9002-column.sh
 create mode 100644 test-column.c

diff --git a/.gitignore b/.gitignore
index 3dd6ef7..a1a1202 100644
--- a/.gitignore
+++ b/.gitignore
@@ -162,6 +162,7 @@
 /gitweb/gitweb.cgi
 /gitweb/static/gitweb.min.*
 /test-chmtime
+/test-column
 /test-ctype
 /test-date
 /test-delta
diff --git a/Makefile b/Makefile
index 775ee83..6d74956 100644
--- a/Makefile
+++ b/Makefile
@@ -417,6 +417,7 @@ PROGRAM_OBJS +=3D http-backend.o
 PROGRAMS +=3D $(patsubst %.o,git-%$X,$(PROGRAM_OBJS))
=20
 TEST_PROGRAMS_NEED_X +=3D test-chmtime
+TEST_PROGRAMS_NEED_X +=3D test-column
 TEST_PROGRAMS_NEED_X +=3D test-ctype
 TEST_PROGRAMS_NEED_X +=3D test-date
 TEST_PROGRAMS_NEED_X +=3D test-delta
@@ -498,6 +499,7 @@ LIB_H +=3D builtin.h
 LIB_H +=3D cache.h
 LIB_H +=3D cache-tree.h
 LIB_H +=3D color.h
+LIB_H +=3D column.h
 LIB_H +=3D commit.h
 LIB_H +=3D compat/bswap.h
 LIB_H +=3D compat/cygwin.h
@@ -575,6 +577,7 @@ LIB_OBJS +=3D branch.o
 LIB_OBJS +=3D bundle.o
 LIB_OBJS +=3D cache-tree.o
 LIB_OBJS +=3D color.o
+LIB_OBJS +=3D column.o
 LIB_OBJS +=3D combine-diff.o
 LIB_OBJS +=3D commit.o
 LIB_OBJS +=3D config.o
diff --git a/column.c b/column.c
new file mode 100644
index 0000000..4b92fa5
--- /dev/null
+++ b/column.c
@@ -0,0 +1,177 @@
+#include "cache.h"
+#include "column.h"
+#include "parse-options.h"
+
+static int item_length(const struct column_layout *c, const char *s)
+{
+	int a_len =3D 0;
+
+	if (!(c->mode & COL_ANSI))
+		return strlen(s);
+
+	while ((s =3D strstr(s, "\033[")) !=3D NULL) {
+		int len =3D strspn(s+2, "0123456789;");
+		s +=3D len+3; /* \033[<len><func char> */
+		a_len +=3D len+3;
+	}
+	return a_len;
+}
+
+static void layout(const struct column_layout *c,
+		   int total_width, int padding,
+		   int *width,
+		   int *rows, int *cols)
+{
+	int i;
+
+	*width =3D 0;
+	/* Find maximum column width */
+	for (i =3D 0; i < c->items.nr; i++) {
+		const char *s =3D c->items.items[i].string;
+		int len =3D item_length(c, s);
+		if (*width < len)
+			*width =3D len;
+	}
+	*width +=3D padding;
+
+	*cols =3D total_width / *width;
+	if (*cols =3D=3D 0)
+		*cols =3D 1;
+	/* items.nr <=3D rows*cols -> rows >=3D items.nr/cols */
+	*rows =3D c->items.nr / *cols;
+	if (c->items.nr > *rows * *cols)
+		(*rows)++;
+}
+
+static int squeeze_columns(const struct column_layout *c,
+			   int *width, int padding,
+			   int rows, int cols)
+{
+	int x, y, i, len, item_len, spare =3D 0;
+	const char *s;
+
+	for (x =3D 0; x < cols; x++) {
+		for (y =3D len =3D 0; y < rows; y++) {
+			i =3D x * rows + y;
+			if (i >=3D c->items.nr)
+				break;
+			s =3D c->items.items[i].string;
+			item_len =3D item_length(c, s);
+			if (len < item_len)
+				len =3D item_len;
+		}
+		len +=3D padding;
+		if (len < width[x]) {
+			spare +=3D width[x] - len;
+			width[x] =3D len;
+		}
+	}
+	return spare;
+}
+
+static void relayout(const struct column_layout *c,
+		     int padding, int spare,
+		     int *initial_width, int **width,
+		     int *rows, int *cols)
+{
+	int new_rows, new_cols, new_initial_width;
+	int i, *new_width, new_spare, total_width;
+
+	/*
+	 * Assume all columns have same width, we would need
+	 * initial_width*cols. But then after squeezing, we have
+	 * "spare" more chars. Assume a new total_width with
+	 * additional chars, then re-squeeze to see if it fits
+	 * c->width.
+	 */
+	total_width =3D (*initial_width)*(*cols) + spare;
+	layout(c, total_width, padding,
+	       &new_initial_width, &new_rows, &new_cols);
+	new_width =3D xmalloc(sizeof(*new_width) * new_cols);
+	for (i =3D 0; i < new_cols; i++)
+		new_width[i] =3D new_initial_width;
+	new_spare =3D squeeze_columns(c, new_width, padding, new_rows, new_co=
ls);
+
+	/* Does it fit? */
+	if (total_width - new_spare < c->width) {
+		free(*width);
+		*width =3D new_width;
+		*initial_width =3D new_initial_width;
+		*rows =3D new_rows;
+		*cols =3D new_cols;
+	}
+}
+
+static void display_columns_first(const struct column_layout *c,
+				  int padding, const char *indent)
+{
+	int x, y, i, cols, rows, initial_width, *width;
+	char *empty_cell;
+
+	layout(c, c->width, padding, &initial_width, &rows, &cols);
+	width =3D xmalloc(sizeof(*width) * cols);
+	for (i =3D 0; i < cols; i++)
+		width[i] =3D initial_width;
+
+	if (c->mode & COL_DENSE) {
+		int spare =3D squeeze_columns(c, width, padding, rows, cols);
+		/* is it worth relayout? */
+		if (spare >=3D initial_width/2)
+			relayout(c, padding, spare,
+				 &initial_width, &width, &rows, &cols);
+	}
+
+	empty_cell =3D xmalloc(initial_width + 1);
+	memset(empty_cell, ' ', initial_width);
+	empty_cell[initial_width] =3D '\0';
+	for (y =3D 0; y < rows; y++) {
+		for (x =3D 0; x < cols; x++) {
+			const char *s;
+			int len;
+
+			i =3D x * rows + y;
+			if (i >=3D c->items.nr)
+				break;
+			s =3D c->items.items[i].string;
+			len =3D item_length(c, s);
+			if (width[x] < initial_width)
+				len +=3D initial_width - width[x];
+
+			printf("%s%s%s",
+			       x =3D=3D 0 ? indent : "",
+			       c->items.items[i].string,
+			       /* If the next column at same row is
+				  out of range, end the line. Else pad
+				  some space.  */
+			       i + rows >=3D c->items.nr ? "\n" : empty_cell + len);
+		}
+	}
+}
+
+static void display_plain(const struct column_layout *c, const char *i=
ndent)
+{
+	int i;
+
+	for (i =3D 0; i < c->items.nr; i++)
+		printf("%s%s\n", indent, c->items.items[i].string);
+}
+
+void display_columns(const struct column_layout *c, int padding, const=
 char *indent)
+{
+	int mode =3D c->mode & COL_MODE;
+	if (!indent)
+		indent =3D "";
+	if (c->width <=3D 1)
+		mode =3D COL_PLAIN;
+	switch (mode) {
+	case COL_PLAIN:
+		display_plain(c, indent);
+		break;
+
+	case COL_COLUMN_FIRST:
+		display_columns_first(c, padding, indent);
+		break;
+	default:
+		die("BUG: invalid mode %d", c->mode & COL_MODE);
+	}
+}
diff --git a/column.h b/column.h
new file mode 100644
index 0000000..34435b0
--- /dev/null
+++ b/column.h
@@ -0,0 +1,20 @@
+#ifndef COLUMN_H
+#define COLUMN_H
+
+#include "string-list.h"
+
+#define COL_MODE          0x000F
+#define COL_PLAIN         0 /* Single column */
+#define COL_COLUMN_FIRST  1 /* Fill columns before rows */
+#define COL_ANSI          (1 << 4) /* Remove ANSI from string length *=
/
+#define COL_DENSE         (1 << 5) /* "Ragged-right" mode, relayout if=
 enough space */
+
+struct column_layout {
+	int mode;
+	int width;
+	struct string_list items;
+};
+
+extern void display_columns(const struct column_layout *c, int padding=
, const char *indent);
+
+#endif
diff --git a/t/t9002-column.sh b/t/t9002-column.sh
new file mode 100755
index 0000000..1d030b0
--- /dev/null
+++ b/t/t9002-column.sh
@@ -0,0 +1,108 @@
+#!/bin/sh
+
+test_description=3D'git column'
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	cat >lista <<\EOF
+one
+two
+three
+four
+five
+six
+seven
+eight
+nine
+ten
+eleven
+EOF
+'
+
+test_expect_success '80 columns' '
+	cat >expected <<\EOF &&
+one    two    three  four   five   six    seven  eight  nine   ten    =
eleven
+EOF
+	COLUMNS=3D80 test-column < lista > actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'COLUMNS =3D 1' '
+	cat >expected <<\EOF &&
+one
+two
+three
+four
+five
+six
+seven
+eight
+nine
+ten
+eleven
+EOF
+	COLUMNS=3D1 test-column < lista > actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'width =3D 1' '
+	test-column --width=3D1 < lista > actual &&
+	test_cmp expected actual
+'
+
+COLUMNS=3D20
+export COLUMNS
+
+test_expect_success '20 columns' '
+	cat >expected <<\EOF &&
+one    seven
+two    eight
+three  nine
+four   ten
+five   eleven
+six
+EOF
+	test-column < lista > actual &&
+	test_cmp expected actual
+'
+
+test_expect_success '20 columns, densed' '
+	cat >expected <<\EOF &&
+one   seven
+two   eight
+three nine
+four  ten
+five  eleven
+six
+EOF
+	test-column --mode=3Dcolumn,dense < lista > actual &&
+	test_cmp expected actual
+'
+
+test_expect_success '20 columns, padding 2' '
+	cat >expected <<\EOF &&
+one     seven
+two     eight
+three   nine
+four    ten
+five    eleven
+six
+EOF
+	test-column --padding 2 < lista > actual &&
+	test_cmp expected actual
+'
+
+test_expect_success '20 columns, left indented' '
+	cat >expected <<\EOF &&
+  one    seven
+  two    eight
+  three  nine
+  four   ten
+  five   eleven
+  six
+EOF
+	test-column --left=3D2 < lista > actual &&
+	test_cmp expected actual
+'
+
+test_done
diff --git a/test-column.c b/test-column.c
new file mode 100644
index 0000000..4f56cd8
--- /dev/null
+++ b/test-column.c
@@ -0,0 +1,59 @@
+#include "cache.h"
+#include "strbuf.h"
+#include "parse-options.h"
+#include "column.h"
+
+static const char * const builtin_column_usage[] =3D {
+	"git column [--mode=3D<mode>] [--width=3D<width>] [--left-space=3D<N>=
] [--right-space=3D<N>]",
+	NULL
+};
+
+int main(int argc, const char **argv)
+{
+	struct column_layout c;
+	const char *mode =3D NULL;
+	struct strbuf sb =3D STRBUF_INIT;
+	int left_space =3D 0, right_space =3D 0, padding =3D 1;
+	int term_width =3D term_columns();
+	struct option options[] =3D {
+		OPT_INTEGER(0, "width", &term_width, "Maximum width"),
+		OPT_INTEGER(0, "left", &left_space, "Padding space on left border"),
+		OPT_INTEGER(0, "right", &right_space, "Padding space on right border=
"),
+		OPT_INTEGER(0, "padding", &padding, "Padding space between columns")=
,
+		OPT_STRING(0, "mode", &mode, "mode", "Which layout mode to use"),
+		OPT_END()
+	};
+
+	argc =3D parse_options(argc, argv, "", options, builtin_column_usage,=
 0);
+
+	memset(&c, 0, sizeof(c));
+	c.width =3D term_width - right_space - left_space;
+	c.items.strdup_strings =3D 1;
+
+	while (mode && *mode) {
+		int len =3D strcspn(mode, ",");
+		if (len =3D=3D 6 && !strncmp(mode, "column", len))
+			c.mode |=3D COL_COLUMN_FIRST;
+		else if (len =3D=3D 5 && !strncmp(mode, "dense", len))
+			c.mode |=3D COL_DENSE;
+		else if (len =3D=3D 4 && !strncmp(mode, "ansi", len))
+			c.mode |=3D COL_ANSI;
+		else
+			die("Unknown mode %s", mode);
+		mode +=3D len;
+		while (*mode =3D=3D ',')
+			mode++;
+	}
+	if (!c.mode)
+		c.mode =3D COL_COLUMN_FIRST;
+	if ((c.mode & COL_MODE) =3D=3D 0)
+		die("Invalid mode '%s'", mode);
+
+	while (!strbuf_getline(&sb, stdin, '\n'))
+		string_list_append(&c.items, sb.buf);
+
+	strbuf_setlen(&sb, left_space);
+	memset(sb.buf, ' ', left_space);
+	display_columns(&c, padding, sb.buf);
+	return 0;
+}
--=20
1.7.2.2
