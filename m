Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A15DC433E1
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 12:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C7506198E
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 12:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbhCVMMP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Mar 2021 08:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbhCVMMI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Mar 2021 08:12:08 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30669C061574
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 05:12:08 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id 61so16411241wrm.12
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 05:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cQ+TzdREij/MgAEjxaN7QGG6VezBBk6BOaqWWm6NtF0=;
        b=cNkh9iz/KgnBP71a4EhjPFnG0ilLz99DfFvvo9roxDrAXe10vlPp9Df5wmGPcsjxVg
         2e75orsWUPED4YqQJ9ZtsmZSQo5/+AJUXIQhnzTvpgGfjvpLIb0eWbKPdFAWmh/bt9an
         LEgDI5U1dgq5DIeau0GyKOOUnMc6q+bDln0bothoTQGukycWgaeXAPRU8ujivzGRaxXu
         Csktjtqrkjy+Ds1G9ZJOMikqUUt6pALYvSfsN9cZiALjNbrLTBl0qMjz+8ajs5eb/bKV
         7yQLE9VrcH2LRG+j5AdiACDo0xWGsXAYJhGJ6G11QyZR6EvdAuV5wKPvgZ8YJPePoG6U
         pVbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cQ+TzdREij/MgAEjxaN7QGG6VezBBk6BOaqWWm6NtF0=;
        b=p9SDABgcGJoU0TwIG3oE1okx8DJ/3Z93zexx48661NVWD8hLZJuhRMWlYd2a/zdnop
         gBT8IkMatp0iVWeJgPqzefXx34dM4kfpbtdQIcbfYEW3a7JzgdJ8REak1zz4eR/r1hLa
         7TTObjGZUtL8DyY/94JVMCOms4Vhpd4Pu/glRUXtsQLlhdZaaFbxz8fVH41ppvowGj/P
         AtBYWfVf0CQKTjCvFPKu0cQlPawyXvucNDrZQzDIpMYeeor4XjL+pAlXAvRa4fSdmMs6
         NP8JwkwTmi3hznlXf5CvXrKyxbIEDw7G3E7k0w+LigCpBfOQjH5IbCqTxyrMoWMl6Kza
         cEUQ==
X-Gm-Message-State: AOAM533zmjIpV+nt3acClEUgwAGV/031gGRyL37MuBMOkX9tH98k0gVR
        E7iZgz5V9T3dYOnEW24zaRwgvghYLSOWqA==
X-Google-Smtp-Source: ABdhPJyLZTsNNc5Yp9+gMUk0+cZTHI19n/ZV73AKuBY78NM7brcvAtmdI8IlebswiUf5Z8F11pMs8A==
X-Received: by 2002:adf:ea8b:: with SMTP id s11mr18448563wrm.413.1616415126368;
        Mon, 22 Mar 2021 05:12:06 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j20sm15621142wmp.30.2021.03.22.05.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 05:12:05 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Wong <e@80x24.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 0/4] Makefile/coccicheck: fix bugs and speed it up
Date:   Mon, 22 Mar 2021 13:11:46 +0100
Message-Id: <cover.1616414951.git.avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.285.gb40d23e604f
In-Reply-To: <20210306192525.15197-1-avarab@gmail.com>
References: <20210306192525.15197-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A v4 (I'm counting the 5/4 patch I sent to v2 as a v3) which produces
the exact same end result as that v2 + 5/4 patch, but with a rewritten
commit message/squash as requested by Junio.

Ævar Arnfjörð Bjarmason (4):
  Makefile/coccicheck: add comment heading for all SPATCH flags
  Makefile/coccicheck: speed up and fix bug with duplicate hunks
  Makefile/coccicheck: allow for setting xargs concurrency
  Makefile/coccicheck: set SPATCH_BATCH_SIZE to 8

 Makefile | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

Range-diff:
1:  d3a2df76b04 = 1:  d8c6efd2464 Makefile/coccicheck: add comment heading for all SPATCH flags
2:  6b0901e0fc5 ! 2:  3bca3239cb8 Makefile/coccicheck: speed up and fix bug with duplicate hunks
    @@ Commit message
         Makefile/coccicheck: speed up and fix bug with duplicate hunks
     
         Change the coccicheck target to run on all of our *.c and *.h files
    -    with --no-includes, instead of only on the *.c files with
    -    --all-includes.
    -
    -    This speeds it up significantly and reduces its memory usage, since it
    -    doesn't need to parse N includes for every file it visits.
    -
    -    See [1] for a discussion thread about this commit with some timings
    -    for details, but briefly: This change speeds it up by ~2x and makes it
    -    use much less memory. Or a reduction of a max of around ~2GB
    -    per-process (under the old SPATCH_BATCH_SIZE=0) to around ~200MB.
    -
    -    Looking at the history of the coccicheck target I think we've always
    -    been running it in the wrong mode for what we wanted to achieve:
    -
    -     - When it was added in 63f0a758a06 (add coccicheck make target,
    -       2016-09-15) it explicitly processed only the %.c files.
    -
    -     - Then in a9a884aea57 (coccicheck: use --all-includes by default,
    -       2016-09-30) it started processing the %.h files by looking around for
    -       its own includes.
    -
    -    Let's instead just point it to both our *.c and *.h files, then
    -    there's no need to have it recursively look around for included files
    -    to change.
    -
    -    Setting --no-includes would not work if we expected to set
    -    COCCI_SOURCES to a subset of our source files, but that's not what
    -    we're doing here. If anyone manually tweaks COCCI_SOURCES they'll now
    -    need to tweak SPATCH_FLAGS too. The speed and correctness we gain is
    -    worth that small trade-off.
    -
    -    Using --no-includes also fixes a subtle bug introduced in
    -    960154b9c17 (coccicheck: optionally batch spatch invocations,
    -    2019-05-06) with duplicate hunks being written to the
    -    generated *.patch files.
    -
    -    This is because that change altered a file-at-a-time for-loop to an
    -    invocation of "xargs -n X". This would not matter for most other
    -    programs, but it matters for spatch.
    -
    -    This is because each spatch invocation will maintain shared lock files
    -    in /tmp, check if files being parsed were changed etc. I haven't dug
    -    into why exactly, but it's easy to reproduce the issue[2]. The issue
    -    goes away entirely if we just use --no-includes, which as noted above
    -    would have made sense even without that issue.
    -
    -    1. https://lore.kernel.org/git/20210302205103.12230-1-avarab@gmail.com/
    -    2. A session showing racy spatch under xargs -n X:
    -
    -        $ cat test.cocci
    -        @@
    -        expression E1;
    -        @@
    -        - strbuf_avail(E1)
    -        + strbuf_has(E1)
    -        $ for i in 1 2 4 16 64 128 512
    -        do
    -            echo with xargs -n $i: &&
    -            echo *.c | xargs -n $i spatch --sp-file \
    -                test.cocci --all-includes --patch . 2>/dev/null | \
    -            grep -F +++ | sort | uniq -c
    -        done
    -        with xargs -n 1:
    -              1 +++ b/convert.c
    -              1 +++ b/strbuf.c
    -        with xargs -n 2:
    -              1 +++ b/convert.c
    -              1 +++ b/strbuf.c
    -        with xargs -n 4:
    -              1 +++ b/convert.c
    -              1 +++ b/strbuf.c
    -        with xargs -n 16:
    -              1 +++ b/convert.c
    -              1 +++ b/strbuf.c
    -              2 +++ b/strbuf.h
    -        with xargs -n 64:
    -              1 +++ b/convert.c
    -              1 +++ b/strbuf.c
    -              2 +++ b/strbuf.h
    -        with xargs -n 128:
    -              1 +++ b/convert.c
    -              1 +++ b/strbuf.c
    -              2 +++ b/strbuf.h
    -        with xargs -n 512:
    -              1 +++ b/convert.c
    -              1 +++ b/strbuf.c
    -              1 +++ b/strbuf.h
    +    with --include-headers-for-types, instead of trusting it to find *.h
    +    files and other includes to modify from its recursive walking of
    +    includes as it has been doing with only --all-includes.
    +
    +    The --all-includes option introduced in a9a884aea57 (coccicheck: use
    +    --all-includes by default, 2016-09-30) is needed because we have rules
    +    that e.g. use the "type T" construct that wouldn't match unless we
    +    scoured our headers for the definition of the relevant type.
    +
    +    But combining --all-includes it with processing N files at a time with
    +    xargs as we've done since 960154b9c17 (coccicheck: optionally batch
    +    spatch invocations, 2019-05-06) introduced a subtle bug with duplicate
    +    hunks being written to the generated *.patch files. I did not dig down
    +    to the root cause of that, but I think it's due to spatch doing (and
    +    failing to do) some magical locking/racy mtime checking to decide if
    +    it emits a hunk. See [1] for a way to reproduce the issue, and a
    +    discussion of it.
    +
    +    This change speeds up the runtime of "make -j8 coccicheck" from ~1m50s
    +    to ~1m20s for me. See [2] for more timings.
    +
    +    We could also use --no-includes for a runtime of ~55s, but that would
    +    produce broken patches (we miss some hunks) in cases where we need the
    +    type or other definitions from included files.
    +
    +    If anyone cares there's probably an optimization opportunity here to
    +    e.g. detect that the whole file doesn't need to consider includes,
    +    since the rules would be unambiguous without considering them.
    +
    +    Note on portability: The --include-headers-for-types option is not in
    +    my "man spatch", but it's been part of spatch since 2014. See its
    +    fe3a327a (include headers for types option, 2014-07-27), it was first
    +    released with version 1.0.0 of spatch, released in April 2015. The
    +    spatch developers are just inconsistent about updating their TeX docs
    +    and manpages at the same time.
    +
    +    1. https://lore.kernel.org/git/20210305170724.23859-3-avarab@gmail.com/
    +    2. https://lore.kernel.org/git/20210306192525.15197-1-avarab@gmail.com/
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ Makefile: SPARSE_FLAGS ?=
      
      # For the 'coccicheck' target
     -SPATCH_FLAGS = --all-includes --patch .
    -+SPATCH_FLAGS = --no-includes --patch .
    ++SPATCH_FLAGS = --all-includes --include-headers-for-types --patch .
     +
      # For the 'coccicheck' target; setting SPATCH_BATCH_SIZE higher will
      # usually result in less CPU usage at the cost of higher peak memory.
3:  c913d5dbe9b ! 3:  9d5814dacdc Makefile/coccicheck: allow for setting xargs concurrency
    @@ Commit message
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Makefile ##
    -@@ Makefile: SPATCH_FLAGS = --no-includes --patch .
    +@@ Makefile: SPATCH_FLAGS = --all-includes --include-headers-for-types --patch .
      # Setting it to 0 will feed all files in a single spatch invocation.
      SPATCH_BATCH_SIZE = 1
      
4:  98225e65d30 ! 4:  51b782bb9b6 Makefile/coccicheck: set SPATCH_BATCH_SIZE to 8
    @@ Commit message
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Makefile ##
    -@@ Makefile: SPATCH_FLAGS = --no-includes --patch .
    +@@ Makefile: SPATCH_FLAGS = --all-includes --include-headers-for-types --patch .
      # For the 'coccicheck' target; setting SPATCH_BATCH_SIZE higher will
      # usually result in less CPU usage at the cost of higher peak memory.
      # Setting it to 0 will feed all files in a single spatch invocation.
5:  60649abddbb < -:  ----------- Makefile/coccicheck: use --include-headers-for-types
-- 
2.31.0.285.gb40d23e604f

