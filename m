Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320B8C46467
	for <git@archiver.kernel.org>; Sat,  7 Jan 2023 17:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbjAGRGW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Jan 2023 12:06:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjAGRGU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jan 2023 12:06:20 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A9540C1E
        for <git@vger.kernel.org>; Sat,  7 Jan 2023 09:06:18 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-4c24993965eso54881487b3.12
        for <git@vger.kernel.org>; Sat, 07 Jan 2023 09:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PvLgnB1bSTD2AYSOGJWyy/Yxg/zOqnu8TRJt8n7mfFM=;
        b=Z/PF8sOlfy6fyOILf8qIXtSdEsP3vgXCq+H2lPBYMU6ET13zQqaUynm1ByJGOja6M2
         iofhHG3IISz5jnpYjVEGRBoufsEz9vuSyQKQMFvRSzzM3CRY0c4cqH6b2sNz10FLge14
         fCJ0s2qRmaDcXqU1db+VS2r+nxbW7JkYrC1SVqshoWPu7Heyi7KKobIY7zENoHRG2IE5
         ylxmYtZQw7c7jdtj3c/H5qg6iaSb/l5m0i45zby3ouFH3uayZGoC7AzHGviOwiXbiKSi
         KCTa6+9SvdazQPzkVb3O060w7kWqmvxi+ipBP9GZTOfKrzrLjAcppAN29WYa1kt/PDD7
         6AWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PvLgnB1bSTD2AYSOGJWyy/Yxg/zOqnu8TRJt8n7mfFM=;
        b=Y6+M4lJECoHQNVk+j/k5Vdf+jF0/TtZQZV7baZQcCDrs0L6Yrf/qVFEFHOghWUTpQc
         9nJFJOJkOF5dl9owPmgEpf0bipTdxY9Lo/wMb+fOuz1ScOxO2ECUWM/fmdDuxvuNH5r5
         KmxD3LiGZiDs4i4ZH60R7cc2PPXGfWdlq4mmozS9jhpcfkmG21ZLRHO73WRr+h7Fb5YX
         tOiNlgr6bkRv4malScewBYPgeRez+UFRaQYCY+ZOYCH9AhasnjOUqETMsGAGSjN9Ciah
         Jjw5GypPq5yAap7mcpn9E3XTFn4r+CfOLNwRZ3HXJAmlGC7jUgFA14/nn69pOXTwCnm8
         MgEA==
X-Gm-Message-State: AFqh2kpVr3kHMO/X+OsZXhnqEzgYb7qinmIIFjx/7arqJHNEvjmsC7ET
        oAbdpMVXXGUPmqebsRaE7kQRD23Xb28=
X-Google-Smtp-Source: AMrXdXs8In6w1x3K3vbT4wS9fOVKXchdZtO6RCWFVGC0os6AdvXh8sUEvmquaPBKi8B3GaJS/7g27w==
X-Received: by 2002:a0d:e68f:0:b0:4b8:6935:d57 with SMTP id p137-20020a0de68f000000b004b869350d57mr12411304ywe.10.1673111177014;
        Sat, 07 Jan 2023 09:06:17 -0800 (PST)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id bi1-20020a05620a318100b006fb0e638f12sm2426817qkb.4.2023.01.07.09.06.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Jan 2023 09:06:16 -0800 (PST)
Subject: Re: bug?: ORIG_HEAD incorrect after reset during git-rebase -i
To:     phillip.wood@dunelm.org.uk, Erik Cervin Edin <erik@cervined.in>
Cc:     git@vger.kernel.org
References: <CA+JQ7M-ynq1cLN-3ZodXae=x-H5k7Ab6uPBwUFhG+kgtOvCgtA@mail.gmail.com>
 <e6adaad6-f6ee-57d3-dc8f-d14a760c57c2@talktalk.net>
 <CA+JQ7M9G8HqqieRAK3C6csMM93PHOmaMd8GMPrDEfogWG0bteA@mail.gmail.com>
 <ef389a14-8513-4650-21e4-89421a24df2d@gmail.com>
 <81218256-5354-4b0a-6f74-7e9605131968@dunelm.org.uk>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <1b2b8e98-5506-a1e6-6059-a967757b3bb8@gmail.com>
Date:   Sat, 7 Jan 2023 12:06:15 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <81218256-5354-4b0a-6f74-7e9605131968@dunelm.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hi Phillip,

Le 2023-01-06 à 09:29, Phillip Wood a écrit :
> Hi Philippe & Erik
> 
> On 05/01/2023 00:11, Philippe Blain wrote:
>> Hi Phillip and Erik,
>>
>> Le 2021-12-16 à 11:44, Erik Cervin Edin a écrit :
>>> Hi Phillip,
>>>
>>> Yes, I know.
>>> It's just that I was under the impression ORIG_HEAD was to be reverted
>>> to .git/rebase-merge/orig-head at the finish of the rebase.
>>> Personally, it's the behavior I would expect.
>>>
>>> Thanks for the tips.
>>
>> I just hit the same bug (I think it qualifies as one). In fact git-rebase(1) explicitely mentions
>> that ORIG_HEAD is set to the branch tip before the rebase starts:
> 
> Strictly speaking that is what we do so we're documentation the
> implemented behavior. What's not clear from the documentation is that
> if the user run 'git reset' while rebasing then ORIG_HEAD will be
> overwritten. 

Yes, I agree. I think we could highlight it in the doc.

> We could update ORIG_HEAD at the end of the rebase as
> you suggested but I wouldn't be surprised if some else complains that
> ORIG_HEAD no longer points to the commit that the reset while running
> rebase. I also wonder if users would expect 'git rebase --continue'
> to update ORIG_HEAD to point to the pre-rebase HEAD so it is
> consistent each time rebase stops. Basically I think the situation is
> confusing and I don't have a clear idea as to how to make it better.
> If someone submits a patch to try and clean things up I'll happily
> look at it but unless I'm hit by a bright idea as to how to fix it I
> probably wont work on it myself.

Thanks for your thoughts. I think you make good points, it's true that 
some people might be relying on the current behaviour.

I'll try to send a few updates to the doc to make this hopefully clearer.

Cheers,
Philippe.
