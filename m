From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH]: cogito testsuite: use git-symbolic-ref
Date: Mon, 14 Nov 2005 20:13:00 -0500
Message-ID: <1132017180.24084.39.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Nov 15 02:13:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbpNj-0003mL-DZ
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 02:13:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbVKOBNE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 20:13:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbVKOBNE
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 20:13:04 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:43968 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1751298AbVKOBND
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2005 20:13:03 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1EbpNe-0004vl-01
	for git@vger.kernel.org; Mon, 14 Nov 2005 20:13:02 -0500
Received: from proski by dv.roinet.com with local (Exim 4.54)
	id 1EbpNc-0003uY-Og; Mon, 14 Nov 2005 20:13:00 -0500
To: git <git@vger.kernel.org>, Petr Baudis <pasky@suse.cz>
X-Mailer: Evolution 2.4.1 (2.4.1-5) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11871>

cogito testsuite fails if git is compiled with USE_SYMLINK_HEAD=0.
To fix it, use git-symbolic-ref instead of readlink.

Signed-off-by: Pavel Roskin <proski@gnu.org>

diff --git a/t/t9300-seek.sh b/t/t9300-seek.sh
index d3fed11..a6f3a65 100755
--- a/t/t9300-seek.sh
+++ b/t/t9300-seek.sh
@@ -30,7 +30,7 @@ test_expect_success 'seeking to the firs
 test_expect_success 'we should have .git/head-name == master' \
 	"[ $(cat .git/head-name) = master ]"
 test_expect_success 'current branch should be cg-seek-point' \
-	"[ $(basename $(readlink .git/HEAD)) = cg-seek-point ]"
+	"[ $(basename $(git-symbolic-ref HEAD)) = cg-seek-point ]"
 test_expect_success 'current commit should be commit1' \
 	"[ $(cg-object-id -c) = $commit1 ]"
 
@@ -47,14 +47,16 @@ test_expect_success 'identical should be
 test_expect_success 'seeking to the second commit' \
 	"cg-seek $commit2"
 test_expect_success 'we should not unseeked properly' \
-	"([ -e .git/head-name ] && [ $(basename $(readlink .git/HEAD)) = cg-seek-point ])"
+	"([ -e .git/head-name ] &&
+	 [ $(basename $(git-symbolic-ref HEAD)) = cg-seek-point ])"
 test_expect_success 'current commit should be commit2' \
 	"[ $(cg-object-id -c) = $commit2 ]"
 
 test_expect_success 'seeking to the last (well, still second) commit' \
 	"cg-seek master"
 test_expect_success 'we should be unseeked properly' \
-	"([ ! -e .git/head-name ] && [ $(basename $(readlink .git/HEAD)) = master ])"
+	"([ ! -e .git/head-name ] &&
+	 [ $(basename $(git-symbolic-ref HEAD)) = master ])"
 test_expect_success 'current commit should be commit2' \
 	"[ $(cg-object-id -c) = $commit2 ]"
 
@@ -88,7 +90,8 @@ test_expect_success 'identical should be
 test_expect_success 'unseeking' \
 	"cg-seek"
 test_expect_success 'we should be unseeked properly' \
-	"([ ! -e .git/head-name ] && [ $(basename $(readlink .git/HEAD)) = master ])"
+	"([ ! -e .git/head-name ] &&
+	 [ $(basename $(git-symbolic-ref HEAD)) = master ])"
 test_expect_success 'current commit should be commit2' \
 	"[ $(cg-object-id -c) = $commit2 ]"
 


-- 
Regards,
Pavel Roskin
