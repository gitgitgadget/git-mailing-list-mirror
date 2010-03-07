From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 03/12] Add columnizer
Date: Sun,  7 Mar 2010 19:09:36 +0700
Message-ID: <1267963785-473-4-git-send-email-pclouds@gmail.com>
References: <1267963785-473-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 07 13:14:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoFMZ-0006M7-AK
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 13:13:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753821Ab0CGMNS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Mar 2010 07:13:18 -0500
Received: from mail-pz0-f194.google.com ([209.85.222.194]:64105 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753931Ab0CGMNQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Mar 2010 07:13:16 -0500
Received: by mail-pz0-f194.google.com with SMTP id 32so2186152pzk.4
        for <git@vger.kernel.org>; Sun, 07 Mar 2010 04:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=OUnenOoAg2Qd+/lwBbhKrxvmda2V2OI1ETjh6F0A0hQ=;
        b=MN4pctz2rOtw10ciwUGMZl6C83fd91SPeTrjUS3MwahcitWvBRjfZpAm7i+irJZjok
         UOU1z1YBD+VcHNnDa4ll9rhopntshx8k8RKfg5Hjzapz/I/cpKxaIKNhVXenb99/HExa
         PDvvL5lQDuc+1pMcw9PZwO2gHeyYF2m/U6d0Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=s/iIKzyFAIqdtUyxsb4xk2ZoEi90ZRF7LbiHn2R+c0vm1tbe6+xqzwd4CKcUAMiL1G
         TpsUhVovOhQDF3F1aPlaBKPH+d/pRXNC8SqPUqCGam1arKXy3W3QUOv0tKSO/M4ndlIm
         Z2pk0sSMNUx5Ceq7ACCXJGAP874u7nr7kX3BU=
Received: by 10.140.56.1 with SMTP id e1mr802264rva.204.1267963995446;
        Sun, 07 Mar 2010 04:13:15 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.223.3])
        by mx.google.com with ESMTPS id 23sm3576812pzk.10.2010.03.07.04.13.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Mar 2010 04:13:14 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun,  7 Mar 2010 19:10:00 +0700
X-Mailer: git-send-email 1.7.0.1.370.gd3c5
In-Reply-To: <1267963785-473-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141680>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 .gitignore       |    1 +
 Makefile         |    2 +
 column.c         |  164 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 column.h         |   23 ++++++++
 command-list.txt |    1 +
 5 files changed, 191 insertions(+), 0 deletions(-)
 create mode 100644 column.c
 create mode 100644 column.h

diff --git a/.gitignore b/.gitignore
index 7b3acb7..8e087e6 100644
--- a/.gitignore
+++ b/.gitignore
@@ -25,6 +25,7 @@
 /git-cherry-pick
 /git-clean
 /git-clone
+/git-column
 /git-commit
 /git-commit-tree
 /git-config
diff --git a/Makefile b/Makefile
index 7358a20..337f5bf 100644
--- a/Makefile
+++ b/Makefile
@@ -454,6 +454,7 @@ LIB_H +=3D builtin.h
 LIB_H +=3D cache.h
 LIB_H +=3D cache-tree.h
 LIB_H +=3D color.h
+LIB_H +=3D column.h
 LIB_H +=3D commit.h
 LIB_H +=3D compat/bswap.h
 LIB_H +=3D compat/cygwin.h
@@ -526,6 +527,7 @@ LIB_OBJS +=3D branch.o
 LIB_OBJS +=3D bundle.o
 LIB_OBJS +=3D cache-tree.o
 LIB_OBJS +=3D color.o
+LIB_OBJS +=3D column.o
 LIB_OBJS +=3D combine-diff.o
 LIB_OBJS +=3D commit.o
 LIB_OBJS +=3D config.o
diff --git a/column.c b/column.c
new file mode 100644
index 0000000..0e88763
--- /dev/null
+++ b/column.c
@@ -0,0 +1,164 @@
+#include "cache.h"
+#include "column.h"
+
+static int ansi_length(const char *s)
+{
+	int a_len =3D 0;
+
+	while ((s =3D strstr(s, "\033[")) !=3D NULL) {
+		int len =3D strspn(s+2, "0123456789;");
+		s +=3D len+3; /* \033[<len><func char> */
+		a_len +=3D len+3;
+	}
+	return a_len;
+}
+
+static void print_row(struct columnizer *cp, int row)
+{
+	int mode =3D cp->flags & COLUMNIZER_MODE_MASK;
+	int j;
+
+	if (cp->left_space)
+		printf("%-*s", cp->left_space, "");
+
+	for (j =3D 0; j < cp->nr_cols; j++) {
+		int n, size;
+
+		switch (mode) {
+		case COLUMNIZER_COLUMN_FIRST:
+			n =3D j * cp->nr_rows + row;
+			size =3D cp->column_width;
+			break;
+		case COLUMNIZER_ROW_FIRST:
+			n =3D row * cp->nr_cols + j;
+			size =3D cp->column_width;
+			break;
+		}
+
+		if (n >=3D cp->cells_nr)
+			break;
+
+		size +=3D cp->space;
+		if (cp->flags & COLUMNIZER_HAVE_ANSI)
+			size +=3D ansi_length(cp->cells[n]);
+		if (j =3D=3D cp->nr_cols-1)
+			size =3D 1;
+		printf("%-*s", size, cp->cells[n]);
+	}
+	putchar('\n');
+}
+
+static void calculate_column_width(struct columnizer *cp)
+{
+	int max_cols, longest;
+
+	if (cp->flags & COLUMNIZER_READY)
+		return;
+
+	if (!cp->terminal_width)
+		cp->terminal_width =3D term_columns();
+
+	if (cp->column_width)
+		longest =3D cp->column_width;
+	else {
+		int i, len;
+		longest =3D 0;
+		for (i =3D 0; i < cp->cells_nr; i++) {
+			len =3D strlen(cp->cells[i]);
+			if (cp->flags & COLUMNIZER_HAVE_ANSI)
+				len -=3D ansi_length(cp->cells[i]);
+			if (longest < len)
+				longest =3D len;
+		}
+	}
+
+	max_cols =3D cp->terminal_width - 1; /* don't print *on* the edge */
+	max_cols -=3D cp->left_space + cp->right_space;
+
+	/* we don't have space after the last column */
+	max_cols +=3D cp->space;
+
+	cp->nr_cols =3D (longest + cp->space) < max_cols ? max_cols / (longes=
t + cp->space) : 1;
+	cp->nr_rows =3D DIV_ROUND_UP(cp->cells_nr, cp->nr_cols);
+	if (!cp->column_width)
+		cp->column_width =3D max_cols / cp->nr_cols - cp->space;
+	cp->flags |=3D COLUMNIZER_READY;
+}
+
+static int feed_cell(struct columnizer *cp, char *cell)
+{
+	int len;
+
+	/* Non-homogeneous column is not supported yet */
+	if (!(cp->flags & COLUMNIZER_HOMOGENEOUS))
+		return -1;
+
+	if (!cell) {		/* EOF */
+		int i;
+
+		calculate_column_width(cp);
+		for (i =3D 0;i < cp->nr_rows; i++)
+			print_row(cp, i);
+		return 0;
+	}
+
+	cp->cells_nr++;
+	ALLOC_GROW(cp->cells, cp->cells_nr, cp->cells_alloc);
+	cp->cells[cp->cells_nr-1] =3D cell;
+
+	len =3D strlen(cell);
+	if (cp->flags & COLUMNIZER_HAVE_ANSI)
+		len -=3D ansi_length(cell);
+
+	if (!cp->terminal_width)
+		cp->terminal_width =3D term_columns();
+	if (cp->longest < len)
+		cp->longest =3D len;
+
+	/* Can't have more than one column? */
+	if (cp->terminal_width < cp->left_space+cp->longest*2+cp->space+cp->r=
ight_space) {
+		int i;
+		for (i =3D 0;i < cp->cells_nr;i++) {
+			if (cp->left_space)
+				printf("%-*s", cp->left_space, "");
+			printf("%s\n", cp->cells[i]);
+			if (cp->detach)
+				cp->detach(cp->cells[i]);
+		}
+		free(cp->cells);
+		cp->cells_alloc =3D cp->cells_nr =3D 0;
+
+		cp->nr_cols =3D 1;
+		cp->flags |=3D COLUMNIZER_READY;
+	}
+	return 0;
+}
+
+int feed_columnizer(struct columnizer *cp, char *cell)
+{
+	int ret;
+
+	/* Degradation case, no special layout needed */
+	if (cp->flags & COLUMNIZER_READY && cp->nr_cols =3D=3D 1) {
+		if (cell) {
+			if (cp->left_space)
+				printf("%-*s", cp->left_space, "");
+			printf("%s\n", cell);
+		}
+		ret =3D 0;
+	}
+	else
+		ret =3D feed_cell(cp, cell);
+
+	if (!cell) {		/* EOF, cleanup */
+		if (cp->detach) {
+			int i;
+			for (i =3D 0;i < cp->cells_nr;i++)
+				cp->detach(cp->cells[i]);
+		}
+		if (cp->cells_alloc)
+			free(cp->cells);
+	}
+
+	return ret;
+}
diff --git a/column.h b/column.h
new file mode 100644
index 0000000..28122e0
--- /dev/null
+++ b/column.h
@@ -0,0 +1,23 @@
+#define COLUMNIZER_MODE_MASK    0x000F
+#define COLUMNIZER_COLUMN_FIRST      0
+#define COLUMNIZER_ROW_FIRST         1
+
+#define COLUMNIZER_HOMOGENEOUS  0x0010
+#define COLUMNIZER_HAVE_ANSI    0x0020
+#define COLUMNIZER_READY        0x0040
+
+struct columnizer {
+	int flags;
+	int terminal_width, column_width;
+	int left_space, right_space, space;
+	void (*detach)(void *p);
+
+	/* private variables */
+	char **cells;
+	int cells_nr, cells_alloc;
+	int nr_cols, nr_rows;
+
+	int longest;
+};
+
+extern int feed_columnizer(struct columnizer *cp, char *cell);
diff --git a/command-list.txt b/command-list.txt
index 95bf18c..5d6bfc8 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -20,6 +20,7 @@ git-cherry-pick                         mainporcelain
 git-citool                              mainporcelain
 git-clean                               mainporcelain
 git-clone                               mainporcelain common
+git-column                              purehelpers
 git-commit                              mainporcelain common
 git-commit-tree                         plumbingmanipulators
 git-config                              ancillarymanipulators
--=20
1.7.0.1.370.gd3c5
