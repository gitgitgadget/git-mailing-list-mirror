Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EBC9C433B4
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 17:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ED1761462
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 17:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbhD3Rec (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Apr 2021 13:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbhD3Reb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Apr 2021 13:34:31 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FBFC06174A
        for <git@vger.kernel.org>; Fri, 30 Apr 2021 10:33:43 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id i8so5099003qvv.0
        for <git@vger.kernel.org>; Fri, 30 Apr 2021 10:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hMTQnoVwehlljuU8QPp6HT3ceM5GaTcNXipRLyMaqoI=;
        b=mpWa8xd/mw2IhoSZMCPcpqDyW0v9WYPA9U/0PC2/URhXMIPtBMaPFcjTD0XdV9vVwD
         EXB3cvRzk7bW0zv6QtnMZ+LFB6uS44DNIbtZvkPaJsqokoX5XUXISSSOvaAVw1f2Ptm+
         PV/hjrnNbSW73L8I7DMZS9UAnJJBF5OTS3ZSq7JMPMEgK7vfZERKwBfGZkLC9tqe2OFP
         ClYwxYT9qmCOnSt3+YAD9x7/cA5QTE4OkLw2uborvyWXLG+pLZiUPLLNJaYjHc0wSs0T
         HiyuFddSZsPbs+WM4YCT1HGB04c6u9WsysbM1Ok/2P13sJ6HylZjKObjsOyMcCdWNZAI
         IYKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hMTQnoVwehlljuU8QPp6HT3ceM5GaTcNXipRLyMaqoI=;
        b=UEk/RiyVWRm6fIASftbjriwsWhBhCbeoC8xZ89ui/sXfAVittRdiYG0H35EUVqxAwd
         k78J1usHPr1XELSKt0efKRcLS9S6HPEHLhOrXnAHHXxU/RYrqGQDX7jWAg5sD2nWhiUZ
         ZVbjLDqvTog5GQBitaaXk/21OF7fLJZwpQpb8X0R+oz9TNwGy8dADJzhdAtlL/bmm4/p
         Xs5nwhO8r3Nd7AdvTb1MukKw9ZRODAePBGwApyU75QU++qmjQ3qb/JgC9qhXRrZUzttG
         dtCYW3vBUDeDyyIMWyoXkIQJqOw4W151suXdSIehmg7DnTpNyu9E54HTVLORIaReAJuZ
         nC9Q==
X-Gm-Message-State: AOAM531EAkVx+ArQmzrNjqmqzhjcAws2dql9Ok14NFsCnL8VXEgVQt0B
        GwBvt76RwuYYm69nlNtrmYo=
X-Google-Smtp-Source: ABdhPJw7MeuJs2zAGAUj6gkBF8U4qfU/GeaTRPjlfO0N6kS/QQQWuhTvGdOOCW4wrp4kpMCGCQLgLQ==
X-Received: by 2002:a0c:ff48:: with SMTP id y8mr6745252qvt.8.1619804022619;
        Fri, 30 Apr 2021 10:33:42 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:b0ab:c525:4a3f:138b? ([2600:1700:e72:80a0:b0ab:c525:4a3f:138b])
        by smtp.gmail.com with ESMTPSA id h188sm1962488qkd.23.2021.04.30.10.33.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Apr 2021 10:33:41 -0700 (PDT)
Subject: Re: [PATCH 0/6] Push negotiation
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
References: <cover.1617929278.git.jonathantanmy@google.com>
 <xmqqtunocoqf.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e8d20651-43fb-8e1c-3047-7a0bfa5010e6@gmail.com>
Date:   Fri, 30 Apr 2021 13:33:40 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <xmqqtunocoqf.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/30/2021 1:42 AM, Junio C Hamano wrote:
> Jonathan Tan <jonathantanmy@google.com> writes:
> 
>> Here are patches for push negotiation. The basic idea is that we can
>> reuse part of the fetch protocol (and code) to find out what is in
>> common between the client and server, and then use that information to
>> further narrow the objects sent in the packfile during a push.
>>
>> Patch 1 is a bug fix that probably should be merged even if the rest
>> aren't. Patches 2-4 are refactorings in preparation for the future
>> patches. Patches 5-6 contain the actual logic and documentation.
>>
>> I have written more about it in my prior work [1], although the commit
>> messages and documentation in patches 5-6 should be enough to explain
>> what's going on. (If they're not, feel free to make review comments.)
>>
>> The main change from [1] is that the client-side code that used to be in
>> builtin/fetch-pack.c is now in builtin/fetch.c, because I realized that
>> builtin/fetch-pack.c does not support HTTP. Other than that, all the
>> "what hasn't been done yet" items have been done except for statistics
>> in the commit message.
>>
>> [1] https://lore.kernel.org/git/20210218012100.928957-1-jonathantanmy@google.com/
> 
> So... anybody else wants to review this and give it a-OK?

I put this on my calendar for Monday morning. I hope that's not too
long to wait.

Thanks,
-Stolee
