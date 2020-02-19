Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C1E6C34056
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 20:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BF50207FD
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 20:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oY5faqEp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbgBSUmw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 15:42:52 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39869 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgBSUmw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 15:42:52 -0500
Received: by mail-qk1-f196.google.com with SMTP id a141so1474164qkg.6
        for <git@vger.kernel.org>; Wed, 19 Feb 2020 12:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EWZMjl4KxNIYdW6fHlUUUm7KcK1Yd5CjSVo8vhBqncA=;
        b=oY5faqEp+TVp2XZw9hp6V0qPiqjq+0sRfySNRikFM52Buz08v32lXP91JX0gWzrDUm
         SNLri8JLX5Na5Fje43n59PrPhWZm4jlVy8Id/aDesDoJpTJ2sbgup4pet5S8nkfwC5RY
         NDMrXvv96fmC27W5S84f1Iz55cQ3nfSNdyXjM9q+M7OHYNiujW4W3pnsNS7/5VJnYulh
         Y7jwTAlSDUWgyVU/HM+KASJTcTqnXToOGhNKfrCHwr8f6Q1t17Uj3qZpIxv8cGBeQrQI
         WWxx/sphO9DTnw3F4IPVZ9CECtJ5yr/OGefHnQb0TAvd3D1wBIyRhGIXWqEouTTomzQy
         N/gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EWZMjl4KxNIYdW6fHlUUUm7KcK1Yd5CjSVo8vhBqncA=;
        b=PnKELWxlvLtCD42mHMfQ3xAPTPPMia11Nf9dSvIarr0uXEAFADK5dgacmrf20XvTwG
         IlN7ad5XcppKx8XPeF7WBovIU+uwR+HkyKLXyvvYi99Vpy1uqKDlqxS4be+rWNFErVe5
         dA1FJ5jpp8npP88z7JfMHowIjRsuBlrxAZJaJxsP9WYbkzlrOGBVqr3bQfAkWNA0eGZj
         jdbPvb6ST8yjOKl/YjU6JFNFIHYWJICPYjZART1EfQeLp4erAzfiLkO/CUG5JaZg5O2J
         5gdooc/To5tCShK+2PeOW4X1pwq76FvaTvXsZOBcIfNEVE7OkoPG8q2XOLduLo488q/i
         arxQ==
X-Gm-Message-State: APjAAAUT464J8pDP6JhOHInVATZ049225wOrH3RPGrij9S1Jb3UAd4Jj
        3i7OOtCH2Sc4e8+670WgZIQ=
X-Google-Smtp-Source: APXvYqxKPK2xyoR6G/0SUjHlJ5lynXXp4Sd+SrYBqZbxM2GNaElC5SXfD73LvXu8DClGTEQI9uls7Q==
X-Received: by 2002:a37:5f43:: with SMTP id t64mr24729970qkb.68.1582144969708;
        Wed, 19 Feb 2020 12:42:49 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:5cfd:e9c7:d1b7:62ee? ([2001:4898:a800:1012:e31:e9c7:d1b7:62ee])
        by smtp.gmail.com with ESMTPSA id k29sm611905qtu.54.2020.02.19.12.42.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2020 12:42:48 -0800 (PST)
Subject: Re: [PATCH 1/2] partial-clone: demonstrate bugs in partial fetch
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.556.git.1582129312.gitgitgadget@gmail.com>
 <dbc1bdcae16f8b9941add514264b0fe04cda48c0.1582129312.git.gitgitgadget@gmail.com>
 <CAPig+cSRQXRtSscKUUJBA0NShRQfA=NHohnA2GMRmgbpWr_MvA@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <30d990a4-ed72-93b8-3226-a576246134ee@gmail.com>
Date:   Wed, 19 Feb 2020 15:42:47 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:73.0) Gecko/20100101
 Thunderbird/73.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cSRQXRtSscKUUJBA0NShRQfA=NHohnA2GMRmgbpWr_MvA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/19/2020 1:38 PM, Eric Sunshine wrote:
> On Wed, Feb 19, 2020 at 11:22 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> [...]
>> The tests are ordered in this way because if I swap the test order the
>> tag test will succeed instead of fail. I believe this is because somehow
>> we need the srv.bare repo to not have any tags when we clone, but then
>> have tags in our next fetch.
> 
> This ordering requirement might deserve an in-code comment in the test
> script itself.

Can do.

> More below...
> 
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>> diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
>> @@ -374,6 +374,32 @@ test_expect_success 'fetch lazy-fetches only to resolve deltas, protocol v2' '
>> +test_expect_failure 'verify fetch succeeds when asking for new tags' '
>> +       git clone --filter=blob:none "file://$(pwd)/srv.bare" tag-test &&
>> +       for i in I J K
>> +       do
>> +               test_commit -C src $i &&
>> +               git -C src branch $i
>> +       done &&
> 
> If test_commit() or git-branch fail, those failures will go unnoticed.
> You can fix this by bailing from the loop, like this:
> 
>     for i in I J K
>     do
>         test_commit -C src $i &&
>         git -C src branch $i || return 1
>     done &&
> 
> Same comment applies to the other new test.

Thanks!

-Stolee
