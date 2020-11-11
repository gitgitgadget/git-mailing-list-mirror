Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7790DC388F9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 12:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B68D206FB
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 12:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=theori-io.20150623.gappssmtp.com header.i=@theori-io.20150623.gappssmtp.com header.b="LcjtBln/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgKKMaf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 07:30:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgKKMaf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 07:30:35 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1668AC0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 04:30:35 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id f18so1351184pgi.8
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 04:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=theori-io.20150623.gappssmtp.com; s=20150623;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DcvEqspQg6v8GyTJkXl+Sb/MCLh2kXms83lC8aetFZo=;
        b=LcjtBln/qsBEYztoZ55QkuuYk7Tg0bWvOayfI6HskGymdVCx6fHGaaQTn2juosJCMY
         eF+EwJqYldI/MfgNKWcmBclB6I07gdC12CH1VRwW7ScKI/IYZKMSnJyhoisu8iUFaH/c
         94bem+m0m09d1EXQidVokTzCsFHsTB/jOY/LTy7KmcHZAdEngm0zBO3+Ka5frvlzmjUo
         yjn68fTTfoVIiumX8Ffu8iRc0+KlofIaSWIHdCNdDA6rxnnpMoT8OGZpnlyP64jtZQkQ
         auvsNpKCA2PWZO5TeAH6aduwHj7XpohRpTkyVMWg+YhLI2m9Di2gAlmVvIT64KjQ3ABS
         /C2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DcvEqspQg6v8GyTJkXl+Sb/MCLh2kXms83lC8aetFZo=;
        b=TWYyJYjI4R/vaU3qywGnB+hyOsOrCr/Wk/4AoUcuRa5J/bWBp8/LLAqK9vwudfzDjS
         LVq+Tq14M7xmiTY4zSPX/6EdlXI2C5INoXkkkFcydtwinuEv087SVZDMGhdnF6YxDPPa
         kBHWtKW0jKY4dS5MgMLFf6SbVXYP3pFoBJt0HQIKT0OqLqleddmbDZwH1TYcCFpFdIU+
         Yvro6FnACkLyBux2i/FlP3424F8bffPudGxzbYsJNZ1hxdlOKwbgBmhc2V1z6YoWDqx2
         K1FWquwlTuEA72ZvsgOLYEMZbG+ZfnTqyKGurEVzgoSknvmuBAvU1Zvaoe3HixLsnj83
         Eo6g==
X-Gm-Message-State: AOAM531RQUHDoFrM01/Abfp3cuCl1A+fa9/URVjsSZTvfNfE+KCVvuqD
        8bHg++O0osb6g/IhFBjsZGuh8Ic1pJzULVB6
X-Google-Smtp-Source: ABdhPJxCyRv9bHKLwy0vCz/KxW0ygcJFA0Hc+YNu0/ha/vxPOxkoUFcbLzUVj07j4sr8bXzmA8OivA==
X-Received: by 2002:a65:47ca:: with SMTP id f10mr20523026pgs.298.1605097834164;
        Wed, 11 Nov 2020 04:30:34 -0800 (PST)
Received: from [127.0.0.1] ([14.33.99.107])
        by smtp.gmail.com with ESMTPSA id u5sm2456355pgj.28.2020.11.11.04.30.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2020 04:30:33 -0800 (PST)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <junio@pobox.com>, git@vger.kernel.org
References: <aeb24944-17af-cf53-93f4-e727f9fe9988@theori.io>
 <xmqq4km4lppy.fsf@gitster.c.googlers.com>
 <a0513d6f-1f69-683d-d6c5-75b17b8b6890@theori.io>
 <a096d122-52a3-700a-3a14-30a81b099cd8@theori.io>
 <137f0fc1-fbd9-a62c-bd52-cffd26c364bf@theori.io>
 <nycvar.QRO.7.76.6.2011101638080.18437@tvgsbejvaqbjf.bet>
From:   Jinoh Kang <luke1337@theori.io>
Subject: Re: [PATCH v4] diff: make diff_free_filespec_data accept NULL
Message-ID: <01640022-5bda-9712-8228-501374474d5f@theori.io>
Date:   Wed, 11 Nov 2020 12:30:28 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101 Firefox/78.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2011101638080.18437@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/10/20 3:38 PM, Johannes Schindelin wrote:
> I had suggested an improvement for this hunk as well as for the test case.
> Fell through the cracks?

You guessed it right. My apologies.

> +test_expect_success 'difftool --cached with unmerged files' '
> +	test_when_finished git reset --hard &&
> +	echo base >file &&
> +	git add file &&
> +	git commit -m base &&
> 
> This does not advance the committer date. Let's just use the helper
> function we invented to make this much easier:
> 
> 	test_commit base
> 
> This has also the advantage of already tagging the outcome.
> 
>> +	git checkout -B conflict-a &&
>> +	git checkout -B conflict-b &&
>> +	git checkout conflict-a &&
>> +	echo conflict-a >>file &&
>> +	git add file &&
>> +	git commit -m conflict-a &&
>> +	git checkout conflict-b &&
>> +	echo conflict-b >>file &&
>> +	git add file &&
>> +	git commit -m conflict-b &&
>> +	git checkout master &&
>> +	git merge conflict-a &&
>> +	test_must_fail git merge conflict-b &&
>> +	: >expect &&
>> +	git difftool --cached --no-prompt >actual &&
>> +	test_cmp expect actual
> 
> Shouldn't this use the `test_must_be_empty` function instead?
> 
> How about writing the test case this way:
> 
> test_expect_success 'difftool --cached with unmerged files' '
> 	test_when_finished git reset --hard &&
> 
> 	test_commit conflicting &&
> 	test_commit conflict-a a conflicting.t &&
> 	git reset --hard conflicting &&
> 	test_commit conflict-b b conflicting.t &&
> 	test_must_fail git merge conflict-a &&
> 
> 	git difftool --cached --no-prompt >out &&
> 	test_must_be_empty out
> '

The original test code was copied from the "difftool --dir-diff with
unmerged files" case above.

It might be worth cleaning it up too, but let's leave it for another
time.

I'm keeping the return-early code as per Junio's request.

-- 
Jinoh Kang
Theori
