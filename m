Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4274C43334
	for <git@archiver.kernel.org>; Fri, 17 Jun 2022 00:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379216AbiFQAUm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 20:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379006AbiFQAUl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 20:20:41 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C056338A
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 17:20:41 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id u2so2835861pfc.2
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 17:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Q15QEuXCCRuZZrKHul6B4xaF+3fs1brSmg7/UwM+b8=;
        b=Q/FO75Q1rXDbc298cWAen5smzf1OUX9MH7krk+1m9K79CuvQJ2ITiqLSLNTX6Xyphz
         l6IiHwKnp1k5feU9tcGV3G19tQHQRQo8pBPjlHuvop9ThN9MEhFkpHw9Zs7UHZcJpNFY
         Ec/QwjTd8r1gFNcyUxUkYbaiNPYeZOKNYHuD79/vjgEnJVhuiFWJJsIaiXmeAjQ5DYl+
         CKDAEK9kXwHoVdsHwJxNlKeiebMmTaM6y3e6wDN9GL/2E8coHldvxs2v03Nw3woYRDwK
         Z1cIcakdTIiCOBQCqJRLko5eUIR6STLBuekjDAjujK1Mju9qiZcxpDZ+P7fKVSuvrxgl
         ygRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Q15QEuXCCRuZZrKHul6B4xaF+3fs1brSmg7/UwM+b8=;
        b=a0dKteVbf0Cp3yow+TbTHYARvmdgm+S9qxgIjr0fE/+NPSdtXIUTXaLNZUFdtDjKvf
         rGUppH1WNjEnbYH6UkcKIBKKgx8uwuoMm6O/Lr07KdgyPphTR8aByi3T79rWKHsTCvoI
         IuKEYECZtJaTmle+6bvEUFfDiatTqcvPOZhqLXRafsLQY2OnBAl09ayuJfK76dNqerst
         xsbL3Qq1BXXgT3OkB7jmyiW+i7dyTdFc5M55T49gqNGvx7pyrTyjszzfnTLvbiRn8fY9
         PoB4gNu1wjNCdIJHSvBsXOBTg0hK5eTd5iCvKFmuhn2xUMbn5fnpida8x50IMkqmRHzk
         +FHA==
X-Gm-Message-State: AJIora8QCYZksy1pa3nfywRgYhQHJzrkSM/nOmoi3SEg8ZsxMuJTucmg
        SIoWegycg5rxS95xsdLAQIRPr+keIfo=
X-Google-Smtp-Source: AGRyM1u+rC5ycul0yKdiwD3K/Gj7XorlAw/E66lKfGJxTfqctGG3TDvTiMgxnsGuj8G0oGiF0JX5bA==
X-Received: by 2002:a65:4304:0:b0:3fb:9303:de99 with SMTP id j4-20020a654304000000b003fb9303de99mr6887162pgq.429.1655425239374;
        Thu, 16 Jun 2022 17:20:39 -0700 (PDT)
Received: from JEKELLER-HOME.localdomain ([50.39.231.65])
        by smtp.gmail.com with ESMTPSA id e1-20020a17090301c100b001663165eb16sm2260623plh.7.2022.06.16.17.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 17:20:38 -0700 (PDT)
From:   Jacob Keller <jacob.keller@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v3 0/6] remote: handle negative refspecs with show
Date:   Thu, 16 Jun 2022 17:20:30 -0700
Message-Id: <20220617002036.1577-1-jacob.keller@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The git remote show command does not handle negative refspecs. In fact, the
function will happily show that the refs will be fetched, even though they
won't be.

The first patch in this series fixes the show issue for new refs that should
be marked as skipped. The later patches do some cleanup on the
t5505-remote.sh script, improving the test file, along with some improved
test infrastructure.

Finally, I also noticed that git remote prune doesn't interact as expected
with negative refspecs either, so there is a patch to add an expected
failure for this as well.

I suspect we need to dig into get_stale_heads and make that handle negative
refspecs properly, but I wasn't able to figure that out in the time I have
today.

Changes since v2:
* re-ordered so that the fix is first
* cleaned up helper functions to honor -C instead of hard coding 'test'
* added expected failures for the short comings of this fix

Jacob Keller (6):
  remote: handle negative refspecs in git remote show
  t5505: remove sub shell use in favor of git -C
  tests: handle --global directly in test_config/test_unconfig
  tests: only automatically unset matching values from test_config
  t5505: use test_config where appropriate
  remote: add test for negative refspec with prune

 builtin/remote.c                        |   12 +-
 remote.c                                |    2 +-
 remote.h                                |    6 +
 t/lib-parallel-checkout.sh              |    4 +-
 t/lib-proto-disable.sh                  |   12 +-
 t/lib-submodule-update.sh               |    2 +-
 t/t0001-init.sh                         |   14 +-
 t/t0021-conversion.sh                   |   58 +-
 t/t0210-trace2-normal.sh                |   10 +-
 t/t0211-trace2-perf.sh                  |    4 +-
 t/t0212-trace2-event.sh                 |    2 +-
 t/t1309-early-config.sh                 |    2 +-
 t/t2081-parallel-checkout-collisions.sh |    2 +-
 t/t2082-parallel-checkout-attributes.sh |    4 +-
 t/t3431-rebase-fork-point.sh            |    2 +-
 t/t5505-remote.sh                       | 1132 ++++++++++-------------
 t/t5544-pack-objects-hook.sh            |    6 +-
 t/t5550-http-fetch-dumb.sh              |    8 +-
 t/t5573-pull-verify-signatures.sh       |    6 +-
 t/t5606-clone-options.sh                |   10 +-
 t/t5617-clone-submodules-remote.sh      |    4 +-
 t/t5702-protocol-v2.sh                  |    2 +-
 t/t7814-grep-recurse-submodules.sh      |   16 +-
 t/test-lib-functions.sh                 |  104 ++-
 24 files changed, 667 insertions(+), 757 deletions(-)

-- 
2.36.1

