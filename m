Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C75C48BC2
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 21:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2E6761002
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 21:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbhFWWAC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 18:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhFWWAC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 18:00:02 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54ACC061574
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 14:57:43 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id c84so2578025wme.5
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 14:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3E2JBw374YBuJIf/NMFQfmRN34XAZuBFxU+AJSa+mDg=;
        b=rXk2iw4oekMh77Da8lEjn/GCi0mjuWpiNrnu02lGdwkFjn9ZZVCvb5WCyoQMNVD9nA
         M0g5uVphf7KzoP/G2yapU6NjnbFYL1Ac4Z99vjykadDmeo4i7wZp+ZQ6B+1tOthBpMew
         SclmND2HO5pOkRflLxp5pnypeAxyrbLL4A1E+6ab86MCKsLkLtrJW/z9HKtNjgNIo8Z3
         sMLBmBEE4kf2Gv/wvHXB+ZCL3o1RGXIpIy4Dy/861a9ypI9tQ97VOabbpuQlYIX9r2+p
         m6USnytQ4Uv2KL4EL4g5OHiwGXQ7daumkxBnvHZIi8T823biYpU4T6AceUR5jSRbQX0n
         p6sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3E2JBw374YBuJIf/NMFQfmRN34XAZuBFxU+AJSa+mDg=;
        b=uUKY0wakKqSzfE8icJabix+lkcAJ0KjnwCs8KsMWNnfoKbhrJrkRrEwmsiN4jCg1Au
         URB8gQ5LLZX0BubIxHbiJyeGIGgQ+1qZwAy4Q/8qwnvnEy0s4j673+tmSl7YRxdhRMUG
         QnCyaPznHNOCb+16BGsdgFn9fphLPV/jenWfpFIpudeEqZGu1SSko2Gin3dxMaMh+cpv
         mhzQpvCHna2I80ZxkevU9HRv2XuDHqMm5Z3aU3Q7jlCWfJAGEC6XD4ftpiW2w0AjJIl/
         oc4Hh2JP2vW5/AiI0pKNHPzLwxzt79T/BsZhKyYDMHWPVBd0akvqnOpQCSYlT4UuaHEt
         5wfg==
X-Gm-Message-State: AOAM530rTU7Bt3tR8tmuQ4PInX/X5JiiHVPxThrMnGOD3s7qCqnDhLP0
        i0dRukSXPqMmDSBOuf2x9bY1EnEjdLQ=
X-Google-Smtp-Source: ABdhPJyEctYyn08ZDDkpdh936OpRgQtQnEMQS/nYgZ5FAkC5rvL9/i88mCI5Qcm5lhBtjoEP96s2tg==
X-Received: by 2002:a1c:5405:: with SMTP id i5mr212163wmb.93.1624485462394;
        Wed, 23 Jun 2021 14:57:42 -0700 (PDT)
Received: from localhost.localdomain (94-21-146-91.pool.digikabel.hu. [94.21.146.91])
        by smtp.gmail.com with ESMTPSA id q11sm1192348wrx.80.2021.06.23.14.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 14:57:42 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 0/4] WIP/POC check isatty(2)-protected progress lines
Date:   Wed, 23 Jun 2021 23:57:32 +0200
Message-Id: <20210623215736.8279-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.32.0.289.g44fbea0957
In-Reply-To: <20210620200303.2328957-1-szeder.dev@gmail.com>
References: <20210620200303.2328957-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 20, 2021 at 10:02:56PM +0200, SZEDER Gábor wrote:
> It turned out that progress
> counters can be checked easily and transparently in case of progress
> lines that are shown in the tests, i.e. that are shown even when
> stderr is not a terminal or are forced with '--progress'.  (In other
> cases it's still fairly easy but not quite transparent, as I think we
> need changes to the progress API; more on that later in a separate
> series.)

So, the first patch in this WIP/POC series is my attempt at checking
even those progress counters that are not shown in our test suite,
either because stderr is not a terminal or because of an explicit
'--no-progress' option.  There are no usable commit messages yet, I
just wanted to see whether it's possible to check all progress lines
and whether it uncovers any more bugs; and the answer is yes to both.

Anyway, the basic idea is that instead of checking isatty(2) in the
caller, let's perform that check in start_progress() and let callers
override it through an extra function parameter (e.g. when
'--(no-)progress', '-v' or '--quiet' was given).  This way
start_progress() will always be called and it would then return NULL
if the progress line should not be shown.  Or, if
GIT_TEST_CHECK_PROGRESS=1, then it would return a valid non-NULL
progress instance even when the progress line should not be shown, but
with the new 'progress->hidden' flag set, so subsequent
display_progress() and stop_progress() calls won't print anything but
will be able to perform all the checks and trigger BUG() if one is
violated.

However, after Ævar pointed out upthread that progress also generates
trace2 regions, I think that it would be better if start_progress()
always returned a valid progress instance, even without
GIT_TEST_CHECK_PROGRESS but with 'progress->hidden' set as necessary,
because that way we would always get that trace2 output, even with
'--no-progress' or 'git cmd 2>log'.

The first patch also converts a good couple of progress lines to this
new approach, and the subsequent patches fix most of the uncovered
buggy progress lines.


SZEDER Gábor (4):
  WIP progress, isatty(2), hidden progress lnies for
    GIT_TEST_CHECK_PROGRESS
  blame: fix progress total with line ranges
  read-cache: avoid overlapping progress lines
  preload-index: fix "Refreshing index" progress line

 builtin/blame.c          |  8 ++++----
 builtin/fsck.c           | 10 +++-------
 builtin/index-pack.c     | 18 +++++++++---------
 builtin/log.c            |  4 ++--
 builtin/prune.c          |  5 +----
 builtin/unpack-objects.c |  6 +++---
 preload-index.c          | 10 +++++-----
 progress.c               | 26 +++++++++++++++++++-------
 progress.h               |  6 ++++--
 read-cache.c             |  9 +++++----
 10 files changed, 55 insertions(+), 47 deletions(-)

-- 
2.32.0.289.g44fbea0957

