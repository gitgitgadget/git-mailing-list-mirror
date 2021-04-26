Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CCEEC433B4
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 21:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D32561178
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 21:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235332AbhDZVDQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 17:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233483AbhDZVDQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 17:03:16 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E527C061574
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 14:02:32 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id p12-20020a4a2f0c0000b02901ecdbb16887so5676156oop.5
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 14:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Kk0pwT/zuhwh4cDMocgSbnASggU4QA+NF3X1sE9W8hA=;
        b=NsvqWSKpuSrBaJVH0NVQI+5LWHIdVSgeOLggWKmWWG8k/wO/XiOirhzamRChRx+xBe
         gswr6zUb2vhKsYtMbbHAkk6brNDa4SpvzrtTPDBnXgF0XRtx4hj0ZnGVXoJQwt+IytaA
         NceIaQpG5tPgu8p0wDj2y3k9dtlJHRbBGGS7mcyAQ6yxGqRlNH7GPDOOa/JdMfce0fc1
         1uuGM6iq1Cjm2TTE0GZ+5QUzm68ckwQldXkyh2+ccufGASNMns0mHMoq4lUPR6G4COzQ
         KVWk1rdE4P0HTvvZxrQnK5URG6Pd416LxbrGUF92uvz7pwxPluPzYczlbMhp95cMw+O5
         D5/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Kk0pwT/zuhwh4cDMocgSbnASggU4QA+NF3X1sE9W8hA=;
        b=n3M6IQjCja3+eC4HxIKnJxej8ycdgXFdDRgMskj/zQsQgdLgsR7uJuC+dMhgXCnDdN
         Q8euJ1ScyFRfzMLAb57iPeLyb2enc+m6MnQ1bU5If8ANVG5ibM7iBGLwgEGeFjBW6i4f
         jMzZgrZuz/puGz/OuTCnQWP2D5Y0wVEkRhlckoNIsoMCDg/LNcg946xGXOvVzgzyueDL
         04orDaXFoO8m+8EKWgY76YwtPiFLJAKLuYwwQJESlb4X/f8oi5BbbOIlP13u4ZzKO9Z+
         s9fSTXsIFRCSBZxjsa171ca8BDFKi/3dqlKgttPZxKDpxezWwJPYlUYjcoFSU3sO49dc
         J1Hw==
X-Gm-Message-State: AOAM530S54CAHSUhC03KZrFjp/V9PE9Sj7ooMxb56NfTUrQruw+Qp0a2
        ZelePdHA4v0LekZUkAEGonk=
X-Google-Smtp-Source: ABdhPJwDATpI0GpE1E+ugGBRXMwceEbszxE3ptW3brZkV6/k/xjqVjrGypFxH6zS6Da1O3uzfUa2kQ==
X-Received: by 2002:a05:6820:128:: with SMTP id i8mr9050582ood.75.1619470951747;
        Mon, 26 Apr 2021 14:02:31 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:65f6:360e:4aa8:3d0f? ([2600:1700:e72:80a0:65f6:360e:4aa8:3d0f])
        by smtp.gmail.com with ESMTPSA id w13sm233825oop.0.2021.04.26.14.02.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Apr 2021 14:02:31 -0700 (PDT)
Subject: Re: [PATCH 02/23] fsmonitor-ipc: create client routines for
 git-fsmonitor--daemon
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
 <3dac63eae201e6d0b949680e682238625cad59bd.1617291666.git.gitgitgadget@gmail.com>
 <5b63eb3f-0b87-209b-3943-ced8412abb93@gmail.com>
 <CAPig+cTjso8B=E0pGsr4TDU5zikVhjwbrrWD19uaiwJXvuXZ0w@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f18608a4-c4d3-9974-f8ab-ac416b82bab9@gmail.com>
Date:   Mon, 26 Apr 2021 17:02:30 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cTjso8B=E0pGsr4TDU5zikVhjwbrrWD19uaiwJXvuXZ0w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/26/2021 4:20 PM, Eric Sunshine wrote:
> On Mon, Apr 26, 2021 at 10:31 AM Derrick Stolee <stolee@gmail.com> wrote:
>> On 4/1/21 11:40 AM, Jeff Hostetler via GitGitGadget wrote:
>>> +#ifdef HAVE_FSMONITOR_DAEMON_BACKEND
>>> +#define FSMONITOR_DAEMON_IS_SUPPORTED 1
>>> +#else
>>> +#define FSMONITOR_DAEMON_IS_SUPPORTED 0
>>> +#endif
>>> +
>>> +int fsmonitor_ipc__is_supported(void)
>>> +{
>>> +     return FSMONITOR_DAEMON_IS_SUPPORTED;
>>> +}
>>
>> I don't see any other use of FSMONITOR_DAEMON_IS_SUPPORTED,
>> so I was thinking you could use the #ifdef/#else/#endif
>> construct within the implementation of this method instead
>> of creating a macro outside. But my suggestion might be an
>> anti-pattern, so feel free to ignore me.
> 
> On this project, it is preferred to keep the #if / #else / #endif
> outside of functions since embedding them within functions often makes
> it difficult to follow how the code flows (and generally makes
> functions unnecessarily noisy). So, the way Jeff did this seems fine.

Makes sense.

> An alternative would have been:
> 
>   #ifdef HAVE_FSMONITOR_DAEMON_BACKEND
>   #define fsmonitor_ipc__is_supported() 1
>   #else
>   #define fsmonitor_ipc__is_supported() 0
>   #endif
> 
> which would still allow calling it as a function:
> 
>     if (fsmonitor_ipc__is_supported())
>         ...
> 
> but it's subjective whether that's actually any cleaner or better.
 
True. I'm just thinking about a future where we need to do a runtime
check for compatibility, but let's use the YAGNI principle and skip
it for now.

Thanks,
-Stolee
