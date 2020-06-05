Return-Path: <SRS0=KQVw=7S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7213AC433DF
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 13:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D8B4206DC
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 13:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PejD01Hv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgFENH4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Jun 2020 09:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbgFENH4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jun 2020 09:07:56 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9AFDC08C5C2
        for <git@vger.kernel.org>; Fri,  5 Jun 2020 06:07:55 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id v79so9498962qkb.10
        for <git@vger.kernel.org>; Fri, 05 Jun 2020 06:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JEK9dnbOAldToN6KtS/KAR+7ex6wxVLQpACpAnDvURk=;
        b=PejD01HvOminYXBhWZOHBbuZx5IVshaCMVWv1zol72CUkBqXhSe48ADzE6de1xiIRl
         j5Z/8gwUZLG0+r4BpjEDT3Unj5U9BwNsLYpJXyWQ++LeYOKazwwIq/w4C+S5dCJtNYOH
         K4QgoUSFRzFdzwKttsIk1T8ZfhHnK4hAJID+ViSVeC+6h0Wuv1vP36Wiu1C2iesoe8Xa
         lMiIIM2nE39cB6jkJ1F0mdiAttM2FjALBHjMGzJSsD6P1j5HSq3LJqcSQybD11820l5t
         nqi27qg/dCZUYVJhqhD5Ihjrwk5rDa4mfu0L/F9sptg1bHYXJp0eF+K6pEdkqYegbhot
         gAOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JEK9dnbOAldToN6KtS/KAR+7ex6wxVLQpACpAnDvURk=;
        b=TigTzvJXyAJ66H0KPagvEPN9kg2mZnZqHg5zZEjKtBjTT1fNViqpR8Czo/zp2lN88p
         jpSCJkzsf26mswzhHoSz/b0Qf4vHyA15eN6L2xN+OCcKPHAOnw3t/ihw6aKLbC80bXP5
         9tH9mudxgc4/AUgH+5/Mr1D1seK4Wlw8yeJDRuE4ehJsvWpMTlVxG3FGyUY0j/inZct3
         KjkGQAipOnuspemxNsNFVrRh4fIFb/gle7UOrvxApfVWsXEMzTGE1hH85SmIJBci3RFQ
         uBo9ntc6cKU8wt+pV4DAIm4hXfQBW10esftHTfUd8mEn13xk+8c87FM2tZEFoiwhRwKm
         HnQA==
X-Gm-Message-State: AOAM530o8BN2666Tei9SXnKccqSwszcbPgYnKWAlcOFnGx7OSUpbWJGH
        N9GcejmOBpNzwyph5C1QzhavDccFr9E=
X-Google-Smtp-Source: ABdhPJzMTVjZavdr6wkbs2xgcYvQ1ueaMYsGyZAKh0Avi9i2Bj626+FxGvp6IqP+fiZfSm6EQYGAdg==
X-Received: by 2002:a37:9bd7:: with SMTP id d206mr10268569qke.113.1591362474804;
        Fri, 05 Jun 2020 06:07:54 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id q38sm7979423qtb.74.2020.06.05.06.07.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2020 06:07:53 -0700 (PDT)
Subject: Re: Possible regression for sparse-checkout in git 2.27.0
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Shaun Case <warmsocks@gmail.com>, Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <CAD3+_6CUX0RPr-dgfUnfGDNNfqu80SYCskioYnu=MS6aJv2dEQ@mail.gmail.com>
 <CABPp-BGvc3GZfFuiXaqDk6391ZexQ7D3x9gr5JK6-L+rDQQ4sg@mail.gmail.com>
 <c1f9d76a-bf39-8508-1f4f-b34be77450a0@gmail.com>
 <CABPp-BHyDUrOLg6-VONewbmXNFHUvKoDXfRTLgg8aEhJFtJLuQ@mail.gmail.com>
 <CAD3+_6AK390F5iVqCmP-FY8MxJtcUoS7HsbunhZ0qNzOdT53CQ@mail.gmail.com>
 <0aab7056-7176-01bc-ca7b-01356cbace4c@gmail.com>
 <xmqqtuzqnxdm.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <7a6e14b2-84ce-0a78-3644-ffd0e647df05@gmail.com>
Date:   Fri, 5 Jun 2020 09:07:52 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:77.0) Gecko/20100101
 Thunderbird/77.0
MIME-Version: 1.0
In-Reply-To: <xmqqtuzqnxdm.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/4/2020 8:56 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>> The first is due to the .gitignore syntax. The syntax allows exact
>> matches for _directories_ using a trailing slash "/". For example,
>> we can match everything in A/B/C with the pattern
>>
>> 	A/B/C/
>>
>> This would match the files in A/B/C/ and its subdirectories, but will
>> not match a file A/B/C.txt or A/B/C1/. There is no equivalent matching
>> for files, so A/B/C _will_ match a file A/B/C and A/B/C.txt. Whether this
>> matters to you or not depends on your file structure.
> 
> The pattern A/B/C _will_ match a file A/B/C and a directory A/B/C/,
> but I do not think it matches a file A/B/C.txt (or a path with any
> other suffix).

You are correct! I am mistaken. The directory/file confusion would
lead to some interesting logic in an implementation that allowed
file matches.

> I suspect that for the purpose of your explanation, the pattern
> A/B/C does not have to match A/B/C.txt to cause trouble; the fact
> that it matches directory A/B/C would be sufficient, I guess.

Yes. It certainly complicates things.

The thing I neglected to mention is that this file-based matching
is usually necessary when there is a directory containing _all_ of
the "big files" instead of organizing those files into directories
based on who needs those files. It is possible to reorganize the
directory structure to use cone mode and achieve similar goals.

Thanks,
-Stolee

