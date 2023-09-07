Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67320EC875B
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 21:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbjIGVwF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 17:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjIGVwE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 17:52:04 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DC11BC1
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 14:52:01 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-58caaedb20bso14717757b3.1
        for <git@vger.kernel.org>; Thu, 07 Sep 2023 14:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1694123520; x=1694728320; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XYwdiclgBGGGM8UN1Gtbp8TL9ZvglcFQJq/gOKAA7kA=;
        b=MUTBTqLBny67eaasCzjOxvdt/fMNaPy/l923rrp9vDe6+MKdksaDfyPp1ZPPCTwIlC
         ltsxi98YbMUS3B82p4h+tf19g1Yr3gsfLkpWWC/5hLIFzlYx6mBlOAy49LMWMbSZpFx2
         6F9RameSg5adDxHJX5XPXKkY7bPwZiW2Aw5HAru6ofKYtht5x6Dh/mnFxgPJFQK9D/cI
         dVexMCp6s5F1JZYT1/hAWjHI+yxBd6w1UrzWlVVbzrBiAZSOIPXcd/MdYdhlif/jQvYe
         dMl3DUfXhCLWwe75uoS/XthYi3oy6HJbg5u+ClFMsY2vtpZZGscSD7QNdzt0IwTaBk2Y
         Jzbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694123520; x=1694728320;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XYwdiclgBGGGM8UN1Gtbp8TL9ZvglcFQJq/gOKAA7kA=;
        b=INUDM2ZRRmYVDbcUT7dqqK46IQd+FkFhPxBlqAotugv9i1P25ajlvPfR1tjWzfle3N
         Vh3hrwjFEe8MQNObyHMTtX7r73bsVAMyvHLy/yilkYCIqQatGV7tl0XqtqwN5eKdat4j
         wEEIPNOXw0XFfyB5WVMDXA0/m7zDCYly47kNY2i8sk8uceJwvDOfrHRpHydPQs+hdNeV
         S3UL8dJ6vhkCIxSMk+qo2HKRMKDaQpcnvcWWRWh6R562WYNnQ13MXA1ncj73mlh3a+xu
         EkKKRzInQYTYZ9cmtEMugXsv4v+bvslMKGzOtY5JhTiFPwMi4TjaguPAHOGtwaWWvoQp
         cBPQ==
X-Gm-Message-State: AOJu0YzkKeYNxagsonNsQibaN4TcDoqktZQc7hr/7XhhQdI6HvbtZH8T
        hhbby0+L46vSwLzeoiM9B+ZyHgCfjNAL+GS5j+nYuw==
X-Google-Smtp-Source: AGHT+IEVBULmE2AkaxVNPQQkfORttA3wtRkZOixbVD1nNpcbs8Q2KY8Dko59BkvgkS1OdLYyy6drfQ==
X-Received: by 2002:a81:5208:0:b0:59b:51d9:1d6e with SMTP id g8-20020a815208000000b0059b51d91d6emr1015336ywb.6.1694123519916;
        Thu, 07 Sep 2023 14:51:59 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i186-20020a8154c3000000b005844ae2bfa3sm92398ywb.95.2023.09.07.14.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 14:51:59 -0700 (PDT)
Date:   Thu, 7 Sep 2023 17:51:58 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 0/2] repack: implement `--cruft-max-size`
Message-ID: <cover.1694123506.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(These patches should be applied on top of a merge with
tb/repack-existing-packs-cleanup, and tb/multi-cruft-pack).

This series attempts to give users some more robust tools for managing
repositories with a large number of unreachable objects by storing them
in separate cruft packs, via a new option `--cruft-max-size`, like so:

    $ git.compile repack -d --cruft --max-pack-size=10M
    [...]
    Enumerating cruft objects: 617483, done.
    Counting objects: 100% (83791/83791), done.
    Delta compression using up to 20 threads
    Compressing objects: 100% (59696/59696), done.
    Writing objects: 100% (83791/83791), done.
    Total 83791 (delta 19251), reused 82502 (delta 19148), pack-reused 0

    $ ls -la .git/objects/pack/pack-*.mtimes
    -r--r--r-- 1 ttaylorr ttaylorr 179144 Sep  7 17:46 .git/objects/pack/pack-1a95260d26f2897abfd2d54f1d58f535acb81d23.mtimes
    -r--r--r-- 1 ttaylorr ttaylorr    452 Sep  7 17:46 .git/objects/pack/pack-5fde8701ae0f2e5553f1fa33de05faf12f94c07f.mtimes
    -r--r--r-- 1 ttaylorr ttaylorr 155720 Sep  7 17:46 .git/objects/pack/pack-91f9e66921e0ebe1b5e35d34842551468cecdc28.mtimes
    -r--r--r-- 1 ttaylorr ttaylorr     56 Sep  7 17:46 .git/objects/pack/pack-95fe626743207b177b45f32b60fdc313e525ea60.mtimes

The details are explained in the second patch, but the gist is that we
will combine cruft packs up until they reach a certain threshold (as
specified by `--cruft-max-size`) and then begin a new "generation" of
cruft packs. That younger generation will grow up until it reaches the
configured threshold, at which point it will become "frozen" and then
any new unreachable objects will be written into a new generation of
cruft packs.

The goal of this series is to reduce I/O churn in repositories that
either (a) have a large number of unreachable objects, (b) rarely prune
them, or (c) both.

Instead of having to rewrite a cruft pack containing every unreachable
object in the repository, we only have to rewrite a cruft pack up until
it reaches the given threshold, at which point it is effectively kept
(i.e., it behaves as if the cruft pack had a ".keep" file tied to it,
provided that the threshold is held constant).

Thanks in advance for your review!

Taylor Blau (2):
  t7700: split cruft-related tests to t7704
  builtin/repack.c: implement support for `--cruft-max-size`

 Documentation/config/gc.txt  |   6 +
 Documentation/git-gc.txt     |   7 +
 Documentation/git-repack.txt |   9 +
 builtin/gc.c                 |   8 +
 builtin/repack.c             | 133 +++++++++++--
 t/t6500-gc.sh                |  27 +++
 t/t7700-repack.sh            | 121 -----------
 t/t7704-repack-cruft.sh      | 375 +++++++++++++++++++++++++++++++++++
 8 files changed, 553 insertions(+), 133 deletions(-)
 create mode 100755 t/t7704-repack-cruft.sh

-- 
2.42.0.138.g7e4e42e1aa
