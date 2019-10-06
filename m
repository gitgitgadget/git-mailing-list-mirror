Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 669FD1F4BE
	for <e@80x24.org>; Sun,  6 Oct 2019 23:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfJFXbN (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Oct 2019 19:31:13 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:39360 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbfJFXbN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Oct 2019 19:31:13 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id C8C401F4C8;
        Sun,  6 Oct 2019 23:30:45 +0000 (UTC)
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3 10/20] introduce container_of macro
Date:   Sun,  6 Oct 2019 23:30:33 +0000
Message-Id: <20191006233043.3516-11-e@80x24.org>
In-Reply-To: <20191006233043.3516-1-e@80x24.org>
References: <20191006233043.3516-1-e@80x24.org>
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

Later patches will use container_of() to remove the limitation
of "hashmap_entry" being location-dependent. This will complete
the transition to compile-time type checking for the hashmap API.

This macro already exists in our source as "list_entry" in
list.h and making "list_entry" an alias to "container_of"
as the Linux kernel has done is a possibility.

Signed-off-by: Eric Wong <e@80x24.org>
Reviewed-by: Derrick Stolee <stolee@gmail.com>
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
