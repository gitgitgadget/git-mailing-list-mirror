From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v7 1/9] submodule: additional regression tests for relative URLs
Date: Mon, 28 May 2012 01:34:03 +1000
Message-ID: <1338132851-23497-2-git-send-email-jon.seymour@gmail.com>
References: <1338132851-23497-1-git-send-email-jon.seymour@gmail.com>
Cc: Jens.Lehmann@web.de, gitster@pobox.com, phil.hord@gmail.com,
	ramsay@ramsay1.demon.co.uk, Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 27 17:36:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYfVo-0006Ww-3A
	for gcvg-git-2@plane.gmane.org; Sun, 27 May 2012 17:36:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752769Ab2E0Pe7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 May 2012 11:34:59 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:58786 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750958Ab2E0Pe0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2012 11:34:26 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so3166603dad.19
        for <git@vger.kernel.org>; Sun, 27 May 2012 08:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=MjGpXb7JoiY3CqyaAjZjAXorn1sUDnpWjnRwm4i3Pq4=;
        b=W89FiXI+vm7HbvH8TUqwNhPRX8fM6zbYCiilRThuNQWZNcbIibNBvvpCS6yaz/RoKW
         uJkpxI1RIl4eci0n1fN7Rp4l1clgJBx+q1uTTbd+xMcWctMLlvK4joVUeWerzOR07+Ki
         g+DgySuCJUkToQ91vfhIkfGURFlQBKjb2yPPPhDSDPAWOgfKrnxNF5mFA4kA3imjdISL
         baruc2VC1lKfiU/GFcYYqaV4hh9UXcc8mbgSOS7p3t9g062mY1W7P/9G4D5TlakJ+y+f
         Mu5tER0m1xRtFeCyQcVS9TWl+D6Y1vs8mgwJvWBY56JhPxWhegJLOkuNntqeZ3O6z2vA
         Y/cw==
Received: by 10.68.197.99 with SMTP id it3mr875409pbc.148.1338132866101;
        Sun, 27 May 2012 08:34:26 -0700 (PDT)
Received: from ubuntu.ubuntu-domain (124-170-214-58.dyn.iinet.net.au. [124.170.214.58])
        by mx.google.com with ESMTPS id rk4sm16128261pbc.48.2012.05.27.08.34.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 27 May 2012 08:34:25 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2.656.g24a6219
In-Reply-To: <1338132851-23497-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198606>

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
1.7.10.2.656.g24a6219
