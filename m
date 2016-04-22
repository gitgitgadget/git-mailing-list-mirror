From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 2/6] test-match-trees: convert to use struct object_id
Date: Fri, 22 Apr 2016 22:02:49 +0000
Message-ID: <20160422220253.839970-3-sandals@crustytoothpaste.net>
References: <20160422220253.839970-1-sandals@crustytoothpaste.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 23 00:03:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atjAl-0000rb-V4
	for gcvg-git-2@plane.gmane.org; Sat, 23 Apr 2016 00:03:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753213AbcDVWDd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 18:03:33 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:56124 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751690AbcDVWDW (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Apr 2016 18:03:22 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 6B405282AA;
	Fri, 22 Apr 2016 22:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1461362599;
	bh=F2QAwQHtV7h6dq61NOkmtYmiThEZtap/P3MvGBFd40s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BcNswLEepcWmLD6+oeRL2krcut58vPyde0S+kyTefWzfQZvv5lazRwKoFoAMCjoa7
	 lhaJ+cxVLjUfoY1tmvhrabOX1qbHnEL79ELTOKfrZJ9fDp6Cmeh0uazhflKbjaGuNc
	 X4LFMz/nrYCwDLJSWdI0E9ITpAWBylE96WPBWeEXWpYD7v2fMn7EzqvXxAZSEfiwgT
	 LFxKcxS9ZzgUcm5O8g+510BfkfKD9YXRMGiamCT/ZH9TANUqZnP48NigDO7MACEwT+
	 6slhMQrbyNfko2Lx7Pa0dYIdyMwLHGqAcTsqKIrg4WXrJmPTB2wtoh94N7t5ZeklbB
	 bUj7MlzmdUlujhCJJQf7z5zamsQO2gDL/Xe5wgFw1Q+eD+rCgf/iMhtQSPPLZMj684
	 7Z+pUOD5Xh0R++dxaMg9Syze3upjbXt72Kho+omvoaRZIAY8/NJJbb5PZ7iyhqVDaj
	 G1miTi0LWNZH6XRa7bkG7FKHyZvUb5Qstir+wJ/XQ9d+ntWMZ3W
X-Mailer: git-send-email 2.8.1.369.geae769a
In-Reply-To: <20160422220253.839970-1-sandals@crustytoothpaste.net>
X-Spam-Score: -0.262 BAYES_00,RDNS_NONE,T_DKIM_INVALID
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292278>

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
2.8.1.369.geae769a
