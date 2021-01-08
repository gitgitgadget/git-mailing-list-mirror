Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F22C433E0
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 20:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A707623A80
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 20:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729061AbhAHUwQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 15:52:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728222AbhAHUwP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 15:52:15 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337E1C061380
        for <git@vger.kernel.org>; Fri,  8 Jan 2021 12:51:35 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id 9so12829205oiq.3
        for <git@vger.kernel.org>; Fri, 08 Jan 2021 12:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qNvEI0tJ0zWJQx0WsRHwONvn/99wSDQoT5RlcI1qHcg=;
        b=GKTl6LrMvxmbGCsVoUkAbs3IFBAliV75tAK1x98FaBNM7wajtAJAk5zpynnHBtymYr
         Web8Eut7Hfw7nZOWnEZ750EI2cM9ubrqEUdx9TDjMlx/myonj6IqAYxJAf6HrJTCUFpV
         GaB1nCt0j3+krqERnarC6cejB/mqVxxm5eyMM9ZtDvgT/jHWwm6eU5fwfrB4T2Jv6nmm
         Gu5bFpIjtmwwdLYQ6KntaCQwkv2n8BikqWqct6AqN09HukcTmiM8Egz1ZNZDtwzTlEYu
         igOMzJouE39XAeMKblDSz/5Tdjbhjh99jZYwutkCzw1vL5OfwcDey3QWoSOHGrNNe7pB
         zZVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qNvEI0tJ0zWJQx0WsRHwONvn/99wSDQoT5RlcI1qHcg=;
        b=d6bC0DloY4mmKT9NounSLJaOnDZ5edxaizw8LcUrVnhMct1Nuxj6q5rWigqmgfwBUN
         ZFaRqkjB8QyXp4UUgpb09Hp/CKc7svrVC/ExTI1LDhW/qbwNR1dD3aw8Cu/q3YD50yus
         PJAv4iM594tDRbzCiBjICKlMVpkqpUEktmSlX7OFW/jIA87rnCo0KOS51o+/n9U3MayY
         tI/DkJqhYLp8iDBSucpDTLl7u8tGsQkUMLLwwTAfJn0kKPqhyl+2PxkSaxlnV149tzrA
         XBFSegkAsLSoIs07UdD7L8dhhpfiXK14v/Xc+y8Ay30wVNuZXkOl+MhoNIqDsxHD7kH7
         qvrQ==
X-Gm-Message-State: AOAM531Ea58aCIT21tFkFV/oRXbNml4wV9bxZ31eUaogBrxHVCmageJ7
        niK8AcN/VquT3Gnj3rD+TXpOw+ZMpfc=
X-Google-Smtp-Source: ABdhPJygybIL6BqGOSVXcY8hTx8C+Bj8b/HI2huPdPYRBGC4ajlUfJs8/olwvcki4h2P60rK2mBONA==
X-Received: by 2002:a54:4899:: with SMTP id r25mr3403493oic.28.1610139094303;
        Fri, 08 Jan 2021 12:51:34 -0800 (PST)
Received: from tiger.attlocal.net ([2600:1700:bae0:2de0::26])
        by smtp.gmail.com with ESMTPSA id j10sm2018817otn.63.2021.01.08.12.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 12:51:33 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>
Subject: [PATCH 0/1] And so it begins...merge/rename performance work
Date:   Fri,  8 Jan 2021 12:51:10 -0800
Message-Id: <20210108205111.2197944-1-newren@gmail.com>
X-Mailer: git-send-email 2.29.2.542.g6f8bc064c5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This depends on a merge of en/ort-conflict-handling, en/diffcore-rename,
and en/ort-directory-rename.

This series begins the performance work for merge-ort and
diffcore-rename.  This series only has one patch and all it does is add
trace2_region enter/leave pairs -- but it comes with a lengthy commit
message detailing my driving testcases, the current status, and my
plans.  Part of the point of the lengthy testcase description is it will
allow me to repeatedly refer to it in subsequent series' commit messages
with a paragraph of the form:

    For the testcases mentioned in commit 9542932eee ("merge-ort: begin
    performance work; instrument with trace2_region_* calls", 2020-10-28),
    this change improves the performance as follows:
    
                                  Before                  After
          no-renames:       12.975 s ±  0.037 s    12.904 s ±  0.069 s
          mega-renames:   5154.338 s ± 19.139 s  1670.582 s ±  0.904 s
          just-one-mega:   146.703 s ±  0.852 s    48.149 s ±  0.306 s


Elijah Newren (1):
  merge-ort: begin performance work; instrument with trace2_region_*
    calls

 diffcore-rename.c |  8 +++++++
 merge-ort.c       | 57 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

-- 
2.29.1.107.g69489f3566

