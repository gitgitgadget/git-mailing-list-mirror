From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/9] column: add functions to parse column settings
Date: Sun, 20 Mar 2011 19:57:47 +0700
Message-ID: <1300625873-18435-4-git-send-email-pclouds@gmail.com>
References: <1300625873-18435-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 20 13:58:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1IDS-0002un-D6
	for gcvg-git-2@lo.gmane.org; Sun, 20 Mar 2011 13:58:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752247Ab1CTM6i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Mar 2011 08:58:38 -0400
Received: from mail-px0-f179.google.com ([209.85.212.179]:44481 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752243Ab1CTM6g (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2011 08:58:36 -0400
Received: by pxi2 with SMTP id 2so1015892pxi.10
        for <git@vger.kernel.org>; Sun, 20 Mar 2011 05:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=/fGJiqR13N4D3IZOyWewwWwoBWK6LA050fWawTIo57M=;
        b=PuRmrkddbgrCrSu0sKuM4pFGrDOYgbmVavZzuv31zsRaXbW9JCDjz3EZ+p2ke0gS7u
         GH6Jelicoy4G+xwbTpf9L4KwPz9YwmpRIPKtXv55AxBFUNVwcjv6Ui86Xe5jlRiO3kT2
         5aljqA0yYKqnXBV8ehmoSybYVoAzFyy1hgB1w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=MULmSLym1X3wqpSFbWo+2BAux2G/hho3UbDukPQv9XMHND7AVbBbOrPyU0jRdVkbHs
         vy4XzM4YFqggC7JuCjAvFtl2lGD9z0ta9SH/ltk9Me0kHKE9WMaC1GoOUx7P/NiZe26B
         +CGcfJ+rOml6sIcn/TgnxgS2rO3S8xmQyozDQ=
Received: by 10.142.185.1 with SMTP id i1mr728783wff.95.1300625915910;
        Sun, 20 Mar 2011 05:58:35 -0700 (PDT)
Received: from tre ([115.73.209.201])
        by mx.google.com with ESMTPS id p40sm5844991wfc.5.2011.03.20.05.58.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 20 Mar 2011 05:58:34 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Sun, 20 Mar 2011 19:58:25 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
In-Reply-To: <1300625873-18435-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169505>

A column option string consists of many token separated by either
space of commas. A token belongs to one of three groups:

 - enabling: always, never and auto
 - layout mode: to be implemented
 - other tuning, which could be negated be prefix 'no'

A command line option without argument (e.g. --column) will enable
column output and reuse existing settings (layout mode and options..).
--no-column disables columnar output.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 .gitignore        |    1 +
 Makefile          |    1 +
 column.c          |  125 +++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 column.h          |    4 ++
 parse-options.h   |    2 +
 t/t9002-column.sh |   27 +++++++++++
 test-column.c     |   39 ++++++++++++++++
 7 files changed, 199 insertions(+), 0 deletions(-)
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
index 94e1cf0..ba9944b 100644
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
diff --git a/column.c b/column.c
index 8422c89..b32b9f9 100644
--- a/column.c
+++ b/column.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "column.h"
 #include "string-list.h"
+#include "parse-options.h"
=20
 #define MODE(mode) ((mode) & COL_MODE)
=20
@@ -35,3 +36,127 @@ void display_columns(const struct string_list *list=
, int mode,
 	}
 	die("BUG: invalid mode %d", MODE(mode));
 }
+
+struct colopt {
+	enum {
+		ENABLE,
+		MODE,
+		OPTION
+	} type;
+	const char *name;
+	int value;
+};
+
+/*
+ * Set COL_ENABLED and COL_ENABLED_SET. If 'set' is -1, check if
+ * stdout is tty.
+ */
+static int set_enable_bit(int *mode, int set, int stdout_is_tty)
+{
+	if (set < 0) {	/* auto */
+		if (stdout_is_tty < 0)
+			stdout_is_tty =3D isatty(1);
+		set =3D stdout_is_tty || (pager_in_use() && pager_use_color);
+	}
+	if (set)
+		*mode =3D *mode | COL_ENABLED | COL_ENABLED_SET;
+	else
+		*mode =3D (*mode & ~COL_ENABLED) | COL_ENABLED_SET;
+	return 0;
+}
+
+/*
+ * Set COL_MODE_*. mode is intially copied from column.ui. If
+ * COL_ENABLED_SET is not set, then neither 'always', 'never' nor
+ * 'auto' has been used. Default to 'always'.
+ */
+static int set_mode(int *mode, int value)
+{
+	*mode =3D (*mode & ~COL_MODE) | value;
+	if (!(*mode & COL_ENABLED_SET))
+		*mode |=3D COL_ENABLED | COL_ENABLED_SET;
+
+	return 0;
+}
+
+/* Set or unset other COL_* */
+static int set_option(int *mode, int opt, int set)
+{
+	if (set)
+		*mode |=3D opt;
+	else
+		*mode &=3D ~opt;
+	return 0;
+}
+
+static int parse_option(const char *arg, int len,
+			int *mode, int stdout_is_tty)
+{
+	struct colopt opts[] =3D {
+		{ ENABLE, "always",  1 },
+		{ ENABLE, "never",   0 },
+		{ ENABLE, "auto",   -1 },
+	};
+	int i, set, name_len;
+
+	for (i =3D 0; i < ARRAY_SIZE(opts); i++) {
+		if (opts[i].type =3D=3D OPTION) {
+			if (len > 2 && !strncmp(arg, "no", 2)) {
+				arg +=3D 2;
+				len -=3D 2;
+				set =3D 0;
+			}
+			else
+				set =3D 1;
+		}
+
+		name_len =3D strlen(opts[i].name);
+		if (len !=3D name_len ||
+		    strncmp(arg, opts[i].name, name_len))
+			continue;
+
+		switch (opts[i].type) {
+		case ENABLE: return set_enable_bit(mode, opts[i].value,
+						   stdout_is_tty);
+		case MODE: return set_mode(mode, opts[i].value);
+		case OPTION: return set_option(mode, opts[i].value, set);
+		default: die("BUG: Unknown option type %d", opts[i].type);
+		}
+	}
+
+	return error("unsupported style '%s'", arg);
+}
+
+static int parse_string(int *mode, const char *value,
+			int stdout_is_tty)
+{
+	const char *sep =3D " ,";
+
+	while (*value) {
+		int len =3D strcspn(value, sep);
+		if (len) {
+			if (parse_option(value, len, mode, stdout_is_tty))
+				return -1;
+
+			value +=3D len;
+		}
+		value +=3D strspn(value, sep);
+	}
+	return 0;
+}
+
+int parseopt_column_callback(const struct option *opt,
+			     const char *arg, int unset)
+{
+	int *mode =3D opt->value;
+	if (unset) {
+		*mode =3D (*mode & ~COL_ENABLED) | COL_ENABLED_SET;
+		return 0;
+	}
+	if (arg)
+		return parse_string(mode, arg, -1);
+
+	/* no arg, turn it on */
+	*mode |=3D COL_ENABLED | COL_ENABLED_SET;
+	return 0;
+}
diff --git a/column.h b/column.h
index ffae87c..a8b24e8 100644
--- a/column.h
+++ b/column.h
@@ -3,9 +3,13 @@
=20
 #define COL_MODE          0x000F
 #define COL_ENABLED      (1 << 4)
+#define COL_ENABLED_SET  (1 << 5)  /* Has COL_ENABLED been set? */
=20
 extern int term_columns(void);
 extern struct string_list_item *add_to_columns(struct string_list *lis=
t, int mode, const char *string);
 extern void display_columns(const struct string_list *list, int mode, =
int width, int padding, const char *indent);
=20
+struct option;
+extern int parseopt_column_callback(const struct option *opt, const ch=
ar *arg, int unset);
+
 #endif
diff --git a/parse-options.h b/parse-options.h
index 31ec5d2..14816b6 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -220,5 +220,7 @@ extern int parse_opt_tertiary(const struct option *=
, const char *, int);
 	  PARSE_OPT_OPTARG, &parse_opt_abbrev_cb, 0 }
 #define OPT__COLOR(var, h) \
 	OPT_COLOR_FLAG(0, "color", (var), (h))
+#define OPT_COLUMN(s, l, v, h) \
+	{ OPTION_CALLBACK, (s), (l), (v), "style", (h), PARSE_OPT_OPTARG, par=
seopt_column_callback }
=20
 #endif
diff --git a/t/t9002-column.sh b/t/t9002-column.sh
new file mode 100755
index 0000000..099a29f
--- /dev/null
+++ b/t/t9002-column.sh
@@ -0,0 +1,27 @@
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
+test_expect_success 'never' '
+	test-column --mode=3Dnever <lista >actual &&
+	test_cmp lista actual
+'
+
+test_done
diff --git a/test-column.c b/test-column.c
new file mode 100644
index 0000000..d6321a4
--- /dev/null
+++ b/test-column.c
@@ -0,0 +1,39 @@
+#include "cache.h"
+#include "strbuf.h"
+#include "parse-options.h"
+#include "string-list.h"
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
+	struct string_list list =3D STRING_LIST_INIT_DUP;
+	int mode =3D 0;
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
+		OPT_COLUMN(0, "mode", &mode, "layout to use"),
+		OPT_END()
+	};
+
+	argc =3D parse_options(argc, argv, "", options, builtin_column_usage,=
 0);
+
+	while (!strbuf_getline(&sb, stdin, '\n'))
+		string_list_append(&list, sb.buf);
+
+	strbuf_setlen(&sb, left_space);
+	memset(sb.buf, ' ', left_space);
+	display_columns(&list, mode,
+			term_width - right_space - left_space,
+			padding, sb.buf);
+	return 0;
+}
--=20
1.7.4.74.g639db
