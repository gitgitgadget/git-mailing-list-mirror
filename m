From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 18/32] setup.c: detect $GIT_COMMON_DIR check_repository_format_gently()
Date: Sun, 28 Sep 2014 08:22:32 +0700
Message-ID: <1411867366-3821-19-git-send-email-pclouds@gmail.com>
References: <xmqqk34r9z3r.fsf@gitster.dls.corp.google.com>
 <1411867366-3821-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 28 03:24:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XY3E0-0002Vx-AL
	for gcvg-git-2@plane.gmane.org; Sun, 28 Sep 2014 03:24:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753399AbaI1BY2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Sep 2014 21:24:28 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:63128 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753183AbaI1BY1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Sep 2014 21:24:27 -0400
Received: by mail-pa0-f47.google.com with SMTP id rd3so4885688pab.34
        for <git@vger.kernel.org>; Sat, 27 Sep 2014 18:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=JoOlKr9zi8ued9AQI5701Afp12eVvFJJtekJykSN4mY=;
        b=YpHZXtACW3q4o73+WIgAyxbj1VqTrnXq5ktzLEyb2ZhfF/BJsve21EjUQ0nTH9ouxi
         n3eFTqksXUOnVgzjfA1NJtWENvacKdO3njNDEwLAz9NyjBELHb2d4zhKZTDKV8fwM8Z8
         6F/w9nlDzakXa02vIvJHrVdUkZl9CZHiPTdEoIUcWp09u1A/Hug2NDqeQYxEDdi7TZHj
         VfNVBIMblcv8lC+L8syPtue06ZngKfygW9dPkap7z72qnvxn0NVMndYSyDXV203ei91X
         BteULN+uUE33ElE8EUuShqsuB6yTXj1mkstxfLUMF1MFta0fMxSD7TXWxdmWpirwNe9K
         6cDg==
X-Received: by 10.66.141.165 with SMTP id rp5mr45786744pab.115.1411867467360;
        Sat, 27 Sep 2014 18:24:27 -0700 (PDT)
Received: from lanh ([115.73.212.224])
        by mx.google.com with ESMTPSA id iu10sm8517446pbd.57.2014.09.27.18.24.24
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Sep 2014 18:24:26 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 28 Sep 2014 08:24:30 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1411867366-3821-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257577>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 setup.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/setup.c b/setup.c
index 00a23e6..1d4f1aa 100644
--- a/setup.c
+++ b/setup.c
@@ -346,6 +346,10 @@ static int check_repository_format_gently(const ch=
ar *gitdir, int *nongit_ok)
 	const char *repo_config;
 	int ret =3D 0;
=20
+	get_common_dir(&sb, gitdir);
+	strbuf_addstr(&sb, "/config");
+	repo_config =3D sb.buf;
+
 	/*
 	 * git_config() can't be used here because it calls git_pathdup()
 	 * to get $GIT_CONFIG/config. That call will make setup_git_env()
@@ -355,8 +359,6 @@ static int check_repository_format_gently(const cha=
r *gitdir, int *nongit_ok)
 	 * Use a gentler version of git_config() to check if this repo
 	 * is a good one.
 	 */
-	strbuf_addf(&sb, "%s/config", gitdir);
-	repo_config =3D sb.buf;
 	git_config_early(check_repository_format_version, NULL, repo_config);
 	if (GIT_REPO_VERSION < repository_format_version) {
 		if (!nongit_ok)
--=20
2.1.0.rc0.78.gc0d8480
