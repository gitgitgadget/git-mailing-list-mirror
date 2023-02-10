Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C2CAC05027
	for <git@archiver.kernel.org>; Fri, 10 Feb 2023 10:29:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbjBJK3A (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Feb 2023 05:29:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbjBJK24 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2023 05:28:56 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF12971645
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 02:28:52 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id h16so4553642wrz.12
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 02:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=irGsXh5R8IOMD1vCH2Z1Uvc85DMxsNHpIsfoMDdO7KI=;
        b=C0+djIfeet00Ey3c6smjVHgulsGXyaPKPite8V0Rmf2mXe+2FBCosfuGmlmwpRYwxD
         J1nnTGagKsd5WHCT67n90lrASeKqmxhUpOpNyV1sjb9LPotybIB+RNCtfIotjsQ3AdML
         ttXye6LT1E8rq/j2V0A/9Ik6jq+yW0TQOBaPfVhmwaBVmVn8ExnNVARKmWaJNSQVhpzz
         hWxjlIoesy0L83gNHBRi7x3OGWr7PurIQRzO1ZhYlCFHh5VwlhPvLke3YCQCknBYYRCA
         IPGlPp3+BR1cFfprM2uBrZNKZ9pjCSy6JRN34KdS9SvMARgX9ognDytzJZpSMoR5oiev
         pz8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=irGsXh5R8IOMD1vCH2Z1Uvc85DMxsNHpIsfoMDdO7KI=;
        b=f8IRqLHS6TqLLSSUEIdDf3bhhirJyx4B95gLDxSkY2KTvwv7RW0UhFWTSz687yulTh
         h077LPlfCyeqmJw2lGxE4N6N7dS/XyqwpAjWjmNLAsC8iGP/Qv+AC05SKATjvI8LCM2q
         DFruFNbKpYRum/ld4QIHAFOYMmUmQcpg8XeOMnp6q7jkMCMJ+Zgklh/altITpZrHqVPG
         zM/bIpnAdrkVo8nBMz/fpO501/UAmJ9JRKNHQ++OLOJcxoCakjorVo7fCkPPE0+YYSGm
         9ew1v0Dl7SPwN3AICeAE9ZUb5FKv/GvBeSzPQyuYFv/SbkVU506uE5VL01/vlUGepYxK
         4Gjg==
X-Gm-Message-State: AO0yUKVn/Cb/ynHEucbKcg3DpHQ8qj/iMQUR2h5gKm/Uz4f5zrCAsmST
        sY+l7f8VioeSRnkazvBgPR3ZkFi7QkmVqIT/
X-Google-Smtp-Source: AK7set9W/0v7t0elAnUq2kjSH8HzVxORMPrucVytA4NrIh/ZRkDmI8S9eKWlBTeJffX97KqqglfCXQ==
X-Received: by 2002:adf:dd82:0:b0:2bf:b199:c7eb with SMTP id x2-20020adfdd82000000b002bfb199c7ebmr13380799wrl.54.1676024930714;
        Fri, 10 Feb 2023 02:28:50 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u13-20020a5d514d000000b002c3f50228afsm3244792wrt.3.2023.02.10.02.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 02:28:49 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/6] cocci & cache.h: fully apply "active_nr" part of index-compatibility
Date:   Fri, 10 Feb 2023 11:28:35 +0100
Message-Id: <patch-v2-2.6-6040edad622-20230210T102114Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1475.gc2542cdc5ef
In-Reply-To: <cover-v2-0.6-00000000000-20230210T102114Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20221215T095335Z-avarab@gmail.com> <cover-v2-0.6-00000000000-20230210T102114Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Apply the "active_nr" part of "index-compatibility.pending.cocci",
which was left out in [1] due to an in-flight conflict. As of [2] the
topic we conflicted with has been merged to "master", so we can fully
apply this rule.

1. dc594180d9e (cocci & cache.h: apply variable section of "pending"
   index-compatibility, 2022-11-19)
2. 9ea1378d046 (Merge branch 'ab/various-leak-fixes', 2022-12-14)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/commit.c                             |  2 +-
 cache.h                                      |  2 --
 contrib/coccinelle/index-compatibility.cocci | 13 ++++---------
 3 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 44b763d7cd0..57a95123dff 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -991,7 +991,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		struct object_id oid;
 		const char *parent = "HEAD";
 
-		if (!active_nr) {
+		if (!the_index.cache_nr) {
 			discard_cache();
 			if (read_cache() < 0)
 				die(_("Cannot read index"));
diff --git a/cache.h b/cache.h
index 4bf14e0bd94..b0bbecf35ef 100644
--- a/cache.h
+++ b/cache.h
@@ -454,8 +454,6 @@ extern struct index_state the_index;
 
 #ifndef USE_THE_INDEX_VARIABLE
 #ifdef USE_THE_INDEX_COMPATIBILITY_MACROS
-#define active_nr (the_index.cache_nr)
-
 #define read_cache() repo_read_index(the_repository)
 #define discard_cache() discard_index(&the_index)
 #define cache_name_pos(name, namelen) index_name_pos(&the_index,(name),(namelen))
diff --git a/contrib/coccinelle/index-compatibility.cocci b/contrib/coccinelle/index-compatibility.cocci
index 8520f03128a..028ff53354a 100644
--- a/contrib/coccinelle/index-compatibility.cocci
+++ b/contrib/coccinelle/index-compatibility.cocci
@@ -1,6 +1,7 @@
 // the_index.* variables
 @@
 identifier AC = active_cache;
+identifier AN = active_nr;
 identifier ACC = active_cache_changed;
 identifier ACT = active_cache_tree;
 @@
@@ -8,6 +9,9 @@ identifier ACT = active_cache_tree;
 - AC
 + the_index.cache
 |
+- AN
++ the_index.cache_nr
+|
 - ACC
 + the_index.cache_changed
 |
@@ -15,15 +19,6 @@ identifier ACT = active_cache_tree;
 + the_index.cache_tree
 )
 
-@@
-identifier AN = active_nr;
-identifier f != prepare_to_commit;
-@@
-  f(...) {<...
-- AN
-+ the_index.cache_nr
-  ...>}
-
 // "the_repository" simple cases
 @@
 @@
-- 
2.39.1.1475.gc2542cdc5ef

