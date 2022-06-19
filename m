Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CB6C433EF
	for <git@archiver.kernel.org>; Sun, 19 Jun 2022 03:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233162AbiFSD0f (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Jun 2022 23:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233217AbiFSD0Y (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Jun 2022 23:26:24 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738A7F59D
        for <git@vger.kernel.org>; Sat, 18 Jun 2022 20:26:22 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id u18so6983310plb.3
        for <git@vger.kernel.org>; Sat, 18 Jun 2022 20:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QvI7YUGmKvvkFdWKpmwW/k5ky80zzBvcOB9aG5Dthsk=;
        b=gJ8RCD9PN3wmUpOE9K+BllQ8vlEka7aRpxvRqRCW2U6UHrP0Rf2jTfPZHvnncaoxLY
         lCqrvz0YeQ+a/brORjOszMQTLvfjCrNso5e/n3KgzWAx6BgMCz0CGeJN0yMb6DjsnQSl
         NUfvDgOz9SpbdqaBJqyq2ZFhfUQ++EpnjV7jqSk7BKmj4EpwtY5J9RmlTJz2CGGCYV+B
         zapp2qKaYrmt4I4lwqzGO3oRH6m3n3fg0ZkToX8E7UFmfUwSdNOZJVMr7taR3swtJNjs
         x7fldxCBPol1NiKM9/iUeMGrPw6phiLsUbuMWo7hSXn9PbLkj7PPEbz6lRalqS9abhrM
         LzHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QvI7YUGmKvvkFdWKpmwW/k5ky80zzBvcOB9aG5Dthsk=;
        b=7kAOkyIhVpXhLmqYSP7mmrAWhC45sZB+WicTMxiHEUGetrWWHhdk30azfWIJg6P8Ud
         +Qly5gaMRROfAXp+8AaaLQkhWemXMdm0Xeb89/5fSkSnH1DXiwe/a/QrUMo3d7saDD0H
         OZ1dvLJFhX6sOejpxQojWHHqq35I6MA1W8F6oHlMHBHAqH3A0nARJIk/qU0V87514K8A
         UsCEA5jToVph/g0ogQbIGv846tVteNcOyxC2IzdWgD71unxPmh+Wg7J/JcfOPNQAyMnQ
         C47cmkmWlTwbH5K7Iw4Rfr/sBVbowOvlDLHVL1GcjSIh7s5js1iiAYoqunuAT24xOAz+
         w9tQ==
X-Gm-Message-State: AJIora9+D25kMZvj8rts9afMoAsqqu8Fp+e+nl4AKneLj9B2r/iaVaY/
        SE5ipVPnzlbpzkNsuyEpsTVdK8hIcPvQao+6iS4=
X-Google-Smtp-Source: AGRyM1tBpZ/PFefpGExD9yuLaqiWHC2sCmhBm2l5x8zMapEZ8gRMuAaYrc16vVeJ+MX/8GOLh14Mrg==
X-Received: by 2002:a17:90a:e582:b0:1ec:8bd2:981e with SMTP id g2-20020a17090ae58200b001ec8bd2981emr5683729pjz.22.1655609181816;
        Sat, 18 Jun 2022 20:26:21 -0700 (PDT)
Received: from ffyuanda.localdomain ([112.195.147.33])
        by smtp.gmail.com with ESMTPSA id u1-20020a170903124100b0016188a4005asm5990650plh.122.2022.06.18.20.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jun 2022 20:26:21 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     shaoxuan.yuan02@gmail.com
Cc:     derrickstolee@github.com, git@vger.kernel.org, gitster@pobox.com,
        vdye@github.com, newren@gmail.com
Subject: [WIP v3 7/7] mv: update sparsity after moving from out-of-cone to in-cone
Date:   Sun, 19 Jun 2022 11:25:49 +0800
Message-Id: <20220619032549.156335-8-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220619032549.156335-1-shaoxuan.yuan02@gmail.com>
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
 <20220619032549.156335-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Originally, "git mv" a sparse file from out-of-cone to
in-cone does not update the moved file's sparsity (remove its
SKIP_WORKTREE bit). And the corresponding cache entry is, unexpectedly,
not checked out in the working tree.

Update the behavior so that:
1. Moving from out-of-cone to in-cone removes the SKIP_WORKTREE bit from
   corresponding cache entry.
2. The moved cache entry is checked out in the working tree to reflect
   the updated sparsity.

Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
---
 builtin/mv.c                  | 18 ++++++++++++++++++
 t/t7002-mv-sparse-checkout.sh |  4 +---
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index cb3441c7cb..a8b9f55654 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -13,6 +13,7 @@
 #include "string-list.h"
 #include "parse-options.h"
 #include "submodule.h"
+#include "entry.h"
 
 static const char * const builtin_mv_usage[] = {
 	N_("git mv [<options>] <source>... <destination>"),
@@ -399,6 +400,11 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		const char *src = source[i], *dst = destination[i];
 		enum update_mode mode = modes[i];
 		int pos;
+		struct checkout state = CHECKOUT_INIT;
+		state.istate = &the_index;
+
+		if (force)
+			state.force = 1;
 		if (show_only || verbose)
 			printf(_("Renaming %s to %s\n"), src, dst);
 		if (show_only)
@@ -424,6 +430,18 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		pos = cache_name_pos(src, strlen(src));
 		assert(pos >= 0);
 		rename_cache_entry_at(pos, dst);
+
+		if (mode & SPARSE) {
+			if (path_in_sparse_checkout(dst, &the_index)) {
+				int dst_pos;
+
+				dst_pos = cache_name_pos(dst, strlen(dst));
+				active_cache[dst_pos]->ce_flags &= ~CE_SKIP_WORKTREE;
+
+				if (checkout_entry(active_cache[dst_pos], &state, NULL, NULL))
+					die(_("cannot checkout %s"), ce->name);
+			}
+		}
 	}
 
 	if (gitmodules_modified)
diff --git a/t/t7002-mv-sparse-checkout.sh b/t/t7002-mv-sparse-checkout.sh
index 30e13b9979..7734119197 100755
--- a/t/t7002-mv-sparse-checkout.sh
+++ b/t/t7002-mv-sparse-checkout.sh
@@ -237,7 +237,6 @@ test_expect_success 'can move out-of-cone directory with --sparse' '
 	git mv --sparse folder1 sub 1>actual 2>stderr &&
 	test_must_be_empty stderr &&
 
-	git sparse-checkout reapply &&
 	test_path_is_dir sub/folder1 &&
 	test_path_is_file sub/folder1/file1
 '
@@ -260,7 +259,6 @@ test_expect_success 'can move out-of-cone file with --sparse' '
 	git mv --sparse folder1/file1 sub 1>actual 2>stderr &&
 	test_must_be_empty stderr &&
 
-	git sparse-checkout reapply &&
 	! test_path_is_dir sub/folder1 &&
 	test_path_is_file sub/file1
 '
@@ -278,7 +276,7 @@ test_expect_success 'refuse to move sparse file to existing destination' '
 	test_cmp expect stderr
 '
 
-test_expect_failure 'move sparse file to existing destination with --force and --sparse' '
+test_expect_success 'move sparse file to existing destination with --force and --sparse' '
 	test_when_finished "cleanup_sparse_checkout" &&
 	mkdir folder1 &&
 	touch folder1/file1 &&
-- 
2.35.1

