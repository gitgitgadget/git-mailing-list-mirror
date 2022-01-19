Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0909CC433EF
	for <git@archiver.kernel.org>; Wed, 19 Jan 2022 17:29:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356413AbiASR3p (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jan 2022 12:29:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356412AbiASR3o (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jan 2022 12:29:44 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70910C061574
        for <git@vger.kernel.org>; Wed, 19 Jan 2022 09:29:43 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 25-20020a05600c231900b003497473a9c4so15781809wmo.5
        for <git@vger.kernel.org>; Wed, 19 Jan 2022 09:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=d177RoXwBN4waEXcE0hYaWy8QTe4DCf5iLYnapbu+cE=;
        b=JQYCrFdFT0Et6C8CLhPMGDf/CT44BPMrHK1tCnzfnBtCH0WmvC3bcQE+9ImWIqCpes
         9Kl7alOMSzhTtxsKOia16iC3SCKsWzpRJ4eae3fmAH71ktM8Omax53sIv0Qo4chdn/Dz
         nXy5fUBBCy+zowtDE3h/P3p560C7ncYicDB6U8zHEk0eubg4P8dmVziJoocNoqW0zlxl
         CE2reSxavVIpp7coSVdGy5Usn8qv+CU4TVNEP2SsIE8CXuInOP7GoHVeGoSZpJB6FuQW
         cKLMIdsaDUPS6MHz276FJtytWBDRPBSD9MJqxsWUKjDN2mo+s68fDZr7jiUAeffwKweM
         am3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=d177RoXwBN4waEXcE0hYaWy8QTe4DCf5iLYnapbu+cE=;
        b=PM20QXy6ga/SxFBvrTbDbnXU8k/zFxBBnAOTIM8AvOE2DhFoM86bscoHFbtSe5TuRv
         jHb6Dhmgb8n2JNTzEhs739KKRT44URbOKRqp8ZbW8UAieaH5vjFNsqU21DswmDyHQ/ev
         ojzAnAfo/HrLecxzodBbdImjznl29T+vlnPKbc0S1UbFN8gx80myJ8Vg6t5EKcloZ3lT
         ylh62ZKf85ddrZq0Vw61hQxEogkqQMUoUTEGLMpwavHTW3e+9nYuifS/Vod255L+QDEl
         uNEsFhrT6chaNZ0YLJnJUnXmmtgIol1td25E2yWOSF3Hi2x8PyFQnqtTe0PbcfFD+P5N
         M+oA==
X-Gm-Message-State: AOAM530qNO4VheWGZRfzlf7FHQdfvrtERH8YMQ4mX5c6fzB1hO04UKqe
        +dEbQanCwr4+RljyhBpQB75GAyuh848=
X-Google-Smtp-Source: ABdhPJxNKcNGHQPEUmGtiwAzyRBGwdLwh305xJmA85bI0l/fCl9VSjlrsrMroWoB4yGLQpaNSSdRaw==
X-Received: by 2002:a5d:6848:: with SMTP id o8mr30294117wrw.2.1642613381913;
        Wed, 19 Jan 2022 09:29:41 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c18sm411720wrr.64.2022.01.19.09.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 09:29:41 -0800 (PST)
Message-Id: <d5c1440d9a9c943bf195a9d158c4badbd9a022a3.1642613380.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1119.git.1642613379.gitgitgadget@gmail.com>
References: <pull.1119.git.1642613379.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 19 Jan 2022 17:29:37 +0000
Subject: [PATCH 1/3] sparse-index: sparse index is disallowed when split index
 is active
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In 6e773527b6b (sparse-index: convert from full to sparse, 2021-03-30),
we introduced initial support for a sparse index, and were careful to
avoid converting to a sparse index in the presence of a split index.

However, when we _just_ read a freshly-initialized index, it might not
contain a split index even if _writing_ it will add one by virtue of
being asked for via the `GIT_TEST_SPLIT_INDEX` variable.

We did not notice any problems with checking _only_ for `split_index`
(and not `GIT_TEST_SPLIT_INDEX`) right until both
`vd/sparse-sparsity-fix-on-read` _and_ `vd/sparse-reset` were merged.

Those two topics' interplay triggers a bug in conjunction with running
t1091.15 when `GIT_TEST_SPLIT_INDEX=true` in the following way:
`vd/sparse-sparsity-fix-on-read` ensures that the index is made sparse
right after reading, and `vd/sparse-reset` ensures that the index is
made non-sparse again unless running in the `--soft` mode. Since the
split index feature is incompatible with the sparse index feature, we
see a symptom like this:

	fatal: position for replacement 4 exceeds base index size 4

Let's fix this by avoiding the conversion to a sparse index when
`GIT_TEST_SPLIT_INDEX=true`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sparse-index.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sparse-index.c b/sparse-index.c
index a1d505d50e9..08f54747bb4 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -136,7 +136,7 @@ static int is_sparse_index_allowed(struct index_state *istate, int flags)
 		/*
 		 * The sparse index is not (yet) integrated with a split index.
 		 */
-		if (istate->split_index)
+		if (istate->split_index || git_env_bool("GIT_TEST_SPLIT_INDEX", 0))
 			return 0;
 		/*
 		 * The GIT_TEST_SPARSE_INDEX environment variable triggers the
-- 
gitgitgadget

