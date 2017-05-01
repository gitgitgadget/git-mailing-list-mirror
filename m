Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84DD51F829
	for <e@80x24.org>; Mon,  1 May 2017 02:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2999584AbdEACbj (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Apr 2017 22:31:39 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:36046 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S642326AbdEACaq (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 30 Apr 2017 22:30:46 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 98F4A280AE;
        Mon,  1 May 2017 02:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1493605807;
        bh=PIZ3gx1aHRaCQtcuwuk6Ye15UOP7JE01YzTgp9gB5XI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0ncJOy8US+zCkiSZz13hwtUoMoI+1KG3M4uKjRVIZ9SbWRk3CWGTdi2F42AKcyCLB
         1ojSegMxDNXVnOFZYSDzOI6Mv0hrkzgPqrp535u236tAc7qgv4jx+9SaTX3NR7IWdI
         /i8GbtEIh+orBNwqohpmUhwE0btmjPzftBOQ37OP4tYLZ+7pDKng8zDyxRqO7kEJkd
         i6HdtKvXsnoxyLW1s17Zba52YbgSrzQOwDHbAFtM4ePL1bywll69tUOsnxNSZx4KtU
         xSMWhcxsTYfX+lJsvb3AU+WNjqfhpYuW1SH8z2Y8bisHjVvGGKFFSjOtz34+4yYzom
         pteDyar18V+AHYW4yPqeHgxUZezjwiPyCjIv1hfuOsbm0+iM52iPhIesBiWQKhCHfk
         ocqFYdiUeZah8zj6AjyudReOTPFJrtWJb11v/M0ewWgjIRVqQpXbMzD25hLzFpAs2c
         7J69iLxYzfesKBhij1JPQzo9qwdpl5g/miDqmHDiTsleAXcwqlI
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 20/53] revision: convert prepare_show_merge to struct object_id
Date:   Mon,  1 May 2017 02:29:13 +0000
Message-Id: <20170501022946.258735-21-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.13.0.rc0.306.g87b477812d
In-Reply-To: <20170501022946.258735-1-sandals@crustytoothpaste.net>
References: <20170501022946.258735-1-sandals@crustytoothpaste.net>
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
