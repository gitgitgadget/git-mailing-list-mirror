From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] git.c: fix help.autocorrect after 57ea712 breaks it
Date: Tue, 26 Jan 2016 20:26:41 +0700
Message-ID: <1453814801-1925-1-git-send-email-pclouds@gmail.com>
References: <56A72235.9080602@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@drmicha.warpmail.net,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 26 14:29:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aO3gY-0006Q0-21
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 14:29:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965828AbcAZN3Y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Jan 2016 08:29:24 -0500
Received: from mail-pf0-f171.google.com ([209.85.192.171]:36643 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965168AbcAZN3U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2016 08:29:20 -0500
Received: by mail-pf0-f171.google.com with SMTP id n128so99060378pfn.3
        for <git@vger.kernel.org>; Tue, 26 Jan 2016 05:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=SIUk5P8FHg+oOutOeXD2KKzSI/34Uv9aeKSS9ifzxLE=;
        b=CfREpbJyLeIMAvKTgMc6ZH/bKRgACRz3HD189KxLej6ao7Pi5WM1XVitpnsgnUaG25
         vaoaALOqUXaHMcoKMXdGCrvlipCZkMOa9rwRs/naSe2aD1UJJn9dDLR47AS4wa3fVn/n
         1QRIF/M2nMiri/VfzeGVdJHUJ8D27mVpe2yP7y3i4BGOLQFqrMwdPCHx1tFAeK2k38Bc
         LG87gVrHDhY35uVfvUD+qR/qk3ayTSaxKCRXmCaVnqjNhHqdvLv01l/kR5HnuFPX/QBx
         cxdCC7WRhwGNl0Nkd8ai3IhdkC/o996fXJtMoZM7XFMRB94ygnlV9TX8gAFOxv71O7QO
         ACag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=SIUk5P8FHg+oOutOeXD2KKzSI/34Uv9aeKSS9ifzxLE=;
        b=RHTIhXQv/v2cYWNG8IWuUV5aMwL6A25IVrLi3oT8CJQcgP1BvhRGgaxbfgLQzHvImT
         BMJNjM0YM5MAoVCzpHjG47Jx+B1unYzMdAyc31ymSaPl9acxwZ7Q2HJFbBYAIBwxYhwD
         uagOchqQ1pLXu+stk2HfePtXLUHli62V0cfm1dhAgCdZEyhg/8HwO3zwqjxxDGfH/zHR
         GIjbvMRUtPrzNvdUZ6K27Uv9MBvQKo7NStssIrPdjoLEmKp2URSU+FiGgFbk8aV9DC26
         UiqpKVROBHen898eK0BG/n4Y4MfQqWl+yRfoQ7gROXROl5rYi3CSK2WRuhrLO1Cd7El4
         oz4w==
X-Gm-Message-State: AG10YOTZCuH6JkvEBPWUF+oNpkWz2G2GdFC20dOghZjdrmSv7/eXxl63DWqUwzj0rc6eJg==
X-Received: by 10.98.32.76 with SMTP id g73mr33764648pfg.48.1453814959455;
        Tue, 26 Jan 2016 05:29:19 -0800 (PST)
Received: from lanh ([115.76.235.75])
        by smtp.gmail.com with ESMTPSA id p87sm1965811pfi.94.2016.01.26.05.29.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jan 2016 05:29:17 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 26 Jan 2016 20:29:21 +0700
X-Mailer: git-send-email 2.7.0.288.g1d8ad15
In-Reply-To: <56A72235.9080602@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284813>

Commit 57ea712 (git.c: make sure we do not leak GIT_* to alias scripts =
-
2015-12-20) does not realize that handle_alias() can be called multiple
times because of the forever loop in run_argv(). The commit breaks alia=
s
chains.

Suppose you have an alias "abc" that resolves to another alias "def",
which finally resolve to "git status". handle_alias() is called twice.
save_env() and restore_env() are also called twice. But because of the
check save_env_before_alias in save_env(), we save once while trying to
restore twice. Consequences are left for the reader's imagination.

=46ortunately, you cannot make an alias of another alias. At least not
yet. Unfortunately it can still happen with help.autocorrect, where you=
r
alias typo is treated as the first "alias", and it can be resolved to
the second alias. Then boom.

Make sure we call save_env() and restore_env() in pairs. While at there=
,
set orig_cwd to NULL after freeing it for hygiene.

Reported-by: Michael J Gruber <git@drmicha.warpmail.net>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 git.c                  | 11 ++++++++---
 t/t1300-repo-config.sh |  8 ++++++++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/git.c b/git.c
index da278c3..cd733f7 100644
--- a/git.c
+++ b/git.c
@@ -25,14 +25,15 @@ static const char *env_names[] =3D {
 	GIT_PREFIX_ENVIRONMENT
 };
 static char *orig_env[4];
-static int saved_env_before_alias;
+static int saved_env_before_alias, saved;
=20
 static void save_env_before_alias(void)
 {
 	int i;
-	if (saved_env_before_alias)
-		return;
+	if (saved)
+		die("BUG: uneven pair of save_env/restore_env calls");
 	saved_env_before_alias =3D 1;
+	saved =3D 1;
 	orig_cwd =3D xgetcwd();
 	for (i =3D 0; i < ARRAY_SIZE(env_names); i++) {
 		orig_env[i] =3D getenv(env_names[i]);
@@ -44,9 +45,13 @@ static void save_env_before_alias(void)
 static void restore_env(int external_alias)
 {
 	int i;
+	if (saved !=3D 1)
+		die("BUG: uneven pair of save_env/restore_env calls");
 	if (!external_alias && orig_cwd && chdir(orig_cwd))
 		die_errno("could not move to %s", orig_cwd);
 	free(orig_cwd);
+	orig_cwd =3D NULL;
+	saved =3D 0;
 	for (i =3D 0; i < ARRAY_SIZE(env_names); i++) {
 		if (external_alias &&
 		    !strcmp(env_names[i], GIT_PREFIX_ENVIRONMENT))
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 52678e7..3f95285 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -1201,4 +1201,12 @@ test_expect_success POSIXPERM,PERL 'preserves ex=
isting permissions' '
 	  "die q(badrename) if ((stat(q(.git/config)))[2] & 07777) !=3D 0600"
 '
=20
+test_expect_success 'autocorrect and save_env/restore_env' '
+	git config alias.ss status &&
+	git config help.autocorrect 1 &&
+	git sss --porcelain | grep actual >actual &&
+	echo "?? actual" >expected &&
+	test_cmp expected actual
+'
+
 test_done
--=20
2.7.0.288.g1d8ad15
