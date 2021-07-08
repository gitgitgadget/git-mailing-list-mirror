Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4A3C07E96
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 12:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC8366140F
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 12:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbhGHMmI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Jul 2021 08:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbhGHMmI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jul 2021 08:42:08 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7086C061574
        for <git@vger.kernel.org>; Thu,  8 Jul 2021 05:39:26 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id kk10so2705195qvb.5
        for <git@vger.kernel.org>; Thu, 08 Jul 2021 05:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7aTwVt+zRnkWVnHXY2uo9UBMiaxQzDV3Umdbks1ttOs=;
        b=pBs8Y/ai+TXTY9UPe6+TwzRep2/5ej9yMQmRJSTFcHOFyOp7dZimhVnynRv8JoDiPj
         8SOSX8ul30UBwOL6T4fs2YM6+LqtJlwjtWhB6lIQSLI9ptNNG5zsNVoIsmY/0YJfBevv
         eyt6wShXxrunmRvUbEOwlJMbjbo15rqAkBMQb+VSj5RMVjcIxBVGNoHr1VxQXVv8mGyD
         +pjDldYKX3x+gVGWLFyDBwFR3KJmAa+nFFSAKOOzcTMenP5DF7maRAbZxMsLV3gCTqyf
         4yGsSIOphBHE4kfNmERTGIKlMFlksDfVALNVfibT37EwC4P5Q0tnBt1Cx4cxXQhRFveZ
         eDnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7aTwVt+zRnkWVnHXY2uo9UBMiaxQzDV3Umdbks1ttOs=;
        b=hGCUWIGGLYBn03C2zj1CzSd9AH+ORSomz4qpF7qzJZ/BRcCfeU7SoA43jaeA69nH9c
         gVrJFyIubGMx2zfAcv7IEogL7oVwF1V7ycWZzS9kMx5WAn32MffB8V+Qft/Vv4LNCBdn
         kW+u3BAy3JWtrU9BH0jQUtwE6tC+W6a76fkr1cN6vHu1933RGBDKfZ2hLYDeI9yRDG7B
         iYfPzo8gMXFacAqIze9ISCUujEVT7CjgHSOXLYINqze1pwyBXW4UhoOVWPfvodon5yI1
         GEM0Ry33ibFkgs24Zl/mwP6FZVwQOuPlXKmdpi+FMlrDesCIShhkSmlqIBRBfq5K4nSH
         o9GA==
X-Gm-Message-State: AOAM533UI0nLSu4jEZ+n578u00SVix2uVNMKw++xs/cZo39HulcoIywJ
        9uu0LQAg0Qx7GAIz1Gd14uE=
X-Google-Smtp-Source: ABdhPJzGVGAxwI9pOkDLHbd90F++pT+dcCTggjOSKgslotno6yQ+sK0XwHsUA1sn7l7X4XN1uXCNTw==
X-Received: by 2002:a05:6214:c49:: with SMTP id r9mr9299558qvj.10.1625747965566;
        Thu, 08 Jul 2021 05:39:25 -0700 (PDT)
Received: from Derricks-MBP.attlocal.net ([2600:1700:e72:80a0:484d:4d55:499:3d7c])
        by smtp.gmail.com with ESMTPSA id v16sm881318qta.47.2021.07.08.05.39.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jul 2021 05:39:24 -0700 (PDT)
Subject: Re: What's cooking in git.git (Jul 2021, #01; Tue, 6)
To:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
References: <xmqqim1mgbty.fsf@gitster.g>
 <CABPp-BGt0E4nLtU6Ocn0dUwOUUwDkz-90KKUpSLK9ctU9tQXmA@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <8756d446-b191-ac7e-9eff-5c0ea040e582@gmail.com>
Date:   Thu, 8 Jul 2021 08:39:24 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BGt0E4nLtU6Ocn0dUwOUUwDkz-90KKUpSLK9ctU9tQXmA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/6/21 9:46 PM, Elijah Newren wrote:
> On Tue, Jul 6, 2021 at 6:20 PM Junio C Hamano <gitster@pobox.com> wrote:
> 
>> * ds/commit-and-checkout-with-sparse-index (2021-06-28) 5 commits
...> 
> This was submitted at the same time as the latest round of
> ds/status-with-sparse-index.  Last week was a bit busy for me.  I'd
> like to complete reviewing the latest round from the other series,
> then I'll review this one.  So I'll have some comments soon-ish (by
> end of week).
> 
>> * ds/status-with-sparse-index (2021-06-28) 16 commits
...
> 
> Sorry for the delay.  I reviewed about half of the latest round last
> week, and it appears all my feedback from earlier rounds was addressed
> from what I've seen so far.  I suspect this series is now good to go
> and I'd like to stick my Reviewed-by on it before it goes to next, but
> I need to complete my review first.   I should be able to complete it
> by end of week.

I appreciate your attention to these contributions. I have also
had a significant lack of time the past few weeks and hopefully
will be able to spend more time on-list starting the 19th.

-Stolee
