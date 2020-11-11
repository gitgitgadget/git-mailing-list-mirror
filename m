Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FFEC56201
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 20:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F988207F7
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 20:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BjWowig7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbgKKUCa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 15:02:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727617AbgKKUC2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 15:02:28 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE01C0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 12:02:25 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id 33so3729738wrl.7
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 12:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Jocfg7YZWIu8+9smY849oOLeXDPASHAu3oPYwLRYkxg=;
        b=BjWowig7xxav1UeKU4zFsPoWyPHEdXqKEDjcF2MDHDTIjxA4C+Gmza75yuUKYNWP/A
         bhnn5mADGaJSUuWvM/NIwyRb3bd8e4DhSqBgLctv0WM3gwNxwKvpnoHoEf8oUCjoCePX
         8LiADQY5d1kth454sJZegpKwWZM6IGqiM1zFM5rWPcA6OWQggOO78C9yeEq9OU8W5sJu
         Kmuv7gkbwJb+gdplynBmYP5wyVFNvRdKwBUagCeiH83GB1+Qg1Ew7HkiJ7l2JeKR1E8p
         H1Fd2XxC+0z5Cob7lDb8LoplNWWg9LaDCZz3TvTbxNT6XNCj0HFLNxGv6TgRQuNZk9fL
         I9cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Jocfg7YZWIu8+9smY849oOLeXDPASHAu3oPYwLRYkxg=;
        b=sKvgCrXvqOS/zRtx+iIlvsX9P/6jC8xGOYcGV120i4FsxtggWBWxhCLcy3u4sWL9br
         ju5UU438bAiA/YQqFGV/xVWFcKcbSlysk711DIq8zkpjryXg+Vx4pA4xJWYrK7gnG2DX
         oJYsj3EME2jwOhpPHfhrKfRFBO7IWaKNLRcxlfXvcvATNWOQt0c/2FEnAeHwJXriMFQ9
         gho5m61qq3CnB6dFR9nRs0uU/cy9QrxHb2YHEpOTqOiTv8Og0zY/tBq7GxMt5kjCf1Un
         Zc+PeO80FqmMWpyCNecViU2d6AO8MF56mWP+dXfuIrOL5+zsw6cN2VocveR9KkBUOQC3
         FHng==
X-Gm-Message-State: AOAM53073B7tR9uO62ZRAO6Hco5DHKnvjaeLktMyXjMUQWhbomFwVNTK
        cnDD05HwT7FV/bbYufnHZt3NFhtElRA=
X-Google-Smtp-Source: ABdhPJx4lTsgV3gk4okXtgnZoyqtHcJfh9B7fk9ZPa/1DBbQ7o1zkfnlJx9YVq/exsvLG/EPfdjTsQ==
X-Received: by 2002:a5d:50c6:: with SMTP id f6mr25714685wrt.150.1605124944020;
        Wed, 11 Nov 2020 12:02:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f16sm3869585wrp.66.2020.11.11.12.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 12:02:23 -0800 (PST)
Message-Id: <pull.835.v6.git.git.1605124942.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v5.git.git.1604622298.gitgitgadget@gmail.com>
References: <pull.835.v5.git.git.1604622298.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 11 Nov 2020 20:02:06 +0000
Subject: [PATCH v6 00/15] Add struct strmap and associated utility functions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here I introduce new strmap, strintmap, and strset types.

Changes since v5:

 * Fixed a typo in forward declaration of struct mem_pool, spotted by
   Phillip. (Usage via pointers meant gcc & clang wouldn't complain.)

[1] 
https://lore.kernel.org/git/20180906191203.GA26184@sigill.intra.peff.net/

Elijah Newren (15):
  hashmap: add usage documentation explaining hashmap_free[_entries]()
  hashmap: adjust spacing to fix argument alignment
  hashmap: allow re-use after hashmap_free()
  hashmap: introduce a new hashmap_partial_clear()
  hashmap: provide deallocation function names
  strmap: new utility functions
  strmap: add more utility functions
  strmap: enable faster clearing and reusing of strmaps
  strmap: add functions facilitating use as a string->int map
  strmap: split create_entry() out of strmap_put()
  strmap: add a strset sub-type
  strmap: enable allocations to come from a mem_pool
  strmap: take advantage of FLEXPTR_ALLOC_STR when relevant
  Use new HASHMAP_INIT macro to simplify hashmap initialization
  shortlog: use strset from strmap.h

 Makefile                |   1 +
 add-interactive.c       |   2 +-
 attr.c                  |  26 ++--
 blame.c                 |   2 +-
 bloom.c                 |   5 +-
 builtin/difftool.c      |   9 +-
 builtin/fetch.c         |   6 +-
 builtin/shortlog.c      |  61 +--------
 config.c                |   2 +-
 diff.c                  |   4 +-
 diffcore-rename.c       |   2 +-
 dir.c                   |   8 +-
 hashmap.c               |  74 +++++++----
 hashmap.h               |  91 +++++++++++---
 merge-recursive.c       |   6 +-
 name-hash.c             |   4 +-
 object.c                |   2 +-
 oidmap.c                |   2 +-
 patch-ids.c             |   2 +-
 range-diff.c            |   6 +-
 ref-filter.c            |   2 +-
 revision.c              |  11 +-
 sequencer.c             |   4 +-
 strmap.c                | 178 ++++++++++++++++++++++++++
 strmap.h                | 268 ++++++++++++++++++++++++++++++++++++++++
 submodule-config.c      |   4 +-
 t/helper/test-hashmap.c |   9 +-
 27 files changed, 621 insertions(+), 170 deletions(-)
 create mode 100644 strmap.c
 create mode 100644 strmap.h


base-commit: d4a392452e292ff924e79ec8458611c0f679d6d4
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-835%2Fnewren%2Fstrmap-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-835/newren/strmap-v6
Pull-Request: https://github.com/git/git/pull/835

Range-diff vs v5:

  1:  af6b6fcb46 =  1:  af6b6fcb46 hashmap: add usage documentation explaining hashmap_free[_entries]()
  2:  591161fd78 =  2:  591161fd78 hashmap: adjust spacing to fix argument alignment
  3:  f2718d036d =  3:  f2718d036d hashmap: allow re-use after hashmap_free()
  4:  61f1da3c51 =  4:  61f1da3c51 hashmap: introduce a new hashmap_partial_clear()
  5:  861e8d65ae =  5:  861e8d65ae hashmap: provide deallocation function names
  6:  448d3b219f =  6:  448d3b219f strmap: new utility functions
  7:  5e8004c728 =  7:  5e8004c728 strmap: add more utility functions
  8:  fd96e9fc8d =  8:  fd96e9fc8d strmap: enable faster clearing and reusing of strmaps
  9:  f499934f54 =  9:  f499934f54 strmap: add functions facilitating use as a string->int map
 10:  3bcceb8cdb = 10:  3bcceb8cdb strmap: split create_entry() out of strmap_put()
 11:  e128a71fec = 11:  e128a71fec strmap: add a strset sub-type
 12:  34f542d9dd ! 12:  3926c4c97b strmap: enable allocations to come from a mem_pool
     @@ strmap.h
       
       #include "hashmap.h"
       
     -+struct mempool;
     ++struct mem_pool;
       struct strmap {
       	struct hashmap map;
      +	struct mem_pool *pool;
 13:  39ec2fa411 = 13:  562595224b strmap: take advantage of FLEXPTR_ALLOC_STR when relevant
 14:  d3713d88f2 = 14:  058e7a6b76 Use new HASHMAP_INIT macro to simplify hashmap initialization
 15:  24e5ce60f5 = 15:  9b494c26c1 shortlog: use strset from strmap.h

-- 
gitgitgadget
