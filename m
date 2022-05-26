Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B8CC433EF
	for <git@archiver.kernel.org>; Thu, 26 May 2022 00:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242032AbiEZAbx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 20:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346079AbiEZAax (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 20:30:53 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCF6A7E1B
        for <git@vger.kernel.org>; Wed, 25 May 2022 17:30:51 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id i82-20020a1c3b55000000b003974edd7c56so1695421wma.2
        for <git@vger.kernel.org>; Wed, 25 May 2022 17:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=14ddBtKWQHtDaPBIxJZV/C9RynPq5xZa2K6TPx6synw=;
        b=NOpICP0ij3ADozfu+1s9IqHuFg53lLj3UJ+HWZhwDSS+2VZTUaVeBZM8PAYBWnGQIQ
         V6HE5tW0XtLYXmoKXI8hKTTdRrrXoPDekh0AA2bc5LEWdoINL68w9ieXahZur6IRAlwh
         l/FrVrHcfS7rj7aOzfX0M4dCJb//IdHfBI5vbQO0KAFQuwIO+QcLTjLYhWOvTur/kaIP
         Ri0e8QAxa6UdTabEuorvcnVlxjvVuzHbEoPnSZYbLJYDZAXzyN/HyWT2kLQZEZsCJZTS
         7L6nkFvb2Lk5XSwUq25EFWYv8xqpC3OFTWgX6nwro7q/Cd4M5YaML2iTDy0txY/NeRW2
         cfmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=14ddBtKWQHtDaPBIxJZV/C9RynPq5xZa2K6TPx6synw=;
        b=JoCT7eAs3U9QIoLsefGpq9c78ZMZ93ZxL9bWUg7P/V+mEWLUn4OkYC7E5zLBCR43ly
         xO94ekqiFtQ76q3psL1Tq593CG62ntoABxpDzzF2Lqz22tPrn4SdsLNayc5dR9BlizMk
         g+4Oftd94JXZRioiSnw7OjbHJW80TU7pRghN0muj5B0fO8YFjGfDUM+8U1KSB8bHxs04
         J0mk1msjVGRtCC4hpYtxri4WmTPfdn4PytT0qVwRT3jdW5u8X0RgiBPRM4dsfQNpqePj
         6QESbaHZV9ixurN1CMgnBBM4nOUy/rFp30qe1Rv0UwXwm5wNmfOW0A3WXtWmhi2yv3KK
         nhNQ==
X-Gm-Message-State: AOAM532AWlnU3p240qg8VmAMg0yEp9F7JtTS1SYwyCGZtBOajqeUaOZf
        Tid3lUS5dk0NuBhq8uIvhMUCL6whW9BAWg==
X-Google-Smtp-Source: ABdhPJw/S51LEWZjH1QkyK1oDF6dYrfNCheE3qJFJBEJMFn3DHcpaYKKkwzJMrtC39fUo0rQLMS3iA==
X-Received: by 2002:a1c:4d09:0:b0:397:4a35:54db with SMTP id o9-20020a1c4d09000000b003974a3554dbmr10724338wmh.117.1653525050219;
        Wed, 25 May 2022 17:30:50 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id az19-20020a05600c601300b003973c54bd69sm3138968wmb.1.2022.05.25.17.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 17:30:49 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Josh Steadmon <steadmon@google.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>,
        John Cai <johncai86@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 0/3] trace2: log "signal" end events if we invoke BUG()
Date:   Thu, 26 May 2022 02:30:41 +0200
Message-Id: <RFC-cover-0.3-00000000000-20220525T234908Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1046.g586767a6996
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon noted in the Review Club tonight/today/yesterday
(depending on the TZ) that he'd encountered trace2 event streams
without an "exit" event, which as discussed can be seen from usage.c
is due to our invoking of abort() there.

This RFC series aims to rectify that, first we back out of test-tool
specific behavior for BUG() in 1/3, and in 3/3 define abort() to be a
wrapper macro like what we do for exit() already.

I'm not sure about the direction of emitting such a "signal" event,
should we just "fake it" and emit an "exit" event? Probably not, but
I'm not confident in that. For one is the exit code (as in what a
shell would get from $?) when we're killed with SIGABRT guaranteed to
be portable?

But hopefully this gets the ball rolling on a good fix for this by
starting a discussion about what we should be doing here.

One alternate way of dealing with this would be to first split up the
"error" event so that we don't emit "error" for all of BUG(), die(),
error() and warning(), and to instead split those up into "BUG",
"die", "error", "warning".

Once we did that we could pretty much declare that the current
behavior before this series is a feature, and that anyone parsing
trace2 output needs to deal with the stream potentially ending in a
"BUG" event.

Any such event parser will need to deal with at least:

    "start" -> ["exit" | "signal"] (with this series)

So perhaps it's OK to simply say that consumers should expect?

   # Or "error" now, but then you can't distinguish "BUG()" from the
   # rest.
    "start" -> ["exit" | "BUG"]

I think I like that less, but it's worth pointing out as an
alternative. The implementation would certainly be smaller than this
proposed RFC.

Ævar Arnfjörð Bjarmason (3):
  test-tool: don't fake up BUG() exits as code 99
  refs API: rename "abort" callback to avoid macro clash
  trace2: emit "signal" events after calling BUG()

 Documentation/technical/api-trace2.txt | 13 +++++++++----
 git-compat-util.h                      |  9 +++++++++
 refs/debug.c                           |  4 ++--
 refs/files-backend.c                   |  4 ++--
 refs/iterator.c                        |  8 ++++----
 refs/packed-backend.c                  |  2 +-
 refs/ref-cache.c                       |  2 +-
 refs/refs-internal.h                   |  2 +-
 t/helper/test-tool.c                   |  1 -
 t/t0210-trace2-normal.sh               |  5 ++---
 t/t1406-submodule-ref-store.sh         | 10 +++++-----
 t/test-lib-functions.sh                | 13 +++++++++++++
 trace2.c                               | 19 +++++++++++++++++++
 trace2.h                               |  8 ++++++++
 trace2/tr2_tgt.h                       |  3 +++
 trace2/tr2_tgt_event.c                 | 11 +++++++++--
 trace2/tr2_tgt_normal.c                | 11 +++++++++--
 trace2/tr2_tgt_perf.c                  | 11 +++++++++--
 usage.c                                |  5 -----
 19 files changed, 106 insertions(+), 35 deletions(-)

-- 
2.36.1.1046.g586767a6996

