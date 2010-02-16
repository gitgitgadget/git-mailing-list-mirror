From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [WIP PATCH 06/26] Tweak init/clone to work properly with GIT_HARDENED_SETUP=1
Date: Tue, 16 Feb 2010 23:04:57 +0700
Message-ID: <1266336317-607-7-git-send-email-pclouds@gmail.com>
References: <1266336317-607-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 17:09:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhPz1-0007Hq-7e
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 17:09:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757008Ab0BPQIl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Feb 2010 11:08:41 -0500
Received: from mail-yx0-f200.google.com ([209.85.210.200]:56134 "EHLO
	mail-yx0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756943Ab0BPQIj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 11:08:39 -0500
Received: by mail-yx0-f200.google.com with SMTP id 38so4317189yxe.4
        for <git@vger.kernel.org>; Tue, 16 Feb 2010 08:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=LWmE7KuGijA4Pog6TZGMhOd3rmg9HmNmE2l8xWqzsPk=;
        b=FgRvv8JPFysR5KG6GThAL9kSA81jBX6YprxsUjT5KIjwh4s/4flPmOPbLsqZea/7Ov
         jingiOtrvuIv5bOJki+RV2AbKNY5Vwm6/lTndthulx6dXLXbtsYUO53Q4ZSdqtTvBuMU
         O+RQdPxyl/Ws5j17a7S++uZuQiv6LQ+88DLh4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=opV/Zz9tdqLtJ29Yc6rDSHcxF+LH0DdglBiMiIDXi2mABIj6Vpuj+gQY47n6WUjGu7
         B9VBrnsWUbk2KzGPVHjUCqsn3He4SEhsZM8uwRl+AMqu+A+Mok6PC5YoNnGT4wjGGchV
         MoeBxNdiPBJSo6I1L3EkVVoLlbfiBFhT9dr9w=
Received: by 10.150.5.17 with SMTP id 17mr7846373ybe.88.1266336519281;
        Tue, 16 Feb 2010 08:08:39 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.207.162])
        by mx.google.com with ESMTPS id 6sm2834078ywc.8.2010.02.16.08.08.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 16 Feb 2010 08:08:38 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 16 Feb 2010 23:05:56 +0700
X-Mailer: git-send-email 1.7.0.195.g637a2
In-Reply-To: <1266336317-607-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140105>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin-init-db.c             |    4 ++++
 t/t0000-basic.sh              |    2 ++
 t/t0001-init.sh               |    2 ++
 t/t0003-attributes.sh         |    2 ++
 t/t5600-clone-fail-cleanup.sh |    2 ++
 t/t5601-clone.sh              |    2 ++
 t/t5602-clone-remote-exec.sh  |    2 ++
 t/t5700-clone-reference.sh    |    2 ++
 t/t5701-clone-local.sh        |    2 ++
 t/t5702-clone-options.sh      |    2 ++
 t/t5704-bundle.sh             |    2 ++
 t/t5705-clone-2gb.sh          |    2 ++
 t/t5706-clone-branch.sh       |    2 ++
 13 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/builtin-init-db.c b/builtin-init-db.c
index dd84cae..22b2b07 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -195,6 +195,7 @@ static int create_default_files(const char *templat=
e_path)
 	 * from it after installing.
 	 */
 	copy_templates(template_path);
+	startup_info->have_repository =3D 1;
=20
 	git_config(git_default_config, NULL);
 	is_bare_repository_cfg =3D init_is_bare_repository;
@@ -286,6 +287,9 @@ int init_db(const char *template_dir, unsigned int =
flags)
 	char *path;
 	int len, reinit;
=20
+	/* init_db's caller mush have called set_git_dir() */
+	startup_info->have_set_gitdir =3D 1;
+
 	safe_create_dir(get_git_dir(), 0);
=20
 	init_is_bare_repository =3D is_bare_repository();
diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index f4ca4fc..0a4be17 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -28,6 +28,8 @@ then
 	exit 1
 fi
=20
+export GIT_HARDENED_SETUP=3D1
+
 . ./test-lib.sh
=20
 ################################################################
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 5386504..0dd6ffa 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -4,6 +4,8 @@ test_description=3D'git init'
=20
 . ./test-lib.sh
=20
+export GIT_HARDENED_SETUP=3D1
+
 check_config () {
 	if test -d "$1" && test -f "$1/config" && test -d "$1/refs"
 	then
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index 1c77192..2ebb345 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -4,6 +4,8 @@ test_description=3Dgitattributes
=20
 . ./test-lib.sh
=20
+export GIT_HARDENED_SETUP=3D1
+
 attr_check () {
=20
 	path=3D"$1"
diff --git a/t/t5600-clone-fail-cleanup.sh b/t/t5600-clone-fail-cleanup=
=2Esh
index ee06d28..424e6ad 100755
--- a/t/t5600-clone-fail-cleanup.sh
+++ b/t/t5600-clone-fail-cleanup.sh
@@ -11,6 +11,8 @@ remove the directory before attempting a clone again.=
'
=20
 . ./test-lib.sh
=20
+export GIT_HARDENED_SETUP=3D1
+
 test_expect_success \
     'clone of non-existent source should fail' \
     'test_must_fail git clone foo bar'
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 2147567..a598f75 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -4,6 +4,8 @@ test_description=3Dclone
=20
 . ./test-lib.sh
=20
+export GIT_HARDENED_SETUP=3D1
+
 test_expect_success setup '
=20
 	rm -fr .git &&
diff --git a/t/t5602-clone-remote-exec.sh b/t/t5602-clone-remote-exec.s=
h
index deffdae..a94c528 100755
--- a/t/t5602-clone-remote-exec.sh
+++ b/t/t5602-clone-remote-exec.sh
@@ -4,6 +4,8 @@ test_description=3Dclone
=20
 . ./test-lib.sh
=20
+export GIT_HARDENED_SETUP=3D1
+
 test_expect_success setup '
 	echo "#!/bin/sh" > not_ssh
 	echo "echo \"\$*\" > not_ssh_output" >> not_ssh
diff --git a/t/t5700-clone-reference.sh b/t/t5700-clone-reference.sh
index 1c10916..2464f57 100755
--- a/t/t5700-clone-reference.sh
+++ b/t/t5700-clone-reference.sh
@@ -6,6 +6,8 @@
 test_description=3D'test clone --reference'
 . ./test-lib.sh
=20
+export GIT_HARDENED_SETUP=3D1
+
 base_dir=3D`pwd`
=20
 U=3D$base_dir/UPLOAD_LOG
diff --git a/t/t5701-clone-local.sh b/t/t5701-clone-local.sh
index 8b4c356..3c3d6ed 100755
--- a/t/t5701-clone-local.sh
+++ b/t/t5701-clone-local.sh
@@ -3,6 +3,8 @@
 test_description=3D'test local clone'
 . ./test-lib.sh
=20
+export GIT_HARDENED_SETUP=3D1
+
 D=3D`pwd`
=20
 test_expect_success 'preparing origin repository' '
diff --git a/t/t5702-clone-options.sh b/t/t5702-clone-options.sh
index 02cb024..63f59ba 100755
--- a/t/t5702-clone-options.sh
+++ b/t/t5702-clone-options.sh
@@ -3,6 +3,8 @@
 test_description=3D'basic clone options'
 . ./test-lib.sh
=20
+export GIT_HARDENED_SETUP=3D1
+
 test_expect_success 'setup' '
=20
 	mkdir parent &&
diff --git a/t/t5704-bundle.sh b/t/t5704-bundle.sh
index a8f4419..507c838 100755
--- a/t/t5704-bundle.sh
+++ b/t/t5704-bundle.sh
@@ -3,6 +3,8 @@
 test_description=3D'some bundle related tests'
 . ./test-lib.sh
=20
+export GIT_HARDENED_SETUP=3D1
+
 test_expect_success 'setup' '
=20
 	: > file &&
diff --git a/t/t5705-clone-2gb.sh b/t/t5705-clone-2gb.sh
index adfaae8..f63a557 100755
--- a/t/t5705-clone-2gb.sh
+++ b/t/t5705-clone-2gb.sh
@@ -3,6 +3,8 @@
 test_description=3D'Test cloning a repository larger than 2 gigabyte'
 . ./test-lib.sh
=20
+export GIT_HARDENED_SETUP=3D1
+
 test -z "$GIT_TEST_CLONE_2GB" &&
 say "Skipping expensive 2GB clone test; enable it with GIT_TEST_CLONE_=
2GB=3Dt" &&
 test_done &&
diff --git a/t/t5706-clone-branch.sh b/t/t5706-clone-branch.sh
index f3f9a76..fbee0d0 100755
--- a/t/t5706-clone-branch.sh
+++ b/t/t5706-clone-branch.sh
@@ -3,6 +3,8 @@
 test_description=3D'clone --branch option'
 . ./test-lib.sh
=20
+export GIT_HARDENED_SETUP=3D1
+
 check_HEAD() {
 	echo refs/heads/"$1" >expect &&
 	git symbolic-ref HEAD >actual &&
--=20
1.7.0.195.g637a2
