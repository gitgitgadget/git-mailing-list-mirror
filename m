Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A5DEC43460
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 15:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02C31611AE
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 15:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234913AbhDJPXT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Apr 2021 11:23:19 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58538 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234900AbhDJPXR (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 10 Apr 2021 11:23:17 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 845876078E;
        Sat, 10 Apr 2021 15:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1618068152;
        bh=dXi2wylGHNDtBiHdzhCosvbWMltUqKnOmmXIwtCFai4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=TJFYDRe0o9ZvQL9vDovrAfpY7mfNAYJVXg284uPo6AiiHAG8m860cp8qxg54QD8oy
         7t1ZFQwyCvSAQ+8IqrPeJXqa8oLzvZvz37a/G6Bdbh1eBSu1JiAwq4puk7NWqDAFPx
         JW4p9pD0t727BUlMEfjkGkCkWjAhRrFfHkOolC6aMe+U5+UuoMLyxIwfKIavky01Ej
         zCWYn45U1Q14rCX0rs7mTDt2OJBmMXr0r1UuJKs35eSriIIc6b5aWfpqN4yQXDyIHR
         MDCAyQ9ABr/JntXZpAVEjyy6oyZb1cjdEtbF9OYmjXNz8eK9K92qPR5JY3OeHSON14
         Jg9IxRv/+/6QQ2ph6chrmU3+fAGpuP7RWy+CIE/je6nqMt9CAyLxdjup1vP9VaykrF
         DnFAGSVI+rOpeNnW4TRPjr2leydxUAsh4ICLDeagonMj+qzdB/fD5s3JzM1KsWLIcM
         O+LxQVTzhRkxT/cgBxutGIgh8pJXj/QzjFv6i3xDepWxpwlM7R+
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 03/15] cache: add an algo member to struct object_id
Date:   Sat, 10 Apr 2021 15:21:28 +0000
Message-Id: <20210410152140.3525040-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf
In-Reply-To: <20210410152140.3525040-1-sandals@crustytoothpaste.net>
References: <20210410152140.3525040-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that we're working with multiple hash algorithms in the same repo,
it's best if we label each object ID with its algorithm so we can
determine how to format a given object ID. Add a member called algo to
struct object_id.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 hash.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hash.h b/hash.h
index 3fb0c3d400..dafdcb3335 100644
--- a/hash.h
+++ b/hash.h
@@ -181,6 +181,7 @@ static inline int hash_algo_by_ptr(const struct git_hash_algo *p)
 
 struct object_id {
 	unsigned char hash[GIT_MAX_RAWSZ];
+	int algo;
 };
 
 #define the_hash_algo the_repository->hash_algo
