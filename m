Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B85C1F42D
	for <e@80x24.org>; Wed, 30 May 2018 00:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968587AbeE3AtU (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 20:49:20 -0400
Received: from mail-pl0-f52.google.com ([209.85.160.52]:45673 "EHLO
        mail-pl0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968516AbeE3Asx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 20:48:53 -0400
Received: by mail-pl0-f52.google.com with SMTP id bi12-v6so9954386plb.12
        for <git@vger.kernel.org>; Tue, 29 May 2018 17:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qH1u7NpMQc319e2YPpn/IPQE7B3zj01C5oq28xH8gOQ=;
        b=e4dSsQBAmfEtyx8Qlged9tDnDls15GNGGz5xu8YtAdmgvjc7lW90YVES2Sg6mcI55i
         xJqwbiFsMcSFQn7aC3v9pbhv39uQqWb74IR/OiFfl3hLuRUEgwgY4lQjZVsOXBLIUed+
         n82fK38eDWlzi0bwnyg4r2zhy8H85cuOoMVUx5wMtVMcWkTk9tld9EN0ute4X6Yfz9tE
         UQTi6T56Aq6/tzrOWmDo0nQeKRHaRC0dPsFwYTE9gKgcLjZA1nv7jmpAAiTrfD1pUhb9
         RwWgPZtQG/3R2VpCRJrsTyPXQwFIPxbH8lHmOubeLnSAOUHhfYnPe/0URTvC2HlEfQ+A
         p4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qH1u7NpMQc319e2YPpn/IPQE7B3zj01C5oq28xH8gOQ=;
        b=SI/AziurZMbP/+uEmVze28L60mO3Y0wds9DRK1hgCx2W/mvXlpZ3odTJe7tDA+gOaQ
         DswMKLrmaw4Olwgzj/ebCLgQfPWO0ncd8Ql8+AOTFdip+t6NfUi26BCSu0S3r7CaEiL5
         J2Evy3movcSB+QjyRLIChRceJ+si2t3x0aSdbzPAlRlpMJjgGUhbs7oOtF6I7MjvhHDY
         Zj0OBpCd65wnRECs3YXG6BHa7aYhq2uRnBsbkizKZNe6wLohrmhebDb7Pjhxn2HT7dLn
         tziKh0tFfWegex77n8SsxdS8moVi3e9iEyDRLEIQeQu+9gFo/0EhqgUZzf+L+13GDAdn
         1l8Q==
X-Gm-Message-State: ALKqPwdjlF0s9JKusPUdrfHjNoqhCBaGDnGiBT6PS7HrlvFhtYuiCeMA
        /Z1i76vIxs9VBcal5GXDmiA89uEyWik=
X-Google-Smtp-Source: ADUXVKKErKumc2SPvPJEhnYKW/41hkiMlZNZ9mhQtqOyL3LFS/yVU4eECl7iJ0Ncj52RfXgttcvJww==
X-Received: by 2002:a17:902:ba93:: with SMTP id k19-v6mr577973pls.379.1527641332069;
        Tue, 29 May 2018 17:48:52 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id u16-v6sm68958858pfl.39.2018.05.29.17.48.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 May 2018 17:48:51 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 21/35] blob: allow lookup_blob to handle arbitrary repositories
Date:   Tue, 29 May 2018 17:47:56 -0700
Message-Id: <20180530004810.30076-22-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180530004810.30076-1-sbeller@google.com>
References: <20180530004810.30076-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 blob.c | 10 +++++-----
 blob.h |  3 +--
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/blob.c b/blob.c
index 17b9314f0a0..342bdbb1bbe 100644
--- a/blob.c
+++ b/blob.c
@@ -5,13 +5,13 @@
 
 const char *blob_type = "blob";
 
-struct blob *lookup_blob_the_repository(const struct object_id *oid)
+struct blob *lookup_blob(struct repository *r, const struct object_id *oid)
 {
-	struct object *obj = lookup_object(the_repository, oid->hash);
+	struct object *obj = lookup_object(r, oid->hash);
 	if (!obj)
-		return create_object(the_repository, oid->hash,
-				     alloc_blob_node(the_repository));
-	return object_as_type(the_repository, obj, OBJ_BLOB, 0);
+		return create_object(r, oid->hash,
+				     alloc_blob_node(r));
+	return object_as_type(r, obj, OBJ_BLOB, 0);
 }
 
 int parse_blob_buffer(struct blob *item, void *buffer, unsigned long size)
diff --git a/blob.h b/blob.h
index 08bc34487a0..16648720557 100644
--- a/blob.h
+++ b/blob.h
@@ -9,8 +9,7 @@ struct blob {
 	struct object object;
 };
 
-#define lookup_blob(r, o) lookup_blob_##r(o)
-struct blob *lookup_blob_the_repository(const struct object_id *oid);
+struct blob *lookup_blob(struct repository *r, const struct object_id *oid);
 
 int parse_blob_buffer(struct blob *item, void *buffer, unsigned long size);
 
-- 
2.17.0.582.gccdcbd54c44.dirty

