Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B4D0C4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 11:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1564861008
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 11:03:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236234AbhHWLDv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 07:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234997AbhHWLDt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 07:03:49 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE6EC061575
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 04:03:06 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id u15so10242334wmj.1
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 04:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1WtZtkqG3InMIqhzIDlQ7xvd08LY3B6ZEGXcYKecVq4=;
        b=HjJyw22EXoS8o1Yqi2Zzc0P+0e+olgPRjiqDZsdfjlg1FkS/NQBwGNhbuFH1Y+ae3p
         e0unFYY01BeqSdfrdaTwolePgxIDI5139GkzkCw0vnbz+xG9UxOVccSc4caZGcKN6Uxz
         vG6x8/NUOA950OPY4HMyMgefOgKWhiOZ2MngT8b8Gwu+XYFJHNiqnVIB+xr6G+N5fzTZ
         00l7dG3kdmN8+FNYuZXCj4OGpeQhcnZ6ELGBBHNbKLco8XGzLxku7g0UUlN19IRr5rj9
         8MQg7cewq7UR9tuHDC0p159xBuIM/UKo5NUx/v/NlMcWTsWl4+qe1r+WcOvs7+SZhybz
         WTmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1WtZtkqG3InMIqhzIDlQ7xvd08LY3B6ZEGXcYKecVq4=;
        b=Hu6RfntTY5rlpkbROCSS0zZBqtdxh+/efnwRh5aPYJoUhBvKFhAJyvmYwLojaMAtUQ
         JILQtnnrAyeihOq1f6o3vma0QVUSW5CnqVAsBj+7ymuTPDWHnBzVocJQVEOg96zQQYd2
         Og4FcpFZiHuT+uSUPXGZWoVSSElg8vt7jMhHjFNGlazq5tDVAx3jNVVHEStZuy3DTmNZ
         0m3i1yrqrTTtaexgTauXC4If2FcP+cq7R9fTexcuKUwd/Phqe5tUMviTjW8Nuh5yj8y3
         fLtD20nG/6Xn+GE4SWPJ2A0v47cNb7na0kifokJPVSnMa0BFV4urGmEteO8GpnCAotus
         Dy0w==
X-Gm-Message-State: AOAM533SFvJZoaACTK1rRDfpmZcANMfCz1FsA2h7/WbGFHMt8R90XzmT
        9L/WOtaT5LO1sB4JhU4WbOjCTVNttQKKFlKf
X-Google-Smtp-Source: ABdhPJxUCJPAs6qAEZlQstp7tmUjqTajA3TH7rweMCiYbLyc6vykAuYERA9D43QOMvOPlZnO2sLPFw==
X-Received: by 2002:a1c:f206:: with SMTP id s6mr15292974wmc.102.1629716585015;
        Mon, 23 Aug 2021 04:03:05 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l19sm13255493wmi.4.2021.08.23.04.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 04:03:04 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/4] bundle: show progress on "unbundle"
Date:   Mon, 23 Aug 2021 13:02:55 +0200
Message-Id: <cover-v2-0.4-00000000000-20210823T110136Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.662.g438caf9576d
In-Reply-To: <cover-0.4-0000000000-20210727T004015Z-avarab@gmail.com>
References: <cover-0.4-0000000000-20210727T004015Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This straightforward series addr progress output on "git bundle
unbundle", we already had progress output if bundles were fetched from
via the transport.c (i.e. "git clone/fetch" etc.), but not from "git
bundle unbundle" directly.

This was submitted as
https://lore.kernel.org/git/cover-0.4-0000000000-20210727T004015Z-avarab@gmail.com/
before v2.33, hopefully now with the release out these rather trivial
patches can be queued up. The only change since v1 is an extended
commit message in 3/4 discussing the initial motivation for this change.

Ævar Arnfjörð Bjarmason (4):
  bundle API: start writing API documentation
  bundle API: change "flags" to be "extra_index_pack_args"
  index-pack: add --progress-title option
  bundle: show progress on "unbundle"

 Documentation/git-index-pack.txt |  6 ++++++
 builtin/bundle.c                 | 16 ++++++++++++++--
 builtin/index-pack.c             |  6 ++++++
 bundle.c                         | 17 +++++++++++------
 bundle.h                         | 15 +++++++++++++--
 transport.c                      |  5 ++++-
 6 files changed, 54 insertions(+), 11 deletions(-)

Range-diff against v1:
1:  70865046bea = 1:  dc8591f6d0b bundle API: start writing API documentation
2:  f19af15c9da = 2:  3d7bd9c33be bundle API: change "flags" to be "extra_index_pack_args"
3:  98262f4cb89 ! 3:  67197064a8b index-pack: add --progress-title option
    @@ Commit message
     
         Add a --progress-title option to index-pack, when data is piped into
         index-pack its progress is a proxy for whatever's feeding it
    -    data. This option will allow us to set a more relevant progress bar
    -    title.
    +    data.
    +
    +    This option will allow us to set a more relevant progress bar title in
    +    "git bundle unbundle", and is also used in my "bundle-uri" RFC
    +    patches[1] by a new caller in fetch-pack.c.
    +
    +    1. https://lore.kernel.org/git/RFC-cover-00.13-0000000000-20210805T150534Z-avarab@gmail.com/
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
4:  853d72848a0 = 4:  e4ca8b26962 bundle: show progress on "unbundle"
-- 
2.33.0.662.g438caf9576d

