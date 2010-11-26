From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 40/47] setup: clean up setup_bare_git_dir()
Date: Fri, 26 Nov 2010 22:32:36 +0700
Message-ID: <1290785563-15339-41-git-send-email-pclouds@gmail.com>
References: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 26 16:49:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PM0Xr-0000bl-6a
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 16:49:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755427Ab0KZPtB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Nov 2010 10:49:01 -0500
Received: from mail-pw0-f66.google.com ([209.85.160.66]:39840 "EHLO
	mail-pw0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751734Ab0KZPtA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 10:49:00 -0500
Received: by pwj5 with SMTP id 5so469831pwj.1
        for <git@vger.kernel.org>; Fri, 26 Nov 2010 07:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=XdiFRyLbYPW/ei9xdvns1n9Z8lgmjiOq08/2YsTjl5U=;
        b=Xd9BiDLWY0N1YrS34fMytYdXSoZ1BEHmVn07uJalGfEcuFLyy1XPDVEBw/O6w50T6y
         jSTeTFoZGDy0hjZrQqPbczeTjEAX+gW7VMyYJI0yBDnbsSVz0JoVfpAwIG+3KbRJpTCU
         9wG2PrLhtnhU1OKKxzietLAMbDK9vYiTDTkyU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=NYcn7Sj5cEVCpQi/hMrbnR4iv65DwLxWpSlIk+F860SCJ+MDmC86HzI47tAOqBzvsV
         4pjcq2ftPiE3PeEjLelLC7VKE9sJrxtzM4IOqh9H4SA8/yol1zNFl9eHzcZsUuYFdMJa
         ioifzYYV1OM3lErk7la8rwAigxYorrKkT1/VM=
Received: by 10.142.224.11 with SMTP id w11mr2528321wfg.126.1290786540020;
        Fri, 26 Nov 2010 07:49:00 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.252.168])
        by mx.google.com with ESMTPS id x18sm2689215wfa.11.2010.11.26.07.48.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Nov 2010 07:48:59 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 26 Nov 2010 22:47:47 +0700
X-Mailer: git-send-email 1.7.3.2.316.gda8b3
In-Reply-To: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162251>

work_tree_env argument is removed because this function does not need
it. GIT_WORK_TREE is only effective inside setup_explicit_git_dir.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 setup.c |   19 +++++++++----------
 1 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/setup.c b/setup.c
index c7d7198..a6cc044 100644
--- a/setup.c
+++ b/setup.c
@@ -405,26 +405,25 @@ static const char *setup_discovered_git_dir(const=
 char *work_tree_env,
 	return cwd + offset;
 }
=20
-static const char *setup_bare_git_dir(const char *work_tree_env,
-		int offset, int len, char *cwd, int *nongit_ok)
+/* #16.1, #17.1, #20.1, #21.1, #22.1 (see t1510) */
+static const char *setup_bare_git_dir(char *cwd, int offset, int len, =
int *nongit_ok)
 {
 	int root_len;
=20
+	if (check_repository_format_gently(".", nongit_ok))
+		return NULL;
+
 	inside_git_dir =3D 1;
-	if (!work_tree_env)
-		inside_work_tree =3D 0;
+	inside_work_tree =3D 0;
 	if (offset !=3D len) {
 		if (chdir(cwd))
 			die_errno("Cannot come back to cwd");
 		root_len =3D offset_1st_component(cwd);
 		cwd[offset > root_len ? offset : root_len] =3D '\0';
 		set_git_dir(cwd);
-		check_repository_format_gently(cwd, nongit_ok);
 	}
-	else {
+	else
 		set_git_dir(".");
-		check_repository_format_gently(".", nongit_ok);
-	}
 	return NULL;
 }
=20
@@ -509,8 +508,8 @@ static const char *setup_git_directory_gently_1(int=
 *nongit_ok)
 							offset, len,
 							cwd, nongit_ok);
 		if (is_git_directory("."))
-			return setup_bare_git_dir(work_tree_env, offset,
-							len, cwd, nongit_ok);
+			return setup_bare_git_dir(cwd, offset, len, nongit_ok);
+
 		while (--offset > ceil_offset && cwd[offset] !=3D '/');
 		if (offset <=3D ceil_offset)
 			return setup_nongit(cwd, nongit_ok);
--=20
1.7.3.2.316.gda8b3
