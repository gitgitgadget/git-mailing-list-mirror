From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/3] Add "ls", which is basically ls-files with user-friendly settings
Date: Fri,  8 Jan 2010 00:07:56 +0700
Message-ID: <1262884076-12293-4-git-send-email-pclouds@gmail.com>
References: <1262884076-12293-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 07 18:09:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSvrW-0003aN-4c
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jan 2010 18:09:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752828Ab0AGRJW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Jan 2010 12:09:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752784Ab0AGRJW
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 12:09:22 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:63795 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752753Ab0AGRJV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2010 12:09:21 -0500
Received: by mail-yw0-f176.google.com with SMTP id 6so18630285ywh.4
        for <git@vger.kernel.org>; Thu, 07 Jan 2010 09:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=uTXjcLHQ700Eg1TcmC6VkW/OTm/tP9WLGgUAxIYGwg4=;
        b=DtRa4Ua1JqY+8AvdDqekepSrj/IUh9XWrCkix0xVNG4k3yz8CcpXAKGOI/LFcoWhAm
         fi3q839u8Hq8PJ9ngb8F/9QN6mBFzYebj0cxZrKrnFZbkCcrf437l8ISnRx0LMRkB/zu
         39imHh231AClr0YAYVeJ42s4DnIr2znr31fxo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=wIMCIRISj6RfOLd12r4XGwdLy8x7bue288Tn2GKlre2OTI8Vhctjulc6cFBpZqPmsh
         1q1MhMPEw0JdxYuvzeJRq3ststauRNUHGAdS4/T77QpayJNSQjqAUYTyLQYCQ8elFO5J
         Lc0MMBqaRyuuxUu2nNnLA9MmNxo85QQTVQ4/g=
Received: by 10.90.40.18 with SMTP id n18mr1997169agn.93.1262884161146;
        Thu, 07 Jan 2010 09:09:21 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.227.183])
        by mx.google.com with ESMTPS id 15sm10222443gxk.8.2010.01.07.09.09.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 07 Jan 2010 09:09:19 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri,  8 Jan 2010 00:08:33 +0700
X-Mailer: git-send-email 1.6.6.315.g1a406
In-Reply-To: <1262884076-12293-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136363>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin-ls-files.c |   31 +++++++++++++++++++++++++++++++
 builtin.h          |    1 +
 git.c              |    1 +
 3 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index e16638e..f63b039 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -11,6 +11,7 @@
 #include "builtin.h"
 #include "tree.h"
 #include "parse-options.h"
+#include "run-command.h"
=20
 static int abbrev;
 static int show_deleted;
@@ -31,6 +32,7 @@ static char *ps_matched;
 static const char *with_tree;
 static int exc_given;
 static int max_depth =3D 0;
+static int show_colums =3D 0;
=20
 static const char *tag_cached =3D "";
 static const char *tag_unmerged =3D "";
@@ -461,6 +463,7 @@ static int option_parse_exclude_standard(const stru=
ct option *opt,
=20
 int cmd_ls_files(int argc, const char **argv, const char *prefix)
 {
+	struct child_process cp;
 	int require_work_tree =3D 0, show_tag =3D 0;
 	struct dir_struct dir;
 	struct option builtin_ls_files_options[] =3D {
@@ -513,6 +516,7 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *prefix)
 		OPT_STRING(0, "with-tree", &with_tree, "tree-ish",
 			"pretend that paths removed since <tree-ish> are still present"),
 		OPT_INTEGER(0, "max-depth", &max_depth, "max recursive depth"),
+		OPT_BOOLEAN(0, "columns", &show_colums, "show in columns"),
 		OPT__ABBREV(&abbrev),
 		OPT_END()
 	};
@@ -591,6 +595,20 @@ int cmd_ls_files(int argc, const char **argv, cons=
t char *prefix)
 			die("ls-files --with-tree is incompatible with -s or -u");
 		overlay_tree_on_cache(with_tree, prefix);
 	}
+
+	if (show_colums) {
+		const char *argv[] =3D { "column", NULL };
+
+		memset(&cp, 0, sizeof(cp));
+		cp.in =3D -1;
+		cp.out =3D dup(1);
+		cp.argv =3D argv;
+		start_command(&cp);
+		close(1);
+		dup2(cp.in, 1);
+		close(cp.in);
+	}
+
 	show_files(&dir, prefix);
=20
 	if (ps_matched) {
@@ -602,5 +620,18 @@ int cmd_ls_files(int argc, const char **argv, cons=
t char *prefix)
 		return bad ? 1 : 0;
 	}
=20
+	if (show_colums) {
+		fflush(stdout);
+		close(1);
+		finish_command(&cp);
+	}
+
 	return 0;
 }
+
+int cmd_ls(int argc, const char **argv, const char *prefix)
+{
+	max_depth =3D 1;
+	show_colums =3D 1;
+	return cmd_ls_files(argc, argv, prefix);
+}
diff --git a/builtin.h b/builtin.h
index c3f83c0..d8980e5 100644
--- a/builtin.h
+++ b/builtin.h
@@ -61,6 +61,7 @@ extern int cmd_init_db(int argc, const char **argv, c=
onst char *prefix);
 extern int cmd_log(int argc, const char **argv, const char *prefix);
 extern int cmd_log_reflog(int argc, const char **argv, const char *pre=
fix);
 extern int cmd_ls_files(int argc, const char **argv, const char *prefi=
x);
+extern int cmd_ls(int argc, const char **argv, const char *prefix);
 extern int cmd_ls_tree(int argc, const char **argv, const char *prefix=
);
 extern int cmd_ls_remote(int argc, const char **argv, const char *pref=
ix);
 extern int cmd_mailinfo(int argc, const char **argv, const char *prefi=
x);
diff --git a/git.c b/git.c
index 11544cd..4aff5ec 100644
--- a/git.c
+++ b/git.c
@@ -323,6 +323,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "init-db", cmd_init_db },
 		{ "log", cmd_log, RUN_SETUP | USE_PAGER },
 		{ "ls-files", cmd_ls_files, RUN_SETUP },
+		{ "ls", cmd_ls, RUN_SETUP },
 		{ "ls-tree", cmd_ls_tree, RUN_SETUP },
 		{ "ls-remote", cmd_ls_remote },
 		{ "mailinfo", cmd_mailinfo },
--=20
1.6.6.315.g1a406
