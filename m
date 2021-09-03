Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7FDC433F5
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 17:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E3286054F
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 17:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349942AbhICREC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Sep 2021 13:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235624AbhICREB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Sep 2021 13:04:01 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF122C061575
        for <git@vger.kernel.org>; Fri,  3 Sep 2021 10:03:01 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id c42-20020a05683034aa00b0051f4b99c40cso7314239otu.0
        for <git@vger.kernel.org>; Fri, 03 Sep 2021 10:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i0iD+vz7KgoxYuEZtaazd2ip3HeFg0LThlLXb/cugXo=;
        b=Qw0nKVF3drGN3ewdQUZpgmPcCG0xtTQKkpkExlBhwX+IsIFV7tSM4VYcdRvlU4wDhJ
         kqBdObHzj3bb6OenDqwIp6exsP7NgMReyJoVuTjq/+PLcJ1EdmzGUAHHKyHpz6FYqMWU
         r+f8xGeoEVLbFnhZMszbKe7PsjAf/06MaJtrOkoXnrz6s/GCxFpWTgCH+7i/bxcNI6LS
         Hmz2c+xvQ/Fthk/O4qkeOv4H0hcQB5Mz5cHCc/frcPMHw1sJB7B+OFvyw4bu/AaODqe4
         Fas8DnqWZPWocxFOzWyJx37rNIitZ/QJhyRhE3qHx6jJTeXbcqNqepPm0O7eOqAkKOyZ
         xcnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i0iD+vz7KgoxYuEZtaazd2ip3HeFg0LThlLXb/cugXo=;
        b=cu+vVStfxb7dIp/IimW6ytjfbZrEgHnk8I/YSfUtwLWKkhC1iegxsM7eh5LapZQK7v
         kveSLX15JPYoZPg/9WruNGN3f+yA+3fvTWk9s/GMv37pfU2dVw5POdmIfe3I3J2f3UlM
         /yz7xGegmcNmNRs5pU68k3EQDze4fbnx9aHA2wnWD59sSW9M/QFx8hlM48DkzY2Rc8vK
         OKw9WvHx85x7TqUb11J7m6J5Q7M+3PeVukCR87UuIJxaW3kUADN5iWWnz7gRlkgoi3Zr
         oZznGSAVlr7iGpSRkA2iHism5hUz+4UhBD9EQvHIo8SguxMWSWWDLHgjYCVBVKSxn15p
         3K7w==
X-Gm-Message-State: AOAM533l4uMNuIU0AC+GXW15BYIx/TsGGc2gmn8lSxBLCBCFR0nongcB
        uWowLu8sC4mk81pr5d+TyqxPnIUnBMA=
X-Google-Smtp-Source: ABdhPJxa2VmyQL2Esby4pao7kCeov/LUWYyzu3gRjwV/Z5K/z4EsNrawyPe7J8y6evJAw7nxsui/xg==
X-Received: by 2002:a05:6830:2473:: with SMTP id x51mr60930otr.34.1630688580872;
        Fri, 03 Sep 2021 10:03:00 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id bf6sm1124044oib.0.2021.09.03.10.03.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Sep 2021 10:03:00 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, phillip.wood@dunelm.org.uk,
        sunshine@sunshineco.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v3 0/3] support pedantic in developer mode
Date:   Fri,  3 Sep 2021 10:02:29 -0700
Message-Id: <20210903170232.57646-1-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.481.g26d3bed244
In-Reply-To: <20210901091941.34886-1-carenas@gmail.com>
References: <20210901091941.34886-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series enables pedantic mode for building when DEVELOPER=1 is
used and as an alternative to only enabling it in one CI job, that
was merged to "seen" as part of cb/ci-build-pedantic.

The second patch is really an independent prerequisite to ensure
that it doesn't break the build for Windows and is the minimal change
possible.

Additional changes needed for the git-for-windows/git fork main to be
posted independently.

It merges and builds successfully all the way to "seen" IF the known
problem reported earlier[1] and expected as part of a reroll of 
jh/builtin-fsmonitor is merged first.

[1] https://lore.kernel.org/git/20210809063004.73736-3-carenas@gmail.com/

Carlo Marcelo Arenas Belón (2):
  win32: allow building with pedantic mode enabled
  developer: enable pedantic by default

Ævar Arnfjörð Bjarmason (1):
  gettext: remove optional non-standard parens in N_() definition

 Makefile                     | 22 ++--------------------
 compat/nedmalloc/nedmalloc.c |  2 +-
 compat/win32/lazyload.h      |  2 +-
 config.mak.dev               | 19 +++++++++++--------
 gettext.h                    | 24 ------------------------
 git-compat-util.h            |  4 ----
 6 files changed, 15 insertions(+), 58 deletions(-)

--
v3
- replace the first patch with an even better worded one from Ævar
- include minor changes needed for Windows
- version check new flags to avoid risk of breaking old compilers
- drop alternative
v2
- enable pedantic globally instead of single job as suggested by Phillip
- propose an alternative solution for USE_PARENS_AROUND_GETTEXT_N
v1
- create job to check for pedantic compilation (only in Linux, using
  Fedora)

2.33.0.481.g26d3bed244

