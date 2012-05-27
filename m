From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v6 1/9] submodule: additional regression tests for relative URLs
Date: Sun, 27 May 2012 23:43:22 +1000
Message-ID: <1338126210-11517-2-git-send-email-jon.seymour@gmail.com>
References: <1338126210-11517-1-git-send-email-jon.seymour@gmail.com>
Cc: Jens.Lehmann@web.de, gitster@pobox.com, phil.hord@gmail.com,
	ramsay@ramsay1.demon.co.uk, Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 27 15:43:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYdlB-0005oe-E3
	for gcvg-git-2@plane.gmane.org; Sun, 27 May 2012 15:43:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752078Ab2E0Nnr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 May 2012 09:43:47 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:38301 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751894Ab2E0Nnq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2012 09:43:46 -0400
Received: by dady13 with SMTP id y13so3101250dad.19
        for <git@vger.kernel.org>; Sun, 27 May 2012 06:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=hVLf1uKv5SWKOvIgOg3tW/GPr3BPPlDwbNOUOQmHCmc=;
        b=NxcdiGBFKXCQT6CTS0oYyTzvI0Sm2hzfZF72ZwMoO9v5gXA97ri/V6SYfZtuMmmWD2
         bCh8BjE8lj09mz0qIvykMxx0b67GAUlyZXSmQec/c+fJpSjA6RiT5IC4nDWODwFk5e7P
         r9+GmTD2rE08FofZ8wzm2igPNliBMGhS0nz1WbdBodEfn9vUr6wNGpKkhneVbmu3tS+C
         U3D2c0YRcEp0LdhZ+vnJwxYQGYm9L/7E0SGC797logHcwyM7TBzXx7a5xvEYQ0nVfX1n
         6UbL3DkFqlJccxzIaiqC70H2oD3HAkWhJw2bz+GIioFk/PSubPWzdJ5KyM2RTHq+HWMQ
         CPFg==
Received: by 10.68.219.199 with SMTP id pq7mr17288856pbc.93.1338126225371;
        Sun, 27 May 2012 06:43:45 -0700 (PDT)
Received: from ubuntu.ubuntu-domain (124-170-214-58.dyn.iinet.net.au. [124.170.214.58])
        by mx.google.com with ESMTPS id ru4sm15870005pbc.66.2012.05.27.06.43.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 27 May 2012 06:43:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2.656.gb5a46db
In-Reply-To: <1338126210-11517-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198593>

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
1.7.10.2.656.gb5a46db
