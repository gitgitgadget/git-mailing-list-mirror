From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 1/2] Add a t/t6001 test case for a --merge-order bug
Date: Thu, 07 Jul 2005 00:44:06 +1000
Message-ID: <20050706144406.17750.qmail@blackcubes.dyndns.org>
Cc: torvalds@osdl.org, jon.seymour@gmail.com
X-From: git-owner@vger.kernel.org Wed Jul 06 16:45:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqB9L-000203-VN
	for gcvg-git@gmane.org; Wed, 06 Jul 2005 16:45:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262315AbVGFOoz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jul 2005 10:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262344AbVGFOoz
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jul 2005 10:44:55 -0400
Received: from 203-217-64-103.dyn.iinet.net.au ([203.217.64.103]:1665 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S262315AbVGFOoM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2005 10:44:12 -0400
Received: (qmail 17760 invoked by uid 500); 6 Jul 2005 14:44:06 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


This test case demonstrates a problem with --merge-order.

A
|
B
|\
C D
|/
E
|
F

git-rev-list --merge-order A B doesn't produce the expected output of

A
B
D
C
E
F

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
This patch is known designed to apply on top of:

[PATCH 1/6] Temporary fixup to rev-list.c to restore expected order of arguments presented to --merge-order sort.
[PATCH 2/6] Swap order of insert_by_date arguments
[PATCH 3/6] Introduce struct rev_list_fns to rev-list.c to reduce amount of conditional processing.
[PATCH 4/6] Add a topological sort procedure to commit.c [rev 4]
[PATCH 5/6] Introduce --topo-order switch to git-rev-list
[PATCH 6/6] Change gitk so that it uses --topo-order rather than --merge-order

and 

[PATCH 1/3] Factor out useful test case infrastructure from t/t6001... into t/t6000-lib.sh
[PATCH 2/3] Introduce unit tests for git-rev-list --bisect
[PATCH 3/3] Change the sed seperator in t/t6000-lib.sh.

A subsequent patch will fix the problem.
---

 t/t6001-rev-list-merge-order.sh |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

3c04d86fbc9310e823a6a46ac7bf295fda57c7b7
diff --git a/t/t6001-rev-list-merge-order.sh b/t/t6001-rev-list-merge-order.sh
--- a/t/t6001-rev-list-merge-order.sh
+++ b/t/t6001-rev-list-merge-order.sh
@@ -438,6 +438,26 @@ a2
 a1
 EOF
 
+test_output_expect_success "--merge-order a4 l3" "git-rev-list --merge-order a4 l3" <<EOF
+l3
+a4
+c3
+c2
+c1
+b4
+b3
+b2
+b1
+a3
+a2
+a1
+a0
+l2
+l1
+l0
+root
+EOF
+
 #
 #
 
------------
