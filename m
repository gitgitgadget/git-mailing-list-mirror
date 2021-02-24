Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC46C433E0
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 17:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBCDD64F0C
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 17:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234131AbhBXRv1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 12:51:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234161AbhBXRvX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 12:51:23 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB17C0617AA
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 09:50:17 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id l132so1773128qke.7
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 09:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ptljn3dI3It7PUs5XPBoG9WdS/stnUZ+L6tOeon3kaI=;
        b=VawzUFyBMLL1vVraYMvpuN29ovuoLFgcIZBe3rOHcCz2aqG/fBQlJlXlMgNZt/ic8S
         IVfib0rf4KSyWItGkMIxHrLnq5Zh60o2Xf68AMyYXXTnXBpILvnMjuXDibClNlZzPOEv
         xoirbKkz3mV8Bxdc0eMqUZbeR4IePhOPccAmnY99SomdHcK7lQYyxepq1pe+AI0K23+/
         HRnmcLWxP++/SNtmIkqWuMEHjk+I57pplDC5sJVCRMCb6XnWka3VFhMOK0Tdw6Ix+M6M
         nBR1P7m0k7EAGxALIi3whQCg1ufI6ZueD+3StcC9zpVBu53Pe1U9ohy96FU0Hr9emCbX
         dTTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ptljn3dI3It7PUs5XPBoG9WdS/stnUZ+L6tOeon3kaI=;
        b=pUP/b11M3poD+njKviL3OVSyUzFg9Y8q4fWh4e62XdyBIhNSquSJ+i45CRo3R474GR
         oHhUr6fO2+zIBn7O2EJza7QyP37m1uxe/hzjswtb9C/ZMdLEB94mAupTS8AO98PmbLyR
         jmmaNOxzvNfcoRDJSO8igYuSC5aKeisqHBvHH91RD+AD3v1GLbeULkhUC6TZZxvsXsSC
         PQdiV8eHhua+f+njN92lHn8Wklhs+cfB23yofPfirqxUG07CtR10TOXPt7B/amzgs/JH
         Zb8+p5yTJdELm0Rjc8HMcye2AVIOFfXkwv7T6/qke7v55yv7Y6ye6D2Rv1qh+kOdarPo
         plbg==
X-Gm-Message-State: AOAM5306CDzJXvmgmTAbgFkjXXIqJxkfnXE1ji04wIFNWF8YVedvLHBK
        DIpoZL/imIIkJ3WSG2zAmIg0c9khJk+KNw==
X-Google-Smtp-Source: ABdhPJwM2BiQItM05NGONTlGYAE+sxqUxODw96gqDOT4kLqiCITtZ9qqDiZDSkoxs0wvBzhgUi55Lw==
X-Received: by 2002:a05:620a:294a:: with SMTP id n10mr19679884qkp.496.1614189016785;
        Wed, 24 Feb 2021 09:50:16 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:d50a:c289:effe:68e4? ([2600:1700:e72:80a0:d50a:c289:effe:68e4])
        by smtp.gmail.com with UTF8SMTPSA id c63sm2092282qkf.8.2021.02.24.09.50.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Feb 2021 09:50:16 -0800 (PST)
Message-ID: <22419bc6-d35a-7537-d388-d51c24138f5f@gmail.com>
Date:   Wed, 24 Feb 2021 12:50:15 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Subject: Re: [PATCH v2 00/10] Optimization batch 8: use file basenames even
 more
Content-Language: en-US
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
References: <pull.844.git.1613289544.gitgitgadget@gmail.com>
 <pull.844.v2.git.1614123848.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <pull.844.v2.git.1614123848.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/23/2021 6:43 PM, Elijah Newren via GitGitGadget wrote:
> This series depends on en/diffcore-rename (a concatenation of what I was
> calling ort-perf-batch-6 and ort-perf-batch-7).
> 
> There are no changes since v1; it's just a resend a week and a half later to
> bump it so it isn't lost.

Thank you for re-sending. I intended to review it before but got redirected
and forgot to pick it up again.

> === Results ===
> 
> For the testcases mentioned in commit 557ac0350d ("merge-ort: begin
> performance work; instrument with trace2_region_* calls", 2020-10-28), the
> changes in just this series improves the performance as follows:
> 
>                      Before Series           After Series
> no-renames:       12.775 s ±  0.062 s    12.596 s ±  0.061 s
> mega-renames:    188.754 s ±  0.284 s   130.465 s ±  0.259 s
> just-one-mega:     5.599 s ±  0.019 s     3.958 s ±  0.010 s
> 
> 
> As a reminder, before any merge-ort/diffcore-rename performance work, the
> performance results we started with (as noted in the same commit message)
> were:
> 
> no-renames-am:      6.940 s ±  0.485 s
> no-renames:        18.912 s ±  0.174 s
> mega-renames:    5964.031 s ± 10.459 s
> just-one-mega:    149.583 s ±  0.751 s

These are good results.

I reviewed the patches and believe they do the optimizations claimed. I
only found some nits for comments and whitespace things.

You are very careful to create the necessary pieces and connect them
from the bottom-up. However, this leads to one big "now everything is
done" commit with performance improvements. It seems that there are
some smaller performance improvements that could be measured if the
logic was instead built from the top-down with stubs for the complicated
logic.

For example, the final patch links the rename logic with a call to
idx_possible_rename(). But, that could just as well always return -1
and the implementation would be correct. Then, it would be good to see
if the performance changes with that non-functional update. It would
also help me read the series in patch order and understand the context
of the methods a bit better before seeing their implementation.

This is _not_ a recommendation that you rewrite the series. Just food
for thought as we continue with similar enhancements in the future.

Thanks,
-Stolee
