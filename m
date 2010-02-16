From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [WIP PATCH 15/26] archive: move up gitdir setup to run_builtin()
Date: Tue, 16 Feb 2010 23:05:06 +0700
Message-ID: <1266336317-607-16-git-send-email-pclouds@gmail.com>
References: <1266336317-607-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 17:10:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhPzw-0008Ll-2g
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 17:10:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933036Ab0BPQJj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Feb 2010 11:09:39 -0500
Received: from mail-yx0-f200.google.com ([209.85.210.200]:56134 "EHLO
	mail-yx0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932954Ab0BPQJh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 11:09:37 -0500
Received: by mail-yx0-f200.google.com with SMTP id 38so4317189yxe.4
        for <git@vger.kernel.org>; Tue, 16 Feb 2010 08:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=gYmm2rxRkMcySKyWNPl8gpfuOGpGakNo8Vk86U55PP8=;
        b=rRFAcOtDM3jnbu8aa04GhgJqLvAkX8CCIG2I/O8wQ6hXK1O3TWcoEng7LbRntyFE6v
         0nTZcevgM8Aoi5K5lB66QihgXfGt65hddIbp0Ex55QRY0xQC3ZcYhoRunPSP1VM+wfsr
         HB2tw3tD+ynYIdFKvg22X7WMLh0/9xEuC6DCo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=oLJfRj8NkkTOBwHBVSV7NHsBg6TpUsADIMUqidZRzw173JLhksnx1lRgCsFEzO2WfG
         w8RDn/bDVYC3tOUjZP6uFCn3nhamcPsoRJzwYimVtOom3wHylllWmRcIga6syOdaikug
         EwF++bxumNm+7iULNueaYgI97sy70cYI2+mIg=
Received: by 10.101.131.9 with SMTP id i9mr1450276ann.214.1266336576986;
        Tue, 16 Feb 2010 08:09:36 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.207.162])
        by mx.google.com with ESMTPS id 8sm2857321ywg.49.2010.02.16.08.09.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 16 Feb 2010 08:09:35 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 16 Feb 2010 23:06:54 +0700
X-Mailer: git-send-email 1.7.0.195.g637a2
In-Reply-To: <1266336317-607-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140113>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin-archive.c       |    2 +-
 git.c                   |    4 ++--
 t/t0024-crlf-archive.sh |    3 +++
 t/t5000-tar-tree.sh     |    2 ++
 t/t5001-archive-attr.sh |    2 ++
 5 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/builtin-archive.c b/builtin-archive.c
index 6a887f5..ef0bef8 100644
--- a/builtin-archive.c
+++ b/builtin-archive.c
@@ -125,5 +125,5 @@ int cmd_archive(int argc, const char **argv, const =
char *prefix)
=20
 	setvbuf(stderr, NULL, _IOLBF, BUFSIZ);
=20
-	return write_archive(argc, argv, prefix, 1);
+	return write_archive(argc, argv, prefix, 0);
 }
diff --git a/git.c b/git.c
index 1d1ad1a..24fc0fc 100644
--- a/git.c
+++ b/git.c
@@ -308,7 +308,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "stage", cmd_add, RUN_SETUP | NEED_WORK_TREE },
 		{ "annotate", cmd_annotate, RUN_SETUP },
 		{ "apply", cmd_apply },
-		{ "archive", cmd_archive },
+		{ "archive", cmd_archive, RUN_SETUP_GENTLY },
 		{ "bisect--helper", cmd_bisect__helper, RUN_SETUP | NEED_WORK_TREE }=
,
 		{ "blame", cmd_blame, RUN_SETUP },
 		{ "branch", cmd_branch, RUN_SETUP },
@@ -396,7 +396,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "stripspace", cmd_stripspace },
 		{ "symbolic-ref", cmd_symbolic_ref, RUN_SETUP },
 		{ "tag", cmd_tag, RUN_SETUP },
-		{ "tar-tree", cmd_tar_tree },
+		{ "tar-tree", cmd_tar_tree, RUN_SETUP_GENTLY },
 		{ "unpack-file", cmd_unpack_file, RUN_SETUP },
 		{ "unpack-objects", cmd_unpack_objects, RUN_SETUP },
 		{ "update-index", cmd_update_index, RUN_SETUP },
diff --git a/t/t0024-crlf-archive.sh b/t/t0024-crlf-archive.sh
index c7d0324..f96db4d 100755
--- a/t/t0024-crlf-archive.sh
+++ b/t/t0024-crlf-archive.sh
@@ -3,6 +3,9 @@
 test_description=3D'respect crlf in git archive'
=20
 . ./test-lib.sh
+
+export GIT_HARDENED_SETUP=3D1
+
 UNZIP=3D${UNZIP:-unzip}
=20
 test_expect_success setup '
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 27bfba5..4c69dd2 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -29,6 +29,8 @@ UNZIP=3D${UNZIP:-unzip}
=20
 SUBSTFORMAT=3D%H%n
=20
+export GIT_HARDENED_SETUP=3D1
+
 test_expect_success \
     'populate workdir' \
     'mkdir a b c &&
diff --git a/t/t5001-archive-attr.sh b/t/t5001-archive-attr.sh
index 426b319..80e1e72 100755
--- a/t/t5001-archive-attr.sh
+++ b/t/t5001-archive-attr.sh
@@ -4,6 +4,8 @@ test_description=3D'git archive attribute tests'
=20
 . ./test-lib.sh
=20
+export GIT_HARDENED_SETUP=3D1
+
 SUBSTFORMAT=3D%H%n
=20
 test_expect_exists() {
--=20
1.7.0.195.g637a2
