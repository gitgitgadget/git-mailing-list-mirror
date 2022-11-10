Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05516C43219
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 16:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbiKJQpj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 11:45:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbiKJQpN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 11:45:13 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B03F1FCC4
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 08:43:45 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id y16so3078398wrt.12
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 08:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Wa/Hd95TEaqoQSJp1TmcOmOVJLVrmyKJMUcDb34Alzs=;
        b=AOjTZ82NCDqzkAP3iJjI221q2zZCfGs/w0xOnkPN0wrN2CE6WLm+gjNuw5LClmAlA7
         Vqo+ULf64Vz425jHjM0lpx193J6U+I2qYGC5hg5lN7Aj2pKHGH4QqrSXM82PmwEuEA38
         o7h74VIztL6wvTJDmSMLD7HXnlOXecBAjSAajESUXV1jk/h/x3E/neqfaAvIsX4WvClB
         f1AXHY6VL5DcxNa+vMC0/kfry3gfvZy6/YkPT/TNRa+S4ydZ7dvKlT8NRIlaqyIFj+e6
         evkxvnDqLglIY6aLGCb2+GqdCLZHa5NELrXvqx/3Qajfid+/6rN5hEgQVPO18qiFyApK
         Ajww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wa/Hd95TEaqoQSJp1TmcOmOVJLVrmyKJMUcDb34Alzs=;
        b=z3F/dEa2GtwctVhjdwF6UWQQJ4o4IKEWPxV4SgbKlIgRxnjyFLONj+xhpEFIlQQu07
         nDwKuTqYqozFE/5mxyL3fLK9AcG3iU6NQUz4KExAd4cMcryt0tyMzH9roAT8tozyQ2Rc
         n3e4EhiACcqQvw/zTku778qISO8cvbp/Q66FEGlXqLMw5cbm7I8MttAJ9Lf94VG46n2P
         kOVCEqbCkPz/2MzFqIPFzSmOMDdRMI4uM1IDXM96y+lwdvIlgQAG2D4I36qQgmv2V5Lo
         1X8g/YPRHBtTlW7WXge/3/tFx2rDxRidknNd2WhwD+b562jTTdfvi5I8xJla5rPtf6gr
         dfZw==
X-Gm-Message-State: ACrzQf2heHijQJ4eH7sh4pBt3Kcp1CLZVFdcB27WIV7IvW8SdzWbrMYL
        kq+QXq3EcuLIS2YiyQw6qsH5hj/ilkk=
X-Google-Smtp-Source: AMsMyM5Rdj7KoUJnIwSmqsqV3o8i8AM3ZVLcVs//FdZMri+39daOD2BF2ozDMDfKa37QQINDd1uEtA==
X-Received: by 2002:a05:6000:c9:b0:22e:3f37:fdc with SMTP id q9-20020a05600000c900b0022e3f370fdcmr1021802wrx.665.1668098623561;
        Thu, 10 Nov 2022 08:43:43 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t128-20020a1c4686000000b003c3a1d8c8e6sm71246wma.19.2022.11.10.08.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 08:43:42 -0800 (PST)
Message-Id: <pull.1414.git.1668098622.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Nov 2022 16:43:39 +0000
Subject: [PATCH 0/2] rebase: stricter label lookups
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If a rebase label does not exist and a branch or tag named refs/rewritten/
does exist it will use that instead of returning an error.

Phillip Wood (2):
  sequencer: unify label lookup
  sequencer: tighten label lookups

 sequencer.c              | 53 +++++++++++++++++++++-------------------
 t/t3430-rebase-merges.sh | 17 +++++++++++++
 2 files changed, 45 insertions(+), 25 deletions(-)


base-commit: 3b08839926fcc7cc48cf4c759737c1a71af430c1
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1414%2Fphillipwood%2Fsequencer-label-read-refs-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1414/phillipwood/sequencer-label-read-refs-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1414
-- 
gitgitgadget
