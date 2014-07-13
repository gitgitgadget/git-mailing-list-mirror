From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v7 31/31] checkout: don't require a work tree when checking out into a new one
Date: Sun, 13 Jul 2014 11:51:08 +0700
Message-ID: <1405227068-25506-32-git-send-email-pclouds@gmail.com>
References: <1404891197-18067-1-git-send-email-pclouds@gmail.com>
 <1405227068-25506-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Max Kirillov <max@max630.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 13 06:56:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6BpU-00026c-Pq
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jul 2014 06:56:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753181AbaGME4B convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jul 2014 00:56:01 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:49234 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753095AbaGMEz7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2014 00:55:59 -0400
Received: by mail-pd0-f177.google.com with SMTP id p10so132817pdj.36
        for <git@vger.kernel.org>; Sat, 12 Jul 2014 21:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=0svi8TylaQrweIgVSCChJIrgusPa8R3uxyUianM10H4=;
        b=YeBXllcNtTY/N1zpubl1/GzCNGyX9ZjO8DCgMSlBMYs1pZVPx9dZ/d3+q8A4PXVfZ1
         N84MTvogBV/MnImjNRl0zicCr7n+Jv3P+UjlciqVxGL5Ogvxe+/Q+eUZ4r292S8QKhet
         LPetnZlwTDB1dD60MUmnAe68h0fVTKwIg3d/AnOPi1UicwStx6PWHrwbVAk/sgFSrbLw
         Dm+52vuHJ3f7XV+MViItF6RuqvfIpggMOQuFcq9w5EdZmiie4GpXl1DotsDLJnpZ23jP
         Kzp/B7el5Q4rLYp1U1a/m4YLgQEiO4ru1xcK5+Cd3qEcOIu+yG54fJ0hCnfcRSSYM0KC
         JOOg==
X-Received: by 10.69.10.164 with SMTP id eb4mr9015725pbd.35.1405227358751;
        Sat, 12 Jul 2014 21:55:58 -0700 (PDT)
Received: from lanh ([115.73.227.1])
        by mx.google.com with ESMTPSA id oy12sm6760916pbb.27.2014.07.12.21.55.55
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jul 2014 21:55:58 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 13 Jul 2014 11:55:58 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1405227068-25506-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253434>

=46rom: Dennis Kaarsemaker <dennis@kaarsemaker.net>

=46or normal use cases, it does not make sense for 'checkout' to work o=
n
a bare repository, without a worktree. But "checkout --to" is an
exception because it _creates_ a new worktree. Allow this option to
run on bare repositories.

People who check out from a bare repository should remember that
core.logallrefupdates is off by default and it should be turned back
on. `--to` cannot do this automatically behind the user's back because
some user may deliberately want no reflog.

=46or people interested in repository setup/discovery code,
is_bare_repository_cfg (aka "core.bare") is unchanged by this patch,
which means 'true' by default for bare repos. Fortunately when we get
the repo through a linked checkout, is_bare_repository_cfg is never
used. So all is still good.

[nd: commit message]

Signed-off-by: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/checkout.c     |  3 +++
 git.c                  |  2 +-
 t/t2025-checkout-to.sh | 15 +++++++++++++++
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 5b93f49..c83f476 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1357,6 +1357,9 @@ int cmd_checkout(int argc, const char **argv, con=
st char *prefix)
 	if (opts.new_worktree_mode)
 		opts.new_worktree =3D NULL;
=20
+	if (!opts.new_worktree)
+		setup_work_tree();
+
 	if (conflict_style) {
 		opts.merge =3D 1; /* implied */
 		git_xmerge_config("merge.conflictstyle", conflict_style, NULL);
diff --git a/git.c b/git.c
index 5b6c761..7426651 100644
--- a/git.c
+++ b/git.c
@@ -383,7 +383,7 @@ static struct cmd_struct commands[] =3D {
 	{ "check-ignore", cmd_check_ignore, RUN_SETUP | NEED_WORK_TREE },
 	{ "check-mailmap", cmd_check_mailmap, RUN_SETUP },
 	{ "check-ref-format", cmd_check_ref_format },
-	{ "checkout", cmd_checkout, RUN_SETUP | NEED_WORK_TREE },
+	{ "checkout", cmd_checkout, RUN_SETUP },
 	{ "checkout-index", cmd_checkout_index,
 		RUN_SETUP | NEED_WORK_TREE},
 	{ "cherry", cmd_cherry, RUN_SETUP },
diff --git a/t/t2025-checkout-to.sh b/t/t2025-checkout-to.sh
index 20e3dc7..b0d97a0 100755
--- a/t/t2025-checkout-to.sh
+++ b/t/t2025-checkout-to.sh
@@ -62,4 +62,19 @@ test_expect_success 'not detach on re-checking out c=
urrent branch' '
 	)
 '
=20
+test_expect_success 'checkout --to from a bare repo' '
+	(
+		git clone --bare . bare &&
+		cd bare &&
+		git checkout --to ../there2 master
+	)
+'
+
+test_expect_success 'checkout from a bare repo without --to' '
+	(
+		cd bare &&
+		test_must_fail git checkout master
+	)
+'
+
 test_done
--=20
1.9.1.346.ga2b5940
