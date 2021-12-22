Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE63DC433FE
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 04:00:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238919AbhLVEAC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 23:00:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238870AbhLVD76 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 22:59:58 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D92C061756
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 19:59:55 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id g7-20020a7bc4c7000000b00345c4bb365aso282165wmk.4
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 19:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UnKtuPBXICpvJKAEmfLfcOUU4owo0ELp8kOt+Hr6O7A=;
        b=EOoPBRiHrnABe3lw+/HED917tRkZEQA9yQ0bEYrvWEicaPQXDQE8r5S0Pcz2pEGrkp
         nAfQtIuuVsIKwJcp6krGa7OFn4qisfZobTXQnJtCQguiJVqNJKpGnAu0pF2O1R97p7lN
         KOCP9d2INNCVbgpmmxkSN3/9LbeqfknLJZcpLwjMmsSQIHf4GAOFY9UUiYvDtfVXo/yH
         sCcZnHlJb69D2m+0VYjNGH4lBb6/WtUiUqjAfT6ohXVLG4SV8Qd5d++IdGRLj98+gg/f
         hcpQHtdziU6ltV4QGNZfc0ZSkqPVHZCpVolk8GDrNxG3GhyrucWk24ZLw2yLVADFrytZ
         bEwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UnKtuPBXICpvJKAEmfLfcOUU4owo0ELp8kOt+Hr6O7A=;
        b=ZOcbW0dxt72/Hdfb8WumVRH1dW6hmlz2V96jBecdPdr002R79niG7vzWj5UN/rqHP8
         xn8cSUtijSMYX5gp50ZVilIgUtFOhWxnlxV+5h4xAlsaisI1JfUvzKoS1z1s1wiVYlPm
         zjyp2rKdxZD5x2thXAQe002MUcLQM7LSZo15dOfHVaHSlnm+RBwPIkQURF+SaMOZd5oe
         9JRfe/mP91wJ88b7ashBaCcwmuwnas3r/vOLudM9Q0F5yJ64KTvS2g9+/9VXe+1NCy/8
         WU+1w5AwYn0dVNCSbKdLJkg4gI7SlqaAj1+2ASl+qzFq26sNnKpGOlTz3G1xmcOdOk4w
         MUgg==
X-Gm-Message-State: AOAM530LQyKGchxCOTbTPpRUTvCY3wpAbyFKJOjnBybxZhVSSQqHSDLv
        B9xzH4uNVf9aIFLt2AVzwr/MC65455+Lpw==
X-Google-Smtp-Source: ABdhPJwc2D3WTmgD91HowB7ONlchko9SDK+zckp6hSejqBLb41ataTRX0PXFJg/Z4jqcNBc/HeXypQ==
X-Received: by 2002:a1c:a98f:: with SMTP id s137mr767271wme.5.1640145594024;
        Tue, 21 Dec 2021 19:59:54 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s8sm867300wra.9.2021.12.21.19.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 19:59:53 -0800 (PST)
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
Subject: [PATCH v6 09/17] hooks: convert non-worktree 'post-checkout' hook to hook library
Date:   Wed, 22 Dec 2021 04:59:35 +0100
Message-Id: <patch-v6-09.17-d3107034806-20211222T035755Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1146.gb52885e7c44
In-Reply-To: <cover-v6-00.17-00000000000-20211222T035755Z-avarab@gmail.com>
References: <cover-v5-00.17-00000000000-20211123T114206Z-avarab@gmail.com> <cover-v6-00.17-00000000000-20211222T035755Z-avarab@gmail.com>
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
index 72beeb49aa9..e2e95445407 100644
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
@@ -114,7 +115,7 @@ static void branch_info_release(struct branch_info *info)
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
2.34.1.1146.gb52885e7c44

