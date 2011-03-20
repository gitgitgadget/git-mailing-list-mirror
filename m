From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/9] Add display_columns() to display in columnar layout
Date: Sun, 20 Mar 2011 19:57:46 +0700
Message-ID: <1300625873-18435-3-git-send-email-pclouds@gmail.com>
References: <1300625873-18435-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 20 13:58:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1IDG-0002pp-J7
	for gcvg-git-2@lo.gmane.org; Sun, 20 Mar 2011 13:58:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752241Ab1CTM60 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Mar 2011 08:58:26 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:50802 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752233Ab1CTM6Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2011 08:58:25 -0400
Received: by mail-iw0-f174.google.com with SMTP id 34so5553777iwn.19
        for <git@vger.kernel.org>; Sun, 20 Mar 2011 05:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=gNXb0RPMUymI0K63d+qBEcVIiOicltqaCmUUFzWrDTQ=;
        b=Y7vLWFNpOEp8meI6UgJMpGhRetQVUCpL+vKk9qC67KTe7q8yKPeZpkos43/CJ7FTJP
         9WM9lMuaEamU2G9NirGW+Rgkwm1yrQ6UslKg1t/Oy1+tBgwXg18UT4h6oGwd9VSx6GFo
         gzMN1h30wp3OXfGbVZ4kAs8u7nxPbf8PFGGts=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=mdsRKPwkiRSQ+Zf9pBI5XyQzxYwBKtiZotqkSTLJHUqOYV71W9KGE97k147My7vJ3k
         Vrj9ekpN5B5fFfj29uzo3Gg7u0pG249/JQ1bdQMPs38wbRa7B4b4Ac3fqg+EBvf5Ntzp
         VLxbRTUN929AhbLX4UrV09UPeQ4v9iDDYIe98=
Received: by 10.42.74.3 with SMTP id u3mr4854218icj.512.1300625904751;
        Sun, 20 Mar 2011 05:58:24 -0700 (PDT)
Received: from tre ([115.73.209.201])
        by mx.google.com with ESMTPS id g17sm690232ibb.57.2011.03.20.05.58.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 20 Mar 2011 05:58:23 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Sun, 20 Mar 2011 19:58:15 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
In-Reply-To: <1300625873-18435-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169504>

Currently it does not do that, just provide the API. In order to
output in columns, COL_ENABLED bit must be set. A nice consequence is
mode 0 is effectively no column mode.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Makefile |    3 ++-
 column.c |   37 +++++++++++++++++++++++++++++++++++++
 column.h |    5 +++++
 3 files changed, 44 insertions(+), 1 deletions(-)
 create mode 100644 column.c

diff --git a/Makefile b/Makefile
index 6007f68..94e1cf0 100644
--- a/Makefile
+++ b/Makefile
@@ -575,6 +575,7 @@ LIB_OBJS +=3D branch.o
 LIB_OBJS +=3D bundle.o
 LIB_OBJS +=3D cache-tree.o
 LIB_OBJS +=3D color.o
+LIB_OBJS +=3D column.o
 LIB_OBJS +=3D combine-diff.o
 LIB_OBJS +=3D commit.o
 LIB_OBJS +=3D config.o
@@ -1956,7 +1957,7 @@ builtin/prune.o builtin/reflog.o reachable.o: rea=
chable.h
 builtin/commit.o builtin/revert.o wt-status.o: wt-status.h
 builtin/tar-tree.o archive-tar.o: tar.h
 connect.o transport.o http-backend.o: url.h
-help.o pager.o: column.h
+column.o help.o pager.o: column.h
 http-fetch.o http-walker.o remote-curl.o transport.o walker.o: walker.=
h
 http.o http-walker.o http-push.o http-fetch.o remote-curl.o: http.h ur=
l.h
=20
diff --git a/column.c b/column.c
new file mode 100644
index 0000000..8422c89
--- /dev/null
+++ b/column.c
@@ -0,0 +1,37 @@
+#include "cache.h"
+#include "column.h"
+#include "string-list.h"
+
+#define MODE(mode) ((mode) & COL_MODE)
+
+struct string_list_item *add_to_columns(struct string_list *list, int =
mode,
+					const char *string)
+{
+	if (mode & COL_ENABLED)
+		return string_list_append(list, string);
+	printf("%s\n", string);
+	return NULL;
+}
+
+/* Display without layout when COL_ENABLED is not set */
+static void display_plain(const struct string_list *list, const char *=
indent)
+{
+	int i;
+
+	for (i =3D 0; i < list->nr; i++)
+		printf("%s%s\n", indent, list->items[i].string);
+}
+
+void display_columns(const struct string_list *list, int mode,
+		     int width, int padding, const char *indent)
+{
+	if (!list->nr)
+		return;
+	if (!indent)
+		indent =3D "";
+	if (width <=3D 1 || !(mode & COL_ENABLED)) {
+		display_plain(list, indent);
+		return;
+	}
+	die("BUG: invalid mode %d", MODE(mode));
+}
diff --git a/column.h b/column.h
index 55d8067..ffae87c 100644
--- a/column.h
+++ b/column.h
@@ -1,6 +1,11 @@
 #ifndef COLUMN_H
 #define COLUMN_H
=20
+#define COL_MODE          0x000F
+#define COL_ENABLED      (1 << 4)
+
 extern int term_columns(void);
+extern struct string_list_item *add_to_columns(struct string_list *lis=
t, int mode, const char *string);
+extern void display_columns(const struct string_list *list, int mode, =
int width, int padding, const char *indent);
=20
 #endif
--=20
1.7.4.74.g639db
