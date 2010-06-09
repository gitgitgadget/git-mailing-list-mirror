From: =?UTF-8?q?Cl=C3=A9ment=20Poulain?= 
	<clement.poulain@ensimag.imag.fr>
Subject: [PATCH v3 1/4] sha1_name: add get_sha1_with_context()
Date: Wed,  9 Jun 2010 19:02:06 +0200
Message-ID: <1276102929-31712-2-git-send-email-clement.poulain@ensimag.imag.fr>
References: <1276102929-31712-1-git-send-email-clement.poulain@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Cl=C3=A9ment=20Poulain?= 
	<clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 09 19:02:50 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMOfu-0008KI-U9
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 19:02:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758031Ab0FIRC2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Jun 2010 13:02:28 -0400
Received: from mx1.imag.fr ([129.88.30.5]:52531 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753355Ab0FIRC1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jun 2010 13:02:27 -0400
Received: from ensikerberos.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o59GsX1H032506
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Wed, 9 Jun 2010 18:54:33 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensikerberos.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id o59H2G9Z012745;
	Wed, 9 Jun 2010 19:02:16 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id o59H2Gww031769;
	Wed, 9 Jun 2010 19:02:16 +0200
Received: (from poulainc@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id o59H2G3m031768;
	Wed, 9 Jun 2010 19:02:16 +0200
X-Mailer: git-send-email 1.6.6.7.ga5fe3
In-Reply-To: <1276102929-31712-1-git-send-email-clement.poulain@ensimag.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 09 Jun 2010 18:54:33 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o59GsX1H032506
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: clement.poulain@ensimag.imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148798>

Textconv is defined by the diff driver, which is associated with a path=
name,
not a blob. This fonction permits to know the context for the sha1 you'=
re
looking for, especially his pathname

Signed-off-by: Cl=C3=A9ment Poulain <clement.poulain@ensimag.imag.fr>
Signed-off-by: Diane Gasselin <diane.gasselin@ensimag.imag.fr>
Signed-off-by: Axel Bonnet <axel.bonnet@ensimag.imag.fr>
---
 cache.h     |   11 +++++++++++
 sha1_name.c |   31 ++++++++++++++++++++++++++-----
 2 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/cache.h b/cache.h
index c966023..67030db 100644
--- a/cache.h
+++ b/cache.h
@@ -730,12 +730,23 @@ static inline unsigned int hexval(unsigned char c=
)
 #define MINIMUM_ABBREV 4
 #define DEFAULT_ABBREV 7
=20
+struct object_context {
+	unsigned char tree[20];
+	char path[PATH_MAX];
+	unsigned mode;
+};
+
 extern int get_sha1(const char *str, unsigned char *sha1);
 extern int get_sha1_with_mode_1(const char *str, unsigned char *sha1, =
unsigned *mode, int gently, const char *prefix);
 static inline int get_sha1_with_mode(const char *str, unsigned char *s=
ha1, unsigned *mode)
 {
 	return get_sha1_with_mode_1(str, sha1, mode, 1, NULL);
 }
+extern int get_sha1_with_context_1(const char *name, unsigned char *sh=
a1, struct object_context *orc, int gently, const char *prefix);
+static inline int get_sha1_with_context(const char *str, unsigned char=
 *sha1, struct object_context *orc)
+{
+	return get_sha1_with_context_1(str, sha1, orc, 1, NULL);
+}
 extern int get_sha1_hex(const char *hex, unsigned char *sha1);
 extern char *sha1_to_hex(const unsigned char *sha1);	/* static buffer =
result! */
 extern int read_ref(const char *filename, unsigned char *sha1);
diff --git a/sha1_name.c b/sha1_name.c
index bf92417..7fdb202 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -933,8 +933,8 @@ int interpret_branch_name(const char *name, struct =
strbuf *buf)
  */
 int get_sha1(const char *name, unsigned char *sha1)
 {
-	unsigned unused;
-	return get_sha1_with_mode(name, sha1, &unused);
+	struct object_context unused;
+	return get_sha1_with_context(name, sha1, &unused);
 }
=20
 /* Must be called only when object_name:filename doesn't exist. */
@@ -1032,11 +1032,23 @@ static void diagnose_invalid_index_path(int sta=
ge,
=20
 int get_sha1_with_mode_1(const char *name, unsigned char *sha1, unsign=
ed *mode, int gently, const char *prefix)
 {
+	struct object_context oc;
+	int ret;
+	ret =3D get_sha1_with_context_1(name, sha1, &oc, gently, prefix);
+	*mode =3D oc.mode;
+	return ret;
+}
+
+int get_sha1_with_context_1(const char *name, unsigned char *sha1,
+			    struct object_context *oc,
+			    int gently, const char *prefix)
+{
 	int ret, bracket_depth;
 	int namelen =3D strlen(name);
 	const char *cp;
=20
-	*mode =3D S_IFINVALID;
+	memset(oc, 0, sizeof(*oc));
+	oc->mode =3D S_IFINVALID;
 	ret =3D get_sha1_1(name, namelen, sha1);
 	if (!ret)
 		return ret;
@@ -1059,6 +1071,11 @@ int get_sha1_with_mode_1(const char *name, unsig=
ned char *sha1, unsigned *mode,
 			cp =3D name + 3;
 		}
 		namelen =3D namelen - (cp - name);
+
+		strncpy(oc->path, cp,
+			sizeof(oc->path));
+		oc->path[sizeof(oc->path)-1] =3D '\0';
+
 		if (!active_cache)
 			read_cache();
 		pos =3D cache_name_pos(cp, namelen);
@@ -1071,7 +1088,6 @@ int get_sha1_with_mode_1(const char *name, unsign=
ed char *sha1, unsigned *mode,
 				break;
 			if (ce_stage(ce) =3D=3D stage) {
 				hashcpy(sha1, ce->sha1);
-				*mode =3D ce->ce_mode;
 				return 0;
 			}
 			pos++;
@@ -1098,12 +1114,17 @@ int get_sha1_with_mode_1(const char *name, unsi=
gned char *sha1, unsigned *mode,
 		}
 		if (!get_sha1_1(name, cp-name, tree_sha1)) {
 			const char *filename =3D cp+1;
-			ret =3D get_tree_entry(tree_sha1, filename, sha1, mode);
+			ret =3D get_tree_entry(tree_sha1, filename, sha1, &oc->mode);
 			if (!gently) {
 				diagnose_invalid_sha1_path(prefix, filename,
 							   tree_sha1, object_name);
 				free(object_name);
 			}
+			hashcpy(oc->tree, tree_sha1);
+			strncpy(oc->path, filename,
+				sizeof(oc->path));
+			oc->path[sizeof(oc->path)-1] =3D '\0';
+
 			return ret;
 		} else {
 			if (!gently)
--=20
1.6.6.7.ga5fe3
