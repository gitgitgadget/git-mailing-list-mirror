Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C0E6C433EF
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 19:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242792AbhLJT2A (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 14:28:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234441AbhLJT2A (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 14:28:00 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5BEC061746
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 11:24:24 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id k37-20020a05600c1ca500b00330cb84834fso9756885wms.2
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 11:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=y3juyUlnIXWXCHlEfotiUDzDFXCysDFHEnPbIR86xck=;
        b=PpeTQhd2EeU/y6CTIoAu3F/UXUOIJiY4YgJGnM7he+in08/Qkn+dnxXL+FLss+Vd4p
         Bh6+LdhcrpReyKElgscDH7ZXs9MNbSnkRC8cnKUef+3jCkA/UJ29K0EOHJK5TVLUKF9+
         BX9H5AAZWu9Z3T0iuHkhesq6aPibTh6rH5+8NgMBiTAPw3ylqoufcr6C+E7d+OVNMTXE
         SvXFjzv7XgbnpOVSiP7tiy4OC1WQcnIhoYvM0An7nB7U7nHFvHUFqhl4rtfp/enFP2QJ
         PTOUYLOyzyWda29XfTgaoExXJVH1aUAw+6GijDuqKvFQtgkz96C4BUKCv0CS/ZFO2bmk
         ik3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=y3juyUlnIXWXCHlEfotiUDzDFXCysDFHEnPbIR86xck=;
        b=pFvWzb5BjSsSfZ3JjDUveDhBeJ3VHyg1QI+7VwSMPwqnv0VjDv2tljJ5H9N1dJLBpb
         IMIot0MBttkaycC3LXXlRo0wTjxRm3ETB61NjGD3f2EwDkUte/gzy89+Bkg6GhPuwfno
         sD4IaH8JyxIO61F/hfT0WKl3awyjuly3Gi9xv5fJyAjbsnZSugwjqGw/3cmNXs19fXHm
         dHpaiMgSu8xneEJ3txg5a2C4FZzBWmVGqwnFGKDPa8Z5Bly+1yonhHcWHKU2GBpuYKX8
         7Xu9r1Ayuqv0YtzmTdX0DKoYKBsNRLZxjUMt69U57Gpixtvasw6Yo2G3OtMTQpcq2Z75
         CAyA==
X-Gm-Message-State: AOAM533VI9LiXW2uLlKiIZzjgbZ8XA1OBxWwIoiVlDI2JcokxwERHF5z
        ME+BA2E2YU6Spukx7ssMqDkGnxHC6hA=
X-Google-Smtp-Source: ABdhPJzUg/n2bxGA5NaatWQiUWVsjsjq7ym9PrnZKyeM3lH7k6lj2Sc6lqXTtRv1aCfgK/YCPYT7ig==
X-Received: by 2002:a7b:cd02:: with SMTP id f2mr18740624wmj.115.1639164263038;
        Fri, 10 Dec 2021 11:24:23 -0800 (PST)
Received: from [192.168.1.201] ([31.185.185.186])
        by smtp.googlemail.com with ESMTPSA id h18sm3630992wre.46.2021.12.10.11.24.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Dec 2021 11:24:22 -0800 (PST)
Message-ID: <e881a455-88b5-9c87-03a8-caaee68bb344@gmail.com>
Date:   Fri, 10 Dec 2021 19:24:21 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH 02/10] range-diff.c: don't use st_mult() for signed
 "int"
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
References: <RFC-cover-00.10-00000000000-20211209T191653Z-avarab@gmail.com>
 <RFC-patch-02.10-bd7d014c531-20211209T191653Z-avarab@gmail.com>
 <YbLL/YWbjc/sPRyH@coredump.intra.peff.net>
 <211210.86lf0sdah1.gmgdl@evledraar.gmail.com>
 <YbM85W3N0ySi5k+H@coredump.intra.peff.net>
 <211210.86czm4d3zo.gmgdl@evledraar.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <211210.86czm4d3zo.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 10/12/2021 12:31, Ævar Arnfjörð Bjarmason wrote:
> 
> [...] 
> I think I was just chasing butterflies making this intmax_t at all. I
> just submitted a v2, and explained that case in a bit more detail in
> https://lore.kernel.org/git/RFC-cover-v2-0.5-00000000000-20211210T122901Z-avarab@gmail.com
> 
> I *think* it fixes all the cases we plausible run into, i.e. storing the
> "cost" in an "int" was enough, we just needed a size_t as an offset. It
> passes the regression test you noted[3].
> 
> The first thing I tried when hacking on this some months ago (I picked
> these patches up again after running into the segfault again) was this
> s/int/ssize_t/ change.
> 
> I don't think using ssize_t like that is portable, and that we'd need
> something like intmax_t if we needed this in another context.
 >
> Firstly it's not standard C, it's just in POSIX, intmax_t is standard C
> as of C99, which and we have in-tree code that already depends on it
> (and uintmax_t).

I'm not objecting to using intmax_t particularly for code that needs to 
store negative values other than -1 but we're already using ssize_t in a 
lot of places so I don't think we need to worry about it not being 
supported.

> But more importantly it's not "as big as size_t, just signed" in
> POSIX. size_t is "no greater than the width of type long"[1]

The full text is

     The implementation shall support one or more programming
     environments in which the widths of blksize_t, pid_t, size_t,
     ssize_t, and suseconds_t are no greater than the width of type
     long. The names of these programming environments can be obtained
     using the confstr() function or the getconf utility.

so "no greater than the width of type long" applies to ssize_t as well 
as size_t.

> and
> LONG_MAX is at least 2^31-1 [2].
> 
> Whereas ssize_t is not a "signed size_t", but a type that stores
> -1..SSIZE_MAX, and SSIZE_MAX has a minimum value of 2^15-1. I.e. I think
> on that basis some implemenations would make it the same as a "short
> int" under the hood.

The minimum value of SIZE_MAX is 2^16-1[1], I'm not sure you can read 
much into the width of ssize_t from the minimum value of SSIZE_MAX. If 
you think about where ssize_t is used as the return value of read() and 
write() that take a size_t as the number of bytes to read/write then it 
would be very odd if ssize_t was a different width to size_t.

Best Wishes

Phillip

[1] https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/stdint.h.html

> On my linux system it's just mapped to the longest available signed
> integer, but that doesn't seem to be a portable assumption.
> 
> 1. https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/sys_types.h.html
> 2. https://pubs.opengroup.org/onlinepubs/009696899/basedefs/limits.h.html
> 
> 3. B.t.w. a thing I ended up ejecting out of this was that I made a
>     "test_commit_bulkier" which is N times faster than "test_commit_bulk",
>     it just makes the same commit N times with the printf-repeating feature
>     and feeds it to fast-import, but the test took so long in any case that
>     I couldn't find a plausible way to get it in-tree).
> 

