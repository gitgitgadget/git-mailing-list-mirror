From: Kevin Bracey <kevin@bracey.fi>
Subject: [PATCH v4 05/15] t6111: add parents to tests
Date: Thu, 16 May 2013 18:32:31 +0300
Message-ID: <1368718361-27859-6-git-send-email-kevin@bracey.fi>
References: <1368718361-27859-1-git-send-email-kevin@bracey.fi>
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Kevin Bracey <kevin@bracey.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 16 17:49:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ud0RB-0000fe-U9
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 17:49:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754554Ab3EPPtm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 11:49:42 -0400
Received: from 18.mo4.mail-out.ovh.net ([188.165.54.143]:42418 "EHLO
	mo4.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754482Ab3EPPtk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 11:49:40 -0400
Received: from mail92.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo4.mail-out.ovh.net (Postfix) with SMTP id 6440110540C3
	for <git@vger.kernel.org>; Thu, 16 May 2013 17:33:09 +0200 (CEST)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 16 May 2013 17:33:09 +0200
Received: from 85-23-153-122.bb.dnainternet.fi (HELO asus-i7-debian.bracey.fi) (kevin@bracey.fi@85.23.153.122)
  by ns0.ovh.net with SMTP; 16 May 2013 17:33:05 +0200
X-Ovh-Mailout: 178.32.228.4 (mo4.mail-out.ovh.net)
X-Mailer: git-send-email 1.8.3.rc0.28.g4b02ef5
In-Reply-To: <1368718361-27859-1-git-send-email-kevin@bracey.fi>
X-Ovh-Tracer-Id: 18172305972904431843
X-Ovh-Remote: 85.23.153.122 (85-23-153-122.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: -100
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrkeegucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-Spam-Check: DONE|U 0.500006/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrkeegucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224587>

Signed-off-by: Kevin Bracey <kevin@bracey.fi>
---
 t/t6111-rev-list-treesame.sh | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/t/t6111-rev-list-treesame.sh b/t/t6111-rev-list-treesame.sh
index 1e4a550..4d74d3c 100755
--- a/t/t6111-rev-list-treesame.sh
+++ b/t/t6111-rev-list-treesame.sh
@@ -66,8 +66,6 @@ test_expect_success setup '
 	test_commit M file "Parts 1+2"
 '
 
-# could we soup this up to optionally check parents? So "(BA)C" would check
-# that C is shown and has parents B A.
 check_outcome () {
 	outcome=$1
 	shift
@@ -109,14 +107,16 @@ check_result () {
 # except the most basic list. Achieving this means normal merge D will also be
 # shown in normal full-history, as we can't distinguish unless we do a
 # simplification pass. After simplification, D is dropped but G remains.
+# Also, merge simplification of G should not drop the parent B that the default
+# simple history follows.
 check_result 'M L K J I H G F E D C B A'
 check_result '(LH)M (K)L (GJ)K (I)J (G)I (G)H (FE)G (D)F (B)E (BC)D (A)C (A)B A'
 check_result 'M H L K J I G E F D C B A' --topo-order
 check_result 'M L H B A' -- file
-check_result 'M L H B A' --parents -- file
+check_result '(LH)M (B)L (B)H (A)B A' --parents -- file
 check_outcome failure 'M L J I H G F D B A' --full-history -- file # drops G
-check_result 'M L K J I H G F D B A' --full-history --parents -- file
-check_outcome failure 'M H L J I G F B A' --simplify-merges -- file # drops G
+check_result '(LH)M (K)L (GJ)K (I)J (G)I (G)H (FB)G (D)F (BA)D (A)B A' --full-history --parents -- file
+check_outcome failure '(LH)M (G)H (J)L (I)J (G)I (FB)G (B)F (A)B A' --simplify-merges -- file # drops G
 check_result 'M L K G F D B A' --first-parent
 check_result 'M L G F B A' --first-parent -- file
 
@@ -124,14 +124,14 @@ check_result 'M L G F B A' --first-parent -- file
 check_result 'M L K J I H G E' F..M
 check_result 'M H L K J I G E' F..M --topo-order
 check_result 'M L H' F..M -- file
-check_result 'M L H' F..M --parents -- file # L+H's parents rewritten to B, so more useful than it may seem
+check_result '(LH)M (B)L (B)H' --parents F..M -- file
 check_outcome failure 'M L J I H G' F..M --full-history -- file # drops G
-check_result 'M L K J I H G' F..M --full-history --parents -- file
-check_outcome failure 'M H L J I G' F..M --simplify-merges -- file # drops G
+check_result '(LH)M (K)L (GJ)K (I)J (G)I (G)H (FB)G' F..M --full-history --parents -- file
+check_outcome failure '(LH)M (G)H (J)L (I)J (G)I (FB)G' F..M --simplify-merges -- file # drops G
 check_result 'M L K J I H G' F..M --ancestry-path
 check_outcome failure 'M L J I H G' F..M --ancestry-path -- file # drops G
-check_result 'M L K J I H G' F..M --ancestry-path --parents -- file
-check_result 'M H L J I G' F..M --ancestry-path --simplify-merges -- file
+check_result '(LH)M (K)L (GJ)K (I)J (G)I (G)H (FE)G' F..M --ancestry-path --parents -- file
+check_result '(LH)M (G)H (J)L (I)J (G)I (FE)G' F..M --ancestry-path --simplify-merges -- file
 check_result 'M L K G' F..M --first-parent
 check_result 'M L G' F..M --first-parent -- file
 
@@ -139,15 +139,15 @@ check_result 'M L G' F..M --first-parent -- file
 # If we want history since E, then we're quite happy to ignore G that took E.
 check_result 'M L K J I H G' E..M --ancestry-path
 check_result 'M L J I H' E..M --ancestry-path -- file
-check_outcome failure 'M L K J I H' E..M --ancestry-path --parents -- file # includes G
-check_outcome failure 'M H L J I' E..M --ancestry-path --simplify-merges -- file # includes G
+check_outcome failure '(LH)M (K)L (EJ)K (I)J (E)I (E)H' E..M --ancestry-path --parents -- file # includes G
+check_outcome failure '(LH)M (E)H (J)L (I)J (E)I' E..M --ancestry-path --simplify-merges -- file # includes G
 
 # Should still be able to ignore I-J branch in simple log, despite limiting
 # to G.
 check_result 'M L K J I H' G..M
 check_result 'M H L K J I' G..M --topo-order
 check_outcome failure 'M L H' G..M -- file # includes J I
-check_outcome failure 'M L H' G..M --parents -- file # includes J I
+check_outcome failure '(LH)M (G)L (G)H' G..M --parents -- file # includes J I
 check_result 'M L J I H' G..M --full-history -- file
 check_result 'M L K J I H' G..M --full-history --parents -- file
 check_result 'M H L J I' G..M --simplify-merges -- file
@@ -162,10 +162,10 @@ check_result 'M H L J I' G..M --ancestry-path --simplify-merges -- file
 # we can't decide if the merge from INTERESTING commit C was sensible.
 check_result 'F D C' B..F
 check_result 'F' B..F -- file
-check_outcome failure 'F' B..F --parents -- file # includes D
+check_outcome failure '(B)F' B..F --parents -- file # includes D
 check_outcome failure 'F D' B..F --full-history -- file # drops D prematurely
-check_result 'F D' B..F --full-history --parents -- file
-check_result 'F' B..F --simplify-merges -- file
+check_result '(D)F (BA)D' B..F --full-history --parents -- file
+check_result '(B)F' B..F --simplify-merges -- file
 check_result 'F D' B..F --ancestry-path
 check_result 'F' B..F --ancestry-path -- file
 check_outcome failure 'F' B..F --ancestry-path --parents -- file # includes D
@@ -181,10 +181,10 @@ check_result 'F' E...F -- file
 # and it differs from it.
 check_result 'F D B' C..F
 check_result 'F B' C..F -- file
-check_result 'F B' C..F --parents -- file
+check_result '(B)F (A)B' C..F --parents -- file
 check_outcome failure 'F D B' C..F --full-history -- file # drops D
-check_result 'F D B' C..F --full-history --parents -- file
-check_result 'F D B' C..F --simplify-merges -- file
+check_result '(D)F (BC)D (A)B' C..F --full-history --parents -- file
+check_result '(D)F (BC)D (A)B' C..F --simplify-merges -- file
 check_result 'F D' C..F --ancestry-path
 check_outcome failure 'F D' C..F --ancestry-path -- file # drops D
 check_result 'F D' C..F --ancestry-path --parents -- file
-- 
1.8.3.rc0.28.g4b02ef5
