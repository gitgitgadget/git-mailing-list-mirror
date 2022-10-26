Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97712C38A2D
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 15:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234594AbiJZPgk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 11:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234581AbiJZPgi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 11:36:38 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31143103D89
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 08:36:37 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id z14so13495968wrn.7
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 08:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gjxCXTrFZniZT1XuIZbgKexDsunNSfqN+VYhcXXiWgs=;
        b=D8itmUhKkzirK9AHbwmATGzNVKiXlS9RMoWkWdGP5G818SxcEiYPhGqdN82u+C1hly
         me+G5pnufpI6C+AQM2MPmOEYuD9AvnHIU4u2a2/qX+jRFre9PTy5d20PcuPrSdZ2ceC9
         uYVaRV1XP4ZGBcrz+8dy1f8UQYPPXUEhUHtUOPnpOi7SUR785H7W3hIajyrJBdWS1tz2
         W3/HoD7M5TL8oOCdsLSdQgpaW/aOtzxt8W9pnfDdpezRF9kk4JUNPXvYz1/LAfad8xYL
         YGaorHk3Y8kEzALKZVr2sQbbL+/eSYIPvnJ28tZLjIzy9qs93nxUwAqqK8iA3IkZTzaM
         YZkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gjxCXTrFZniZT1XuIZbgKexDsunNSfqN+VYhcXXiWgs=;
        b=3n3nZb0HUyhM0G55ib7zh/AtpueELIo7dy4N1Sm9AhupYfM0j9VJ3l4w3AqhCP7TXA
         bp0f97QXtP1DrrByVvE5MzlD+bmmc+7kieziT9dO8fmKgIIGOYfQKPQRWTW7k7XS+AMp
         2i1sy2Z+vaWYcyP141AYznmDChZ2XY35DEu3hn/pBTL/zWWBWhyC/7i5Q8Hc+RAMN6L4
         TDcfCwOxN+zkIywov9f3ZW2tlKjrxy5JtW0QeoO5LLtVk/GY5XEkz404Fx9dT0zCyqmZ
         kYYqsPImZ3sFU+h5GDdvZKnMDmQA+YSPdykXmgjhiwZ/Hj7ZDwKtI399AQPX2IPpvjpi
         lzwQ==
X-Gm-Message-State: ACrzQf0Ja3g8+X+mKcaPP5yN3AAXzdHWqwmUXPAL4qr+eu5emGZCacVL
        9M37zF5OWMZOVt4KfhEWGIzO59xgsisQmA==
X-Google-Smtp-Source: AMsMyM6p5bSskcusyEH9qpQ5dIlgT90FqoIJN0ClRwG/1LXCOCGchDzmxvpUjTe4xc17agv63t4B0A==
X-Received: by 2002:a5d:6d06:0:b0:232:b56c:e5c3 with SMTP id e6-20020a5d6d06000000b00232b56ce5c3mr28016770wrq.506.1666798594242;
        Wed, 26 Oct 2022 08:36:34 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r1-20020a0560001b8100b002366f300e57sm5581884wru.23.2022.10.26.08.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 08:36:33 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 00/10] config API: make "multi" safe, fix numerous segfaults
Date:   Wed, 26 Oct 2022 17:35:13 +0200
Message-Id: <cover-00.10-00000000000-20221026T151328Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1251.g3eefdfb5e7a
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series is a follow-up to an earlier RFC Stolee sent about making
the *_multi() config API return non-NULL, and instead give you an
empty string list[1].

I also think that part of the config API is a wart, but that we should
go for a different solution. It's the only config function that
doesn't return an "int" indicating whether we found the key.

Code that wants to use the values should then check that return
value. I.e. Stolee's version allows you to do:

	const struct string_list *list = git_config_get_value_multi(key);
	for_each_string_list_item(item, list) { ... found = 1 ... }

Whereas in this proposal we instead do (same as for non-multi):

	if (!git_config_get_const_value_multi(key, &list))
		for_each_string_list_item(item, list) { ... found = 1 ... }

Mid-series that's made nicer by adjusting the string_list API to have
sensible "const"'s (so we don't need catsing), and using utility
functions from there. I.e. the recently added code in builtin/gc.c
becomes (Stolee's at [3]):

	if (!git_config_get_knownkey_value_multi(key, &list))
		found = unsorted_string_list_has_string(list, maintpath);

But anyway.

Once I started poking at this approach I discovered that we have a
much larger issue here than whether the top-level value is NULL or an empty list.

As noted I don't think it's an issue that the *_multi() returns NULL
if we have no key, that's easy to handle.

But *_multi() doesn't have the equivalent of a wrapper that coerces
the values on the list into one of our types (as in "git config
--type=<type>").

A not so well known edge case in our config format (see 8/10) is that
value-less keys are represented as NULL's, and a "struct string_list"
is perfectly happy to have a "char *string" member that's NULL.

I.e.:

	[a]key=x
	[a]key
	[a]key=y

Is represented as:

	{ "x", NULL, "y" }

Not, as existing code apparently expected:

	{ "x", "", "y" }

As a result existing code using *_multi() would segfault when reading
config like that. See 9/10, which fixes segfaults in 6 commits as old
as from 2015, and a couple of recent ones: One in the last release,
and one on "master" but not released yet.

The fix is thoroughly boring, we just start doing for *_multi() what
we've been doing for other config since Junio's 2008 fix (see 9/10) to
fix the same issue for non-multi config variables.

I.e. we provide a safer "I want strings, please" variant of the API,
just for *_multi(). At the culmination of this topic only the
test-helper uses the underlying unsafe API, and only because it needs
to check that we're still parsing the config correctly.

1. https://lore.kernel.org/git/pull.1369.git.1664287711.gitgitgadget@gmail.com/
2. https://lore.kernel.org/git/220928.868rm3w9d4.gmgdl@evledraar.gmail.com
3. https://lore.kernel.org/git/e06cb4df081bc2222731f9185a22ed7ad67e3814.1664287711.git.gitgitgadget@gmail.com/

Ævar Arnfjörð Bjarmason (10):
  config API: have *_multi() return an "int" and take a "dest"
  for-each-repo: error on bad --config
  config API: mark *_multi() with RESULT_MUST_BE_USED
  string-list API: mark "struct_string_list" to "for_each_string_list"
    const
  string-list API: make has_string() and list_lookup() "const"
  builtin/gc.c: use "unsorted_string_list_has_string()" where
    appropriate
  config API: add and use "lookup_value" functions
  config tests: add "NULL" tests for *_get_value_multi()
  config API: add "string" version of *_value_multi(), fix segfaults
  for-each-repo: with bad config, don't conflate <path> and <cmd>

 builtin/for-each-repo.c        |  14 ++-
 builtin/gc.c                   |  29 +-----
 builtin/log.c                  |   6 +-
 builtin/submodule--helper.c    |   7 +-
 builtin/worktree.c             |   3 +-
 config.c                       | 164 +++++++++++++++++++++++++++++----
 config.h                       | 110 ++++++++++++++++++++--
 pack-bitmap.c                  |   7 +-
 string-list.c                  |   6 +-
 string-list.h                  |   6 +-
 submodule.c                    |   3 +-
 t/helper/test-config.c         |   6 +-
 t/t0068-for-each-repo.sh       |  19 ++++
 t/t1308-config-set.sh          |  30 ++++++
 t/t4202-log.sh                 |  15 +++
 t/t5310-pack-bitmaps.sh        |  21 +++++
 t/t7004-tag.sh                 |  17 ++++
 t/t7413-submodule-is-active.sh |  16 ++++
 t/t7900-maintenance.sh         |  38 ++++++++
 versioncmp.c                   |  18 +++-
 20 files changed, 451 insertions(+), 84 deletions(-)

-- 
2.38.0.1251.g3eefdfb5e7a

