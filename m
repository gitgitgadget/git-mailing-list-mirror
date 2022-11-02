Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C883EC433FE
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 12:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbiKBM4R (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 08:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbiKBM4Q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 08:56:16 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B8A286ED
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 05:56:15 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id v4-20020a17090a088400b00212cb0ed97eso1830856pjc.5
        for <git@vger.kernel.org>; Wed, 02 Nov 2022 05:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m33LfFDete9KJeRZxFDkc1CiDs9KG4WGInD4m2UgLwg=;
        b=I8Qm7F77JgXUHeuqslTNHwFOUlC8YzgstYX2nYXIUg4Ea9RSv2h37yFMsGIdHhsw0G
         1Cm3KAqOojnwxATtCjdPVAln38LRqffjqYvtnJCyfiDGftAPZE07SbhauN1VD/yogtFC
         vY4ANO4WgL/EPGePBSIilomPS/qfrk2jj084ZKVvJCdgl48CtQrP0CgkVmL72LuC6S7Z
         BK6Hntmp3iPuMFevHdFkT/1EQDIQNR5q8VL1IIROvUb+7qvXhiWiPrYcOdOogJrLL/gz
         h8UyiIJShx7dlAL4Hyu3CT84p6XcA9M7f3EUnKE+n6M1CVFU0B1HSeXYsooyaW5vvPjT
         t2yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m33LfFDete9KJeRZxFDkc1CiDs9KG4WGInD4m2UgLwg=;
        b=DbBjGxY/zeUiJRmJMJnZmb9icZr3Js/odwP0qmw9AdnCSUWE6cTq2t0xH3brVe8kaz
         Ziiv+96Q0BZehWt8vOAviGOyCzhq5vG2BGGaJ+PpFutNgQ55V/WgokdSll6t/ds6KQ5L
         Kf/ToBwIvDuwJar6/xT+wadFwNBvxigmzTFTjz1mh/llwpEeXo4l9oUdjSjviX3ylIRL
         qs4//ddpSJQGQQ1fd5cfIj3v79d+9+csK1XSTkITOTFiFsAtcNBlxKZqoLIxRHOe7YaH
         ZU9K6JyYAbQYJdqZB3K4linUXjaAZLJQHTtgPGdkgH+ok/f+ZeuwVec7WSjdGZi+FOO4
         1iWA==
X-Gm-Message-State: ACrzQf27P5U1AeYyrJYmZlZRVN6QW1ceI5n0wPcP495eCRdzXLYvt/S5
        hfME6eOJD6z2kUD+xlyR8Rk=
X-Google-Smtp-Source: AMsMyM7ZqufZZuruFrAHxcKxR8TES3EcmWgW6H/sl2fD8bChN2MF0w/6Jfy74HUPv+UNo/7A7Z81/w==
X-Received: by 2002:a17:903:2489:b0:187:3a59:570a with SMTP id p9-20020a170903248900b001873a59570amr7400563plw.35.1667393774787;
        Wed, 02 Nov 2022 05:56:14 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.48])
        by smtp.gmail.com with ESMTPSA id x5-20020a17090a788500b0020ad53b5883sm1428129pjk.14.2022.11.02.05.56.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Nov 2022 05:56:14 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        gitster@pobox.com, me@ttaylorr.com, tenglong.tl@alibaba-inc.com,
        peff@peff.net
Subject: [PATCH v2 0/1] pack-bitmap.c: avoid exposing absolute paths
Date:   Wed,  2 Nov 2022 20:56:04 +0800
Message-Id: <cover.1667393419.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.37.2.1.g87a494e5ac0
In-Reply-To: <20220826070912.70274-1-dyroneteng@gmail.com>
References: <20220826070912.70274-1-dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

Diff since the first patch:

     * remove the "ignore extra bitmap file" warning
     * add "ignore extra bitmap file" in trace2 debugging output
     * modify case "t5310"

Thanks.

Teng Long (1):
  pack-bitmap.c: avoid exposing absolute paths

 pack-bitmap.c           | 12 ++++++++----
 t/t5310-pack-bitmaps.sh | 11 ++++++++---
 2 files changed, 16 insertions(+), 7 deletions(-)

Range-diff against v1:
1:  1591e7ee52e < -:  ----------- pack-bitmap.c: avoid exposing absolute paths
-:  ----------- > 1:  87a494e5ac0 pack-bitmap.c: avoid exposing absolute paths
-- 
2.37.2.1.g87a494e5ac0

