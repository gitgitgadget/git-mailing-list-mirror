From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH 3/3] remote: 'show' and 'prune' take more than one remote
Date: Wed, 24 Apr 2013 15:54:37 +0200
Message-ID: <3c40e8ca9d85f5254c2ba7d6a42e1d0d196e6faf.1366811347.git.trast@inf.ethz.ch>
References: <cover.1366811347.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 24 15:55:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV0A0-0002hP-D9
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 15:55:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755765Ab3DXNyr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 09:54:47 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:34610 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755203Ab3DXNyn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 09:54:43 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 24 Apr
 2013 15:54:38 +0200
Received: from linux-k42r.v.cablecom.net (129.132.153.233) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 24 Apr
 2013 15:54:39 +0200
X-Mailer: git-send-email 1.8.2.1.935.g71f5136
In-Reply-To: <cover.1366811347.git.trast@inf.ethz.ch>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222252>

The 'git remote show' and 'prune' subcommands are documented as taking
only a single remote name argument, but that is not the case; they
will simply iterate the action over all remotes given.  Update the
documentation and tests to match.

With the last user of the -f flag gone, we also remove the code
supporting it.

Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
---
 Documentation/git-remote.txt |  4 ++--
 t/t5505-remote.sh            | 11 +++--------
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index e8c396b..7a6f354 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -18,8 +18,8 @@ SYNOPSIS
 'git remote set-url' [--push] <name> <newurl> [<oldurl>]
 'git remote set-url --add' [--push] <name> <newurl>
 'git remote set-url --delete' [--push] <name> <url>
-'git remote' [-v | --verbose] 'show' [-n] <name>
-'git remote prune' [-n | --dry-run] <name>
+'git remote' [-v | --verbose] 'show' [-n] <name>...
+'git remote prune' [-n | --dry-run] <name>...
 'git remote' [-v | --verbose] 'update' [-p | --prune] [(<group> | <remote>)...]
 
 DESCRIPTION
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index eea87fc..dd10ff0 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -1009,12 +1009,7 @@ test_expect_success 'extra args: setup' '
 '
 
 test_extra_arg () {
-	expect="success"
-	if test "z$1" = "z-f"; then
-		expect=failure
-		shift
-	fi
-	test_expect_$expect "extra args: $*" "
+	test_expect_success "extra args: $*" "
 		test_must_fail git remote $* bogus_extra_arg 2>actual &&
 		grep '^usage:' actual
 	"
@@ -1026,8 +1021,8 @@ test_extra_arg remove origin
 test_extra_arg set-head origin master
 # set-branches takes any number of args
 test_extra_arg set-url origin newurl oldurl
-test_extra_arg -f show origin
-test_extra_arg -f prune origin
+# show takes any number of args
+# prune takes any number of args
 # update takes any number of args
 
 test_done
-- 
1.8.2.1.931.g0116868
