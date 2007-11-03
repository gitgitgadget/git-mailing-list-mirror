From: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH] Make struct commands[] const to save a couple bytes
Date: Sat, 3 Nov 2007 18:13:24 +0700
Message-ID: <20071103111324.GA30441@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 03 12:14:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoGxM-0001Mi-0v
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 12:14:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753160AbXKCLNl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Nov 2007 07:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753110AbXKCLNl
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 07:13:41 -0400
Received: from rv-out-0910.google.com ([209.85.198.187]:3917 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753160AbXKCLNi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 07:13:38 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1029575rvb
        for <git@vger.kernel.org>; Sat, 03 Nov 2007 04:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:content-transfer-encoding:user-agent;
        bh=OskfXRlf1Ut5HMbXk4QjUckknE7GTp2f2xZ075psuCs=;
        b=bPULN7E7XS/xcgVBiM3NyqEa0KDMgK4NshrKBAWod4fYU9gfVGX1IfFXglten765Lxz8gwrW9H7iJ8M6omArAWtIpxkkOCGrBVx32tHJfYrcjBlhcd9IwNlpw0eLjQXKEtJOvYnlIXDi3O4EsRD3SHRW3UApYqyJHxh/FC7z4Eo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:content-transfer-encoding:user-agent;
        b=dJIVFZ1JSILR8w8qu2TC4G7uDMcStQr4wly2sPjGmeGY2ZhSwfltCViWVuPl2gkY1tdfraFCkzCQ2tDNnqi4qlW/eK248R7MFbtdWZBSgC10jOOFr+aqTPHtbtRwtstKwlkheBxGaVzKSfQK10a/Px2b8W5NAYvCfrCn50F07sU=
Received: by 10.141.133.14 with SMTP id k14mr1378499rvn.1194088417133;
        Sat, 03 Nov 2007 04:13:37 -0700 (PDT)
Received: from pclouds@gmail.com ( [117.5.0.14])
        by mx.google.com with ESMTPS id g1sm8702135rvb.2007.11.03.04.13.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 03 Nov 2007 04:13:36 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat,  3 Nov 2007 18:13:24 +0700
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63232>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 .data got reduced by 960 bytes. Not much, but anyway ;)

 git.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git.c b/git.c
index 4e10581..d0a2042 100644
--- a/git.c
+++ b/git.c
@@ -238,7 +238,7 @@ struct cmd_struct {
 	int option;
 };
=20
-static int run_command(struct cmd_struct *p, int argc, const char **ar=
gv)
+static int run_command(const struct cmd_struct *p, int argc, const cha=
r **argv)
 {
 	int status;
 	struct stat st;
@@ -283,7 +283,7 @@ static int run_command(struct cmd_struct *p, int ar=
gc, const char **argv)
 static void handle_internal_command(int argc, const char **argv)
 {
 	const char *cmd =3D argv[0];
-	static struct cmd_struct commands[] =3D {
+	static const struct cmd_struct commands[] =3D {
 		{ "add", cmd_add, RUN_SETUP | NEED_WORK_TREE },
 		{ "annotate", cmd_annotate, RUN_SETUP },
 		{ "apply", cmd_apply },
@@ -375,7 +375,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 	}
=20
 	for (i =3D 0; i < ARRAY_SIZE(commands); i++) {
-		struct cmd_struct *p =3D commands+i;
+		const struct cmd_struct *p =3D commands+i;
 		if (strcmp(p->cmd, cmd))
 			continue;
 		exit(run_command(p, argc, argv));
--=20
1.5.3.rc4.3.gab089
