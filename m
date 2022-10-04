Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27B5C433F5
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 16:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiJDQUO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 12:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiJDQUM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 12:20:12 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78A932BAB
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 09:20:10 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id fn7-20020a05600c688700b003b4fb113b86so7872826wmb.0
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 09:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date;
        bh=qSGO4wR912TefVp0/dRUgaBkF9oGijJ8m+oDKsKGwLo=;
        b=SGQUnrlR+1IKXkgo11w0TnvKSzHsuyN5vYfjFu8GbGkfSwbO4NDR169bvRk9v2VxAr
         wZVmd8ZKpjzYEfNuraxLBBExkDI1tNHN8z6chkiMsD8+qq3pyv12R8R8U+VhCfqmwPzm
         qbfqs0UoJ+WHB9C8on6dSBg9GRU9Ry+kSwparXO46cUJSTvBDKkhGuu9VX/TZl+vi3vx
         008pPu8jp03v2EZ5Qf6L4VDWeO2w/bC8VRYJZZxNdg+8eQMhJDC+d7/cL4cV97ZIVTyb
         bwIrY+hxPH3ehgZtcTRGsBwl0KpaIPZCCZ68/wBOatllTpWctIQdZo64NlPNMEXBVULh
         r4KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=qSGO4wR912TefVp0/dRUgaBkF9oGijJ8m+oDKsKGwLo=;
        b=5Z2bi44kLSbO36hqIwYBoXE5jekZNDbNr0NyI2Ruc0/BDFAp3WKAb4eAjJIxV0ccom
         UEGADmrCtoHH7IgX8WyxsEjddaDXct22hgM0aW68Gx7msUK04grH6E3qdI2vA0msz4gN
         SEyYEj+7CE0Zy+COc+5Bc3S/+BoERfAUJ7VLLHVVBKcRC6x5zo0pz3gOEBzJMEB0IEhk
         QrHH+Ptkz8Oc02JzMjSSTBjB9lSS64yVDPS5j3/TnVrg82S3Tx+pVa01g4lY8cSm6SgX
         NIPlr6IDqduu0cavhuy9pfKtucMuR+SSs6eYScpJeCJO248Hseo1HTVxCB8SASw0zmix
         7WEA==
X-Gm-Message-State: ACrzQf16+Ebz8mokyq5taMmffXahLVpAlYveDEfYY17gic4CH7w/+jEY
        4lFFJOfG4qTK++ijvoLQ/QRGHvGXhaI=
X-Google-Smtp-Source: AMsMyM72p4sK5/M70Ky2l10HrJnSPWMOUAbJCTNRSs/gN/lYN+gxytTRM3pMZIYMy7TgshQCEYSwNw==
X-Received: by 2002:a05:600c:2118:b0:3b4:76ce:d274 with SMTP id u24-20020a05600c211800b003b476ced274mr382764wml.95.1664900408846;
        Tue, 04 Oct 2022 09:20:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d16-20020adfe890000000b0022e035a4e93sm12227021wrm.87.2022.10.04.09.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 09:20:08 -0700 (PDT)
Message-Id: <pull.1373.git.1664900407.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 Oct 2022 16:19:58 +0000
Subject: [PATCH 0/9] Trace2 timers and counters and some cleanup
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series add stopwatch timers and global counters to the trace2
logging facility. It also does a little housecleaning.

This is basically a rewrite of the series that I submitted back in December
2021: [1] and [2]. Hopefully, it addresses all of the concerns raised back
then and does it in a way that avoids the issues that stalled that effort.

First we start with a few housecleaning commits:

 * The first 2 commits are unrelated to this effort, but were required to
   get the existing code to compile on my Mac with Clang 11.0.0 with
   DEVELOPER=1. Those can be dropped if there is a better way to do this.

 * The 3rd commit is in response a concern about using int rather than
   size_t for nr and alloc in an ALLOC_GROW() in existing trace2 code.

 * The 4th commit cleans up my use of the term "TLS" in my thread code.

 * The 5th and 6th commits (hopefully) clear up the misunderstandings around
   the thread_name variable in my thread context structures. My earlier
   attempts to clean and clarify this led to most of the controversies in
   the earlier patch series. Hopefully, these 2 commits will improve the
   clarify matters.

 * The 7th commit cleans up a mostly obsolete section in the trace2 API
   documentation.

Finally, the last 2 commits add the stopwatch timers and the global
counters.

[1]
https://lore.kernel.org/git/pull.1099.git.1640012469.gitgitgadget@gmail.com/
[2]
https://lore.kernel.org/git/pull.1099.v2.git.1640720202.gitgitgadget@gmail.com/

Jeff Hostetler (9):
  builtin/merge-file: fix compiler warning on MacOS with clang 11.0.0
  builtin/unpack-objects.c: fix compiler warning on MacOS with clang
    11.0.0
  trace2: use size_t alloc,nr_open_regions in tr2tls_thread_ctx
  tr2tls: clarify TLS terminology
  trace2: rename trace2 thread_name argument as name_hint
  trace2: convert ctx.thread_name to flex array
  api-trace2.txt: elminate section describing the public trace2 API
  trace2: add stopwatch timers
  trace2: add global counter mechanism

 Documentation/technical/api-trace2.txt | 190 +++++++++++++++++--------
 Makefile                               |   2 +
 builtin/merge-file.c                   |   4 +-
 builtin/unpack-objects.c               |   2 +-
 t/helper/test-trace2.c                 | 187 ++++++++++++++++++++++++
 t/t0211-trace2-perf.sh                 |  95 +++++++++++++
 t/t0211/scrub_perf.perl                |   6 +
 trace2.c                               | 121 +++++++++++++++-
 trace2.h                               | 101 +++++++++++--
 trace2/tr2_ctr.c                       | 101 +++++++++++++
 trace2/tr2_ctr.h                       | 104 ++++++++++++++
 trace2/tr2_tgt.h                       |  14 ++
 trace2/tr2_tgt_event.c                 |  47 +++++-
 trace2/tr2_tgt_normal.c                |  39 +++++
 trace2/tr2_tgt_perf.c                  |  49 ++++++-
 trace2/tr2_tls.c                       |  43 +++---
 trace2/tr2_tls.h                       |  52 ++++---
 trace2/tr2_tmr.c                       | 182 +++++++++++++++++++++++
 trace2/tr2_tmr.h                       | 140 ++++++++++++++++++
 19 files changed, 1366 insertions(+), 113 deletions(-)
 create mode 100644 trace2/tr2_ctr.c
 create mode 100644 trace2/tr2_ctr.h
 create mode 100644 trace2/tr2_tmr.c
 create mode 100644 trace2/tr2_tmr.h


base-commit: 3dcec76d9df911ed8321007b1d197c1a206dc164
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1373%2Fjeffhostetler%2Ftrace2-stopwatch-v4-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1373/jeffhostetler/trace2-stopwatch-v4-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1373
-- 
gitgitgadget
