Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A53C4338F
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 17:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A69A60FD9
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 17:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbhHQRJ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 13:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbhHQRJV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 13:09:21 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25752C0613CF
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 10:08:48 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id q11so29687873wrr.9
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 10:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EPp3Mz0DC9MjlMnYCAKfV25Pr4V1EcMULCjq6Yxkm54=;
        b=HswZdt8+tUINTQHa/z1FLZmQlCyDA8nmY6a2iy2bqtZKQ+DoooyFhNFxARhxEyX94w
         S+c6csnonA0ATAxju3k9msY+NCH+zM38GJT0oZXMBKGZyPUKfawFTA7hCoFB80e139wa
         2F/s394QR5BCByR+WOAM1Hkl0AjluLa+llFGq5iF9epnI0h40bPmqGuELuRUT90QT7Ql
         DxfkcGh9NQ5jYqoFZYq/hcsHWP7iIZo4EcUEAxGJdaK34R6jXomX1dZ6+bWfSDNnDT7l
         p0TkCvlFWb/r9BtP8/Fcp98xM9kCl2vUUV04cnm2gVJp1u76NqFguJXBhYSRbiE5jioP
         2MgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=EPp3Mz0DC9MjlMnYCAKfV25Pr4V1EcMULCjq6Yxkm54=;
        b=Wg/zyBgByIGIAr6uDo592GrMiDQx+4BVfFPOCMKkf4s3JK5airExWjGaRo/KnOQIjH
         t+/E/x2Ep8epqFuw6hj18FsJ8x8H63O1UPCe/DUJX7/57XApKRnA97buYWEHTmB0IuuJ
         KcIbSjQaqC5Y5OEiDDMX5YjioX5STmEmAJKM+AC5QpDk/Kciwbdlj800n6rMUZj1R2HI
         NlRyf/Z59pzpmXg4PzxYh13di951f10xRnqLUav9cWerKckHGSBH4YyVMpcjBlC/OAe7
         Xrw0jkkcUNQnZUbh+4v2EmeHeM8JbiL00OytwS1F15FOEozsVSddrXrQeIOvz4OH1/3u
         DgZQ==
X-Gm-Message-State: AOAM533CjHc3d7MkT0OFj7qaIjee64iIeQyyUM/r6vc4ChWfMGgCKKos
        gx1KUEqcikWU/W43elq142ktBneRLhc=
X-Google-Smtp-Source: ABdhPJzLnw9vC3/cSGL2TPkFEVP3nAD1A3gqn6rq27BRet8jDph7Nld1Tyw7JtoUZPrABjDDARJIuw==
X-Received: by 2002:adf:8102:: with SMTP id 2mr5364280wrm.89.1629220126821;
        Tue, 17 Aug 2021 10:08:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t1sm2805703wma.25.2021.08.17.10.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 10:08:46 -0700 (PDT)
Message-Id: <9f50f11d394e46ffbe348a579792c2b683096452.1629220124.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1019.git.1629220124.gitgitgadget@gmail.com>
References: <pull.1019.git.1629220124.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Aug 2021 17:08:40 +0000
Subject: [PATCH 2/6] diff: ignore sparse paths in diffstat
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, stolee@gmail.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The diff_populate_filespec() method is used to describe the diff after a
merge operation is complete, especially when a conflict appears. In
order to avoid expanding a sparse index, the reuse_worktree_file() needs
to be adapted to ignore files that are outside of the sparse-checkout
cone. The file names and OIDs used for this check come from the merged
tree in the case of the ORT strategy, not the index, hence the ability
to look into these paths without having already expanded the index.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 diff.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/diff.c b/diff.c
index a8113f17070..c457cfa0e59 100644
--- a/diff.c
+++ b/diff.c
@@ -26,6 +26,7 @@
 #include "parse-options.h"
 #include "help.h"
 #include "promisor-remote.h"
+#include "dir.h"
 
 #ifdef NO_FAST_WORKING_DIRECTORY
 #define FAST_WORKING_DIRECTORY 0
@@ -3900,6 +3901,13 @@ static int reuse_worktree_file(struct index_state *istate,
 	if (!FAST_WORKING_DIRECTORY && !want_file && has_object_pack(oid))
 		return 0;
 
+	/*
+	 * If this path does not match our sparse-checkout definition,
+	 * then the file will not be in the working directory.
+	 */
+	if (!path_in_sparse_checkout(name, istate))
+		return 0;
+
 	/*
 	 * Similarly, if we'd have to convert the file contents anyway, that
 	 * makes the optimization not worthwhile.
-- 
gitgitgadget

