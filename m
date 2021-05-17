Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBC3C433ED
	for <git@archiver.kernel.org>; Mon, 17 May 2021 06:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B01F61185
	for <git@archiver.kernel.org>; Mon, 17 May 2021 06:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbhEQGu1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 02:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbhEQGu0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 02:50:26 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE20C061573
        for <git@vger.kernel.org>; Sun, 16 May 2021 23:49:10 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id l70so3989311pga.1
        for <git@vger.kernel.org>; Sun, 16 May 2021 23:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YbEczw/eXXMSs9GYp2iku5+6F4BUzIn44OLg2ihPHFw=;
        b=rddNnm46JWC8OikSb8Fma2TVniyQsu8N/KGVRcKyUoZiEoKMrHApH39UXRAM4IZ0QS
         bLkGN+I0wFRKxMSGJoUz3tX1L72YhjnKtlz2FQQSjk8tLnSclN2sTuVpc08aXYxYCOH6
         80TCa+pk0teBwg0gug891SX1SctPCrblYnfopzzdBuSER/DwbI9IKVrdhfm8XGXEcX+F
         7MnfYRQNXnMMqQRWeFaA5AhcrxBJE1nn1wFVhECJ+pyJfoCYDvPAp+73Q4MgbEY3eCzw
         L/NsvWv/4PuqG68fTPydd28LjVhYQeUEVPjr89BnM8/KVP/whg/HA35CbFQEFUlM88Y1
         zPgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YbEczw/eXXMSs9GYp2iku5+6F4BUzIn44OLg2ihPHFw=;
        b=PpxWSPQ/a51FfJD8zua4mTaxTg/U9o+tkfHSRD4sQMDzky+wPxoB1u669+zY5utob3
         tm0RbsG0/qOK3ijeCau53EH84yrU7z4ACZWDSi1wlt1ryVcf4098qdN0ojFcUQW5AGKz
         9ipfpSlYWN7r0BdhCAodxIETaHjr8+Zw7KAo+YVKrieUkLuHCUXEe1nim4Q8nBVP/Wfb
         nyxCmCTgGzEae+DsaMWpwpVyc7RCV48zk2pC8Ce9FTaGflNRL2djASjLVjpP+87GW4jC
         LVuQfU+DL0U4TAst/iEhCYkSWczll8i3EuS4OU2/prv1KBJZzFvq2eONy4iNi4bgyQ/r
         BThA==
X-Gm-Message-State: AOAM531H8hxfdYJrqSUots+nG1I4mxR9avslWZlUCmLxEvzHwmyI/t2d
        X8NgLTKeJOi6R6TPkEsNaC1dw/RNmdcNXA==
X-Google-Smtp-Source: ABdhPJy53V/jQg2obHx2Q1Gi3iER5aKEngTR7USkXOaDrUSsrkA9hR3C4TTXJx8KMMjqNAvQP6gWtQ==
X-Received: by 2002:a63:4145:: with SMTP id o66mr36920986pga.4.1621234149940;
        Sun, 16 May 2021 23:49:09 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-39.three.co.id. [116.206.12.39])
        by smtp.gmail.com with ESMTPSA id y13sm4407637pgp.16.2021.05.16.23.49.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 May 2021 23:49:09 -0700 (PDT)
Subject: Cryptographic hash agnostic git (was: Re: Preserving the ability to
 have both SHA1 and SHA256 signatures)
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        Personal Sam Smith <sam@samuelsmith.org>,
        dwh@linuxprogrammer.org
Cc:     git@vger.kernel.org
References: <D433038A-2643-4F63-8677-CA8AB6904AE1@samuelsmith.org>
 <60a1e1cc5b8b6_11206d20830@natae.notmuch>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <649946ac-b080-7f8b-3777-0be6556547e9@gmail.com>
Date:   Mon, 17 May 2021 13:49:06 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <60a1e1cc5b8b6_11206d20830@natae.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 17/05/21 10.23, Felipe Contreras wrote:
> Personal Sam Smith wrote:
>> One of the essential properties of any good cryptographic system is
>> what is called cryptographic algorithm agility. Without it the system
>> cannot easily adapt to new attacks and newly discovered weaknesses in
>> cryptographic algorithms. Self-describing cryptographic primitives are
>> the most convenient enabler for cryptographic agility. One advantage
>> of signed hash chained provenance logs is that the whole log must be
>> compromised not merely one part of it. Such a log that exhibits
>> agility especially through self-describing primitives is self-healing
>> in sense that new appendages to the log may use stronger crypto
>> primitives which protect earlier entries in the log that use weaker
>> primitives. This makes the log (or any such agile self-describing
>> verifiable data structure) future proof. It is the best practice for
>> designing distributed (over the internet) zero trust computing
>> applications.
> 
> This is way above my pay grade, but let me try to interpret the above.
> 
> If we have a repository with two digest algorithms:
> 
>   2. BLAKE2b (considered non-compromised)
>   1. SHA-1 (broken)
> 
> We may not be confident on the SHA-1 history (1), but as long as we have
> BLAKE2b history (2), we can be confident on that.
> 
> The delta between when SHA-1 was broken, and the switch to BLAKE2b
> happened, is when the repository could be potentially compromised.
> 
> So, it's in the best interest of the repository owners to switch to the
> non-compromised version as soon as possible. In fact, it would be better
> if the switch happened *BEFORE* SHA-1 was broken.
> 
> This is why algorithm agility is important.
> 
> 
> But this is not sufficient, because BLAKE2b could get
> compromised in the future. The repository owners need to be thinking
> ahead to the time, to when they'll need to make yet another algorithm
> switch.
> 
> When such times comes, they need their infrastructure to be able to
> perform the switch as fast as possible. If possible right after they've
> finalized their decision.
> 
> 
> So, if I can summarize your and dwh's proposal: git should be
> cryptographic-digest-algorithm-agnostic.
>

  
But SHA-256 support on Git is still on progress, unfortunately. What if
on someday SHA-1 is broken completely, and we're still not yet switch to
stronger hashes?

Anyway, beside SHA-256 and BLAKE2b, there is also SHA-3 family, which
supports from 224 bits to 512 bits. If Git wants to support SHA-3 hashed
objects, which bit length should we use? I prefer 256 bits, because it's
a nice trade-off between performance (speed) and security (resistance).

> 
> So far this makes sense to me.
> 
> The only problem comes when you consider day-to-day operations, which to
> be honest have been totally uninterrupted by 15 years of using SHA-1.
> 
> At this point it's worth noting that if the git project has a maxim, it
> would be a single word: "performance". Nothing else matters.
> 
> So, if you suggest to switch from SHA-1 to SHA-256, that's fine; as long
> as you can guarantee that *performance* is not affected. This is the
> work brian m. carlson seems to have been doing.
> 
> On the other hand what dwh seemed to suggest is to support every digest
> algorithm on the horizon--without regards of how that would affect
> performance--and as expected that didn't land very smoothly.
> 
> 
> But I don't think the two approaches are incompatible.
> 
> All we have to do is reconcile two facts:
> 
>    1. The ability for users to switch to a new digest is important
>    2. We don't want users to be switching algorithms every other commit
> 
> If git can switch the digest algorithm on a per-repository basis, I
> don't think anybody would have a problem with that.
> 
> Git could support SHA-1, SHA-256, and BLAKE2b as of today. The
> repository owners can decide wich algorithm to choose today, and their
> past history would not be affected.
> 

In reality, many users just use Git that is packaged by the distribution,
and depending on release version of the distro, it can be older than
recent. So we need to also consider that.

> This is future-proof, and would make repository owners be able to make
> that decision, not git.
> 
> If at some point in the future people want to start to get ready for
> SHA-4, that could be introduced to the git core, *before* people want to
> make such transition, and *after* the project has made sure such change
> does not impact on performance.
> 
> Or am I missing something?
> 
> Cheers.
> 

Another remark: currently we roll-out hash algorithms on our own, but
industry best practices said that we should instead use third-party libraries
to do the job (OpenSSL or similar).

The problem of offloading hash algorithm implementation to third-party
libraries is some (or most) distributions camp specific version of library
for usage for several years, with only (backported) bugfix updates are added.
This make algorithm agility is more resistant to do, because we must wait
until ALL distributions supported our objective algorithms in their libraries.

-- 
An old man doll... just what I always wanted! - Clara
