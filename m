From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v5 18/28] setup.c: detect $GIT_COMMON_DIR check_repository_format_gently()
Date: Sat,  8 Mar 2014 09:48:10 +0700
Message-ID: <1394246900-31535-19-git-send-email-pclouds@gmail.com>
References: <1393675983-3232-1-git-send-email-pclouds@gmail.com>
 <1394246900-31535-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 08 03:49:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WM7Ke-0005j2-7x
	for gcvg-git-2@plane.gmane.org; Sat, 08 Mar 2014 03:49:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753503AbaCHCto convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Mar 2014 21:49:44 -0500
Received: from mail-pb0-f51.google.com ([209.85.160.51]:59509 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752305AbaCHCtn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2014 21:49:43 -0500
Received: by mail-pb0-f51.google.com with SMTP id uo5so4931972pbc.24
        for <git@vger.kernel.org>; Fri, 07 Mar 2014 18:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=28pKm7tSsxQHX6gW6qvpt/KGPoWVqfv6Yynxjkxo99w=;
        b=SSDmOkBDPi1ou6i92iGDWidr8mgYouCM9NtOXysWa1eDej8tfftQmpjcnFCXOiKdig
         KZvl+JlKRtDsgdSoYst1stb27IRgnQ53yMkfq1NYRXt5062VtNBepq5IyYgA8AGP2bre
         1p5RoSWIGvfuF9JtNMGQjyaughkE49k1L0y8bcvHzJsTpeurhGRKuTVwiCU3W5OdGFI+
         6RgVkUZeai1zfalYDlL6vFWRq2P26LkFjiT0tc/SHH8JCdH3Qa/XFrPkbZ4IXMDTHUKW
         hazfIejekBiD2tWxOXpEdmL26+hQudhOd1BxjpNsjDEObXb/uqShVD3CzgwrwcVu5s+B
         wQUw==
X-Received: by 10.68.197.8 with SMTP id iq8mr25918661pbc.124.1394246983287;
        Fri, 07 Mar 2014 18:49:43 -0800 (PST)
Received: from lanh ([115.73.205.153])
        by mx.google.com with ESMTPSA id ns7sm42323085pbc.32.2014.03.07.18.49.40
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 07 Mar 2014 18:49:42 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 08 Mar 2014 09:50:16 +0700
X-Mailer: git-send-email 1.9.0.40.gaa8c3ea
In-Reply-To: <1394246900-31535-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243659>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 setup.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/setup.c b/setup.c
index 5085ab1..42849f3 100644
--- a/setup.c
+++ b/setup.c
@@ -292,6 +292,10 @@ static int check_repository_format_gently(const ch=
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
@@ -301,8 +305,6 @@ static int check_repository_format_gently(const cha=
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
1.9.0.40.gaa8c3ea
