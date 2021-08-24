Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FB1C4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 09:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D15861360
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 09:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235881AbhHXJQS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 05:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235862AbhHXJQQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 05:16:16 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DDFC061764
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 02:15:32 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id n5so17855125wro.12
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 02:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DRRhCmPxNctTEEwXAfd6mjBU0jSIXkKmNYsKiqfzKIU=;
        b=Z006BEpkBWYE5nAXY8r6wVzUbrN82EWyEWpzleYiHNAFlAgQbNhB9Yxb+ZC4isySFv
         VXiUHxB914+tD8JJbECTngnk0gEszECruwQF5dsdUpfaIfTQ0kZrQPSydZqg26iWknQI
         xnhtMnyuqJ8mWBxlLG6Rg+agOIHC35Lye4nLjIVdsX2yhWzFcIk5+k42mS4d1xlT9abz
         TzXM1keJOC2+/szh0KdRLUlbztsXG8RjbeN6IMO6aT8GlYegkoTFfc+gZVJ0JFHtS3Wo
         HfiH3TmIyy+pwEmTErWemYMaAeYJh7qQgJQBAgmjk991NxIP8aEo4OoiE4s1ELHrS6r8
         ozWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DRRhCmPxNctTEEwXAfd6mjBU0jSIXkKmNYsKiqfzKIU=;
        b=MoTXMfSoGkXMXYVo/NR9l/xZa+psWIt20pvGFkMtQTXptqp+jiFNFleN1NzYDGoIh8
         90UsJ4F7KC7ntClYKbbYdvOLbgA7tKnACv2D7zsErVt6fd19CcNQZ6koTEw068EMKY5w
         II5dII5NfoYy9scTPCgu2NJ+jFWl+/Kn29nYIKbHrBXDNvmUew49EhczvTQczjhsQx12
         uD7vTDpwLxpM+yS+cVCt5m4h6tFWM+9VYJbKyZ0lKgtnXVW3WwTE5XBGHV3jxDRQ1a2f
         UYYOwjIE4/gry8mgmTiyf2K8mNFD7/tQenBsDpgAQlkeLl9wwwBYtiyPhXRBz8wutenP
         vO/g==
X-Gm-Message-State: AOAM533ir1modKIvW01wxXK6MCAxicBbEUF5BNE338gzBIP7F2NTOWxP
        pUdfUGVkETmBKUAGvGJbU2qeYczcnqtygg==
X-Google-Smtp-Source: ABdhPJz5ydPOmlWrbTXiyslwbFQ545gSSYBvKNsbMxzOhOe4BicsLSHXodioWUpbo/zpew92PvK30w==
X-Received: by 2002:a05:6000:120c:: with SMTP id e12mr17917434wrx.130.1629796530967;
        Tue, 24 Aug 2021 02:15:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u8sm1853104wmq.45.2021.08.24.02.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 02:15:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/4] test-tool: split up "read-cache" tool
Date:   Tue, 24 Aug 2021 11:15:21 +0200
Message-Id: <cover-v2-0.4-00000000000-20210824T091204Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.663.gbaff4edb973
In-Reply-To: <cover-0.4-0000000000-20210607T115454Z-avarab@gmail.com>
References: <cover-0.4-0000000000-20210607T115454Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A re-roll addressing the feedback v1 got, see
https://lore.kernel.org/git/cover-0.4-0000000000-20210607T115454Z-avarab@gmail.com

I think the gist of that feedback from Emily was that v1 could be
understood as aiming to optimize the perf test, but the main reason
I'm doing this split up is to make the code easier to read. The
changed commit message summarizes both goals.

I also changed some nits in the code I spotted myself, e.g. "argc > 0"
checks to just "argc", and a simpler way of providing the "cnt"
default.

Ævar Arnfjörð Bjarmason (4):
  test-tool: split up test-tool read-cache
  test-tool: migrate read-cache-perf to parse_options()
  test-tool: migrate read-cache-again to parse_options()
  read-cache perf: add a perf test for refresh_index()

 Makefile                         |  2 ++
 t/helper/test-read-cache-again.c | 45 +++++++++++++++++++++++++
 t/helper/test-read-cache-perf.c  | 47 +++++++++++++++++++++++++++
 t/helper/test-read-cache.c       | 56 +++++++++++++-------------------
 t/helper/test-tool.c             |  2 ++
 t/helper/test-tool.h             |  2 ++
 t/perf/p0002-read-cache.sh       |  7 +++-
 t/t7519-status-fsmonitor.sh      |  2 +-
 8 files changed, 128 insertions(+), 35 deletions(-)
 create mode 100644 t/helper/test-read-cache-again.c
 create mode 100644 t/helper/test-read-cache-perf.c

Range-diff against v1:
1:  6e7fcd46934 ! 1:  adb3f989a29 test-tool: split up test-tool read-cache
    @@ Commit message
         test-tool: split up test-tool read-cache
     
         Since the "test-tool read-cache" was originally added back in
    -    1ecb5ff141 (read-cache: add simple performance test, 2013-06-09) it's
    -    been growing all sorts of bells and whistles that aren't very
    -    conducive to performance testing the index, e.g. it learned how to
    -    read config.
    +    1ecb5ff141 (read-cache: add simple performance test, 2013-06-09) the
    +    test-read-cache.c tool has been growing various features that make the
    +    code harder to read. I.e. sometimes running as a one-off, sometimes looping.
    +
    +    It's also been unconditionally reading config since
    +    dc76852df2f (fsmonitor: demonstrate that it is not refreshed after
    +    discard_index(), 2019-05-07), which introduces unnecessary noise into
    +    the performance test.
     
         Then in recent changes in e2df6c3972 (test-read-cache: print cache
         entries with --table, 2021-03-30) and 2782db3eed (test-tool: don't
    @@ Commit message
     
         I think that having one test tool do so many different things makes it
         harder to read its code. Let's instead split up the "again" and "perf"
    -    uses for it into their own tools.
    +    uses for it into their own small tools, this makes the main
    +    "test-read-cache.c" a simpler.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ t/helper/test-read-cache.c: static void print_cache(struct index_state *istate)
     +	};
     +
     +	argc = parse_options(argc, argv, "test-tools", options, read_cache_usage, 0);
    -+	if (argc > 0)
    ++	if (argc)
     +		usage_msg_opt("Too many arguments.", read_cache_usage, options);
      
      	initialize_the_repository();
2:  07f392e0878 ! 2:  a68fa4a6355 test-tools: migrate read-cache-perf to parse_options()
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    test-tools: migrate read-cache-perf to parse_options()
    +    test-tool: migrate read-cache-perf to parse_options()
     
         Change the newly added (but then mostly copy/pasted) read-cache-perf
         to use the parse_options() API. This will make things easier as we add
    @@ t/helper/test-read-cache-perf.c
     -		die("usage: test-tool read-cache-perf [<count>]");
     +	argc = parse_options(argc, argv, "test-tools", options,
     +			     read_cache_perf_usage, 0);
    -+	if (argc > 0)
    ++	if (argc)
     +		usage_msg_opt("Too many arguments.", read_cache_perf_usage,
     +			      options);
     +	if (cnt < 1)
3:  36f4072b131 ! 3:  a34e69eaa48 test-tools: migrate read-cache-again to parse_options()
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    test-tools: migrate read-cache-again to parse_options()
    +    test-tool: migrate read-cache-again to parse_options()
     
         Change the newly added (but then mostly copy/pasted) read-cache-perf
         to use the parse_options() API. I have no plans to further modify
    @@ t/helper/test-read-cache-again.c
      {
      	struct repository *r = the_repository;
     -	int i, cnt;
    -+	int cnt = -1;
    ++	int cnt = 2;
      	const char *name;
     +	struct option options[] = {
     +		OPT_INTEGER(0, "count", &cnt, "number of passes"),
    @@ t/helper/test-read-cache-again.c
     +	if (argc != 1)
     +		usage_msg_opt("Too many arguments.", read_cache_again_usage,
     +			      options);
    -+	if (cnt == -1)
    -+		cnt = 2;
    -+	else if (cnt < 1)
    ++	if (cnt < 1)
     +		usage_msg_opt("Need at least one pass.", read_cache_again_usage,
     +			      options);
      	name = argv[2];
4:  120a37acaef = 4:  e3648bf78c7 read-cache perf: add a perf test for refresh_index()
-- 
2.33.0.663.gbaff4edb973

