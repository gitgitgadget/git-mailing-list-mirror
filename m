Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C82C4708F
	for <git@archiver.kernel.org>; Mon, 31 May 2021 07:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 020286100A
	for <git@archiver.kernel.org>; Mon, 31 May 2021 07:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbhEaHOc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 03:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbhEaHOa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 03:14:30 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B032CC061574
        for <git@vger.kernel.org>; Mon, 31 May 2021 00:12:49 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id l2so2339126wrw.6
        for <git@vger.kernel.org>; Mon, 31 May 2021 00:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=G6wQspYp2kSNGl1kvtRUzE9ILPvaicOqAgyBAe6LwrA=;
        b=JipWkxA6In1FAz2D1G0/ihtgK9iS9EojuLBZKIClP61AIcO5YEq4h5XMt6CU5vQm8y
         he/5bwePtLtYik7bGElX6G0+eCb9RoQzYzb/Kxp62SI/fRKMjq1ohJBJMc6Aq1N5/q1T
         oZxHBiU4n/7E0xI75/NDDK2NQGpPa8JyMaskP9bkOp7xK1gdLpQKd4/0v8pSDt/82qeu
         MWd0W2WcnVvod8l6YOVbBicgrHUc47twUYnUJWk+QGOQ6WWEpfsFp+qzYdRsZKVPmf38
         mk7+WLkgcJRNIug8xZTWkuXgsBz6sO8aj0gFLMxXlWfBZari1Z3RO5xaqCHTSsKy6IW7
         gCqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G6wQspYp2kSNGl1kvtRUzE9ILPvaicOqAgyBAe6LwrA=;
        b=QUbcEyJiZ8XEPaOvjMSZPzlDACJEJTS/3UfH8F83aje19zb7sNdewjbIzGpzKRbXyG
         w+sFbla/s8xS1PGRAZpWs1y7j0osTAoJ1wEreUmCNCCRD69biig8uiHjbMi/1bPy6rxl
         9acEeprGKB1VTKKVAIWyhWqMuCkk3Hfs3Wt/VIZZz5d8WynlGQFpdN/SR8hk92gScAMD
         kywd4WuP95ILJjn98yADCKzvLX+qyv0qBHKcLcNJDOF+IWOu20KS1eYmJQ0LFUqDuBlN
         CS3SloQeADQJvNEerBnlnu2Q+KvDodFTycMAevVukhLcjLiX2AhTean00W/VnUnyGA5O
         w8mw==
X-Gm-Message-State: AOAM5330gEZoGT/S3T3sqt+vZRBNf16yoAjRKxIKk6FLmyMDMN3mknhs
        ZWuwWvfjqg1qHh99S8GlH9k=
X-Google-Smtp-Source: ABdhPJw+OxPXWeoVKSMbZUPWCQMYsmdhmf95Cmk12nGvd/Vm4JWZRXNrskVvQqihZZ1+z6TzSI4xQg==
X-Received: by 2002:a05:6000:186a:: with SMTP id d10mr21114020wri.41.1622445168351;
        Mon, 31 May 2021 00:12:48 -0700 (PDT)
Received: from ?IPv6:2a02:8388:e002:8cf0:25d1:fff3:8887:500f? (2a02-8388-e002-8cf0-25d1-fff3-8887-500f.cable.dynamic.v6.surfer.at. [2a02:8388:e002:8cf0:25d1:fff3:8887:500f])
        by smtp.googlemail.com with ESMTPSA id s7sm21548457wmh.35.2021.05.31.00.12.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 May 2021 00:12:47 -0700 (PDT)
Subject: Re: [PATCH v2 6/6] doc: push: explain default=simple correctly
To:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ramkumar Ramachandra <r@artagnon.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Junio C Hamano <gitster@pobox.com>
References: <20210529071115.1908310-1-felipe.contreras@gmail.com>
 <20210529071115.1908310-7-felipe.contreras@gmail.com>
 <acfafe6e-b0f3-ba2e-71f0-9bcc09b9d612@gmail.com>
 <60b3e2ceee840_ee4c20823@natae.notmuch>
From:   Mathias Kunter <mathiaskunter@gmail.com>
Message-ID: <3e5c2303-030e-928e-af57-8e2be8f3ce86@gmail.com>
Date:   Mon, 31 May 2021 09:12:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <60b3e2ceee840_ee4c20823@natae.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-AT
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 30.05.21 um 21:09 schrieb Felipe Contreras:
>>> The current branch is pushed to the corresponding upstream branch, but
>>> as a safety measure, the push is aborted if the upstream branch does not
>>> have the same name as the local one.
> 
> Except that isn't accurate.
> 
>    git clone $url
>    git checkout -b fix-1
>    # do commits
>    git push
> 
> Does that push the current branch to the corresponding upstream branch?

I see. Then maybe reword to something like this:

> The current branch is pushed to a branch with the same name on the
> remote, but as a safety measure, the push is aborted if a corresponding
> upstream branch does not have the same name as the local one.

In your above example, I'm in centralized workflow, but I can still push 
the fix-1 branch to origin without having to configure an upstream 
branch for it. So this seems to contradict with the currently proposed 
wording:

> If you are working on a centralized workflow, then you need to configure
> an upstream branch with the same name.
