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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1CBC433E6
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 00:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E77564DEC
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 00:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbhBRAIT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 19:08:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhBRAIO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 19:08:14 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19A9C061574
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 16:07:33 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id v62so6268723wmg.4
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 16:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1Xya3mTSIesbgbx3CHuR6yO+uP1mkIR9eg+VYWQz7ZA=;
        b=Dxa9L15GQgcL8+Z/72bra1/Pq7cJk8GFMe2AUjsRHTkxVPXj0ijLWLjpTYqfPf9K1Y
         T63KBawdKn0jltPmM76mJEFiKwTTFY+mOttgTVpN6xLnvAVkie3YFiHhwUoW1sWg56B6
         VBQDjeW/NZfPdaTNE9mAe6JBXFstrjPAUh0KGMxkafKvWvk/L/vZ8gPEsV/voZpjvwgb
         nraLldL7PsuZwLnWfAbtkc0bPJJs7TdMxsKhibI1pODNmpvlQUjjVtxjxn8Moay+uPFw
         jqYKaDa9pWnZz2blsfdr2E+lJd6eHwQxZOpujPUsAR6xMxQfh+EnXHvdCrA2/9aaFO7d
         J7Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1Xya3mTSIesbgbx3CHuR6yO+uP1mkIR9eg+VYWQz7ZA=;
        b=o/ysl/SWErTygqI9hRDA0oX3ZPdh88Ze0wvzficWkU7X8aS7cJSdtXa/a/6stIJB1z
         FHqXHt3FCQ5+3BsHULRdGDuzqu2Of8fc+eEdKCrmDF42OmwNv7l2s/y5Yg1YXv6o6rBr
         x/onmexmlUYXlwOwy/MSwgHwzZDt1ZgwLvZu6X8m9GQ1BawQMqQnB4/UAVvnAkYLfR6n
         R/EfAhU+0SF+oM9CbxdbyHHmkiikOMcts2KKUWVO2z8+JU3HLEdwjNKPtB/Hf8XBcQwW
         4g7dzHnjXP6rnt92S9VfZaUMKGBYUJRrAyaw46yeEf3ib8oI2w9lgQvFl8FlcN29czhw
         HSRQ==
X-Gm-Message-State: AOAM531JvuvxJftx7/i+iLcdi8S8l8MKq0HUwCo4r8Sa+StZd3AeDkct
        LkS0dFWyGj70ZgNDPxcADMQDXC++M9nbjw==
X-Google-Smtp-Source: ABdhPJxHSpLDjiijfYrBEBhr7Q+d8Su5kwutAbXk/rUQj8Z6yU7YYmr+bZuYFcMoJDfUQ/22hh3Ygw==
X-Received: by 2002:a1c:cc08:: with SMTP id h8mr1115852wmb.188.1613606851792;
        Wed, 17 Feb 2021 16:07:31 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r17sm6232795wrx.82.2021.02.17.16.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 16:07:31 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 00/10] grep/pcre2: memory allocation fixes
Date:   Thu, 18 Feb 2021 01:07:18 +0100
Message-Id: <20210218000728.13995-1-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210204210556.25242-1-avarab@gmail.com>
References: <20210204210556.25242-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now based on "master", when I sent v1[1] it dependen on other
in-flight topics of mine.

Addresses minor issues with the commit messages raised by Johannes on
v1, and other commit message issues I noticed myself on re-reading
this.

1. https://lore.kernel.org/git/20210204210556.25242-1-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (10):
  grep/pcre2: drop needless assignment + assert() on opt->pcre2
  grep/pcre2: drop needless assignment to NULL
  grep/pcre2: correct reference to grep_init() in comment
  grep/pcre2: prepare to add debugging to pcre2_malloc()
  grep/pcre2: add GREP_PCRE2_DEBUG_MALLOC debug mode
  grep/pcre2: use compile-time PCREv2 version test
  grep/pcre2: use pcre2_maketables_free() function
  grep/pcre2: actually make pcre2 use custom allocator
  grep/pcre2: move back to thread-only PCREv2 structures
  grep/pcre2: move definitions of pcre2_{malloc,free}

 builtin/grep.c |  1 -
 grep.c         | 99 ++++++++++++++++++++++----------------------------
 grep.h         |  9 ++++-
 3 files changed, 51 insertions(+), 58 deletions(-)

Range-diff:
 1:  a11f1e91552 !  1:  40d2e47c540 grep/pcre2: drop needless assignment + assert() on opt->pcre2
    @@ Commit message
         There was never a good reason for this, it's just a relic from when I
         initially wrote the PCREv2 support. We're not going to have confusion
         about compile_pcre2_pattern() being called when it shouldn't just
    -    because we forgot to cargo-cult this opt->pcre2 option, and "opt"
    -    is (mostly) used for the options the user supplied, let's avoid the
    -    pattern of needlessly assigning to it.
    +    because we forgot to cargo-cult this opt->pcre2 option.
     
    -    With my in-flight removal of PCREv1 [1] ("Remove support for v1 of the
    -    PCRE library", 2021-01-24) there'll be even less confusion around what
    -    we call where in these codepaths, which is one more reason to remove
    -    this.
    +    Furthermore the "struct grep_opt" is (mostly) used for the options the
    +    user supplied, let's avoid the pattern of needlessly assigning to it.
     
    -    1. https://lore.kernel.org/git/xmqqmtwy29x8.fsf@gitster.c.googlers.com/
    +    With my recent removal of the PCREv1 backend in 7599730b7e2 (Remove
    +    support for v1 of the PCRE library, 2021-01-24) there's even less
    +    confusion around what we call where in these codepaths, which is one
    +    more reason to remove this.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
 2:  db0ef9189e3 !  2:  e02f9b5ab50 grep/pcre2: drop needless assignment to NULL
    @@ Commit message
         grep/pcre2: drop needless assignment to NULL
     
         Remove a redundant assignment of pcre2_compile_context dating back to
    -    my 94da9193a6e (grep: add support for PCRE v2, 2017-06-01). In
    -    create_grep_pat() we xcalloc() the "grep_pat" struct, so there's no
    +    my 94da9193a6e (grep: add support for PCRE v2, 2017-06-01).
    +
    +    In create_grep_pat() we xcalloc() the "grep_pat" struct, so there's no
         need to NULL out individual members here.
     
         I think this was probably something left over from an earlier
 3:  9c5429f4d96 =  3:  2bcb6c53589 grep/pcre2: correct reference to grep_init() in comment
 4:  e5558f5f0f1 !  4:  78477193cd4 grep/pcre2: prepare to add debugging to pcre2_malloc()
    @@ Commit message
         grep/pcre2: prepare to add debugging to pcre2_malloc()
     
         Change pcre2_malloc() in a way that'll make it easier for a debugging
    -    fprintf() to spew out the allocated pointer. This doesn't introduce
    -    any functional change, it just makes a subsequent commit's diff easier
    -    to read. Changes code added in 513f2b0bbd4 (grep: make PCRE2 aware of
    -    custom allocator, 2019-10-16).
    +    fprintf() to spew out the allocated pointer.
    +
    +    This doesn't introduce any functional change, it just makes a
    +    subsequent commit's diff easier to read. Changes code added in
    +    513f2b0bbd4 (grep: make PCRE2 aware of custom allocator, 2019-10-16).
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
 5:  7968effaa8a !  5:  cbeb521bd65 grep/pcre2: add GREP_PCRE2_DEBUG_MALLOC debug mode
    @@ Commit message
         grep/pcre2: add GREP_PCRE2_DEBUG_MALLOC debug mode
     
         Add optional printing of PCREv2 allocations to stderr for a developer
    -    who manually changes the GREP_PCRE2_DEBUG_MALLOC definition to
    -    "1".
    +    who manually changes the GREP_PCRE2_DEBUG_MALLOC definition to "1".
    +
    +    You need to manually change the definition in the source file similar
    +    to the DEBUG_MAILMAP, there's no Makefile knob for this.
     
         This will be referenced a subsequent commit, and is generally useful
         to manually see what's going on with PCREv2 allocations while working
 6:  604e183c224 =  6:  788929c3de6 grep/pcre2: use compile-time PCREv2 version test
 7:  f864a9aac4c !  7:  6a4552c6d4e grep/pcre2: use pcre2_maketables_free() function
    @@ Commit message
         grep/pcre2: use pcre2_maketables_free() function
     
         Make use of the pcre2_maketables_free() function to free the memory
    -    allocated by pcre2_maketables(). At first sight it's strange that
    -    10da030ab75 (grep: avoid leak of chartables in PCRE2, 2019-10-16)
    -    which added the free() call here doesn't make use of the pcre2_free()
    -    the author introduced in the preceding commit in 513f2b0bbd4 (grep:
    -    make PCRE2 aware of custom allocator, 2019-10-16).
    +    allocated by pcre2_maketables().
    +
    +    At first sight it's strange that 10da030ab75 (grep: avoid leak of
    +    chartables in PCRE2, 2019-10-16) which added the free() call here
    +    doesn't make use of the pcre2_free() the author introduced in the
    +    preceding commit in 513f2b0bbd4 (grep: make PCRE2 aware of custom
    +    allocator, 2019-10-16).
     
         The reason is that at the time the function didn't exist. It was first
         introduced in PCREv2 version 10.34, released on 2019-11-21.
     
         Let's make use of it behind a macro. I don't think this matters for
         anything to do with custom allocators, but it makes our use of PCREv2
    -    more discoverable. At some distant point in the future we'll be able
    -    to drop the version guard, as nobody will be running a version older
    -    than 10.34.
    +    more discoverable.
    +
    +    At some distant point in the future we'll be able to drop the version
    +    guard, as nobody will be running a version older than 10.34.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
 8:  cea9e066951 !  8:  bf58d597a4b grep/pcre2: actually make pcre2 use custom allocator
    @@ Commit message
         functions for allocation. We'll now use it for all PCREv2 allocations.
     
         The reason 513f2b0bbd4 worked as a bugfix for the USE_NED_ALLOCATOR
    -    issue is because it managed to target pretty much the allocation freed
    -    via free(), as opposed to by a pcre2_*free() function. I.e. the
    -    pcre2_maketables() and pcre2_maketables_free() pair. For most of the
    -    rest we continued allocating with stock malloc() inside PCREv2 itself,
    -    but didn't segfault because we'd use its corresponding free().
    +    issue is because it targeted the allocation freed via free(), as
    +    opposed to by a pcre2_*free() function. I.e. the pcre2_maketables()
    +    and pcre2_maketables_free() pair.
    +
    +    For most of the rest we continued allocating with stock malloc()
    +    inside PCREv2 itself, but didn't segfault because we'd use its
    +    corresponding free().
     
         In a preceding commit of mine I changed the free() to
         pcre2_maketables_free() on versions of PCREv2 10.34 and newer. So as
    @@ Commit message
             grep --threads=1 -iP æ.*var.*xyz
     
         Only use pcre2_{malloc,free}() for 2 malloc() calls and 2
    -    corresponding free() call. Now it's 12 calls to each. This can be
    +    corresponding free() calls. Now it's 12 calls to each. This can be
         observed with the GREP_PCRE2_DEBUG_MALLOC debug mode.
     
         Reading the history of how this bug got introduced it wasn't present
    @@ Commit message
         Thus the failed attempts to go down the route of only creating the
         general context in cases where we ourselves call pcre2_maketables(),
         before finally settling on the approach 513f2b0bbd4 took of always
    -    creating it.
    +    creating it, but then mostly not using it.
     
         Instead we should always create it, and then pass the general context
         to those functions that accept it, so that they'll consistently use
         our preferred memory allocation functions.
     
    -    1. https://public-inbox.org/git/3397e6797f872aedd18c6d795f4976e1c579514b.1565005867.git.gitgitgadget@gmail.com/
    +    1. https://lore.kernel.org/git/3397e6797f872aedd18c6d795f4976e1c579514b.1565005867.git.gitgitgadget@gmail.com/
         2. https://lore.kernel.org/git/CAPUEsphMh_ZqcH3M7PXC9jHTfEdQN3mhTAK2JDkdvKBp53YBoA@mail.gmail.com/
         3. https://lore.kernel.org/git/20190806085014.47776-3-carenas@gmail.com/
     
 9:  99eaa918261 !  9:  129adf872fb grep/pcre2: move back to thread-only PCREv2 structures
    @@ Commit message
         grep/pcre2: move back to thread-only PCREv2 structures
     
         Change the setup of the "pcre2_general_context" to happen per-thread
    -    in compile_pcre2_pattern() instead of in grep_init(), as happens with
    -    all the rest of the pcre2_* members of the grep_pat structure.
    +    in compile_pcre2_pattern() instead of in grep_init().
    +
    +    This change brings it in line with how the rest of the pcre2_* members
    +    in the grep_pat structure are set up.
     
         As noted in the preceding commit the approach 513f2b0bbd4 (grep: make
         PCRE2 aware of custom allocator, 2019-10-16) took to allocate the
         pcre2_general_context seems to have been initially based on a
         misunderstanding of how PCREv2 memory allocation works.
     
    -    This approach of creating a global context is just added complexity
    -    for almost zero gain. On my system it's 24 bytes saved per-thread, for
    -    context PCREv2 will then go on to some kilobytes for its own
    -    thread-local state.
    +    The approach of creating a global context in grep_init() is just added
    +    complexity for almost zero gain. On my system it's 24 bytes saved
    +    per-thread. For comparison PCREv2 will then go on to allocate at least
    +    a kilobyte for its own thread-local state.
     
         As noted in 6d423dd542f (grep: don't redundantly compile throwaway
         patterns under threading, 2017-05-25) the grep code is intentionally
    @@ Commit message
         structures globally, while making others thread-local.
     
         So let's remove this special case and make all of them thread-local
    -    for simplicity again.
    +    again for simplicity. With this change we could move the
    +    pcre2_{malloc,free} functions around to live closer to their current
    +    use. I'm not doing that here to keep this change small, that cleanup
    +    will be done in a follow-up commit.
     
         See also the discussion in 94da9193a6 (grep: add support for PCRE v2,
         2017-06-01) about thread safety, and Johannes's comments[1] to the
10:  462f12126c8 ! 10:  688d1b00d5d grep/pcre2: move definitions of pcre2_{malloc,free}
    @@ Commit message
         grep/pcre2: move definitions of pcre2_{malloc,free}
     
         Move the definitions of the pcre2_{malloc,free} functions above the
    -    compile_pcre2_pattern() function they're used it. Before the preceding
    -    commit they used to be needed earlier, but now we can move them to be
    -    adjacent to the other PCREv2 functions.
    +    compile_pcre2_pattern() function they're used in.
    +
    +    Before the preceding commit they used to be needed earlier, but now we
    +    can move them to be adjacent to the other PCREv2 functions.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
-- 
2.30.0.284.gd98b1dd5eaa7

