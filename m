From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v6 01/11] column: add API to print items in columns
Date: Sat, 25 Feb 2012 18:41:08 +0700
Message-ID: <1330170078-29353-2-git-send-email-pclouds@gmail.com>
References: <1330170078-29353-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 25 12:39:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1Fy9-0001lI-V9
	for gcvg-git-2@plane.gmane.org; Sat, 25 Feb 2012 12:39:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756364Ab2BYLjK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Feb 2012 06:39:10 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:44098 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756298Ab2BYLjG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Feb 2012 06:39:06 -0500
Received: by mail-pz0-f46.google.com with SMTP id d14so3436768dae.19
        for <git@vger.kernel.org>; Sat, 25 Feb 2012 03:39:06 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.68.130.234 as permitted sender) client-ip=10.68.130.234;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.68.130.234 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.68.130.234])
        by 10.68.130.234 with SMTP id oh10mr18307993pbb.143.1330169946634 (num_hops = 1);
        Sat, 25 Feb 2012 03:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=MuUNfSM3stkFrI0pLqICw7XJrAm4+M8Y/lVwL2ps26E=;
        b=YpkKBVKYc00CXtV1xHw3IyBuERXlzeoI+/SnBDVovwqIZRuvr119EjmZJTiM0N2K7P
         nM6dNKVMzMhuHKDoZ3D4CnSnzTRINvfW/5VudJ4nEMscuaZ94CUo1mM1GKdC6Y/aB2cU
         C2aPU1WhSjqutXjV30qOmTs2623pzOwKRyftY=
Received: by 10.68.130.234 with SMTP id oh10mr15252581pbb.143.1330169946585;
        Sat, 25 Feb 2012 03:39:06 -0800 (PST)
Received: from tre ([115.74.53.120])
        by mx.google.com with ESMTPS id s1sm7012226pbs.21.2012.02.25.03.39.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 25 Feb 2012 03:39:05 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Sat, 25 Feb 2012 18:41:25 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1330170078-29353-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191523>

Simple code that print line-by-line and wants to columnize can do
this:

struct string_list list;
string_list_append(&list, ...);
string_list_append(&list, ...);
=2E..
print_columns(&list, ...);

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Makefile |    2 ++
 column.c |   39 +++++++++++++++++++++++++++++++++++++++
 column.h |   19 +++++++++++++++++++
 3 files changed, 60 insertions(+), 0 deletions(-)
 create mode 100644 column.c
 create mode 100644 column.h

diff --git a/Makefile b/Makefile
index a0de4e9..4e9501b 100644
--- a/Makefile
+++ b/Makefile
@@ -646,6 +646,7 @@ LIB_OBJS +=3D bulk-checkin.o
 LIB_OBJS +=3D bundle.o
 LIB_OBJS +=3D cache-tree.o
 LIB_OBJS +=3D color.o
+LIB_OBJS +=3D column.o
 LIB_OBJS +=3D combine-diff.o
 LIB_OBJS +=3D commit.o
 LIB_OBJS +=3D compat/obstack.o
@@ -2166,6 +2167,7 @@ builtin/prune.o builtin/reflog.o reachable.o: rea=
chable.h
 builtin/commit.o builtin/revert.o wt-status.o: wt-status.h
 builtin/tar-tree.o archive-tar.o: tar.h
 connect.o transport.o url.o http-backend.o: url.h
+column.o help.o pager.o: column.h
 http-fetch.o http-walker.o remote-curl.o transport.o walker.o: walker.=
h
 http.o http-walker.o http-push.o http-fetch.o remote-curl.o: http.h ur=
l.h
=20
diff --git a/column.c b/column.c
new file mode 100644
index 0000000..742ae18
--- /dev/null
+++ b/column.c
@@ -0,0 +1,39 @@
+#include "cache.h"
+#include "column.h"
+#include "string-list.h"
+
+#define MODE(mode) ((mode) & COL_MODE)
+
+/* Display without layout when COL_ENABLED is not set */
+static void display_plain(const struct string_list *list,
+			  const char *indent, const char *nl)
+{
+	int i;
+
+	for (i =3D 0; i < list->nr; i++)
+		printf("%s%s%s", indent, list->items[i].string, nl);
+}
+
+void print_columns(const struct string_list *list, unsigned int mode,
+		   struct column_options *opts)
+{
+	const char *indent =3D "", *nl =3D "\n";
+	int padding =3D 1, width =3D term_columns();
+
+	if (!list->nr)
+		return;
+	if (opts) {
+		if (opts->indent)
+			indent =3D opts->indent;
+		if (opts->nl)
+			nl =3D opts->nl;
+		if (opts->width)
+			width =3D opts->width;
+		padding =3D opts->padding;
+	}
+	if (width <=3D 1 || !(mode & COL_ENABLED)) {
+		display_plain(list, indent, nl);
+		return;
+	}
+	die("BUG: invalid mode %d", MODE(mode));
+}
diff --git a/column.h b/column.h
new file mode 100644
index 0000000..8e4fdaa
--- /dev/null
+++ b/column.h
@@ -0,0 +1,19 @@
+#ifndef COLUMN_H
+#define COLUMN_H
+
+#define COL_MODE          0x000F
+#define COL_ENABLED      (1 << 4)
+
+struct column_options {
+	int width;
+	int padding;
+	const char *indent;
+	const char *nl;
+};
+
+extern int term_columns(void);
+extern void print_columns(const struct string_list *list,
+			  unsigned int mode,
+			  struct column_options *opts);
+
+#endif
--=20
1.7.8.36.g69ee2
