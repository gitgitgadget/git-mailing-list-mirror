Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F88F1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752327AbeBFA3j (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:29:39 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:42585 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752038AbeBFA3e (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:29:34 -0500
Received: by mail-pg0-f68.google.com with SMTP id m28so174932pgc.9
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PljHpDTiFk+wMfqdQbK+xwBFa51YgrqsXOsgpIyWHX4=;
        b=O3N6rNrNXWmwKIW6xQzCVy2IGDOGhM9LhrUZ5rrpTpEFroRzpqWEygtBzHDoVq59F/
         7GRam+iSdeP4h8r7zBOSLW4Xg80VIhU/D0KOG4EolD1FKncOJUwVe8HStTozFDomHgP9
         FQ6kbdTUjTk/aOzZ6oQ1XZA9ZBayyasCzL/4lDhLCcGd7WtODXLMjeczKt9tYf5fF/OI
         MxHK4+hP5G7Qtfsgy9kJO19WzjC1V9s/aCxMQrH0Mg0VoRB5Vg0SM+US96zbdeA/TDbD
         BvNmJz3wRR5uuCQrkKr65D2XXrrbQrbqhNwhe58/PdAJFJJiyE0T/sI/9aV9DuNuKIII
         ScXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PljHpDTiFk+wMfqdQbK+xwBFa51YgrqsXOsgpIyWHX4=;
        b=loPAWYSU6tY0YwU4fD8qNkX6hEeIs+nEHLxQVWQxq78rGGY70/75oyxnzimXnPbFP3
         sk1W/ofywuawY30kOF72Z8JwOgFd4pNcpefqLLp6Cmmf/+Txh8Lm6VUuffn28Swhgjc9
         AF0+ya/hY8Qzm6Lqr6wVv66wRRA00URZGVfYQ8ViciXtPxsKCxWyjp9TlSAXSDR7rmcX
         0yYPv0KS1+kkvf2FekUPUJFMtSOblSlGJLNeDID7mIW59HAokjLuLotCKLFGJBZL394v
         gJoguiPsutVjEXt5D7OPZ5nYGw8ulcNtRwPVw4qkr1bGla8h3uEK41AwZihBpeEai8zY
         LvPA==
X-Gm-Message-State: APf1xPBdORjL5LrgyUZzOWov98o91juIW0u178OcoXkF3XFO92ohA55L
        7uvGTJYT7Z1C0BGPf9xKtbhG2QW1Y0Q=
X-Google-Smtp-Source: AH8x225Ngx9OOHm9ojrQferAP8yxBXNl+WaV8aRDuRmBWbsWqeXxZ/tndrh32QD2wNnUJk76rGRIwg==
X-Received: by 10.99.149.8 with SMTP id p8mr444813pgd.186.1517876973895;
        Mon, 05 Feb 2018 16:29:33 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id n63sm15411155pgn.39.2018.02.05.16.29.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:29:33 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 173/194] blob: allow lookup_blob to handle arbitrary repositories
Date:   Mon,  5 Feb 2018 16:17:28 -0800
Message-Id: <20180206001749.218943-75-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180206001749.218943-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180206001749.218943-1-sbeller@google.com>
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
index 7c661f178a..5dcaf63697 100644
--- a/blob.c
+++ b/blob.c
@@ -4,13 +4,13 @@
 
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
index 08bc34487a..1664872055 100644
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
2.15.1.433.g936d1b9894.dirty

