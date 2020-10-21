Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4743C388F9
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 13:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4243421D7B
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 13:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sAV3+7Lb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437029AbgJUNWk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 09:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436929AbgJUNWk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 09:22:40 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF05C0613CE
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 06:22:39 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id c16so2520128wmd.2
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 06:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=5DKHMtzOP+ekNwMvjOEYKBlgCiRxuXoYq9i0UeHQxBk=;
        b=sAV3+7LbTUQwVy38jtUaXO9HI0dlGrAdy6bMJFS7SWfY5H8kNuYvVckfl60t6c5YY+
         g1UHEEPZ/Xssp83HaJsmnCBkC3jMIFd5kD6Z41H+/QKrUN9Sd6ZqFW7WFYMY29wx8eSz
         J0iBieNaAq4EWjMrEBXYNDpedZzJDvdzIYMhYtAnJ/SxbMEaYev5qe+3EZPL6vMm7sxC
         Mkkq0SvcIiciGyn7B3UdrhyCRFigoyb/yDICcr1KkP6L20BRNVSPXpvfd8al3efvgOwV
         ZH9nte8N5kFPveDABM5qTOp15p4F4u8kolSm/bzq8PIT0GzaDR2QIJCKTLi3965QJzNJ
         my5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5DKHMtzOP+ekNwMvjOEYKBlgCiRxuXoYq9i0UeHQxBk=;
        b=CkrZKArWHWMH5lBKhopxgYaA6hN761/aAhgsSfYcBHTR4pYDMsK+7tVPzlOuqxpEdi
         CvbvjEDSxajQftSpn4QuXe6UtH/pPXhixe0TDDIAAKoYnTMISomUuVsS+QIvQKNtzu70
         Flwzp8m6EwxHcTqrIXSBiw+ftkku0VQc6ebO9WNOQ8yK+B0iLtbuGmNWCpsQWuk/AyvE
         /vRqIjVIzS10ELkOkIORDs2qdrqtmvb75FRJY+59ojVoFyfztWXn8R/2Wx8zckNqreqF
         0bK+Mnupkx1NwSU5LLrAhvG+xMSQO/VYjVjXxYZe+eZyzNKsWM6+Uriv/z4/bwvTOJe/
         kp+A==
X-Gm-Message-State: AOAM5322JWrj2zUMdYMNvk2VkdjLA6fQZOqvltp+AcGPaG3ElKgaJySu
        piZAJX5n0wRvviclGd8YEPepioB5cCM=
X-Google-Smtp-Source: ABdhPJwfXI/TFCVoLjuXqd8ukv8/dxq+h/UugCrAW1dmhlIJpGUeBmZ24ZXDg6y20irFRkm18L4LSQ==
X-Received: by 2002:a1c:9e12:: with SMTP id h18mr3551447wme.11.1603286558074;
        Wed, 21 Oct 2020 06:22:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d3sm4043985wrb.66.2020.10.21.06.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 06:22:36 -0700 (PDT)
Message-Id: <pull.895.git.git.1603286555.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 21 Oct 2020 13:22:31 +0000
Subject: [PATCH 0/4] Beginning of new merge strategy: New API, empty implementation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In this series, I try to show the new merge API I have developed in
merge-ort and show how it differs from that provided by merge-recursive. I
do this in four steps, each corresponding to a patch:

 * Provide the new merge-ort.h header file and an empty die-immediately
   implementation
 * Provide new merge-ort-wrappers.[ch] files, showing how to implement the
   old API using the new API. The wrappers make it easy to convert existing
   callsites, too.
 * Provide a demonstration of the flexibility of the new API and its
   separation of merging steps and updating the index/worktree steps, with a
   "fast-rebase". [Doesn't yet function since merge-ort.c is still an empty
   die-immediately implementation]
 * Provide the changes to merge, rebase, revert, and cherry-pick so that
   with an environment variable or config option the new or old backend can
   be called.

My next patch series will focus on testsuite changes needed to
simultaneously support both merge backends, keyed off an environment
variable (thus related to and building on patch 4). Let me know if I'm
submitting series too close together or otherwise need to tweak how I'm
sending these out...

Elijah Newren (4):
  merge-ort: barebones API of new merge strategy with empty
    implementation
  merge-ort-wrappers: new convience wrappers to mimic the old merge API
  fast-rebase: demonstrate merge-ort's API via temporary/hidden command
  merge,rebase,revert: select ort or recursive by config or environment

 Makefile              |   3 +
 builtin.h             |   1 +
 builtin/fast-rebase.c | 210 ++++++++++++++++++++++++++++++++++++++++++
 builtin/merge.c       |  26 +++++-
 builtin/rebase.c      |   9 +-
 builtin/revert.c      |   2 +
 git.c                 |   1 +
 merge-ort-wrappers.c  |  62 +++++++++++++
 merge-ort-wrappers.h  |  25 +++++
 merge-ort.c           |  52 +++++++++++
 merge-ort.h           |  49 ++++++++++
 sequencer.c           |  71 +++++++++++---
 12 files changed, 496 insertions(+), 15 deletions(-)
 create mode 100644 builtin/fast-rebase.c
 create mode 100644 merge-ort-wrappers.c
 create mode 100644 merge-ort-wrappers.h
 create mode 100644 merge-ort.c
 create mode 100644 merge-ort.h


base-commit: 69986e19ffcfb9af674ae5180689ab7bbf92ed28
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-895%2Fnewren%2Fort-api-with-empty-implementation-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-895/newren/ort-api-with-empty-implementation-v1
Pull-Request: https://github.com/git/git/pull/895
-- 
gitgitgadget
