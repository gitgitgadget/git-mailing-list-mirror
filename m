From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 18/32] setup.c: detect $GIT_COMMON_DIR check_repository_format_gently()
Date: Sat, 30 Aug 2014 15:33:48 +0700
Message-ID: <1409387642-24492-19-git-send-email-pclouds@gmail.com>
References: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 30 10:35:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNe8N-0002Z5-Rj
	for gcvg-git-2@plane.gmane.org; Sat, 30 Aug 2014 10:35:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbaH3Ifd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Aug 2014 04:35:33 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:56556 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751327AbaH3Ifc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2014 04:35:32 -0400
Received: by mail-pd0-f182.google.com with SMTP id fp1so2048147pdb.41
        for <git@vger.kernel.org>; Sat, 30 Aug 2014 01:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Nh10Z32snD5jF/DTDqSsHnddABY5MKxW8V/8wXurlOI=;
        b=Gvbt5KCUpxoDNerIGg+ej2kr92CFL1V2rEMukR65ElJxtPdJzrTDVeEq9tFGj5lXmT
         h//zcYajuIztUT1KHTG3Q1pbYZ+EbSGS0+f7u4TrB71D7N0Cpn4v7JHsK0NGKcsg8hiq
         dh2n1Ze+NeFQGFvz4aQs9+7OhnpLDr5sxKKjs6v91beP1dHA9gk2ZXOREUR0Q0eixMEs
         lsGTn8K1OjkSa7beSXObM/zCFg9Jhak02Ja9xpwsHc/u+CAmd46SSC5xkmguloZRjNQP
         cafjiJHaQZNl/Mq0X9rJp854AHsBXdrmByh0F6bj21HKrrKVQZp59nnP2LbuDXnJXeqO
         PtpQ==
X-Received: by 10.70.95.100 with SMTP id dj4mr22629181pdb.94.1409387731459;
        Sat, 30 Aug 2014 01:35:31 -0700 (PDT)
Received: from lanh ([115.73.195.142])
        by mx.google.com with ESMTPSA id fk5sm2088537pbc.53.2014.08.30.01.35.28
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Aug 2014 01:35:30 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 30 Aug 2014 15:35:40 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256228>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
2.1.0.rc0.78.gc0d8480
