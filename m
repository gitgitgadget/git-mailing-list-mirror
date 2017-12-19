Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 114071F406
	for <e@80x24.org>; Tue, 19 Dec 2017 22:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752298AbdLSW0t (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Dec 2017 17:26:49 -0500
Received: from mail-it0-f45.google.com ([209.85.214.45]:44495 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751820AbdLSW0s (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Dec 2017 17:26:48 -0500
Received: by mail-it0-f45.google.com with SMTP id b5so4540225itc.3
        for <git@vger.kernel.org>; Tue, 19 Dec 2017 14:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=yMfuUJffbiK2Q/89ShLjQ1ZtyPF3FX6AeadPj7Mk5AA=;
        b=JHS/z98YO/NiFIysgqZQ0mBs9i9uq96mbSuedKkzDwNyY726d+uDQp3dsF0RLmmab8
         c54kuj+otqpI9mrgjwOgJ3POb9KroHiSYeFiOsACENQQFSCzyyfq+iJD2H7TPGJ7Yku9
         sd6VYv9DBFLuED6K+AxOFI2rjBIRAHXz/58K68JTY4j65s5rJdV2REMbQSnKvvztp6jN
         fvcD3vxY2FkCfu7+snliZvAwcdHuRU3ACge3Vr/xuTsBPfH50OIHWLrl+G61Wbze54MJ
         WWIeoQ4Wgvgu4eCdUqfS/FC0DYu9G7h+5yE7EE3CookmJIEytHVyruaPHCgMpm0cycW4
         yapw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yMfuUJffbiK2Q/89ShLjQ1ZtyPF3FX6AeadPj7Mk5AA=;
        b=DZ+qZGw0RzzrtfM6U4hGv3zXWjdxUthrAmjOfJS91D3lHhLKA2Gvxpx3ZCUmfKS37Q
         xKZwvtw3X0G4qRtw7gwAk6rIpYGdPeIOx8JCvNSaFYzKisYw7Se6XEyvjQW+pmB8fJbi
         XsTH1TXWxOL1L5vLQgsMZQIPy7ThDy0uunEodvmW3378sHVFaR++7aMHhil6nO11aonV
         3QyjEsa7P1+6HNuADgTspj/ndi7iNKVshzXM5hTIUs1GBUPFnc+3DdaJ29bw3MyrQgnP
         hcd5s7Bt1I4mvfaeXbeuNaUxyB2BD62UZcJFbjiKOHipWERxVa6+gEetGBG0Q+1BP7G5
         g2OA==
X-Gm-Message-State: AKGB3mL9VZBniX5XFantjlDQftPSErL7DFClfiHYYUnXDQTwQAf+0izS
        H8UMTzM0CtBRyM4Na7y2e3tZx1eoVpg=
X-Google-Smtp-Source: ACJfBosOJ/eu5tHNS5hedNASdFEAffwaHEKETyTfKOCqUcGStU1GQRpUOT2QwOAXVEbiqaBrqyNGng==
X-Received: by 10.36.249.132 with SMTP id l126mr5423786ith.52.1513722407462;
        Tue, 19 Dec 2017 14:26:47 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id 139sm4580897itm.2.2017.12.19.14.26.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Dec 2017 14:26:46 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/5] Fix --recurse-submodules for submodule worktree changes
Date:   Tue, 19 Dec 2017 14:26:31 -0800
Message-Id: <20171219222636.216001-1-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.620.gb9897f4670-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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

Stefan Beller (5):
  t/lib-submodule-update.sh: clarify test
  t/lib-submodule-update.sh: Fix test ignoring ignored files in
    submodules
  t/lib-submodule-update.sh: add new test for submodule internal change
  unpack-trees: Fix same() for submodules
  submodule: submodule_move_head omits old argument in forced case

 submodule.c               |  4 +++-
 t/lib-submodule-update.sh | 16 ++++++++++++++--
 unpack-trees.c            |  2 ++
 3 files changed, 19 insertions(+), 3 deletions(-)

-- 
2.15.1.620.gb9897f4670-goog

