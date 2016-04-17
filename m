From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 2/6] test-match-trees: convert to use struct object_id
Date: Sun, 17 Apr 2016 23:10:37 +0000
Message-ID: <1460934641-435791-3-git-send-email-sandals@crustytoothpaste.net>
References: <1460934641-435791-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 04:20:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arynS-0004Cg-Pf
	for gcvg-git-2@plane.gmane.org; Mon, 18 Apr 2016 04:20:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751428AbcDRCUB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Apr 2016 22:20:01 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:52826 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750860AbcDRCUA (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2016 22:20:00 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 6A559282AD;
	Sun, 17 Apr 2016 23:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1460934674;
	bh=nrpgKZJbqVdv+3FRw2zwifkDShw2UmYthC7yLtGNLQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nbO217/0snWCUraz1E9fTTUY4A5DMovyqI8ssGVEr0uyHcV5/Fytbj1W5IlYSbc0w
	 yPAlfKAPCagqqKRPYOv6FHs6v3iN1aKz+4KeatD//q7++mB33uP3qsgF9ELkmKkI0+
	 lqE5exu+hFw11KzzXtuAReTSCPXrlm27Btgyjs/9hv70vTeD8io52Q3iYoTbf10OZ5
	 hGuQjdVjWPmiUpQr8ix+iijQVsM2E6eXuAvANs+8RAnwZRQfEYdd6EqlMObMIyebLM
	 mbWhfX/ucO8czR8knf/5Mg40cCPuRgccbxAHry+robDutcH2UUa/l4rMhIZ+BejMJh
	 +6A0cX3B9xM6nPe5MenPrwtUSEmx8IxY3uUudlqJULmWq5J3TKZKgYAfyPOcU0FU4u
	 ak+6SzV2BqH73sKhWl0YhRssa0uXl8SKalt2CFjqFVfsygm+SaC26I4Hvw6QnyKyEZ
	 oDO0TcRe38KaZ5El3a7ZnHtM6h87WgLU8l16fDxuOMycABcgw5x
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1460934641-435791-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -0.262 BAYES_00,RDNS_NONE,T_DKIM_INVALID
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291790>

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 test-match-trees.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/test-match-trees.c b/test-match-trees.c
index 4dad7095..41aff841 100644
--- a/test-match-trees.c
+++ b/test-match-trees.c
@@ -3,24 +3,24 @@
 
 int main(int ac, char **av)
 {
-	unsigned char hash1[20], hash2[20], shifted[20];
+	struct object_id hash1, hash2, shifted;
 	struct tree *one, *two;
 
 	setup_git_directory();
 
-	if (get_sha1(av[1], hash1))
+	if (get_oid(av[1], &hash1))
 		die("cannot parse %s as an object name", av[1]);
-	if (get_sha1(av[2], hash2))
+	if (get_oid(av[2], &hash2))
 		die("cannot parse %s as an object name", av[2]);
-	one = parse_tree_indirect(hash1);
+	one = parse_tree_indirect(hash1.hash);
 	if (!one)
 		die("not a tree-ish %s", av[1]);
-	two = parse_tree_indirect(hash2);
+	two = parse_tree_indirect(hash2.hash);
 	if (!two)
 		die("not a tree-ish %s", av[2]);
 
-	shift_tree(one->object.oid.hash, two->object.oid.hash, shifted, -1);
-	printf("shifted: %s\n", sha1_to_hex(shifted));
+	shift_tree(one->object.oid.hash, two->object.oid.hash, shifted.hash, -1);
+	printf("shifted: %s\n", oid_to_hex(&shifted));
 
 	exit(0);
 }
-- 
2.8.0.rc3.226.g39d4020
