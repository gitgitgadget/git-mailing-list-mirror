Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 385A4C48BDF
	for <git@archiver.kernel.org>; Sun, 20 Jun 2021 20:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13C9161004
	for <git@archiver.kernel.org>; Sun, 20 Jun 2021 20:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbhFTUF1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Jun 2021 16:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbhFTUFZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Jun 2021 16:05:25 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2184C061574
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 13:03:11 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id nb6so24976062ejc.10
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 13:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8RgQQgPwIZBGE6qoRovpOK7G5R/488F3sp5hyzvlDUE=;
        b=V2pTBx13yE8IcSLILNGnvbi5JWZumA0FbyQagS7/91h7D40vm3t+ybUpBWXpmhgJQ7
         fG+FCcXf1NIndg962rQykOgvtjPYekQ/aoROP5XxvVCVYULE8ZV3TOyCe2negz8G/ueT
         PUd5xtrLE2DahPv76XTHC48f1Mr4wmfDsc3deV4doKOTXTF9xe2dEBh6/12fZ23vmGZO
         +pheq7PDuKAx36DND2VMX8wBQAcsl1T5/cELGRtd46cbYI22gLLmSUnX2WMXGT6esDs2
         uJQoy5hFrbSY9a5NBC+EiMv5Q9Px3aiDt60uEwOg5VraHh80f7ZOqEf68iqxDQAqg0lb
         nBmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8RgQQgPwIZBGE6qoRovpOK7G5R/488F3sp5hyzvlDUE=;
        b=iHAQH9b9bWkMiNwAuctygLkrpXRLJqjgg1Z3yHGEAoQJlb68/GOc7wqNyAKh5Y9GKc
         Z0Nn9zRtpbkwFW9kN+xsed4z1Jh1EFGa2od2G/H9rYOJ6RkOXfx2ucE7OlmZtpilQNBU
         Wzu9wnczhcl3gnjz9KDTuXChouVhRzCX2udLRRaQu2n+cmH3q1DnSvMwIeLS2zWL99gT
         R7OpOAsCBveW6a7E2kWyUyOBkUKVEEb0rvpHaFzA/ErVRnfzQBc8Qb/ILnoVgzVRQLlv
         7zQRIDkF4getQ/cIJy1jpTaPDq8M6wD6KjiknJ+832YlsBEltiw9y2XJ3frKeGX1YOfe
         3AQA==
X-Gm-Message-State: AOAM533MJHIrrrr7PhmzWPLdV+KZQeVf/m3OHiah+XkS08Yxe9K1U2dV
        gjdkDGRtLUMf60DBORkXpAUQy7E/iTI=
X-Google-Smtp-Source: ABdhPJyox1ki1gw1tk/oOadg+zKdMph08ldh4XO/GnCpl69qx/lErx6YrIb2/84THQCWxospULTBYQ==
X-Received: by 2002:a17:906:144b:: with SMTP id q11mr20761777ejc.478.1624219390344;
        Sun, 20 Jun 2021 13:03:10 -0700 (PDT)
Received: from localhost.localdomain (94-21-23-215.pool.digikabel.hu. [94.21.23.215])
        by smtp.gmail.com with ESMTPSA id cw10sm3893904ejb.62.2021.06.20.13.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jun 2021 13:03:09 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 0/7] progress: verify progress counters in the test suite
Date:   Sun, 20 Jun 2021 22:02:56 +0200
Message-Id: <20210620200303.2328957-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.32.0.289.g44fbea0957
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Splitting off from:

  https://public-inbox.org/git/cover-0.2-0000000000-20210607T144206Z-avarab@gmail.com/T/#me5d3176914d4268fd9f2a96fc63f4e41beb26bd6

On Tue, Jun 08, 2021 at 06:14:42PM +0200, René Scharfe wrote:
> I wonder (only in a semi-curious way, though) if we can detect
> off-by-one errors by adding an assertion to display_progress() that
> requires the first update to have the value 0, and in stop_progress()
> one that requires the previous display_progress() call to have a value
> equal to the total number of work items.  Not sure it'd be worth the
> hassle..

I fixed and reported a number of bogus progress lines in the past, the
last one during v2.31.0-rc phase, so I've looked into whether progress
counters could be automatically validated in our tests, and came up
with these patches a few months ago.  It turned out that progress
counters can be checked easily and transparently in case of progress
lines that are shown in the tests, i.e. that are shown even when
stderr is not a terminal or are forced with '--progress'.  (In other
cases it's still fairly easy but not quite transparent, as I think we
need changes to the progress API; more on that later in a separate
series.)

These checks did uncover a couple of buggy progress lines which are
fixed in this series as well, but I'm not sure that the fix presented
in patch 6 is the right approach, hence the RFC.


SZEDER Gábor (7):
  progress: introduce GIT_TEST_CHECK_PROGRESS to verify progress
    counters
  progress: catch nested/overlapping progresses with
    GIT_TEST_CHECK_PROGRESS
  progress: catch backwards counting with GIT_TEST_CHECK_PROGRESS
  commit-graph: fix bogus counter in "Scanning merged commits" progress
    line
  entry: show finer-grained counter in "Filtering content" progress line
  [RFC] entry: don't show "Filtering content: ... done." line in case of
    errors
  test-lib: enable GIT_TEST_CHECK_PROGRESS by default

 commit-graph.c              |  2 +-
 entry.c                     | 10 +++---
 progress.c                  | 29 ++++++++++++++--
 t/t0500-progress-display.sh | 69 +++++++++++++++++++++++++------------
 t/test-lib.sh               |  6 ++++
 5 files changed, 86 insertions(+), 30 deletions(-)

-- 
2.32.0.289.g44fbea0957

