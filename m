From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/3] clone: do not accept --depth on local clones
Date: Fri, 20 Aug 2010 11:51:05 +1000
Message-ID: <1282269067-5527-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>, mikachu@gmail.com,
	computerdruid@gmail.com, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 20 03:51:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmGlY-0007EH-P5
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 03:51:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504Ab0HTBvY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Aug 2010 21:51:24 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:55333 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750849Ab0HTBvX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Aug 2010 21:51:23 -0400
Received: by pzk26 with SMTP id 26so1019216pzk.19
        for <git@vger.kernel.org>; Thu, 19 Aug 2010 18:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=/j8kzhKj1S1eIxZp0S5VjBcOv+hLPb3gwETmti65Vlc=;
        b=s+3oQnpo9WnxmLHhxwH7cBieEINDYM+SoKEMN2nNq+6iejnLuRvb1OwXzddMVrWC5V
         tFN04c58F9NkjiBV9UWkrIFx9y6RUDPBiwvS7hg3X6qiCzhAkwtBUYtgFlVKxHbmBKNu
         LQYvl041OGPP+jDU4GWaJwFIJ7385mS9gHY00=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=apaOf4tgVF3A9jp8eoCEao96b4jfElzQfrDh/MsjCJP/WfQnozXuMCEU9H1Py/A/qD
         3OLEdw/0GOKFK+AnyamK3ybq82b2dqncXDCUT2elRlW3ej7VBWQDwO3jfkOq2O5LO2kp
         O+213qLT043DcfptlAlZ/LWLn6qWRmhpZGJaY=
Received: by 10.114.121.16 with SMTP id t16mr762092wac.169.1282269082802;
        Thu, 19 Aug 2010 18:51:22 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id q6sm3778247waj.22.2010.08.19.18.51.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 19 Aug 2010 18:51:21 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Fri, 20 Aug 2010 11:51:10 +1000
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153968>

clone_local() function disregards --depth. Make it more apparent.
Also hint users that file:// works with --depth.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/clone.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index efb1e6f..e787cf2 100644
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
@@ -414,6 +414,10 @@ int cmd_clone(int argc, const char **argv, const c=
har *prefix)
 		repo =3D xstrdup(make_absolute_path(repo_name));
 	else
 		repo =3D repo_name;
+	is_local =3D path && !is_bundle;
+	if (is_local && option_depth)
+		die("local clone with --depth does not make sense\n"
+		    "hint: use file:// instead");
=20
 	if (argc =3D=3D 2)
 		dir =3D xstrdup(argv[1]);
@@ -514,7 +518,7 @@ int cmd_clone(int argc, const char **argv, const ch=
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
