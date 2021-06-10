Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F1AEC48BDF
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 18:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48750613FE
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 18:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbhFJScE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 14:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbhFJScD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 14:32:03 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89765C061574
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 11:30:06 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id im10so14361548qvb.3
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 11:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OnZ0LwZ6eGXLlWzB/Ok9/0xfIMmeIb0N9chqxUyF6Lw=;
        b=k3I95Uh2hKue3c9dvzb9ggNYToKk4yesT5b9lUdMxif53c2UkMwidraiPSjbOUXOee
         K5tyDmjv2u1lBhfpzsppsMRk46IIKIvXM5Mk3k8+lUL/DKM7nieo4oZjXHbvqtqR78QW
         zWI9BlfcUzggEi2g3njylJiS01hmweByR/6noNo5ZpUmqwGv0IC+gixpQkNS23PmD+AP
         VEiL0xBaMKxJ51cl0Yiu8vahI7PojYSnExSw3szvT/VMLKlCT2UTNd8SDyLXGlgNZ+iK
         3YsNcFk8w9GgehJ/QQqJvjFI+2iPDo3A7N02XLXZ2JkloSqmcz2hB+HJxkrL+JiQxHYg
         kKEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OnZ0LwZ6eGXLlWzB/Ok9/0xfIMmeIb0N9chqxUyF6Lw=;
        b=BbrmV4/euVH5kQ0AN1z6VjS2hACgxe01zLkIfrbp4v9xVquGI1vJ8A+jxSo8pnIhFY
         7HYpG/7DFbpUHteMoIX+tClXK2DNRMNaX76M2wNbiardCm+duNYmBH+76O46ixxPtlo0
         6j6a8/7leBD9MJ8H9W7rBX5ZckXOyAyYWZBpneo1xoz4L2nAPSIwo7TzlcYosXTQKkbr
         kxfmIUd2v+HheYn2Bv8q7cmVPD9G3UmRYfCAlai4IidlZ7GSjH4PKW2SjwC3akolnTw4
         RVvtQF+/94U2e76tA6btEtq4FbS2fz2058MSHVxAYlieFybf8YRSSZXeInyeqP1oko4E
         9gZg==
X-Gm-Message-State: AOAM532A2knUmrvhTdams63hkNXg3rQRo8MkvYGP/Kp3I5NPNLGhqe60
        4aFv6it7xty22k/Ci6uLKRQ=
X-Google-Smtp-Source: ABdhPJxI6LX/RUTKOSql+q5XCyHD1ZztQzmwyZ9p/+et8yheD1803REoiXmj/Tlf11KhrA4/+6W2MQ==
X-Received: by 2002:a05:6214:ccb:: with SMTP id 11mr970882qvx.43.1623349805638;
        Thu, 10 Jun 2021 11:30:05 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:8dd3:e726:fe78:a0d9? ([2600:1700:e72:80a0:8dd3:e726:fe78:a0d9])
        by smtp.gmail.com with ESMTPSA id f9sm2882280qkl.46.2021.06.10.11.30.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 11:30:05 -0700 (PDT)
Subject: Re: [PATCH 1/4] Documentation: use singular they when appropriate
To:     Phillip Susi <phill@thesusis.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com,
        sandals@crustytoothpaste.net, jrnieder@gmail.com,
        emilyshaffer@google.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>
 <afc51c5e6edec7935a6d0d0a05d396e11311ca6c.1623085069.git.gitgitgadget@gmail.com>
 <60be91757c6ca_db80d2086e@natae.notmuch> <87czsu98ar.fsf@vps.thesusis.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <790688e5-6816-9837-85e7-2fdbbdf24169@gmail.com>
Date:   Thu, 10 Jun 2021 14:30:04 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87czsu98ar.fsf@vps.thesusis.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/9/2021 2:47 PM, Phillip Susi wrote:
> 
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
>> Derrick Stolee via GitGitGadget wrote:
>>> From: Derrick Stolee <dstolee@microsoft.com>
>>> --- a/Documentation/SubmittingPatches
>>> +++ b/Documentation/SubmittingPatches
>>> @@ -373,7 +373,7 @@ If you like, you can put extra tags at the end:
>>>  . `Acked-by:` says that the person who is more familiar with the area
>>>    the patch attempts to modify liked the patch.
>>>  . `Reviewed-by:`, unlike the other tags, can only be offered by the
>>> -  reviewer and means that she is completely satisfied that the patch
>>> +  reviewer and means that they are completely satisfied that the patch
> 
> Say wait a minute.  If that is a "singular they", then why was the "is"
> changed to "are"?  I think that belies the fact that there is no such
> thing as a "singular they".

Singular "they" works the same as singular "you". For example:

	...means that _you are_ completely satisfied...

Singular "you" had a similar backlash in the 1660s as singular "they"
is having in this thread, but singular "you" has lasted (and we use
"thou" only to signify someone using old-timey language).

There is more of this in [1] and [2]

[1] https://public.oed.com/blog/a-brief-history-of-singular-they/
[2] https://en.wikipedia.org/wiki/T%E2%80%93V_distinction#English

Thanks,
-Stolee
