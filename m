From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/3] clone: do not accept --depth on local clones
Date: Thu, 19 Aug 2010 20:40:35 +1000
Message-ID: <1282214437-16384-1-git-send-email-pclouds@gmail.com>
References: <201008180854.18474.ComputerDruid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, computerdruid@gmail.com, joey@kitenet.net
X-From: git-owner@vger.kernel.org Thu Aug 19 13:27:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Om3H0-0002HP-Gs
	for gcvg-git-2@lo.gmane.org; Thu, 19 Aug 2010 13:27:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752569Ab0HSL04 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Aug 2010 07:26:56 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:51059 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751119Ab0HSL0z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Aug 2010 07:26:55 -0400
Received: by pwi7 with SMTP id 7so471942pwi.19
        for <git@vger.kernel.org>; Thu, 19 Aug 2010 04:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=ewOadI2OmnaOTYQZHonATatnryDD9pLy5FjyI3ELHdg=;
        b=eXEHWa6VNDtYeeVnbiN2PSZz7uRPCo4nicPgcyjahkx9JEb3JJ5d+iubJUe9+0M7JV
         KUxpZN3dz7POFSwC4uhbKleBre30aSFHAg+03APhiuFT/XFltXYsNO5v6CT1KWYJWCRH
         RxqqMZbIuxiPf9jJOIl25pbNLNlOQJzsRqCbg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=ZxO/pcLGciam6X0Q3I3RL0HRVVDqGvMWtuVGqIA5ouSSUa5WKD1E5Or/QXeOH7pNsf
         BMEoM/OYBsXa3/3ldQgzqlMJ4yV97jvQitZUaTRFhSLoe9bR7Xb5zOdSx0C4AbZXNyYn
         yOmkR8CwAaCpCUhD5AiwlHqv+UG5UbIWaPsmo=
Received: by 10.114.66.20 with SMTP id o20mr11079081waa.163.1282217214713;
        Thu, 19 Aug 2010 04:26:54 -0700 (PDT)
Received: from dektop ([121.91.127.5])
        by mx.google.com with ESMTPS id d39sm2477461wam.4.2010.08.19.04.26.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 19 Aug 2010 04:26:53 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Thu, 19 Aug 2010 20:40:38 +1000
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <201008180854.18474.ComputerDruid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153915>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/clone.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index efb1e6f..215c432 100644
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
+		die("local clone with --depth does not make sense");
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
