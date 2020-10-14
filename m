Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D61C433DF
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 01:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB4E72225E
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 01:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OEeshNcM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732443AbgJOBzK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 21:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732450AbgJOByj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Oct 2020 21:54:39 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0B7C08EA7C
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 16:24:56 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id a27so499444pfl.17
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 16:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=vA1bTEcQt/I6n6xazv8zbHVsllvOVLp5ca7f47a4LcU=;
        b=OEeshNcMM1N3tpirEFSiZS/XxIm0ruS/jR/ICLyCGq6/0IGWW9KX/0Qhfq7ku8SF3/
         SuK2joC9bNmZ8Dv7+AHjt0wr9HOFHK/gsNstrPAOaaTDxyczxuztAxs/+xPW7IqniSik
         cbAlyhuHkSDpZDOWrcx+9EjH6EO4AFmLnm7VeOKUAD0S9fW7k+HkOXjMZyuDiu5A86tH
         HoBSWfvK8EBhV4kzyQIx2AoYS1+iVFWwddCMaLPBlQu/LiDmulwG9pVERLvDAb74p9Ql
         TGzmT2ikQjPH1NWe688HwORPJuw4rg9t37ZzbTkse7QY6YRGnWAKUXYHySLaee6S0cg/
         iTnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :subject:from:to:cc;
        bh=vA1bTEcQt/I6n6xazv8zbHVsllvOVLp5ca7f47a4LcU=;
        b=Y3uCWczTVHHr1+8b2tUZBEEAuoNC/6HKxzf0pmWdQojkRfpiiuTs5zo1qUXBqSZriC
         9wVOs4inBrsDvvgTgvGZ8qXNJe2fQJXe3rHUHhnIWrNSiKlAObmFt7SlWNT73Yuecm5W
         NHg9DcM8c96BxiqPqGh+09Zve/dpXVP14abU4SreY/TR00wyqloLXB7QE20uFOdFmJSN
         gflKlYEsWHhb3XTJdKW9WTy9grmwXo64KDuEjKwYpYdDIBXfDL6Z5d7Dn8ivyFm55oGT
         tYPRf24VwM3AFlW2XOugeTZ7Ut9I6t2jTaUuODZlvdLP1XKuchfqnYDWSOVejW7ME0Vp
         nJXA==
X-Gm-Message-State: AOAM532RjNidKpMB2q2TJr8fkGGirNclVEkavjVaWCDIcn0iglUVKfRR
        WrUlNfuLkAW9YxBJEykuip1pp0Ic1muZaoxEd8lQGVXRcpbFHrZVx/Z7gjKScSm1qsoXPDZJCqM
        ffrNZ5I6Bs7iJK7yGlo2ua34/pc5emNpyZKNnZuSc21uw8Fc7JSbPBTTo6/uvrHR5yE/q/bYhtQ
        ==
X-Google-Smtp-Source: ABdhPJwFSx5Rx+LLbH8N1U5juLdqrGXYfmoDxSL9eH/Oc0m2WlQxQOT2uFTTHQDRZQqW3PlSM2KUG7yD857YoekO9Ns=
Sender: "emilyshaffer via sendgmr" 
        <emilyshaffer@podkayne.svl.corp.google.com>
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
 (user=emilyshaffer job=sendgmr) by 2002:a17:902:bc4b:b029:d3:d350:eb69 with
 SMTP id t11-20020a170902bc4bb02900d3d350eb69mr1575405plz.45.1602717895464;
 Wed, 14 Oct 2020 16:24:55 -0700 (PDT)
Date:   Wed, 14 Oct 2020 16:24:39 -0700
In-Reply-To: <20200909004939.1942347-1-emilyshaffer@google.com>
Message-Id: <20201014232447.3050579-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.226.g0268cb6820
Subject: [PATCH v5 0/8] propose config-based hooks (part I)
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

Since v4:
- Reordered the commits. Hookdir support is added sooner and conversion
  of existing hooks is moved to another branch (part II) for hopefully
  more granular reviewing. If folks hate this, let me know and I'll
  reintegrate the two topics.
- Removed the --porcelain option on 'git hook list'. General consensus
  is that this should use a format string instead, and I didn't want to
  write that new feature while I had been promising v5 "any day now".
- Added functionality for 'skip' to remove hooks from the execution
  list.
- General nits from folks.

Coming soon:
- 'git hook list --format'
- More conversions (in the other topic)
- As required by new conversions, stdin support for hooks

Coming much later:
- 'git hook add'/'git hook edit'. The config isn't too ugly to manually
  edit, for now, so I'd like to get the hooks themselves all figured out
  before adding these convenience tools. I do still think they're a good
  idea, as they'll increase the discoverability of the feature for new
  users.

More detailed notes in each commit. Thanks all for your patience and
reviews.

 - Emily

Emily Shaffer (8):
  doc: propose hooks managed by the config
  hook: scaffolding for git-hook subcommand
  hook: add list command
  hook: include hookdir hook in list
  hook: implement hookcmd.<name>.skip
  parse-options: parse into strvec
  hook: add 'run' subcommand
  hook: replace find_hook() with hook_exists()

 .gitignore                                    |   1 +
 Documentation/Makefile                        |   1 +
 Documentation/config/hook.txt                 |  14 +
 Documentation/git-hook.txt                    |  81 ++++
 Documentation/technical/api-parse-options.txt |   5 +
 .../technical/config-based-hooks.txt          | 367 ++++++++++++++++++
 Makefile                                      |   2 +
 builtin.h                                     |   1 +
 builtin/hook.c                                | 163 ++++++++
 git.c                                         |   1 +
 hook.c                                        | 282 ++++++++++++++
 hook.h                                        |  58 +++
 parse-options-cb.c                            |  16 +
 parse-options.h                               |   4 +
 t/t1360-config-based-hooks.sh                 | 232 +++++++++++
 15 files changed, 1228 insertions(+)
 create mode 100644 Documentation/config/hook.txt
 create mode 100644 Documentation/git-hook.txt
 create mode 100644 Documentation/technical/config-based-hooks.txt
 create mode 100644 builtin/hook.c
 create mode 100644 hook.c
 create mode 100644 hook.h
 create mode 100755 t/t1360-config-based-hooks.sh

-- 
2.28.0.rc0.142.g3c755180ce-goog

