Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC74FC07E99
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 11:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96EA9611AE
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 11:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbhGIMCd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Jul 2021 08:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbhGIMCc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jul 2021 08:02:32 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701AFC0613DD
        for <git@vger.kernel.org>; Fri,  9 Jul 2021 04:59:49 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id i11so471869qvv.12
        for <git@vger.kernel.org>; Fri, 09 Jul 2021 04:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=sDiaN/Weqtf3H3V+wfdamHCMDHY72EtcRqK+rm+3KXY=;
        b=md7bkYjIhMk0JWXjDkvMya8GU596GWIQRxoRSRHTXmOLib2I9r1BlYQEjQfUN1mj6X
         2ql3slDhEo2Slskzz91zPOnTTxwjQ1ZEFBsjS9lLJMrc73GUYzraEFwegkX8D3TK+FTz
         2Uy06nzRlp28WhO6JkVypcxFQSJ7rLMzRgIXX0CNyXZIhujWlmeMucleKnKtjy3ehj3M
         zRpAuRhFYWuBmC8X4P7LoJFi9Qek7cOiuQfLSgJRVaHvGaObS2ynVeErfbeJVI0UYNjA
         38WKsNzOCPkhPQv0ynVxlBXkawE0sYiCUQ4YIapTlhKq9oMRbbDPFZHUO6040rEhN71m
         xJSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=sDiaN/Weqtf3H3V+wfdamHCMDHY72EtcRqK+rm+3KXY=;
        b=ZjLktLQwjrdnsQMnb3kzMNxPv0zfkO9U+1Bd+xJxXAMVJ9MMeyCMzfFY4mjLkj6FiB
         7U+OD/CmU9I9XL1y4GS30qgRB47NPm+x/hO7NnuMNfXkmwbcchsOfvKAwPRGbNzM7Hic
         C/RbokDPZT4x+v6Bhb5TZuG4hdPLHbOp3GKrpOXhmWNf3rglQYDCeBcEgk3H983SY2d7
         8CVtKKt5M7odGHSKMd8apiWKnBlhFM7h06DcLrCD/hYlUwy2q6fjHtTvAbcbOW5C0Abw
         hph/T0PtEeeuPRUv9UCfStWOzNgxGSZCj1kkqUtBInx5NFELA1Xktppu/4eA/zYxj2Qp
         lEtA==
X-Gm-Message-State: AOAM5331O8qt+gAj5qsjOZfbCyjPh6HnO2v25wbtVlMQ2sjUawDEGUxR
        U2CQVsFGF4YxeLh4r58dQv4q0+ynCj4=
X-Google-Smtp-Source: ABdhPJwMYd9HdflZg2EmgeR3SA31SwkTd2K0Pqd0/PV47/BnAqBO0wlTFRCUo5/zH05C0kgYO0fLIw==
X-Received: by 2002:ad4:5aab:: with SMTP id u11mr2201461qvg.49.1625831988563;
        Fri, 09 Jul 2021 04:59:48 -0700 (PDT)
Received: from ?IPv6:2601:147:8500:eef0:b128:de99:792f:fe53? ([2601:147:8500:eef0:b128:de99:792f:fe53])
        by smtp.gmail.com with ESMTPSA id n191sm2423088qke.10.2021.07.09.04.59.47
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jul 2021 04:59:48 -0700 (PDT)
To:     git@vger.kernel.org
From:   Baptiste Chocot <baptiste.chocot@gmail.com>
Subject: Troubles redirecting git output
Message-ID: <57ebeb1d-f467-6cbd-5ad9-a55cf04dde34@gmail.com>
Date:   Fri, 9 Jul 2021 07:59:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello guys, hope you're doing great.

I'm reaching out today because I cannot find a fix for my issue. I'm 
using git 2.25.1 from the debian repo. I'm having difficulties to 
redirect git stderr, here is an example:

---
$ git init
Initialized empty lol/.git/
$ git branch >&2 2>/dev/null
fatal: your current branch 'master' does not have any commits yet
---

Is this an expected behavior? I find it weird not to be able to silent 
git. Are you aware of a workaround? I've been browsing a bit but did not 
find an answer yet.

Thanks for your time!

Baptiste

