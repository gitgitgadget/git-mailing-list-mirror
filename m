Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13038C433E2
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 17:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA911206C3
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 17:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FBZWlFCi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbgIQRt5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 13:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgIQRr7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 13:47:59 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28698C06178B
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 10:37:32 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id k25so2561019qtu.4
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 10:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rRxjtSIaiaj9u8nUsrWRzaECoY2koz0wq6zfI5pcrMA=;
        b=FBZWlFCi8vALKBE1OJumBpMwqFRdHekJLgA/Xzv31UMrRmTvaZ5vnZViiPKu7cyzXo
         Bo5XC82F73xDrvL3GLwrubAWMNRggjtin9JCKyj0kL+fQR3oOk5DmEtoJXv5lQq0Yjwz
         NGt0xE1zqGy1NT0UM4f64KN0M540MmxcPeYufT2+ELDhaUgHh90AqR2EzTH8sgDJXupK
         FWtll947R7W993rgZoSsrH2tMk29V3QNeuvYQ1mThKyhP/hsz2vEoJjF7v4pE4jEOhCm
         lUArDUawDdlXOVI1rSYapW6MXzVL4/QhOGVJvxyiWBZC94xrPNPYrUMvCkr5f5HE/8hD
         J46A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rRxjtSIaiaj9u8nUsrWRzaECoY2koz0wq6zfI5pcrMA=;
        b=E0c9TxhDNoo5sGozhu6YFweR665cgAWSu1c29Tg3N0jJ8sA1EyXgFMBFmiFATEKa3v
         2WWeqEqu0lFW4rBsC1+2/rSI6tlR6DdKMJll2F6lmj480jEAlZD4fxYp5yhp0dNM4OVu
         9cb3tsxivtYEUF8yIncAyOO/7uRjozzyCeOUUgwaWxVUfUtQkahaj0TDaNdXW+9eLh+h
         JYbHURNcQfaEv69beNRTiP00e19wmJQe3ooETjTPElKKZdiowsuzqAy35t78qmIR2aBk
         ZFJ4nhPB3xmHxKBY+ZvZNAPphlVdum+NIEYBCC6nATESY+801GTmI0wcl03a04YlsT7A
         TnDA==
X-Gm-Message-State: AOAM531tOxHbUwfOejJAwyIWs8/2Lap8Bk984FRm0fpO5aqWKEXy9RBu
        nTetqQAQCFzraFpsjCzLUn4rEEmiGZbOyg==
X-Google-Smtp-Source: ABdhPJxHA52F7WzoS6jnbg3jU7dl+UvhHoUErrEGIR+xAsgzesXZGap00jHbJdrAjSFvpfHUaEHUKg==
X-Received: by 2002:ac8:414e:: with SMTP id e14mr14828667qtm.250.1600364251065;
        Thu, 17 Sep 2020 10:37:31 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:acfa:efc8:96e3:6e10? ([2600:1700:e72:80a0:acfa:efc8:96e3:6e10])
        by smtp.gmail.com with ESMTPSA id k5sm43416qkc.45.2020.09.17.10.37.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2020 10:37:30 -0700 (PDT)
Subject: Re: ds/maintenance-part-1 (was Re: What's cooking in git.git (Sep
 2020, #04; Wed, 16))
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <xmqq8sd9t679.fsf@gitster.c.googlers.com>
 <39e940da-c8ee-9371-84e3-1bedbe86bf5b@gmail.com>
 <xmqqo8m4s6mi.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f22e0a5e-3e08-874a-bb86-a3a3be108bbb@gmail.com>
Date:   Thu, 17 Sep 2020 13:37:30 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:81.0) Gecko/20100101
 Thunderbird/81.0
MIME-Version: 1.0
In-Reply-To: <xmqqo8m4s6mi.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/17/2020 12:36 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>> This message [1] includes a simple forward-fix for the
>> parsing logic. I mention a re-roll in my preface, but
>> I was talking about a potential re-roll of part-3 when
>> that gets more feedback.
>>
>> My hope was that the quick fix could be applied directly
>> on top of this branch and then cook in next as planned.
>> I'll accept a delay if you think that is merited, but "on
>> hold" just seems like you are waiting for something more
>> from me.
> 
> I was expecting [1] to be corrected in the commit in the series
> before it hits 'next', not a "oops we screwed up earlier so here is
> a band-aid on top", which we must do after the topic is already in
> 'next' or 'master', and also hoping that it would happen quickly so
> that we can move it forward.

Noted. I can squash it in and send a new series.

Thanks,
-Stolee

>> [1] https://lore.kernel.org/git/0b35829f-a83b-a093-2dc5-0e7d3b42fd15@gmail.com/
