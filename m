From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 13/16] t3700: Skip a test with backslashes in pathspec
Date: Sat, 21 Mar 2009 22:26:36 +0100
Message-ID: <6acd113f60d1b0e7926386f3aebe5d72ad362034.1237667830.git.j6t@kdbg.org>
References: <cover.1237667830.git.j6t@kdbg.org>
Cc: Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 21 22:30:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ll8lg-0004Ii-Fk
	for gcvg-git-2@gmane.org; Sat, 21 Mar 2009 22:30:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754967AbZCUV1X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2009 17:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753039AbZCUV1V
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Mar 2009 17:27:21 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:27965 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753648AbZCUV07 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2009 17:26:59 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id DEC94CDF8E;
	Sat, 21 Mar 2009 22:26:56 +0100 (CET)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id CEDCA40009;
	Sat, 21 Mar 2009 22:26:55 +0100 (CET)
X-Mailer: git-send-email 1.6.2.1.224.g2225f
In-Reply-To: <cover.1237667830.git.j6t@kdbg.org>
In-Reply-To: <cover.1237667830.git.j6t@kdbg.org>
References: <cover.1237667830.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114066>

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t3700-add.sh |    2 +-
 t/test-lib.sh  |    2 ++
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index dc17d9f..050de42 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -222,7 +222,7 @@ test_expect_success POSIXPERM 'git add (add.ignore-errors = false)' '
 	! ( git ls-files foo1 | grep foo1 )
 '
 
-test_expect_success 'git add '\''fo\[ou\]bar'\'' ignores foobar' '
+test_expect_success BSLASHPSPEC "git add 'fo\\[ou\\]bar' ignores foobar" '
 	git reset --hard &&
 	touch fo\[ou\]bar foobar &&
 	git add '\''fo\[ou\]bar'\'' &&
diff --git a/t/test-lib.sh b/t/test-lib.sh
index f134e73..b4b626e 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -688,9 +688,11 @@ case $(uname -s) in
 		builtin pwd -W
 	}
 	# no POSIX permissions
+	# backslashes in pathspec are converted to '/'
 	;;
 *)
 	test_set_prereq POSIXPERM
+	test_set_prereq BSLASHPSPEC
 	;;
 esac
 
-- 
1.6.2.1.224.g2225f
