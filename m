Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A417C433B4
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 03:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 291D561132
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 03:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbhDHDy7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 23:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbhDHDy6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 23:54:58 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD0EC061760
        for <git@vger.kernel.org>; Wed,  7 Apr 2021 20:54:45 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id l76so426155pga.6
        for <git@vger.kernel.org>; Wed, 07 Apr 2021 20:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=tRHUvvwxb0c2T+10VLGCmeAWgdXAtUjVSuXuq9bUkXw=;
        b=KZ8y8HU6GFyNia+WfXi/iECma7Gp+ATk0MgcwOs9UemsSYL4BC6bqCIjMPRAksx7en
         x7Lz1z2Hacle+rGqZZRBuEfYAgcO7UiW+13wGjfGRd7EicQCErUKsv9+Ziv/UQ+w9hWD
         cb8mn/XB9M5w8bsOLSf651Er8T84jyblG8uUrQPMRARvnK+tzneusxFGxtTkSSrvMIt2
         eDMhadDZhPwycZWuz6rXZWFrz92Qc8zpcavgv2ON3Hhm/4O1baZei1yJwLiw39hx26ON
         QZFFEWL1fhoh/LVG7jvl+9OUmfKoHK/snu96BQHgsXXXW9VJhDDY4Gq5lN1TgdZq5I/K
         Pzrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=tRHUvvwxb0c2T+10VLGCmeAWgdXAtUjVSuXuq9bUkXw=;
        b=tsjFjVHDRZrcvpS1InKfZpq8skpyai2ep9fFxrnk4gCK3tXrqoLNQZUa+S7xR/Ax+V
         N187JUjMYAKm06s02d60M6YDLjb2wTqD2Yvna1PEKVtfn0/PnPg62gpfmOXnN1bXRZhT
         3QICl5l8iEtailSnFIQ2ruiOoGXGPTafsCy0StGjCETvxkccrtEIiq7l70fW0KXHwJPf
         gIzKviKV5FVvOo5WQPxAkwKeu5XXllFPTZovee2mWs6j17rulX7aVkjtH1UhO2F4Dpvb
         kMQYsePiedfWOj46Xi8Ejjcv9RreowQtQ+PsYvXvZebhXiH4gYsZXlE5xXaAlYOjeOXJ
         s2Vg==
X-Gm-Message-State: AOAM533UWtooSqOwhDUZvUxHDw/0MW0OP1WBtj+MZADFket6++KgEuqj
        gCVv4i4/oDF+rJfgnVXUG2X5HV6cmyXzWg==
X-Google-Smtp-Source: ABdhPJzmEiWur7OR4CG+OMo++X2v8u99bFuY0Eo6CrftSaciC7mXRgTDo5QSyyAQTmbbsClXnlRGhQ==
X-Received: by 2002:a65:6645:: with SMTP id z5mr6095903pgv.273.1617854084739;
        Wed, 07 Apr 2021 20:54:44 -0700 (PDT)
Received: from [192.168.0.107] ([103.112.34.122])
        by smtp.gmail.com with ESMTPSA id y4sm22045007pfn.67.2021.04.07.20.54.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Apr 2021 20:54:44 -0700 (PDT)
Subject: Re: [PATCH v4] cache-tree.c: remove implicit dependency on
 the_repository
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <pull.915.v3.git.1617465421353.gitgitgadget@gmail.com>
 <pull.915.v4.git.1617778489719.gitgitgadget@gmail.com>
 <xmqqsg41wvdi.fsf@gitster.g>
From:   Chinmoy Chakraborty <chinmoy12c@gmail.com>
Message-ID: <0df415b7-73b7-6e72-1885-3ca606acf8fd@gmail.com>
Date:   Thu, 8 Apr 2021 09:26:12 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <xmqqsg41wvdi.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 4/8/21 4:33 AM, Junio C Hamano wrote:
> "Chinmoy via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Chinmoy Chakraborty <chinmoy12c@gmail.com>
>>
>> This kills the_repository dependency in cache_tree_update()
>> and prime_cache_tree().
>>
>> Signed-off-by: Chinmoy Chakraborty <chinmoy12c@gmail.com>
>> ---
>>      Replace the_repository with r
> Huh???


Sorry I forgot to change the cover letter.


> The patch assumes that istate->repo will always set, but it does not
> even try to justify why that assumption is safe to make (e.g. "the
> entire codebase that leads to this function has been audited and
> made sure istate at this point will always have its .repo member is
> set" in the log message, if such an audit has actually been done,
> may have been convincing), which I find quite troubling.


Is it safe to make this assumption? I mean to be completely

sure of this, one would have to track back to all the callers.

Should a check like:

     if(!istate->repo)

         istate->repo = the_repository;


be required?

