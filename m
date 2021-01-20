Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1980C433E0
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 20:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8820423441
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 20:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392824AbhATUHd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 15:07:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390054AbhATOGm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 09:06:42 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3744BC061757
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 06:06:02 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id r9so16283177qtp.11
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 06:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=19MG0mxacToFzdC47Wu+kdVbgOpq6x0MP8ggYOPgcew=;
        b=Ewp+4w2dJ+MM98V/p+B5XCkFXcU4a215+n4yG50Il6dHEFL8vkU3lOqeaj8TWcfQu9
         U9LwIER910n3dtyg7+20rCQ95DEyFi2zJdtzC1/66kW6Y2fH4oqWSGItJ5bE9dg5jyX0
         8w68iX2h3cG73cjECEcnCjxGrBOTdCdXv+PerMFzcXULIIEwwj06BVW/MOIM4FYHMphz
         ER78lAF5pNMeZMEmR/WdB1CsPbGrnJ4gH402j99zzG60tSGIothg5Uq2d7p1DTnQSW8t
         /7pkom4g3GrsLLYY21oKTrGEFoHallPB7cMewfc2IY8O33rr/+N/D09toqjRdkNqLHf3
         gCvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=19MG0mxacToFzdC47Wu+kdVbgOpq6x0MP8ggYOPgcew=;
        b=PhkcTlaptdsywaS2eFE2mJP6Mk7MauaBvVPLM56lPbvuXlN0Zvh4rjvbHRGVz7Jg7i
         88rZyslqDGTv74i+kJv4phYSraTHAJEI0c80S1k402dzb7PXuQRRG+9t8cnNB8k9ScdX
         svOYzkyss2GVlPLnMASi2J6QVWJt++Op551lf5vV0ZsOJt+58JMRjYOxlYwuZHUDOnap
         /I8q1tdBcMsz72Qg9V++GPfhds/i6XIEdQ3+d7K4Jm1ARg9yV4GX81mtbxDF7uag1giX
         TYvbMdCfrlkp8uC/j2KniT6n4nzGBl/6xDp77oKR8k0+skuz98uFwDWNkHyKTc+hJF7V
         wMNg==
X-Gm-Message-State: AOAM5332FwhIiYPRiM+59282aKVsymBAy5lrfJr0GvcQ8L/ecgX9IT9T
        +03MUGYOXnnxSEN60LvfoK0=
X-Google-Smtp-Source: ABdhPJxou44FsigwcPeq8OihdloM8rWHUdMtk2eNjH4cjbUHJzum3iAIZcfOQOGqSYFVl+rm8HREwg==
X-Received: by 2002:ac8:7257:: with SMTP id l23mr8828490qtp.264.1611151561277;
        Wed, 20 Jan 2021 06:06:01 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:710c:cecb:a7d:75ab? ([2600:1700:e72:80a0:710c:cecb:a7d:75ab])
        by smtp.gmail.com with UTF8SMTPSA id u1sm1196222qth.19.2021.01.20.06.05.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 06:06:00 -0800 (PST)
Subject: Re: [PATCH 00/10] repack: support repacking into a geometric sequence
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com
References: <cover.1611098616.git.me@ttaylorr.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f477fd3d-1725-9792-7907-780afe91e37b@gmail.com>
Date:   Wed, 20 Jan 2021 09:05:59 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <cover.1611098616.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/19/2021 6:23 PM, Taylor Blau wrote:
> This series introduces a new mode of 'git repack' where (instead of packing just
> loose objects or packing everything together into one pack), the set of packs
> left forms a geometric progression by object count.
...
> Thanks in advance for your review.

I had the pleasure of reading an early version of this series, but it's
been a while. Upon a fresh reading, I only had nitpicks. Otherwise, this
LGTM.

I encourage other reviewers to read patch 10 carefully, as that is the
most math-heavy of all of them.

Thanks,
-Stolee
