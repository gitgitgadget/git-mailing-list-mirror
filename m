From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 6/9] setup: clean up setup_bare_git_dir()
Date: Mon,  1 Nov 2010 13:26:31 +0700
Message-ID: <1288592794-24221-6-git-send-email-pclouds@gmail.com>
References: <AANLkTim-uW4Esk1bkPzNNGRb8svZoNwCUvXF3Fqb4QmR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 01 07:27:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCnrm-0001t5-CO
	for gcvg-git-2@lo.gmane.org; Mon, 01 Nov 2010 07:27:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753416Ab0KAG1V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Nov 2010 02:27:21 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:36067 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592Ab0KAG1T (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Nov 2010 02:27:19 -0400
Received: by mail-gx0-f174.google.com with SMTP id 23so2961184gxk.19
        for <git@vger.kernel.org>; Sun, 31 Oct 2010 23:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=y0j2TniCytElqjAgI4ns7hUU+qQgXajtDj0Tb4ytRFI=;
        b=pM4qapDlXdTUblVpCsSqNc5gEyNljABTk2iOWlVceOHhrfFiqQcJHlW99SykO/M7+U
         IB06UtUV4ogdZLscTVJlfNpibBUWeAD4IH/d22xPO1wvWFxV5PqqkpxMHAnncYKjR4Go
         lz0IZL8lX2nPAwZAzQAF2MYHxne7EBZyGwVuA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=A8xhtnkjG6ZzM4P7fvVN0brH5qf7B6jVepORkO2WQUKC2QNlKs1nmBVIPNV4coH6O7
         0QGd6RvMg/TQLpQ8otbTawZtG1dmGX+mHrG33HfW1YmdcwJQ+7Q0s+aNjZqQyAs3VteC
         pWkoov6b8J2iUjr3fK+sJtCNki8qItuMxH0Ss=
Received: by 10.150.12.5 with SMTP id 5mr27666494ybl.257.1288592839418;
        Sun, 31 Oct 2010 23:27:19 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id t9sm7079416ybe.9.2010.10.31.23.27.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 31 Oct 2010 23:27:18 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 01 Nov 2010 13:27:20 +0700
X-Mailer: git-send-email 1.7.3.2.210.g045198
In-Reply-To: <AANLkTim-uW4Esk1bkPzNNGRb8svZoNwCUvXF3Fqb4QmR@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160464>

work_tree_env argument is removed because this function does not need
it. GIT_WORK_TREE is only effective inside setup_explicit_git_dir.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
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
1.7.3.2.210.g045198
