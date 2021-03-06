Return-Path: <SRS0=58cf=IE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95F6C433E0
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 19:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3AB4650CF
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 19:35:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbhCFTfZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Mar 2021 14:35:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbhCFTfO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Mar 2021 14:35:14 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C26C06174A
        for <git@vger.kernel.org>; Sat,  6 Mar 2021 11:35:14 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id u16so6586542wrt.1
        for <git@vger.kernel.org>; Sat, 06 Mar 2021 11:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m9xjruj01KKxjuUTSQ4OgN+X211qPgTii+MuIYTuBCk=;
        b=uDZ2hDWHiJhj/DhU7bZKfbiHFmqW2LxipK8GYWKm6EEbQVQDFr/IcbYA/1BijaK8M/
         7P01KE4H6eQKElTG7Lyl9SX0HE/XPpcBc4uyW/rapYxlDM/zXZWFF8NcZlLFwj122eiI
         Q/r6wIjWfAsBg270eTqk7azH2FMFzIVaDNCLnxwKJETQnIFZ6qsEvufXQs3wqvPWStqT
         Imu7Vtr7eA2OFfc9pg0Ju/8Sm4Nb6QqAkobpwa7VrIgCpnnqiCUa2Y71W2h5/JVxLX2S
         aBBZ11+h1uXwI9jsDtfqw460MSk08veE288m1gtPcFRvF+oDt7hsZIJWZCMaDru1mVZc
         p2AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m9xjruj01KKxjuUTSQ4OgN+X211qPgTii+MuIYTuBCk=;
        b=FJEFx20na0ZWo7MxtQosz94Da09lS30yWhFIV07I68foF9V67Ft+HflwEmp+3yLETe
         Irsc9WA2aZ//7uHNlOMAo+2DolCLD1p+MKK1Uwl/BPWGON+xPifzVwxK5SMc6g+Rko6W
         Z94eIoWdNi618BkAOdbaXJ/OeFF0ehejhPvOl1vK/lWEi37G6EuWT0NMGxC7A/JGTctl
         8hkG8zWo7LI8WC55cIjPX0YwXioVsGCLg8bSiQCjENSdpz2h6FtTFInI47AH6LlDVvpR
         T5EAEnZzoMf/Qvpx3MkFXzwM3LTjYU5d12SBpx0nLbR3a93hTl12NjFp+D77h0QImfFh
         EyYQ==
X-Gm-Message-State: AOAM532FPVVwTBc3Z9Q/V4j49v44xRI/62fZui9BpjyO3lBbc2pLsRsN
        C6OZV1wAtuCkDwsVv4ibzYKVbfWFWENbYw==
X-Google-Smtp-Source: ABdhPJzM/KJPNKgxsMwFbNN0wcIlBwCxFvqUXWvfJ62jdEQGWT4t+bXUicHPuoUzEPFKoNBxqjutLQ==
X-Received: by 2002:adf:d84d:: with SMTP id k13mr15804197wrl.164.1615059312633;
        Sat, 06 Mar 2021 11:35:12 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a5sm9951578wrs.35.2021.03.06.11.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 11:35:12 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/7] Move the read_tree() function to its only user
Date:   Sat,  6 Mar 2021 20:34:51 +0100
Message-Id: <20210306193458.20633-1-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc0.126.g04f22c5b82
In-Reply-To: <1240014568-3675-1-git-send-email-pclouds@gmail.com>
References: <1240014568-3675-1-git-send-email-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a small cleanup series to remove move the last user of
read_tree() over to read_tree_recursive(), and while we're at it
adjust the API of read_tree_fn_t to its current use-case.

I found out after writing this that there had been a FIXME comment
(never made it into git.git) about this from mid-2009:
https://lore.kernel.org/git/1240014568-3675-1-git-send-email-pclouds@gmail.com/

Ævar Arnfjörð Bjarmason (7):
  tree.c API: move read_tree() into builtin/ls-files.c
  ls-files: don't needlessly pass around stage variable
  ls-files: remove cache juggling + sorting
  merge-ort: move cmp_cache_name_compare() from tree.c
  ls-files: refactor read_one_entry_quick() to use a strbuf
  tree.h API: remove support for starting at prefix != ""
  tree.h API: remove "stage" parameter from read_tree_recursive()

 archive.c          |  13 +++---
 builtin/checkout.c |   4 +-
 builtin/log.c      |   6 +--
 builtin/ls-files.c |  28 +++++++++++-
 builtin/ls-tree.c  |   4 +-
 merge-ort.c        |  10 ++++
 merge-recursive.c  |   4 +-
 tree.c             | 112 ++-------------------------------------------
 tree.h             |  11 +----
 9 files changed, 60 insertions(+), 132 deletions(-)

-- 
2.31.0.rc0.126.g04f22c5b82

