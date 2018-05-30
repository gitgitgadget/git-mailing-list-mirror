Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 217611F42D
	for <e@80x24.org>; Wed, 30 May 2018 00:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968452AbeE3At5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 20:49:57 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:35818 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968560AbeE3AtB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 20:49:01 -0400
Received: by mail-pf0-f169.google.com with SMTP id x9-v6so8102936pfm.2
        for <git@vger.kernel.org>; Tue, 29 May 2018 17:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JJEPeSu9ZHCXZNjYvV8lVwaS7SuYWY4c2JkS1zLQOgM=;
        b=R9w0eDQd5dvCjEARuKRaSJQlOJfRZkobcpAnGXSwQ8QE7cgqJXlFvaAHlm0UTO0P9r
         FOyHUb7Fj7C8JG8C9mhg1hY6Tsw71ZviaM4v/26ElVe2heR5VS/CR6wfG2F/DHcFMqas
         67zLou4Zg23gw/E7bN2MZh4yE6ttVYDk/OrcrTvPNJVWswimOn6dS+3iw96sVZE1JJ6Y
         X9yT5bg2MnceMeqSURX3XzYNSgT7tgzHe5SlkMh7bKHJUXY+ZiPnpQPwa7RtwpsTsgqx
         JsiKHIPwWVYmEAVMigDYuvBD0vg0Hd5igdJkDxdEKalJ6vKcue8JyAuqJVbFAbjGm7FB
         zcYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JJEPeSu9ZHCXZNjYvV8lVwaS7SuYWY4c2JkS1zLQOgM=;
        b=Hj5O8+HY/IhhfPCD6CE/XzcS+3Gr8jP6/of076x1lJR0S/jamTEpgVQqIv10erGayE
         fudeMj3rumMpArZCdFcolZRuRZdOKaeLwYI7ZxcFMaqEgwEio2nZuwNvNN+tt3zvsgjn
         EzdAFKKtfh2ncyBUH6BExSEtVKzDLRhvz9PgvOAQYNo4t0hgkoy4x+3GGkP+LceM8knl
         10alWrU/I605LkfkaeCvQjCSQ0wdYks44lIF5JRu82wxr+Ge4c/b00wfXIxMbyNPHCqK
         XGuhKGr73HF6A2UfYMSpvikTqXcrYv+fV+VScQzakJd0AoBgYhYvn5M5m7p4n+6asiOS
         HQpA==
X-Gm-Message-State: ALKqPwe36YMIRxd1NlgPjsg7aFCZs55j8L4DS7Axys0SUjqpqPdnRuiY
        TM+J1jtk6ZlHD1IIdzIdvYfuCLr6cNk=
X-Google-Smtp-Source: ADUXVKIEI7cHupEJvK7yY9hX8XgTRmLcxYN3JOQNStloLiGUwUDjK1d0rf3PzlCQ5w8VlgWj9qfvWA==
X-Received: by 2002:a65:590d:: with SMTP id f13-v6mr467806pgu.313.1527641340331;
        Tue, 29 May 2018 17:49:00 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id x3-v6sm12074586pfm.2.2018.05.29.17.48.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 May 2018 17:48:59 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 27/35] commit-slabs: remove realloc counter outside of slab struct
Date:   Tue, 29 May 2018 17:48:02 -0700
Message-Id: <20180530004810.30076-28-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180530004810.30076-1-sbeller@google.com>
References: <20180530004810.30076-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The realloc counter is declared outside the struct for the given slabname,
which makes it harder for a follow up patch to move the declaration of the
struct around as then the counter variable would need special treatment.

As the reallocation counter is currently unused we can just remove it.
If we ever need to count the reallocations again, we can reintroduce
the counter as part of 'struct slabname' in commit-slab-decl.h.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 commit-slab-impl.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/commit-slab-impl.h b/commit-slab-impl.h
index 87a9cadfcca..ac1e6d409ad 100644
--- a/commit-slab-impl.h
+++ b/commit-slab-impl.h
@@ -11,8 +11,6 @@
 
 #define implement_commit_slab(slabname, elemtype, scope)		\
 									\
-static int stat_ ##slabname## realloc;					\
-									\
 scope void init_ ##slabname## _with_stride(struct slabname *s,		\
 						   unsigned stride)	\
 {									\
@@ -54,7 +52,6 @@ scope elemtype *slabname## _at_peek(struct slabname *s,			\
 		if (!add_if_missing)					\
 			return NULL;					\
 		REALLOC_ARRAY(s->slab, nth_slab + 1);			\
-		stat_ ##slabname## realloc++;				\
 		for (i = s->slab_count; i <= nth_slab; i++)		\
 			s->slab[i] = NULL;				\
 		s->slab_count = nth_slab + 1;				\
-- 
2.17.0.582.gccdcbd54c44.dirty

