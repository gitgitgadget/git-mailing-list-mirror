Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 224611F403
	for <e@80x24.org>; Wed, 13 Jun 2018 23:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936018AbeFMXGg (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 19:06:36 -0400
Received: from mail-ua0-f201.google.com ([209.85.217.201]:41050 "EHLO
        mail-ua0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935843AbeFMXGe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jun 2018 19:06:34 -0400
Received: by mail-ua0-f201.google.com with SMTP id j9-v6so1341805uan.8
        for <git@vger.kernel.org>; Wed, 13 Jun 2018 16:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=mmN26XHZkl5EyZrTBzadT33Dqvi6CmoPnj+0AFccpGI=;
        b=DrTdhDf0d2+nfw2ZkwONwymNvgHj93jlkCceZtW0xdoSBg0PcK6DdZqCa6d1Tw634U
         APzQw/+yWFzvvKcHp2Vn+FwdCjzoUFI2IPfSKNgViU9PY5u9DuJKzRj3ouckuZuMtGwB
         TR0vn5QGdX+B6ruQL34nJJhMwZnibRtH4bmqVScNvnTGIoyaIwJek7sgp0HzdLygSWm8
         mMvXMr3Q8sr27FP15c0Si7bLvdcklZ8uwwNOXWlGH9Knxn2p9of1ABCQA0yPLY2EAulQ
         NZEOvLdsNl03WWQ5Z61oz/MGabn1vI6OGfE+mII6XPi7RpA+XpqEjtDmPrtIOdeIj1z3
         L1ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=mmN26XHZkl5EyZrTBzadT33Dqvi6CmoPnj+0AFccpGI=;
        b=IJV1zuzxafytfbSsqCpUyiKBJjzRETqTjmy/ojF/NPD5Jh9RKbvrZtLz4hA8K+owqN
         TRKa4QjAO2su7pH6DQaG+TkYPrEjejvEsAgdL1RBOmRQpxR8T6SPReMKfwLy1UQHcTCf
         LtdE/H3mue1YvkJAvr3HbcmldjYcvoJ7oKQESNGwzwgk1+2N8BmHSzp+qJdnzOqJGOev
         XtK5nRi5wSfLzT2i4cJLQuq2mNTDfcpTclRjuPU8Hkn4BYhnDrjy97/gN1pmuCH0PLTU
         /rKKyTIhsnqAQ6g6hJR54CFplyYqPhJvlaeipxU6YaIP2600AJ/GOgO8T0ckm4i0dqRh
         +k0g==
X-Gm-Message-State: APt69E35RYTr26g0VEVV+6b6CAFemnfEcX7kCurlucgQvtPBQy5K4yYR
        KghJqlpYOrq9belSsYEVODgi3f+7MFrR24OGJm8g1kh4qyagiuwM+8uy/qVUdq+WWgrXJ8SG2Ct
        rWSISVmMUM5HecD+0Tmk84tU/gTQms+aHztUGjQqJU0KVf+sQhoH18gX+m1HX
X-Google-Smtp-Source: ADUXVKIqNYVe7kz4SKZizx/042ov2/ekbIcjL3yzDEvNOgjYXUb3J35Qig8WqLLMxyiF5w7vc0hOsnMyDQR8
MIME-Version: 1.0
X-Received: by 2002:ab0:31d6:: with SMTP id e22-v6mr73534uan.19.1528931193279;
 Wed, 13 Jun 2018 16:06:33 -0700 (PDT)
Date:   Wed, 13 Jun 2018 16:05:16 -0700
In-Reply-To: <20180613230522.55335-1-sbeller@google.com>
Message-Id: <20180613230522.55335-26-sbeller@google.com>
References: <20180530004810.30076-1-sbeller@google.com> <20180613230522.55335-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Subject: [PATCH v2 25/31] commit.c: allow set_commit_buffer to handle
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
index e9b22268997..44d1a38187a 100644
--- a/commit.c
+++ b/commit.c
@@ -262,10 +262,10 @@ void free_commit_buffer_slab(struct buffer_slab *bs)
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
index a417f99ad4f..3e883787855 100644
--- a/commit.h
+++ b/commit.h
@@ -87,8 +87,7 @@ void free_commit_buffer_slab(struct buffer_slab *bs);
  * Associate an object buffer with the commit. The ownership of the
  * memory is handed over to the commit, and must be free()-able.
  */
-#define set_commit_buffer(r, c, b, s) set_commit_buffer_##r(c, b, s)
-void set_commit_buffer_the_repository(struct commit *, void *buffer, unsigned long size);
+void set_commit_buffer(struct repository *r, struct commit *, void *buffer, unsigned long size);
 
 /*
  * Get any cached object buffer associated with the commit. Returns NULL
-- 
2.18.0.rc1.244.gcf134e6275-goog

