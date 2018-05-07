Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75E05200B9
	for <e@80x24.org>; Mon,  7 May 2018 22:59:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753263AbeEGW7k (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 18:59:40 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:35793 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753051AbeEGW7i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 18:59:38 -0400
Received: by mail-pl0-f65.google.com with SMTP id i5-v6so1011876plt.2
        for <git@vger.kernel.org>; Mon, 07 May 2018 15:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qlOsWcCCDQpEPUNYVYs+Aaqb2R1bF5fO2T7Efe1f7XA=;
        b=fOXAgwT6oYqHik+KSPLfcAQrMB0qagoiLEs5C8kEI9i4Q1dbznKY15Vj2rJCuYP8zo
         NE8y/4Ti60a6KIma9DcQR7e+rNz9fX+GXHAWoObEpDYokTHMyjJAz1J3L428K59u8hdY
         3Di4UXi0UbmEBDhWptV3ueWG6PYFSmNfLw+4G/u3rNcvRR7zlj3OIYl5QKkUWsM6rdVV
         Kypnb9WMeTwgLGch725TekbBAZY1YwLvCQOYEDZnRf3mMh2jWJutRF83QFGFrm0CkBZv
         PTNLOVjuChN/sILSqgyNLkkq2sN5FKMW6dQ8SBITIABpdkU/fshY/S8gTGzgroX60BUV
         AYQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qlOsWcCCDQpEPUNYVYs+Aaqb2R1bF5fO2T7Efe1f7XA=;
        b=nGJtxxcDLKg6sm6cXGmkdvx1vYELmOLwF14zqSfl1UJYK/Ve+4DSPP6LkbFLe7SaVt
         OdVcdYRHFyKieOKgK7LHpBFsbh80pPGydkfHqbiZ19947dbWVLKpSUTgVPFhy36eupN/
         ++vFUsWFSTRmHQkBPyGRcPSUyfi+iukDtfU4YoMQoe2JM4p4Hlo/dHV8ba1BzDNKFdeK
         yPYGS0ecKqJCcNM/6h4cRm/TmsfGinEQpsr9gcCW559qUfldfoMM43ihbCTgl0GM5+q8
         WYz/hzLQ4TrzhMrOC9Bpalr30MJ4GWa7rVos0L9EBHnbvM2VeTCU1IBqFznfnBMNLMLl
         9EWA==
X-Gm-Message-State: ALQs6tCPkLE8AmSxArwI0hFm7zP0gQGy7Um02dGPatJp+sttTzn811a/
        eXaHLwznRi9g+QB1Ni5am1JSpkOIka8=
X-Google-Smtp-Source: AB8JxZqkkJXBLOq/o0jrelPhaqLSfzt80ssqQOlMp/ml8oWmP4wftJ3x0/qzcGzXq9wBGYKWBdwomQ==
X-Received: by 2002:a17:902:64d0:: with SMTP id y16-v6mr38463138pli.349.1525733976825;
        Mon, 07 May 2018 15:59:36 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id k84sm44682832pfh.93.2018.05.07.15.59.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 May 2018 15:59:36 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, jonathantanmy@google.com, gitster@pobox.com,
        jamill@microsoft.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 08/13] alloc: add repository argument to alloc_object_node
Date:   Mon,  7 May 2018 15:59:11 -0700
Message-Id: <20180507225916.155236-9-sbeller@google.com>
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
 alloc.c  | 2 +-
 cache.h  | 3 ++-
 object.c | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/alloc.c b/alloc.c
index 290250e3595..f031ce422d9 100644
--- a/alloc.c
+++ b/alloc.c
@@ -73,7 +73,7 @@ void *alloc_tag_node_the_repository(void)
 }
 
 static struct alloc_state object_state;
-void *alloc_object_node(void)
+void *alloc_object_node_the_repository(void)
 {
 	struct object *obj = alloc_node(&object_state, sizeof(union any_object));
 	obj->type = OBJ_NONE;
diff --git a/cache.h b/cache.h
index 32f340cde59..2d60359a964 100644
--- a/cache.h
+++ b/cache.h
@@ -1772,7 +1772,8 @@ extern void *alloc_tree_node_the_repository(void);
 extern void *alloc_commit_node_the_repository(void);
 #define alloc_tag_node(r) alloc_tag_node_##r()
 extern void *alloc_tag_node_the_repository(void);
-extern void *alloc_object_node(void);
+#define alloc_object_node(r) alloc_object_node_##r()
+extern void *alloc_object_node_the_repository(void);
 extern void alloc_report(void);
 extern unsigned int alloc_commit_index(void);
 
diff --git a/object.c b/object.c
index 91edc30770c..b8c3f923c51 100644
--- a/object.c
+++ b/object.c
@@ -180,7 +180,7 @@ struct object *lookup_unknown_object(const unsigned char *sha1)
 	struct object *obj = lookup_object(sha1);
 	if (!obj)
 		obj = create_object(the_repository, sha1,
-				    alloc_object_node());
+				    alloc_object_node(the_repository));
 	return obj;
 }
 
-- 
2.17.0.255.g8bfb7c0704

