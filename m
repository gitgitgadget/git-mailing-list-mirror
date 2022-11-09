Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C577AC433FE
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 00:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiKIAr0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 19:47:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiKIArY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 19:47:24 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA2D60EA9
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 16:47:22 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id mj8-20020a17090b368800b002137a506927so6911661pjb.1
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 16:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=84tL3ckwTNBEfyMxNhIUpwz7v+pUjkoFoD48WS7O6mo=;
        b=XxLQyLiqdO6hbT/4OPbspc7PZ/YzkuXgQhauCF6WJkSbw1xssJlPp/leos5WCeO2KP
         EIuULB1ClG2iEdQRUCbMzIwM1DT4gKJnPaZ7kxxX20m6lE8wQkSDHLeHtBkGyhaVTeQU
         YAr9YDNd96g5wBJzg8zJFNAMANkaYFrLsZqwhwzKXKk3pNvX85wBdv5PcbVcAQ7RMULD
         q7iRo8qsVD2L51+IsahC2WR6VlFHDrZ6OHtXpwaWC00Y0OcIG93eQblSAmSoSuAkKKv0
         DewpLT8kQqk8h5Ea8wS9UWFtK9lwLSv91w7mOF3yv+4cggx4h49R1gIbdNYniu3/KrqF
         aKlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=84tL3ckwTNBEfyMxNhIUpwz7v+pUjkoFoD48WS7O6mo=;
        b=pzclBKuMLZGIR3p+1Ou95Hzops7KEzM8oUIXUD29wEZlIHBE9xoGVXgm9o4suBMlON
         q5ySXga+f+heiPwjEwTv+fpgDf0qd4omY7JYqx0+ibCcYv9AcI51M4eGS+kLhA91+++h
         r9s6DCs8T0rPrdIs32U1Vvf9C2BNAuNtBfvDuCHKZagQV42lmRO/prXBCZjkW3ZZ3hwk
         Jczk11bjq7I22lO5FXx3Cv+SkJsGNW8jJpY7iS/VIx1ffR9mpD3RDFlvndyA3e8x9Alr
         6QPProd6aRmwALdzTdJsVCMlHrkxqI1AW5ZjKvvcErXKcQfWmYWhZWW7R+Oq9m6VkwEe
         wobg==
X-Gm-Message-State: ANoB5pmoXe0BrFhm0D5f4G0DvTHNz6FRQflSEHfcpKz6+EGIskEpHssP
        9IIxzk2mugw2LspljThKmOlmhx/RTBEmYSUKlWMo+uymJLoKABo+6JqQCWCB4K0I7RXqTLaDeL9
        vC8kLmUJ6A4hrZP3n442uSxC6RTk/GnPGyOq0u6hsdhw9DG6Hlo136Me6QLLYhLI=
X-Google-Smtp-Source: AA0mqf6mar72o6/neswRpvo+t9z83CtE9aPj/15yjxGfPE/S8NE/BafbfYudL3mYewuVMuiu+j1IGtnIbUvjlw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:24c5:b0:56e:b06c:f97a with SMTP
 id d5-20020a056a0024c500b0056eb06cf97amr22781394pfv.57.1667954842271; Tue, 08
 Nov 2022 16:47:22 -0800 (PST)
Date:   Tue,  8 Nov 2022 16:47:04 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221109004708.97668-1-chooglen@google.com>
Subject: [RFC PATCH 0/4] git: remove --super-prefix
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

*Note to maintainer*: See "Interactions with other series".

Given the work on ab/submodule-helper-prep-only, I'm sending this early
for feedback, and to see if I can avoid blocking =C3=86var's follow-up work=
.
This is pretty much done, but I haven't scrutinized the patches too
closely to see if all of the relevant paths are tested.

The main motivation behind this is the partial clone bug demonstrated by
the test in Patch 3/4, but instead of just fixing that one issue, I'd
prefer to get rid of this class of error once and for all.

=3D Description

When we introduced the internal-only "--super-prefix" in 74866d7579
(git: make super-prefix option, 2016-10-07), we specified that commands
must prefix paths by it, and pathspecs must be parsed relative to it.
That commit also includes safeguards to ensure that "--super-prefix" is
used correctly, namely:

- Only commands marked SUPPORT_SUPER_PREFIX can be invoked with
  "--super-prefix".
- The super prefix is propagated via the GIT_INTERNAL_SUPER_PREFIX env
  var, so a non-SUPPORT_SUPER_PREFIX command cannot be invoked by a
  SUPPORT_SUPER_PREFIX one.

However, its use is inconsistent, which is a strong reason to consider
using better-scoped flags instead. For example..

- Of the 4 commands that are SUPPORT_SUPER_PREFIX, only "read-tree" and
  "submodule--helper" do anything useful with it. "fsmonitor--daemon"
  has it to avoid the SUPPORT_SUPER_PREFIX warning [1].
  "checkout--worker" doesn't have a documented reason, but since it can
  be invoked by "read-tree", it's presumably also a workaround.
- "read-tree" and "submodule--helper" use different values for the super
  prefix; "read-tree" passes the path from the root of the
  superproject's tree to the submodule's gitlink, while
  "submodule--helper" passes the relative path of the original CWD to
  the submodule.
- "submodule--helper" doesn't use "--super-prefix" to parse pathspecs,
  only to display paths.

This series replaces the top-level "--super-prefix" with better-scoped,
per-command flags.

=3D Interactions with other series

As noted in the conversation starting at [2], the submodule--helper bits
in this series have substantial overlap with
ab/submodule-helper-prep-only and the work that series is prep for. I've
based this series off ab/submodule-helper-prep-only, since the
conversion of builtin/submodule--helper.c to use options parsing makes
patch 1 much easier to reason about.

=C3=86var: The patch of interest is 1/4, which removes the super prefix che=
ck
from submodule--helper. Hopefully you find this useful, I strongly
suspect that it will save time and churn for us to move this series
forward and to base your follow up work on this. But if this does end up
stalling, however, I'm happy to rebase this on top of your follow up
work.

=3D Patch summary

- Patch 1/4 introduces a "--toplevel-cwd-prefix" flag for "git
  submodule--helper" (replacing "--super-prefix" for "git
  submodule--helper").
- Patches 2-3/4 refactors "--submodule-prefix" for "git fetch" and
  reuses that implementation for "git read-tree" (replacing
  "--super-prefix" for "git read-tree").
- Patch 4 drops "--super-prefix" and a now-defunct fsmonitor test.

[1]: 53fcfbc84f (fsmonitor--daemon: allow --super-prefix argument, 2022-05-=
26)
[2]: https://lore.kernel.org/git/221104.86wn8bzeus.gmgdl@evledraar.gmail.co=
m

Glen Choo (4):
  submodule--helper: teach --toplevel-cwd-prefix
  fetch: refactor --submodule-prefix
  read-tree: teach --submodule-prefix
  git: remove --super-prefix

 Documentation/fetch-options.txt    |  5 --
 Documentation/git.txt              |  7 +--
 builtin.h                          |  4 --
 builtin/fetch.c                    |  7 ++-
 builtin/read-tree.c                |  4 ++
 builtin/submodule--helper.c        | 52 ++++++++-----------
 cache.h                            |  2 -
 environment.c                      | 13 -----
 git.c                              | 40 +++-----------
 repository.c                       |  1 +
 repository.h                       |  9 +++-
 submodule.c                        | 83 ++++++++++++++++++------------
 submodule.h                        | 20 ++++++-
 t/t1001-read-tree-m-2way.sh        |  4 +-
 t/t5616-partial-clone.sh           | 43 ++++++++++++++++
 t/t7412-submodule-absorbgitdirs.sh | 13 ++++-
 t/t7527-builtin-fsmonitor.sh       | 50 ------------------
 unpack-trees.c                     | 32 ++++++------
 18 files changed, 187 insertions(+), 202 deletions(-)


base-commit: 69d94464e14de859ff56bcde7ebe0132201eceb9
--=20
2.38.1.431.g37b22c650d-goog

