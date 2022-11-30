Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBAF0C4321E
	for <git@archiver.kernel.org>; Wed, 30 Nov 2022 20:31:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbiK3UbX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Nov 2022 15:31:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbiK3UbG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2022 15:31:06 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719CF5AE00
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 12:30:54 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id u6-20020a170903124600b00188cd4769bcso18542753plh.0
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 12:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xp+/M203iYfy919NkZCnyiA80gtUXY7ftoNwhtszETs=;
        b=me//wLPaOApCimDiqRtVnJQklUfwU+srnwBtY8d9UswKyFOfLnzOVGQENKf5Ljil9u
         Bd3BgPBx+6hGlP6SLIkKZf+EXNs7QaHef50y2g1SqWwHw2M1b11yZpMwGO/PDvo4aIqd
         1iCL8/tL05OPFUGzvfuqRswk8wKpjY4av/+aQIf+xpPl+wtjDYMyaKMeqx0Ff1ebpdoN
         WTvFd1qZlqNVBaGqW3WbdIj+DNUsJAyEnTpjlfpx397LczXuAYS7tNncwUlFKqnOccf/
         MEd315ybXKvgm63NaD0b7FYtCoJjxU6kWpYc9wCVLYLSas9Wvzsysjn6tmHpgorEWJDZ
         xYpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xp+/M203iYfy919NkZCnyiA80gtUXY7ftoNwhtszETs=;
        b=E8gsytIdxkHHSK+USbq5kLeiWHDWIUaPfpaqPK0LDRUMDXy5M5EGQtYYQK5fCxgSZm
         9XpB1PkgDKY9j9kzIfq2HVaQqMPkMMzrZFNSxVSRPxp9dfiYidt+QsJ3Vi5kGlHjvXd9
         T1qAdMjkHshYt2W3VjrPWT1NeBEpZ9QEsnqVRLeOhZpYK351RJccg9vk0UeA7+ggIw42
         yqm/7fuxc17dKLRUF2ii8Ot9aXP1Zox/VxHW4Pg+g7PnJFc4VwaWdljYbQDAni8EGEVR
         2+v3Wd5MNuzupmhckwzVGaRGBtZnDCbbfUW2oa/5R7dnIT7AcY/aYwjZFP9ootkdIXOl
         6nGw==
X-Gm-Message-State: ANoB5pksqZ5c7lhyK3EWFUzk8d+hsuwA0HGKDr7QdtvOF2WbpTlGONGH
        v0QNujAINaInC4y6iU3te3AUmV8qPoDnhvOE4P3zLuhMBHPXrfa7H4L7zm0KstiWO364DOhO2ey
        xj5NQn8YfGNlReDPAp6ztNgZoiOayleFa2IaskcmYav3i5avqXtGpooyIF2vDbruGlTonfCSNFz
        qp
X-Google-Smtp-Source: AA0mqf58xRQ9rPb2rIh/rgRpN0N7ma+y7aa6yTIjjdE4Xg52hf8zad7rTQcHov+lbbR8UtXqFNYaQtuhrg/bLeXZ+RJB
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:d086:b0:219:227d:d91f with
 SMTP id k6-20020a17090ad08600b00219227dd91fmr2321844pju.0.1669840253255; Wed,
 30 Nov 2022 12:30:53 -0800 (PST)
Date:   Wed, 30 Nov 2022 12:30:45 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <cover.1669839849.git.jonathantanmy@google.com>
Subject: [PATCH 0/4] Don't lazy-fetch commits when parsing them
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a follow-up from my previous email about the possibility of not
fetching when we know that we're fetching a commit [1]. I had to refactor a few
things mostly due to replace objects, so the number of patches might be larger
than you would expect. I tried to keep each patch small and easy to understand,
though.

Patches 1-3 contain some forward-compatibility and refactoring changes, and
patch 4 contains the actual logic change.

[1] https://lore.kernel.org/git/20221124004205.1777255-1-jonathantanmy@google.com/

Jonathan Tan (4):
  object-file: reread object with exact same args
  object-file: refactor corrupt object diagnosis
  object-file: refactor replace object lookup
  commit: don't lazy-fetch commits

 commit.c       | 18 ++++++++++++++--
 object-file.c  | 57 ++++++++++++++++++++++++++++++++++----------------
 object-store.h | 10 +++++++++
 3 files changed, 65 insertions(+), 20 deletions(-)

-- 
2.38.1.584.g0f3c55d4c2-goog

