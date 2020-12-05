Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FBF6C4361B
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 404C122DFB
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730954AbgLEBub (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 20:50:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgLEBub (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 20:50:31 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D00C061A4F
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 17:49:51 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id d30so6395121qvf.3
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 17:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=ZqciuEw0sooa1wy97tE8SogVLQ38hg3p8yy8a0JzgM0=;
        b=D8UORe5oHhAShJHs21adAuveVepKQxZcfDR9Mq6+34Vuhof9G51kRkkF4eUOgzlRPq
         65dHwGwgaZ/uESyNQzQmE+rz/PK3Yr9Sux27lFAQVRH3SIbWKoOKta3GS0TDb2gMC3ae
         9v7GjFXm7/MjBRPVYMEcJwIl8q8X1hbuEqKNGCJbVPEdNTRI2r113PzqycaOw+g0nOvQ
         0WZ+5hykU6e9adjsjFMpsTv1nxARWY8w/fb2Q0FYtIu762SS/d3l57GsxlY3EPCnImpU
         6u/roqc8Lge6CL43rqYt28mp+OAC40tfoTNXVIpx+KlsilSNkXwfCG2GOz4lr5WRA9oJ
         K9Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :subject:from:to:cc;
        bh=ZqciuEw0sooa1wy97tE8SogVLQ38hg3p8yy8a0JzgM0=;
        b=nFdsA4lBJZWj0K6q6BvseYOd0ApHFhDUr1MQfROyk8hkVbhsusDh4tlJ6IV+4AZnp+
         inKXKr6EYhqLbQij73DffXapFBFcMQ03HvdWWRtzJobl/9ccLlOyLeNOBQdZSTSQlCoU
         +nFbKmbTNZ51V2dUXfjhP3mm20ge/e+3/vBUe9uyNPC4IxwdI9r5GaQIgUonKG1slYIW
         hv/8KdmDWw77or7VHlc9FUGD6qTvX5Okg/Srrq76QIAXBOdOBjhxHhyVjI9N1wtgBNpb
         C5Ac7aFw0sX7v2+bepzwFwDUv50bbJmFrxXoT9bx/QcBMyy4FhHwOnvhnMC/+4XGctrk
         Jk5g==
X-Gm-Message-State: AOAM530i6oku67gUmRE+2EorgI3eHeP3mOS1PKCzaIcD0fAacfe9IrqG
        3xJ/cRXtFaWa2Jqw0ZE2a4LSS0h5qKbx/wRz5Lb+yK/rfRYWJR3auPvXS2pyYa9iCApQnuqOh96
        mYED8GcSVrSK0QormAn5IplBumG5lEMTjprClYVYTutwEfgPVh/4gyI7SHnj99M3yo7fwTXX3hw
        ==
X-Google-Smtp-Source: ABdhPJwPU+SLhzWhz2wWGgovH0yWZzJixY6krQUrAsiry5Ida+ZtDDLM0pxXQrTP/vqD9YC7N0wRIWohy0Aaox0EXg8=
Sender: "emilyshaffer via sendgmr" 
        <emilyshaffer@podkayne.svl.corp.google.com>
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
 (user=emilyshaffer job=sendgmr) by 2002:a0c:8d47:: with SMTP id
 s7mr9169883qvb.17.1607132990199; Fri, 04 Dec 2020 17:49:50 -0800 (PST)
Date:   Fri,  4 Dec 2020 17:49:28 -0800
In-Reply-To: <20201014232517.3068298-1-emilyshaffer@google.com>
Message-Id: <20201205014945.1502660-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.226.g0268cb6820
Subject: [PATCH 00/17] use config-based hooks (config-based hooks part
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        James Ramsay <james@jramsay.com.au>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As of rebasing today, these are all the hooks, converted to hook.h.

I chose between parallel and serial execution based only on reading the docs -
please, please correct me if I'm wrong.

Most of these are pretty straightforward but there are a couple outstanding ones
on the server side, which I think could use some extra attention.

Thanks!
 - Emily

Emily Shaffer (17):
  commit: use config-based hooks
  am: convert applypatch hooks to use config
  merge: use config-based hooks for post-merge hook
  gc: use hook library for pre-auto-gc hook
  rebase: teach pre-rebase to use hook.h
  read-cache: convert post-index-change hook to use config
  receive-pack: convert push-to-checkout hook to hook.h
  git-p4: use 'git hook' to run hooks
  hooks: convert 'post-checkout' hook to hook library
  hook: convert 'post-rewrite' hook to config
  transport: convert pre-push hook to use config
  reference-transaction: look for hooks in config
  receive-pack: convert 'update' hook to hook.h
  proc-receive: acquire hook list from hook.h
  post-update: use hook.h library
  receive-pack: convert receive hooks to hook.h
  run-command: stop thinking about hooks

 Documentation/githooks.txt                    |  45 +++
 builtin/am.c                                  |  30 +-
 builtin/checkout.c                            |  16 +-
 builtin/clone.c                               |   7 +-
 builtin/commit.c                              |  11 +-
 builtin/gc.c                                  |   4 +-
 builtin/merge.c                               |  14 +-
 builtin/rebase.c                              |   7 +-
 builtin/receive-pack.c                        | 326 ++++++++++--------
 builtin/worktree.c                            |  30 +-
 commit.c                                      |  20 +-
 commit.h                                      |   3 +-
 git-p4.py                                     |  70 +---
 hook.c                                        |  39 ++-
 read-cache.c                                  |  12 +-
 refs.c                                        |  33 +-
 reset.c                                       |  15 +-
 run-command.c                                 |  66 ----
 run-command.h                                 |  24 --
 sequencer.c                                   |  83 ++---
 t/t1416-ref-transaction-hooks.sh              |  12 +-
 t/t5411/test-0015-too-many-hooks-error.sh     |  47 +++
 ...3-pre-commit-and-pre-merge-commit-hooks.sh |  17 +-
 transport.c                                   |  55 +--
 24 files changed, 492 insertions(+), 494 deletions(-)
 create mode 100644 t/t5411/test-0015-too-many-hooks-error.sh

-- 
2.28.0.rc0.142.g3c755180ce-goog

