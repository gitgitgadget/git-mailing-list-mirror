From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 05/12] Add builtin command "column"
Date: Sun,  7 Mar 2010 19:09:38 +0700
Message-ID: <1267963785-473-6-git-send-email-pclouds@gmail.com>
References: <1267963785-473-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 07 13:13:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoFMa-0006M7-Eh
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 13:13:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754024Ab0CGMN0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Mar 2010 07:13:26 -0500
Received: from mail-px0-f188.google.com ([209.85.216.188]:40434 "EHLO
	mail-px0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753998Ab0CGMNY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Mar 2010 07:13:24 -0500
Received: by pxi26 with SMTP id 26so1786133pxi.1
        for <git@vger.kernel.org>; Sun, 07 Mar 2010 04:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=izHjnLRadae93Afbn+8qpbBBVwq19SVVX8YbV1rxZME=;
        b=Xdnaae1TOokhU3rDZpL4uaAkxZP9tjwwZ2BGEAR0YwUN39ymrKaGTysqFuJK+ub+l2
         NnZlu2NassAvGPUB/McqZalSWjYEpUJmmaXpwNb6Rs53UvYDzU12BWtQbVW6pCTY3h+8
         jc+H5vDFWA6xHIsC5YzPGKCi0AUv+cm2BH4hQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=ufp34xVZ9cY+nFB8w1uZQvMgqYRUJ92K7P8REn32tAUdkRr4zuFhPO4CoX2zCVRkxE
         sP0fLExnxee+pmgmXwr/t+ehxz78HnLk1LX/ZSOkuu2eRfYHRcata1RZKaI8nviE1VWg
         TI9v9qeEkpbH3rokm4DerKCh5MWqWvaRX+pKY=
Received: by 10.142.119.26 with SMTP id r26mr2299617wfc.320.1267964003959;
        Sun, 07 Mar 2010 04:13:23 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.223.3])
        by mx.google.com with ESMTPS id 20sm3640042pzk.3.2010.03.07.04.13.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Mar 2010 04:13:23 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun,  7 Mar 2010 19:10:08 +0700
X-Mailer: git-send-email 1.7.0.1.370.gd3c5
In-Reply-To: <1267963785-473-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141675>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-column.txt |   40 ++++++++++++++++
 Makefile                     |    1 +
 builtin.h                    |    1 +
 builtin/column.c             |   42 +++++++++++++++++
 git.c                        |    1 +
 t/t9002-column.sh            |  101 ++++++++++++++++++++++++++++++++++=
++++++++
 6 files changed, 186 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-column.txt
 create mode 100644 builtin/column.c
 create mode 100755 t/t9002-column.sh

diff --git a/Documentation/git-column.txt b/Documentation/git-column.tx=
t
new file mode 100644
index 0000000..3ee887f
--- /dev/null
+++ b/Documentation/git-column.txt
@@ -0,0 +1,40 @@
+git-column(1)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+NAME
+----
+git-column - Columnate lists
+
+SYNOPSIS
+--------
+[verse]
+'git column' [--mode=3D<mode>] [--width=3D<width>] [--left-space=3D<N>=
] [--right-space=3D<N>]
+
+DESCRIPTION
+-----------
+This command formats its input into multiple columns. Rows are filled =
before
+columns.
+
+OPTIONS
+-------
+--width=3D<width>::
+	Specify the terminal width. By default 'git column' will detect the
+	terminal width, or fall back to 80 if it is unable to do so.
+
+--left-space=3D<N>::
+	Prepend a number of spaces on the first column.
+
+--right-space=3D<N>::
+	Append a number of spaces after the last column.
+
+--mode=3D<mode>::
+	Which layout mode to use. Supported modes are 'row' (default mode,
+	fill rows first) and 'column' (fill columns first)
+
+Author
+------
+Written by Nguyen Thai Ngoc Duy <pclouds@gmail.com>
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index 337f5bf..53686a2 100644
--- a/Makefile
+++ b/Makefile
@@ -640,6 +640,7 @@ BUILTIN_OBJS +=3D builtin/checkout-index.o
 BUILTIN_OBJS +=3D builtin/checkout.o
 BUILTIN_OBJS +=3D builtin/clean.o
 BUILTIN_OBJS +=3D builtin/clone.o
+BUILTIN_OBJS +=3D builtin/column.o
 BUILTIN_OBJS +=3D builtin/commit-tree.o
 BUILTIN_OBJS +=3D builtin/commit.o
 BUILTIN_OBJS +=3D builtin/config.o
diff --git a/builtin.h b/builtin.h
index cdf9847..c68c758 100644
--- a/builtin.h
+++ b/builtin.h
@@ -39,6 +39,7 @@ extern int cmd_cherry(int argc, const char **argv, co=
nst char *prefix);
 extern int cmd_cherry_pick(int argc, const char **argv, const char *pr=
efix);
 extern int cmd_clone(int argc, const char **argv, const char *prefix);
 extern int cmd_clean(int argc, const char **argv, const char *prefix);
+extern int cmd_column(int argc, const char **argv, const char *prefix)=
;
 extern int cmd_commit(int argc, const char **argv, const char *prefix)=
;
 extern int cmd_commit_tree(int argc, const char **argv, const char *pr=
efix);
 extern int cmd_count_objects(int argc, const char **argv, const char *=
prefix);
diff --git a/builtin/column.c b/builtin/column.c
new file mode 100644
index 0000000..d5d7f80
--- /dev/null
+++ b/builtin/column.c
@@ -0,0 +1,42 @@
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
+int cmd_column(int argc, const char **argv, const char *prefix)
+{
+	struct columnizer cp;
+	const char *mode =3D NULL;
+	struct strbuf sb =3D STRBUF_INIT;
+	struct option options[] =3D {
+		OPT_INTEGER(0, "width", &cp.terminal_width, "Maximum width"),
+		OPT_INTEGER(0, "left-space", &cp.left_space, "Padding space on left =
border"),
+		OPT_INTEGER(0, "right-space", &cp.right_space, "Padding space on rig=
ht border"),
+		OPT_STRING(0, "mode", &mode, "mode", "Which layout mode to use"),
+		OPT_END()
+	};
+
+	memset(&cp, 0, sizeof(cp));
+	cp.space =3D 1;
+	cp.detach =3D free;
+
+	argc =3D parse_options(argc, argv, prefix, options, builtin_column_us=
age, 0);
+
+	if (!mode || !strcmp(mode, "column"))
+		cp.flags =3D COLUMNIZER_COLUMN_FIRST | COLUMNIZER_HAVE_ANSI | COLUMN=
IZER_HOMOGENEOUS;
+	else if (!strcmp(mode, "row"))
+		cp.flags =3D COLUMNIZER_ROW_FIRST | COLUMNIZER_HAVE_ANSI | COLUMNIZE=
R_HOMOGENEOUS;
+	else
+		die("Invalid mode '%s'", mode);
+
+	while (!strbuf_getline(&sb, stdin, '\n'))
+		feed_columnizer(&cp, strbuf_detach(&sb, NULL));
+
+	feed_columnizer(&cp, NULL);
+	return 0;
+}
diff --git a/git.c b/git.c
index 6bae305..8dc6fdd 100644
--- a/git.c
+++ b/git.c
@@ -301,6 +301,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "cherry-pick", cmd_cherry_pick, RUN_SETUP | NEED_WORK_TREE },
 		{ "clone", cmd_clone },
 		{ "clean", cmd_clean, RUN_SETUP | NEED_WORK_TREE },
+		{ "column", cmd_column },
 		{ "commit", cmd_commit, RUN_SETUP | NEED_WORK_TREE },
 		{ "commit-tree", cmd_commit_tree, RUN_SETUP },
 		{ "config", cmd_config },
diff --git a/t/t9002-column.sh b/t/t9002-column.sh
new file mode 100755
index 0000000..b5b46fc
--- /dev/null
+++ b/t/t9002-column.sh
@@ -0,0 +1,101 @@
+#!/bin/sh
+
+test_description=3D'git column'
+. ./test-lib.sh
+
+cat >lista <<\EOF
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
+EOF
+
+cat >expected <<\EOF
+one   two   three four  five  six   seven eight nine  ten  =20
+EOF
+test_expect_success '80 columns' '
+	COLUMNS=3D80 git column < lista > actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<\EOF
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
+EOF
+test_expect_success '1 column' '
+	COLUMNS=3D1 git column < lista > actual &&
+	test_cmp expected actual
+'
+
+test_expect_success '1 column (--width)' '
+	git column --width=3D1 < lista > actual &&
+	test_cmp expected actual
+'
+
+COLUMNS=3D20
+export COLUMNS
+
+cat >expected <<\EOF
+one   five  nine
+two   six   ten
+three seven=20
+four  eight=20
+EOF
+test_expect_success '20 columns' '
+	git column < lista > actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<\EOF
+one   two   three
+four  five  six
+seven eight nine
+ten  =20
+EOF
+test_expect_success '20 columns, row mode' '
+	git column --mode=3Drow < lista > actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'unsupported mode' '
+	test_must_fail git column --mode=3Dfoo
+'
+
+cat >expected <<\EOF
+  one   five  nine
+  two   six   ten
+  three seven=20
+  four  eight=20
+EOF
+test_expect_success '20 columns, left indented' '
+	git column --left-space=3D2 < lista > actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<\EOF
+one     six
+two     seven
+three   eight
+four    nine
+five    ten
+EOF
+test_expect_success '20 columns, right indented' '
+	git column --right-space=3D3 < lista > actual &&
+	test_cmp expected actual
+'
+
+test_done
--=20
1.7.0.1.370.gd3c5
