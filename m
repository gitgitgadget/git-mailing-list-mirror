Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CC6C43603
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 02:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B75C3218AC
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 02:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EOLBdgyK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfLSCWl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Dec 2019 21:22:41 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:42851 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfLSCWl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Dec 2019 21:22:41 -0500
Received: by mail-yb1-f196.google.com with SMTP id z10so1630324ybr.9
        for <git@vger.kernel.org>; Wed, 18 Dec 2019 18:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SK4t2rn08YoyVt3O5iEoU+Jp2n6shXqjQt1Ci9Cpqbo=;
        b=EOLBdgyK5WduL9RelbUeL9kcJZulBhoPXjiXzWp5/EqPf51N+NOnWMHzZvswpGnlD4
         dW12SEmmi59U6Z4m2fMwCf9DlskdgStFWFEZdTI0daR3gOjYMJ4jyp8oDHvwcTtUdzQG
         LtQ8ZHkwATORE+dDVc4PQ2v0yM/fIH1/Oy4jF06qV29lq2/K2xrtrOmrIIASpYbXba3Q
         cGBJO5Ripa6TV+EvEptNDCyfY+Ne2VFIb/76oGkpi7KYZtaDs0MYgtog7guTfBCbMNca
         CU9wS7ynkLO0M8Suq2AebXfRBnWx3zfR560j0Y4fxpr+vPL8Ai0shFE8yTnBeBDMVQr0
         ql5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SK4t2rn08YoyVt3O5iEoU+Jp2n6shXqjQt1Ci9Cpqbo=;
        b=Z5rBGkfNy5bBMEL6tWG9M+H29k/XOgVsXo86e0kelyRYYui5O2yJjR4Cta8RBdZUgC
         3XZgvmHuxMaYjLlostY0GXITLlCOLUKLJm+6tjjIpEkUbaWlmCxOfslOKja2jZdSWGjr
         vglvFmxjn6AesZm/UCyUrJ+cTSfCHH2G5p028wak48atLvKH3oG5ZcrhOH4jbXPsmjB4
         0mffhZq6ggKWBCl/9is5caO3DEiwRwCCQW5drqrVXQ0geEb6d+h9PAZILL1xfxDXeJev
         Y43SYxEzupt18lcVtz9jnwok/IK/KEBK3mM9N21tE7uyateSN38arJORNqhFhwKKBlYi
         ycOA==
X-Gm-Message-State: APjAAAWVddKNraGvXOhNax7zGhwe7auhsyyWpjIctS7WQw+i0f3Dd1TB
        rqj41XZMBJ9l8e49BsFYDko=
X-Google-Smtp-Source: APXvYqxefMmfcGQYoKrjXIotFZdO6ubo6eGh0ujDQTsg8K+zI8f9+L8E9djhe1dIYzzXQXia9GB8/g==
X-Received: by 2002:a25:5c4:: with SMTP id 187mr4164997ybf.199.1576722160238;
        Wed, 18 Dec 2019 18:22:40 -0800 (PST)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id y9sm1783826ywc.19.2019.12.18.18.22.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2019 18:22:39 -0800 (PST)
Subject: Re: [PATCH] sparse-checkout: improve OS ls compatibility
To:     Ed Maste <emaste@freebsd.org>
Cc:     git mailing list <git@vger.kernel.org>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
References: <20191219015833.49314-1-emaste@FreeBSD.org>
 <46d9f9dd-b278-bade-af48-3a3bd2e4aa5e@gmail.com>
 <CAPyFy2BROa9iMWBWf1hioYDaoEXPvyUNGHOZaZiD0TzVVhEtoA@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <2653429f-46ac-c67d-cb08-8cc8695d77ae@gmail.com>
Date:   Wed, 18 Dec 2019 21:22:39 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <CAPyFy2BROa9iMWBWf1hioYDaoEXPvyUNGHOZaZiD0TzVVhEtoA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/18/2019 9:18 PM, Ed Maste wrote:
> On Wed, 18 Dec 2019 at 21:07, Derrick Stolee <stolee@gmail.com> wrote:
>>
>> On 12/18/2019 8:58 PM, Ed Maste wrote:
>>
>> Thanks for the report!
>>
>> It was a little unclear from the get-go what exactly the issue is.
>>
>>> On FreeBSD, when executed by root ls enables the '-A' option:
>>>
>>>   -A  Include directory entries whose names begin with a dot (`.')
>>>       except for . and ...  Automatically set for the super-user unless
>>>       -I is specified.
>>
>> It appears that the "ls" commands in the sparse-checkout tests are
>> reporting the ".git" directory when executed on FreeBSD as root. Is this
>> only as root?
> 
> Yes, this is only as root - it seems Cirrus-CI invokes the build and
> test scripts as root, which is why I had trouble reproducing it
> locally.
> 
>>> Pipe ls's output to grep -v .git to remove the undesired entry.  Also
>>> pass the -1 option to ensure one entry per line.
>>
>> What if we instead ran "ls -a" and added .git to our expected output
>> (when appropriate)? Would that be simpler (and reduce the process
>> count that this solution introduces).
> 
> I originally tried that approach and thought it was a bit cumbersome,
> but avoiding additional process invocations is a good argument. I'll
> send a v2 with that change instead.

I guess you are right that having "." and ".." appear is a bit silly.
Perhaps your approach is cleaner, and the extra processes are not too
much of a cost.

Let's hold off on the v2 for a bit in case someone has a better idea.

Thanks,
-Stolee
