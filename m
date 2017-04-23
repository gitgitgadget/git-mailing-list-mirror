Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1B9C207BD
	for <e@80x24.org>; Sun, 23 Apr 2017 21:36:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1046191AbdDWVgd (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Apr 2017 17:36:33 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:37462 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1046109AbdDWVfj (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 23 Apr 2017 17:35:39 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id CD138280C1;
        Sun, 23 Apr 2017 21:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1492983333;
        bh=PIZ3gx1aHRaCQtcuwuk6Ye15UOP7JE01YzTgp9gB5XI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T4fSrJQ2Gogoki1NGWNBQHi65qaDapb52BK4NndwukCCnyg6H4G6zi+u4dmrFqdSj
         6IoNi60eNbaJiVkfgmASPMUHR8sTFwF46cgUl18qo4WEukAKcTTU6DE4pcgDzP0Z8Q
         Er0YpRhrGPdzIlWsIeskmB8/iZTugzuXNrJaMc60xjlAsDsRAqxj2EF1bgi8p8walw
         shpLPmjXv1NJiIaKAx6zUJLvDF3OnqjhYPC21JU66qPu86lrSTsJPbCv2DpXJ00jFN
         uiTb2Q2Lohz1vne1SdnuNbauQ/+FCxGGs6KY0VSHiGNLo/LO0VNr6cUfMkMx2JrUXE
         XMaVB1YJJHDOJ6PjOJ2eAdG12ngRPcQliydfh7qay/gN8iWfSIuWB/v1upAlvV7luQ
         71cg7xApQxmu4rgw9MGwHUUMXStJjssOEiIz1C5t6LfqhW2tc9NqkJsY8UzY+AgF7Y
         EkNG+D5Jk/1knpwPy90qU6HQCB6WbybT/I1UgfUCEqoDnwYL7M2
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 20/53] revision: convert prepare_show_merge to struct object_id
Date:   Sun, 23 Apr 2017 21:34:20 +0000
Message-Id: <20170423213453.253425-21-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.12.2.762.g0e3151a226
In-Reply-To: <20170423213453.253425-1-sandals@crustytoothpaste.net>
References: <20170423213453.253425-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a caller of lookup_commit_or_die, which we will convert later
on.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 revision.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/revision.c b/revision.c
index 2b56c3baf..945367034 100644
--- a/revision.c
+++ b/revision.c
@@ -1389,16 +1389,16 @@ static void prepare_show_merge(struct rev_info *revs)
 {
 	struct commit_list *bases;
 	struct commit *head, *other;
-	unsigned char sha1[20];
+	struct object_id oid;
 	const char **prune = NULL;
 	int i, prune_num = 1; /* counting terminating NULL */
 
-	if (get_sha1("HEAD", sha1))
+	if (get_oid("HEAD", &oid))
 		die("--merge without HEAD?");
-	head = lookup_commit_or_die(sha1, "HEAD");
-	if (get_sha1("MERGE_HEAD", sha1))
+	head = lookup_commit_or_die(oid.hash, "HEAD");
+	if (get_oid("MERGE_HEAD", &oid))
 		die("--merge without MERGE_HEAD?");
-	other = lookup_commit_or_die(sha1, "MERGE_HEAD");
+	other = lookup_commit_or_die(oid.hash, "MERGE_HEAD");
 	add_pending_object(revs, &head->object, "HEAD");
 	add_pending_object(revs, &other->object, "MERGE_HEAD");
 	bases = get_merge_bases(head, other);
