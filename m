From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH] test git-rev-parse
Date: Fri, 16 Mar 2007 23:33:57 +0100
Message-ID: <20070316223357.GA16255@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 16 23:34:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSKzw-0005os-5E
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 23:34:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965994AbXCPWeF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 18:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965995AbXCPWeE
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 18:34:04 -0400
Received: from mail.gmx.net ([213.165.64.20]:47513 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965994AbXCPWeC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 18:34:02 -0400
Received: (qmail invoked by alias); 16 Mar 2007 22:34:00 -0000
X-Provags-ID: V01U2FsdGVkX1+b9/9EFx2b40H/Jvt+MXqGY7RtChPRBlPXc/Nv0t
	FQMd84b/GqE2sw
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42401>

this tests --is-bare-repository, --is-inside-git-dir, --show-cdup and
--show-prefix

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
The number of the test has to be changed.
---
 t/t9999-rev-parse.sh |   57 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 57 insertions(+), 0 deletions(-)
 create mode 100755 t/t9999-rev-parse.sh

diff --git a/t/t9999-rev-parse.sh b/t/t9999-rev-parse.sh
new file mode 100755
index 0000000..c385660
--- /dev/null
+++ b/t/t9999-rev-parse.sh
@@ -0,0 +1,57 @@
+#!/bin/sh
+
+test_description='test git rev-parse'
+. ./test-lib.sh
+
+test_expect_success 'toplevel: is-bare-repository' \
+	'test "false" = "$(git rev-parse --is-bare-repository)"'
+test_expect_success 'toplevel: is-inside-git-dir' \
+	'test "false" = "$(git rev-parse --is-inside-git-dir)"'
+test_expect_success 'toplevel: show-cdup' \
+	'test "" = "$(git rev-parse --show-cdup)"'
+test_expect_success 'toplevel: show-prefix' \
+	'test "" = "$(git rev-parse --show-prefix)"'
+
+cd .git/objects || exit 1
+test_expect_success 'in-git-dir: is-bare-repository' \
+	'test "false" = "$(git rev-parse --is-bare-repository)"'
+test_expect_success 'in-git-dir: is-inside-git-dir' \
+	'test "true" = "$(git rev-parse --is-inside-git-dir)"'
+test_expect_success 'in-git-dir: show-cdup' \
+	'test "../../" = "$(git rev-parse --show-cdup)"'
+test_expect_success 'in-git-dir: show-prefix' \
+	'test ".git/objects/" = "$(git rev-parse --show-prefix)"'
+cd ../.. || exit 1
+
+mkdir sub || exit 1
+cd sub || exit 1
+test_expect_success 'subdirectory: is-bare-repository' \
+	'test "false" = "$(git rev-parse --is-bare-repository)"'
+test_expect_success 'subdirectory: is-inside-git-dir' \
+	'test "false" = "$(git rev-parse --is-inside-git-dir)"'
+test_expect_success 'subdirectory: show-cdup' \
+	'test "../" = "$(git rev-parse --show-cdup)"'
+test_expect_success 'subdirectory: show-prefix' \
+	'test "sub/" = "$(git rev-parse --show-prefix)"'
+cd .. || exit 1
+
+test_expect_success 'core.bare = true: is-bare-repository' \
+	'git config core.bare true &&
+	test "true" = "$(git rev-parse --is-bare-repository)"'
+test_expect_success 'unset core.bare: is-bare-repository' \
+	'git config --unset core.bare &&
+	test "false" = "$(git rev-parse --is-bare-repository)"'
+
+mv .git foo.git || exit 1
+export GIT_DIR=foo.git
+export GIT_CONFIG=foo.git/config
+test_expect_success 'GIT_DIR=foo.git: is-bare-repository' \
+	'test "true" = "$(git rev-parse --is-bare-repository)"'
+test_expect_success 'GIT_DIR=foo.git, core.bare = true: is-bare-repository' \
+	'git --git-dir foo.git config core.bare true &&
+	test "true" = "$(git --git-dir foo.git rev-parse --is-bare-repository)"'
+test_expect_success 'GIT_DIR=foo.git, core.bare = false: is-bare-repository' \
+	'git config core.bare false &&
+	test "false" = "$(git rev-parse --is-bare-repository)"'
+
+test_done
-- 
1.5.0.3.972.g70823
