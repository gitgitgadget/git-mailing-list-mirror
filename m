From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v8 1/4] submodule: additional regression tests for relative URLs
Date: Sun,  3 Jun 2012 19:46:47 +1000
Message-ID: <1338716810-9881-2-git-send-email-jon.seymour@gmail.com>
References: <1338716810-9881-1-git-send-email-jon.seymour@gmail.com>
Cc: Jens.Lehmann@web.de, gitster@pobox.com, phil.hord@gmail.com,
	ramsay@ramsay1.demon.co.uk, j6t@kdbg.org,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 03 11:47:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sb7P7-000631-D4
	for gcvg-git-2@plane.gmane.org; Sun, 03 Jun 2012 11:47:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753040Ab2FCJrL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Jun 2012 05:47:11 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:60718 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752397Ab2FCJrJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2012 05:47:09 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so4601633dad.19
        for <git@vger.kernel.org>; Sun, 03 Jun 2012 02:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=63f2V5t4O6ZVuEReP0DrG050lq1oin5ooGSS8N0Vq9w=;
        b=TVI6Bi4tMELPQ40Y+kLDRYy35cKeUUIRQNves90tO1PBhTBbvDLiUeKI1u9O0TGYWe
         C3g+OLx62wh00kj7YW2IOtqCSuvnxV65LOAGRVOjdwdU2jPEE+v9ubszYw9jeATB01F/
         fQRl6WMIU7oW5sTQbpOl/g1vwaH0I3XawIgJkMCchK0mbJM5o0w9NvMLs12/f/p/iGS8
         ImegmQ8aGY924pRjMA15WwKDzLaLlvGlInQUuOTAimhYpNOelR0xMmzINwFXFHcjkXgS
         eUaTs7qzwIfXx3y7Ij7ixUiSvQzn/cquCylZompepZYhJeIJTvGlWFmr0g79e7Qugj37
         lioQ==
Received: by 10.68.191.201 with SMTP id ha9mr25177796pbc.75.1338716828890;
        Sun, 03 Jun 2012 02:47:08 -0700 (PDT)
Received: from ubuntu.au.ibm.com (202-159-159-155.dyn.iinet.net.au. [202.159.159.155])
        by mx.google.com with ESMTPS id pb10sm8385550pbc.68.2012.06.03.02.47.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 03 Jun 2012 02:47:07 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2.651.g2c84487
In-Reply-To: <1338716810-9881-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199075>

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
1.7.10.2.652.gdffd412
