Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E57C433EF
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 02:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241974AbhLVC7E (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 21:59:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbhLVC7D (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 21:59:03 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C96EC061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 18:59:03 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id o19-20020a1c7513000000b0033a93202467so649420wmc.2
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 18:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ASgTJhBp0YooSRBkmv2k0EhvgvUFlN+/NuxWB7ZpCSc=;
        b=hM4dx3dnhsuFpQYc6MhspW20hN/EnNUZBrjw2/5u34mC+i43FIfRF0S84X+fI0CeoZ
         vF/qYH6GV2KT94wspmkWtKzkaPwgTJTNAsPey4cDhWV3LwHgpL5ufrNm9D/P9HsmcD7O
         o73lVUCbxyfd1SpTHMT3Rm/1ENWbzfsK2b9vykYx2+UhUMH7Avmd0QfVy6JDAmsOc8ji
         sqCSm30/LkLKc/6eIYefa1QUm8ncbeiF2ZBD6awCGpSCO7RhZrSphxXofE28TtBWS4bj
         MWCrJQPWUEQyas2nvxKm/LIsQosYIsrfaxNgFY7IPKblZEOSBJR9v6c03QZm+GFm6uqI
         xMkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ASgTJhBp0YooSRBkmv2k0EhvgvUFlN+/NuxWB7ZpCSc=;
        b=taZdWkcdX31K6IgeCx38c1vFiYmY6lRTkP3/GRsqDJ7Mz72///8BBfa8ZxLWZrMnXo
         87cIadqi2A4DLMZ7MyC5Jl6wMyBkhj7cy8OZd7sONutBirrhP9sMGJnwe9hVJth5JjBs
         tw4jhoqonDgpfFWB2apCyTu4FuaKJydLAnn+NUV4Cy0pXa2+6r4kDxoc42n81kKEuNLq
         Fjbejq3lAjx5qrmSCd9EfV7vpxAzBbi1a6GpaVlXFAABE1jxBBpOxxqeE1I2qp1KdAXG
         FEVo2K8FZrqFt1ZqSw71daLlkUEjqq6PA90Z+gSwdHj4yhjgsMdEMvuLFQDn8GdB0srL
         4EuQ==
X-Gm-Message-State: AOAM530xknRg9B1xqhGK1cH6LoVnq12/by/ySlnLCBDJxhEBO681I1pB
        tKe3UwODqkHobELS/Tg1hzWQbP2wYhQ=
X-Google-Smtp-Source: ABdhPJywNWQwj6u0+UAwXU8zqYSbMbWDAII31+vwkKW9XCbYnqcB5tSXzK8SdVgrWgMyCcJgICtkmA==
X-Received: by 2002:a05:600c:5025:: with SMTP id n37mr857597wmr.18.1640141940875;
        Tue, 21 Dec 2021 18:59:00 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n15sm611577wru.66.2021.12.21.18.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 18:59:00 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 0/7] grep: simplify & delete "init" & "config" code
Date:   Wed, 22 Dec 2021 03:58:50 +0100
Message-Id: <cover-v5-0.7-00000000000-20211222T025214Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1146.gb52885e7c44
In-Reply-To: <cover-v4-0.7-00000000000-20211203T101348Z-avarab@gmail.com>
References: <cover-v4-0.7-00000000000-20211203T101348Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A simplification and code deletion of the overly complex setup for the
grep API, no behavior changes. For v4 see:
https://lore.kernel.org/git/cover-v4-0.7-00000000000-20211203T101348Z-avarab@gmail.com/

This re-roll is rebased on the latest push-out to "master", now-landed
topic had a minor conflict with it in git.c.

Ævar Arnfjörð Bjarmason (7):
  grep.h: remove unused "regex_t regexp" from grep_opt
  log tests: check if grep_config() is called by "log"-like cmds
  grep tests: add missing "grep.patternType" config test
  built-ins: trust the "prefix" from run_builtin()
  grep.c: don't pass along NULL callback value
  grep API: call grep_config() after grep_init()
  grep: simplify config parsing and option parsing

 builtin/grep.c    |  27 +++++-----
 builtin/log.c     |  13 ++++-
 builtin/ls-tree.c |   2 +-
 git.c             |   1 +
 grep.c            | 124 ++++++++--------------------------------------
 grep.h            |  33 ++++++++----
 revision.c        |   4 +-
 t/t4202-log.sh    |  24 +++++++++
 t/t7810-grep.sh   |  19 +++++++
 9 files changed, 116 insertions(+), 131 deletions(-)

Range-diff against v4:
1:  d7d232b2b52 = 1:  b6a3e0e2e08 grep.h: remove unused "regex_t regexp" from grep_opt
2:  f853d669682 = 2:  c0d77b2683f log tests: check if grep_config() is called by "log"-like cmds
3:  a97b7de3a3c = 3:  f02f246aa23 grep tests: add missing "grep.patternType" config test
4:  f7d995a5a80 ! 4:  a542a352eab built-ins: trust the "prefix" from run_builtin()
    @@ builtin/ls-tree.c: int cmd_ls_tree(int argc, const char **argv, const char *pref
     
      ## git.c ##
     @@ git.c: static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
    - 			int nongit_ok;
    - 			prefix = setup_git_directory_gently(&nongit_ok);
    - 		}
    -+		assert(!prefix || *prefix);
    - 		precompose_argv_prefix(argc, argv, NULL);
    - 		if (use_pager == -1 && p->option & (RUN_SETUP | RUN_SETUP_GENTLY) &&
    - 		    !(p->option & DELAY_PAGER_CONFIG))
    + 	} else {
    + 		prefix = NULL;
    + 	}
    ++	assert(!prefix || *prefix);
    + 	precompose_argv_prefix(argc, argv, NULL);
    + 	if (use_pager == -1 && run_setup &&
    + 		!(p->option & DELAY_PAGER_CONFIG))
     
      ## grep.c ##
     @@ grep.c: int grep_config(const char *var, const char *value, void *cb)
5:  ab1685f0dad = 5:  a33b00a247e grep.c: don't pass along NULL callback value
6:  8ffa22df8c7 = 6:  92b1c3958fa grep API: call grep_config() after grep_init()
7:  efbd1c50b43 = 7:  63de643ebc2 grep: simplify config parsing and option parsing
-- 
2.34.1.1146.gb52885e7c44

