Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A74C4332F
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 13:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbiKBNET (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 09:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbiKBNEN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 09:04:13 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33AF1A212
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 06:04:12 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id h193so7487414pgc.10
        for <git@vger.kernel.org>; Wed, 02 Nov 2022 06:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2j9px1wQ41kyz9OVWxojnNXcVo2n3oV1ncQ99TLIPnM=;
        b=HccjRY9PsGoudSo+Yx/bn/DIps8rbUDl/0mHwyFxz+GZ4i57tYqSPApt34Nbhf7yPl
         w7E6lN/qU8UA8qbu678Iwoh7pgiFRes3tk+QxHxX6GVFkTND+R/vVluhgUCnTtCH31/Q
         a7CQouYELx/3Y2tr8KJU9VnSPKHLm43o8w/1fWsWRoXuy8AV3mxmeU3Qyl7vN/vxneoH
         xcy8dSnfc50G5jyJn/Q//DbAYLQb+RQXnb+pUYbDJZRcbXLOkzy3nffvfukH+4dDJ3Z6
         WXkTtAm5nfbEbqVp1gSsjA/8IuLuVA5T2PTKdOWMNFLjpUzzS2VOEeoZzvtFyipPdUcL
         2E3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2j9px1wQ41kyz9OVWxojnNXcVo2n3oV1ncQ99TLIPnM=;
        b=sRcIaM+Z8I3H2vAv/iUmFobaPczSjXg1aiCYPGogD3Mu7weH26endqtEl3mAdYr7nj
         kJnLvOmbpydN7W/xSINoN/WqAMeYYW7MA1SxXwnXIDe/7+k/ku5zaQe8fQU9LOnNTm/e
         8UfpuvIWt27FAJXv8m9q4Ltie/+aluJBxiDGMQHVGJ91jdAvPNuMszxUq1dABN0JARYC
         LDMIhGG1e/gU93BXrtZEp8mC6PdbQBAAIP3lLAxY8bsr/dPxeXO4QmZWBi90X/eBwB+V
         8dPFIXKu6vvQIgzvX7yRNWtof668HiZ4uCzZMaE7+0T3g9sOeX1hKXeSl/AoHvnDnZCb
         Z64g==
X-Gm-Message-State: ACrzQf3lYUjWkbHpud/Rvrd/OSGwWMArZYNkEojdBZnaoG7s+lZd0sKz
        zD0jdpSO00/WHJo//Swabbw=
X-Google-Smtp-Source: AMsMyM5vgneF0SX4UxGnRyVyPW0Sf9owmlHZS/s7T3r4Lg5OkljCg0BnNzDfEKhlDZxczcFXNKp7LQ==
X-Received: by 2002:a63:2d8:0:b0:46e:9da4:df67 with SMTP id 207-20020a6302d8000000b0046e9da4df67mr21262955pgc.176.1667394252132;
        Wed, 02 Nov 2022 06:04:12 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.48])
        by smtp.gmail.com with ESMTPSA id c8-20020a631c08000000b0046ff6b380f8sm2614257pgc.68.2022.11.02.06.04.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Nov 2022 06:04:11 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     avarab@gmail.com
Cc:     derrickstolee@github.com, dyroneteng@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH 0/1] pack-bitmap.c: avoid exposing absolute paths
Date:   Wed,  2 Nov 2022 21:04:05 +0800
Message-Id: <20221102130405.91866-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.37.2.1.g87a494e5ac0
In-Reply-To: <221102.86tu3h3e1w.gmgdl@evledraar.gmail.com>
References: <221102.86tu3h3e1w.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Ævar Arnfjörð Bjarmason" <avarab@gmail.com> writes：

> I see that downthread of here there's discussion about keeping the
> warning, adding tracing, etc. etc.
>
> Maybe it's been brought up (I was skimming, sorry), but for the problem
> you have isn't a narrow and acceptable solution to you to keep the
> warning, but just don't print the absolute path?
>
> I.e.:
>
> 	warning: ignoring extra bitmap file: /Users/tenglong.tl/Downloads/alternate_repo.git/.git/objects/pack/pack-bff67e2a7a154e6933afe61b3681726cf9bd8e8b.pack
>
> To:
>
> 	warning: ignoring extra bitmap file: ../alternate_repo.git/.git/objects/pack/pack-bff67e2a7a154e6933afe61b3681726cf9bd8e8b.pack
>
> Or would the relative path to the alternate also be sensitive?
>
> We might also want to just remove this etc., but that's a different
> question than "should we print these absolute paths?".

Oops, sorry for that mistake, and I just sent the patch v2, and the trace2
output might like:

19:33:24.360684 common-main.c:49             | d0 | main                     | version      |     |           |           |              | 2.37.2.1.g520f5131b7c.dirty
19:33:24.360963 common-main.c:50             | d0 | main                     | start        |     |  0.001820 |           |              | /usr/local/bin/git rev-list --test-bitmap HEAD
19:33:24.361487 git.c:461                    | d0 | main                     | cmd_name     |     |           |           |              | rev-list (rev-list)
19:33:24.364617 pack-bitmap.c:435            | d0 | main                     | data         | r0  |  0.005497 |  0.005497 | bitmap       | opened bitmap file:pack-c9fe9d2dc5d002d4a4b622626ffa282bcbccb7ee.pack
19:33:24.365635 pack-bitmap.c:409            | d0 | main                     | data         | r0  |  0.006518 |  0.006518 | bitmap       | ignoring extra bitmap file:pack-3cea516b416961285fd8f519e12102b19bcf257e.pack
Bitmap v1 test (2 entries loaded)
Found bitmap for 2c5959955b5e6167181d08eeb30ee4099b4a4c5b. 64 bits / ca44d5df checksum
19:33:24.365970 progress.c:268               | d0 | main                     | region_enter | r0  |  0.006853 |           | progress     | label:Verifying bitmap entries
Verifying bitmap entries: 100% (6/6), done.
19:33:24.366479 progress.c:340               | d0 | main                     | data         | r0  |  0.007362 |  0.000509 | progress     | ..total_objects:6
19:33:24.366493 progress.c:346               | d0 | main                     | region_leave | r0  |  0.007377 |  0.000524 | progress     | label:Verifying bitmap entries
OK!
19:33:24.366558 wrapper.c:621                | d0 | main                     | data         | r0  |  0.007442 |  0.007442 | fsync        | fsync/writeout-only:0
19:33:24.366572 wrapper.c:622                | d0 | main                     | data         | r0  |  0.007456 |  0.007456 | fsync        | fsync/hardware-flush:0
19:33:24.366578 git.c:720                    | d0 | main                     | exit         |     |  0.007463 |           |              | code:0
19:33:24.366592 trace2/tr2_tgt_perf.c:215    | d0 | main                     | atexit       |     |  0.007476 |           |              | code:0

In short, the "related path" will not appear in output now but the "basename"
(packname) instead. I think maybe it will help the experts like Taylor who
often hacking the bitmap code.

Thanks.
