From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] entry.c: remove "checkout-index" from error messages
Date: Sun, 28 Nov 2010 11:36:38 +0700
Message-ID: <1290918998-15208-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 28 05:37:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PMZ1P-0006cV-SF
	for gcvg-git-2@lo.gmane.org; Sun, 28 Nov 2010 05:37:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451Ab0K1Ehu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Nov 2010 23:37:50 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:45566 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751317Ab0K1Eht (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Nov 2010 23:37:49 -0500
Received: by pva4 with SMTP id 4so527047pva.19
        for <git@vger.kernel.org>; Sat, 27 Nov 2010 20:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=QRi+2OAAU95FbZHNBKoxs7jtO5cmusQ+vX3UzGwP8dg=;
        b=IFXGC/TBrdzo/kUHtSBNCnQ++vhKjbr9WwOFtLBcGlhhjDlu9bRJIYkB3VM2toyoF+
         26JXFrWMqs8Bq9ium1YqFp08zA3hQ/aQQJ4tHPaecmEXnYK2uDbbnImKsPMH426wj4Of
         pcE5+HFv4scK+OWJFllEfGeQqp2DBaox67xgY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=hS0Ejs82q1XpYGYXioEGq8VaGnR5fL79CbDF5syLH8RnKgY92YpoUUh4QQaExTVaYP
         y7g7CWW1XQGeCR57hoMZYv/t5eTEkGuBpKCAYS8tJ+jacRpQIndWDGaoFRHg6S4FG90/
         VqUVqI+960RP64d01FMJpGwvvseWSXJD4fVIQ=
Received: by 10.142.234.1 with SMTP id g1mr3952365wfh.142.1290919069116;
        Sat, 27 Nov 2010 20:37:49 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.252.168])
        by mx.google.com with ESMTPS id w22sm5271223wfd.7.2010.11.27.20.37.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 27 Nov 2010 20:37:48 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 28 Nov 2010 11:36:40 +0700
X-Mailer: git-send-email 1.7.3.2.316.gda8b3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162335>

Back then when entry.c was part of checkout-index (or checkout-cache
at that time [1]). It makes sense to print the command name in error
messages. Nowadays entry.c is in libgit and can be used by any
commands, printing "git checkout-index: blah" does no more than
confusion. The error messages without it still give enough information.

[1] 12dccc1 (Make fiel checkout function available to the git library -=
 2005-06-05)

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 I attempted to replace "git checkout-index" with the actual command na=
me
 when these functions are called, but I think it's better just removing
 it...

 entry.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/entry.c b/entry.c
index 004182c..b017167 100644
--- a/entry.c
+++ b/entry.c
@@ -106,14 +106,14 @@ static int write_entry(struct cache_entry *ce, ch=
ar *path, const struct checkout
 	case S_IFLNK:
 		new =3D read_blob_entry(ce, &size);
 		if (!new)
-			return error("git checkout-index: unable to read sha1 file of %s (%=
s)",
+			return error("unable to read sha1 file of %s (%s)",
 				path, sha1_to_hex(ce->sha1));
=20
 		if (ce_mode_s_ifmt =3D=3D S_IFLNK && has_symlinks && !to_tempfile) {
 			ret =3D symlink(new, path);
 			free(new);
 			if (ret)
-				return error("git checkout-index: unable to create symlink %s (%s)=
",
+				return error("unable to create symlink %s (%s)",
 					     path, strerror(errno));
 			break;
 		}
@@ -141,7 +141,7 @@ static int write_entry(struct cache_entry *ce, char=
 *path, const struct checkout
 		}
 		if (fd < 0) {
 			free(new);
-			return error("git checkout-index: unable to create file %s (%s)",
+			return error("unable to create file %s (%s)",
 				path, strerror(errno));
 		}
=20
@@ -155,16 +155,16 @@ static int write_entry(struct cache_entry *ce, ch=
ar *path, const struct checkout
 		close(fd);
 		free(new);
 		if (wrote !=3D size)
-			return error("git checkout-index: unable to write file %s", path);
+			return error("unable to write file %s", path);
 		break;
 	case S_IFGITLINK:
 		if (to_tempfile)
-			return error("git checkout-index: cannot create temporary subprojec=
t %s", path);
+			return error("cannot create temporary subproject %s", path);
 		if (mkdir(path, 0777) < 0)
-			return error("git checkout-index: cannot create subproject director=
y %s", path);
+			return error("cannot create subproject directory %s", path);
 		break;
 	default:
-		return error("git checkout-index: unknown file mode for %s", path);
+		return error("unknown file mode for %s in index", path);
 	}
=20
 	if (state->refresh_cache) {
@@ -211,7 +211,7 @@ int checkout_entry(struct cache_entry *ce, const st=
ruct checkout *state, char *t
 			return 0;
 		if (!state->force) {
 			if (!state->quiet)
-				fprintf(stderr, "git-checkout-index: %s already exists\n", path);
+				fprintf(stderr, "%s already exists, no checkout\n", path);
 			return -1;
 		}
=20
--=20
1.7.3.2.316.gda8b3
