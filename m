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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF64C43331
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 00:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8CAA64D99
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 00:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbhCKAiw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 19:38:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbhCKAih (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 19:38:37 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB67C061574
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 16:38:37 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id r10-20020a05600c35cab029010c946c95easo11768166wmq.4
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 16:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=kd5td6wc9FWn/SjExJSr1jffv9qVUuehEeLs/f0/N9o=;
        b=HEoEP0ffM8A2Qs6QS96VSn7MNtjmtiYYC1iJm7K7SwSb1uGqp/ZKLDMxjX4zpnFwpb
         uNQ9HZkJxkR3bEKpXSPqio3hzFmypQ9SFKi9RHyfcjsBaaV7j3N3NupbmNwpIbeH1JZY
         D/X0mWnfhnwnIGStrTtk9PHfgsHUTeMDmQr/I10fTX253E4UH/aDOpzKRoTRAwGSsgSS
         x0tqMuMHG8C2e1MAzvZmM9nnKF7m7xUYHba/B5oKmiY+KJAoMuuBfAQzBhpZvRs4KkNg
         N4e2BwiJykrH6klBZ9VuQVlSpHnmlXZSmcGJ6IPADbJQnRrEdXuHUKV4a5kpYo01/LtJ
         Oqow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=kd5td6wc9FWn/SjExJSr1jffv9qVUuehEeLs/f0/N9o=;
        b=pY+csx4NlcowLOzX8SGeNSRmYstrFLXWrlqxluB+csL7QS22J4dvbE2rfs1Jju2/7F
         /idsVPqYg9yHiGdYuaqnZqNoaBX5Wy6sh8fpmyXtEbxWgtwK6etSRznpeI2bwq/2sKE6
         Pf0x+3HoF+vnHNvwPTQa/43K80d0Ur0hIyGEJrKIEGq7/1UV97tC+91k7xTmxx8PZpU9
         mfqs9r+XfDCZmhwwphLCh9Em3loloex4FDfe5AMQM9xlGAzKSgXlHVM+SNkEAwaNbMJo
         Aa9/cHFnnAgLh+nr/mfb0Jp1TJfpbiPjwzoMImFcgcVJj7dlc18PY9TS4V5ZJZsotACy
         NsXw==
X-Gm-Message-State: AOAM5339w9r7QjCeT9gCtk0ZiNrMs40d2/IHpG8n6TA0rsq3PznSq7ka
        VZ2QxY/jeqI253vUPMY3j6M/lnl2tJ4=
X-Google-Smtp-Source: ABdhPJwEadQV7Byq3dTOXJO3lN6MR4HYy0RrH7G0Q6CxKJdzes7OiZdaqru/LO+8cW4ATYkhIlsUig==
X-Received: by 2002:a05:600c:c4:: with SMTP id u4mr5712144wmm.27.1615423116349;
        Wed, 10 Mar 2021 16:38:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a3sm1019488wrt.68.2021.03.10.16.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 16:38:36 -0800 (PST)
Message-Id: <375c9b36861b2068f34e3d6e5073ab768644a030.1615423112.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.845.v3.git.1615423111.gitgitgadget@gmail.com>
References: <pull.845.v2.git.1615248599.gitgitgadget@gmail.com>
        <pull.845.v3.git.1615423111.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 11 Mar 2021 00:38:29 +0000
Subject: [PATCH v3 6/8] merge-ort: use relevant_sources to filter possible
 rename sources
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The past several commits determined conditions when rename sources might
be needed, and filled a relevant_sources strset with those paths.  Pass
these along to diffcore_rename_extended() to use to limit the sources
that we need to detect renames for.

For the testcases mentioned in commit 557ac0350d ("merge-ort: begin
performance work; instrument with trace2_region_* calls", 2020-10-28),
this change improves the performance as follows:

                            Before                  After
    no-renames:       12.596 s ±  0.061 s     6.003 s ±  0.048 s
    mega-renames:    130.465 s ±  0.259 s   114.009 s ±  0.236 s
    just-one-mega:     3.958 s ±  0.010 s     3.489 s ±  0.017 s

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index 5840832cf3ed..eea14024c657 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -2208,7 +2208,7 @@ static void detect_regular_renames(struct merge_options *opt,
 	diff_queued_diff = renames->pairs[side_index];
 	trace2_region_enter("diff", "diffcore_rename", opt->repo);
 	diffcore_rename_extended(&diff_opts,
-				 NULL,
+				 &renames->relevant_sources[side_index],
 				 &renames->dirs_removed[side_index],
 				 &renames->dir_rename_count[side_index]);
 	trace2_region_leave("diff", "diffcore_rename", opt->repo);
-- 
gitgitgadget

