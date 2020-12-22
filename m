Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85139C433DB
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 00:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5339222AED
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 00:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbgLVAFY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 19:05:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbgLVAFY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 19:05:24 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF37C0613D3
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 16:04:43 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id bp20so9289564qvb.20
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 16:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=jvaydvpx4TvmN4pmx7oMeXxZIuLIpX6i3jcuz7chFog=;
        b=C52FN9GQIK2PCYmvP0j2dj57OMekFbI8tj5+W5Jadc7wiJNrZr4cD3p8YbNnkTgHnj
         qd09tMf5APdHh7AQ3s44Q2ERDEsQpbCGE1EQRDM37/dXnNT8Lj2othOshjXnP6ZsU18S
         Flfd3rfZTCCLlFmsUCHMAOnWOM98/+x3aiWm6TwinZ+h8mtwsSinbniwodoFckQLOr3e
         c5aGWymPr6lGElKzux0VVNfKzw8BtKcagLviU9T2+SceBE5/OkbxhEl4rI0/LPxpwJaG
         lGFAORKM2tl7RQfdDSu/OPTPqM/BFt1Tm7yAaJqCMeanumzCTnftR89mHuQfeLDfApP4
         taDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :subject:from:to:cc;
        bh=jvaydvpx4TvmN4pmx7oMeXxZIuLIpX6i3jcuz7chFog=;
        b=SxNCZrlzA1AFClitT6Kq+DDtEqY06cO6zlWza+lWfl8LLg5jITL1oqWIDqXVIHtKlB
         3Ku6AoEmp49XMdzYVwxcrB/gZwtUVlwx7gYh663ThnvN/mE8k0VFe+GmkimStL3lUQBN
         m4z8I1u9gI0QiWpdE1uIdKLRCj8j0W+TrwHhlJB8i0iPPuCzqsi6+K2A2BljCaUHxKZd
         QvaJ7/TjY0rCbI2V9dkvv3sRCbhJD7HLs6s9zfk3HEaRyMhYm8wPiEL/hQTYR225vTqb
         D1Yw9Lt21eZ0pTmEgaYYt2nZDkCRcDOELZHSrq2hZASDDOCnSPykxTLzPzbLGwIALP80
         pg2A==
X-Gm-Message-State: AOAM531hZacYm4ozCs1+jW1w7Xhp2GsZ0t78N8vXQ/xTCPsSEARVgnF1
        xyfBxul4UtHnEDIV25tP7pdSyeImEoCxteKgZIiDH3PY3nlEQkzT1f+rtY5gl3JltWgTzrIYLMZ
        CSyvCzSChUylZVYVj6hbpZ4VVnmI9XwA/QRcQOmhJ24CL0OyEO6uks6htx6ohw4erEKpZ2XuQbA
        ==
X-Google-Smtp-Source: ABdhPJzgCR97+HgKmPECoprm79GLOp6O+cwEc621HfnabpkpMxm2oGOb9Y5JX8bijZHDtEdnu0zk8Y7GP8043ufaypI=
Sender: "emilyshaffer via sendgmr" 
        <emilyshaffer@podkayne.svl.corp.google.com>
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
 (user=emilyshaffer job=sendgmr) by 2002:a0c:ebc2:: with SMTP id
 k2mr19170089qvq.24.1608595482889; Mon, 21 Dec 2020 16:04:42 -0800 (PST)
Date:   Mon, 21 Dec 2020 16:04:18 -0800
In-Reply-To: <20201205014945.1502660-1-emilyshaffer@google.com>
Message-Id: <20201222000435.1529768-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.490.gc7ae633391
Subject: [PATCH v3 00/17] use config-based hooks (config-based hooks part II)
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

Since v2:
 - Renamed 'master' to 'main' in new t5411 (proc-receive) test.
 - Removed some accidentally included debug strings.
 - Fixed a nasty bug in the reference-transaction hook conversion where calling
   'oid_to_hex()' would invalidate references to the output of earlier
   'oid_to_hex()' runs farther up the callstack. Instead, the hook callsite now
   uses 'oid_to_hex_r()'.

Another thing I wanted to do in this series but ended up not having time
for before the holidays was to figure out a way to consolidate
Documentation/githooks.txt and Documentation/git-hook.txt. My personal
preference would be to remove githooks.txt's contents, move the "Hooks"
header from there into git-hook.txt, and have 'git help githooks'/'git
help hooks' redirect to git-hook.txt; I don't have a patch to share here
because I ran out of time before vacation :) What do others envision the
documentation looking like?

Thanks!
 - Emily

CI run: https://github.com/nasamuffin/git/actions/runs/436905873

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
 git-p4.py                                     |  67 +---
 hook.c                                        |  39 ++-
 read-cache.c                                  |  12 +-
 refs.c                                        |  38 +-
 reset.c                                       |  15 +-
 run-command.c                                 |  66 ----
 run-command.h                                 |  24 --
 sequencer.c                                   |  83 ++---
 t/t1416-ref-transaction-hooks.sh              |  12 +-
 t/t5411/test-0015-too-many-hooks-error.sh     |  47 +++
 ...3-pre-commit-and-pre-merge-commit-hooks.sh |  17 +-
 transport.c                                   |  55 +--
 24 files changed, 493 insertions(+), 495 deletions(-)
 create mode 100644 t/t5411/test-0015-too-many-hooks-error.sh

-- 
2.28.0.rc0.142.g3c755180ce-goog

