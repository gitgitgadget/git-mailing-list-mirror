Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 370C3C433F5
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 17:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243651AbiCBRLM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 12:11:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243652AbiCBRLJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 12:11:09 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC35A43ED2
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 09:10:25 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id m6so3811754wrr.10
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 09:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qIjPKGje/yiXpPz2zaWFShNGrY9YznoVw63CLzLPYc4=;
        b=KwfXV2m0cb1qHzcxYNMIOJd1cifHtB4FUfq5vs4rGBub2oMBXl320l8DTRh6zpRFo5
         ygkCEgfk8JzeVJ1AoaES7xDhCtj2nsXsrJI+mbqbwIjWeqEkqP9fcrg/T2lwakLhTgXf
         hon9llrjTmpQDY/QW8aGgfeoIH24imOrVHR0RyusPqBvWTxV+YNrb0CWVFA2zcks5pRW
         XBFcMCmVBxNySX7ct9vNtZak18w5+3lOxkVyJk3XG1A+p/gwrQzvzt4UKOjRIIA9K633
         dcyk7/MYWiPyEiSWQK20IDMY1JqQJtR84tNanaY+xzeTCOhznZztbF1uchVf2biGlAPH
         Eu2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qIjPKGje/yiXpPz2zaWFShNGrY9YznoVw63CLzLPYc4=;
        b=OpXnWlvuZ06UQXLyZidImReBBfGgYLPTiEjjtMUKqpR3c+9Hdzx1R0mpAfTJfCdCn9
         YrP2Y4Y0dwpsRYqh/VuDmlp7VyUoXxJIOt7zeafv1HmqbZePUQxolB5Eap2K1V08ZHC5
         fJDVWJZTR57TaJk+RSDkC0BfHAA5VXsfhGM30L/LNHJXWBZnJEPhAaC8xkq04CiKMzAj
         SwndGoCMFsoD02kVlRiPrAEqc3VEdP5+jthn1isFdF6H1a7J7ePlow8qWHOrQyglAsIm
         E4e7fR2oRzV5xVjTb+DaO/jrh+OSCgYR/y94Dg7dU0TAjoOrgxXFRCa12nGYpRI5wKFD
         MoXA==
X-Gm-Message-State: AOAM5331ZDzHdTsC/0K7BIirbAQTKmCWi5pshUiO9COPKlCGqeRg1Sud
        OytQ1lxb5gAhJj/HWHBS3dcAc7MKAblKkw==
X-Google-Smtp-Source: ABdhPJy4EfGZKq/G3kxG38YzRE9XZxOFzkKmffElfKLs1VwdX0YmzWNHzTyPz8f6aYFHImVVXmAtQg==
X-Received: by 2002:a5d:6d0f:0:b0:1f0:469d:42bb with SMTP id e15-20020a5d6d0f000000b001f0469d42bbmr1978851wrq.257.1646241023983;
        Wed, 02 Mar 2022 09:10:23 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p9-20020a05600c1d8900b003813b489d75sm6178001wms.10.2022.03.02.09.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 09:10:23 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 00/14] tree-wide: small fixes for memory leaks
Date:   Wed,  2 Mar 2022 18:10:06 +0100
Message-Id: <cover-00.14-00000000000-20220302T170718Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1228.g56895c6ee86
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a collection of various otherwise unrelated tree-wide fixes
for memory leaks.

In fixing more targeted memory leaks in specific areas I've run into
small leaks here & there. Rather than submit e.g. a 2-series patch for
just small bundle leaks, the same for range-diff etc. I thought it
made sense to submit these together.

Ævar Arnfjörð Bjarmason (14):
  index-pack: fix memory leaks
  merge-base: free() allocated "struct commit **" list
  diff.c: free "buf" in diff_words_flush()
  urlmatch.c: add and use a *_release() function
  remote-curl.c: free memory in cmd_main()
  bundle: call strvec_clear() on allocated strvec
  transport: stop needlessly copying bundle header references
  submodule--helper: fix trivial leak in module_add()
  commit-graph: fix memory leak in misused string_list API
  commit-graph: stop fill_oids_from_packs() progress on error and free()
  lockfile API users: simplify and don't leak "path"
  range-diff: plug memory leak in common invocation
  range-diff: plug memory leak in read_patches()
  repository.c: free the "path cache" in repo_clear()

 apply.c                     |  7 ++++++-
 apply.h                     |  2 ++
 builtin/bundle.c            |  1 +
 builtin/commit-graph.c      |  6 +++---
 builtin/config.c            |  2 +-
 builtin/index-pack.c        |  5 +++++
 builtin/merge-base.c        |  5 ++++-
 builtin/sparse-checkout.c   |  3 +--
 builtin/submodule--helper.c |  5 ++++-
 commit-graph.c              | 18 +++++++++++-------
 commit-graph.h              |  2 +-
 credential.c                |  1 +
 diff.c                      |  1 +
 path.h                      | 14 --------------
 range-diff.c                | 30 +++++++++++++-----------------
 remote-curl.c               | 12 ++++++++----
 repository.c                | 16 ++++++++++++++++
 repository.h                | 14 +++++++++++++-
 transport.c                 | 27 ++++++++++++++++-----------
 urlmatch.c                  |  5 +++++
 urlmatch.h                  |  1 +
 21 files changed, 113 insertions(+), 64 deletions(-)

-- 
2.35.1.1228.g56895c6ee86

