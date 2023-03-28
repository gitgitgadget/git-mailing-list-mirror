Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F44C76196
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 14:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbjC1OAK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 10:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233057AbjC1N7e (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 09:59:34 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A40AC16A
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 06:59:20 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id l27so12336750wrb.2
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 06:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680011959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=19rcKh1VlGEoOIA7l8w/Tb7+Mmb0RGSkfwDqqd2/FTE=;
        b=eMA73ZOaY+t4ZLrSv7QgBjK6rALsyVzkjCeo0tWy1usu9lI3xZsLwc/2nQxzgGZjFu
         ScYNL74h9+VkNEfpyxSgUTNeJHJnwzMJu/6OtEHObH2C3phYQuSbrFcy2RxHBD5wTYDy
         ab27S8BvM+PcYnqTb5E70suWG1qbxqPxpERuEYZQ/RVVqLY7b4xICVqvr0ulFStyl/cY
         90oqF7N/kqONVKejKd14swE2sFDabiDagRVLCHgljlPZObl2tSPXJik396gWTmBc6JBc
         57ftXvajxkw2qnj1EPp2PBJGWjM4qaP0TS8OvMmsct1obJWXg5MkpZ+Mrdg9EsPq53tu
         IMZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680011959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=19rcKh1VlGEoOIA7l8w/Tb7+Mmb0RGSkfwDqqd2/FTE=;
        b=10IMa4vtKZKqeFTwgd3wSFhYSp+oG+iPBImIpl/MZQaU3nOCtt4o+oVLFzK2bdD8Q4
         26kq7IChpekahV2uM/svQ6j5x5SdDN6QgQz4Gic7BsyXI6BpovZJoureQNOYaZ2cvnIm
         oy9t/o3vP6/6veL9k/lTtTIsbdcD6kuECw69/meVIN8nBfobFUyvThUUVbakAI1hLtaW
         zaeClrW9lI+/lOF8NEvza/6ykapwwfHiCuAsnQRYnEEX0pHkSuPthuhChn7jHWcWKgqX
         MSuR/zQ7ulLXC86RCubUpNAfm1OLKbkiffoFDnj8wNX/L6AWjIc1edlUVON+a1SLQlIw
         xLVw==
X-Gm-Message-State: AAQBX9d96BvjTwSl9EoRTX1aGAa0HGs2aHuKog8ZJpqFa7MktCqIQXLr
        3NARadQTeLJkeOeKDxTboqQ64IN6oRGFbw==
X-Google-Smtp-Source: AKy350bxxwEvnCpmjELCEFvKf74L7uLugKO/vBUKgSEvUCrApGqI4f/VVNd1nNBguEv6/2o625vLRQ==
X-Received: by 2002:adf:e44a:0:b0:2d0:33aa:26da with SMTP id t10-20020adfe44a000000b002d033aa26damr12259628wrm.7.1680011959078;
        Tue, 28 Mar 2023 06:59:19 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q7-20020a05600c46c700b003ede2c59a54sm6252268wmo.37.2023.03.28.06.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 06:59:18 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 11/17] cocci: apply the "packfile.h" part of "the_repository.pending"
Date:   Tue, 28 Mar 2023 15:58:52 +0200
Message-Id: <patch-v2-11.17-13955394126-20230328T110947Z-avarab@gmail.com>
X-Mailer: git-send-email 2.40.0.rc1.1034.g5867a1b10c5
In-Reply-To: <cover-v2-00.17-00000000000-20230328T110946Z-avarab@gmail.com>
References: <cover-00.17-00000000000-20230317T152724Z-avarab@gmail.com> <cover-v2-00.17-00000000000-20230328T110946Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Apply the part of "the_repository.pending.cocci" pertaining to
"packfile.h".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/gc.c                                    | 2 +-
 commit-graph.c                                  | 2 +-
 contrib/coccinelle/the_repository.cocci         | 4 ++++
 contrib/coccinelle/the_repository.pending.cocci | 4 ----
 packfile.h                                      | 1 -
 5 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 9dc80344b64..a61d62bcf7b 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -285,7 +285,7 @@ static uint64_t total_ram(void)
 
 static uint64_t estimate_repack_memory(struct packed_git *pack)
 {
-	unsigned long nr_objects = approximate_object_count();
+	unsigned long nr_objects = repo_approximate_object_count(the_repository);
 	size_t os_cache, heap;
 
 	if (!pack || !nr_objects)
diff --git a/commit-graph.c b/commit-graph.c
index a30c4c96940..6403567dfee 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -2361,7 +2361,7 @@ int write_commit_graph(struct object_directory *odb,
 			replace = ctx->opts->split_flags & COMMIT_GRAPH_SPLIT_REPLACE;
 	}
 
-	ctx->approx_nr_objects = approximate_object_count();
+	ctx->approx_nr_objects = repo_approximate_object_count(the_repository);
 
 	if (ctx->append && ctx->r->objects->commit_graph) {
 		struct commit_graph *g = ctx->r->objects->commit_graph;
diff --git a/contrib/coccinelle/the_repository.cocci b/contrib/coccinelle/the_repository.cocci
index ff4c56114f1..a325361f961 100644
--- a/contrib/coccinelle/the_repository.cocci
+++ b/contrib/coccinelle/the_repository.cocci
@@ -91,6 +91,10 @@
 |
 - format_commit_message
 + repo_format_commit_message
+// packfile.h
+|
+- approximate_object_count
++ repo_approximate_object_count
 )
   (
 + the_repository,
diff --git a/contrib/coccinelle/the_repository.pending.cocci b/contrib/coccinelle/the_repository.pending.cocci
index 375850e773c..9b426e49e66 100644
--- a/contrib/coccinelle/the_repository.pending.cocci
+++ b/contrib/coccinelle/the_repository.pending.cocci
@@ -5,11 +5,7 @@
 @@
 @@
 (
-// packfile.h
-- approximate_object_count
-+ repo_approximate_object_count
 // promisor-remote.h
-|
 - promisor_remote_reinit
 + repo_promisor_remote_reinit
 |
diff --git a/packfile.h b/packfile.h
index a3f6723857b..6ec16567971 100644
--- a/packfile.h
+++ b/packfile.h
@@ -65,7 +65,6 @@ struct packed_git *get_all_packs(struct repository *r);
  * for speed.
  */
 unsigned long repo_approximate_object_count(struct repository *r);
-#define approximate_object_count() repo_approximate_object_count(the_repository)
 
 struct packed_git *find_sha1_pack(const unsigned char *sha1,
 				  struct packed_git *packs);
-- 
2.40.0.rc1.1034.g5867a1b10c5

