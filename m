Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 038B8C433EF
	for <git@archiver.kernel.org>; Wed, 29 Jun 2022 18:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbiF2SqN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jun 2022 14:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231831AbiF2SqD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jun 2022 14:46:03 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EAB3ED36
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 11:45:53 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id k10so12699736qke.9
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 11:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=Fm/r6W1xC6MGTRN7FqDtYknvi6INHlNbemvxryqWtzE=;
        b=Pabr/1tgVk2y2ezOdQfW+8h7zzKAKXYWHx1uDO9vW07U7JQPetxwlQIdFyqK/ktz6A
         tFkK2qOqYrNMM3R6sQlF3HUngMfFEd/GfAUpXMqLKlJQFsE0/PLBKOEvvsJuZxlw8WwV
         Ps6ObT42JItImRZ68ngeg3+9lKgEsU2LxclSIWXs9jv+v1AhAezXypQklFPIvk1Zh/tM
         hZf4uBaOtjPWivyOTbcFFm23HPuTQHsVcalA71vyOQEf+ujyr7ueRcAS3YGpEAnM+nRk
         EfMWF16a9wdrNFUKrA4yrn7O/1+53e3nX7riGvrXHejHRPJmWuDAypIawZkWDsO2hZs5
         37CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Fm/r6W1xC6MGTRN7FqDtYknvi6INHlNbemvxryqWtzE=;
        b=rF2n2oF+5zeEpQU7Yxg8mM+1b2EMtAXeXGXkGVsf/lNx0ICdRts/0pUvY3yZHK3kex
         TFQrGAkACtSRU22IR7XWn5W0yjz86TQmEbgdlENR5NajLLv4UlfIDRqzUI0YdZkgSnGt
         nicI7uWu5JE3MJvDytXcCAiw+meZuFOdDEdmjYBe0uIVsV72nD01xoMIdihgQBfy7nNf
         tj9i8zLhgr100KcAI8zLpI592KQvJqhNjlWnBiaEqxa+UmB/8yU5m+28sn/cnWzQaJuE
         246k3gcz7FyZt36+nuv54Qivhn4fw+CABs9Ng+KNgmyAe3fiVSFF74LuNtSkPzMXJ3eK
         2+bQ==
X-Gm-Message-State: AJIora+lCMf5M/wKK3HQP5bI96SPEsy0wexlePPV4RQRDi1fOTHjZlZY
        yCuV7d9R0yekcoJ4pB0rzfFR6xWAexRbSw==
X-Google-Smtp-Source: AGRyM1vfiKXvM0tTJbRRPXGHykDY/NI8+SjgwR4un90rgfM9qnYmtfkJ7eIx3x1Cipvia9m+dq+wpQ==
X-Received: by 2002:a05:620a:3183:b0:6af:40c:284d with SMTP id bi3-20020a05620a318300b006af040c284dmr3255156qkb.433.1656528351943;
        Wed, 29 Jun 2022 11:45:51 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id bi32-20020a05620a31a000b006af3f3b385csm6897100qkb.98.2022.06.29.11.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 11:45:51 -0700 (PDT)
Date:   Wed, 29 Jun 2022 14:45:49 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, jonathantanmy@google.com,
        gitster@pobox.com
Subject: [RFC PATCH 0/4] move pruned objects to a separate repository
Message-ID: <cover.1656528343.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that cruft packs are available in v2.37.0, here is an interesting
application of that new feature to enable a two-phase object pruning
approach.

This came out of a discussion within GitHub about ways we could support
storing a set of pruned objects in "limbo" so that they were not
accessible from the repository which pruned them, but instead stored in
a cruft pack in a separate repository which lists the original one as an
alternate.

This makes it possible to take the collection of all pruned objects and
store them in a cruft pack in a separate repository. This repository
(which I have been referring to as the "expired.git") can then be used
as a donor repository for any missing objects (like the ones described
by the race in [1]).

The first few patches are preparatory. The final one implements writing
the pruned objects separately. The trick is to write another cruft pack
to a separate repository, with two tweaks:

  - the `--cruft-expiration` value is set to "never", since we want to
    keep around all of the objects we expired in the previous step, and

  - the original cruft pack appears as a pack that we are going to keep,
    meaning all unreachable objects that are stored in the original
    cruft pack are excluded from the one we write to the "expired.git"
    repository.

You can try this out yourself by doing something like:

    $ git init --bare ../expired.git $ git repack --cruft
    --cruft-expiration=1.day.ago -d \
    --expire-to=../expired.git/objects/pack/pack

which will create two cruft packs:

  - one in the repository which ran `git repack` containing all
    unreachable objects written within the last day, and
  - another in the "expired.git" repository which contains all
    unreachable objects written prior to the last day

This series is an RFC for now since I'm interested in discussing whether
or not this is a feature that people would actually want to use or not.
But if it is, I'm happy to polish this up and turn it into a
non-RFC-quality series ;-).

In the meantime, thanks for your review!

[1]: https://lore.kernel.org/git/YryF+vkosJOXf+mQ@nand.local/

Taylor Blau (4):
  builtin/repack.c: pass "out" to `prepare_pack_objects`
  builtin/repack.c: pass "cruft_expiration" to `write_cruft_pack`
  builtin/repack.c: write cruft packs to arbitrary locations
  builtin/repack.c: implement `--expire-to` for storing pruned objects

 Documentation/git-repack.txt |   6 ++
 builtin/repack.c             |  67 ++++++++++++++++---
 t/t7700-repack.sh            | 121 +++++++++++++++++++++++++++++++++++
 3 files changed, 186 insertions(+), 8 deletions(-)

-- 
2.37.0.1.g1379af2e9d
