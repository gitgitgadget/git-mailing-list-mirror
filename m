From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 18/34] setup.c: detect $GIT_COMMON_DIR check_repository_format_gently()
Date: Sun, 30 Nov 2014 15:24:43 +0700
Message-ID: <1417335899-27307-19-git-send-email-pclouds@gmail.com>
References: <1417335899-27307-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 30 09:28:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xuzry-0008LO-KN
	for gcvg-git-2@plane.gmane.org; Sun, 30 Nov 2014 09:28:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752099AbaK3I2e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Nov 2014 03:28:34 -0500
Received: from mail-pd0-f172.google.com ([209.85.192.172]:62899 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751910AbaK3I2d (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2014 03:28:33 -0500
Received: by mail-pd0-f172.google.com with SMTP id y13so8939336pdi.31
        for <git@vger.kernel.org>; Sun, 30 Nov 2014 00:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=D5e76VFVwnxbFc5yqkCYOnZ+O2h0pKLqHaihKMSVDEM=;
        b=d1E78tzetEBQJmRjL/I+fDiscqE/gbh/NruyJ6BHpljBAvcEgYpaWRkgP8Vfap0wx0
         2X/z86ThTe6uBCGHDLcKrZF+dNUSsErDNiE+XLrqDd0Ap/N4FmfunWb0y24PKlx/TPxF
         r/EMPqH0MDie32M9MiA5Qfzz6IsSNSYN2WiewqUBOne/DiksxONgMKzNuEpVpaEryT/R
         cbyN/bRbsybVjxBnrbzR0tITJfPqYm601A/gMfr9lOp1+DtYgYRKFpg6B1XoH5HeA0GS
         0TCFjJ1EfMDQIeqNmSPdLL7MtiWcH7DCC9RzDLDDCIyxnIeLnRKaXMCvp9/y6qRbQFQ2
         e/gg==
X-Received: by 10.70.126.161 with SMTP id mz1mr12398837pdb.14.1417336113168;
        Sun, 30 Nov 2014 00:28:33 -0800 (PST)
Received: from lanh ([115.73.247.22])
        by mx.google.com with ESMTPSA id a13sm11635658pdm.44.2014.11.30.00.28.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Nov 2014 00:28:32 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 30 Nov 2014 15:28:31 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1417335899-27307-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260405>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
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
