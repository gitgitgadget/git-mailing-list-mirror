Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2993C433E0
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 01:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C9D020842
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 01:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AzalCoza"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbgHEBU7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 21:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbgHEBU4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 21:20:56 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F348C06174A
        for <git@vger.kernel.org>; Tue,  4 Aug 2020 18:20:56 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id oc8so3619183pjb.4
        for <git@vger.kernel.org>; Tue, 04 Aug 2020 18:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8RG+AJeDR2XAqHqxw/ffLwxdh9GBnIFmI50dSTPWFqg=;
        b=AzalCozaDMRPwB3D8DRYKqUPSkfuA+NhC/9HH/42HsMx1JqVwXlRAH5uelrJ/EcUNl
         g8iLfBbekm+W7KUu1b+49ykfrcIcG1HsNSwcbat1U+39tBqb6PpqELaVF1vKILEO4ywy
         jExcqKjd9emGs3Cg3sZlIDe/0rvajYUobO0U2oyv7ZhYU9OwzGKOOMlqhQDGL1Dr9Rs8
         9Gjmd9pfjP6u94RUT14opzu5RR62IrFAyL6sJ3cBTZ3iZZi6UP/oUXb4i7BrKlUIR260
         xn7kfJhhcWOmGFx0oNi/AQZwuJqIpEfUlO5Fao0rxWSKHLsD0fwNKzW01c3vKApTdhZW
         YcMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8RG+AJeDR2XAqHqxw/ffLwxdh9GBnIFmI50dSTPWFqg=;
        b=rCJBDgYslZsyjXo0HtjbVbwz4s3fJJXsvVMDQ90xM+uykW0NO1TbeR1x4bBjYFfshe
         TSsjwXCMmUaTaj1AGGkFZI5gw4ffkCF3hVAdM0LDGfFWbs1LN5HVGEWqk5CStV+hOMlb
         pUwCscpCKnKOWC2Bpp9Jp543U+I6Wec7mp5ththAFuUaryVJd8j0ZlswnyG2Fp9rQ3N1
         FL8kLsL5MhE1ORzHRw7qTccl4/N/0wNqfjXKSjNig+wlsyiCvin2bWQLB1SiZ0ID+PvP
         7jpARiDSJ5N840N+EuhheaP+lKSf8vwm3uqk1wOn6yFrp5NmWFO3JoJcqqdLkhbnbf43
         SaJw==
X-Gm-Message-State: AOAM532Nc9x0JqCa4Hwp0aEs/woKnOik5wEMRMq4URzaRFlHvMGND493
        0X+noEeJi3enjm7G//CqdiV61JhDr/3gaBt0CI90k+dLgOZ2N3hD7bLyfXs+0VOykKSPFaEekoG
        dg06OKgSCsheAZ/2X/VhRKEaLNLGJgPyNKmYniNWGqQ6aC31tqa98WXUpTKZX/AzYKMnae5d4H5
        GN
X-Google-Smtp-Source: ABdhPJwARoQIcX3Bhy/4GPIbxOmZDOqVbH5qCTAmu/2pNrC8sHrCyO41/c79HIu8vItg8fKGeOC+Cb8rZbJ4mo+O4ERM
X-Received: by 2002:aa7:9422:: with SMTP id y2mr1021452pfo.211.1596590455707;
 Tue, 04 Aug 2020 18:20:55 -0700 (PDT)
Date:   Tue,  4 Aug 2020 18:20:43 -0700
In-Reply-To: <20200724223844.2723397-1-jonathantanmy@google.com>
Message-Id: <cover.1596590295.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20200724223844.2723397-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [RFC PATCH 0/7] Lazy fetch with subprocess
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's some code that performs the lazy fetch in a subprocess. It was
more involved than I thought it would be, but here it is.

My main concern is the user-facing interface for the null fetch
negotiator. It not only does not negotiate at all but affects the
everything_local() check, so I wonder if it should be exposed
differently. More information is in the commit message for the 2nd
patch.

I know that the following still needs to be done, but I thought I'd send
out the patches for early feedback first since the main design and code
is already done:

 - Commit messages
 - User-facing documentation
 - A way to prevent a promisor-remote fetch from invoking another
   promisor-remote fetch (use a file as a lock?)
 - Remove no_dependents code (fetch-pack, transport)

Jonathan Tan (7):
  fetch-pack: allow NULL negotiator->add_tip
  fetch-pack: allow NULL negotiator->known_common
  negotiator/null: add null fetch negotiator
  fetch: --stdin
  fetch: submodule config
  fetch: only populate existing_refs if needed
  promisor-remote: use subprocess to fetch

 Documentation/config/fetch.txt   |  5 +++-
 Makefile                         |  1 +
 builtin/fetch.c                  | 42 +++++++++++++++++++++++------
 fetch-negotiator.c               |  5 ++++
 fetch-pack.c                     | 23 +++++++++++-----
 negotiator/null.c                | 34 +++++++++++++++++++++++
 negotiator/null.h                |  8 ++++++
 promisor-remote.c                | 46 +++++++++++++++-----------------
 repo-settings.c                  |  2 ++
 repository.h                     |  1 +
 submodule-config.c               |  5 ++--
 t/t0410-partial-clone.sh         |  2 +-
 t/t4067-diff-partial-clone.sh    |  8 +++---
 t/t5554-null-fetch-negotiator.sh | 22 +++++++++++++++
 t/t5601-clone.sh                 |  2 +-
 15 files changed, 157 insertions(+), 49 deletions(-)
 create mode 100644 negotiator/null.c
 create mode 100644 negotiator/null.h
 create mode 100755 t/t5554-null-fetch-negotiator.sh

-- 
2.28.0.163.g6104cc2f0b6-goog

