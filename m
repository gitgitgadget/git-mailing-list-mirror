Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D121C433E0
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 01:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A6696197F
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 01:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbhCTB4G (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Mar 2021 21:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbhCTBz6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Mar 2021 21:55:58 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3626EC061760
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 18:55:58 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id q127-20020a4a33850000b02901b646aa81b1so2758897ooq.8
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 18:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/HZ5emCo5ZHe3sSyF9iqrfNdwR+HDgIs5fzE+O0GC7w=;
        b=hS7/c2kxxn0DheNBViQfHyLaUG9+3Dm0PWOtrs/MXlDUV1PZdr5ejTMdStS5MQdCSt
         2aTyqjMljNBiOmysi8m6vur3EtAk94qBigm7DN5CmCN3w8jxnlQrRBGSsxqP7KNpn95M
         MiTXO7vNnYDCVNb+3V4XWQarCb2cb1m6QeG5KRcs1XbDgOwUhY5PCfbJDVOTxEx2Pzyv
         +TraL/aoueeueT7WoQ0oNK70zBQgPT0883Vv0AgsFsSgDS0UHUW2pbVEr6I6Kl4BtuYx
         rNMOrOB3KbfyMJM5sMZkSn7zTymczsClKcQ3a6wzB5cqcTz6p5f/jMlat+v6AuZ6yyZ2
         2UyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/HZ5emCo5ZHe3sSyF9iqrfNdwR+HDgIs5fzE+O0GC7w=;
        b=e3ErG/0E8UoQHYcIJ3/MXrZGHkuZynH+cQrDRiXFsGDkvFZkywtHZN6JfCLzGX4cmg
         aOKNLOKepPYeAUxiur7CaZCCfZcx+WGaTji1gEAZFKrvxnQLGGh+tHEeXQzCH/O0xj9b
         FTTlUXBYJAvwZl/gjILgKP+r5kpiaqDs6ZvOElkOZ+qLFIU7cleU2b3fruE1hpcD8f9/
         HSXvrJ09hfA+6ucmpWQQfsJbMOmaeNssExVjpnCif4fARVdtGpazpOenBD4dLr+Gmadw
         euudJ9LpZrkBRgg0M/mTf6dYeiGsIAFsrElKwDUlapQ4u4S7WD1kxcCyDxjfoGeN5oEh
         gN6A==
X-Gm-Message-State: AOAM5337vbRt65Nvs4LediKGiAsk2+WnfuCK0bTsyz3FgVVLiDsbY+lb
        7RUgisqXSb/7UrapQLcXUYQ=
X-Google-Smtp-Source: ABdhPJwvrI5jczHY9tcHPT3NkhZZ2FO3/Rih2NO7XBYLxlLbWuMhYNOl8pRvvIrdYAbmRL6iLbxkPw==
X-Received: by 2002:a4a:45d5:: with SMTP id y204mr3572845ooa.33.1616205357479;
        Fri, 19 Mar 2021 18:55:57 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:5c2:d98f:a8c3:5198? ([2600:1700:e72:80a0:5c2:d98f:a8c3:5198])
        by smtp.gmail.com with ESMTPSA id b22sm1557358ots.59.2021.03.19.18.55.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Mar 2021 18:55:57 -0700 (PDT)
Subject: Re: [PATCH] Fix a typo in git-maintenance documentation
To:     Junio C Hamano <gitster@pobox.com>,
        Nils Leif Fischer via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org,
        Nils Leif Fischer <hello@nilsleiffischer.de>,
        Nils Leif Fischer <nils.fischer@aei.mpg.de>
References: <pull.984.git.git.1616149021392.gitgitgadget@gmail.com>
 <xmqqv99nm3jy.fsf@gitster.g> <xmqqa6qynbfm.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d27633aa-8e68-36e9-ddd3-0d05d74a780c@gmail.com>
Date:   Fri, 19 Mar 2021 21:55:56 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <xmqqa6qynbfm.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/19/2021 4:19 PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>>>  gc::
>>>  	Clean up unnecessary files and optimize the local repository. "GC"
>>> -	stands for "garbage collection," but this task performs many
>>> +	stands for "garbage collection", but this task performs many
>>
>> Isn't this merely an American style vs British style issue?
> 
> Having said that, I think a lot of existing documentation (and my
> gut feeling says "majority of", but I cannot claim anything like
> that without actually counting [*1*]) we have tend to stick to the
> "punctuation outside" British style [*2*].
> 
> If somebody (not me, and probably not Derrick) is willing to do the
> counting and tree-wide style fixes, I am OK if we add some new text
> to Documentation/CodingGuidelines to declare which style we stick
> to, and enforce consistency throughout the documentation set.

I'm not lining up to volunteer for this effort, but if it is truly
the typical case in the Git documentation, I would agree to a change
to the coding guidelines and this specific change.
 
> [Footnote]
> 
> *1* A quick count:
> 
>     $ git grep -e '," ' Documentation/
> 
>     gives just a single hit.  On the other hand, '", ' hits too many,
>     but many are sentences like 
> 
>       "git clone -q", "git fetch -q", and the like are quiet.
> 
>     which is not quite fair.

Right. I would use this order in these cases.

> *2* After all, that is more "logical", for us CS types---opening and
>     closing quotes pair with each other, and the punctuation that
>     appears near the quoted portion is part of the larger sentence
>     structure.
 
I'm willing to concede that using ", universally avoids needing
a special rule, especially because phrases like

	If you run "git commit", then X happens.

is obviously the right thing to do.

I can't speak for contributors whose first language isn't English,
but I can imagine that removing the difference between these cases
would make it just a tiny bit easier to contribute.

I can break my own habits. The only thing I ask is to make it
officially part of the guidelines.

Thanks,
-Stolee
