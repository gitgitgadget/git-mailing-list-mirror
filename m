Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2038200B9
	for <e@80x24.org>; Mon,  7 May 2018 23:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753406AbeEGXAT (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 19:00:19 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:39364 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753149AbeEGW7j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 18:59:39 -0400
Received: by mail-pf0-f195.google.com with SMTP id a22so8897450pfn.6
        for <git@vger.kernel.org>; Mon, 07 May 2018 15:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ysfPI2H13Ps7vdzmU6c9CMqsUxslBVl2viPJvzaPEmw=;
        b=JlwYJojpc5MH9Ga2fufz8eWRQiGlG1tm7Vt3MpELfadm6rqn0JyH4s/nZoazZ2vj1n
         c0YXjELLZTpZjH8j2Ss7h7kUbXAX9yQl8U/N09ZLyIynuoQtPKQ7+1JwEsHOHbvTqxNJ
         yziKPyST/KmbW6HogaTR/q4doDMFCJSr858M3kaijMevcQqRMmghqEMxazpE6eay3V0J
         MRW9RW0u2CTWQ1+482ur9gfM2Y6C0jChhNL6Raqh+Indn8CM2CWHSSUYZOTlwwoZngyq
         50yg8V4md/49mnWfvBfrTO0R2YDP0di8BQWoqpxHjHWiK0dgO8Gj8WMTLZwb4HxcnYdZ
         rcXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ysfPI2H13Ps7vdzmU6c9CMqsUxslBVl2viPJvzaPEmw=;
        b=NaT5CkDx+H8iGD72iNDXLJRXJf+9Oh5xTtaUTusJM43Eql1vL2b7yOGNkHlV3r2MCt
         9CwGevJNBwYjYfyDdMVz3B44REWbDjDKCpfbU9la6co10LbCYH6NJdslH7NEf7llLNr5
         SHDfTtZn+QcMfAYpmrI9Yjl4Yh1L1dAWMqOXIQbY/qaRyCY8LllyQTLEA3e2M32X8sxi
         vpzkpoi4tFqjbgnukbLK3Sca/RnTrN+I9GOmiA20yCXkUBYl3Lklj9wshygk49RbHMDH
         7GAy0vFHfUF2IxHrbKLycbH4tcPZ4IoeDo/e1IOgy8G5nKGKYeB1Nd1WPOWfmCmhzvu+
         16iQ==
X-Gm-Message-State: ALQs6tA351oirb4dp9wANQ+xeFTrI8Zja03eGTzhgl90GVTu7QLt0YLl
        haPtm9o7paTn2BRc9iQO6VFUhGvlO0k=
X-Google-Smtp-Source: AB8JxZqNK9WvmGbMkb00Qq2NPSixK0tBKkgsLQ/RYeYyYnqfNusQtqpQb0crD6fcB1SKRIoYqKRwQA==
X-Received: by 2002:a63:9314:: with SMTP id b20-v6mr30988855pge.309.1525733978274;
        Mon, 07 May 2018 15:59:38 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id a5sm50695855pff.8.2018.05.07.15.59.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 May 2018 15:59:37 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, jonathantanmy@google.com, gitster@pobox.com,
        jamill@microsoft.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 09/13] alloc: add repository argument to alloc_report
Date:   Mon,  7 May 2018 15:59:12 -0700
Message-Id: <20180507225916.155236-10-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.255.g8bfb7c0704
In-Reply-To: <20180507225916.155236-1-sbeller@google.com>
References: <20180501213403.14643-1-sbeller@google.com>
 <20180507225916.155236-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a small mechanical change; it doesn't change the
implementation to handle repositories other than the_repository yet.
Use a macro to catch callers passing a repository other than
the_repository at compile time.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 alloc.c | 2 +-
 cache.h | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/alloc.c b/alloc.c
index f031ce422d9..28b85b22144 100644
--- a/alloc.c
+++ b/alloc.c
@@ -105,7 +105,7 @@ static void report(const char *name, unsigned int count, size_t size)
 #define REPORT(name, type)	\
     report(#name, name##_state.count, name##_state.count * sizeof(type) >> 10)
 
-void alloc_report(void)
+void alloc_report_the_repository(void)
 {
 	REPORT(blob, struct blob);
 	REPORT(tree, struct tree);
diff --git a/cache.h b/cache.h
index 2d60359a964..01cc207d218 100644
--- a/cache.h
+++ b/cache.h
@@ -1774,7 +1774,8 @@ extern void *alloc_commit_node_the_repository(void);
 extern void *alloc_tag_node_the_repository(void);
 #define alloc_object_node(r) alloc_object_node_##r()
 extern void *alloc_object_node_the_repository(void);
-extern void alloc_report(void);
+#define alloc_report(r) alloc_report_##r()
+extern void alloc_report_the_repository(void);
 extern unsigned int alloc_commit_index(void);
 
 /* pkt-line.c */
-- 
2.17.0.255.g8bfb7c0704

