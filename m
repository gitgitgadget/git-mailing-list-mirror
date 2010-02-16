From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [WIP PATCH 20/26] bundle: move up gitdir setup to run_builtin()
Date: Tue, 16 Feb 2010 23:05:11 +0700
Message-ID: <1266336317-607-21-git-send-email-pclouds@gmail.com>
References: <1266336317-607-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 17:17:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhQ77-00072y-2r
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 17:17:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757197Ab0BPQRJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Feb 2010 11:17:09 -0500
Received: from mail-gx0-f227.google.com ([209.85.217.227]:34219 "EHLO
	mail-gx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756888Ab0BPQRG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 11:17:06 -0500
Received: by gxk27 with SMTP id 27so91780gxk.1
        for <git@vger.kernel.org>; Tue, 16 Feb 2010 08:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=hRVnQ3HHqrFJDQD8OIlCHeB0CkUSCuuF87YXJh4Gz0U=;
        b=YjRlBC7yprggDLiY05nnRFwArA8bbIl5OPMp4Nju7ak+VzrRY3jBTxuE8Db71crPV6
         3IGvL3t8kbPQU3CpoFUCwXQDk+XEV/j1g2wjPvOAoNrqCZJnVySPBEKBAES25L8iPuTV
         JY2otVbi884jye10GQ+/mYTAo0s8+tKDTDqqA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=lvC5bA4OK8wOq1I3lvuA0WfTLWhQUL2poXtqORfKQx2+faLl3Lbi7PE3LogdQ+OmD3
         7m5xFAva9b453SOY3J5TqC9EzYKbIlrFWcsO1o7ZTChRFwTnZ0PDBJykObGyvfa5Vy98
         KoVoEkQECxx1JQ1X0aDrRGO19EaabCAB8Oeoo=
Received: by 10.101.158.10 with SMTP id k10mr4632459ano.87.1266336607868;
        Tue, 16 Feb 2010 08:10:07 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.207.162])
        by mx.google.com with ESMTPS id 23sm2878566ywh.18.2010.02.16.08.10.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 16 Feb 2010 08:10:07 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 16 Feb 2010 23:07:25 +0700
X-Mailer: git-send-email 1.7.0.195.g637a2
In-Reply-To: <1266336317-607-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140125>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin-bundle.c |    6 ++----
 git.c            |    2 +-
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/builtin-bundle.c b/builtin-bundle.c
index 2006cc5..80649ba 100644
--- a/builtin-bundle.c
+++ b/builtin-bundle.c
@@ -18,7 +18,6 @@ static const char builtin_bundle_usage[] =3D
 int cmd_bundle(int argc, const char **argv, const char *prefix)
 {
 	struct bundle_header header;
-	int nongit;
 	const char *cmd, *bundle_file;
 	int bundle_fd =3D -1;
 	char buffer[PATH_MAX];
@@ -31,7 +30,6 @@ int cmd_bundle(int argc, const char **argv, const cha=
r *prefix)
 	argc -=3D 2;
 	argv +=3D 2;
=20
-	prefix =3D setup_git_directory_gently(&nongit);
 	if (prefix && bundle_file[0] !=3D '/') {
 		snprintf(buffer, sizeof(buffer), "%s/%s", prefix, bundle_file);
 		bundle_file =3D buffer;
@@ -54,11 +52,11 @@ int cmd_bundle(int argc, const char **argv, const c=
har *prefix)
 		return !!list_bundle_refs(&header, argc, argv);
 	}
 	if (!strcmp(cmd, "create")) {
-		if (nongit)
+		if (!startup_info->have_repository)
 			die("Need a repository to create a bundle.");
 		return !!create_bundle(&header, bundle_file, argc, argv);
 	} else if (!strcmp(cmd, "unbundle")) {
-		if (nongit)
+		if (!startup_info->have_repository)
 			die("Need a repository to unbundle.");
 		return !!unbundle(&header, bundle_fd) ||
 			list_bundle_refs(&header, argc, argv);
diff --git a/git.c b/git.c
index 96ccedd..9a85619 100644
--- a/git.c
+++ b/git.c
@@ -312,7 +312,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "bisect--helper", cmd_bisect__helper, RUN_SETUP | NEED_WORK_TREE }=
,
 		{ "blame", cmd_blame, RUN_SETUP },
 		{ "branch", cmd_branch, RUN_SETUP },
-		{ "bundle", cmd_bundle },
+		{ "bundle", cmd_bundle, RUN_SETUP_GENTLY },
 		{ "cat-file", cmd_cat_file, RUN_SETUP },
 		{ "checkout", cmd_checkout, RUN_SETUP | NEED_WORK_TREE },
 		{ "checkout-index", cmd_checkout_index,
--=20
1.7.0.195.g637a2
