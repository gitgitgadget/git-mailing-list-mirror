Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC4A71F403
	for <e@80x24.org>; Wed, 13 Jun 2018 23:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935963AbeFMXGQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 19:06:16 -0400
Received: from mail-ua0-f202.google.com ([209.85.217.202]:34909 "EHLO
        mail-ua0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935953AbeFMXGP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jun 2018 19:06:15 -0400
Received: by mail-ua0-f202.google.com with SMTP id t18-v6so1352166uaj.2
        for <git@vger.kernel.org>; Wed, 13 Jun 2018 16:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=hqNnIYMoM/EwpPfFrOlQ92eTNnEpBqWVxyDFI1sllvY=;
        b=uuVyMRuT08wmrvppBWGcvsn8fyVmYoiz6SvOcEB4kRpAJkCrpr7hANNjwdHs+x7Dbi
         VgLnBf3s8QwwK8WayV+5jpHwG5uKHCA4rptcVYco7N6CR2YwO8WYWQwxz36+j05MpKrV
         zNUlZhNq0JqlkBuWsDT89s8yySgcUrIFpPJdHAVOp91K2zQ6oNKUghGYr65Yf43GDJxi
         kEbsup4Jh9rkTofPrB6TMRr0gQWThAc/fkH+vyAzTPvbe1PJ/LZtOKGRwQMYdkSwUOvS
         lC2XCoXx29xxj30dI0a6lCV6Gp+mrym2cMdj3+2B5azvWAj/M1rnVIuFLKC+djbIyJ8C
         DAUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=hqNnIYMoM/EwpPfFrOlQ92eTNnEpBqWVxyDFI1sllvY=;
        b=TATxokyFR/om/T9uBpa2OU371ilecUHF/mnU4EY3XSWwUdTQWss5hEXKETCJM8HOF2
         KUeNVZcpd8OSpVedl+z1TQP8VI7wR/mJpgmBlWGENE2G1NEbJJhPb1BNMzfsyY0cS1Rm
         ZVu/X1GclwvJ0yuj3S3wxHCTHIABF2/EYzPt0r3z7oHU6QQ7+aD8zMI6k3BaxLxDkUlb
         HX7dkH4D/QC+HBskR8LNeOhIKSSPd7Gag97w/3/gqrbpOxXGIrvLSAqySfEetGZFZTEO
         6hlKs+12d0K0stG8/pOY6S9I9kD9j2T8evrkG1bneM5IxlwF5ZCFBglZu/oTKAZXVXqQ
         88fA==
X-Gm-Message-State: APt69E0eE7fmIX5iRJp0/LeiH9yRA7+w2GZu0EyEXwLn1BjJqp4CJU2C
        ZS+rdsOzVdQBy5rhEbNVnDwTmILARMJaGEweUzfrlqsdLqB12Y4DSCh2lJbUQds2KKr/RXOxlyS
        Q7PSQeRCFWDVrh7o0aFrsxaUZ9kZ3g9xAOqPND5gQWNwfPSXhh679HvpRqn7s
X-Google-Smtp-Source: ADUXVKJx+tOm1DphHlZU3YHHbcLbyboXdGYaBmxACynyqmRQjfW/Xm/K57OwiRc0M0ZQGjtRDWXUZu5szCLb
MIME-Version: 1.0
X-Received: by 2002:a1f:8281:: with SMTP id e123-v6mr82451vkd.80.1528931174688;
 Wed, 13 Jun 2018 16:06:14 -0700 (PDT)
Date:   Wed, 13 Jun 2018 16:05:08 -0700
In-Reply-To: <20180613230522.55335-1-sbeller@google.com>
Message-Id: <20180613230522.55335-18-sbeller@google.com>
References: <20180530004810.30076-1-sbeller@google.com> <20180613230522.55335-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Subject: [PATCH v2 17/31] blob: allow lookup_blob to handle arbitrary repositories
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
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
2.18.0.rc1.244.gcf134e6275-goog

