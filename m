From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 17/25] setup.c: detect $GIT_COMMON_DIR check_repository_format_gently()
Date: Tue, 18 Feb 2014 20:40:06 +0700
Message-ID: <1392730814-19656-18-git-send-email-pclouds@gmail.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 18 14:42:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFkwe-0000pO-50
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 14:42:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755742AbaBRNl6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Feb 2014 08:41:58 -0500
Received: from mail-pd0-f174.google.com ([209.85.192.174]:35786 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755735AbaBRNl5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 08:41:57 -0500
Received: by mail-pd0-f174.google.com with SMTP id z10so16088790pdj.5
        for <git@vger.kernel.org>; Tue, 18 Feb 2014 05:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=+nwhA0L7VxB2U7+3KenE/EZVaH1aoINMUqOOFpBjToM=;
        b=G3UZUO+X3aebhx74iPrBZZggesoMYpAMAvU1jlmkgiRhCUMOYrGW2nmROnQfuTsvQF
         XgfHro4A7Chd8xSuRlB91YORCw4BJrEpBUlblsyzXDXpmtSdX39Mz3UTFzJ5yMCp9OSV
         y1wMhvwUlUhW2lA2F7bpC8vfYYl25m1zY194xPJIoY63wptlhTzu+AjYFLKdn90FLiZk
         861UOh7KMtjoh95X6FtxVBC7mMiz58Su2Hxoa2JtbcmTKEnosv9nKCxz3fs6Tc7lnPRF
         L1nl/4HKHiaISG8WPURgJiVfEja+0Rdyp9wAPg6dcPt6Y1GhXhO1iyR8QmT4xojbg5tP
         2bTw==
X-Received: by 10.68.203.102 with SMTP id kp6mr33165957pbc.14.1392730916922;
        Tue, 18 Feb 2014 05:41:56 -0800 (PST)
Received: from lanh ([115.73.228.211])
        by mx.google.com with ESMTPSA id gj9sm6964960pbc.7.2014.02.18.05.41.53
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 18 Feb 2014 05:41:56 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 18 Feb 2014 20:42:08 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242315>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 setup.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/setup.c b/setup.c
index 282fdc9..e56ec11 100644
--- a/setup.c
+++ b/setup.c
@@ -285,6 +285,10 @@ static int check_repository_format_gently(const ch=
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
@@ -294,8 +298,6 @@ static int check_repository_format_gently(const cha=
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
1.8.5.2.240.g8478abd
