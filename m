From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 1/3] Demonstrate broken t6001 test case function
Date: Thu, 30 Jun 2005 12:41:55 +1000
Message-ID: <20050630024155.32511.qmail@blackcubes.dyndns.org>
Cc: torvalds@osdl.org, jon.seymour@gmail.com
X-From: git-owner@vger.kernel.org Thu Jun 30 04:35:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnotI-0007TS-7i
	for gcvg-git@gmane.org; Thu, 30 Jun 2005 04:35:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262792AbVF3CmG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Jun 2005 22:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262796AbVF3CmG
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jun 2005 22:42:06 -0400
Received: from 203-173-52-158.dyn.iinet.net.au ([203.173.52.158]:39552 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S262792AbVF3Cl6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2005 22:41:58 -0400
Received: (qmail 32521 invoked by uid 500); 30 Jun 2005 02:41:55 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Junio discovered a problem where an actual test case break was hidden because pipelines
are not handled properly by the test infrastructure in t6001.

This patch fixes the broken infrastructure (and demonstrates the break explicitly).

A subsequent patch in this series will fix the test case so that it doesn't fail.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---

This patch set:
   * demonstrates and fixes some broken test infrastructure
   * fixes a broken test case that was previously hidden by the broken infrastructure
   * simplifies the test case to remove an unnecessary sort.

Although all patches in the set touch the same file, I have broken it into
three smaller patches to highlight the 3 different changes.

This patch set patches assumes that this series has been applied:

[PATCH 1/2] Test case that demonstrates problem with --merge-order ^ processing
[PATCH 2/2] Fix for git-rev-list --merge-order B ^A (A,B share common base) [rev 2]

 t/t6001-rev-list-merge-order.sh |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

0b0041e1fdb1b25757b0c861a0832c54b922440b
diff --git a/t/t6001-rev-list-merge-order.sh b/t/t6001-rev-list-merge-order.sh
--- a/t/t6001-rev-list-merge-order.sh
+++ b/t/t6001-rev-list-merge-order.sh
@@ -85,13 +85,12 @@ check_output()
 {
 	_name=$1
 	shift 1
-	if "$@" | entag > $_name.actual
+	if eval "$*" | entag > $_name.actual
 	then
 		diff $_name.expected $_name.actual
 	else
 		return 1;
 	fi
-	
 }
 
 # Turn a reasonable test description into a reasonable test name.
@@ -114,7 +113,7 @@ test_output_expect_success()
         [ $# -eq 2 ] || error "usage: test_output_expect_success description test <<EOF ... EOF"
         _name=$(echo $_description | name_from_description)
 	cat > $_name.expected
-	test_expect_success "$_description" "check_output $_name $_test" 
+	test_expect_success "$_description" "check_output $_name \"$_test\"" 
 }
 
 # --- end of stuff to move ---
------------
