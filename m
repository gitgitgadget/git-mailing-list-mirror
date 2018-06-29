Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 914491F516
	for <e@80x24.org>; Fri, 29 Jun 2018 01:23:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030392AbeF2BXh (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 21:23:37 -0400
Received: from mail-yw0-f201.google.com ([209.85.161.201]:41023 "EHLO
        mail-yw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030243AbeF2BXd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 21:23:33 -0400
Received: by mail-yw0-f201.google.com with SMTP id e68-v6so6046257ywh.8
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 18:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=eSuhXUKHEE4K2Qn9KQswUwECvrnv1ZMkdNhFa6X3fac=;
        b=GLG3raYyXjpxdD5KvPTS76oMkwR9yMj9C/0eb5XzNbIw+cJ4Huv82t6OTsYPouWm9m
         BRwrL6XEXBwsgzhd0h6/hwo96TuvUK31Letd5LuwMdLYzYjSUTTEUq47iE5hYSRpTbzT
         nhBys+zLioLFqcVGg3fhB9pO4XOcCrRtXl6AYhXiS2Kfh/dA/Hxh4Mz6D74bAIiBEFoz
         Ory3zGqkGBgAc5nfmdMwG45r7aqkZpnt7zp3+Uq9qf6bZvRQBU/O+NC+H4hSCMdeFhHB
         xjAfLkG7QKF1cc4Wnk/vNVD8r5A4+7a7+QqIf2mXM4aY2M83fHSGw4PE6UyOUz5qNeOH
         oBgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=eSuhXUKHEE4K2Qn9KQswUwECvrnv1ZMkdNhFa6X3fac=;
        b=C9G6csemtZPZVP29M/mq+s0MEKVX+jBI68HRMYZwzbA3P4HtC8o0R4O1yNsmBly4u9
         t/Ix6Ok8ITl6cGEAX3PlvHs/jep7C0UjKyeKOP2D7AIGw5hOcOxz4t0n29foRjKD1Spg
         17PrxeefQi3Y0b2RnMTQEKBlgMIa20WBqFNQhX/EfPjKE1RyBdxz4jZD30mIBHGZeHZj
         /aTUOXZYFbub95DjdgYyx5ayiOgKktsp66wiIM7hTilkn3GDK6oNU0dMh5F9DJ+WBEOe
         DHNTf6gwivx1w8FTJbC7K3laT9vEgUef/PqyEgSnsJ6gK9J7ATg9Et/vowqSF7VfbF33
         3cwQ==
X-Gm-Message-State: APt69E38Kv2XcLX33Tf1J9TNAa6l/OzxB8kc8TZtJAsnJiDy/Hrv6SN9
        S3tsxfjXtpCKi4DpKdQ6zJSEd3YRLmT/YgVzLPDzXjIXH+9lUQ+UsELH2BXBtfD8ZDETsA2chL0
        sVNL7CTBkWwVo6Bgrw7oYzxnQiqLLzaJiakCf+AQJs2Xi8Iua8xfk2hPXZIBh
X-Google-Smtp-Source: AAOMgpcYRuLbgLN1Dmhs1GutNnBQ9elygf/CX0DHDZTrhXYHkvtxkKheAC6BFEg28j3HCkhpIuf2Emw0eKiZ
MIME-Version: 1.0
X-Received: by 2002:a81:2407:: with SMTP id k7-v6mr2044013ywk.183.1530235412267;
 Thu, 28 Jun 2018 18:23:32 -0700 (PDT)
Date:   Thu, 28 Jun 2018 18:22:16 -0700
In-Reply-To: <20180629012222.167426-1-sbeller@google.com>
Message-Id: <20180629012222.167426-27-sbeller@google.com>
References: <20180629012222.167426-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1-goog
Subject: [PATCH v3 26/32] commit.c: allow set_commit_buffer to handle
 arbitrary repositories
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
 commit.c | 4 ++--
 commit.h | 3 +--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/commit.c b/commit.c
index 1baac77861f..dd8c9c15b14 100644
--- a/commit.c
+++ b/commit.c
@@ -275,10 +275,10 @@ void free_commit_buffer_slab(struct buffer_slab *bs)
 	free(bs);
 }
 
-void set_commit_buffer_the_repository(struct commit *commit, void *buffer, unsigned long size)
+void set_commit_buffer(struct repository *r, struct commit *commit, void *buffer, unsigned long size)
 {
 	struct commit_buffer *v = buffer_slab_at(
-		the_repository->parsed_objects->buffer_slab, commit);
+		r->parsed_objects->buffer_slab, commit);
 	v->buffer = buffer;
 	v->size = size;
 }
diff --git a/commit.h b/commit.h
index bea5e015b28..7297af467b9 100644
--- a/commit.h
+++ b/commit.h
@@ -97,8 +97,7 @@ void free_commit_buffer_slab(struct buffer_slab *bs);
  * Associate an object buffer with the commit. The ownership of the
  * memory is handed over to the commit, and must be free()-able.
  */
-#define set_commit_buffer(r, c, b, s) set_commit_buffer_##r(c, b, s)
-void set_commit_buffer_the_repository(struct commit *, void *buffer, unsigned long size);
+void set_commit_buffer(struct repository *r, struct commit *, void *buffer, unsigned long size);
 
 /*
  * Get any cached object buffer associated with the commit. Returns NULL
-- 
2.18.0.399.gad0ab374a1-goog

