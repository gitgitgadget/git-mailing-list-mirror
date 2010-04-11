From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] Take it easy on unallowed access to non-existent repository
Date: Sun, 11 Apr 2010 13:01:22 +0200
Message-ID: <1270983682-12215-1-git-send-email-pclouds@gmail.com>
References: <20100409001322.GB23501@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 11 13:01:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0uur-0001Hg-Ii
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 13:01:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751832Ab0DKLBE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Apr 2010 07:01:04 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:62196 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801Ab0DKLBB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Apr 2010 07:01:01 -0400
Received: by fg-out-1718.google.com with SMTP id 19so826119fgg.1
        for <git@vger.kernel.org>; Sun, 11 Apr 2010 04:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=s6BumL8mfbHybxBar4TZZkBQbKAnuNSbgMDhPxmcabE=;
        b=RBwbsxXx3rARCwqQUvuqIdQ/wqWaT6edGNIZtvwpSi3m0vqYcWjzx9wxyQzApL1sh/
         0ADq1H1eq2KGIAJIQGggMx2YKmnVGetrZ/DI2UgO/9vjT1ueLNfHDBcB5jc93BDMHBIG
         KtE2bmB9iPidOvatLxJzbUkpzaJZo//xRxFGo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=jbHa3R2xEyzKb3hA1NdrUgbs1KEacVi2y3rwslmTFqoBOiCK7iHik3YaWs26zeRqoS
         pJefTL58w1uDeFhdWCtUHEECvbPzeORZj45rPSgRhPKuDS/r++CEd5XGEUIFe9nlzYk0
         u9zLcwphDD7KpBBSrw/zicjzxG9YLiDTcDyA0=
Received: by 10.223.15.133 with SMTP id k5mr1957330faa.39.1270983659364;
        Sun, 11 Apr 2010 04:00:59 -0700 (PDT)
Received: from dektop ([212.247.124.209])
        by mx.google.com with ESMTPS id k29sm6420934fkk.15.2010.04.11.04.00.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 11 Apr 2010 04:00:58 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Sun, 11 Apr 2010 13:01:23 +0200
X-Mailer: git-send-email 1.7.0.rc1.541.g2da82.dirty
In-Reply-To: <20100409001322.GB23501@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144638>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 2010/4/9 Jeff King <peff@peff.net>:
 > Yeah, that sounds reasonable, especially if merging this to 'next' w=
ould
 > make git unusable. We want to shake out bugs, not punish people runn=
ing
 > next. :) But I haven't even really looked at the topic in detail yet=
=2E

 This patch could be squashed into 551a5786 (Guard unallowed access to =
repository..)
 Still don't know what to do with "git ls-remote". I'm not familiar wit=
h it.

 config.c      |    2 +-
 environment.c |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/config.c b/config.c
index 9981b09..63702bf 100644
--- a/config.c
+++ b/config.c
@@ -738,7 +738,7 @@ int git_config(config_fn_t fn, void *data)
 	int ret;
=20
 	if (startup_info && !startup_info->have_run_setup_gitdir)
-		die("internal error: access to .git/config without repo setup");
+		warning("Broken repository setup: early access to $GIT_DIR/config");
 	if (!startup_info || startup_info->have_repository)
 		repo_config =3D git_pathdup("config");
 	ret =3D git_config_early(fn, data, repo_config);
diff --git a/environment.c b/environment.c
index 28624ad..dbaed04 100644
--- a/environment.c
+++ b/environment.c
@@ -99,7 +99,7 @@ void unset_git_env(void)
 static void setup_git_env(void)
 {
 	if (startup_info && startup_info->have_run_setup_gitdir)
-		die("internal error: setup_git_env can't be called twice");
+		warning("Broken repository setup: setup_git_env() called twice");
 	git_dir =3D getenv(GIT_DIR_ENVIRONMENT);
 	if (!git_dir) {
 		/*
@@ -107,7 +107,7 @@ static void setup_git_env(void)
 		 * or enter_repo, not by this function
 		 */
 		if (startup_info)
-			die("internal error: $GIT_DIR is empty");
+			warning("Broken respository setup: git_dir is empty");
 		git_dir =3D read_gitfile_gently(DEFAULT_GIT_DIR_ENVIRONMENT);
 	}
 	if (!git_dir)
--=20
1.7.0.rc1.541.g2da82.dirty
