Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F890C7618E
	for <git@archiver.kernel.org>; Fri, 21 Apr 2023 19:13:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233414AbjDUTNZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Apr 2023 15:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233306AbjDUTNX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2023 15:13:23 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389F410D0
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 12:13:22 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-2f4214b430aso1328861f8f.0
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 12:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682104400; x=1684696400;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GY4+yK7VMLz9EMfK9WtcuBk67WPj2p4IPbd7F0fHUrs=;
        b=rSRL63xXO1P/DQM0FwnNhCeRKisjO82P5zR6/EEtMdKNOnfiy0wDgopwXX7UBbhF8P
         raWbiKt4DjcJTMZIVTeptN5kLS4QWUnoUgEHBrKLl9QOej9BHmT3CArbhBPcNpZc4l9k
         zQGNjRpD5RTktPWpKpjLMidsrobp32o/s+11U6NyFVEhmpYcw9uaV7alAag9yw9hGvyq
         P6IAL8OMGSP7tFadpkoK6SX/ii3viyq/yrW9hp6JacvWcROzaPV6/EmPN0GoGhvK94Ij
         bzmFjyt0xOLFYkglzhMD1pMePA+F8oLJWKp6Dgu4Fg87d2C51XyfVY71qhQvh45mLFFb
         nP6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682104400; x=1684696400;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GY4+yK7VMLz9EMfK9WtcuBk67WPj2p4IPbd7F0fHUrs=;
        b=NB1ROlaxysPqwjh2oRIJ/B/X/Cq9wrXKFNuIROlWgEpqDZunEP9OajRTprxRI0DpZh
         WJqbyXlrhIl8kMlcj+sRvTzJEoOHW5tLnlEGADnoty4y9fGfA8wGrMi0Hc3tjSW6jz+z
         cvLLVu/eNH6cjytODseqxlsnUGl90k0Jfj2HDRKhuSs2ukdtETOBLYXcsI3tPF6GMH//
         FQsu4hSAt4ibo0SCFIZ+K/0gKecUQUqQAU1WLlqHZAB9ZPzO+FA6r/khU8eY2O2BEVeC
         ieGJhY90fWzEib+NhAxUeLTHthUjdcK7JmPmVrksM+TwEQFP9BBV55EjP71og94hlSS2
         CRkQ==
X-Gm-Message-State: AAQBX9eUjpGAAynTBtNhEKDdUW1AgGnVnYvFr5+DccNyw19VndEihbzj
        2jRcDSfw09DDA8jmp9Wk02CO+DNdYjw=
X-Google-Smtp-Source: AKy350bl7Va6c5KW12eH3Wz/3fegFFNd1nrU7gx0GnhY18tZIdBF1hNOaiJBGb3gyU1xhEY7Eo5jFA==
X-Received: by 2002:adf:cd85:0:b0:2fb:283a:1754 with SMTP id q5-20020adfcd85000000b002fb283a1754mr5425048wrj.32.1682104400370;
        Fri, 21 Apr 2023 12:13:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m10-20020a5d56ca000000b002c54c9bd71fsm4981797wrw.93.2023.04.21.12.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 12:13:20 -0700 (PDT)
Message-Id: <pull.1497.git.git.1682104398.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Apr 2023 19:13:04 +0000
Subject: [PATCH 00/14] [RFC] config: remove global state from config iteration
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Emily Shaffer <nasamuffin@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

= Description

This series removes all global state from config iteration, i.e. parsing
config and iterating configsets, by passing config metadata as a "struct
key_value_info" arg to the "config_fn_t" callbacks. This allows us to get
rid of:

 * "the_reader" (formerly "cf", "current_parsing_scope",
   "current_config_kvi"), and the config.c machinery that maintained it.
   This only needed to be global because it was read by...
 * The "current_*" functions that read metadata about the 'current' config
   value ("current_config_scope", "current_config_name", etc), which are
   replaced by reading values from the "struct key_value_info" passed to the
   callbacks.

As a result:

 * Config iterating code can be moved to into its own library with few
   modifications. C.f. libification efforts [1].
 * The config iterating code can be safely called in parallel.
 * We expose and fix instances where the "current_*" functions were being
   called outside of config callbacks.

We've had this idea of doing this "config_fn_t" refactor for a long time
[2], but we've never attempted it because we wanted to avoid churn. After
attempting it, though, I'm quite convinced that this is the right way
forward for config, since the lack of global state makes things much easier
to reason about. The churn is also quite manageable:

 * The vast majority of changes can be handled with cocci.
 * The few cases that aren't covered by cocci have obvious fixes.
 * The change is simple enough for in-flight topics to perform and conflicts
   will be caught at build time anyway.
 * Anecdotally, we don't change config functions often anyway. This merges
   cleanly with 'seen' and the result passes CI.

= Patch overview

I've arranged the patches in a way that makes them readable, but is
unsuitable for merging, hence the RFC tag. The "Post-RFC cleanups" section
describes all the changes I'll make prior to submitting this as non-RFC.

1-5/14 converts the config.c machinery to set and make use of
"config_reader.config_kvi" instead of "config_reader.source" and
"config_reader.scope", which makes it easier to pass "struct key_value_info"
to config callbacks. To minimize churn, I opted to 'de-plumb' "struct
config_reader" here instead of plumbing it and removing it later.

6-10/14 actually changes "config_fn_t"'s signature. The earlier patches are
minor refactors that make the cocci application + adjustment easier. Post
RFC, cocci application + adjustment will be a single patch, but for ease of
reading I've kept them separate.

11-14/14 teach the config callbacks to use the "kvi" parameter, replace the
now-obsolete "current_*" functions, and remove the now-obsolete "struct
config_reader". This requires plumbing "kvi" through some more config.c
machinery and fixing a sneaky config.c-like code path in trace2/.

= Post-RFC cleanups

 * To make future refactors easier, I'm strongly considering replacing the
   "struct key_value_info" arg with something more extensible so that we can
   modify that without changing 100+ function signatures. An alternative
   would be to replace all of the args to config_fn_t with a single struct,
   but that would very significantly increase churn because we'd need to
   touch all the config_fn_t function bodies too.

 * Rearrange the cocci patches to avoid breaking CI in the middle of the
   series.

 * Fix style issues (e.g. spacing around "kvi", line wrapping, "{ 0 }"
   instead of dedicated initializer)

= Alternatives considered

Ævar suggested in [3] that we might be able to do the refactor incrementally
by having both the old "config_fn_t" and the new "config_fn_t with kvi",
which lets us convert some of config iterating (e.g. configsets) without
touching the others (e.g. config parsing). I experimented with that for a
bit, and it turned out that doing it all at once is actually less work
because we don't have to worry about the case where the same "config_fn_t"
is used in both git_config() and git_config_from_file().

Jonathan Tan suggested in [4] that to reduce churn, we might be able to
convert many of the config_fn_t-s to the config set API before attempting
this refactor. But (hopefully), these patches show that the churn is
manageable even without this preparatory step.

[1]
https://lore.kernel.org/git/CAJoAoZ=Cig_kLocxKGax31sU7Xe4==BGzC__Bg2_pr7krNq6MA@mail.gmail.com/
[2]
https://lore.kernel.org/git/CAPc5daV6bdUKS-ExHmpT4Ppy2S832NXoyPw7aOLP7fG=WrBPgg@mail.gmail.com/
[3]
https://lore.kernel.org/git/RFC-patch-5.5-2b80d293c83-20230317T042408Z-avarab@gmail.com
[4]
https://lore.kernel.org/git/20230306195756.3399115-1-jonathantanmy@google.com/

Glen Choo (14):
  config.c: introduce kvi_fn(), use it for configsets
  config.c: use kvi for CLI config
  config: use kvi for config files
  config: add kvi.path, use it to evaluate includes
  config: pass source to config_parser_event_fn_t
  config: inline git_color_default_config
  urlmatch.h: use config_fn_t type
  (RFC-only) config: add kvi arg to config_fn_t
  (RFC-only) config: apply cocci to config_fn_t implementations
  (RFC-only) config: finish config_fn_t refactor
  config: remove current_config_(line|name|origin_type)
  config: remove current_config_scope()
  config: pass kvi to die_bad_number()
  config: remove config_reader from configset_add_value

 alias.c                                       |   3 +-
 archive-tar.c                                 |   5 +-
 archive-zip.c                                 |   1 +
 builtin/add.c                                 |   5 +-
 builtin/blame.c                               |   5 +-
 builtin/branch.c                              |   8 +-
 builtin/cat-file.c                            |   5 +-
 builtin/checkout.c                            |   7 +-
 builtin/clean.c                               |   9 +-
 builtin/clone.c                               |  10 +-
 builtin/column.c                              |   3 +-
 builtin/commit-graph.c                        |   3 +-
 builtin/commit.c                              |  20 +-
 builtin/config.c                              |  59 +-
 builtin/difftool.c                            |   5 +-
 builtin/fetch.c                               |  12 +-
 builtin/fsmonitor--daemon.c                   |  11 +-
 builtin/grep.c                                |  12 +-
 builtin/help.c                                |   5 +-
 builtin/index-pack.c                          |   9 +-
 builtin/log.c                                 |  12 +-
 builtin/merge.c                               |   7 +-
 builtin/multi-pack-index.c                    |   1 +
 builtin/pack-objects.c                        |  19 +-
 builtin/patch-id.c                            |   5 +-
 builtin/pull.c                                |   5 +-
 builtin/push.c                                |   5 +-
 builtin/read-tree.c                           |   5 +-
 builtin/rebase.c                              |   5 +-
 builtin/receive-pack.c                        |  15 +-
 builtin/reflog.c                              |   7 +-
 builtin/remote.c                              |  12 +-
 builtin/repack.c                              |   5 +-
 builtin/reset.c                               |   5 +-
 builtin/send-pack.c                           |   5 +-
 builtin/show-branch.c                         |   8 +-
 builtin/stash.c                               |   5 +-
 builtin/submodule--helper.c                   |   3 +-
 builtin/tag.c                                 |   9 +-
 builtin/var.c                                 |   5 +-
 builtin/worktree.c                            |   5 +-
 bundle-uri.c                                  |   9 +-
 color.c                                       |   8 -
 color.h                                       |   6 +-
 compat/mingw.c                                |   3 +-
 compat/mingw.h                                |   4 +-
 config.c                                      | 540 +++++++-----------
 config.h                                      |  56 +-
 connect.c                                     |   4 +-
 .../coccinelle/config_fn_kvi.pending.cocci    | 146 +++++
 contrib/coccinelle/git_config_number.cocci    |  27 +
 convert.c                                     |   4 +-
 credential.c                                  |   1 +
 delta-islands.c                               |   3 +-
 diff.c                                        |  19 +-
 diff.h                                        |   7 +-
 fetch-pack.c                                  |   5 +-
 fmt-merge-msg.c                               |   7 +-
 fmt-merge-msg.h                               |   3 +-
 fsck.c                                        |  11 +-
 fsck.h                                        |   4 +-
 git-compat-util.h                             |   2 +
 gpg-interface.c                               |   6 +-
 grep.c                                        |   7 +-
 grep.h                                        |   4 +-
 help.c                                        |  10 +-
 http.c                                        |  15 +-
 ident.c                                       |   3 +-
 ident.h                                       |   4 +-
 imap-send.c                                   |   7 +-
 ll-merge.c                                    |   1 +
 ls-refs.c                                     |   2 +-
 mailinfo.c                                    |   5 +-
 notes-utils.c                                 |   3 +-
 notes.c                                       |   3 +-
 pager.c                                       |   5 +-
 pretty.c                                      |   1 +
 promisor-remote.c                             |   4 +-
 remote.c                                      |   7 +-
 revision.c                                    |   3 +-
 scalar.c                                      |   3 +-
 sequencer.c                                   |  28 +-
 setup.c                                       |  17 +-
 submodule-config.c                            |  31 +-
 submodule-config.h                            |   3 +-
 t/helper/test-config.c                        |  21 +-
 t/helper/test-userdiff.c                      |   4 +-
 trace2.c                                      |   4 +-
 trace2.h                                      |   3 +-
 trace2/tr2_cfg.c                              |  12 +-
 trace2/tr2_sysenv.c                           |   3 +-
 trace2/tr2_tgt.h                              |   4 +-
 trace2/tr2_tgt_event.c                        |   4 +-
 trace2/tr2_tgt_normal.c                       |   4 +-
 trace2/tr2_tgt_perf.c                         |   4 +-
 trailer.c                                     |   2 +
 upload-pack.c                                 |  18 +-
 urlmatch.c                                    |   7 +-
 urlmatch.h                                    |   8 +-
 worktree.c                                    |   2 +-
 xdiff-interface.c                             |   5 +-
 xdiff-interface.h                             |   5 +-
 102 files changed, 855 insertions(+), 641 deletions(-)
 create mode 100644 contrib/coccinelle/config_fn_kvi.pending.cocci
 create mode 100644 contrib/coccinelle/git_config_number.cocci


base-commit: 9857273be005833c71e2d16ba48e193113e12276
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1497%2Fchooglen%2Fconfig%2Fno-global-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1497/chooglen/config/no-global-v1
Pull-Request: https://github.com/git/git/pull/1497
-- 
gitgitgadget
