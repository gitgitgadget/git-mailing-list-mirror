Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A544C433EF
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 15:21:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238161AbhLTPVa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 10:21:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240181AbhLTPTq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 10:19:46 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65F9C0698CB
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 07:01:11 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id t18so20624906wrg.11
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 07:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=+dG+91gcuvuMDMEaCTPNejNAc1tQTWPSllNnDdNSTFE=;
        b=Yk+4fBvxr/6KVdBvf17bb6D0Oy/L5tgdzqAsHlvm1Oodrj7LySqeHXuD20ElOvJydK
         /pHXJ7Xuqju/ZQoinw1V7m2yNuleGKrdd4+o1l1mmSAsJedjPVqLlcAHvsmhp6tkVeK1
         t8Q1RSbAu93ttjNrHHcnOJLN5+Yj/dEZuS708NQ1BCscf9ICwI6h1nzvbRbRfgliZ4yx
         PNoWDUygBApHeS3Z9VRxFp22jFMeDBUNYVkaT6CjhyL+puuocUB+Qbf8lapecrJVmige
         j7xcgy29Yif391LObyx+itjnmSZH7m6J19tPpeZB1y9rvko3Ec1ZI/aCjohbRgAL09Ax
         Fjpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+dG+91gcuvuMDMEaCTPNejNAc1tQTWPSllNnDdNSTFE=;
        b=556TxD7gsgmn2mYHVd6SNqH7stLPZC26zp+5Ccp4eK8nbwxFVN0Gs6G/L+Xgl3yZe9
         BoHI0dknNbf1gzX9vaOmCeKh25sEHQ50ZvTR+Tl3BbOftJu/cl10AcgyTXKdfM4xdvH+
         1tUMqv7FVchIe4makPCWfrxV05pG9idPExrMvTZI1iacOJiESr26xAZjIpzMfZf2qmg/
         3y15dq0rPg9ZIwpbt1zvC2/bywL5FrTMAdkH1NYDGFtGndmusAvtleSf557+rjAn1IbU
         wpbpJPfQ8qK+2MeLSPhnU9oRXQwL3sQBF0YNLB6tbQVbp/VT4Ah+EulinlwdpMoKby64
         8GFQ==
X-Gm-Message-State: AOAM531dOsjHlE5uTu6t0wD6dKIIlKxbPD5o4GHEPVeYU3AQHOaTKXtU
        5G0vkU1hHzTbzCI0r5nLTJ42PoHOVm0=
X-Google-Smtp-Source: ABdhPJx52Bkwr29hbSSaPTC1EI2buXc0k+Pqn1RA0f7ZRpsddP1RIALbD9me/vFd0BvL/29xOvWMdg==
X-Received: by 2002:a5d:6d41:: with SMTP id k1mr13102525wri.134.1640012470172;
        Mon, 20 Dec 2021 07:01:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l2sm8753326wru.83.2021.12.20.07.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 07:01:09 -0800 (PST)
Message-Id: <pull.1099.git.1640012469.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Dec 2021 15:01:00 +0000
Subject: [PATCH 0/9] Trace2 stopwatch timers and global counters
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extend Trace2 to provide multiple "stopwatch timers" and "global counters".

 1. Stopwatch Timers

A stopwatch timer is a thread-safe timer that may be repeatedly started and
stopped to measure intervals of time spent in spans of code. A single
summary "timer" event record is written to the Trace2 event stream at the
end of the program. Timers are accumulated in TLS, so it can also report
per-thread interval times when desired.

Timer events are automatically written during the Trace2 "atexit" handler,
so various subsystems don't need to worry about that.

New timers may be defined by adding a new enum trace2_timer_id value and a
row to the trace2/tr2_tmr.c:tr2tmr_def_block[] global table.

Timer events include the number of intervals (start+stop calls), the total
elapsed time, and min/max intervals.

Two test timers are predefined and used by t/helper/test-trace2.c and the
t/t0211 and t/0212 tests.

 2. Global Counters

A global counter is a lighter weight version of the above that just
accumulates integer values, but without the timing and min/max statistics.

Counter events are written during the Trace2 "atexit" handler automatically,
so subsystems that use these counters don't need to create their own.

New counters may be defined by adding a new enum trace2_counter_id value and
a row to the trace2/tr2_ctr.c:tr2ctr_def_block[] global table.

 3. Rationale

Timers and counters are an alternative to the existing "region" and "data"
events. The latter are intended to trace the major flow (or phases) of the
program and possibly capture the amount of work performed within a loop, for
example. The former are offered as a way to measure activity that is not
localized, such as the time spent in zlib or lstat, which may be called from
many different parts of the program.

There are currently several places in the Git code where we want to measure
such activity -- changed-path Bloom filter stats, topo-walk commit counts,
and tree-walk counts and max-depths. A conversation in [1] suggested that we
should investigate a more general mechanism to collect stats so that each
instance doesn't need to recreate their own atexit handling mechanism.

This is an attempt to address that and let us easily explore other areas in
the future.

This patch series does not attempt to refactor those three instances to use
the new timers and counters. That should be a separate effort -- in part
because we may want to retool them rather than just translate them. For
example, rather than just translating the existing four Bloom filter counts
(in revision.c) into Trace2 counters, we may instead want to have a "happy
path timer" and a "sad path timer" if that would provide more insight.

 4. Notes

The first two commits in this series attend to some cleanup that was
discussed in [2] and [3]. The first (using size_t rather than int) is
harmless and could be done in a separate series if desired. The second
(using a char* rather than a strbuf for the thread-name) is a nice cleanup
before I change how I use the thread-name in a later commit in the series.

[1]
https://lore.kernel.org/git/cbc17f1b-57fc-497f-f1ab-baa8cc84620d@gmail.com/
[2] https://lore.kernel.org/all/YULF3hoaDxA9ENdO@nand.local/ [3]
https://lore.kernel.org/all/xmqqa6kdwo24.fsf@gitster.g/

Jeff Hostetler (9):
  trace2: use size_t alloc,nr_open_regions in tr2tls_thread_ctx
  trace2: convert tr2tls_thread_ctx.thread_name from strbuf to char*
  trace2: defer free of TLS CTX until program exit.
  trace2: add thread-name override to event target
  trace2: add thread-name override to perf target
  trace2: add timer events to perf and event target formats
  trace2: add stopwatch timers
  trace2: add counter events to perf and event target formats
  trace2: add global counters

 Documentation/technical/api-trace2.txt | 159 ++++++++++++++++++++-
 Makefile                               |   2 +
 t/helper/test-trace2.c                 | 184 +++++++++++++++++++++++++
 t/t0211-trace2-perf.sh                 |  49 +++++++
 t/t0212-trace2-event.sh                |  69 ++++++++++
 trace2.c                               | 114 +++++++++++++++
 trace2.h                               |  75 ++++++++++
 trace2/tr2_ctr.c                       |  65 +++++++++
 trace2/tr2_ctr.h                       |  75 ++++++++++
 trace2/tr2_tgt.h                       |  39 ++++++
 trace2/tr2_tgt_event.c                 | 122 ++++++++++++----
 trace2/tr2_tgt_normal.c                |   2 +
 trace2/tr2_tgt_perf.c                  | 112 +++++++++++----
 trace2/tr2_tls.c                       | 110 ++++++++++++---
 trace2/tr2_tls.h                       |  42 +++++-
 trace2/tr2_tmr.c                       | 126 +++++++++++++++++
 trace2/tr2_tmr.h                       | 120 ++++++++++++++++
 17 files changed, 1386 insertions(+), 79 deletions(-)
 create mode 100644 trace2/tr2_ctr.c
 create mode 100644 trace2/tr2_ctr.h
 create mode 100644 trace2/tr2_tmr.c
 create mode 100644 trace2/tr2_tmr.h


base-commit: e773545c7fe7eca21b134847f4fc2cbc9547fa14
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1099%2Fjeffhostetler%2Ftrace2-stopwatch-v2-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1099/jeffhostetler/trace2-stopwatch-v2-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1099
-- 
gitgitgadget
