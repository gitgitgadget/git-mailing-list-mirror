Return-Path: <SRS0=XjWc=BM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A4DC433DF
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 06:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB6572076B
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 06:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LjThClTH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgHBGdO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Aug 2020 02:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbgHBGdM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Aug 2020 02:33:12 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5835AC061757
        for <git@vger.kernel.org>; Sat,  1 Aug 2020 23:33:12 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id b6so31325123wrs.11
        for <git@vger.kernel.org>; Sat, 01 Aug 2020 23:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=x7mt8q9mrmBv6ufF03Gh1PR5EdY4MRfFqXa2dOXs0tE=;
        b=LjThClTHRSK4IBFaHnjtKOmTOCP80GdJKbvg5e2gO4sodwjhRJ9Mj85hGPyWKUeGfo
         YolMaXAwcUPAxFrLD2xYUaOq921PuS5wBVdvnftzquOHmuFE2eQv4nyIilnxSgBMOnfl
         poskf+lVU8DERAWeTwmXhdnRrrmSM93yCCEdpuFKQhbTHve4vQzF+DTGARGjpCiLtqTp
         PEbx7jnCh2/GZDTz3eF/mRFpcli5gJRs0TxGziveBeZplMQ4l1NzhLWZnDXdmzMA/ZIj
         9g2HENHlkuI1MHvMVcfGeytj3XzUJgCFZlmXNOFcKLzfVo4QyQdyAsQGU6ErqAQ7aQCX
         xpuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=x7mt8q9mrmBv6ufF03Gh1PR5EdY4MRfFqXa2dOXs0tE=;
        b=GQaAyUTSnCwwYuaNWXyejDNiMQM8GQfi39bvmxx1ZXsLr4Fv3zxkX2LaWxm3q5c6Kk
         z8VfH/abaDGuiMUUdxmZwcvt0JSjLaeuX8ctVen6JBcsq3rWlyhSJfCL5iMlMivkBCyf
         +Gkbv4/ANfZIfJHLC0iQzq1l3YM5oYGtirHa/PDobA1uxZs8UjBG484vnaTEkdGWWDql
         onWxjwQ2vG0/y3PW1M6cZL7YAj5w3iutYIz1RL48wyoeaC4eUTl2DVCqAmMTebPNpTxT
         aNFX7YmnTwIvgyAoOmPF7PY9J3jYrUvbdz05MRxcVH2JpMOan5cvFjCYoNYiIZGRBWzM
         vThA==
X-Gm-Message-State: AOAM533zrR9QpIK5yOFEhSEUQ+J0zF0GwmM13/vxNYzfD5fRBinVQQeO
        l7SPBN3PKLT7yx2MYOVikGbrLdRf
X-Google-Smtp-Source: ABdhPJzLl7cr8MYB2i9F+uF7x1PbrS/ed7zgCjXRKw0Ln3UshyLdoGnWqHQMuGz78++O+DmAVCgUKQ==
X-Received: by 2002:adf:e712:: with SMTP id c18mr10437676wrm.92.1596349991010;
        Sat, 01 Aug 2020 23:33:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z6sm19482367wrs.36.2020.08.01.23.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2020 23:33:10 -0700 (PDT)
Message-Id: <fcc7ea3add7fc0d3031a944b3da9b882f36981da.1596349986.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.825.git.git.1596349986.gitgitgadget@gmail.com>
References: <pull.825.git.git.1596349986.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 02 Aug 2020 06:33:06 +0000
Subject: [PATCH 4/4] checkout: support renormalization with checkout -m
 <paths>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/checkout.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 18c49034c4..2837195491 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -239,6 +239,8 @@ static int checkout_merged(int pos, const struct checkout *state, int *nr_checko
 	mmbuffer_t result_buf;
 	struct object_id threeway[3];
 	unsigned mode = 0;
+	struct ll_merge_options ll_opts;
+	int renormalize = 0;
 
 	memset(threeway, 0, sizeof(threeway));
 	while (pos < active_nr) {
@@ -259,13 +261,12 @@ static int checkout_merged(int pos, const struct checkout *state, int *nr_checko
 	read_mmblob(&ours, &threeway[1]);
 	read_mmblob(&theirs, &threeway[2]);
 
-	/*
-	 * NEEDSWORK: re-create conflicts from merges with
-	 * merge.renormalize set, too
-	 */
+	memset(&ll_opts, 0, sizeof(ll_opts));
+	git_config_get_bool("merge.renormalize", &renormalize);
+	ll_opts.renormalize = renormalize;
 	status = ll_merge(&result_buf, path, &ancestor, "base",
 			  &ours, "ours", &theirs, "theirs",
-			  state->istate, NULL);
+			  state->istate, &ll_opts);
 	free(ancestor.ptr);
 	free(ours.ptr);
 	free(theirs.ptr);
-- 
gitgitgadget
