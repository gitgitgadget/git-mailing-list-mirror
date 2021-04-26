Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 545BCC433ED
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 20:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26AF5613AE
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 20:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241619AbhDZUZI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 16:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241079AbhDZUZH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 16:25:07 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2CAFC061574
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 13:24:25 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id l17so26332886oil.11
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 13:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Py17Op20Cb44UwXcGdpaEqYErXieuvbu9htxWPWooXI=;
        b=dwIgMS/3Bkh9kxn6n6EjAAgIjTcHHoAB8/Ueoxx5VTK5nz59K7K63BUub8MmhrBwoh
         XgOGZqC1nF655ZmEvF7PXsXsFlgY41KLFK3fHarHlHra6Zpht9mKR8KsNUbESBQQq++e
         XBixgZ98O8Hr/Ykz6aBrvdSkjdTlNesgx+jLCbs4I3F4V6gtgSc8GBt4KCCOOhZ/zQLw
         oD61/BOZtPtGeaL7SJydB9QD7M/VhxPjikuLSbrSbSjWDHuIzVRtgtMk4EvEOy/0tsI4
         80qDsc9hTSc+iwuRCyMqW3CgkevOq2ad/3a97ZoM+cJ1rczmki1c0ldzl11EjOiwIp02
         Fr+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Py17Op20Cb44UwXcGdpaEqYErXieuvbu9htxWPWooXI=;
        b=s0XPsBJMcEsnO/2Wdw24IP97psMN5RVRbKJtUDwAe+3eYZ/gQ2a8Dl6oLFw08e3864
         vDGskZxciQ0EiwqzY7t5VEc4jIBL4Tcv8XO3Xmkk8Hes/mllQPw6ZUH8b0EY/fMCxdzT
         wP58z190azhhqMpZ42X7bvqfR5J2aRWU5YNrNeHzqSe8uw3W8doo635ii4QgeFYi3aql
         iFzB5kI8LW8q1MAydfCe2woyH/AfO3BCCY/UYFOdE8kyDwUNoYRmLmLK3fcytw/5cAFc
         07tMFWolbF0rvJv+ORG8b0BQFIchK/fYrbi2PovMjZ35J2jJPOSb16diLi3q55sgUySX
         PEVw==
X-Gm-Message-State: AOAM530PmJc8wxUCiIdPqomVfWIMe5sr1+n7lLUMR9OfrHGW9b7+a2jO
        +xtFNp9MQtEuXMdVdKLoIVQ=
X-Google-Smtp-Source: ABdhPJx92yMfDsBinJgMPHcP/FQd4lnqmAHcr0Npsp+NMgoF/iKk+A6e9TuZqei0E8TRDl5OZw69NQ==
X-Received: by 2002:aca:3808:: with SMTP id f8mr625125oia.4.1619468665102;
        Mon, 26 Apr 2021 13:24:25 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:65f6:360e:4aa8:3d0f? ([2600:1700:e72:80a0:65f6:360e:4aa8:3d0f])
        by smtp.gmail.com with ESMTPSA id r20sm779225otd.70.2021.04.26.13.24.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Apr 2021 13:24:24 -0700 (PDT)
Subject: Re: [PATCH 10/23] fsmonitor--daemon: add pathname classification
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
 <451563314d84f9d6dee29a4899b5d18033aa227d.1617291666.git.gitgitgadget@gmail.com>
 <aca24c96-33ab-3b90-bf21-0da19283a3d7@gmail.com>
 <CAPig+cT1yz-M1MYTx1_HQRYe+Ryy=vzwtRgkhkX7bTYDB5rnkA@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <9a9d6da0-1a31-c04a-f41f-de20d85996b2@gmail.com>
Date:   Mon, 26 Apr 2021 16:24:23 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cT1yz-M1MYTx1_HQRYe+Ryy=vzwtRgkhkX7bTYDB5rnkA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/26/2021 4:11 PM, Eric Sunshine wrote:
> On Mon, Apr 26, 2021 at 3:17 PM Derrick Stolee <stolee@gmail.com> wrote:
>> On 4/1/2021 11:40 AM, Jeff Hostetler via GitGitGadget wrote:
>>> +#define FSMONITOR_COOKIE_PREFIX ".fsmonitor-daemon-"
>>> +
>>> +     if (!fspathncmp(rel, FSMONITOR_COOKIE_PREFIX,
>>> +                     strlen(FSMONITOR_COOKIE_PREFIX)))
>>
>> Seems like this strlen() could be abstracted out. Is it
>> something the compiler can compute and set for us? Or,
>> should we create a macro for this constant?
> 
> If you're asking whether the compiler will resolve strlen("literal
> string") to an integer constant at compile time rather than computing
> the length at runtime, then the answer is that on this project we
> presume that the compiler is smart enough to do that.

That is what I was asking.

> Or are you asking for a function something like this?
> 
>     fspathhasprefix(rel, FSMONITOR_COOKIE_PREFIX)

The "fix" I would recommend otherwise would be

	if (!fspathncmp(rel, FSMONITOR_COOKIE_PREFIX,
			FSMONITOR_COOKIE_PREFIX_LEN))

which is much uglier. I'm glad we can trust the compiler to
be smart enough.

Thanks,
-Stolee
