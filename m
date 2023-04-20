Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 105E0C77B73
	for <git@archiver.kernel.org>; Thu, 20 Apr 2023 07:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233999AbjDTHOM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Apr 2023 03:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjDTHOL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2023 03:14:11 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46551BF9
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 00:14:09 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id bi21-20020a05600c3d9500b003f17a8eaedbso2571694wmb.1
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 00:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681974848; x=1684566848;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/9E2EDfO2PXg922TlbxmSeykIDp89NFNE8og1Y2d2Cs=;
        b=mjToAFek6xFtmB05BPWKMbhpf6RL+/oaMAzqjjwYsj3hDo4QzQ8tHxSWbTueBNsmjX
         QoL0Ll6+a4ZJH0HUBHLK+kFd48J3gwmwp/2HB9Ny5pkBwU22G1QCWJcKnc5UUriguOPC
         GnSK1V9CYwxvKmUzzgIGPJGRCbVwLzOsU3ugGvAGOcxIgmo5LxCP/xIH8Mnx4z2nrOFn
         28s+SSEWk1R8LvYHM1XtVbVeM6T8Gxm75J/0nXAFjCUbgqQ1++1OrjI6ifI2KlwwsB+j
         pafDeWiLVR9z24aYe+VMymHzlyb6a89HVzhkM/XunCKmee4fi1v4L+rqMJrWfepCMlNX
         N3UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681974848; x=1684566848;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/9E2EDfO2PXg922TlbxmSeykIDp89NFNE8og1Y2d2Cs=;
        b=bqeTe3Be83jd3nWvFIHeDakChplaq9FWOiDnnk2T2gUfOBL8CONOJQhNkIYtYf/1kM
         2JC7OiB1Pknc0poC0B6c0M7NfEuhmDaqPZdTFr0RXjjcnXFmvz8Lr4FZ6tccptImsipX
         HdhEtQBK7+XXv/bs9f6yq7C5XRRsdEwf8imW7nq+0w31isG3C8bvJW0SfsMhGvj00EsL
         gyJGJj7+X3gYnY2G1xWqJEXqdqnv6VAJb8IsYUUxKFFspCjyFXHSS0TpKo7vJGCa+qLm
         ibLAAlNDy9XoxVUZmfG3i7shQdFgNWPns+NivFpokDdxW2nwTRjahJ1Ws9Sdx2OimKVw
         WOCA==
X-Gm-Message-State: AAQBX9efUs232a61W4qjhqq4rlc1RaIDF4+5vcPQspuqPdYJl45XqodZ
        fco+ijCJ9AjS2Da4hme/WG1xW4hQtBs=
X-Google-Smtp-Source: AKy350anRa2DvG5BV/C/aizxiIxNmtJmmPwT3UGaIv+GOdPpBpIRmKcqDqyPCPAMcujgBmnw0Ccpog==
X-Received: by 2002:a05:600c:2212:b0:3f1:75b3:60df with SMTP id z18-20020a05600c221200b003f175b360dfmr382290wml.41.1681974848019;
        Thu, 20 Apr 2023 00:14:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f4-20020a0560001b0400b002ffbf2213d4sm1126008wrz.75.2023.04.20.00.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 00:14:07 -0700 (PDT)
Message-Id: <pull.1518.git.1681974847078.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 20 Apr 2023 07:14:06 +0000
Subject: [PATCH] merge-ort: fix calling merge_finalize() with no intermediate
 merge
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

If some code sets up the data structures for a merge, but then never
actually performs one before calling merge_finalize(), then
merge_finalize() wouldn't notice that result->priv was NULL and
return early, resulting in following that NULL pointer and getting
a segfault.  There is currently no code in the git codebase that does
this, but this issue was found during testing of some proposed patches
that had the following structure:

    struct merge_options merge_opt;
    struct merge_result result;

    init_merge_options(&merge_opt, the_repository);
    memset(&result, 0, sizeof(result));

    <do N merges, for some value of N>

    merge_finalize(&merge_opt, &result);

where some flags could cause the code to have N=0, i.e. doing no merges.
Add a check for result->priv being NULL and return early to avoid a
segfault in these kinds of cases.

While at it, ensure the FREE_AND_NULL() in the function does something
useful with the nulling aspect, namely sets result->priv to NULL rather
than a mere temporary.

Reported-by: Derrick Stolee <derrickstolee@github.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
    merge-ort: fix calling merge_finalize() with no intermediate merge
    
    See
    https://lore.kernel.org/git/CABPp-BHCdjOutYqdMO1NbYKNA0BgkXRgwUEKK=MX0kXM-5G_DQ@mail.gmail.com/

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1518%2Fnewren%2Ffix-merge-finalize-with-no-merge-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1518/newren/fix-merge-finalize-with-no-merge-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1518

 merge-ort.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 5bf64354d16..cba3662e497 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -4718,14 +4718,14 @@ void merge_switch_to_result(struct merge_options *opt,
 void merge_finalize(struct merge_options *opt,
 		    struct merge_result *result)
 {
-	struct merge_options_internal *opti = result->priv;
-
 	if (opt->renormalize)
 		git_attr_set_direction(GIT_ATTR_CHECKIN);
 	assert(opt->priv == NULL);
 
-	clear_or_reinit_internal_opts(opti, 0);
-	FREE_AND_NULL(opti);
+	if (!result->priv)
+		return;
+	clear_or_reinit_internal_opts(result->priv, 0);
+	FREE_AND_NULL(result->priv);
 }
 
 /*** Function Grouping: helper functions for merge_incore_*() ***/

base-commit: 667fcf4e15379790f0b609d6a83d578e69f20301
-- 
gitgitgadget
