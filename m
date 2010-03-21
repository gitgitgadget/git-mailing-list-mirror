From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 02/19] enter_repo(): initialize other variables as setup_git_directory_gently() does
Date: Sun, 21 Mar 2010 17:30:29 +0700
Message-ID: <1269167446-7799-3-git-send-email-pclouds@gmail.com>
References: <1269167446-7799-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 21 11:34:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtIUg-0003AR-ON
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 11:34:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752928Ab0CUKet convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Mar 2010 06:34:49 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:54002 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752861Ab0CUKer (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Mar 2010 06:34:47 -0400
Received: by mail-gw0-f46.google.com with SMTP id a18so509917gwa.19
        for <git@vger.kernel.org>; Sun, 21 Mar 2010 03:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=z4E1zuRRVWxiXpyX4ex2Z/wBHvK2xbyeWaqEitEUTIE=;
        b=iWc+fdgBOzo+BaSI+AgXB6IFu/m32KSrXVkuiSronoIstAyt40K0J+3HGCRT6/3jNx
         r1mlSO8wqJJsZU24Ala/l3rhveU6dSGXWcMTnXnNjRVPPZxqXAVLOh/ucd7INNJ2of3S
         riMgwyxjfzUukZ+u9C1q5fZ0pWJCei/+XCLJE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=KbQHr9rDThJwL4JMm+3U7njIvyG0srpgmoV3yHGGIp8Qyaof6AsdY9UuYi+RQCVluM
         KswOqJGrYsxm4LI7dDamj8+9t1T6BaS3FMm/iNTzKzsCiN9ifWWvnQFvsN03N39QcANz
         LUbX1XsMcH1jU+l5TWgyY4vf7d6upXUTTuv0A=
Received: by 10.101.130.5 with SMTP id h5mr5459240ann.54.1269167678637;
        Sun, 21 Mar 2010 03:34:38 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.230.17])
        by mx.google.com with ESMTPS id 22sm1863284iwn.12.2010.03.21.03.34.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 21 Mar 2010 03:34:38 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 21 Mar 2010 17:30:58 +0700
X-Mailer: git-send-email 1.7.0.2.425.gb99f1
In-Reply-To: <1269167446-7799-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142798>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
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
1.7.0.2.425.gb99f1
