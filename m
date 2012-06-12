From: Javier.Roucher-Iglesias@ensimag.imag.fr
Subject: [PATCH/RFC] Add 'git credential' plumbing command
Date: Tue, 12 Jun 2012 16:24:04 +0200
Message-ID: <1339511044-29977-1-git-send-email-Javier.Roucher-Iglesias@ensimag.imag.fr>
Cc: Javier Roucher <jroucher@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 12 16:24:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeS1P-0003b2-9A
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 16:24:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752254Ab2FLOYX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jun 2012 10:24:23 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:40580 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751836Ab2FLOYU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2012 10:24:20 -0400
Received: by weyu7 with SMTP id u7so2883318wey.19
        for <git@vger.kernel.org>; Tue, 12 Jun 2012 07:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=igNMfFHPX7yjrIOVMACtDLXwXbONS5lLWtYf2k7EtsM=;
        b=VnMFlf/hGL2v4OAAMirRiR0vyVIEV306CSPhIHSU3ynSU3xizf2aU6fCXdS5tFtTYM
         km4ak+8DfZ71YTV69n+Vb3iW0S5cNnQ2X3RFcgmB6kKpl3xGiIC+RJSFQscrKEuTGIF/
         D9LoFmKtg07iWyVLank55JWKNoiKmgCsA16ivZfv64OYoADxaVtxbMyahfEGQLPS108E
         kjgekfsNOx6odWv1/scQtuWy3iEhO684gY3xakp7jaoRTcuTbyPtMXi/KpwCCQgidw2W
         GJvhDf8OlE88bOeOGE03WKjgG6QEZavKLvbqJhMnWyzodQhElSqMH3+8UeG/TT1ePzgR
         ddDQ==
Received: by 10.180.99.70 with SMTP id eo6mr29473824wib.17.1339511059304;
        Tue, 12 Jun 2012 07:24:19 -0700 (PDT)
Received: from SuperNova.grenet.fr ([80.214.9.0])
        by mx.google.com with ESMTPS id gc6sm5679820wib.0.2012.06.12.07.24.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 12 Jun 2012 07:24:18 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2.573.ged8bfa6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199789>

From: Javier Roucher <jroucher@gmail.com>

Test is comming
we are working to added soon.

---
 .gitignore                       |  1 +
 Documentation/git-credential.txt | 74 ++++++++++++++++++++++++++++++++++++++++
 Makefile                         |  1 +
 builtin.h                        |  1 +
 builtin/credential.c             | 40 ++++++++++++++++++++++
 git.c                            |  1 +
 6 files changed, 118 insertions(+)
 create mode 100644 Documentation/git-credential.txt
 create mode 100644 builtin/credential.c

diff --git a/.gitignore b/.gitignore
index bf66648..7d1d86e 100644
--- a/.gitignore
+++ b/.gitignore
@@ -31,6 +31,7 @@
 /git-commit-tree
 /git-config
 /git-count-objects
+/git-credential
 /git-credential-cache
 /git-credential-cache--daemon
 /git-credential-store
diff --git a/Documentation/git-credential.txt b/Documentation/git-credential.txt
new file mode 100644
index 0000000..fa05aad
--- /dev/null
+++ b/Documentation/git-credential.txt
@@ -0,0 +1,74 @@
+git-credential(7)
+=================
+
+NAME
+----
+git-credential - Provide and store user credentials.
+
+SYNOPSIS
+--------
+------------------
+git credential <fill|approve|reject>
+
+------------------
+
+DESCRIPTION
+-----------
+
+Git-credential permits to the user of the script to save:
+username, password, host, path and protocol. When the user of script
+invoke git-credential, the script can ask for a password, using the command
+'git credential fill'.
+Taking data from the standard input, the program treats each line as a
+separate data item, and the end of series of data item is signalled by a 
+blank line.
+
+		username=admin\n 
+		protocol=[http|https]\n
+		host=localhost\n
+		path=/dir\n\n
+
+-If git-credential system has the password already stored
+git-credential will answer with by STDOUT:
+	
+		username=admin
+		password=*****
+
+-If it is not stored, the user will be prompt for a password:
+		
+		> Password for '[http|https]admin@localhost':
+
+
+Then if the password is correct, (note: it's not git credential that
+decides if the password is correct or not. That part is done by the 
+external system) it can be stored using command 'git crendential approve' 
+by providing the structure, by STDIN.
+
+		username=admin
+		password=*****
+		protocol=[http|https]
+		host=localhost
+		path=/dir
+
+If the password is refused, it can be deleted using command
+'git credential reject' by providing the same structure.
+
+
+REQUESTING CREDENTIALS
+----------------------
+
+1. The 'git credential fill' makes the structure,
+with this structure it will be able to save your
+credentials, and if the credential is already stored,
+it will fill the password.
+
+		username=foo
+		password=****
+		protocol=[http|https]
+		localhost=url
+		path=/direction
+
+2. Then 'git credential approve' to store them.
+
+3. Otherwise, if the credential is not correct you can do
+  'git credential reject' to delete the credential.
diff --git a/Makefile b/Makefile
index 4592f1f..3f53da8 100644
--- a/Makefile
+++ b/Makefile
@@ -827,6 +827,7 @@ BUILTIN_OBJS += builtin/commit-tree.o
 BUILTIN_OBJS += builtin/commit.o
 BUILTIN_OBJS += builtin/config.o
 BUILTIN_OBJS += builtin/count-objects.o
+BUILTIN_OBJS += builtin/credential.o
 BUILTIN_OBJS += builtin/describe.o
 BUILTIN_OBJS += builtin/diff-files.o
 BUILTIN_OBJS += builtin/diff-index.o
diff --git a/builtin.h b/builtin.h
index 338f540..48feddc 100644
--- a/builtin.h
+++ b/builtin.h
@@ -66,6 +66,7 @@ extern int cmd_commit(int argc, const char **argv, const char *prefix);
 extern int cmd_commit_tree(int argc, const char **argv, const char *prefix);
 extern int cmd_config(int argc, const char **argv, const char *prefix);
 extern int cmd_count_objects(int argc, const char **argv, const char *prefix);
+extern int cmd_credential(int argc, const char **argv, const char *prefix);
 extern int cmd_describe(int argc, const char **argv, const char *prefix);
 extern int cmd_diff_files(int argc, const char **argv, const char *prefix);
 extern int cmd_diff_index(int argc, const char **argv, const char *prefix);
diff --git a/builtin/credential.c b/builtin/credential.c
new file mode 100644
index 0000000..c8dcfbb
--- /dev/null
+++ b/builtin/credential.c
@@ -0,0 +1,40 @@
+#include <stdio.h>
+#include "cache.h"
+#include "credential.h"
+#include "string-list.h"
+
+static const char usage_msg[] =
+"credential <fill|approve|reject>";
+
+void cmd_credential (int argc, char **argv, const char *prefix) {
+	const char *op;
+	struct credential c = CREDENTIAL_INIT;
+	int i;
+
+	op = argv[1];
+	if (!op)
+		usage(usage_msg);
+
+	if (credential_read(&c, stdin) < 0)
+		die("unable to read credential from stdin");
+
+	if (!strcmp(op, "fill")) {
+		credential_fill(&c);
+		if (c.username)
+			printf("username=%s\n", c.username);
+		if (c.password)
+			printf("password=%s\n", c.password);
+		if (c.protocol)
+			printf("protocol=%s\n", c.protocol);
+		if (c.host)
+			printf("host=%s\n", c.host);
+		if (c.path)
+			printf("path=%s\n", c.path);
+	} else if (!strcmp(op, "approve")) {
+		credential_approve(&c);
+	} else if (!strcmp(op, "reject")) {
+		credential_reject(&c);
+	} else {
+		usage(usage_msg);
+	}
+}
diff --git a/git.c b/git.c
index d232de9..660c926 100644
--- a/git.c
+++ b/git.c
@@ -353,6 +353,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "commit-tree", cmd_commit_tree, RUN_SETUP },
 		{ "config", cmd_config, RUN_SETUP_GENTLY },
 		{ "count-objects", cmd_count_objects, RUN_SETUP },
+		{ "credential", cmd_credential, RUN_SETUP_GENTLY },
 		{ "describe", cmd_describe, RUN_SETUP },
 		{ "diff", cmd_diff },
 		{ "diff-files", cmd_diff_files, RUN_SETUP | NEED_WORK_TREE },
-- 
1.7.10.2.573.ged8bfa6
