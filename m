From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v6 20/32] setup.c: detect $GIT_COMMON_DIR check_repository_format_gently()
Date: Wed,  9 Jul 2014 14:33:05 +0700
Message-ID: <1404891197-18067-21-git-send-email-pclouds@gmail.com>
References: <1404891197-18067-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 09 09:35:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4mPT-00041K-C5
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 09:35:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754939AbaGIHfR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Jul 2014 03:35:17 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:41366 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754802AbaGIHfP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 03:35:15 -0400
Received: by mail-pa0-f53.google.com with SMTP id ey11so8631240pad.26
        for <git@vger.kernel.org>; Wed, 09 Jul 2014 00:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=CSgffAFZAjkMY2PTTwYgwlor0NTS/344KGlQeK+d8Gc=;
        b=ClRh060Jms4EDk27By+FdoLPNG+weMQSQ5ZSItVB98fjV7oVjSsj9i21NZ7fK7dxgi
         lzDwuiUc+ZrHVDMtGnWSRglb9sfQC6z9weEU5la7GWefrgDoXrRHFbWzCzmxlHcQHNK1
         R3nyBSZszZo8BcA+7cYU5UkcgoqVmKReiV+/RxlnDPFJJcBe7xJ9qzApHbwTNr+6yk23
         lsMFycI1wGRHaarXTEcopz9enpFPRxMiMdshyLhp1JlIsSQ1bLfmjTyBAq3uCf/aRwbc
         RREaugU8NZvpjC6qymGV8atr6g6Pg/4FOQk9XtZeId6LfFGhXhPrpkMiLIkBHKHVKeNM
         k/Vw==
X-Received: by 10.68.173.1 with SMTP id bg1mr39802880pbc.13.1404891315283;
        Wed, 09 Jul 2014 00:35:15 -0700 (PDT)
Received: from lanh ([115.73.209.165])
        by mx.google.com with ESMTPSA id rc3sm57974435pbc.5.2014.07.09.00.35.12
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jul 2014 00:35:14 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 09 Jul 2014 14:35:12 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1404891197-18067-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253095>

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
