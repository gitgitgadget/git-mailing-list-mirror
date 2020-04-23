Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03908C54FCB
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 13:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D816720728
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 13:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s/UjpNOs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbgDWNsH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 09:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726429AbgDWNsG (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 23 Apr 2020 09:48:06 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2770EC08E934
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 06:48:05 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id v63so2953287pfb.10
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 06:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JhkAuUSXXZg11LkphN2dAZHR2scGmokPWAz/UTZSYYs=;
        b=s/UjpNOscllJfpBQjD6efhT9Z5BRvjb6QyMHbW2DRyktnmzJF+8SjGwYkNJYjmiS78
         szRWbiNX8J7+G/y2vch6yTs840qMkpN0HNCqDDg6cv/vMdPttF3fcQFmcab73chTtL7B
         0wTVRWNEOW9xL48zLUDIIJC0LehRoRHiKgtbCX116u6EyRyppJc9phHREnjtN+IjtK97
         YFl56HUvP1kTzGBkKiBX+ldSOhJZuBZl5o2uTN2rGf9GfOWKWcXOnPjRfmo76A4Fu85j
         Vfk3r0XW8Ku1rkr54x+e9aTf8R/fcGfKkKk3soYDJSQQ6OQGAjxxkIixTxCA4Ss2svZf
         x+tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JhkAuUSXXZg11LkphN2dAZHR2scGmokPWAz/UTZSYYs=;
        b=HUmu2NNuaGyhHHfa6XXHAVhaK6M1wG65Ctq8XoD8nRs2FsvLMOEdTYkWFwI449CjZr
         L0u2z5yXx858JmqDyW1jHqKOj/TISQhj5mOJ2e9V55QtvfmpxBEWZybTF1aqvU/HWHzR
         pmVZ11fPLbze9HoVe2JsK/CHHtuyvZU8cDxu217S2Je7XYAYDpsexBTL3ju9/fsot3ZV
         tPxfdaXYFqkVbPYu45saIS5X/yiAX4tPq0uNoeYAKLzJSRwWe2btuBaXzcEZdsDFVkuG
         ct/+vR1cfRZ9+U8tFdppoK0CF0kzHb4QeT15vaq6y+ar9vjdhvTv8+tJSkZU3OcFOH+V
         IHwQ==
X-Gm-Message-State: AGi0PuYAPUmPj1eUmmKDvUBNW8EMu+IB71Orb0Vm3LRV5FYnrx7nfhLF
        +t6oxyq9I9+lz+kdVS8nMkdxTKov
X-Google-Smtp-Source: APiQypKr1hSNUJvvSr+WSOBV7mswsD56HKJivB4Od03oee97pZe8U6ChoyVglx2qEDbTfJYCFO7zQA==
X-Received: by 2002:a63:5d5c:: with SMTP id o28mr4190377pgm.322.1587649684267;
        Thu, 23 Apr 2020 06:48:04 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:f359:1ce8:a621:5f80:1116])
        by smtp.gmail.com with ESMTPSA id z23sm2635958pfr.136.2020.04.23.06.48.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Apr 2020 06:48:03 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH 0/4] fix make sparse warning
Date:   Thu, 23 Apr 2020 20:47:52 +0700
Message-Id: <cover.1587648870.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.2.384.g435bf60bd5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's happened that I tried to run make check on project that support autoconf.
Git's Makefile told me to run `make sparse` instead.

I /think/ if we have a rule in Makefile, we should adhere to it.
I also fix another change in ds/blame-on-bloom, which I think it's worth to
fix, see: <20200423133937.GA1984@danh.dev>

This series is developed from latest master.

It's conflicted when merge down next and pu.

For next, please ignore the conflict with fmt-merge-msg.c and
apply [5/4] instead.

For pu, reftable.c has too much warnings, I'm too lazy to look into it.

Đoàn Trần Công Danh (4):
  C: s/0/NULL/ for pointer type
  compat/regex: silence `make sparse` warning
  graph.c: limit linkage of internal variable
  progress.c: silence cgcc suggestion about internal linkage

 add-interactive.c                   | 2 +-
 builtin/fmt-merge-msg.c             | 2 +-
 compat/regex/regex.c                | 1 +
 compat/regex/regex_internal.c       | 2 +-
 compat/regex/regex_internal.h       | 5 ++---
 graph.c                             | 2 +-
 log-tree.c                          | 4 ++--
 progress.c                          | 2 ++
 range-diff.c                        | 2 +-
 t/helper/test-parse-pathspec-file.c | 6 +++---
 10 files changed, 15 insertions(+), 13 deletions(-)

-- 
2.26.2.384.g435bf60bd5

