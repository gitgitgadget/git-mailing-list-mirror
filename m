From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 3/4] t5500-fetch-pack: remove local (bashism) usage.
Date: Thu, 25 May 2006 19:06:17 -0700
Message-ID: <11486091793385-git-send-email-normalperson@yhbt.net>
References: <11486091783808-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: git@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
	Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri May 26 04:06:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjRid-00077O-TR
	for gcvg-git@gmane.org; Fri, 26 May 2006 04:06:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030214AbWEZCGV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 May 2006 22:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030217AbWEZCGU
	(ORCPT <rfc822;git-outgoing>); Thu, 25 May 2006 22:06:20 -0400
Received: from hand.yhbt.net ([66.150.188.102]:7574 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1030214AbWEZCGU (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 May 2006 22:06:20 -0400
Received: by hand.yhbt.net (Postfix, from userid 500)
	id 477FD7DC022; Thu, 25 May 2006 19:06:19 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.3.2.g7d11
In-Reply-To: <11486091783808-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20777>

None of the variables seem to conflict, so local was unnecessary.

Also replaced ${var:pos:len} with the sed equivalent.

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 t/t5500-fetch-pack.sh |   30 +++++++++++++++---------------
 1 files changed, 15 insertions(+), 15 deletions(-)

62f64e95d24f90e61af0fa42d88300e41f60c277
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 92f12d9..f7625a6 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -12,11 +12,11 @@ # Test fetch-pack/upload-pack pair.
 
 # Some convenience functions
 
-function add () {
-	local name=$1
-	local text="$@"
-	local branch=${name:0:1}
-	local parents=""
+add () {
+	name=$1
+	text="$@"
+	branch=`echo $name | sed -e 's/^\(.\).*$/\1/'`
+	parents=""
 
 	shift
 	while test $1; do
@@ -36,13 +36,13 @@ function add () {
 	eval ${branch}TIP=$commit
 }
 
-function count_objects () {
+count_objects () {
 	ls .git/objects/??/* 2>>log2.txt | wc -l | tr -d " "
 }
 
-function test_expect_object_count () {
-	local message=$1
-	local count=$2
+test_expect_object_count () {
+	message=$1
+	count=$2
 
 	output="$(count_objects)"
 	test_expect_success \
@@ -50,18 +50,18 @@ function test_expect_object_count () {
 		"test $count = $output"
 }
 
-function pull_to_client () {
-	local number=$1
-	local heads=$2
-	local count=$3
-	local no_strict_count_check=$4
+pull_to_client () {
+	number=$1
+	heads=$2
+	count=$3
+	no_strict_count_check=$4
 
 	cd client
 	test_expect_success "$number pull" \
 		"git-fetch-pack -k -v .. $heads"
 	case "$heads" in *A*) echo $ATIP > .git/refs/heads/A;; esac
 	case "$heads" in *B*) echo $BTIP > .git/refs/heads/B;; esac
-	git-symbolic-ref HEAD refs/heads/${heads:0:1}
+	git-symbolic-ref HEAD refs/heads/`echo $heads | sed -e 's/^\(.\).*$/\1/'`
 
 	test_expect_success "fsck" 'git-fsck-objects --full > fsck.txt 2>&1'
 
-- 
1.3.2.g7d11
