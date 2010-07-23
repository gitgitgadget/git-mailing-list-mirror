From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/2] worktree setup: return to original cwd if prefix is set NULL
Date: Sat, 24 Jul 2010 02:47:52 +0700
Message-ID: <1279914472-6544-1-git-send-email-pclouds@gmail.com>
References: <AANLkTilTmddAdEtLWvZy1wmB-kRPUL3E54lyKKWwfDqG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	avarab@gmail.com
X-From: git-owner@vger.kernel.org Sat Jul 24 08:13:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcXzO-000238-5h
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 08:13:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752018Ab0GXGNd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Jul 2010 02:13:33 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:38075 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751839Ab0GXGNc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jul 2010 02:13:32 -0400
Received: by pzk26 with SMTP id 26so374305pzk.19
        for <git@vger.kernel.org>; Fri, 23 Jul 2010 23:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=5nReg2sOEf+Ybg8FISJHb26Bw1nbkY6AxEF5QwhXuHk=;
        b=b7Mc7V9uQMWqWlvq4Sny0PmhN9Ku+dfomJVAfP3LPTFyL28nsEaAK8iN16R9CtqgN1
         ri90NoEWqq32tI06fHayFGtS2J3ijKGm2M0AJHmNvfPc0mZOAh6EYDWaiwIKlgKkZ3q7
         3dnIRzeKB9zKRRSUn7md5q494PlQbZasRhV1I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=kWvDXEmMHa4SpKhjgufoqLZGux05+uzOW9esjZqGynPlFm7aZAtJI/Lr6Hkx0o21f/
         /rYdRecVZ2b0pzVEHFwd9Ate2B9A8jEm/lbzHFtErwutU3yY7xhuVHQ6eOSxGiSxQ0Il
         j2SSztFEQQSnGzJpRAmY9hg410e2xYuHVArH4=
Received: by 10.142.194.15 with SMTP id r15mr5334272wff.274.1279952011976;
        Fri, 23 Jul 2010 23:13:31 -0700 (PDT)
Received: from dektop ([121.91.36.254])
        by mx.google.com with ESMTPS id c38sm1219220rvf.5.2010.07.23.23.13.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 23 Jul 2010 23:13:31 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Sat, 24 Jul 2010 02:47:53 +0700
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <AANLkTilTmddAdEtLWvZy1wmB-kRPUL3E54lyKKWwfDqG@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151602>

Commit a672ea6 (rehabilitate 'git index-pack' inside the object
store - 2008-10-20) worked around a fault in
setup_git_directory_gently(). When walking up from inside a git
repository, we will return NULL as prefix.

Prefix and cwd should be consistent. That is if cwd is moved, prefix
reflects that. If prefix is NULL, cwd is unmoved. In this case, to
retain current behavior, we move cwd back, with an eye on gitdir
because gitdir may be relative to cwd.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
  On Sat, Jul 24, 2010 at 01:16:00AM +0000, =C3=86var Arnfj=C3=B6r=C3=B0=
 Bjarmason wrote:
  > On Sat, Jul 24, 2010 at 00:50, Nguyen Thai Ngoc Duy <pclouds@gmail.=
com> wrote:
  >=20
  > > I don't want to pollute the repo early. If the test fails, rm wou=
ld not be run.
  >=20
  > Sure, I'm just asking if there's a reason to run rm in this
  > case. Because usually we defer the whole rm to be done inside
  > test-lib.sh once the entire test completes.
 =20
  "rm" removed. The rest of the tests do not seem to care whatelse in o=
bjects..

 setup.c             |    7 +++++++
 t/t1501-worktree.sh |   20 ++++++++++++++++++++
 2 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/setup.c b/setup.c
index 87c21f0..33eb253 100644
--- a/setup.c
+++ b/setup.c
@@ -413,6 +413,13 @@ const char *setup_git_directory_gently(int *nongit=
_ok)
 			if (!work_tree_env)
 				inside_work_tree =3D 0;
 			if (offset !=3D len) {
+				/*
+				 * The returned prefix in this code path is NULL
+				 * chdir() back to match NULL prefix, i.e. unmoved cwd
+				 */
+				if (chdir(cwd))
+					die_errno("Cannot come back to cwd");
+
 				root_len =3D offset_1st_component(cwd);
 				cwd[offset > root_len ? offset : root_len] =3D '\0';
 				set_git_dir(cwd);
diff --git a/t/t1501-worktree.sh b/t/t1501-worktree.sh
index bd8b607..a024056 100755
--- a/t/t1501-worktree.sh
+++ b/t/t1501-worktree.sh
@@ -33,6 +33,26 @@ mkdir -p work/sub/dir || exit 1
 mkdir -p work2 || exit 1
 mv .git repo.git || exit 1
=20
+cat >repo.git/objects/patch <<\EOF
+diff one one
+--- one
++++ one
+@@ -1 +1,2 @@
+ 1
++2
+EOF
+
+test_expect_success 'cwd is unchanged when prefix is NULL (from within=
 a repo)' '
+	(
+		cd repo.git/objects &&
+		echo 1 > one &&
+		cp one expected &&
+		echo 2 >> expected &&
+		git apply patch &&
+		test_cmp expected one
+	)
+'
+
 say "core.worktree =3D relative path"
 GIT_DIR=3Drepo.git
 GIT_CONFIG=3D"$(pwd)"/$GIT_DIR/config
--=20
1.7.1.rc1.69.g24c2f7
