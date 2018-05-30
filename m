Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBEA81F42D
	for <e@80x24.org>; Wed, 30 May 2018 00:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968468AbeE3Atu (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 20:49:50 -0400
Received: from mail-pl0-f43.google.com ([209.85.160.43]:41595 "EHLO
        mail-pl0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968246AbeE3AtF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 20:49:05 -0400
Received: by mail-pl0-f43.google.com with SMTP id az12-v6so9957919plb.8
        for <git@vger.kernel.org>; Tue, 29 May 2018 17:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Emq9u3wuk5ZuPMc02LE3mXqDa7q5X4flWgPI7/+TJT4=;
        b=Y8TGKItCmJfkUTbdiGXOgOFGc7XLmor7HAHlPhY8/GwylrtINoZWK2PETyFyqbT3TQ
         HiOKn4Ke8SxGJ79B0gPcAVnRCwRlmoMtqKKXV7rgI2dWk0+/GqRZwpDIwhXwTkEU1dT/
         luX4xCOQElmmmdAxGomZHzh4PbyCMxcTXnohhuj+p8gMNtYRqDRNb/e6qcYeWIVVgJeF
         XDVGLjdAKHdgFMdCuCKnZuq/NPKXoctLSEXW7TxjYl5AV0Wr9PXbVg7T4pf3UiO9u72i
         DKIdyptoyXKb5do4Q6ipnO39CYt8TncRaofOD6q/eAlJR12XQtUeK5s1gM3TR7DyE6rW
         ztvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Emq9u3wuk5ZuPMc02LE3mXqDa7q5X4flWgPI7/+TJT4=;
        b=Jn5QJhNFuNRkBUrf35Eds7Qn9CM7hXHvncdEZ4jWCy9f3487O//Wb6QjyoKqsBC28x
         1wcW04rpN2tYGedc5RUuaOZFxwkSsjXI6LEgBdfbzcm4ZDvYEI5SHM/4KKTIVMN4J20N
         FGgs/nBiHBwJ12IVclmhZVu1KtSK1m1rciBbf6C3pKAmv7veAOrCAEl/oXaPVnRk441U
         Fx9UtVQpiJQsAL/DJrq17mdCfJ+zDfz1wFhRT9vzjwCwDuiUX8gDJi4O0VZDCGfyRT+/
         I609bRjlPuj55rGlWxZkVi1EVnG6Q5iImuGmxpPdBBwilAAEo1QRCoNFXPz6UHeAuFnb
         MZrw==
X-Gm-Message-State: ALKqPwf/zMh9266ksTEIN4EXvxFgr1qmnasFSYD+biDXr/fHnOxhSTtY
        tHNOPHDQoyHxanLPGYZqK3GpuQ49ECE=
X-Google-Smtp-Source: ADUXVKKxuWAqyDOl66aj6zYUwZaNy6xOkxW1tS0PYAY8wWWVghxMuxzBEQFiKYVWUk+UE2FS+NfNmQ==
X-Received: by 2002:a17:902:1e4:: with SMTP id b91-v6mr614786plb.155.1527641344705;
        Tue, 29 May 2018 17:49:04 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id k84-v6sm24155276pfh.110.2018.05.29.17.49.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 May 2018 17:49:03 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 30/35] commit.c: allow get_cached_commit_buffer to handle arbitrary repositories
Date:   Tue, 29 May 2018 17:48:05 -0700
Message-Id: <20180530004810.30076-31-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180530004810.30076-1-sbeller@google.com>
References: <20180530004810.30076-1-sbeller@google.com>
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
index b824e69186e..383997817f0 100644
--- a/commit.c
+++ b/commit.c
@@ -270,10 +270,10 @@ void set_commit_buffer(struct repository *r, struct commit *commit, void *buffer
 	v->size = size;
 }
 
-const void *get_cached_commit_buffer_the_repository(const struct commit *commit, unsigned long *sizep)
+const void *get_cached_commit_buffer(struct repository *r, const struct commit *commit, unsigned long *sizep)
 {
 	struct commit_buffer *v = buffer_slab_peek(
-		the_repository->parsed_objects->buffer_slab, commit);
+		r->parsed_objects->buffer_slab, commit);
 	if (!v) {
 		if (sizep)
 			*sizep = 0;
diff --git a/commit.h b/commit.h
index ec1733ed86d..90ab9c403fe 100644
--- a/commit.h
+++ b/commit.h
@@ -93,8 +93,7 @@ void set_commit_buffer(struct repository *r, struct commit *, void *buffer, unsi
  * Get any cached object buffer associated with the commit. Returns NULL
  * if none. The resulting memory should not be freed.
  */
-#define get_cached_commit_buffer(r, c, s) get_cached_commit_buffer_##r(c, s)
-const void *get_cached_commit_buffer_the_repository(const struct commit *, unsigned long *size);
+const void *get_cached_commit_buffer(struct repository *, const struct commit *, unsigned long *size);
 
 /*
  * Get the commit's object contents, either from cache or by reading the object
-- 
2.17.0.582.gccdcbd54c44.dirty

