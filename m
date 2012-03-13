From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v7 11/9] column: support "denser" mode
Date: Tue, 13 Mar 2012 19:11:35 +0700
Message-ID: <25ba0cdc7d4898e65af12b584c0e9ebf4e412557.1331638664.git.pclouds@gmail.com>
References: <1330430331-19945-1-git-send-email-pclouds@gmail.com> <cover.1331638663.git.pclouds@gmail.com> <1294ed94f981a7029b47a44143c3eb9fb6b820f1.1331638663.git.pclouds@gmail.com> <dd6e9c2189fb4502aaf9f7368cb7f13216961cfa.1331638663.git.pclouds@gmail.com> <c439d91ff126e2a9d7fe627de7346e19801dd6d4.1331638663.git.pclouds@gmail.com> <28f1df2d0cc13d69fa571600c4723094b6fe514b.1331638663.git.pclouds@gmail.com> <dfa792c463da82097de69b1fba5dc54147dd1951.1331638663.git.pclouds@gmail.com> <dc618ca926bdbdbb96ae59615cbbe57cde9f763f.1331638663.git.pclouds@gmail.com> <d7319b7a0445fc476ae1e928bdc0750287f7fb42.1331638663.git.pclouds@gmail.com> <45b5fc83af9ef53f79eb66742eedcbfe14a3d532.1331638664.git.pclouds@gmail.com> <b1d1aead1851563dbab0cb98db27db07a1addf19.1331638664.git.pclouds@gmail.com> <79a9a0dd
 76d72d9cda14378acb16a2fc6456dd0e.1331638664.git.pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 13 13:09:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7QXa-00075A-8V
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 13:09:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755121Ab2CMMI5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Mar 2012 08:08:57 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:54731 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759472Ab2CMMIw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2012 08:08:52 -0400
Received: by gghe5 with SMTP id e5so443954ggh.19
        for <git@vger.kernel.org>; Tue, 13 Mar 2012 05:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=QIozdhOSl2k5HhdYaStehtn9TrGPMJKPIOdHz1d5USo=;
        b=WuoFXZDfpHLlKafgBxVDIyv0nFwbRUWI+MNqU84IUlpeNewEHBtNlwvvWK1gmU6xzz
         wCjcpeRAdwGJmQ5gazXmm7hTdupMcdmHa6ExP9WwoJsDlw+qdt0cRgIY4l6uBJKsjOi6
         hm5wQXbjzVnN6nnDThwhTpBb26rWPGkC5fy/pALhpcm0eriduk81aJ0SxKedNo4zN5hJ
         H5qBoMXSQlXmHwZG4IaB1XR+M8qt+Ks2hpBISe+m8xtR+H0717k9iu7u/UGyCQss4gJf
         FZzRg7ZCwyjhl2Hpo+kJvrNQfWC88GSA+me58bWd4QRqMzh7FRsG1VhvQyUlmwCOLbTS
         4JEw==
Received: by 10.68.241.2 with SMTP id we2mr5837524pbc.53.1331640532089;
        Tue, 13 Mar 2012 05:08:52 -0700 (PDT)
Received: from tre ([115.74.61.175])
        by mx.google.com with ESMTPS id 6sm643579pbv.5.2012.03.13.05.08.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 13 Mar 2012 05:08:50 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Tue, 13 Mar 2012 19:11:59 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <79a9a0dd76d72d9cda14378acb16a2fc6456dd0e.1331638664.git.pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193009>

Sometimes a few long entries in the listing would stretch out columns,
wasting space. If these entries are cut out, the columns could become
smaller, hence more columns.

This new mode does that by looking for the longest entry, if cutting th=
e
list before that entry results in much denser layout, then the entry
will be cut out and printed in a separate line. The remaining will put
in a new layout.

Multiple tables with different column width might be unpleasant to
look at, especially if the tables are really short. But on the other
hand it could be quite handy. For example,
"COLUMNS=3D80 ./git ls-files --column=3Ddense -- '*.[ch]'" takes 415
lines, while "denser" only takes 223 because it break the layout at
contrib/credential/osxkeychain/git-credential-osxkeychain.c
and relayout again:

abspath.c                  builtin/rm.c
advice.c                   builtin/send-pack.c
<snip>
builtin/rev-parse.c        connected.h
builtin/revert.c           contrib/convert-objects/convert-objects.c

contrib/credential/osxkeychain/git-credential-osxkeychain.c

contrib/examples/builtin-fetch--tool.c refs.c                   xdiff/x=
utils.c
contrib/svn-fe/svn-fe.c                refs.h                   xdiff/x=
utils.h
convert.c                              remote-curl.c            zlib.c
convert.h                              remote.c
<snip>
reflog-walk.c                          xdiff/xprepare.h
reflog-walk.h                          xdiff/xtypes.h

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 column.c |   74 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++---
 column.h |    1 +
 2 files changed, 71 insertions(+), 4 deletions(-)

diff --git a/column.c b/column.c
index 1e545a0..80eefa0 100644
--- a/column.c
+++ b/column.c
@@ -152,10 +152,55 @@ static int display_cell(struct column_data *data,=
 int initial_width,
 	return 0;
 }
=20
+/*
+ * Attempt to put the longest cell into a separate line, see if it
+ * improves the layout
+ */
+static int break_long_line(const struct column_data *old_data)
+{
+	struct column_data data;
+	struct string_list faked_list;
+	int initial_width, x, y, i, item =3D 0, row1, row2;
+	char *empty_cell;
+
+	memcpy(&data, old_data, sizeof(data));
+	for (i =3D 0; i < data.list->nr; i++)
+		if (data.len[i] > data.len[item])
+			item =3D i;
+	data.list =3D &faked_list;
+	data.width =3D NULL;
+	faked_list =3D *old_data->list;
+
+	faked_list.nr =3D item + 1;
+	layout(&data, &initial_width);
+	shrink_columns(&data);
+	row1 =3D data.rows;
+
+	faked_list.nr =3D item;
+	layout(&data, &initial_width);
+	shrink_columns(&data);
+	row2 =3D data.rows;
+
+	if (row1 - row2 < 3)
+		return -1;
+
+	empty_cell =3D xmalloc(initial_width + 1);
+	memset(empty_cell, ' ', initial_width);
+	empty_cell[initial_width] =3D '\0';
+	for (y =3D 0; y < data.rows; y++) {
+		for (x =3D 0; x < data.cols; x++)
+			if (display_cell(&data, initial_width, empty_cell, x, y))
+				break;
+	}
+	free(data.width);
+	free(empty_cell);
+	return item;
+}
+
 /* Display COL_COLUMN or COL_ROW */
-static void display_table(const struct string_list *list,
-			  unsigned int colopts,
-			  const struct column_options *opts)
+static int display_table(const struct string_list *list,
+			 unsigned int colopts,
+			 const struct column_options *opts)
 {
 	struct column_data data;
 	int x, y, i, initial_width;
@@ -174,6 +219,19 @@ static void display_table(const struct string_list=
 *list,
=20
 	if (colopts & COL_DENSE)
 		shrink_columns(&data);
+	if (colopts & COL_DENSER) {
+		i =3D break_long_line(&data);
+		if (i !=3D -1) {
+			printf("%s%s" "%s%s%s" "%s%s",
+			       indent, nl,
+			       indent, list->items[i].string, nl,
+			       indent, nl);
+			free(data.len);
+			free(data.width);
+			return i + 1;
+		}
+		shrink_columns(&data);
+	}
=20
 	empty_cell =3D xmalloc(initial_width + 1);
 	memset(empty_cell, ' ', initial_width);
@@ -187,12 +245,15 @@ static void display_table(const struct string_lis=
t *list,
 	free(data.len);
 	free(data.width);
 	free(empty_cell);
+	return list->nr;
 }
=20
 void print_columns(const struct string_list *list, unsigned int colopt=
s,
 		   const struct column_options *opts)
 {
 	struct column_options nopts;
+	int processed;
+	struct string_list l =3D *list;
=20
 	if (!list->nr)
 		return;
@@ -213,7 +274,11 @@ void print_columns(const struct string_list *list,=
 unsigned int colopts,
 		break;
 	case COL_ROW:
 	case COL_COLUMN:
-		display_table(list, colopts, &nopts);
+		while (l.nr &&
+		       (processed =3D display_table(&l, colopts, &nopts)) < l.nr) {
+			l.items +=3D processed;
+			l.nr -=3D processed;
+		}
 		break;
 	default:
 		die("BUG: invalid layout mode %d", COL_LAYOUT(colopts));
@@ -252,6 +317,7 @@ static int parse_option(const char *arg, int len, u=
nsigned int *colopts,
 		{ "column", COL_COLUMN,   COL_LAYOUT_MASK },
 		{ "row",    COL_ROW,      COL_LAYOUT_MASK },
 		{ "dense",  COL_DENSE,    0 },
+		{ "denser", COL_DENSER,   0 },
 	};
 	int i;
=20
diff --git a/column.h b/column.h
index b6872fe..dbc5da2 100644
--- a/column.h
+++ b/column.h
@@ -6,6 +6,7 @@
 #define COL_PARSEOPT      0x0040   /* --column is given from cmdline *=
/
 #define COL_DENSE         0x0080   /* Shrink columns when possible,
 				      making space for more columns */
+#define COL_DENSER        0x0100
=20
 #define COL_ENABLE(c) ((c) & COL_ENABLE_MASK)
 #define COL_DISABLED      0x0000   /* must be zero */
--=20
1.7.8.36.g69ee2
