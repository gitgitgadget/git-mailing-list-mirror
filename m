From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v7 18/31] setup.c: detect $GIT_COMMON_DIR check_repository_format_gently()
Date: Sun, 13 Jul 2014 11:50:55 +0700
Message-ID: <1405227068-25506-19-git-send-email-pclouds@gmail.com>
References: <1404891197-18067-1-git-send-email-pclouds@gmail.com>
 <1405227068-25506-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Max Kirillov <max@max630.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 13 06:54:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6BoI-0000hV-6Q
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jul 2014 06:54:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752877AbaGMEyr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jul 2014 00:54:47 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:55074 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752633AbaGMEyp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2014 00:54:45 -0400
Received: by mail-pd0-f182.google.com with SMTP id fp1so646614pdb.13
        for <git@vger.kernel.org>; Sat, 12 Jul 2014 21:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=CSgffAFZAjkMY2PTTwYgwlor0NTS/344KGlQeK+d8Gc=;
        b=BCzX32GybUvaev4LhDgv5uj3TF49nkNjc7ba/PTBWWk/KOY+rD4IdMoBuvz2dnwL1E
         4lRA5h2AkhsimOov0fjcJOC3x8FMDuISMuSdFxVPtYCkVbbcAnkbStvZCWiZdXbSjz1k
         XURXkivYsOyNhzqSKY+TEP97txjoV0nt7ner4hACd0urBi6Tn4CqluBP2kcJJaXmH2bZ
         AXtFnGflb5xXzRVUemQOjh1qpKrcB4A3q+3819Ap/luifnRVhspr9U/+36fX1KdR7hSI
         9QvoWi9Go+yy6f4S5yTzv63T9/KEL/9uyd5JWprYp4DsvUyOA40BakRern5PnFDwYCuU
         ivLg==
X-Received: by 10.66.163.38 with SMTP id yf6mr9172878pab.46.1405227285166;
        Sat, 12 Jul 2014 21:54:45 -0700 (PDT)
Received: from lanh ([115.73.227.1])
        by mx.google.com with ESMTPSA id a5sm9104783pdo.1.2014.07.12.21.54.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jul 2014 21:54:44 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 13 Jul 2014 11:54:45 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1405227068-25506-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253421>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 setup.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/setup.c b/setup.c
index a17389f..79f79f2 100644
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
1.9.1.346.ga2b5940
