Return-Path: <SRS0=jQhj=D2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2635C43467
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 19:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41F3422314
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 19:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7yp3L9B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731281AbgJSTfs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Oct 2020 15:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730021AbgJSTfr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Oct 2020 15:35:47 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3005FC0613CE
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 12:35:45 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id e17so970802wru.12
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 12:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oibkg5DWZ5/5I3pt07ZfEPUIo7r+H20+Y+/upu6mV8Y=;
        b=A7yp3L9BoK2hfHHsUALqNujbVPBzZbso3F3JBHb/SmBzfeLvVk0+3KhNOIAecBU3Z3
         2me3IMa99LSF0/ss4E+GMwvjE8uuMxkshh9QUBHfrs4qM5wtwz3VU3GerHN8dQgvyOB+
         5zhw76E7sW1Ox7Uq+LpI0wQKIyu2t9MN/LoWvwLPrzFWpKhVbAJyCj4+AcK2ckzt+3XQ
         +c4t+ssa+qSNBm5E4gIHlArk/lmXHn9Kf35tN9Ypytsbnms/nYNTmubH659LJdO+UcfK
         Iuh5ECEqLx8+3zabJm5Rm0fQ8FCtV+We/jo1Hr3TH2CUKE65aqw+3xxWJDoX405y33bP
         ACpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oibkg5DWZ5/5I3pt07ZfEPUIo7r+H20+Y+/upu6mV8Y=;
        b=UVF1WpiWe2108YwEF539Qdz/HO3AFx46KJEST+a6D2O/1WT90kJOlNC/jwIddDC8C5
         ZGRv38HCNvOTdNo8jqqGkGx0w/HtPHd7b9EB/Aa23amofWlntrhCdpIPc8jgui+VfbEk
         F8FDTQbjFulH+gzxrkkDlgzuXV/rH9ABCR+bE+6MjE+vqlyEzFjKEbQOpK6W75M4Jmle
         ykqCusMusgwGzWnmOpX+MP8lERvC8ZiPwfVdCqB+d7gOHjjmxAxcZd1K+fYA2ZekW7TB
         ge0b97S4N0oFtbZnJt83U3+dMTo7l76mag4MESMeUZtUpeTzTU5ca//jw4oLb5/Kbebp
         IQpw==
X-Gm-Message-State: AOAM533SJGOIWm8+vFf+ehyLaEfi+DHOcIbbX0ijbu9/lqBDiLkm1IdA
        BcgspeXdR6yWhOi16VHsYK2sA1olPjk=
X-Google-Smtp-Source: ABdhPJwB8G1DHMlF2N2vxCBgbsXU3ulPRW/Fcn7eH2AQ8IxVjZxI+DtxbuU5o/SsC0woDMnSVbh+OQ==
X-Received: by 2002:a5d:66cc:: with SMTP id k12mr817678wrw.47.1603136143753;
        Mon, 19 Oct 2020 12:35:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g4sm685206wmh.13.2020.10.19.12.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 12:35:43 -0700 (PDT)
Message-Id: <pull.753.v2.git.1603136142.gitgitgadget@gmail.com>
In-Reply-To: <pull.753.git.1602600323973.gitgitgadget@gmail.com>
References: <pull.753.git.1602600323973.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Oct 2020 19:35:39 +0000
Subject: [PATCH v2 0/3] Work around flakiness in t5500.43
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It seems that this test became flaky only recently, although I have to admit
that I have no idea why: the involved code does not seem to have changed
recently at all. It should have been fixed by 
https://lore.kernel.org/git/20200506220741.71021-1-jonathantanmy@google.com/
, but apparently wasn't completely fixed, despite what I said in that
thread.

Changes since v1:

 * Instead of papering over the underlying cause, the patch was completely
   changed to actually fix the bug and add a proper regression test for it
   (originally, I wanted to act according to the common notion that good
   programmers are lazy, oh my, see how well that worked out for me).
 * We now specifically watch out for future bugs where incomplete sideband
   messages would be dropped inadvertently rather than being reported at EOF
   or at encountering a flush/error packet.
 * Before sending 0-length data to demultiplex_sideband(), we now make sure
   that it is not marked as a data packet; Otherwise we now complain loudly
   about a bug.

Johannes Schindelin (3):
  sideband: avoid reporting incomplete sideband messages
  sideband: report unhandled incomplete sideband messages as bugs
  sideband: add defense against packets missing a band designator

 pkt-line.c               | 11 +++++++++--
 sideband.c               |  2 +-
 t/helper/test-pkt-line.c | 23 +++++++++++++++++++++++
 t/t0070-fundamental.sh   |  6 ++++++
 4 files changed, 39 insertions(+), 3 deletions(-)


base-commit: d4a392452e292ff924e79ec8458611c0f679d6d4
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-753%2Fdscho%2Funflake-t5500.43-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-753/dscho/unflake-t5500.43-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/753

Range-diff vs v1:

 1:  d977644184 < -:  ---------- t5500.43: make the check a bit more robust
 -:  ---------- > 1:  e4ba96358b sideband: avoid reporting incomplete sideband messages
 -:  ---------- > 2:  9ffcc5b78e sideband: report unhandled incomplete sideband messages as bugs
 -:  ---------- > 3:  c61e560451 sideband: add defense against packets missing a band designator

-- 
gitgitgadget
