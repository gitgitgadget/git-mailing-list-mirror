Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A01C433FE
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 18:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EF9760EBB
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 18:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbhKATAx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Nov 2021 15:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbhKATAZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Nov 2021 15:00:25 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B140C06120F
        for <git@vger.kernel.org>; Mon,  1 Nov 2021 11:56:34 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id c71-20020a1c9a4a000000b0032cdcc8cbafso574817wme.3
        for <git@vger.kernel.org>; Mon, 01 Nov 2021 11:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Any6a1LK2HXrYbq9lMDq2rjvMK57JW2CkVVXaPnmLbQ=;
        b=G9DQBtjfcWCYEuQ9BV+1DYHvmuiVQXHjc31Xk5bgCA0CLXNdHlf1t+OrhZlhMUcB1m
         jOaZQ9+b4jviBpzKKwi/6eG0rwwDCeOurufbhnV+9CKWjtmJ5mR2ncEJRxOOnkD6Ixqb
         h20ITi5rcmNoKcdXPl7bv7CgWRnx4rTJ2XJ5p9H4r7wMZXssztJUuTA0ba/iDbxMzYjp
         saobzJw1DwHTz1L41Rh40WXYrHqKQknmJbWJX7I/Q3dBFFoyA3TNfHAqLR9n/4/Mov3Z
         nrO8o9JOczsckgJT2noDkIqTiDpcUKtax5SJn8peixiQzSiIqObAzmdcBWKNn2QEMFb9
         AOZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Any6a1LK2HXrYbq9lMDq2rjvMK57JW2CkVVXaPnmLbQ=;
        b=EaRXOUJn6sULVo5FUrJ7Y90FPOqPUk1RMyW1yJB6XaLwY8f9J3eyNH2JDn390kCSEn
         6Pwy738vNv58fPiF2eBvGec09mnsA5LUH+5LRZQVeKrK0L2w4NkqFcBGpzu76T0GuoEh
         cXyMmnL+8gmnmjdOYxflPao0FJhwvdlgZsecX2rhDLn6uksKSjNiGYZKLcOryvDaiKTn
         mTBips0N0XoAYBvilKU3pRvSwdne70fCwI7hdhUn7iz3CSh8tDGbWR9xPQdML6UjYNLB
         abfnsDhjJr9vPC3FbD3Cxnp/U/bsjkg0y65WFaC9zLdkiuU6KI8wTMrQZ8NR5o82uvvG
         U/SQ==
X-Gm-Message-State: AOAM532RZepSfPFdKnAZh0NAVAIZsZuDFtIcgv/VZXTqZDnEnuBy25qM
        86mf9m5NuFsNtoXvz5Mv6upAcSrtWPY68uNv
X-Google-Smtp-Source: ABdhPJwau50yxCnRnZG1NW2NOfoMMDlIVQvXwuPhgnAIyqy3BqUEoxE4WYXuayA/YaQFYclBW+2/iA==
X-Received: by 2002:a7b:c007:: with SMTP id c7mr838803wmb.101.1635792991969;
        Mon, 01 Nov 2021 11:56:31 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q14sm314185wmq.4.2021.11.01.11.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 11:56:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 09/17] hooks: convert non-worktree 'post-checkout' hook to hook library
Date:   Mon,  1 Nov 2021 19:56:14 +0100
Message-Id: <patch-v4-09.17-cb95c79093b-20211101T184938Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1570.g069344fdd45
In-Reply-To: <cover-v4-00.17-00000000000-20211101T184938Z-avarab@gmail.com>
References: <cover-v3-00.13-00000000000-20211019T231647Z-avarab@gmail.com> <cover-v4-00.17-00000000000-20211101T184938Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

Move the running of the 'post-checkout' hook away from run-command.h
to the new hook.h library, except in the case of
builtin/worktree.c. That special-case will be handled in a subsequent
commit.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/checkout.c | 3 ++-
 builtin/clone.c    | 3 ++-
 reset.c            | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index cbf73b8c9f6..4af17d17217 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -9,6 +9,7 @@
 #include "config.h"
 #include "diff.h"
 #include "dir.h"
+#include "hook.h"
 #include "ll-merge.h"
 #include "lockfile.h"
 #include "merge-recursive.h"
@@ -106,7 +107,7 @@ struct branch_info {
 static int post_checkout_hook(struct commit *old_commit, struct commit *new_commit,
 			      int changed)
 {
-	return run_hook_le(NULL, "post-checkout",
+	return run_hooks_l("post-checkout",
 			   oid_to_hex(old_commit ? &old_commit->object.oid : null_oid()),
 			   oid_to_hex(new_commit ? &new_commit->object.oid : null_oid()),
 			   changed ? "1" : "0", NULL);
diff --git a/builtin/clone.c b/builtin/clone.c
index fb377b27657..ee27b9f8114 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -32,6 +32,7 @@
 #include "connected.h"
 #include "packfile.h"
 #include "list-objects-filter-options.h"
+#include "hook.h"
 
 /*
  * Overall FIXMEs:
@@ -705,7 +706,7 @@ static int checkout(int submodule_progress)
 	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
 		die(_("unable to write new index file"));
 
-	err |= run_hook_le(NULL, "post-checkout", oid_to_hex(null_oid()),
+	err |= run_hooks_l("post-checkout", oid_to_hex(null_oid()),
 			   oid_to_hex(&oid), "1", NULL);
 
 	if (!err && (option_recurse_submodules.nr > 0)) {
diff --git a/reset.c b/reset.c
index f214df3d96c..0881e636915 100644
--- a/reset.c
+++ b/reset.c
@@ -7,6 +7,7 @@
 #include "tree-walk.h"
 #include "tree.h"
 #include "unpack-trees.h"
+#include "hook.h"
 
 int reset_head(struct repository *r, struct object_id *oid, const char *action,
 	       const char *switch_to_branch, unsigned flags,
@@ -127,7 +128,7 @@ int reset_head(struct repository *r, struct object_id *oid, const char *action,
 					    reflog_head);
 	}
 	if (run_hook)
-		run_hook_le(NULL, "post-checkout",
+		run_hooks_l("post-checkout",
 			    oid_to_hex(orig ? orig : null_oid()),
 			    oid_to_hex(oid), "1", NULL);
 
-- 
2.33.1.1570.g069344fdd45

