From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 6/8] mv: unindent one level for directory move code
Date: Sun, 10 Aug 2014 09:29:34 +0700
Message-ID: <1407637776-19794-7-git-send-email-pclouds@gmail.com>
References: <1407637776-19794-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 10 04:30:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XGItp-0003tW-8H
	for gcvg-git-2@plane.gmane.org; Sun, 10 Aug 2014 04:30:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752120AbaHJCaO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Aug 2014 22:30:14 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:54377 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751631AbaHJCaN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Aug 2014 22:30:13 -0400
Received: by mail-pa0-f52.google.com with SMTP id bj1so9265764pad.11
        for <git@vger.kernel.org>; Sat, 09 Aug 2014 19:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=EvDl7y1U/EtrCJD3nolADLm3dg0j683qtE/e9WyVRxs=;
        b=DXT8DRq1IATYyFXYdT8LMwTzNTBUc1V8lmUcqSeGAIM0a2dqHIhiV76gC0Tw2NdhFC
         WyQ7wq65b6xgcG3EPP8ifFFAtTSvCG5wDhCqZWcJqYrLQnJmlpRNg52Fv02MOaP5ruS9
         J+8ElSverRRxQGsVcvoojadIKHKtkBz8XiaVyYWr/ORWW7fktWfmW7pXB/akS7dERR3z
         3UCtFiv/8y9ZINo68D9UVoKOvfIepbnAdXDKB41FJj15CcREMfOLrCdLVBj6ZLE05Bqc
         y0/RS6JMo9tFBTDT37vYQeloR80hu8Pfk4MSneEardcojMMY6hYKmUdYmyRKQRCXVpUj
         o00g==
X-Received: by 10.70.88.237 with SMTP id bj13mr33472722pdb.57.1407637813240;
        Sat, 09 Aug 2014 19:30:13 -0700 (PDT)
Received: from lanh ([115.73.228.225])
        by mx.google.com with ESMTPSA id cj17sm11005670pdb.75.2014.08.09.19.30.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Aug 2014 19:30:12 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 10 Aug 2014 09:30:16 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1407637776-19794-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255082>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/mv.c | 47 +++++++++++++++++++++--------------------------
 1 file changed, 21 insertions(+), 26 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index dcfcb11..988945c 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -171,42 +171,37 @@ int cmd_mv(int argc, const char **argv, const cha=
r *prefix)
 				&& lstat(dst, &st) =3D=3D 0)
 			bad =3D _("cannot move directory over file");
 		else if (src_is_dir) {
-			int first =3D cache_name_pos(src, length);
+			int first =3D cache_name_pos(src, length), last;
 			if (first >=3D 0)
 				prepare_move_submodule(src, first,
 						       submodule_gitfile + i);
-			else {
-				int last;
-
+			else if (index_range_of_same_dir(src, length,
+							 &first, &last) < 1) {
 				modes[i] =3D WORKING_DIRECTORY;
-				index_range_of_same_dir(src, length, &first, &last);
 				if (last - first < 1)
 					bad =3D _("source directory is empty");
-				else {
-					int j, dst_len, n;
+			} else { /* last - first >=3D 1 */
+				int j, dst_len, n;
=20
-					n =3D argc + last - first;
-					source =3D xrealloc(source, n * sizeof(char *));
-					destination =3D xrealloc(destination, n * sizeof(char *));
-					modes =3D xrealloc(modes, n * sizeof(enum update_mode));
-					submodule_gitfile =3D
-						xrealloc(submodule_gitfile, n * sizeof(char *));
+				modes[i] =3D WORKING_DIRECTORY;
+				n =3D argc + last - first;
+				source =3D xrealloc(source, n * sizeof(char *));
+				destination =3D xrealloc(destination, n * sizeof(char *));
+				modes =3D xrealloc(modes, n * sizeof(enum update_mode));
+				submodule_gitfile =3D xrealloc(submodule_gitfile, n * sizeof(char =
*));
=20
-					dst =3D add_slash(dst);
-					dst_len =3D strlen(dst);
+				dst =3D add_slash(dst);
+				dst_len =3D strlen(dst);
=20
-					for (j =3D 0; j < last - first; j++) {
-						const char *path =3D
-							active_cache[first + j]->name;
-						source[argc + j] =3D path;
-						destination[argc + j] =3D
-							prefix_path(dst, dst_len,
-								path + length + 1);
-						modes[argc + j] =3D INDEX;
-						submodule_gitfile[argc + j] =3D NULL;
-					}
-					argc +=3D last - first;
+				for (j =3D 0; j < last - first; j++) {
+					const char *path =3D active_cache[first + j]->name;
+					source[argc + j] =3D path;
+					destination[argc + j] =3D
+						prefix_path(dst, dst_len, path + length + 1);
+					modes[argc + j] =3D INDEX;
+					submodule_gitfile[argc + j] =3D NULL;
 				}
+				argc +=3D last - first;
 			}
 		} else if (cache_name_pos(src, length) < 0)
 			bad =3D _("not under version control");
--=20
2.1.0.rc0.78.gc0d8480
