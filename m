Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FBD41F404
	for <e@80x24.org>; Wed, 27 Dec 2017 22:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752382AbdL0W5N (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 17:57:13 -0500
Received: from mail-io0-f181.google.com ([209.85.223.181]:34514 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752122AbdL0W5M (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 17:57:12 -0500
Received: by mail-io0-f181.google.com with SMTP id q188so12434415iod.1
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 14:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UL3FCIZKLzzQus1qAx7yV6sXtbc4EUcJMO6jqTXPvh4=;
        b=YYvInETsNk6DRBU+6roiirlyWzjzIM7LTh6QfJS2w5hVVMZUU0PDUbiLEkTMATKLJ9
         j1i8J8IhORriTN0SP1m8Xnlo24TSANnsa7TTqxu3bvyZSPFzA5T3gRojAmdoNVQK6ani
         gI3pXNLgUgbAoBcTwf/75bc9FpLrRJ6Oqzh2AatHPJPlPsUkrHoodEIL9Wrj245N0IkM
         CKqZcRAwuS14dY/puuWvu5Iv58XRYIuu9ZG+pyuDXE/6b4365Ee4PlyIJONeEyr2MGib
         6cVWes5+zrdHoHZCECCOTb912dLYYqJ2SATdXockBPAMffvXGVAAplVLTm/IBObnCCy5
         PTcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UL3FCIZKLzzQus1qAx7yV6sXtbc4EUcJMO6jqTXPvh4=;
        b=dGfy9L9WclwBNjuim6I8YG77bnD6G+VNShGolGmxHa41zaB5/3++PhHpL/bGl+SzOQ
         OuF7dKChLfJpZaj8zAa9Z2IEghkFMP8jGhTLjL5d8SQRH+qOitZy7zbK16urp3qMmyf1
         p7GS/oOaC16+EeIcvdnffhx77V62VZuPIKMaJRWvrDgH1qORQ4LNHG1VZm5+5or5ykiA
         BvRFtPhV6/65EIjSxH2U/HsNghP6HFGsPIWdbJNvyQ/5h4SDG4ZIbZnPe8Mn+38VtFq4
         UV2awakFQUUcFtURw77GVUWKsdouwFZ25KSZP89txc88olGHnfVtBXOPQVqyCJKxzMix
         0fYA==
X-Gm-Message-State: AKGB3mLl/dVBDiUbpix31K4MNEWETFw6frxYXcVFj8tQbaRFBxHBfSqq
        VEAlI3SDPO0kcoXlQQ4SeHfv1w==
X-Google-Smtp-Source: ACJfBovSF8GHqc5EoXTfXTnq6F2JcNN6SwsH/LfV6neDM+qI8nLrgNG8CnrRO1dSzAB2WhO5TXS2jQ==
X-Received: by 10.107.111.5 with SMTP id k5mr20280755ioc.72.1514415431568;
        Wed, 27 Dec 2017 14:57:11 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id i68sm18174810ioi.24.2017.12.27.14.57.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Dec 2017 14:57:11 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, jrnieder@gmail.com
Subject: [PATCHv2 0/5] Fix --recurse-submodules for submodule worktree changes
Date:   Wed, 27 Dec 2017 14:57:00 -0800
Message-Id: <20171227225705.73235-1-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.620.gb9897f4670-goog
In-Reply-To: <20171219222636.216001-1-sbeller@google.com>
References: <20171219222636.216001-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I dropped the patch to `same()` as I realized we only need to fix the
oneway_merge function, the others (two, three way merge) are fine as
they have the checks already in place.

The test added in the last patch got slightly larger as now we also test for
newly staged files to be blown away in the submodule.

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

Stefan Beller (5):
  t/helper/test-lazy-name-hash: fix compilation
  t/lib-submodule-update.sh: clarify test
  t/lib-submodule-update.sh: Fix test ignoring ignored files in
    submodules
  unpack-trees: oneway_merge to update submodules
  submodule: submodule_move_head omits old argument in forced case

 submodule.c                         |  4 +++-
 t/helper/test-lazy-init-name-hash.c |  2 +-
 t/lib-submodule-update.sh           | 19 +++++++++++++++++--
 unpack-trees.c                      |  3 +++
 4 files changed, 24 insertions(+), 4 deletions(-)

-- 
2.15.1.620.gb9897f4670-goog

