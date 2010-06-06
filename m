From: =?UTF-8?q?Cl=C3=A9ment=20Poulain?= 
	<clement.poulain@ensimag.imag.fr>
Subject: [RFC/PATCH 2/4] textconv: support for cat-file
Date: Sun,  6 Jun 2010 13:30:46 +0200
Message-ID: <1275823848-7151-3-git-send-email-clement.poulain@ensimag.imag.fr>
References: <1275823848-7151-1-git-send-email-clement.poulain@ensimag.imag.fr>
 <1275823848-7151-2-git-send-email-clement.poulain@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: spearce@spearce.org, drizzd@aon.at, matthieu.moy@grenoble-inp.fr,
	=?UTF-8?q?Cl=C3=A9ment=20Poulain?= 
	<clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 06 13:32:13 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLE5M-000667-MX
	for gcvg-git-2@lo.gmane.org; Sun, 06 Jun 2010 13:32:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933976Ab0FFLb6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Jun 2010 07:31:58 -0400
Received: from mx2.imag.fr ([129.88.30.17]:52856 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933861Ab0FFLb5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jun 2010 07:31:57 -0400
Received: from ensikerberos.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o56BODpe030404
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 6 Jun 2010 13:24:13 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensikerberos.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id o56BVmX4007130;
	Sun, 6 Jun 2010 13:31:48 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id o56BVmMS008025;
	Sun, 6 Jun 2010 13:31:48 +0200
Received: (from poulainc@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id o56BVmBR008024;
	Sun, 6 Jun 2010 13:31:48 +0200
X-Mailer: git-send-email 1.6.6.7.ga5fe3
In-Reply-To: <1275823848-7151-2-git-send-email-clement.poulain@ensimag.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 06 Jun 2010 13:24:13 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o56BODpe030404
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: clement.poulain@ensimag.imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148515>

Make the textconv_object function public, and add --textconv option to =
cat-file to perform conversion on blob objects. Using --textconv implie=
s that we are working on a blob

Signed-off-by: Cl=C3=A9ment Poulain <clement.poulain@ensimag.imag.fr>
Signed-off-by: Diane Gasselin <diane.gasselin@ensimag.imag.fr>
Signed-off-by: Axel Bonnet <axel.bonnet@ensimag.imag.fr>
---
 builtin/blame.c    |    8 ++++----
 builtin/cat-file.c |   21 ++++++++++++++++++++-
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 4679fd9..869be1d 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -91,10 +91,10 @@ struct origin {
  * if the textconv driver exists.
  * Return 1 if the conversion succeeds, 0 otherwise.
  */
-static int textconv_object(const char *path,
-			   const unsigned char *sha1,
-			   unsigned short mode,
-			   struct strbuf *buf)
+int textconv_object(const char *path,
+		    const unsigned char *sha1,
+		    unsigned short mode,
+		    struct strbuf *buf)
 {
 	struct diff_filespec *df;
=20
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 124e0a9..fde5fb9 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -9,6 +9,7 @@
 #include "tree.h"
 #include "builtin.h"
 #include "parse-options.h"
+#include "diff.h"
=20
 #define BATCH 1
 #define BATCH_CHECK 2
@@ -135,6 +136,21 @@ static int cat_one_file(int opt, const char *exp_t=
ype, const char *obj_name)
=20
 		/* otherwise just spit out the data */
 		break;
+
+	case 'c':
+		if (!object_context.path[0])
+			die("git cat-file --textconv %s: <object> must be <sha1:path>",
+			    obj_name);
+
+		if(textconv_object(object_context.path, sha1,
+				   object_context.mode, &sbuf))
+			buf =3D strbuf_detach(&sbuf, (size_t *) &size);
+		else
+			buf =3D read_object_with_reference(sha1, "blob", &size, NULL);
+
+		strbuf_release(&sbuf);
+		break;
+
 	case 0:
 		buf =3D read_object_with_reference(sha1, exp_type, &size, NULL);
 		break;
@@ -204,7 +220,7 @@ static int batch_objects(int print_contents)
 }
=20
 static const char * const cat_file_usage[] =3D {
-	"git cat-file (-t|-s|-e|-p|<type>) <object>",
+	"git cat-file (-t|-s|-e|-p|<type>|--textconv) <object>",
 	"git cat-file (--batch|--batch-check) < <list_of_objects>",
 	NULL
 };
@@ -221,6 +237,8 @@ int cmd_cat_file(int argc, const char **argv, const=
 char *prefix)
 		OPT_SET_INT('e', NULL, &opt,
 			    "exit with zero when there's no error", 'e'),
 		OPT_SET_INT('p', NULL, &opt, "pretty-print object's content", 'p'),
+		OPT_SET_INT(0, "textconv", &opt,
+				"for blob objects, run textconv on object's content", 'c'),
 		OPT_SET_INT(0, "batch", &batch,
 			    "show info and content of objects fed from the standard input",
 			    BATCH),
@@ -231,6 +249,7 @@ int cmd_cat_file(int argc, const char **argv, const=
 char *prefix)
 	};
=20
 	git_config(git_default_config, NULL);
+	git_config(git_diff_basic_config, NULL);
=20
 	if (argc !=3D 3 && argc !=3D 2)
 		usage_with_options(cat_file_usage, options);
--=20
1.6.6.7.ga5fe3
