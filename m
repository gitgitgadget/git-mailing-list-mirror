Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28C3F1F461
	for <e@80x24.org>; Mon, 26 Aug 2019 02:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729209AbfHZCoD (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Aug 2019 22:44:03 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:36474 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729030AbfHZCoD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Aug 2019 22:44:03 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 5C4101F4C1;
        Mon, 26 Aug 2019 02:43:34 +0000 (UTC)
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH 10/11] introduce container_of macro
Date:   Mon, 26 Aug 2019 02:43:31 +0000
Message-Id: <20190826024332.3403-11-e@80x24.org>
In-Reply-To: <20190826024332.3403-1-e@80x24.org>
References: <20190826024332.3403-1-e@80x24.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This macro is popular within the Linux kernel for supporting
intrusive data structures such as linked lists, red-black trees,
and chained hash tables while allowing the compiler to do
type checking.

I intend to use this to remove the limitation of "hashmap_entry"
being location-dependent and to allow more compile-time type
checking.

This macro already exists in our source as "list_entry" in
list.h and making "list_entry" an alias to "container_of"
as the Linux kernel has done is a possibility.

Signed-off-by: Eric Wong <e@80x24.org>
---
 git-compat-util.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index 83be89de0a..4cc2c8283a 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1312,4 +1312,14 @@ void unleak_memory(const void *ptr, size_t len);
  */
 #include "banned.h"
 
+/*
+ * container_of - Get the address of an object containing a field.
+ *
+ * @ptr: pointer to the field.
+ * @type: type of the object.
+ * @member: name of the field within the object.
+ */
+#define container_of(ptr, type, member) \
+	((type *) ((char *)(ptr) - offsetof(type, member)))
+
 #endif
-- 
EW

