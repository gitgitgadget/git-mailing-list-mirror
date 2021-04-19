Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FAAEC433B4
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 19:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6D7D61354
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 19:53:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237037AbhDSTyP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 15:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235026AbhDSTyO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 15:54:14 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A3DC06174A
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 12:53:44 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id y136so4996983qkb.1
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 12:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qqG0Q3amPKEC67Mmlms+gzupkQLZ2giwnrr7Zm28Pvw=;
        b=geO1xy6r2e2e9sIST20wYxJsIe6yAxiyTgg1OQBgOnhtHbNnb3vqQOOwpfjZLKeSZS
         di7mN+555aaqdI6CufhedGl6XpyEIkKJs7bm45WHpE+dNnqK/NV4EUzZumasjVVG/OZ1
         nmoPi3xNC/Pvz8yQANZ6EgLMQDw56Cf5R3N5+w/ucYGfU178Qo1xohr8/wuGmIkkaXUw
         HjC5NJDJvP7dKZhz5rnT0c8TjZ5f3sOilXBZ8THTpFPjTGeCE5nLezaXv1Tx++e7Htdq
         fOouPT7eIhLJVA2hmzZywaM0Rb7bj5uXgIGvWoP6odj3rw2bIStzOrwgZm1uX8jQwBpe
         2HBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qqG0Q3amPKEC67Mmlms+gzupkQLZ2giwnrr7Zm28Pvw=;
        b=pY/yoliHG+0E5mBosh5AHfhx5Bf8ou6+Moz20oeiQY9H0JTQBYvhpIqkoSiHKEqoO5
         qY9uSBOEKjmlGpJK1K3pAqj4OgoOnUw31p7YigQYkhoXlvPC8u4prDeVw65Zj5+wYjcx
         8ayI+PJUGnHObc4s3eI0+3mWywwlDFkXuQVA6YiGKt4S9aE8q9weslgQBpCIwxtRJOqK
         FNqXnVDo6G2JF2S8hDkKAxB9oJ3oK63uMKwqWHSSxgQg0mQi09Z3KA6OdwtB1/tdY7D0
         sy+SiTB9kXXBsbQLUvxRPm0mPSEiT1uWSGN5QGXtTHGMF4E7zFOLmGBYBcGG7Ytj5zej
         FtgA==
X-Gm-Message-State: AOAM531BGrtyjxR2PRY93PrQ2SonGCc3AdeS+XVzyn4e6gnbrWgM7WmB
        7ciflsaxaVsrXl1jAOaITRtURQ==
X-Google-Smtp-Source: ABdhPJzdAgSxMK2f0j4mml/nX0VF1bm51qBd38zG60kPqGsm5NqvAxh+JenzzsoKGUYxCwkyQs3eLw==
X-Received: by 2002:a37:e315:: with SMTP id y21mr7621563qki.176.1618862023345;
        Mon, 19 Apr 2021 12:53:43 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id h3sm4479987qka.122.2021.04.19.12.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 12:53:42 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        git@jeffhostetler.com
Subject: [PATCH v4 0/5] Parallel Checkout (part 2)
Date:   Mon, 19 Apr 2021 16:53:30 -0300
Message-Id: <cover.1618861380.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1618790794.git.matheus.bernardino@usp.br>
References: <cover.1618790794.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This version is almost identical to v3, but the last patch incorporates
the typo fixes and other rewording suggestions Christian made about the
design doc on the last round.

I decided to remove the sentence about step 3 dominating the execution
time as that's not always the case on e.g. a non-local clone or
sparse-checkout.

Matheus Tavares (5):
  unpack-trees: add basic support for parallel checkout
  parallel-checkout: make it truly parallel
  parallel-checkout: add configuration options
  parallel-checkout: support progress displaying
  parallel-checkout: add design documentation

 .gitignore                                    |   1 +
 Documentation/Makefile                        |   1 +
 Documentation/config/checkout.txt             |  21 +
 Documentation/technical/parallel-checkout.txt | 270 ++++++++
 Makefile                                      |   2 +
 builtin.h                                     |   1 +
 builtin/checkout--worker.c                    | 145 ++++
 entry.c                                       |  17 +-
 git.c                                         |   2 +
 parallel-checkout.c                           | 655 ++++++++++++++++++
 parallel-checkout.h                           | 111 +++
 unpack-trees.c                                |  19 +-
 12 files changed, 1240 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/technical/parallel-checkout.txt
 create mode 100644 builtin/checkout--worker.c
 create mode 100644 parallel-checkout.c
 create mode 100644 parallel-checkout.h

Range-diff against v3:
1:  7096822c14 = 1:  7096822c14 unpack-trees: add basic support for parallel checkout
2:  4526516ea0 = 2:  4526516ea0 parallel-checkout: make it truly parallel
3:  ad165c0637 = 3:  ad165c0637 parallel-checkout: add configuration options
4:  cf9e28dc0e = 4:  cf9e28dc0e parallel-checkout: support progress displaying
5:  415d4114aa ! 5:  fd929f072c parallel-checkout: add design documentation
    @@ Documentation/technical/parallel-checkout.txt (new)
     +* Step 4: Write the new index to disk.
     +
     +Step 3 is the focus of the "parallel checkout" effort described here.
    -+It dominates the execution time for most of the above command types.
     +
     +Sequential Implementation
     +-------------------------
    @@ Documentation/technical/parallel-checkout.txt (new)
     +It wouldn't be safe to perform Step 3b in parallel, as there could be
     +race conditions between file creations and removals. Instead, the
     +parallel checkout framework lets the sequential code handle Step 3b,
    -+and use parallel workers to replace the sequential
    ++and uses parallel workers to replace the sequential
     +`entry.c:write_entry()` calls from Step 3c.
     +
     +Rejected Multi-Threaded Solution
    @@ Documentation/technical/parallel-checkout.txt (new)
     +warning for the user, like the classic sequential checkout does.
     +
     +The workers are able to detect both collisions among the entries being
    -+concurrently written and collisions among parallel-eligible and
    -+ineligible entries. The general idea for collision detection is quite
    -+straightforward: for each parallel-eligible entry, the main process must
    -+remove all files that prevent this entry from being written (before
    -+enqueueing it). This includes any non-directory file in the leading path
    -+of the entry. Later, when a worker gets assigned the entry, it looks
    -+again for the non-directories files and for an already existing file at
    -+the entry's path. If any of these checks finds something, the worker
    -+knows that there was a path collision.
    ++concurrently written and collisions between a parallel-eligible entry
    ++and an ineligible entry. The general idea for collision detection is
    ++quite straightforward: for each parallel-eligible entry, the main
    ++process must remove all files that prevent this entry from being written
    ++(before enqueueing it). This includes any non-directory file in the
    ++leading path of the entry. Later, when a worker gets assigned the entry,
    ++it looks again for the non-directories files and for an already existing
    ++file at the entry's path. If any of these checks finds something, the
    ++worker knows that there was a path collision.
     +
     +Because parallel checkout can distinguish path collisions from the case
     +where the file was already present in the working tree before checkout,
    @@ Documentation/technical/parallel-checkout.txt (new)
     +Besides, long-running filters may use the delayed checkout feature to
     +postpone the return of some filtered blobs. The delayed checkout queue
     +and the parallel checkout queue are not compatible and should remain
    -+separated.
    ++separate.
     ++
     +Note: regular files that only require internal filters, like end-of-line
     +conversion and re-encoding, are eligible for parallel checkout.
    @@ Documentation/technical/parallel-checkout.txt (new)
     +The API
     +-------
     +
    -+The parallel checkout API was designed with the goal to minimize changes
    -+to the current users of the checkout machinery. This means that they
    -+don't have to call a different function for sequential or parallel
    ++The parallel checkout API was designed with the goal of minimizing
    ++changes to the current users of the checkout machinery. This means that
    ++they don't have to call a different function for sequential or parallel
     +checkout. As already mentioned, `checkout_entry()` will automatically
     +insert the given entry in the parallel checkout queue when this feature
     +is enabled and the entry is eligible; otherwise, it will just write the
-- 
2.30.1

