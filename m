Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FC161F403
	for <e@80x24.org>; Wed, 13 Jun 2018 23:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935982AbeFMXG0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 19:06:26 -0400
Received: from mail-oi0-f73.google.com ([209.85.218.73]:46531 "EHLO
        mail-oi0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935953AbeFMXGU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jun 2018 19:06:20 -0400
Received: by mail-oi0-f73.google.com with SMTP id j136-v6so2693453oih.13
        for <git@vger.kernel.org>; Wed, 13 Jun 2018 16:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=/xhhrYMm5TO84Z/gunr5ASMQYl1P3XqROyNINoURDLo=;
        b=nHs/qTKWi2F/Ih9r4K6dIcbCnoPsJiBYfhvly8LvSPPbyoqD09qvsUupo5nEOxScqP
         cpaQdjKCmM/E/X9fRLlMCWGvxWUBRx02EM8cCEJDCQ+2AZ0vHkQEW+GbupZ5dcHJ5SC7
         92S6DUBPeXbUiwn3furszSGzU/kcTlUV9M1je5rEiMB4RlIe6V6abYQ87ma1Bw2egfG3
         bvXKzRheoNX6hSWvc303pu4QVhaRYKuW9gZHoW52z/3QTUylIoV50t5x1gRZhg/AKnBM
         4BMN6l6Lfl78IuG7CVluMNddwdenTnLOiuWIyaHHq/OZU0oRPv7BtuEJTtWJxZGZCD5z
         ITpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=/xhhrYMm5TO84Z/gunr5ASMQYl1P3XqROyNINoURDLo=;
        b=jxaGm4G5PpBwA17gKAjF3xDE8+m2G0EebJifvl8rN3owexVmIMEJqkQYv8vHLhLcUy
         ktLFjOyQYLH2Hjx6E9c4eSHjj8Y3LDoPPz3FMB1+nVz4UwFbZUhvUbR3kcVwGCuIy+GO
         Odu5M6pBV+X5fP8hFCPBJVZ7cIghkV11+b0mM7+Y9Mpdxmlpkig7KIL9zuOfTVqAdrjW
         4q+WGwh5A923Hv7yKrhwZYcJI6ae3d+o5XTvq5vPenckMLcpjuu6qEqqkyXzGOz58hyL
         pCUhc/+5AhHe5kUszBLs2Qfwb26uAV2/OkvpKoL4r2OJFBUrnhWLeDWKea+98XPDUpu9
         5vww==
X-Gm-Message-State: APt69E0xt54ed5KAwomNAjHe4F71oEV8BU3G0Q8W3PUJm77/tQehw1UN
        m+6srYX2s/9b64Sb5wGZqs2wp8JqIHvgt9qbtzNKclXyVKUz+riGizNU/NWcXOZtvd1U3s0QlZ6
        nZeK4kGksOk/azqmUGPCBpkF0WONZiyUD8ToH8RQxIYa9CLQoXfl1mEvO+sPG
X-Google-Smtp-Source: ADUXVKL7Qw7xJTHzq17o6ryHgPt/H1QCX7D9SGH5+YvmEXl58vRbwxkLnL2pgL/4ApR/RuDcQGOWhWssSh6G
MIME-Version: 1.0
X-Received: by 2002:a9d:29a7:: with SMTP id n36-v6mr94626otb.20.1528931179395;
 Wed, 13 Jun 2018 16:06:19 -0700 (PDT)
Date:   Wed, 13 Jun 2018 16:05:10 -0700
In-Reply-To: <20180613230522.55335-1-sbeller@google.com>
Message-Id: <20180613230522.55335-20-sbeller@google.com>
References: <20180530004810.30076-1-sbeller@google.com> <20180613230522.55335-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Subject: [PATCH v2 19/31] commit: allow lookup_commit to handle arbitrary repositories
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
 commit.c | 10 +++++-----
 commit.h |  3 +--
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/commit.c b/commit.c
index ede31c46931..4b10e7173b5 100644
--- a/commit.c
+++ b/commit.c
@@ -52,13 +52,13 @@ struct commit *lookup_commit_or_die(const struct object_id *oid, const char *ref
 	return c;
 }
 
-struct commit *lookup_commit_the_repository(const struct object_id *oid)
+struct commit *lookup_commit(struct repository *r, const struct object_id *oid)
 {
-	struct object *obj = lookup_object(the_repository, oid->hash);
+	struct object *obj = lookup_object(r, oid->hash);
 	if (!obj)
-		return create_object(the_repository, oid->hash,
-				     alloc_commit_node(the_repository));
-	return object_as_type(the_repository, obj, OBJ_COMMIT, 0);
+		return create_object(r, oid->hash,
+				     alloc_commit_node(r));
+	return object_as_type(r, obj, OBJ_COMMIT, 0);
 }
 
 struct commit *lookup_commit_reference_by_name(const char *name)
diff --git a/commit.h b/commit.h
index 66eb576897f..d4561587851 100644
--- a/commit.h
+++ b/commit.h
@@ -53,8 +53,7 @@ enum decoration_type {
 void add_name_decoration(enum decoration_type type, const char *name, struct object *obj);
 const struct name_decoration *get_name_decoration(const struct object *obj);
 
-#define lookup_commit(r, o) lookup_commit_##r(o)
-struct commit *lookup_commit_the_repository(const struct object_id *oid);
+struct commit *lookup_commit(struct repository *r, const struct object_id *oid);
 #define lookup_commit_reference(r, o) \
 		lookup_commit_reference_##r(o)
 struct commit *lookup_commit_reference_the_repository(const struct object_id *oid);
-- 
2.18.0.rc1.244.gcf134e6275-goog

