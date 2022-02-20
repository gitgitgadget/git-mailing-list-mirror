Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71C2C433F5
	for <git@archiver.kernel.org>; Sun, 20 Feb 2022 01:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237705AbiBTBaQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Feb 2022 20:30:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiBTBaP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Feb 2022 20:30:15 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9E0527ED
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 17:29:55 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id az26-20020a05600c601a00b0037c078db59cso8959703wmb.4
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 17:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=fo+OmbFe7YltWcC4DZ93Zqx1yYqpUZzcEEmkPsh3KlU=;
        b=GiIwHjfb+CsufNjJtb/5L7lWt6wmz4ohK76CJoRhq/dDN8OzcHz1fQeUam5ACZBPm3
         F+jdHyJvW2G1YVetBojibVEVwT+wOQtNpNygeYGJOyap0ah7dyycx15vkyw8qABn7/aS
         pPe/7mGw9cDYLPKasH8PHgbTjyGQTkgjT2x7XQmh3k5zrqbth8RUZJTRUqAtI5BSI9fg
         1Q/mIvkSJrKXIz7ZkVBsiDof0/zbC+ZCea3wLH/626k4yTw0ZOaUgPACtGA9dhoV6jLl
         CwHP2/Zm+fijtiFmDh6pO5wd3H+E9+W3WEUbws0ReSLOyWZk52TmcRryM2NUnglR5Xvb
         l1NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=fo+OmbFe7YltWcC4DZ93Zqx1yYqpUZzcEEmkPsh3KlU=;
        b=r0DFdpXYV9kBlTctDbxVuCMtKyQNwtJHFnBNMu+AzdCNxRu7J2D8XNhu5h/+DmSUzk
         QNx77ihYniYR2oFjHaNMmun3PSIo/GZ2ng+YMqbvbXQhI1s/yMT8iFQgBHqm+Iat76LM
         LfyMbbrTMm6ihXVtPzvSBhEDsMAnJzO5dFbOryJuS1wXE3OKUFc8/kNR4zLRHn7rI393
         E6cAMP/gG9A3lyDviZTr79HQXq8owjfo6UlVC5r+VK27oooO3vuWm0680UvqVf92bnjL
         wxCPW9w/5QgNIfKx3lAQnycZlev73mMjB/Ro4bUEyZAek+msXGGILY+y4bnnVQOMLkB2
         pLCA==
X-Gm-Message-State: AOAM533hbkEznqbcK8VTlFMkNb+L3uatVzTUY5hYCbSXNXnM4tTb9nyB
        A3sFD6HYNt4xj/8+RPOVd9PI/fe4fHo=
X-Google-Smtp-Source: ABdhPJxqftV8J/m3jiz6G4mZ62yVDcqvhEDF7ymEfzxXbY1VSx+TX5o1A/P2I47Mpi19xdhxf2c0rA==
X-Received: by 2002:a05:600c:2b82:b0:37b:fb77:aff with SMTP id j2-20020a05600c2b8200b0037bfb770affmr16531517wmc.152.1645320593492;
        Sat, 19 Feb 2022 17:29:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y6sm25132531wrd.30.2022.02.19.17.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 17:29:52 -0800 (PST)
Message-Id: <pull.1152.v2.git.1645320591.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.git.1645290601.gitgitgadget@gmail.com>
References: <pull.1152.git.1645290601.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 20 Feb 2022 01:29:49 +0000
Subject: [PATCH v2 0/2] Fix a couple small leaks in merge-ort
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Off-list, Ævar reported a few small leaks in merge-ort to me that I missed
previously. Here's a couple fixes.

Changes since v1:

 * Simplified patch 1 a bit as per Ævar's suggestion

Elijah Newren (2):
  merge-ort: fix small memory leak in detect_and_process_renames()
  merge-ort: fix small memory leak in unique_path()

 merge-ort.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)


base-commit: e2ac9141e64e2cd3e690d1b5fc848949827c09b4
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1152%2Fnewren%2Fmerge-ort-leak-fixes-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1152/newren/merge-ort-leak-fixes-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1152

Range-diff vs v1:

 1:  f0308de28e4 ! 1:  f1f7fc97fe2 merge-ort: fix small memory leak in detect_and_process_renames()
     @@ Commit message
                          free(combined.queue);
                  }
      
     -    The problem is that sometimes even when there are pairs, none of them are
     -    necessary.  Instead of checking combined.nr, we should check
     -    combined.alloc.  Doing so fixes the following memory leak, as reported
     -    by valgrind:
     +    The problem is that sometimes even when there are pairs, none of them
     +    are necessary.  Instead of checking combined.nr, just remove the
     +    if-check; free() knows to skip NULL pointers.  This change fixes the
     +    following memory leak, as reported by valgrind:
      
          ==PID== 192 bytes in 1 blocks are definitely lost in loss record 107 of 134
          ==PID==    at 0xADDRESS: malloc
     @@ Commit message
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## merge-ort.c ##
     +@@ merge-ort.c: static int detect_and_process_renames(struct merge_options *opt,
     + 				      struct tree *side1,
     + 				      struct tree *side2)
     + {
     +-	struct diff_queue_struct combined;
     ++	struct diff_queue_struct combined = { 0 };
     + 	struct rename_info *renames = &opt->priv->renames;
     +-	int need_dir_renames, s, clean = 1;
     ++	int need_dir_renames, s, i, clean = 1;
     + 	unsigned detection_run = 0;
     + 
     +-	memset(&combined, 0, sizeof(combined));
     + 	if (!possible_renames(renames))
     + 		goto cleanup;
     + 
      @@ merge-ort.c: simple_cleanup:
       		free(renames->pairs[s].queue);
       		DIFF_QUEUE_CLEAR(&renames->pairs[s]);
       	}
      -	if (combined.nr) {
     -+	if (combined.alloc) {
     - 		int i;
     - 		for (i = 0; i < combined.nr; i++)
     - 			pool_diff_free_filepair(&opt->priv->pool,
     +-		int i;
     +-		for (i = 0; i < combined.nr; i++)
     +-			pool_diff_free_filepair(&opt->priv->pool,
     +-						combined.queue[i]);
     +-		free(combined.queue);
     +-	}
     ++	for (i = 0; i < combined.nr; i++)
     ++		pool_diff_free_filepair(&opt->priv->pool, combined.queue[i]);
     ++	free(combined.queue);
     + 
     + 	return clean;
     + }
 2:  73bc1e5c5df = 2:  69fb932c21d merge-ort: fix small memory leak in unique_path()

-- 
gitgitgadget
