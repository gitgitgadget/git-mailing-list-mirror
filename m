Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7203EC2B9F4
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 13:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57B226128A
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 13:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233403AbhFNNG4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 09:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbhFNNGy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 09:06:54 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CCDC061574
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 06:04:51 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id c9so14467707wrt.5
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 06:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=ZyDVuFFpKbEgrv68/2qmnmQpQyVOjqDTEYtr5NR87i4=;
        b=lhRr1T2zvI56LGerfYhL1MpR9DUJegAZMOiZkLxFk61R54hYVEmfowzHSs7+/cf5SL
         afry4KNxYQ9CJ+CeF7VuFgZ+/JXZxXUsQ3ypHamBJYZjn/s95gXfEN/bxqRLRBAgLegY
         fw+AOKJDfIluIl9n/jx5NEVyZF/07HOhouxTFfNhko9ZY/0joiz5AKTaBwBi3G8Z4IsE
         6C3KV3zwmXiFQnAqWbBwQq5VCZWOlIKaT5ddwngpf/y0AkYcbxh8KoeU0O30sTU5fHdR
         gY6OTBFDQJmb0d4ba9h8ROPx/jtZ+igzv+90JBJGGlr20esnsOWc4NePTIIuQ+lOJzXJ
         haLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=ZyDVuFFpKbEgrv68/2qmnmQpQyVOjqDTEYtr5NR87i4=;
        b=nPeJMbXyfiVVy948SmX7EYFd4+b7YmtCo8y89hsHXOiHIi5To1bRZO1YwkLV2q8Cyc
         UTnXbyhe7nDx3HgoMD8pFmCS7cIAHx3zjW7EUmZG48C3mw+My1F8DJN3H5Zb9b0eRf5g
         OJcukbufKX0kRLcm9EKL1M+fhRGpE0g1neGSt85C/AE2gOaony6WdaypoCyP4t9WiRB9
         z83AsIM2ecjToA/M1Vlg22R3wUdzt+FxCIJe3nqtgps/zC7XFOgnZdNO8KopRzPpR9nQ
         kM4fPhuDPvxp9PWMw8cYNNVoN5lntMK/PHxAkzUsybJwXZDr0lsCKYKNJGsqqW4QxIz+
         y/gw==
X-Gm-Message-State: AOAM532ZKWVdIHuOVom3kc8Bo7GfPEihe9OVIeVwmubLUwIfotQrY77g
        1jd6Op29kUBqpqn2kICBu7Rt7sPV3ac=
X-Google-Smtp-Source: ABdhPJwaCqn5UYe6wJsVf0ZNX+ZZ56QlCzi/7m3rge7vDee09+nnnqY4lUxyK8vMPRTKyqIeTBpxtQ==
X-Received: by 2002:a5d:64ec:: with SMTP id g12mr18649377wri.137.1623675890457;
        Mon, 14 Jun 2021 06:04:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z12sm15784407wrw.97.2021.06.14.06.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 06:04:49 -0700 (PDT)
Message-Id: <pull.981.git.1623675888.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 14 Jun 2021 13:04:38 +0000
Subject: [PATCH 00/10] diff --color-moved[-ws] speedups
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The current implementation of diff --color-moved-ws=allow-indentation-change
is considerably slower that the implementation of diff --color-moved which
is in turn slower than a regular diff. This patch series starts with a
couple of bug fixes and then reworks the implementation of diff
--color-moved and diff --color-moved-ws=allow-indentation-change to speed
them up on large diffs. The time to run git diff --color-moved
--no-color-moved-ws v2.28.0 v2.29.0 is reduced by 33% and the time to run
git diff --color-moved --color-moved-ws=allow-indentation-change v2.28.0
v2.29.0 is reduced by 88%. There is a small slowdown for commit sized diffs
with --color-moved - the time to run git log -p --color-moved
--no-color-moved-ws --no-merges -n1000 v2.29.0 is increased by 2% on recent
processors. On older processors these patches reduce the running time in all
cases that I've tested. In general the larger the diff the larger the speed
up. As an extreme example the time to run diff --color-moved
--color-moved-ws=allow-indentation-change v2.25.0 v2.30.0 goes down from 8
minutes to 6 seconds.

Phillip Wood (10):
  diff --color-moved=zerba: fix alternate coloring
  diff --color-moved: avoid false short line matches and bad zerba
    coloring
  diff: simplify allow-indentation-change delta calculation
  diff --color-moved-ws=allow-indentation-change: simplify and optimize
  diff --color-moved: call comparison function directly
  diff --color-moved: unify moved block growth functions
  diff --color-moved: shrink potential moved blocks as we go
  diff --color-moved: stop clearing potential moved blocks
  diff --color-moved-ws=allow-indentation-change: improve hash lookups
  diff --color-moved: intern strings

 diff.c                     | 375 ++++++++++++++-----------------------
 t/t4015-diff-whitespace.sh | 137 ++++++++++++++
 2 files changed, 276 insertions(+), 236 deletions(-)


base-commit: 211eca0895794362184da2be2a2d812d070719d3
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-981%2Fphillipwood%2Fwip%2Fdiff-color-moved-tweaks-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-981/phillipwood/wip/diff-color-moved-tweaks-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/981
-- 
gitgitgadget
