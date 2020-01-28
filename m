Return-Path: <SRS0=aR3Y=3R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 693EFC2D0DB
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 20:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 302D421739
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 20:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2i9B++k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgA1Urz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jan 2020 15:47:55 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40085 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbgA1Urz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jan 2020 15:47:55 -0500
Received: by mail-qk1-f195.google.com with SMTP id t204so13992913qke.7
        for <git@vger.kernel.org>; Tue, 28 Jan 2020 12:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CKwRlcu1ErKmVHbhNVuPY3a8e0/cE3Fdf41kOHoGvAc=;
        b=c2i9B++kZ+QBtJKKfOsuqliknMCs1L8+ecdFaf5KS7YJ372c27JDHs6Wk9NhXW5Fee
         s1fmGMEtJSlJHRxxwu5cL8bH47YIJi4qvPBPeeDZEI5BTAcX6jrmdVOb2opV/zEQHa31
         AduMq5KzBBSnWT/NSLnapdALOw+MclsERzFq22EdEvFhNerC6J12sLDmLormHRWifhql
         s93ucukkSRRTmauTKsCC7ITIwHYDJUsHvMK/AuT0X7Eeo/Ge1rxcbLA9VWbjxFcBx6U8
         Oy9E7kpXguKuRSAwi1CB14vCV/AK/Q5ZLaRyJXOfxilIdp9mLV+eu1woDvPfqj6SB10U
         Y+nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CKwRlcu1ErKmVHbhNVuPY3a8e0/cE3Fdf41kOHoGvAc=;
        b=ID/TNf9ukrxDItSLajRJqN8+91hh5z4oTAGFhIkqrlxhzDgZcqrceX/lFuVhCq4ep+
         QVDPrMhReBiCsi5VMbxB5LolpyskZ1eo3PFJYd2shYRWkM1bNaOw2e69LsUr67WLxgkN
         oTN5XwzTPB8ms+VG/hPOWr3mmPeVN01lBTvUvZ/bd0S9Rku8OS8zGNkx5BROGQWqjTlU
         wXntsOYo97w4tIxSjPInqYxtkIZ998HKDGRjHiTdRCEnAN2CiMblmLi+DuN/vD30UTsM
         y4q7VMZ3WOLU7LrA+T0710e7dufQFgvzIHC5humhNhF6cpSZNHPGKCD2Mor8Ye/2LEXR
         ZLDQ==
X-Gm-Message-State: APjAAAWWOTYieZcukatLIqGrzlPjA4q3iyNepJfu+JhBaoGWFkr6Vezr
        WW0KECMScemNzTPFS997CA2RTjPgDQA=
X-Google-Smtp-Source: APXvYqy0CB+iy6LWutKcxXACguZXrf1kGdDu9tB/aWV2lamhRVScJVYLOweQkdyN1ncTjs+6LwxgtQ==
X-Received: by 2002:a37:4b8b:: with SMTP id y133mr24049652qka.210.1580244473181;
        Tue, 28 Jan 2020 12:47:53 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:e5a6:5783:dc66:4486? ([2001:4898:a800:1010:96dc:5783:dc66:4486])
        by smtp.gmail.com with ESMTPSA id d9sm5350519qtw.32.2020.01.28.12.47.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2020 12:47:52 -0800 (PST)
Subject: Re: Sparse Checkout Trouble (2.5.0)
To:     Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     JunkYardMail1 <JunkYardMail1@frontier.com>,
        Git Mailing List <git@vger.kernel.org>
References: <062301d5d0bc$c3e17760$4ba46620$@Frontier.com>
 <d4056731-c13b-c89d-dfd2-e6235e29fed6@gmail.com>
 <405d83bd-cd50-49c5-a068-6d3ce102f669@gmail.com>
 <CABPp-BFB3pN1arWb9Acj7La1aX7j=axANnSWV8f7SmW_KuqD0g@mail.gmail.com>
 <de300697-baba-62a6-ea4c-c5bd472954c2@gmail.com>
 <CABPp-BHRAA71LmfYb61N+qAgwhtii7TSEVJksiAGnnO-4bk2dQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e4bb20e9-ad90-3e9b-7ed2-c7793cb8cb22@gmail.com>
Date:   Tue, 28 Jan 2020 15:47:51 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:73.0) Gecko/20100101
 Thunderbird/73.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BHRAA71LmfYb61N+qAgwhtii7TSEVJksiAGnnO-4bk2dQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/28/2020 12:21 AM, Elijah Newren wrote:
> On Sun, Jan 26, 2020 at 6:09 AM Derrick Stolee <stolee@gmail.com> wrote:
>>
>> On 1/25/2020 3:59 PM, Elijah Newren wrote:
>>> On Fri, Jan 24, 2020 at 7:41 AM Derrick Stolee <stolee@gmail.com> wrote:
>>>> I'm CC'ing Elijah because he also made changes to dir.c, and
>>>> perhaps he has some idea of what's going on.
>>>
>>> If you think it might be related to the dir.c changes, I can take a
>>> look.  I don't have any immediate ideas off the top of my head.
>>
>> The only thing I can think of is that these paths are already
>> marked as sparse, but something is requiring us to test if the
>> path can be created with the filesystem. I'll try to debug
>> more into exactly where that is. It's telling that this happens
>> both in cone mode and without.
> 
> Yeah, I'll take a look.  The exponentially slow 'status --ignored'
> report is forcing me to look at dir.c again anyway, though it's also
> delaying me from getting a chance to look at this particular report.

I made some progress, at least, in root-causing the issue.
The problem bisects down to 4dc42c6c1 (mingw: refuse paths
containing reserved names, 2019-12-21) [1]. CC'ing Dscho.

That commit updates is_valid_win32_path() to fail on these
paths. We were _already_ calling this method even for paths
outside the sparse cone, but the method didn't fail for these
examples.

This means the fix is probably even more complicated: we need
to not call this method when traversing paths that have the
skip-worktree bit enabled. This may lead to some tiny
performance gains when hydrating a very small fraction of a
very large index.

Thanks,
-Stolee

[1] http://github.com/git/git/commit/4dc42c6c1867a52e22f1f04a1a247b5a7538b8af
