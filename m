From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 17/27] setup.c: detect $GIT_COMMON_DIR check_repository_format_gently()
Date: Sat,  1 Mar 2014 19:12:53 +0700
Message-ID: <1393675983-3232-18-git-send-email-pclouds@gmail.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
 <1393675983-3232-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 01 13:22:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJiwB-0002Mx-Hw
	for gcvg-git-2@plane.gmane.org; Sat, 01 Mar 2014 13:22:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752863AbaCAMWf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Mar 2014 07:22:35 -0500
Received: from mail-pd0-f173.google.com ([209.85.192.173]:38172 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752429AbaCAMWe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2014 07:22:34 -0500
Received: by mail-pd0-f173.google.com with SMTP id z10so1860187pdj.18
        for <git@vger.kernel.org>; Sat, 01 Mar 2014 04:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=28pKm7tSsxQHX6gW6qvpt/KGPoWVqfv6Yynxjkxo99w=;
        b=rE4b/XNdym0IhHKrkl7N9GnIXnxtdpyLEvcI8Bk/1MHpRQ5mMiUfdACIjhvXNGItc+
         O48bwwk/fPzMGnKH+AecQZ7JiPq4u9ZP5kOhf7ZQacgJD/dhDnfMGJgavoLuOachK7Pz
         OjloUKAr2ch6qSNVBbivnhfkVNP04Najz/Q7hb+TtWtGdfaLxyehY+oOndUHua8+oz8Z
         JFG+FQsFrLPN/kAPWfspQZF1GhviAG/8QS+eev0lVsaNyfhg0Vu3kcA7t343buSc15R7
         y1mC09lInzrHy2u7T8LSUh/jni1/djZMrA3kPwnKKSLGa3NkhpldwYwqx7i/q0D10Lhg
         LB4Q==
X-Received: by 10.68.242.33 with SMTP id wn1mr89067pbc.154.1393676554042;
        Sat, 01 Mar 2014 04:22:34 -0800 (PST)
Received: from lanh ([115.73.238.45])
        by mx.google.com with ESMTPSA id qf7sm37148797pac.14.2014.03.01.04.22.31
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 01 Mar 2014 04:22:33 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 01 Mar 2014 19:22:59 +0700
X-Mailer: git-send-email 1.9.0.40.gaa8c3ea
In-Reply-To: <1393675983-3232-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243082>

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
