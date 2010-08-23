From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 1/3] clone: warn users --depth is ignored in local clones
Date: Mon, 23 Aug 2010 22:08:22 +1000
Message-ID: <1282565304-3122-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 24 00:36:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Onfcw-0001sQ-Ep
	for gcvg-git-2@lo.gmane.org; Tue, 24 Aug 2010 00:36:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754190Ab0HWWgK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Aug 2010 18:36:10 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:35019 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753263Ab0HWWgJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Aug 2010 18:36:09 -0400
Received: by pxi10 with SMTP id 10so2448543pxi.19
        for <git@vger.kernel.org>; Mon, 23 Aug 2010 15:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=2yeIjV/sngZT+5SZEO2ipD8BjlZy5RzTs/Uzy5QjXsI=;
        b=KAQ38t04SYDNrvv4GNVwL9Y2KKs4HwH6N/J+LSjTMdXPqAAHbOBW3L3KmvquNGAPpA
         mVB2LOnL2NjeW//omGqF9zB3UXbc6qEOgb+rjX7n2oU59gUjfSnC/Ymeorz26gv7bFiN
         3DOu63DMkWJBePcg8+8hK6Fqea6V8GxOqw3ZQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=m7+pqUyOa/hRNnwHkWi7SBZ7XJfHgetBSuGCK/2Zxzj7PgkrtkJJNt+wg0fBDHuC7s
         FL9zhdGK4JiJCVst0bngKR56BO6MPUkN0StbdouILUj13IN5tBqPlYxcv2BCLMCX9clI
         le7poCpBZe+iHX4Gu2ZnVVGT39mxP0qpIrtSs=
Received: by 10.142.232.13 with SMTP id e13mr4943961wfh.117.1282602968735;
        Mon, 23 Aug 2010 15:36:08 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id y16sm9051689wff.2.2010.08.23.15.36.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 23 Aug 2010 15:36:06 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Mon, 23 Aug 2010 22:08:30 +1000
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154267>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Just warn users instead of dying in the old patch.

 builtin/clone.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index efb1e6f..fcdb039 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -361,7 +361,7 @@ static void write_remote_refs(const struct ref *loc=
al_refs)
=20
 int cmd_clone(int argc, const char **argv, const char *prefix)
 {
-	int is_bundle =3D 0;
+	int is_bundle =3D 0, is_local;
 	struct stat buf;
 	const char *repo_name, *repo, *work_tree, *git_dir;
 	char *path, *dir;
@@ -414,6 +414,9 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
 		repo =3D xstrdup(make_absolute_path(repo_name));
 	else
 		repo =3D repo_name;
+	is_local =3D path && !is_bundle;
+	if (is_local && option_depth)
+		warning("--depth is ignored in local clones, use file:// instead.");
=20
 	if (argc =3D=3D 2)
 		dir =3D xstrdup(argv[1]);
@@ -514,7 +517,7 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
=20
 	strbuf_reset(&value);
=20
-	if (path && !is_bundle) {
+	if (is_local) {
 		refs =3D clone_local(path, git_dir);
 		mapped_refs =3D wanted_peer_refs(refs, refspec);
 	} else {
--=20
1.7.1.rc1.69.g24c2f7
