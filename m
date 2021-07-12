Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F1CBC07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 13:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 208DD61003
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 13:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233949AbhGLNzf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 09:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbhGLNzf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 09:55:35 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE59C0613DD
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 06:52:45 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id o9so2317663qvu.5
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 06:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Fa+JgJq5Hc90jK7ihISSTZ1ycEIWnqoadSwRNmFg568=;
        b=V/D2vIN8q8TxJwMYnybBdblfP1/0paoIkVH8xQpODvOyR1hiel8zxlNPqgVSJ1HvIs
         ppedT/1h+K3fQ/I4u3EreENQx8I6cqf6AO5S+A3kC6BCjxNVqnVFMx7UsGur19KPqu6Z
         AETxxEsJ1gBr/fRhB8wIJa25ZQzkbTyaVMHwaiOGRoZRdl9wX8jWTlZgVMNP2HVHIALQ
         f/Elv0boezqbl5uz7taTxBAq0FbYFBo+0TlIwoMO80rbQC908X0XCd12fSJMofmcNpy+
         MCe+VPnTqBUGHzHx1fnpx/uiGj7Q3o8SqGumzu5vHT95pOaSQ1QF79AhPugbX3lAAcbT
         K62Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Fa+JgJq5Hc90jK7ihISSTZ1ycEIWnqoadSwRNmFg568=;
        b=pPx+US3/ZwW8HJdbkiIxR2Knm7tZRQ0Wy9oi/4I8BgQnPKc5QTz6vUE4tvHn04yGHb
         3Q/CCdlbxrTsZkJhA501EBDic5MJfBXHUDqhwUF4LXAT4taKVgghxD0nvaEPEte84Hyb
         hFpSWsQ79pivmvpd6e+qQf69mTS9r+VDk98Pm/zQ/a2FaY09tZ2JifoU7QAb6wqo0Tzi
         OSMpWvmNBTplWHJLpYEFLFZfqa2d/95gaEZaHTHt8bIjWVFehHLE7OlswI0i4RTiiS+4
         izShr611lQ6CoVz/TWojnbprpBLioQR+7XT+qQ0x7A3KLWJ+x2kHY48i/TiLP+oNpqrl
         v4mQ==
X-Gm-Message-State: AOAM530+B52UA4gMC1U2nks7QjX5smSz5eiQJFid6RABsIWU9rZUqFE9
        56ZyTZ8cmAM2FYCMxCkThIM=
X-Google-Smtp-Source: ABdhPJxZ0fb61veUW6zU2JaFGTwNIbjuRHFe/5T4rYhRmLaKG94Q3O2USIOXqRZdE2zsd4Jt9wcqtA==
X-Received: by 2002:a05:6214:6a1:: with SMTP id s1mr14706580qvz.54.1626097965019;
        Mon, 12 Jul 2021 06:52:45 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:91f8:61a:4701:b6c? ([2600:1700:e72:80a0:91f8:61a:4701:b6c])
        by smtp.gmail.com with ESMTPSA id f36sm5604903qtb.40.2021.07.12.06.52.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jul 2021 06:52:44 -0700 (PDT)
Subject: Re: [PATCH v7 12/16] diff-lib: handle index diffs with sparse dirs
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.932.v6.git.1624931502.gitgitgadget@gmail.com>
 <pull.932.v7.git.1624932293.gitgitgadget@gmail.com>
 <f83aa08ff6b0fd18d6f9f3ce5ee993523a7f1759.1624932294.git.gitgitgadget@gmail.com>
 <CABPp-BFaWxuBTgztpmso9zCOz3AC62HQuAi5XVAEwsfevYv8gw@mail.gmail.com>
 <CABPp-BHnjB5H4cJ_mx=3PNVss0Z+d-aEE5Hw4AcuLTC0PC+3qg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <bfc422fd-7040-fed4-3284-8ea66b33bcd1@gmail.com>
Date:   Mon, 12 Jul 2021 09:52:41 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BHnjB5H4cJ_mx=3PNVss0Z+d-aEE5Hw4AcuLTC0PC+3qg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/8/2021 7:51 PM, Elijah Newren wrote:
> On Thu, Jul 8, 2021 at 4:10 PM Elijah Newren <newren@gmail.com> wrote:
>>
>> On Mon, Jun 28, 2021 at 7:05 PM Derrick Stolee via GitGitGadget
...
>>> +       /*
>>> +        * If both are sparse directory entries, then expand the
>>> +        * modifications to the file level.
>>> +        */
>>> +       if (old_entry && new_entry &&
>>> +           S_ISSPARSEDIR(old_entry->ce_mode) &&
>>> +           S_ISSPARSEDIR(new_entry->ce_mode)) {
>>> +               diff_tree_oid(&old_entry->oid, &new_entry->oid, new_entry->name, &revs->diffopt);
>>> +               return 0;
>>> +       }
>>> +
>>>         if (get_stat_data(istate, new_entry, &oid, &mode, cached, match_missing,
>>>                           &dirty_submodule, &revs->diffopt) < 0) {
>>>                 if (report_missing)
>>
>> Love the simpler patch.
>>
>> I'm curious about the case where S_ISSPARSEDIR(old_entry->ce_mode) !=
>> S_ISSPARSEDIR(new_entry->ce_mode), though; how is that handled?
> 
> Digging a little deeper, it appears that we could add this just before
> your new if-block:
> 
>     assert(S_ISSPARSEDIR(old_entry->ce_mode) ==
>            S_ISSPARSEDIR(new_entry->ce_mode));
> 
> And the code still functions, while that also removes some of the
> surprise factor.  I'm guessing that the difference between "folder1"
> and "folder1/" cause us to never try to directly compare a file to a
> directory...but if that's accurate, a comment of some effect might
> help make this code be a little clearer and make readers less likely
> to wonder why you need to check that both old and new are sparse
> directories.

I was surprised that this worked, because my patch conditioned on
old_entry and new_entry being non-NULL. But of course show_modified()
requires them to be non-NULL. That can be further simplified.

Adding the assert helps demonstrate this expectation, but also I will
expand upon the comment.

Thanks,
-Stolee
