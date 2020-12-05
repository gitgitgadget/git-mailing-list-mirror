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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 211A2C4361A
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E054422DBF
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbgLEBrC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 20:47:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728158AbgLEBrB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 20:47:01 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF099C0613D1
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 17:46:15 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id 99so6268036qte.19
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 17:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=u+fyi+1FvuFFtTvxbXRwHXvC7xsYMVUfEdhAONipka4=;
        b=Cq0R+yebB1wlaRTEPNnIgAYnrIFwtQ09ulK1J9YeZjU04znEDNPEpQoYsPNAWqoIKd
         by0toHbJCW5+lgBANqgPbjDeBoRPNQ8RUns8EMBCd7Z9AQWfxfyXu7NaaKqdSRYwDSDL
         VQEzUUuVo1/bceCO/0HbsSx/8igkbCgyej43bjKWdP2Kfsjs1vkEM2C6BdanvPJ8W/D4
         LWz2mtl7LdKm3ugUewqfYxRsU0+dnm7IjBN0E5MI1t0Pwl+k9qK97eu8fQ8R0padku9y
         w3HZFHWouwAPyBQBbRGW+PDlotzRT4xlrPSUoFs1KK+o0wuNpEwvxJsiUvgSzmdfC5pq
         HLwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :subject:from:to:cc;
        bh=u+fyi+1FvuFFtTvxbXRwHXvC7xsYMVUfEdhAONipka4=;
        b=D0tMm3f/sAgfqZpaXFFotkNf7CMwAouGAA5jeas87p46FGSKtC8/kkJBT2pTnzic/3
         4DOqH13lwUvr4jLMZUKJbiJ7tvEyBWigeP/2xdk2fok/HwUfyfxmKBhQWQ3Lum2vmAO3
         py46tiUIhxk6wJWCkSTPVr2oR8JgtwGugmuElLitTUtgXQg0g3WqoSKASL39Ozf/rdpH
         qBFK6LJf4MTNzRXo09TYUc5QNjqduhEdDyoNT18SN6ukjMgeoZ8Q/HQSwk97eYXFREZD
         5DFqbO+hZgudXwcSZCS8h1Qg8/2Gedh7eGppXH283c/eJhQ3n60xq/2isPTKAl0GlX2t
         l6ag==
X-Gm-Message-State: AOAM530ZI8bCkmyXOlkMIqdTz4HP8jGV6hkHJn1lxj+kE50z7XLK3QQz
        xSCYZw1r9mVbVow6a9n9d97v0QD1uJzEvREfJvO7XH7jN77u1TPLXBVSxbWI/xlgAZXnpaw7sfp
        CWgJAsVpTh2TWVBKHidUAvpcudnkyW9nU0aex3J46Eh0InXfJF8YN/F1E6+R3ckj36qdrPjFNLg
        ==
X-Google-Smtp-Source: ABdhPJyEpG0nGJDPnNma9MXqxOZU+yWDoLrOqWrkrPI8kCUTaU+dFc7PmMpKMjurC/oHMaVlxPClPu8Q4W6VhVdI5gc=
Sender: "emilyshaffer via sendgmr" 
        <emilyshaffer@podkayne.svl.corp.google.com>
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
 (user=emilyshaffer job=sendgmr) by 2002:a0c:bec6:: with SMTP id
 f6mr2426939qvj.9.1607132774835; Fri, 04 Dec 2020 17:46:14 -0800 (PST)
Date:   Fri,  4 Dec 2020 17:45:50 -0800
In-Reply-To: <20201014232447.3050579-1-emilyshaffer@google.com>
Message-Id: <20201205014607.1464119-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.226.g0268cb6820
Subject: [PATCH v6 00/17] propose config-based hooks (part I)
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

Hi folks, and thanks for the patience - I ran into many, many last-mile
challenges.

I haven't addressed many comments on the design doc yet - I was keen to get the
"functionally complete" implementation and conversion to the list.

Next on my plate:
 - Update the design doc to make sense with what's in the implementation.
 - A blog post! How to set up new hooks, why they're neat, etc.
 - We seem to have some Googlers interested in trying it out internally, so
   I'm hoping we'll gather and collate feedback from that soon too.
 - And of course addressing comments on this series.

Thanks!
 - Emily

Emily Shaffer (17):
  doc: propose hooks managed by the config
  hook: scaffolding for git-hook subcommand
  hook: add list command
  hook: include hookdir hook in list
  hook: respect hook.runHookDir
  hook: implement hookcmd.<name>.skip
  parse-options: parse into strvec
  hook: add 'run' subcommand
  hook: replace find_hook() with hook_exists()
  hook: support passing stdin to hooks
  run-command: allow stdin for run_processes_parallel
  hook: allow parallel hook execution
  hook: allow specifying working directory for hooks
  run-command: add stdin callback for parallelization
  hook: provide stdin by string_list or callback
  run-command: allow capturing of collated output
  hooks: allow callers to capture output

 .gitignore                                    |   1 +
 Documentation/Makefile                        |   1 +
 Documentation/config/hook.txt                 |  19 +
 Documentation/git-hook.txt                    | 118 +++++
 Documentation/technical/api-parse-options.txt |   5 +
 .../technical/config-based-hooks.txt          | 367 +++++++++++++++
 Makefile                                      |   2 +
 builtin.h                                     |   1 +
 builtin/bugreport.c                           |   4 +-
 builtin/fetch.c                               |   1 +
 builtin/hook.c                                | 174 ++++++++
 builtin/submodule--helper.c                   |   2 +-
 git.c                                         |   1 +
 hook.c                                        | 417 ++++++++++++++++++
 hook.h                                        | 154 +++++++
 parse-options-cb.c                            |  16 +
 parse-options.h                               |   4 +
 run-command.c                                 |  85 +++-
 run-command.h                                 |  31 ++
 submodule.c                                   |   1 +
 t/helper/test-run-command.c                   |  46 +-
 t/t0061-run-command.sh                        |  37 ++
 t/t1360-config-based-hooks.sh                 | 256 +++++++++++
 23 files changed, 1728 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/config/hook.txt
 create mode 100644 Documentation/git-hook.txt
 create mode 100644 Documentation/technical/config-based-hooks.txt
 create mode 100644 builtin/hook.c
 create mode 100644 hook.c
 create mode 100644 hook.h
 create mode 100755 t/t1360-config-based-hooks.sh

-- 
2.28.0.rc0.142.g3c755180ce-goog

