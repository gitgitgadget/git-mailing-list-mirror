Return-Path: <SRS0=sGv9=AK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A21CC433E0
	for <git@archiver.kernel.org>; Mon, 29 Jun 2020 20:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFBED20724
	for <git@archiver.kernel.org>; Mon, 29 Jun 2020 20:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CW4ny/hR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731078AbgF2Uz3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731298AbgF2TNM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jun 2020 15:13:12 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A04C0076FF
        for <git@vger.kernel.org>; Mon, 29 Jun 2020 04:30:14 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id 95so4477003otw.10
        for <git@vger.kernel.org>; Mon, 29 Jun 2020 04:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jbT2lz08BbBN++6i69jwcxmDoUg4B+JqZOE/gox0Ezw=;
        b=CW4ny/hREzNGH3KMlDUCoM43OcNzDU31eANl7Z1igM1n7Wwf/Jdy/f1VuVb9zmI88o
         6IOflcCEEdM4EfT8ORZCHbudMKHyZsvOfGbTN1uAP7t+lkG2Fw/5ST1Vr3O83M5rC7Oz
         btSVit6oahrIobYxH1qAqZsuK7UuDbsPoGSLTqwDBH40VU8rg50yQ8YvQCz+AW84+mFD
         goL9Hzqm33nqB4kFTWTXTG5QdurTylS95d8zdiure3cRP5ZUyvfLvcv4u/o02OTDlgK5
         yKNjRP0EaiCIPgFyEzd4JNOWTUPgRB0ULyBSeXdB6owPHDygj22jGg9+QxokKxt2e0CO
         8vng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jbT2lz08BbBN++6i69jwcxmDoUg4B+JqZOE/gox0Ezw=;
        b=oaiwfqguyriI0qwtu3G6J7rMWSXBY1I6dsz9+ZQ26ShipG5MaW1MzqNKVzhLMc3o1t
         LLivnWuidulQ6jbolfOHkn7DrjDPq3SzJFh1OmZWVpJyEI5FTu3tbjNSRGbKMxChCOc/
         M0WXRcew9WR8TvS9X9FPplR9jhCW9hj0tk6fcC+wJ02odZCJxDDfBI+Ahf8tLkRncu/b
         EdwuE1laCW7n23lPPni8ZB1SU+iwDozQ8rXmGA6Pf/eOneOKStaAEGHGk3MUpKKI2Ts8
         Z7U5Jh/XO46IRViLmBEWJacYVhHGlRxlmlFC/ax6PxSkvXsjrzQhqoT2PaJGOBmotGdj
         0npw==
X-Gm-Message-State: AOAM533rImAoYlTbOfJk9WojhtTyaNEeJut/yFYoew4X6fRg1khia4fK
        LpD2iJoAlgkgGN3q5qbcJCc=
X-Google-Smtp-Source: ABdhPJwvip3cVpmNyW3QOAtfTx50VZBVbAJPDGBCFsZsdEwHNpkbhZcc4WD2HcNepcnVxR9buADIZQ==
X-Received: by 2002:a9d:62da:: with SMTP id z26mr13478990otk.369.1593430214084;
        Mon, 29 Jun 2020 04:30:14 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id 89sm6396916otp.3.2020.06.29.04.30.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2020 04:30:13 -0700 (PDT)
Subject: Re: [PATCH 04/34] commit-slab: add a function to deep free entries on
 the slab
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>,
        Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>
References: <20200529085038.26008-1-szeder.dev@gmail.com>
 <20200529085038.26008-5-szeder.dev@gmail.com>
 <8030939b-44fe-e251-5b76-2b2f260b980f@gmail.com>
 <20200627155610.GN2898@szeder.dev>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b2fa923f-adf2-9cc8-7f4a-80a08aaf346f@gmail.com>
Date:   Mon, 29 Jun 2020 07:30:12 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <20200627155610.GN2898@szeder.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/27/2020 11:56 AM, SZEDER Gábor wrote:
> On Thu, Jun 04, 2020 at 12:43:32PM -0400, Derrick Stolee wrote:
>> On 5/29/2020 4:50 AM, SZEDER Gábor wrote:
>>> +void free_depth_in_slab(int **ptr)
>>
>> This needs to be "static" to compile with DEVELOPER=1.
> 
> You are right, of course, but...
> 
> Do you get an error because of this when building with DEVELOPER=1?  I
> don't get an error when building with DEVELOPER=1...

Yes, I believe that's how I discovered it.

>> (I'm working to apply your patches on top of ds/line-log-on-bloom
>> so we can get the benefit of these universally-good things. I just
>> want to report the things that I stumble on.)
> 
> Thanks.

Sure thing.
-Stolee

