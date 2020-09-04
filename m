Return-Path: <SRS0=BZy3=CN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E328CC43461
	for <git@archiver.kernel.org>; Fri,  4 Sep 2020 07:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB42E206D4
	for <git@archiver.kernel.org>; Fri,  4 Sep 2020 07:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DETxcD2G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbgIDHIn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Sep 2020 03:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbgIDHIm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Sep 2020 03:08:42 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57AEC061244
        for <git@vger.kernel.org>; Fri,  4 Sep 2020 00:08:41 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id w8so5480783ilj.8
        for <git@vger.kernel.org>; Fri, 04 Sep 2020 00:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WVXxbSVMN66tJfpoaEWIjvitec5JYimH9W3vJi4oapo=;
        b=DETxcD2GzfQdX9jHxv4AH4yUBt4sHFlFm5zR7WPSZaNEi+HzvvdNuZTIvNKRXR9Aot
         giKaR6zK6/ON83HqDhqeMVTZPoJ5Vh2I1zMqPJ88dkuJo0r89RrsfSDj23t3xZicadO6
         YHylvQJTeTAIL339kkAQCmJcDvJ/w2+JgB0FPQCuA3OpN8iLyc20/V7AUNjnpg4XqwWL
         nR8G+/iircTsmbCNnjh64ll6uOGG99S66BjrqvEDIrrRC8IeOQPJUoKR2nN+wfI+Bh/J
         5tgxZh4eXWq+mnNOZ8jdXjWx1Ux4aoHwJtEgpBpwEYq7amBvhGFczchC148mdG66tGbY
         gWjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=WVXxbSVMN66tJfpoaEWIjvitec5JYimH9W3vJi4oapo=;
        b=NAFmtUjyo50nt9G052gMYISKIJ3prVkDsE/BPpiInAptMDRuHiscFKOuLT+cXq51qH
         zE+3ZuRyOfyyulRe7ZbT7vEsTF2uNTK3r5BHU8oldP57cSb45K5MOBy+HrkNCaL9edP2
         ctLgqWh/CsR+QwttfZyzc0Og52Y1KE6dq+0m0d2LQsnmg9OAKWpJinBMarRQp6gYvTBv
         vN1WC7wV5UTGvk86NGBm9ntC2SnCO3wye1fvqoMV+mZllB1Bwq/6x4Yyi2WM5rJLsIwh
         jlifovONF5upygd5Gvar1NINL48/d2vp/wPTVUfNN81lmYWX/bPJas8UqOgQLoC7OD1x
         hULQ==
X-Gm-Message-State: AOAM532E8w1svTkYVl1hkjPi+pT+Xgwv4e3VtWJXn/dIwhRLTSUNU3f7
        SoAlCk90THsyRz5n+732F8H40OobdQ8=
X-Google-Smtp-Source: ABdhPJyZln5PkwljXX5H7DdLGM/mhOjwCaqaQRtvHJmo4TYsGFAltbKbVRYcAXGGZnjK2whU4ui3qw==
X-Received: by 2002:a92:dd04:: with SMTP id n4mr6913545ilm.70.1599203320578;
        Fri, 04 Sep 2020 00:08:40 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id n62sm2881950ild.36.2020.09.04.00.08.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Sep 2020 00:08:39 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 0/3] worktree: add -d shorthand for --detach & improve documentation
Date:   Fri,  4 Sep 2020 03:07:00 -0400
Message-Id: <20200904070703.47898-1-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series grew directly out of suggestions proposed in [1]. Its
purpose is twofold. First, it brings git-worktree in line with the other
"checkout a branch" commands git-switch and git-checkout by teaching it
-d as shorthand for --detach (which those other commands already
understand). Second, it enhances git-worktree documentation to emphasize
that `git worktree add <path>` creates a new branch by default, and to
discuss branch-based vs. throwaway worktrees, which may help newcomers
avoid creating unwanted new branches without realizing they are doing,
and later wondering why `git branch --list` shows branches they did not
intentionally create.

There was an earlier attempt[2] by Pratyush to add -d as shorthand for
--detach (though it did not enhance git-worktree documentation as the
current patch series does), however, that patch was never re-rolled
after reviewers pushed back on a few of the changes it made.

[1]: https://lore.kernel.org/git/CAPig+cQmqKiYWDWFH5eK2S6XPOi2t2+8Oas8yZa8R=bKLym3wQ@mail.gmail.com/
[2]: https://lore.kernel.org/git/20200125173744.4334-1-me@yadavpratyush.com/

Eric Sunshine (3):
  git-checkout.txt: document -d short option for --detach
  worktree: add -d short option for --detach
  git-worktree.txt: discuss branch-based vs. throwaway worktrees

 Documentation/git-checkout.txt |  1 +
 Documentation/git-worktree.txt | 13 +++++++++++++
 builtin/worktree.c             |  2 +-
 3 files changed, 15 insertions(+), 1 deletion(-)

-- 
2.28.0.618.gf4bc123cb7

