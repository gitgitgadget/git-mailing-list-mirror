Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C4AC38A2A
	for <git@archiver.kernel.org>; Thu,  7 May 2020 13:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34BF120870
	for <git@archiver.kernel.org>; Thu,  7 May 2020 13:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKwC2+KG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgEGNRs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 09:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725879AbgEGNRr (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 May 2020 09:17:47 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79C5C05BD09
        for <git@vger.kernel.org>; Thu,  7 May 2020 06:17:45 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id u127so6780532wmg.1
        for <git@vger.kernel.org>; Thu, 07 May 2020 06:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=weKXCsP2M9DFkclCwIaqBScvevm4IdrU27uUPWoGnEw=;
        b=OKwC2+KGjgvy2WEoPmMeEMOsQBu/yhJSAfpnAWyPBoE0zNNnxBHHRpfNGphWgJgHm6
         25bP//1eRQgDqbN8lCUK5C2wn3HbJ+Y7q6BOAieiyhGU9RL3GP3cHHFRxZmI0ujMAaOG
         ZTZbQTs+o/gp7qdxh5MK/DQdaO8/X5KMpeLLSyvzviICsZnmk6f9/J2v1F9bU/j8ycsi
         8CsTzX41H9wsp33LEnj4BHrRIt1/bT9OCjoxVYT/OC9EccjW/gwP8R7XOWoqSbEu1aya
         wwau7K5xaatWMAeuWInuRBWKzhlrHoLEsDiIjJ3MTuBbQGJOVan8FKkw4xO2kAiws/Pi
         DacQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=weKXCsP2M9DFkclCwIaqBScvevm4IdrU27uUPWoGnEw=;
        b=E4izbsJHBbzO5LPTn+1/UrxCg2izQbL7nGLeF4L53PFHf3hATw0tX94THYDbkfCN2M
         xwlPR1AieDlgXd78a8DsSETkCPhK6FUbPS/ATKRN2PjimVLJQ2uHAqekwQOi5Xv6OQL2
         vdn8cd85zxpmyBn5FXk9aXukArUarYuOYoaqeS9BELTBSThE2aNaQAhYr5n66WybAkjB
         wcP64qlx9WqPpZzENKplEdhCXsBMgqd2bYn7Nb44Nrhc52yZ34rtS/A8G22CyO+Z3nig
         0mWPerBfyPorx2e/T/DSgRWLyRrh65tUN4haNP+2qgZdnnZy8fvlx9PFQl+hq3SweXnm
         rlFg==
X-Gm-Message-State: AGi0PuZ7tAcyAuesZ2sPOJuWR10qgfIw54/t+LnCQUfxs2ylykxGaDZI
        mkNnGlls51HfQo7m0nKD6mpV+ew2
X-Google-Smtp-Source: APiQypK4SjdHehH0BguXaZiFLkyn35GQCQ66eCi32nlJ6QrbygPMbJbYLCxQKZWdKZagYf6NM+uZbw==
X-Received: by 2002:a1c:6a17:: with SMTP id f23mr9838212wmc.136.1588857464294;
        Thu, 07 May 2020 06:17:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 1sm8134268wmz.13.2020.05.07.06.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 06:17:43 -0700 (PDT)
Message-Id: <5bfe3f3fc8a99b3d4fdd4286da17cd935090c614.1588857462.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.627.git.1588857462.gitgitgadget@gmail.com>
References: <pull.627.git.1588857462.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 May 2020 13:17:33 +0000
Subject: [PATCH 01/10] unpack-trees: avoid array out-of-bounds error
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmaill.com, peff@peff.net, me@ttaylorr.com,
        jrnieder@gmail.com, Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The loop in warn_conflicted_path() that checks for the count of entries
with the same path uses "i+count" for the array entry. However, the loop
only verifies that the value of count is below the array size. Fix this
by adding i to the condition.

I hit this condition during a test of the in-tree sparse-checkout
feature, so it is exercised by the end of the series.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 unpack-trees.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 9a3ccd9d083..4f880f2da90 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -563,10 +563,11 @@ static int warn_conflicted_path(struct index_state *istate,
 	add_rejected_path(o, WARNING_SPARSE_UNMERGED_FILE, conflicting_path);
 
 	/* Find out how many higher stage entries at same path */
-	while (++count < istate->cache_nr &&
+	while (i + ++count < istate->cache_nr &&
 	       !strcmp(conflicting_path,
 		       istate->cache[i+count]->name))
 		/* do nothing */;
+
 	return count;
 }
 
-- 
gitgitgadget

