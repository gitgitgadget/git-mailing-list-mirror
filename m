Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 068F61F406
	for <e@80x24.org>; Thu, 10 May 2018 19:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752018AbeEJT66 (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 15:58:58 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33722 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750762AbeEJT64 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 15:58:56 -0400
Received: by mail-pf0-f194.google.com with SMTP id f20-v6so1577919pfn.0
        for <git@vger.kernel.org>; Thu, 10 May 2018 12:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RCcXe4cBXZrMGvAoVIkTEua+Yb8WLmS/zMNIptUlRlI=;
        b=FnY179ropspZqqV4gEmYWfecq7kTIr6Zz14Bo1DEPhS2mXOF7kMufUwJzgh7WrpGJs
         9s800P4/xGRj0o+FZH+p1ws+6ZXEgJ35wgmqy7PwlgYEH10MHREIhKauPMLkU93YAQR+
         gmI9AzL0Iina9TiWec63UbtPoAPNL5G4l8bk4L5RT/wGaTJwdrLEHwrsgv3obrRd5YMR
         gmgAnlK5Y8wsRlKmsfFmwO3v8EsC6syORrB46ZvMdVu4OIGAT647nYs4XvvtKe51vKfX
         qygFUm36pn6k3deYf+mkFa7/onCFO/ER7qUpGbzKkch5Of8kBNEKVVIethOMOspfd2kX
         nt/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RCcXe4cBXZrMGvAoVIkTEua+Yb8WLmS/zMNIptUlRlI=;
        b=PB6SmPFEbp+IoeQRAGukQaZFGvQa+qyw0AuO9eBdigTIKCyl79zExXn0bVjJpGc0LB
         MfB/Xt2RTNxKXcVCgQr7hN4Z2/ucnsh+/lBKeQkU9pQ4nq09YNNlcNFKLaVAuDBD4P2m
         FCMmOoMIAjTX1urfm8VLnT81RAKPGR4YCOkdaQXJfJSpmDRwe5vNvA5RK/BIg1R/uVJv
         dIH9lT2IiPNGFywiJoLwC8ZZiZ0zhezsnFuNTqxRYkAHZFdZJ/3qDq0H9wYHi7vc4LZP
         TdIo8B/OH/2nIJu8FRsUF8GgnVs0DL3tQEfMR+ERIBT2EjsIfFBNNJxYxOEit0ZCf/oy
         CPUQ==
X-Gm-Message-State: ALKqPwfZpWsIF/EOc/6PbriEY82C1uhj8DUoyQHP2JWYO/XF8GO0OEjs
        QNwCCP28f/P8pE5qgZmx1uCAdA==
X-Google-Smtp-Source: AB8JxZpSXHC2Y0SD/pYIswospzWqvZAY1crLvfldj6Wh1AP/Hd0fpqG4Sqy9GSaB3qTAW0M7rhTknA==
X-Received: by 2002:a65:654a:: with SMTP id a10-v6mr2127323pgw.107.1525982336043;
        Thu, 10 May 2018 12:58:56 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id c87-v6sm5418987pfd.78.2018.05.10.12.58.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 May 2018 12:58:55 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, peff@peff.net
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 1/4] packfile: close and free packs upon releasing an object store
Date:   Thu, 10 May 2018 12:58:46 -0700
Message-Id: <20180510195849.28023-2-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.255.g8bfb7c0704
In-Reply-To: <20180510195849.28023-1-sbeller@google.com>
References: <20180510195849.28023-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In d0b59866223 (object-store: close all packs upon clearing the object
store, 2018-03-23), we made sure to close all packfiles on releasing
an object store, but we also have to free the memory of the closed packs.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Notes:
    > Should that INIT_LIST_HEAD get moved down into that function?
    
    done.
    
    > Probably the same applies to setting NULL here; you're left with a
    > dangling pointer if you just call close_and_free_packs(). Should
    > that helper maybe just be a static function in object.c?
    
    I just realize that
    
    	while (o->packed_git) {
    		...
    		o->packed_git = p->next;
    		...
    	}
    
    will make sure that o->packed_git is NULL afterwards,
    hence I removed the explicit set to NULL in object.c
    and we rely on the code in replace-object.c
    
    Thanks,
    Stefan

 object.c   |  4 +---
 packfile.c | 13 +++++++++++++
 packfile.h |  1 +
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/object.c b/object.c
index 66cffaf6e51..242d922d953 100644
--- a/object.c
+++ b/object.c
@@ -484,7 +484,5 @@ void raw_object_store_clear(struct raw_object_store *o)
 	free_alt_odbs(o);
 	o->alt_odb_tail = NULL;
 
-	INIT_LIST_HEAD(&o->packed_git_mru);
-	close_all_packs(o);
-	o->packed_git = NULL;
+	close_and_free_packs(o);
 }
diff --git a/packfile.c b/packfile.c
index 6c3ddc3c31d..7f2a9e28a2b 100644
--- a/packfile.c
+++ b/packfile.c
@@ -322,6 +322,19 @@ void close_all_packs(struct raw_object_store *o)
 			close_pack(p);
 }
 
+void close_and_free_packs(struct raw_object_store *o)
+{
+	close_all_packs(o);
+
+	INIT_LIST_HEAD(&o->packed_git_mru);
+
+	while (o->packed_git) {
+		struct packed_git *p = o->packed_git;
+		o->packed_git = p->next;
+		free(p);
+	}
+}
+
 /*
  * The LRU pack is the one with the oldest MRU window, preferring packs
  * with no used windows, or the oldest mtime if it has no windows allocated.
diff --git a/packfile.h b/packfile.h
index 9c2f8859945..cdab0557979 100644
--- a/packfile.h
+++ b/packfile.h
@@ -67,6 +67,7 @@ extern unsigned char *use_pack(struct packed_git *, struct pack_window **, off_t
 extern void close_pack_windows(struct packed_git *);
 extern void close_pack(struct packed_git *);
 extern void close_all_packs(struct raw_object_store *o);
+extern void close_and_free_packs(struct raw_object_store *o);
 extern void unuse_pack(struct pack_window **);
 extern void clear_delta_base_cache(void);
 extern struct packed_git *add_packed_git(const char *path, size_t path_len, int local);
-- 
2.17.0.255.g8bfb7c0704

