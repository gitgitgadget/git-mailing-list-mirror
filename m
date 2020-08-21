Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 854DEC433E1
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 18:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 695DC20748
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 18:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q/yXuNuK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgHUSwl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 14:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbgHUSwc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 14:52:32 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A673C061573
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 11:52:32 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z18so2828938wrm.12
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 11:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=jKbc1wHESYrUyQ/VtL8BSb5A9xzE7PGcr1oSTJsRQ+M=;
        b=q/yXuNuKAGkNVPO6J5EDzusYYA7fUqvyd4csCRQpegTCqy6Ln8BmNsCAvnKhj15AJF
         uzJEDnUsG4j8gOV+wfC5VePGo7TQeoHBkhLjeC+5AUU/EhkrCICWBY4HzplgvklnmdEQ
         pGniOBsGUTgkFaMK/97StLQi7s4sknCdTWqG7RgagF13qqWlOHI3d/ZRkNiJ7aSGZT1E
         8qq9j6A9bOwAqS9ptwWKd+4TfVzj0IAjZU8kgAMdVunlizSHzO6mxr7kbZRq4Nc/8Lvq
         CLjyRPyp0aq/RnErqou1i47asj0KV4oJdX5JAW/RZsS03xcpkUUy53dGg/y1sEbvUoNN
         JifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jKbc1wHESYrUyQ/VtL8BSb5A9xzE7PGcr1oSTJsRQ+M=;
        b=U5YfEoVOv/s6rPKeO72NgNxVyjFohHtpfSs6+Nmbn4ysF2ztJvFGKhdkdDcqJK/zBA
         NYStwnZAwBQ5F4QULmg/p5DeOYEtoD7NyBCHHTodRg+MKFQ7eJaTTaHYGNJcRR1FC2m4
         dcSWHRsDwh2tufljrw3Cw+68AHJE7UCIczrXfdSD035jyC276YoQaGns83T5BPUZ9dzv
         POiuIHHigEyB7z0lE+IoNA5BEtjq2a9C7mjMVcJ+404k2dkN3pvJvpTLfO8EV9A3VhFL
         8bGRoHAu9M7qBvRIsyevnta9qnuZZaTe/Xo4lsXXpr/KvCXYz3fOEjQNP8nqPei7ciG1
         3saA==
X-Gm-Message-State: AOAM531BVJHbShg8sDfAzIPlhHjEKmXRSx98ip5qK3y9oFCCCukY63q1
        AGV1x2zoweMuOFUKP3EKvyMVTWh8VGg=
X-Google-Smtp-Source: ABdhPJwho1fFBjHUJttDmK7GoNnAW79hQIEDcvqjHVXP8chg4JrJLkg37bqbLRjbilZTQJRd976Zrg==
X-Received: by 2002:a5d:6381:: with SMTP id p1mr3818264wru.112.1598035950712;
        Fri, 21 Aug 2020 11:52:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p8sm6346090wrq.9.2020.08.21.11.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 11:52:30 -0700 (PDT)
Message-Id: <pull.835.git.git.1598035949.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Aug 2020 18:52:24 +0000
Subject: [PATCH 0/5] Add struct strmap and associated utility functions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here I introduce a new strmap type, which my new merge backed, merge-ort,
uses heavily. (I also made significant use of it in my changes to
diffcore-rename). This strmap type was based on Peff's proposal from a
couple years ago[1], but has additions that I made as I used it. I also
start the series off with a quick documentation improvement to hashmap.c to
differentiate between hashmap_free() and hashmap_free_entries(), since I
personally had difficulty understanding them and it affects how
strmap_clear()/strmap_free() are written.

The biggest issue I know about currently concerns the convenience functions
for a string->integer mapping. I wanted such a mapping that didn't need to
allocate an extra int but instead works by just type-casting the void*
pointer to an int instead. That all seems to work, but I needed a separate
name for that type, and the problem is that I couldn't come up with a good
one as you'll see in the last patch. Suggestions for better naming are very
much welcome. As are, of course, suggestions for other API or implementation
improvements.

[1] 
https://lore.kernel.org/git/20180906191203.GA26184@sigill.intra.peff.net/

Elijah Newren (5):
  hashmap: add usage documentation explaining hashmap_free[_entries]()
  strmap: new utility functions
  strmap: add more utility functions
  strmap: add strdup_strings option
  strmap: add functions facilitating use as a string->int map

 Makefile  |   1 +
 hashmap.h |  27 +++++++++++-
 strmap.c  | 126 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 strmap.h  | 123 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 275 insertions(+), 2 deletions(-)
 create mode 100644 strmap.c
 create mode 100644 strmap.h


base-commit: 675a4aaf3b226c0089108221b96559e0baae5de9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-835%2Fnewren%2Fstrmap-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-835/newren/strmap-v1
Pull-Request: https://github.com/git/git/pull/835
-- 
gitgitgadget
