From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 12/13] Add a t/t6001 test case for a --merge-order bug
Date: Thu, 07 Jul 2005 02:39:35 +1000
Message-ID: <20050706163935.10015.qmail@blackcubes.dyndns.org>
Cc: torvalds@osdl.org, jon.seymour@gmail.com
X-From: git-owner@vger.kernel.org Wed Jul 06 18:48:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqD3L-00065f-5g
	for gcvg-git@gmane.org; Wed, 06 Jul 2005 18:47:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262363AbVGFQqT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jul 2005 12:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262371AbVGFQoB
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jul 2005 12:44:01 -0400
Received: from 203-217-64-103.dyn.iinet.net.au ([203.217.64.103]:43648 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S262364AbVGFQjz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2005 12:39:55 -0400
Received: (qmail 10025 invoked by uid 500); 6 Jul 2005 16:39:35 -0000
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

The problem is fixed by a subsequent patch.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---

 t/t6001-rev-list-merge-order.sh |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

eb702818ec4e0db40da78dd27623d33fdbaabe8b
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
