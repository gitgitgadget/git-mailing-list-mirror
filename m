Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ECE7C6FD1C
	for <git@archiver.kernel.org>; Wed, 22 Mar 2023 16:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjCVQBF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Mar 2023 12:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjCVQBE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2023 12:01:04 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051A637707
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 09:01:03 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id bi18-20020a05600c3d9200b003ee7b53fd72so131601wmb.2
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 09:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679500861;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TsZT/PFu5cSqPWPP9djdFd6uPdo0PSdGHTBMwkvBMSA=;
        b=BlHBCtl7h9NDJ0ik/UPSRS+QDFenFo5fuEDFWHMoZEU/bbq/DqnMai4VBGiTxbLpAc
         BTTV0u7c8UGQY7WYIaAIATuCOD0s4MePa46gN7DjgeCjj+o2hzuwstKjmEpQmCH/1BKD
         HXQYHHv4bBGXVY3nUhUMTlvZeMTnIbgyXzb+UI1i+Wmv5f8epc5jsNa/GODxgMRobqwL
         9VXvxBckBIbk5BbCGM42aBtW7uDcPmpKL2s9poz6tzM/sP4nFn4I6c9hEssfy0l4/tSO
         nP6TwmtZYcVCSCDNtrWRr/9/5lNOcLVW1vRiP4UejnzKy/mW3+aZzLeZgN4EU58ENyOt
         zdTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679500861;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TsZT/PFu5cSqPWPP9djdFd6uPdo0PSdGHTBMwkvBMSA=;
        b=641zm6QrTyCjozy5Fs8BJzEjMK9FHLtagkziBhzWK7p3PypFv3qjXvXwrSSbi4Mhbk
         Mj9e/BJg7zRZWvotVf8wwkxgGZeZp3DVoUv196XlxZMASGwaEF9OXzdV7frMJiI8KUUj
         bjsWUsdxVTKs723trp1cExSY0M54NfKE+qyaCzv2vZQ4ZNHUaYh14ISeTFp2/Gq6ue58
         yg9jybgxHbI5N75afrhiZ/ClLmBzg2BNGrdhme7Aeo13L1BeKfO3gFSdC5jVOKzarklM
         tPysRncz4J8JGhuPAYKp/GCi0V4FH6fNhoZb7Ou/YoNt3CBqCshzIfA02fNSE06jrCAN
         Buog==
X-Gm-Message-State: AO0yUKWlChQOUmxU35H/Ff7nOdTfZ4awb8iXyT53Rul1mPrYZJMzWTCk
        XRFivNwdslIwMCsVMqCVY8wkBgXNgCM=
X-Google-Smtp-Source: AK7set/bh9biFvq2Fm7tZ1eJAYnDVrMINTvfhrcGSvH7EILcCaT1aQvat9O34ZHlkU9cX0yfykO8HA==
X-Received: by 2002:a7b:c013:0:b0:3ed:4e5d:99fd with SMTP id c19-20020a7bc013000000b003ed4e5d99fdmr38200wmb.13.1679500861212;
        Wed, 22 Mar 2023 09:01:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z23-20020a7bc7d7000000b003ee1b2ab9a0sm6914832wmk.11.2023.03.22.09.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 09:01:00 -0700 (PDT)
Message-Id: <pull.1497.git.1679500859.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 22 Mar 2023 16:00:55 +0000
Subject: [PATCH 0/4] Fix a few split-index bugs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I received an internal bug report that after upgrading from v2.39.2 to
v2.40.0, some users ran into the following error message:

BUG: fsmonitor.c:21: fsmonitor_dirty has more entries than the index (57 > 0)


It sounds very much like the report we received in
https://lore.kernel.org/git/CAC7ZvybvykKQyMWcZoKXxFDu_amnkxZCDq2C6KHoyhmHN2tcKw@mail.gmail.com/,
but sadly that thread petered out when the reporter stopped being able to
reproduce the problem.

After a few days of investigating, I am convinced that this is due to some
old bugs, and not actually a regression in v2.40.0 (although I can believe
that some improvements in v2.40.0 might make it easier to run into these
bugs).

This patch series addresses those bugs.

Note: While the Git maintainer has stated a strong preference to introduce
regression tests in the same patch that fixes the corresponding regression,
this patch series starts with a stand-alone patch that demonstrates a
problematic scenario via a new test_expect_failure test case. The reason why
I specifically split out the test into its own commit is that there is a lot
of information to unpack in the commit message that is larger than any of
the subsequent bug fixes. Besides, it motivates not only the second patch
(which marks the test case as test_expect_success) but paints the larger
picture necessary to understand also the need for the remaining two patches.

This patch series is based on maint-2.37, the oldest maintenance branch it
applies without merge conflicts. When merging with next, there are only
trivial conflicts in unpack-trees.c due to en/dir-api-cleanup where
o->result is now o->internal.result.

Johannes Schindelin (4):
  split-index & fsmonitor: demonstrate a bug
  split-index; stop abusing the `base_oid` to strip the "link" extension
  fsmonitor: avoid overriding `cache_changed` bits
  unpack-trees: take care to propagate the split-index flag

 fsmonitor.h                  |  2 +-
 read-cache.c                 | 37 ++++++++++++++++++++++--------------
 t/t7527-builtin-fsmonitor.sh | 37 ++++++++++++++++++++++++++++++++++++
 unpack-trees.c               |  2 ++
 4 files changed, 63 insertions(+), 15 deletions(-)


base-commit: eb88fe1ff5ceb34845f0919b8bdc60d8a1703cf6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1497%2Fdscho%2Ffix-split-index-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1497/dscho/fix-split-index-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1497
-- 
gitgitgadget
