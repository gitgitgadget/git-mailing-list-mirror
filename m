Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 709E2C433FE
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 11:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356119AbiBULV7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 06:21:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356225AbiBULUu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 06:20:50 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96703E8A
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 03:10:57 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id d3so10751869wrf.1
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 03:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=WbDn0ma9GNdPml7suaA9VqciMDxsvqQUdG3oW54BJ7Y=;
        b=AmX71nIGVQM8vcrnVJH8HWapL6/b1rcw0XUX65XJFTl+7pd8RXWlYFa1v+QPEMKIzA
         s9XBvcUbb+y6eJl5sZAKk8giMqToAlNMUn0HMjXDBk82TB10dChBU91M7CSHY/phckkG
         PWJw4ihn/L15DBB8tbJZaTnRalWxMHmGgeLRvSAgGAXWs5e9IiZX73mApGhZ8xoNY5Un
         uHqlPK2s5UQrHp3UHwTfHvaIQUp8QH8JfzEbhpSRkVptpxAZpGLq0q+2WWp216EUwOCu
         dEOFXm0iRkRKYevLuPojIiVeiRrLsYg9adhhxJ9YyWZ+feDFictntTqQo3koH0Yi2myw
         Gdtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WbDn0ma9GNdPml7suaA9VqciMDxsvqQUdG3oW54BJ7Y=;
        b=Ig103RvpW7WDBms1SdJf0g0ALzfq1VVZ8S9sc5cVOIUtNhMwx4MvQri1FBhKF+v8YT
         kVOTeNFJtHu/2xQFbOpKu8qddy090kuDcA0TV2EQmbPjf9WJNue4nkwEYRky/V1lm0Xb
         feHh8BR2bt7jkUYfO/lwwQeW9paQ027sbaGZTogxHsTWBe0vC5NgB1UBTaOhlC94FPrb
         SW2luWgOmYvPSt9PVHYLYJ2ivc9rvAzuhysevwQ7uLimQbrQdsp5EzoALW7pxZuux3m4
         L+dAish2SVtpb785KvwCy6uvOY+RJq4jcKWJyEk5HFRKPCqO6JpfUQcZau66Lsa8QwtR
         cfeg==
X-Gm-Message-State: AOAM532EdDSrENc/UKxAR6peG/qE/NV+lpBek2jiSxcp5Ri1Qo6osKZx
        0yrOL6xTfsR011OZugAjE4MmK+AZSJE=
X-Google-Smtp-Source: ABdhPJxAwzPfaIjCahpWO0QgsEGDNsOflnz0MOraSlCSHcbzvn94/VlHkgM5+vKb7Qr5U+oFp+o1ew==
X-Received: by 2002:a5d:64e5:0:b0:1e7:6860:606c with SMTP id g5-20020a5d64e5000000b001e76860606cmr15510867wri.467.1645441855814;
        Mon, 21 Feb 2022 03:10:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z3sm8380654wmp.42.2022.02.21.03.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 03:10:55 -0800 (PST)
Message-Id: <pull.1150.git.1645441854.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Feb 2022 11:10:47 +0000
Subject: [PATCH 0/7] rebase: make reflog messages independent of the backend
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a series of rebase reflog related patches with the aim of unifying
the reflog messages from the two rebase backends.

 * improve rebase reflog test coverage
 * rebase --merge: fix reflog messages for --continue and --skip
 * rebase --apply: respect GIT_REFLOG_ACTION
 * rebase --abort: improve reflog message
 * unify reflog messages between the two rebase backends

This series is based on pw/use-inprocess-checkout-in-rebase

Phillip Wood (7):
  rebase --apply: remove duplicated code
  rebase --merge: fix reflog when continuing
  rebase --merge: fix reflog message after skipping
  rebase --apply: respect GIT_REFLOG_ACTION
  rebase --apply: make reflog messages match rebase --merge
  rebase --abort: improve reflog message
  rebase: cleanup action handling

 builtin/rebase.c          | 144 ++++++++++++-----------------
 sequencer.c               |   5 ++
 t/t3406-rebase-message.sh | 185 +++++++++++++++++++++++++++++++-------
 3 files changed, 214 insertions(+), 120 deletions(-)


base-commit: 38c541ce94048cf72aa4f465be9314423a57f445
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1150%2Fphillipwood%2Fwip%2Frebase-reflog-fixes-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1150/phillipwood/wip/rebase-reflog-fixes-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1150
-- 
gitgitgadget
