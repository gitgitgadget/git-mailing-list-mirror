From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 26/26] Disable file-watcher with system inotify on some tests
Date: Mon,  3 Feb 2014 11:29:14 +0700
Message-ID: <1391401754-15347-27-git-send-email-pclouds@gmail.com>
References: <1389952060-12297-1-git-send-email-pclouds@gmail.com>
 <1391401754-15347-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 03 05:31:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WABCM-0001iF-EI
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 05:31:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753035AbaBCEbu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Feb 2014 23:31:50 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36039 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753031AbaBCEbt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Feb 2014 23:31:49 -0500
Received: by mail-pa0-f49.google.com with SMTP id hz1so6585517pad.22
        for <git@vger.kernel.org>; Sun, 02 Feb 2014 20:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=G6PPJZogijnzxt6Vmk76OXAHGOb/ALyBYSm9Wlg5/ZA=;
        b=0pRZN2CTuhrasYwGhT375+JvJb7pjtjp54o9rcz7wYxxMKaEn8B2vfJeTOF0+iRmDa
         aaCMFJKDRmxUGSln7sylveRwLCJQidFIqmkfg02u2uUBlvcI8s9FlLkEGy/nqcU/bfQN
         1rp7eNrd4DCK5gSPC1M5VnjKszxg0H91KsjmEoVSe65aSVjNDkvJ+HXQ8naIQRi96JeP
         9b+ZHC8qE/4Mm4Q3gB9M5YIy3aeEkxwYeKWBF9/NDP+xttoeGrhscJJTScx/nfXMeDPQ
         AqR0oMrod7WYVLdWV4LSt2VFwAvuZR5NtVWTBjf7cj17tc9G5f38zbptqVWAqjQRDkTt
         yYBw==
X-Received: by 10.66.249.202 with SMTP id yw10mr34338992pac.111.1391401908900;
        Sun, 02 Feb 2014 20:31:48 -0800 (PST)
Received: from lanh ([115.73.226.68])
        by mx.google.com with ESMTPSA id db3sm51429298pbb.10.2014.02.02.20.31.46
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 02 Feb 2014 20:31:48 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 03 Feb 2014 11:31:47 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1391401754-15347-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241421>

When file watcher is active via GIT_TEST_WATCHER_PATH, `ls-files -v`
output may be different (e.g. "H" becomes "W"). Disable file watcher
in those cases.

We could make ls-files turn 'W' back to 'H' for these cases, but not
sure it's worth the effort. The intention of running with
GIT_TEST_WATCHER_PATH is to exercise file watcher in somewhat real
scenarios and the remaining tests are more than enough for that.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1011-read-tree-sparse-checkout.sh  | 2 ++
 t/t2104-update-index-skip-worktree.sh | 2 ++
 t/t7011-skip-worktree-reading.sh      | 2 ++
 t/t7012-skip-worktree-writing.sh      | 2 ++
 4 files changed, 8 insertions(+)

diff --git a/t/t1011-read-tree-sparse-checkout.sh b/t/t1011-read-tree-s=
parse-checkout.sh
index 0c74bee..00e92bc 100755
--- a/t/t1011-read-tree-sparse-checkout.sh
+++ b/t/t1011-read-tree-sparse-checkout.sh
@@ -14,6 +14,8 @@ test_description=3D'sparse checkout tests
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-read-tree.sh
=20
+unset GIT_TEST_WATCHER_PATH
+
 test_expect_success 'setup' '
 	cat >expected <<-\EOF &&
 	100644 77f0ba1734ed79d12881f81b36ee134de6a3327b 0	init.t
diff --git a/t/t2104-update-index-skip-worktree.sh b/t/t2104-update-ind=
ex-skip-worktree.sh
index 1d0879b..2b93c58 100755
--- a/t/t2104-update-index-skip-worktree.sh
+++ b/t/t2104-update-index-skip-worktree.sh
@@ -7,6 +7,8 @@ test_description=3D'skip-worktree bit test'
=20
 . ./test-lib.sh
=20
+unset GIT_TEST_WATCHER_PATH
+
 cat >expect.full <<EOF
 H 1
 H 2
diff --git a/t/t7011-skip-worktree-reading.sh b/t/t7011-skip-worktree-r=
eading.sh
index 88d60c1..2242718 100755
--- a/t/t7011-skip-worktree-reading.sh
+++ b/t/t7011-skip-worktree-reading.sh
@@ -7,6 +7,8 @@ test_description=3D'skip-worktree bit test'
=20
 . ./test-lib.sh
=20
+unset GIT_TEST_WATCHER_PATH
+
 cat >expect.full <<EOF
 H 1
 H 2
diff --git a/t/t7012-skip-worktree-writing.sh b/t/t7012-skip-worktree-w=
riting.sh
index 9ceaa40..c8e0eb5 100755
--- a/t/t7012-skip-worktree-writing.sh
+++ b/t/t7012-skip-worktree-writing.sh
@@ -7,6 +7,8 @@ test_description=3D'test worktree writing operations wh=
en skip-worktree is used'
=20
 . ./test-lib.sh
=20
+unset GIT_TEST_WATCHER_PATH
+
 test_expect_success 'setup' '
 	test_commit init &&
 	echo modified >> init.t &&
--=20
1.8.5.2.240.g8478abd
