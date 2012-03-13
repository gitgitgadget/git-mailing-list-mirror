From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v7 03/9] column: add columnar layout
Date: Tue, 13 Mar 2012 19:09:15 +0700
Message-ID: <c439d91ff126e2a9d7fe627de7346e19801dd6d4.1331638663.git.pclouds@gmail.com>
References: <1330430331-19945-1-git-send-email-pclouds@gmail.com> <cover.1331638663.git.pclouds@gmail.com> <1294ed94f981a7029b47a44143c3eb9fb6b820f1.1331638663.git.pclouds@gmail.com> <dd6e9c2189fb4502aaf9f7368cb7f13216961cfa.1331638663.git.pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 13 13:07:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7QVF-0005Sj-8E
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 13:06:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755452Ab2CMMGj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Mar 2012 08:06:39 -0400
Received: from mail-pz0-f52.google.com ([209.85.210.52]:59624 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754463Ab2CMMGi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2012 08:06:38 -0400
Received: by mail-pz0-f52.google.com with SMTP id p12so885281dad.11
        for <git@vger.kernel.org>; Tue, 13 Mar 2012 05:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=c/zPVUKqnXl36d6P3YnBgEOZ07oTD9bHh7md4G+Y69s=;
        b=HlZ7IsMFli8Obf52kDnulICMS3qURpRRbZ+z2iAi3cfXTgWc2F8HxloggDBdErVr5J
         RyLzh8lsWYfyP7D7FuhlcEgsfhTuTRTBDKJuS8rgR8rN6cUvyxd/xms7ZYjMsBIQOlWV
         VE2Cgt95o0iIByiy9uqDgjH8rsek2d2r20vupsWFN3q3IkC4kp5ADPZy4IcfdFyOWuWK
         iIMFkxeZjrYQHctvrY8qiRWMIXWEo1HSVG7yTiTEdpj3XoC4CdOdtRU4cT1orMOef3o0
         ltyaAgiGJWDt2lBd18Q6egIi7eCSJ4LqX3rczGFjrXpVnn2EOmUvWiqFsdDjrGxBTioD
         +Z2Q==
Received: by 10.68.194.3 with SMTP id hs3mr5894065pbc.119.1331640397906;
        Tue, 13 Mar 2012 05:06:37 -0700 (PDT)
Received: from tre ([115.74.61.175])
        by mx.google.com with ESMTPS id m5sm627094pbo.69.2012.03.13.05.06.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 13 Mar 2012 05:06:36 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Tue, 13 Mar 2012 19:09:45 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <dd6e9c2189fb4502aaf9f7368cb7f13216961cfa.1331638663.git.pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193000>

COL_COLUMN and COL_ROW fill column by column (or row by row
respectively), given the terminal width and how many space between
columns. All cells have equal width.

Strings are supposed to be in UTF-8. Valid ANSI escape strings are OK.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/config.txt |    4 ++
 column.c                 |  114 ++++++++++++++++++++++++++++++++++++++=
++++++++
 column.h                 |    2 +
 t/t9002-column.sh        |   86 ++++++++++++++++++++++++++++++++++
 4 files changed, 206 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 147c41c..d1d74a1 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -833,6 +833,10 @@ column.ui::
 	never show in columns
 `auto`;;
 	show in columns if the output is to the terminal
+`column`;;
+	fill columns before rows (default)
+`row`;;
+	fill rows before columns
 `plain`;;
 	show in one column
 --
diff --git a/column.c b/column.c
index f0877c0..17c2479 100644
--- a/column.c
+++ b/column.c
@@ -2,6 +2,59 @@
 #include "column.h"
 #include "string-list.h"
 #include "parse-options.h"
+#include "utf8.h"
+
+#define XY2LINEAR(d, x, y) (COL_LAYOUT((d)->colopts) =3D=3D COL_COLUMN=
 ? \
+			    (x) * (d)->rows + (y) : \
+			    (y) * (d)->cols + (x))
+
+struct column_data {
+	const struct string_list *list;
+	unsigned int colopts;
+	struct column_options opts;
+
+	int rows, cols;
+	int *len;		/* cell length */
+};
+
+/* return length of 's' in letters, ANSI escapes stripped */
+static int item_length(unsigned int colopts, const char *s)
+{
+	int len, i =3D 0;
+	struct strbuf str =3D STRBUF_INIT;
+
+	strbuf_addstr(&str, s);
+	while ((s =3D strstr(str.buf + i, "\033[")) !=3D NULL) {
+		int len =3D strspn(s + 2, "0123456789;");
+		i =3D s - str.buf;
+		strbuf_remove(&str, i, len + 3); /* \033[<len><func char> */
+	}
+	len =3D utf8_strwidth(str.buf);
+	strbuf_release(&str);
+	return len;
+}
+
+/*
+ * Calculate cell width, rows and cols for a table of equal cells, giv=
en
+ * table width and how many spaces between cells.
+ */
+static void layout(struct column_data *data, int *width)
+{
+	int i;
+
+	*width =3D 0;
+	for (i =3D 0; i < data->list->nr; i++)
+		if (*width < data->len[i])
+			*width =3D data->len[i];
+
+	*width +=3D data->opts.padding;
+
+	data->cols =3D (data->opts.width - strlen(data->opts.indent)) / *widt=
h;
+	if (data->cols =3D=3D 0)
+		data->cols =3D 1;
+
+	data->rows =3D DIV_ROUND_UP(data->list->nr, data->cols);
+}
=20
 /* Display without layout when not enabled */
 static void display_plain(const struct string_list *list,
@@ -13,6 +66,61 @@ static void display_plain(const struct string_list *=
list,
 		printf("%s%s%s", indent, list->items[i].string, nl);
 }
=20
+/* Print a cell to stdout with all necessary leading/traling space */
+static int display_cell(struct column_data *data, int initial_width,
+			const char *empty_cell, int x, int y)
+{
+	int i, len, newline;
+
+	i =3D XY2LINEAR(data, x, y);
+	if (i >=3D data->list->nr)
+		return -1;
+	len =3D data->len[i];
+	if (COL_LAYOUT(data->colopts) =3D=3D COL_COLUMN)
+		newline =3D i + data->rows >=3D data->list->nr;
+	else
+		newline =3D x =3D=3D data->cols - 1 || i =3D=3D data->list->nr - 1;
+
+	printf("%s%s%s",
+	       x =3D=3D 0 ? data->opts.indent : "",
+	       data->list->items[i].string,
+	       newline ? data->opts.nl : empty_cell + len);
+	return 0;
+}
+
+/* Display COL_COLUMN or COL_ROW */
+static void display_table(const struct string_list *list,
+			  unsigned int colopts,
+			  const struct column_options *opts)
+{
+	struct column_data data;
+	int x, y, i, initial_width;
+	char *empty_cell;
+
+	memset(&data, 0, sizeof(data));
+	data.list =3D list;
+	data.colopts =3D colopts;
+	data.opts =3D *opts;
+
+	data.len =3D xmalloc(sizeof(*data.len) * list->nr);
+	for (i =3D 0; i < list->nr; i++)
+		data.len[i] =3D item_length(colopts, list->items[i].string);
+
+	layout(&data, &initial_width);
+
+	empty_cell =3D xmalloc(initial_width + 1);
+	memset(empty_cell, ' ', initial_width);
+	empty_cell[initial_width] =3D '\0';
+	for (y =3D 0; y < data.rows; y++) {
+		for (x =3D 0; x < data.cols; x++)
+			if (display_cell(&data, initial_width, empty_cell, x, y))
+				break;
+	}
+
+	free(data.len);
+	free(empty_cell);
+}
+
 void print_columns(const struct string_list *list, unsigned int colopt=
s,
 		   const struct column_options *opts)
 {
@@ -35,6 +143,10 @@ void print_columns(const struct string_list *list, =
unsigned int colopts,
 	case COL_PLAIN:
 		display_plain(list, nopts.indent, nopts.nl);
 		break;
+	case COL_ROW:
+	case COL_COLUMN:
+		display_table(list, colopts, &nopts);
+		break;
 	default:
 		die("BUG: invalid layout mode %d", COL_LAYOUT(colopts));
 	}
@@ -69,6 +181,8 @@ static int parse_option(const char *arg, int len, un=
signed int *colopts,
 		{ "never",  COL_DISABLED, COL_ENABLE_MASK },
 		{ "auto",   COL_AUTO,     COL_ENABLE_MASK },
 		{ "plain",  COL_PLAIN,    COL_LAYOUT_MASK },
+		{ "column", COL_COLUMN,   COL_LAYOUT_MASK },
+		{ "row",    COL_ROW,      COL_LAYOUT_MASK },
 	};
 	int i;
=20
diff --git a/column.h b/column.h
index 778a71c..79ac50d 100644
--- a/column.h
+++ b/column.h
@@ -11,6 +11,8 @@
 #define COL_AUTO          0x0020
=20
 #define COL_LAYOUT(c) ((c) & COL_LAYOUT_MASK)
+#define COL_COLUMN             0   /* Fill columns before rows */
+#define COL_ROW                1   /* Fill rows before columns */
 #define COL_PLAIN             15   /* one column */
=20
 #define explicitly_enable_column(c) \
diff --git a/t/t9002-column.sh b/t/t9002-column.sh
index a7f3cd9..ec288ae 100755
--- a/t/t9002-column.sh
+++ b/t/t9002-column.sh
@@ -42,4 +42,90 @@ EOF
 	test_cmp expected actual
 '
=20
+test_expect_success '80 columns' '
+	cat >expected <<\EOF &&
+one    two    three  four   five   six    seven  eight  nine   ten    =
eleven
+EOF
+	COLUMNS=3D80 git column --mode=3Dcolumn <lista >actual &&
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
+	COLUMNS=3D1 git column --mode=3Dcolumn <lista >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'width =3D 1' '
+	git column --mode=3Dcolumn --width=3D1 <lista >actual &&
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
+	git column --mode=3Dcolumn <lista >actual &&
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
+	git column --mode=3Dcolumn --padding 2 <lista >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success '20 columns, indented' '
+	cat >expected <<\EOF &&
+  one    seven
+  two    eight
+  three  nine
+  four   ten
+  five   eleven
+  six
+EOF
+	git column --mode=3Dcolumn --indent=3D"  " <lista >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success '20 columns, row first' '
+	cat >expected <<\EOF &&
+one    two
+three  four
+five   six
+seven  eight
+nine   ten
+eleven
+EOF
+	git column --mode=3Drow <lista >actual &&
+	test_cmp expected actual
+'
+
 test_done
--=20
1.7.8.36.g69ee2
