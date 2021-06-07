Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 437F7C47082
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 16:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D3016108E
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 16:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbhFGQ7n (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 12:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbhFGQ7n (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 12:59:43 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09D5C061766
        for <git@vger.kernel.org>; Mon,  7 Jun 2021 09:57:51 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id l9so106387wms.1
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 09:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=7qCf3ontfDcHznOWClKkgZv7dV1KEpJ7OSuarGY8XyY=;
        b=oZMWouJvpUpmHA74Wq7DxFHqvVWe4XMcEVLgzvu0/mP3+svdJ76cph3fO0bAFqRNF6
         U7tGEeOrpUAjpbArddQEmTpJ4V3z4kGzXxXBcuqMDHnRL5H4kUEkQJ8I5nh0VTp5VvyJ
         SyjTM6G+49THxDRR++bT3qvC6GT8jQQsyQ0G1sDBDhQbtOVlnWTWWU62mEzYXRRHZBuF
         B5I8D6TO874ZrTk8rWZEVYOu9w1yFgePwdm/vHh8pcZ4zmN3oyyvg/rrxabb+gT7I+RW
         7/tD62F5HkzfGAgFM9pqJE9YYT0eaG9YKP+Q8vyHaF4EL0ZIFqTA+Nleg8FQnICDNYlz
         oWvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7qCf3ontfDcHznOWClKkgZv7dV1KEpJ7OSuarGY8XyY=;
        b=hJVsO1qouVZd7YGVgyG97FANrjem9aWL/OyhO7IrtP2XJeX+U0/aUm6unxO5khWxkx
         7NtwWREGM51m0d937SNnvuus3maJtytrHe4YVlcT5XsWVDGyOoaZ+8h2xe/5ulLe+nAE
         AN30vXtYseP6nsb6JjCAWxmRxsmnRNiIh8yTEfNtKJui6KS4SNWpQ353aTcJznIL6KHT
         bJYr3LrDp0YStJwyxKhBLgxZ1wEJk5pJXIt2Jot7QM16NdbedWIKhN9NtFlEZu6gBJYc
         26gnTZcRXrgTb3QR84SvId1fnIfixPcdsdDC/y3Ng+D7VsuSzYFYApgtLwv4RZGXMw2N
         0STg==
X-Gm-Message-State: AOAM531jdsPUnblJxFifNm+Dor3cIizeHxCI2zl94KAXt+r6SIQHObdj
        ne8LaRxp5uG2TzKsP3L/OG4PUH1P434=
X-Google-Smtp-Source: ABdhPJxe0im57dmhgRyIFpgPbgBBtqRfT+19un6Jga3PaXGeM6BKwzRF/HBFT3mrKaH5eKJ1TpdW9A==
X-Received: by 2002:a05:600c:d0:: with SMTP id u16mr43619wmm.155.1623085070531;
        Mon, 07 Jun 2021 09:57:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p187sm15501180wmp.28.2021.06.07.09.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 09:57:50 -0700 (PDT)
Message-Id: <pull.975.git.1623085069.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Jun 2021 16:57:44 +0000
Subject: [PATCH 0/4] Use singular "they" when appropriate
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sandals@crustytoothpaste.net, stolee@gmail.com,
        jrnieder@gmail.com, emilyshaffer@google.com,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In another topic, I claimed [1] that singular "they" was better than
"he/she" for gender neutrality.

[1]
https://lore.kernel.org/git/44d937a0-e876-e185-f409-a4fd61eae580@gmail.com/

The fact that singular "they" is less awkward to write and read seemed
obvious to me, so I did not back up my statement with any references or
reasons. The ensuing discussion did include reasons, especially brian m.
carlson's thoughtful message [2].

[2] https://lore.kernel.org/git/YKrk4dEjEm6+48ji@camp.crustytoothpaste.net/

This patch series officially adopts singular "they" as a contributor
guideline; see Patch 4 for the change to the guidelines and the reasoning
for the change. Before modifying the guidelines, documentation and comments
are updated to not use gendered pronouns, which provides examples of how to
use it.

I would appreciate ACKs in support on patch 4.

Thanks, -Stolee

Derrick Stolee (4):
  Documentation: use singular they when appropriate
  *: use singular they in comments
  *: fix typos
  CodingGuidelines: recommend singular they

 Documentation/CodingGuidelines                |  5 +++
 Documentation/SubmittingPatches               |  2 +-
 Documentation/git-push.txt                    |  4 +-
 .../using-signed-tag-in-pull-request.txt      | 38 +++++++++----------
 Documentation/user-manual.txt                 |  2 +-
 commit.c                                      |  2 +-
 config.c                                      |  2 +-
 config.h                                      |  2 +-
 contrib/hooks/multimail/git_multimail.py      |  4 +-
 date.c                                        |  2 +-
 pathspec.h                                    |  2 +-
 strbuf.h                                      |  2 +-
 t/t9300-fast-import.sh                        |  2 +-
 wt-status.c                                   |  2 +-
 14 files changed, 38 insertions(+), 33 deletions(-)


base-commit: c09b6306c6ca275ed9d0348a8c8014b2ff723cfb
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-975%2Fderrickstolee%2Fthey-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-975/derrickstolee/they-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/975
-- 
gitgitgadget
