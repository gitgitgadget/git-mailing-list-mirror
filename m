Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81A6C43461
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 11:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DE25613B8
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 11:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242115AbhDFLq3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Apr 2021 07:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238146AbhDFLq1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Apr 2021 07:46:27 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D11DC061756
        for <git@vger.kernel.org>; Tue,  6 Apr 2021 04:46:19 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id x207so14781923oif.1
        for <git@vger.kernel.org>; Tue, 06 Apr 2021 04:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YKnT1yHqY80zVrrspE8SH9jPpvlBc1tA44t3r86dKQo=;
        b=Scc67XkxnkEprvCzj/7hQ9gdsYKqAexrgMeFs6+YwW0PchSq+M63p05432AnSF5VNk
         32frNqEB4Uhmeu5NAc7kPsjlAXjscMqCM+i+Mxey29TgMb2aVaCKqNwLv0Bqc4yu8Dvr
         ieF5AYu2NtadOcAbJhULylbS3mXoGeifADTZNmsdLicDlgvc4gGbPyCC4JKJr1qmabRG
         8T1sT8iomz3Fm/s2tpSOd1aElcSPjFcIqNV3OSVQaItNGUApFksjhbXlgZDFueM6gENu
         cNOQaeWGdi4bl7cE36s4w2BYQrNcYkB+x5VVCRHJDy2/Q80b1vysi7DjondFGnAeL6gx
         0Trw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YKnT1yHqY80zVrrspE8SH9jPpvlBc1tA44t3r86dKQo=;
        b=PPItuRhrG+D4fMUtDLwQtrHAOB6UXCAyQiYL2R6UkUUgZ9NdxSzuUsbyJZeTVeiwju
         CNuyuju2F0kBF4SPpc3MG/XS17/994f3jEh/mEAanE0cT0ISPSUsHsSZ1/NQ1oPAZpfH
         rUw+ar1Pz8IldIHIGu5hPwINL9/Ob8ZlUbsn3QUhbGua0Z2oU3+1aXC488pCRGJdAGSk
         uoPjDdjbIIXnCCnQCucb/f4d9V6zaZsGQTpN/j5rHyH7ExLiPwGvXuWS7D44Tm2wfOCE
         BuuoAnEjmsqOZagtF45pvao0I0dwZEUZc4jo7FgvTLzu/ApbyIItgd3niRffrFH5nwK7
         jmqQ==
X-Gm-Message-State: AOAM533AyjJl8KeSah4YyYu1XaK6j1qkXbO9LLe4+ll+yCPPwE6z5U4c
        AHgPBQBXxW3u82jjeNc/+SI=
X-Google-Smtp-Source: ABdhPJwatgYXqyoEFpLcKvTalUms6hgA+86TTeij9UcWIc/2JYsnJkWlZMEyoRy9Rvqq3/pmlP2NyA==
X-Received: by 2002:a05:6808:68e:: with SMTP id k14mr2894988oig.175.1617709578762;
        Tue, 06 Apr 2021 04:46:18 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:7d35:99dc:7770:379a? ([2600:1700:e72:80a0:7d35:99dc:7770:379a])
        by smtp.gmail.com with ESMTPSA id p3sm4636838otk.9.2021.04.06.04.46.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Apr 2021 04:46:18 -0700 (PDT)
Subject: Re: [PATCH v2 24/25] sparse-index: expand_to_path()
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.906.git.1615929435.gitgitgadget@gmail.com>
 <pull.906.v2.git.1617241802.gitgitgadget@gmail.com>
 <d52c72b4a7b9a3ae10bd2daae85c1bd1bafcc2f3.1617241803.git.gitgitgadget@gmail.com>
 <CABPp-BE5xLMsVdamAb=MgiBnXKQrYDPJXa1TWutDK+nVYRPyRQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <4768fac6-1d8d-4865-76a2-19f110f66219@gmail.com>
Date:   Tue, 6 Apr 2021 07:46:17 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BE5xLMsVdamAb=MgiBnXKQrYDPJXa1TWutDK+nVYRPyRQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/5/2021 3:32 PM, Elijah Newren wrote:
> On Wed, Mar 31, 2021 at 6:50 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Derrick Stolee <dstolee@microsoft.com>>> +               if (index_file_exists(istate, path_mutable.buf,
>> +                                     path_mutable.len, icase)) {
>> +                       /*
>> +                        * We found a parent directory in the name-hash
>> +                        * hashtable, which means that this entry could
>> +                        * exist within a sparse-directory entry. Expand
>> +                        * accordingly.
> 
> "this entry" is a bit unclear; it might be worth referring to the
> "path" variable instead.  I think it'd also help to explain the
> reasoning for using the '/' character, because while it's clear when
> looking at the series, just running across it in the code it might be
> easy to forget or miss.  Perhaps:
> 
>                     * We found a parent directory in the name-hash
>                     * hashtable, because only sparse directory entries
>                     * have a trailing '/' character.  Since "path" wasn't
>                     * in the index, perhaps it exists within this
>                     * sparse-directory.  Expand accordingly.

A good recommendation. Thanks.

-Stolee
