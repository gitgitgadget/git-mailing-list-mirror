From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v7 05/9] help: reuse print_columns() for help -a
Date: Tue, 13 Mar 2012 19:09:17 +0700
Message-ID: <dfa792c463da82097de69b1fba5dc54147dd1951.1331638663.git.pclouds@gmail.com>
References: <1330430331-19945-1-git-send-email-pclouds@gmail.com> <cover.1331638663.git.pclouds@gmail.com> <1294ed94f981a7029b47a44143c3eb9fb6b820f1.1331638663.git.pclouds@gmail.com> <dd6e9c2189fb4502aaf9f7368cb7f13216961cfa.1331638663.git.pclouds@gmail.com> <c439d91ff126e2a9d7fe627de7346e19801dd6d4.1331638663.git.pclouds@gmail.com> <28f1df2d0cc13d69fa571600c4723094b6fe514b.1331638663.git.pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 13 13:07:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7QVw-0005sh-5C
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 13:07:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755530Ab2CMMGy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Mar 2012 08:06:54 -0400
Received: from mail-pz0-f52.google.com ([209.85.210.52]:59624 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753321Ab2CMMGw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2012 08:06:52 -0400
Received: by mail-pz0-f52.google.com with SMTP id p12so885281dad.11
        for <git@vger.kernel.org>; Tue, 13 Mar 2012 05:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=P0TlLwsk72wtYehJp5wRLkhG+gCwguIxQsTpP9zK4xw=;
        b=ftPQoQLjSyw5vDqPt+XobjVnektmwoR2UkZh0Gab1rHLsL7GAKdumDBybfzqDZV8A8
         MnW8eP9S5aSEQO6Ds21D5RApKLkhsRRH8yhc/EkldIcJfmKVkiG14YTqW7HaiOspAUup
         hsK6qw0BCd/aMpHJ7yExsn/vVTkx0A59anfVsidgkTcsMjzgbVBmfCnlt7nVQ6wkSB3I
         FbdpT96cZyL39i2qFWk3dYkVgRV61fmumHazkeG525c6wIT0r9Tvd46UPLFoJIqv0D2N
         60xkDBZAZlan4FRroOjKztrZ8BZfUuRZEoNv8acKRKTZJonfr8bpNddaAThUNTI7MzeD
         2b0Q==
Received: by 10.68.132.9 with SMTP id oq9mr3826123pbb.130.1331640411678;
        Tue, 13 Mar 2012 05:06:51 -0700 (PDT)
Received: from tre ([115.74.61.175])
        by mx.google.com with ESMTPS id jm4sm626461pbc.73.2012.03.13.05.06.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 13 Mar 2012 05:06:50 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Tue, 13 Mar 2012 19:09:59 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <28f1df2d0cc13d69fa571600c4723094b6fe514b.1331638663.git.pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193003>

"help -a" also respects column.ui (and column.help if presents)

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/help.c |    7 +++++-
 help.c         |   59 +++++++++++++++++++++---------------------------=
-------
 help.h         |    2 +-
 3 files changed, 30 insertions(+), 38 deletions(-)

diff --git a/builtin/help.c b/builtin/help.c
index 61ff798..c64f152 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -9,6 +9,7 @@
 #include "common-cmds.h"
 #include "parse-options.h"
 #include "run-command.h"
+#include "column.h"
 #include "help.h"
=20
 static struct man_viewer_list {
@@ -30,6 +31,7 @@ enum help_format {
 };
=20
 static int show_all =3D 0;
+static unsigned int colopts;
 static enum help_format help_format =3D HELP_FORMAT_NONE;
 static struct option builtin_help_options[] =3D {
 	OPT_BOOLEAN('a', "all", &show_all, "print all available commands"),
@@ -251,6 +253,8 @@ static int add_man_viewer_info(const char *var, con=
st char *value)
=20
 static int git_help_config(const char *var, const char *value, void *c=
b)
 {
+	if (!prefixcmp(var, "column."))
+		return git_column_config(var, value, "help", &colopts);
 	if (!strcmp(var, "help.format")) {
 		if (!value)
 			return config_error_nonbool(var);
@@ -424,8 +428,9 @@ int cmd_help(int argc, const char **argv, const cha=
r *prefix)
 	parsed_help_format =3D help_format;
=20
 	if (show_all) {
+		git_config(git_help_config, NULL);
 		printf("usage: %s\n\n", git_usage_string);
-		list_commands("git commands", &main_cmds, &other_cmds);
+		list_commands("git commands", colopts, &main_cmds, &other_cmds);
 		printf("%s\n", git_more_info_string);
 		return 0;
 	}
diff --git a/help.c b/help.c
index 14eefc9..a815ae6 100644
--- a/help.c
+++ b/help.c
@@ -4,6 +4,8 @@
 #include "levenshtein.h"
 #include "help.h"
 #include "common-cmds.h"
+#include "string-list.h"
+#include "column.h"
=20
 void add_cmdname(struct cmdnames *cmds, const char *name, int len)
 {
@@ -70,31 +72,25 @@ void exclude_cmds(struct cmdnames *cmds, struct cmd=
names *excludes)
 	cmds->cnt =3D cj;
 }
=20
-static void pretty_print_string_list(struct cmdnames *cmds, int longes=
t)
+static void pretty_print_string_list(struct cmdnames *cmds,
+				     unsigned int colopts)
 {
-	int cols =3D 1, rows;
-	int space =3D longest + 1; /* min 1 SP between words */
-	int max_cols =3D term_columns() - 1; /* don't print *on* the edge */
-	int i, j;
-
-	if (space < max_cols)
-		cols =3D max_cols / space;
-	rows =3D DIV_ROUND_UP(cmds->cnt, cols);
-
-	for (i =3D 0; i < rows; i++) {
-		printf("  ");
+	struct string_list list =3D STRING_LIST_INIT_NODUP;
+	struct column_options copts;
+	int i;
=20
-		for (j =3D 0; j < cols; j++) {
-			int n =3D j * rows + i;
-			int size =3D space;
-			if (n >=3D cmds->cnt)
-				break;
-			if (j =3D=3D cols-1 || n + rows >=3D cmds->cnt)
-				size =3D 1;
-			printf("%-*s", size, cmds->names[n]->name);
-		}
-		putchar('\n');
-	}
+	for (i =3D 0; i < cmds->cnt; i++)
+		string_list_append(&list, cmds->names[i]->name);
+	/*
+	 * always enable column display, we only consult column.*
+	 * about layout strategy and stuff
+	 */
+	colopts =3D (colopts & ~COL_ENABLE_MASK) | COL_ENABLED;
+	memset(&copts, 0, sizeof(copts));
+	copts.indent =3D "  ";
+	copts.padding =3D 2;
+	print_columns(&list, colopts, &copts);
+	string_list_clear(&list, 0);
 }
=20
 static int is_executable(const char *name)
@@ -203,25 +199,16 @@ void load_command_list(const char *prefix,
 	exclude_cmds(other_cmds, main_cmds);
 }
=20
-void list_commands(const char *title, struct cmdnames *main_cmds,
-		   struct cmdnames *other_cmds)
+void list_commands(const char *title, unsigned int colopts,
+		   struct cmdnames *main_cmds, struct cmdnames *other_cmds)
 {
-	int i, longest =3D 0;
-
-	for (i =3D 0; i < main_cmds->cnt; i++)
-		if (longest < main_cmds->names[i]->len)
-			longest =3D main_cmds->names[i]->len;
-	for (i =3D 0; i < other_cmds->cnt; i++)
-		if (longest < other_cmds->names[i]->len)
-			longest =3D other_cmds->names[i]->len;
-
 	if (main_cmds->cnt) {
 		const char *exec_path =3D git_exec_path();
 		printf("available %s in '%s'\n", title, exec_path);
 		printf("----------------");
 		mput_char('-', strlen(title) + strlen(exec_path));
 		putchar('\n');
-		pretty_print_string_list(main_cmds, longest);
+		pretty_print_string_list(main_cmds, colopts);
 		putchar('\n');
 	}
=20
@@ -230,7 +217,7 @@ void list_commands(const char *title, struct cmdnam=
es *main_cmds,
 		printf("---------------------------------------");
 		mput_char('-', strlen(title));
 		putchar('\n');
-		pretty_print_string_list(other_cmds, longest);
+		pretty_print_string_list(other_cmds, colopts);
 		putchar('\n');
 	}
 }
diff --git a/help.h b/help.h
index b6b12d5..854d2d4 100644
--- a/help.h
+++ b/help.h
@@ -25,7 +25,7 @@ extern void add_cmdname(struct cmdnames *cmds, const =
char *name, int len);
 /* Here we require that excludes is a sorted list. */
 extern void exclude_cmds(struct cmdnames *cmds, struct cmdnames *exclu=
des);
 extern int is_in_cmdlist(struct cmdnames *cmds, const char *name);
-extern void list_commands(const char *title,
+extern void list_commands(const char *title, unsigned int colopts,
 			  struct cmdnames *main_cmds,
 			  struct cmdnames *other_cmds);
=20
--=20
1.7.8.36.g69ee2
