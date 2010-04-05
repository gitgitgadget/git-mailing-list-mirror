From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 23/43] enter_repo(): initialize other variables as setup_git_directory_gently() does
Date: Mon,  5 Apr 2010 20:41:08 +0200
Message-ID: <1270492888-26589-24-git-send-email-pclouds@gmail.com>
References: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 05 20:43:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyrH4-0000ps-W5
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 20:43:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756090Ab0DESm5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Apr 2010 14:42:57 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:44752 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756042Ab0DESmt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 14:42:49 -0400
Received: by mail-fx0-f227.google.com with SMTP id 27so1251549fxm.28
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 11:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=xJDZ9NdVTxx2hAo5RrmRM1qKlAT0O3breGlASIqVVzA=;
        b=BlOeZn6AAqphTXUyq30nKYo2ctNcspd8GF36CdUqnLJVV8PPM/kqLvmvKkawW8WLbH
         caK4RKuReOkmSbyNSvC/o/rz28OecPrLRHL8+eqZvRt087bAThn05mEiv7mWhIKzWyXI
         1eL9rdWqsh0a0sAuKCpZKrf0EuCfZzgReUAmo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=H4GoKW9t2GczKWPr4u2VTzXMFx6klB4qfV8QPiIhciAUSCwXuSL4837UKHTns3JSJC
         OuzWvDzM6e0XsGrY/2oiM7xwYTZiIXW73tOTW5heR2ZJaiHPnA+TdvUIGvhWGQAO1+KA
         rEkeW+1G5IZGmhZypGEnkvldX9N9zer0XcqnI=
Received: by 10.223.65.73 with SMTP id h9mr6022414fai.75.1270492968290;
        Mon, 05 Apr 2010 11:42:48 -0700 (PDT)
Received: from dektop ([212.247.124.209])
        by mx.google.com with ESMTPS id k29sm26920737fkk.15.2010.04.05.11.42.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 05 Apr 2010 11:42:47 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Mon,  5 Apr 2010 20:42:45 +0200
X-Mailer: git-send-email 1.7.0.rc1.541.g2da82.dirty
In-Reply-To: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144030>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 setup.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/setup.c b/setup.c
index 3019da2..e067292 100644
--- a/setup.c
+++ b/setup.c
@@ -535,8 +535,14 @@ char *enter_repo(char *path, int strict)
=20
 	if (access("objects", X_OK) =3D=3D 0 && access("refs", X_OK) =3D=3D 0=
 &&
 	    validate_headref("HEAD") =3D=3D 0) {
-		set_git_dir(".");
+		inside_work_tree =3D 0;
+		inside_git_dir =3D 1;
 		check_repository_format();
+		set_git_dir(".");
+		if (startup_info) {
+			startup_info->prefix =3D NULL;
+			startup_info->have_repository =3D 1;
+		}
 		return path;
 	}
=20
--=20
1.7.0.rc1.541.g2da82.dirty
