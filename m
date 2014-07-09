From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v6 19/32] setup.c: convert check_repository_format_gently to use strbuf
Date: Wed,  9 Jul 2014 14:33:04 +0700
Message-ID: <1404891197-18067-20-git-send-email-pclouds@gmail.com>
References: <1404891197-18067-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 09 09:35:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4mPO-0003zR-TT
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 09:35:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753748AbaGIHfN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Jul 2014 03:35:13 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:64017 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754802AbaGIHfK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 03:35:10 -0400
Received: by mail-pa0-f49.google.com with SMTP id lj1so8685159pab.22
        for <git@vger.kernel.org>; Wed, 09 Jul 2014 00:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=vwkmXzt7/pH6ytHE7n3iKvzR8neAex12ACTCTernrr4=;
        b=EjfZhD1bZFJHQXWNZNO9H1Dh7Mt+7/FoHe7tCL7XGToXNeKJu7AnbTM/vfiCFvRAzY
         E11IEc96ZVCoG30DwT0VOe2t+NGXBLjAZv8a+vYM3b2YY9CzcZBCwAuXi/i3lR4WzGHh
         6HRVZ6mWXsTjMNjLLVA2mAUfE5FfzZYHw6o2BPWO/VRIuv/ZbHJycVBxvwnxzJG37tMm
         ueoIFt+br3h8egRzpzTd/Qc0KmmvHzG/hk5G34x5PDruoQTH0BBRcBiIY2SjNWM/NBse
         aepDjrUMr4raG1iPSsORcTZBczlg+ribedXtvepCfziUIS/Gi2vPELhKH5kWs5NETQ+c
         gOKg==
X-Received: by 10.70.0.197 with SMTP id 5mr9723105pdg.47.1404891309918;
        Wed, 09 Jul 2014 00:35:09 -0700 (PDT)
Received: from lanh ([115.73.209.165])
        by mx.google.com with ESMTPSA id bg12sm172042828pac.1.2014.07.09.00.35.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jul 2014 00:35:09 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 09 Jul 2014 14:35:06 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1404891197-18067-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253094>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 setup.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/setup.c b/setup.c
index 176d505..a17389f 100644
--- a/setup.c
+++ b/setup.c
@@ -342,7 +342,9 @@ void setup_work_tree(void)
=20
 static int check_repository_format_gently(const char *gitdir, int *non=
git_ok)
 {
-	char repo_config[PATH_MAX+1];
+	struct strbuf sb =3D STRBUF_INIT;
+	const char *repo_config;
+	int ret =3D 0;
=20
 	/*
 	 * git_config() can't be used here because it calls git_pathdup()
@@ -353,7 +355,8 @@ static int check_repository_format_gently(const cha=
r *gitdir, int *nongit_ok)
 	 * Use a gentler version of git_config() to check if this repo
 	 * is a good one.
 	 */
-	snprintf(repo_config, PATH_MAX, "%s/config", gitdir);
+	strbuf_addf(&sb, "%s/config", gitdir);
+	repo_config =3D sb.buf;
 	git_config_early(check_repository_format_version, NULL, repo_config);
 	if (GIT_REPO_VERSION < repository_format_version) {
 		if (!nongit_ok)
@@ -363,9 +366,10 @@ static int check_repository_format_gently(const ch=
ar *gitdir, int *nongit_ok)
 			GIT_REPO_VERSION, repository_format_version);
 		warning("Please upgrade Git");
 		*nongit_ok =3D -1;
-		return -1;
+		ret =3D -1;
 	}
-	return 0;
+	strbuf_release(&sb);
+	return ret;
 }
=20
 /*
--=20
1.9.1.346.ga2b5940
