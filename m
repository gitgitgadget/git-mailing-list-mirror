From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] Revert "setup: set env $GIT_WORK_TREE when work tree is set, like $GIT_DIR"
Date: Mon, 21 Dec 2015 17:22:52 +0700
Message-ID: <1450693372-6863-1-git-send-email-pclouds@gmail.com>
References: <xmqqh9k06all.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 21 11:23:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aAxd6-0005i3-IT
	for gcvg-git-2@plane.gmane.org; Mon, 21 Dec 2015 11:23:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751376AbbLUKXg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Dec 2015 05:23:36 -0500
Received: from mail-pf0-f172.google.com ([209.85.192.172]:35357 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751382AbbLUKW6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Dec 2015 05:22:58 -0500
Received: by mail-pf0-f172.google.com with SMTP id 78so13818347pfw.2
        for <git@vger.kernel.org>; Mon, 21 Dec 2015 02:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=zgFFYEWJfrlj3v+zWoQRnB+Er4wkmhhtM3Sp9aAWZh8=;
        b=IvL4PvsNP6GNpPYN2ABW6B74nhlsLu+/I2xqpt2mbP0JZYQJwpjDJSaL34zYoBHlvb
         Xgto1E/Ddykj4TkCeekf7KjX3CKsKkEcrDWN9++82hWCELRpcGsdhIoMb7FCo3luplct
         vDXOVu131Tm4fA7FGhbnDB7XrzlWbAWyz7jxdDkX3dKLS+oNUYrsWogZo4n09FFy4Gun
         C7cAi74p95smOlO3vtKi0Dz4UivCkzIgbTJtD4bIVkmiZ4onF3QUbBwMGMF8q6XNc7Vl
         3CY4yZ2MIayH9ZARuHpuo/OoeuT4sAJtZ8umdF7HOWOY5WdIGK1FpF60O1NoL1qYpmZ0
         R0uw==
X-Received: by 10.98.66.209 with SMTP id h78mr25546370pfd.29.1450693378138;
        Mon, 21 Dec 2015 02:22:58 -0800 (PST)
Received: from lanh ([171.233.236.127])
        by smtp.gmail.com with ESMTPSA id t85sm33691666pfa.34.2015.12.21.02.22.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Dec 2015 02:22:56 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 21 Dec 2015 17:22:57 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <xmqqh9k06all.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282789>

This commit has caused three regression reports so far. All of them are
about spawning git subprocesses, where the new presence of GIT_WORK_TRE=
E
either changes command behaviour (git-init or git-clone), or how
repo/worktree is detected (from aliases), with or without $GIT_DIR.
The original bug will be re-fixed another way.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 On Thu, Dec 3, 2015 at 12:09 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
 > OK, when/if you decide that our first step should be a revert of
 > d95138e please send in a patch to do so with a brief write-up of a
 > follow-up plan.

 Three reports to me are enough. And I obviously could not push the
 fix out fast enough. So if you want to revert it, here's the patch on
 maint.

 environment.c      | 2 --
 t/t0002-gitfile.sh | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/environment.c b/environment.c
index 23a38e4..f1a2a49 100644
--- a/environment.c
+++ b/environment.c
@@ -238,8 +238,6 @@ void set_git_work_tree(const char *new_work_tree)
 	}
 	git_work_tree_initialized =3D 1;
 	work_tree =3D xstrdup(real_path(new_work_tree));
-	if (setenv(GIT_WORK_TREE_ENVIRONMENT, work_tree, 1))
-		die("could not set GIT_WORK_TREE to '%s'", work_tree);
 }
=20
 const char *get_git_work_tree(void)
diff --git a/t/t0002-gitfile.sh b/t/t0002-gitfile.sh
index 9670e8c..3afe012 100755
--- a/t/t0002-gitfile.sh
+++ b/t/t0002-gitfile.sh
@@ -99,7 +99,7 @@ test_expect_success 'check rev-list' '
 	test "$SHA" =3D "$(git rev-list HEAD)"
 '
=20
-test_expect_success 'setup_git_dir twice in subdir' '
+test_expect_failure 'setup_git_dir twice in subdir' '
 	git init sgd &&
 	(
 		cd sgd &&
--=20
2.3.0.rc1.137.g477eb31
