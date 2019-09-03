Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF9EA1F461
	for <e@80x24.org>; Tue,  3 Sep 2019 19:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfICTmv (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Sep 2019 15:42:51 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:36583 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfICTmv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Sep 2019 15:42:51 -0400
Received: by mail-pf1-f201.google.com with SMTP id p16so14852798pfn.3
        for <git@vger.kernel.org>; Tue, 03 Sep 2019 12:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=HnQT/YZrOSCrU0QO3jvP97MI17cTZr5GEWFgXQULYa0=;
        b=vyKLPAAsgPI+G9f3NULDOY0YyywM0k0UvGMQFVTz4jNEM/uxJuRgalSLY84y8q+QA8
         Uy062YJYoGWkrJNxJRtEQKcTXF9ySIqpllzaxYbca4F4i0xdGZqGsrtTlPXUP1/ZBbwM
         Kl1zrFS4z04q4NyDTUZWZQs/aMsQ0Bd8rndttq+7OaLjHhh9YXgi65y+oNiIdoqELNic
         3E8L/MnMpIsv2AntWHBEelXseJcNVd3TaGexRIWAF/OxAbkYuQ3K//kleV31ddSfs9Ht
         Sb6EIWdy0zsHtKppQ2OiS+Vq7DwQnFs4gUbAUM1RDl2UyNYhbYF2msXo7KxpHZnAXL1y
         zZeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=HnQT/YZrOSCrU0QO3jvP97MI17cTZr5GEWFgXQULYa0=;
        b=Rbc9WhCHp5TCD5XjGGcssz4Hx4Kg8wsBEd4bDCuoividfkeeouZAFCk0oJLxgznDFY
         AG3ARINyh1PbKtJCkT+uDf9Vqj8tAqJl5efGdVUNYxjmBrxdVE/YKI4oKHKuyfVcZN3I
         KdMQeDMqe+x3ZBRVO5RnqspTk6Lko4CnHFyJgq+Hb5YZ2H1xI3efqNevX6TxrzzLRRIa
         bWox9negHsqJZVkaVIJkRddMrah56LDp1A3cGwHeVR2dHtCsywCLjaC9QiC8M1mRsPIK
         xiGM8jo1qudo2Dz/84Z5ozsdpbR1oRjJRWN6GxQeTdW5N/jG8YLxnIyUqLzDtoYdKWyX
         7cng==
X-Gm-Message-State: APjAAAVYZSD8srus6PLatEVRtolDglD67svYiANoMOQbgEOSRVk93hsi
        PDj2D7XF0gMf8bvyWUIW1do20MEehkns2bLHaPZBpCWkIWmoXFpl/79HTWpEOoHLi6IFyQqsD6t
        1XgIRmR5qMokEN8iUWTspheUmM2xkkQ7DFqJu76163sPthxR4wHozBfYM93aHlltP1z/e0p0l8O
        S1
X-Google-Smtp-Source: APXvYqwIdJ0Hof926I6IP8cY1XHwlS4a7TgtcPsVh3gsBGL2xAWE+/OO3FRYGGZQzr3NcbHHUr3xjFO8ahwQ2fLOYKVR
X-Received: by 2002:a63:f118:: with SMTP id f24mr32611089pgi.322.1567539770486;
 Tue, 03 Sep 2019 12:42:50 -0700 (PDT)
Date:   Tue,  3 Sep 2019 12:42:47 -0700
Message-Id: <20190903194247.217964-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH] cache-tree: do not lazy-fetch merge tree
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When cherry-picking (for example), new trees may be constructed. During
this process, Git checks whether these trees exist. However, in a
partial clone, this causes a lazy fetch to occur, which is both
unnecessary (because Git has already constructed this tree as part of
the cherry-picking process) and likely to fail (because the remote
probably doesn't have this tree).

Do not lazy fetch in this situation.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
Another partial clone bug.

This raises the issue that failed fetches are currently fatal - if they
weren't fatal, this cherry-pick would have worked (except with some
delay as the fetch is attempted, and with a warning message about the
fetch failing). My personal inclination right now is to leave things as
it is (fatal failed fetches), but I'm open to other opinions.
---
 cache-tree.c             |  2 +-
 t/t0410-partial-clone.sh | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/cache-tree.c b/cache-tree.c
index c22161f987..9e596893bc 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -407,7 +407,7 @@ static int update_one(struct cache_tree *it,
 	if (repair) {
 		struct object_id oid;
 		hash_object_file(buffer.buf, buffer.len, tree_type, &oid);
-		if (has_object_file(&oid))
+		if (has_object_file_with_flags(&oid, OBJECT_INFO_SKIP_FETCH_OBJECT))
 			oidcpy(&it->oid, &oid);
 		else
 			to_invalidate = 1;
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index 6415063980..3e434b6a81 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -492,6 +492,20 @@ test_expect_success 'gc stops traversal when a missing but promised object is re
 	! grep "$TREE_HASH" out
 '
 
+test_expect_success 'do not fetch when checking existence of tree we construct ourselves' '
+	rm -rf repo &&
+	test_create_repo repo &&
+	test_commit -C repo base &&
+	test_commit -C repo side1 &&
+	git -C repo checkout base &&
+	test_commit -C repo side2 &&
+
+	git -C repo config core.repositoryformatversion 1 &&
+	git -C repo config extensions.partialclone "arbitrary string" &&
+
+	git -C repo cherry-pick side1
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 
-- 
2.23.0.187.g17f5b7556c-goog

