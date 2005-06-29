From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 1/2] Test case that demonstrates problem with --merge-order ^ processing
Date: Thu, 30 Jun 2005 09:45:30 +1000
Message-ID: <20050629234530.28690.qmail@blackcubes.dyndns.org>
Cc: torvalds@osdl.org, jon.seymour@gmail.com
X-From: git-owner@vger.kernel.org Thu Jun 30 01:38:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dnm8W-00020E-3s
	for gcvg-git@gmane.org; Thu, 30 Jun 2005 01:38:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262724AbVF2Xpo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Jun 2005 19:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262735AbVF2Xpo
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jun 2005 19:45:44 -0400
Received: from 203-173-52-158.dyn.iinet.net.au ([203.173.52.158]:11905 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S262724AbVF2Xpd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2005 19:45:33 -0400
Received: (qmail 28700 invoked by uid 500); 29 Jun 2005 23:45:30 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Added a test case that shows that --merge-order doesn't produce the
correct result in the following case.

A
|
| B
|/
C
|
D

git-rev-list --merge-order A ^B should produce just A. Instead
it produces BCD.

A subsequent patch will fix this defect.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---

 t/t6001-rev-list-merge-order.sh |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

444e7b2e2491309cd7101bd48881743a35837a56
diff --git a/t/t6001-rev-list-merge-order.sh b/t/t6001-rev-list-merge-order.sh
--- a/t/t6001-rev-list-merge-order.sh
+++ b/t/t6001-rev-list-merge-order.sh
@@ -543,6 +543,11 @@ test_output_expect_success 'simple merge
 = alt_root
 EOF
 
+test_output_expect_success "don't print things unreachable from one branch" "git-rev-list a3 ^b3 --merge-order" <<EOF
+a3
+a2
+a1
+EOF
 
 #
 #
------------
