Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065A7C433FE
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 13:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbiCINTc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 08:19:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233077AbiCINTW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 08:19:22 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF70517924A
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 05:17:57 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id c192so1338148wma.4
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 05:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GM9RqbFJZluFX1+PoOxTw4N0L+v7R9/7FqEASUG6iy4=;
        b=qgH08dAbpyj5MlIfDuQkvASZoK+vAzjTz8JiJdlItBTz1iuEMZEYd+xS/TTEGsPZYg
         IbkY2NCVAE7cf/sL9DB5GVAYPmwLtpmEhJ+c+vv2gvnZ/Q73/x0D0U0/O6S/5IaUWyH9
         VuUGxmrz/PID2UqN7XyL9K7c3LueRgK574nOuBIBqZloItNZ+sUwUk2eDK9qyXnisE54
         LyhJXXQ34ebeqcrhHPwPdVTqaqopzKw/3NojQZHZZj3H52zOJAXsGOhH+Q9MorKHxylO
         H2E6Y/2usskiWz5e24PMJ4AushBf0mb5tdaTOwGzt1awIYDm3VF5jzDX6bTVBUalIgHL
         zp+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GM9RqbFJZluFX1+PoOxTw4N0L+v7R9/7FqEASUG6iy4=;
        b=FYNrpFEcfEeznncPReFLGg8Q35bgJO6e4TrUro+mW3Mus6HVNP/PrjV2TmNQ5Ws6Pl
         7XE9JujGG7D5avsJpeZKwAm1S5SbgEBgLKH4HSMdonEF4K7uWMUOALyXj01DX7/pM2ap
         PGEoCnweZuQEIQjXHHG85YFYychZwiR81VD/XOZf2Vu2jCUe6s5OR6c10VxxA/lTw7UC
         RIyJ4B0EH3t1uDg297Ca4UKqKEh0x4MGuXRpWgp4KP9XNL5nag/7UE65pHyL3gGcM1GE
         uf6MqCey1qxB+WScCohZd6ozWajuAEcNu2cJR9QHm07WkUVXjfynN9w9aKXkvLXJIKjg
         Kuzg==
X-Gm-Message-State: AOAM531cwTU1xa4jinqV2nz/3W2TYRztS93vrvbatDgZcRlxwl0QbhxI
        Ji0XpF9ptriS2FiKr+rwGWQD3JjTtIqWJQ==
X-Google-Smtp-Source: ABdhPJy1CILEjH52Lp+DpfLEXaqty2EcOo3LLMEIWJnl8tjHBH0Ya6WAQpuTZNETDnntCZK2eV5GGQ==
X-Received: by 2002:a1c:e915:0:b0:37b:d847:e127 with SMTP id q21-20020a1ce915000000b0037bd847e127mr3382968wmc.180.1646831876170;
        Wed, 09 Mar 2022 05:17:56 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i74-20020adf90d0000000b0020373ba7beesm2599988wri.0.2022.03.09.05.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 05:17:55 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 14/24] revisions API users: use release_revisions() for "prune_data" users
Date:   Wed,  9 Mar 2022 14:16:44 +0100
Message-Id: <patch-14.24-761bbd1763c-20220309T123321Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1295.g6b025d3e231
In-Reply-To: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use release_revisions() for users of "struct rev_list" that reach into
the "struct rev_info" and clear the "prune_data" already.

In a subsequent commit we'll teach release_revisions() to clear this
itself, but in the meantime let's invoke release_revisions() here to
clear anything else we may have missed, and for reasons of having
consistent boilerplate.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/add.c   | 1 +
 builtin/stash.c | 1 +
 diff-lib.c      | 1 +
 wt-status.c     | 1 +
 4 files changed, 4 insertions(+)

diff --git a/builtin/add.c b/builtin/add.c
index f507d2191cd..115a26ea633 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -143,6 +143,7 @@ int add_files_to_cache(const char *prefix,
 	rev.max_count = 0; /* do not compare unmerged paths with stage #2 */
 	run_diff_files(&rev, DIFF_RACY_IS_MODIFIED);
 	clear_pathspec(&rev.prune_data);
+	release_revisions(&rev);
 	return !!data.add_errors;
 }
 
diff --git a/builtin/stash.c b/builtin/stash.c
index 0b9d55d09bb..b9fe6f7c712 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1073,6 +1073,7 @@ static int check_changes_tracked_files(const struct pathspec *ps)
 
 done:
 	clear_pathspec(&rev.prune_data);
+	release_revisions(&rev);
 	return ret;
 }
 
diff --git a/diff-lib.c b/diff-lib.c
index ad1dd4834f7..68858a39964 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -642,6 +642,7 @@ int do_diff_cache(const struct object_id *tree_oid, struct diff_options *opt)
 	if (diff_cache(&revs, tree_oid, NULL, 1))
 		exit(128);
 	clear_pathspec(&revs.prune_data);
+	release_revisions(&revs);
 	return 0;
 }
 
diff --git a/wt-status.c b/wt-status.c
index 89289e52603..aaef10451f3 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -617,6 +617,7 @@ static void wt_status_collect_changes_worktree(struct wt_status *s)
 	copy_pathspec(&rev.prune_data, &s->pathspec);
 	run_diff_files(&rev, 0);
 	clear_pathspec(&rev.prune_data);
+	release_revisions(&rev);
 }
 
 static void wt_status_collect_changes_index(struct wt_status *s)
-- 
2.35.1.1295.g6b025d3e231

