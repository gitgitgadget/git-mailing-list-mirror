Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 345A31F404
	for <e@80x24.org>; Wed, 20 Dec 2017 22:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755715AbdLTWT2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Dec 2017 17:19:28 -0500
Received: from mail-io0-f174.google.com ([209.85.223.174]:45463 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932314AbdLTWRa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Dec 2017 17:17:30 -0500
Received: by mail-io0-f174.google.com with SMTP id e204so18941718iof.12
        for <git@vger.kernel.org>; Wed, 20 Dec 2017 14:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=LVlhfgRnXkz+Xj6iBLPr3r5GgChc4/V3mRIRO7BFmmc=;
        b=T2NgNFb55CeUuUpCV0C3SYt40/VqUqU9tixHNbRpN8XPBQLvVzGD1X+dGcRaC4ofWj
         PrJOLUfXHbXyzB0PqUO/LjzVAW3xWAYVEetMQzyd7C5HLV1ARNV6efkOItIpIHug1vyI
         v6SLs7/+fm8TZDIwuFBimZ6LULIOyJCz88qe74GA/ordgaPcNiJuKZWEddEGw2eBZKyR
         bTA2wjJB41lVRfDBnpKBwwlmlKRKPKjb2jCjw+NFZWp8zZiBp4g0L3lfSB2rfCQ/9b6W
         fqoGKIg26K4iKJ5QKp5qGgdyRK79BIu2I5Md4pZqCtkcz7v/UwFf7CpB3R6UEToGX7bR
         nKOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LVlhfgRnXkz+Xj6iBLPr3r5GgChc4/V3mRIRO7BFmmc=;
        b=tmx7UH+EjAFpFGgp/W+5/SJn9o2L/YLXCBJI9K8fUtnsmW9TAOw8pXsMDFlPR0+4Vq
         hVErvD70ufhfT5EbOuQz8aBrFp4A+IrEAb3opeQUNxmli/LBXgQHOijDLsXEqAkqnnYe
         Ti7T189/jJCWbfSrMo98S4+1zoQa1DOUZxbZXx/oJwyf4cGtyChTP2rrWo6SA7qLrYRT
         b/jxJOR5j6PtgGAc/HqGG22XGAyPABOWvo+Ey3ttLtWkkyuXvGT3kO93FQ2ST/ek4OHZ
         V2tktnO64jAkED84KPbtyV3Icp+MshOR5ynv/hiSCMI/eNfRKyfIl57ND36essnhoGFw
         nSwA==
X-Gm-Message-State: AKGB3mJl0SPi1I4BlTq9qFIJ+NFUuiijx8DPDGwG3f2RsP6tqVn5Wv3K
        UKoTDHBSkCAxky6u8meRLJjatA==
X-Google-Smtp-Source: ACJfBouQCvrT7bmdvz0XbPIrp27KSyheZH6IZ4vR1lF0BpkbVDPJFEX3SlJ5LF4fgiM5stQwPHXzQw==
X-Received: by 10.107.154.79 with SMTP id c76mr10243248ioe.79.1513808249169;
        Wed, 20 Dec 2017 14:17:29 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id t188sm3193894ita.23.2017.12.20.14.17.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Dec 2017 14:17:28 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     jrnieder@gmail.com, gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 0/4] Fix --recurse-submodules for submodule worktree changes
Date:   Wed, 20 Dec 2017 14:17:21 -0800
Message-Id: <20171220221725.129162-1-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.620.gb9897f4670-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2:
* squashed the test patch and the bugfix, rewriting the commit message entirely.
  This might not the way Jonathan imagined how I address the potential user
  confusion[1], but I think it does the job.

[1] https://public-inbox.org/git/20171220000148.GJ240141@aiede.mtv.corp.google.com/

v1:

The fix is in the last patch, the first patches are just massaging the code
base to make the fix easy.

The second patch fixes a bug in the test, which was ineffective at testing.
The third patch shows the problem this series addresses,
the fourth patch is a little refactoring, which I want to keep separate
as I would expect it to be a performance regression[1].
The first patch is unrelated, but improves the readability of submodule test
cases, which we'd want to improve further.

Thanks,
Stefan

[1] The performance should improve once we don't use so many processes
    any more, but that repository series is stalled for now.


Stefan Beller (4):
  t/lib-submodule-update.sh: clarify test
  t/lib-submodule-update.sh: Fix test ignoring ignored files in
    submodules
  unpack-trees: Fix same() for submodules
  submodule: submodule_move_head omits old argument in forced case

 submodule.c               |  4 +++-
 t/lib-submodule-update.sh | 16 ++++++++++++++--
 unpack-trees.c            |  2 ++
 3 files changed, 19 insertions(+), 3 deletions(-)

-- 
2.15.1.620.gb9897f4670-goog

