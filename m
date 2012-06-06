From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v9 1/4] submodule: additional regression tests for relative URLs
Date: Wed,  6 Jun 2012 21:57:27 +1000
Message-ID: <1338983850-9872-2-git-send-email-jon.seymour@gmail.com>
References: <1338983850-9872-1-git-send-email-jon.seymour@gmail.com>
Cc: Jens.Lehmann@web.de, gitster@pobox.com, phil.hord@gmail.com,
	ramsay@ramsay1.demon.co.uk, j6t@kdbg.org,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 06 13:58:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScEsC-0000Jj-Jq
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jun 2012 13:58:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752949Ab2FFL5s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jun 2012 07:57:48 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:58482 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751945Ab2FFL5q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2012 07:57:46 -0400
Received: by pbbrp8 with SMTP id rp8so8843656pbb.19
        for <git@vger.kernel.org>; Wed, 06 Jun 2012 04:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ksv0qd9nIVGXDrqye3azPSIr4stknXK4BJBd1Z3teIM=;
        b=Xuz5dyXg4/wOhYe8LvwK0AIS2DyPpsi0QXOtD/OoOl8zmnVCPmPctU/i1brYUzlM+4
         eOPFEL9f+8ie/AW9xVHl/roiirVvWlRrfmSQ9JRTSA7NOsyfISdhykqFVFhrMW5Wc7J4
         NMx2TOksUoNeCYHdI80KNiB4ae1cDRUuaGvHx5I25GWl+Ws63tKhkIS6sV9ubH6EIUex
         Fqc/iNIOu28b2TNW8Z5W8HJDKhSgyK9xOZy2/0Mebj9S21UeEI11KF53NuGYx2sS2v6U
         UVeZAspZL5GWrEtf5w2yi+L8JEbvx9j35st4SC4cIHto1Ih1m9Rfm36ceWkoeBvy9HRm
         okyw==
Received: by 10.68.190.97 with SMTP id gp1mr59147480pbc.76.1338983865593;
        Wed, 06 Jun 2012 04:57:45 -0700 (PDT)
Received: from ubuntu.au.ibm.com ([175.103.19.195])
        by mx.google.com with ESMTPS id pg3sm197182pbc.2.2012.06.06.04.57.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Jun 2012 04:57:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2.650.g9c513dd.dirty
In-Reply-To: <1338983850-9872-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199317>

Some additional tests are added to support regression testing of the changes in the
remainder of the series.

We also add a pristine copy of .gitmodules in anticipation of this being
required by later tests.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 t/t7400-submodule-basic.sh | 110 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 107 insertions(+), 3 deletions(-)

diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 81827e6..9428c7a 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -483,21 +483,67 @@ test_expect_success 'set up for relative path tests' '
 		git add sub &&
 		git config -f .gitmodules submodule.sub.path sub &&
 		git config -f .gitmodules submodule.sub.url ../subrepo &&
-		cp .git/config pristine-.git-config
+		cp .git/config pristine-.git-config &&
+		cp .gitmodules pristine-.gitmodules
 	)
 '
 
-test_expect_success 'relative path works with URL' '
+test_expect_success '../subrepo works with URL - ssh://hostname/repo' '
 	(
 		cd reltest &&
 		cp pristine-.git-config .git/config &&
+		cp pristine-.gitmodules .gitmodules &&
 		git config remote.origin.url ssh://hostname/repo &&
 		git submodule init &&
 		test "$(git config submodule.sub.url)" = ssh://hostname/subrepo
 	)
 '
 
-test_expect_success 'relative path works with user@host:path' '
+test_expect_success '../subrepo works with port-qualified URL - ssh://hostname:22/repo' '
+	(
+		cd reltest &&
+		cp pristine-.git-config .git/config &&
+		cp pristine-.gitmodules .gitmodules &&
+		git config remote.origin.url ssh://hostname:22/repo &&
+		git submodule init &&
+		test "$(git config submodule.sub.url)" = ssh://hostname:22/subrepo
+	)
+'
+
+test_expect_success '../subrepo path works with local path - /foo/repo' '
+	(
+		cd reltest &&
+		cp pristine-.git-config .git/config &&
+		cp pristine-.gitmodules .gitmodules &&
+		git config remote.origin.url /foo/repo &&
+		git submodule init &&
+		test "$(git config submodule.sub.url)" = /foo/subrepo
+	)
+'
+
+test_expect_success '../subrepo works with file URL - file:///tmp/repo' '
+	(
+		cd reltest &&
+		cp pristine-.git-config .git/config &&
+		cp pristine-.gitmodules .gitmodules &&
+		git config remote.origin.url file:///tmp/repo &&
+		git submodule init &&
+		test "$(git config submodule.sub.url)" = file:///tmp/subrepo
+	)
+'
+
+test_expect_success '../subrepo works with helper URL- helper:://hostname/repo' '
+	(
+		cd reltest &&
+		cp pristine-.git-config .git/config &&
+		cp pristine-.gitmodules .gitmodules &&
+		git config remote.origin.url helper:://hostname/repo &&
+		git submodule init &&
+		test "$(git config submodule.sub.url)" = helper:://hostname/subrepo
+	)
+'
+
+test_expect_success '../subrepo works with scp-style URL - user@host:repo' '
 	(
 		cd reltest &&
 		cp pristine-.git-config .git/config &&
@@ -507,6 +553,64 @@ test_expect_success 'relative path works with user@host:path' '
 	)
 '
 
+test_expect_success '../subrepo works with scp-style URL - user@host:path/to/repo' '
+	(
+		cd reltest &&
+		cp pristine-.git-config .git/config &&
+		cp pristine-.gitmodules .gitmodules &&
+		git config remote.origin.url user@host:path/to/repo &&
+		git submodule init &&
+		test "$(git config submodule.sub.url)" = user@host:path/to/subrepo
+	)
+'
+
+test_expect_success '../subrepo works with relative local path - foo/bar' '
+	(
+		cd reltest &&
+		cp pristine-.git-config .git/config &&
+		cp pristine-.gitmodules .gitmodules &&
+		git config remote.origin.url foo/bar &&
+		git submodule init &&
+		test "$(git config submodule.sub.url)" = foo/subrepo
+	)
+'
+
+test_expect_success '../subrepo works with relative local path - ../foo' '
+	(
+		cd reltest &&
+		cp pristine-.git-config .git/config &&
+		cp pristine-.gitmodules .gitmodules &&
+		git config remote.origin.url ../foo &&
+		git submodule init &&
+		test "$(git config submodule.sub.url)" = ../subrepo
+	)
+'
+
+test_expect_success '../subrepo works with relative local path - ../foo/bar' '
+	(
+		cd reltest &&
+		cp pristine-.git-config .git/config &&
+		cp pristine-.gitmodules .gitmodules &&
+		git config remote.origin.url ../foo/bar &&
+		git submodule init &&
+		test "$(git config submodule.sub.url)" = ../foo/subrepo
+	)
+'
+
+test_expect_success '../bar/a/b/c works with relative local path - ../foo/bar.git' '
+	(
+		cd reltest &&
+		cp pristine-.git-config .git/config &&
+		cp pristine-.gitmodules .gitmodules &&
+		mkdir -p a/b/c &&
+		(cd a/b/c; git init) &&
+		git config remote.origin.url ../foo/bar.git &&
+		git submodule add ../bar/a/b/c ./a/b/c &&
+		git submodule init &&
+		test "$(git config submodule.a/b/c.url)" = ../foo/bar/a/b/c
+	)
+'
+
 test_expect_success 'moving the superproject does not break submodules' '
 	(
 		cd addtest &&
-- 
1.7.10.2.650.g9c513dd.dirty
