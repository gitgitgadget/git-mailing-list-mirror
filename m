Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B59C433E0
	for <git@archiver.kernel.org>; Sat,  6 Feb 2021 22:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D770B64E7B
	for <git@archiver.kernel.org>; Sat,  6 Feb 2021 22:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbhBFWxC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Feb 2021 17:53:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhBFWxB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Feb 2021 17:53:01 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FDDC06174A
        for <git@vger.kernel.org>; Sat,  6 Feb 2021 14:52:20 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id z6so12464813wrq.10
        for <git@vger.kernel.org>; Sat, 06 Feb 2021 14:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=QKa2ZoI1VRn+sJT7ub8POwYK7P+os0pSdh0IxjCEyLQ=;
        b=C+iDHcjffjOqroY+Y7Tun0moyBZqBnndKlNZ5Lk5BnjLOLygRaKhdmu/LtbN1q2YeU
         Gt64hU672uJsv9n3dFQXpXtk7WbFKq+jceu4sWWr5sRvmI7b1RMCwId3EzkADtUn8eVY
         MTIIsP+egrgaihzQmhfKWo/NHu98l5p136eLTkXdCSHuFbQ2AO3XEPVpn87XEa3VeRB3
         dQIB8ZGSwZa1CWstQiGDhDZocrae6mQ41+1AywgboMxMqWEOztCBflRmjn6ZTh6Qi/Rb
         0E2kysQyY+QzC9pE8tFqLp9ZIPFOwBeG7g29O9aJDa1gX8UOTPoGEk6qW/KJP4bSmjDd
         IePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=QKa2ZoI1VRn+sJT7ub8POwYK7P+os0pSdh0IxjCEyLQ=;
        b=VFGOYpez9bwsNmASMwlCvV1XfZo3NhYqHTM3fxEVtk3TbqzD+2fnD7rnN8zHnA1vnR
         MthM6P7k1kpW9P6Sy50Yh7nOvetx7eg+BdxHJ/0U5eoFkPHbz2tZRSk8bNpTl/saPEwT
         FQ9jrvvr8uxiXOE9WX+ixlA6L3l9q7ek6fyKYvz0WCU9DZiakvjHp4cnnO6nlTIxvNzq
         5eGkItHMgahjrLvDhKXRvw/y2FfPsIwdpjtMlrZ4dV7svVEoNq9cWxi810fwBNWNBmU5
         jk/xdLg59rA1UFJQzDD0tST3YUbpvBh1dyVBQ3BWNvqGJVysZ4bTXGjFu2dDxvI+9CeD
         wsQQ==
X-Gm-Message-State: AOAM531iRvcUdF/3woCMgi2lbqG9DiQ8otXSZS0PzlB9SRvT1Myzj7rf
        waUZi9Pj/GSmUqiyfbNOaLHSoFKIk5A=
X-Google-Smtp-Source: ABdhPJxERXSgYfs+XUVpHxFpqR+4FIjvfPtUbYumizMqNL7AUXg9bSk/Vtzi9NlDpE2iKIS7CvPztA==
X-Received: by 2002:a5d:54ce:: with SMTP id x14mr3460497wrv.182.1612651939271;
        Sat, 06 Feb 2021 14:52:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s6sm12617029wmh.2.2021.02.06.14.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Feb 2021 14:52:18 -0800 (PST)
Message-Id: <pull.843.git.1612651937.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 06 Feb 2021 22:52:14 +0000
Subject: [PATCH 0/3] Optimization batch 7: use file basenames to guide rename detection
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series depends on ort-perf-batch-6[1], which has not yet appeared in
seen despite being reviewed by both Junio and Stolee.

This series uses file basenames in a basic fashion to guide rename
detection. It represents "Optimization #3" from my Git Merge 2020 talk[2],
and is based on the fact that real world repositories tend to have a large
majority of the renames they have done in history be ones that do not affect
the basenames of the renamed files (in other words, they are simply moving
files into different directories). For the testcases mentioned in commit
557ac0350d ("merge-ort: begin performance work; instrument with
trace2_region_* calls", 2020-10-28), the changes in just this series
improves the performance as follows:

                     Before Series           After Series
no-renames:       13.815 s ±  0.062 s    13.138 s ±  0.086 s
mega-renames:   1799.937 s ±  0.493 s   169.488 s ±  0.494 s
just-one-mega:    51.289 s ±  0.019 s     5.061 s ±  0.017 s


As a reminder, before any merge-ort/diffcore-rename performance work, the
performance results we started with (as noted in the same commit message)
were:

no-renames-am:      6.940 s ±  0.485 s
no-renames:        18.912 s ±  0.174 s
mega-renames:    5964.031 s ± 10.459 s
just-one-mega:    149.583 s ±  0.751 s


[1] https://lore.kernel.org/git/xmqqlfc4byt6.fsf@gitster.c.googlers.com/ [2]
https://github.com/newren/presentations/blob/pdfs/merge-performance/merge-performance-slides.pdf

Elijah Newren (3):
  diffcore-rename: compute basenames of all source and dest candidates
  diffcore-rename: complete find_basename_matches()
  diffcore-rename: guide inexact rename detection based on basenames

 diffcore-rename.c | 181 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 177 insertions(+), 4 deletions(-)


base-commit: 7ae9460d3dba84122c2674b46e4339b9d42bdedd
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-843%2Fnewren%2Fort-perf-batch-7-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-843/newren/ort-perf-batch-7-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/843
-- 
gitgitgadget
