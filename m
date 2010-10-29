From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 39/42] setup: clean up setup_bare_git_dir()
Date: Fri, 29 Oct 2010 13:48:51 +0700
Message-ID: <1288334934-17216-40-git-send-email-pclouds@gmail.com>
References: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 08:54:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBiqz-0007fo-N6
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 08:54:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933548Ab0J2GyN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Oct 2010 02:54:13 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:57125 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933422Ab0J2GyL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 02:54:11 -0400
Received: by mail-iw0-f174.google.com with SMTP id 10so3313568iwn.19
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 23:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=UuJ8G2p8QN+HuIBznmm6zk1zBN/kfphoTun/TmBDogs=;
        b=LvMcdh5gKEhEa5h8LsnWiIjMx+mWHdwOpGvllD7YkipOdSZNzpeaa7J/RcBlVQuDOe
         yA6UX+dsQ51pIAIOKaFmAmNCxY09kJdtYs/Jj7guLcHOuTLL1M4CWjcHJ+e2JRadLrAU
         ptm3OaSzeTv6ZC68kUno0Dmuqb2R3RKUNIPSQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=sLP4dlEGq3tImpleDfwUz30tzbKFpC1UaCrsCOrx/B4q7wX6CLzpO48rJihc3tOM3H
         I/kSkH38DQU+8Lhzanevg1WAbUIp3EbtZtbMcDFgoBzW+VaYDuBcW2bJlgS+9e1ltdTt
         TcMQvZlgTP8YtLUSdJ3fjEeY7yik8nIyHairQ=
Received: by 10.42.30.8 with SMTP id t8mr9168058icc.269.1288335251026;
        Thu, 28 Oct 2010 23:54:11 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id w9sm3335448ibc.1.2010.10.28.23.54.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Oct 2010 23:54:10 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 29 Oct 2010 13:54:10 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160307>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 setup.c |   19 +++++++++----------
 1 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/setup.c b/setup.c
index 49a1a25..cba9bec 100644
--- a/setup.c
+++ b/setup.c
@@ -400,26 +400,25 @@ static const char *setup_discovered_git_dir(const=
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
@@ -504,8 +503,8 @@ static const char *setup_git_directory_gently_1(int=
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
1.7.0.2.445.gcbdb3
