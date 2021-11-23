Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1F2C433EF
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 11:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236639AbhKWLuD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 06:50:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236466AbhKWLtk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 06:49:40 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B98C0613E0
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 03:46:30 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id d24so38534061wra.0
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 03:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p+lXTBdQs+y2f8EPIlH6LT7vkrHqlHb5zjym8NAfE7w=;
        b=UMjHSLrqC8e4RrluZDnK1xso63uippkUuK2pVIhURIaotsYThyjpcagWeezDUFVJxT
         314xn3s9c8CUxw+sMZgWRjFYI9zgEuVRaho6PMe+1y0wcxG2iLzF6UwaVC/k2VUs+oJr
         pMDXS7mUdpoXIRz8usEOoLiqKlGjf4UlCs750og6dlRdBQ6jvZjLwJiCQczvMWLqynkS
         XSDSHLvy6mbD3itneBSDi/rQwNcgY1evE7wRp9W/EVSz7uCKgD9gz+Fe45oNu1xFsVN0
         WHJEvdGYQDm0CGic1jfeEr1+gGqq/anAEjBgepZWIFUjaLQ/COemFIa7rUPBlWUPAKud
         R7bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p+lXTBdQs+y2f8EPIlH6LT7vkrHqlHb5zjym8NAfE7w=;
        b=ajxxgZlW5js8DTAoBTgW96TmlITUb4PK66ljQTh544APu97/wyMRXoeqnc4vHrfKke
         35P0vr5yFDlPuWQkOInoxDj2mKdkMDy/ThblemI1Wr+6k4+LS7/eRdbnkgNIfw/9vydl
         fjadWrpvo0e3AmbBs0guNd/w3G4KzVAXN++/63jmVHPeZ+A9e+0JnHbmc853HR4gvKa3
         Qy0AW0PxPoz3/oGH7G+fBwqNg8mRKuCQAriEetILDdIwVpeYIccVdJzvpRMRX6lKlS2a
         bQafXT5G+H3giwr87SSchKVJ6WwPQ/TSyQr6wq4PTNB7nrqcRbZJM6i867X3gUjmgHLV
         wLyw==
X-Gm-Message-State: AOAM5306fpixQI1UunPJaiMEunSKn6U3oPm8zJ8hSL3tI97RBKIbg+J3
        WGv3yj4c3RXi29LBhO8RBXyxqKYVVunkOQ==
X-Google-Smtp-Source: ABdhPJzi8pbWFvlOgSQISOygaxAaqf2a1vmoDS+LyjlCeS5LlTY6bHXivl11wYdGcwPEyj7jh8loTA==
X-Received: by 2002:adf:cf05:: with SMTP id o5mr6769858wrj.325.1637667988361;
        Tue, 23 Nov 2021 03:46:28 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c11sm1723145wmq.27.2021.11.23.03.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 03:46:27 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 09/17] hooks: convert non-worktree 'post-checkout' hook to hook library
Date:   Tue, 23 Nov 2021 12:46:08 +0100
Message-Id: <patch-v5-09.17-359ba416e84-20211123T114206Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.831.gd33babec0d1
In-Reply-To: <cover-v5-00.17-00000000000-20211123T114206Z-avarab@gmail.com>
References: <cover-v4-00.17-00000000000-20211101T184938Z-avarab@gmail.com> <cover-v5-00.17-00000000000-20211123T114206Z-avarab@gmail.com>
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
2.34.0.831.gd33babec0d1

