Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58FEEC433DB
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 13:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0994C22AAB
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 13:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729632AbhAENfk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 08:35:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbhAENfj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 08:35:39 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94638C061793
        for <git@vger.kernel.org>; Tue,  5 Jan 2021 05:34:59 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id e2so16351846plt.12
        for <git@vger.kernel.org>; Tue, 05 Jan 2021 05:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=BT+WFSKz5NdOmf5NJJp2o4Ml1urMHBCz5lQa0tj02I8=;
        b=Va9dSK1obYkCAwlHfxDKz1JWlZzGS/eX+OeFar4my70K1uztiLTmNA4E25WROJh3TY
         5nEQXshW1Ur4HpKLdxOZtD9AT2kjkEwesfDIgQ8WiRzG/rDNpIkr7Yfzeuh3cxFXH95F
         h36orz1JVzFKAE8L+oQgPO2re5U/zUpdHuNwJoT3gfMKnCYBfcMSBZ085tOUxXsQi6Q0
         xThfLpgoWwIb7N1JnH0u5bShuSODjnr/WHyZHrjUCvkP1bpr6qdns58v4C2v7DACZRZf
         qtfzOHL5tB1xFzPnNsJ5buw5GzdylRDLCU2qfQzNFG+20whb2tGGhiq0el4dZPc/xpH3
         PKbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=BT+WFSKz5NdOmf5NJJp2o4Ml1urMHBCz5lQa0tj02I8=;
        b=eEzQzJ7ry0PJV6SiORnt5+GLUcpENqcDGE72w7Q3cNXs1Y+lKa/K1APBI/8ZE2CcUt
         cUH+KJ1aLXkG+/OWat4MbNDdr8xb/YLgfw/CnODXuHDZXPc8zxMheKAMcqKczduhIetd
         Ijba1WAT+bedJW1HqOuaHImtTZMfqSpuoGYT7YmOoW4mf2AtPTcEVeS+cw8odvyACb7E
         foY/2KbmAhfupHK7Pps+Ja31VYzOme/WpDnmCouXLh4PlpvhhBedxBZ400jFm/NA5UnJ
         UTP6Fdglz5fuQZnQimFVd+fTL506ia/3TQN2YjVyRyH/fmZzunoFkNSn/IwyU1WNvjJH
         9RoQ==
X-Gm-Message-State: AOAM5310nEldE3pL/+LLiYynV917ovJezcaFkhax6KfWvH/JYoh/Qi/K
        tCvm55fXZYLFMaLmK/RpXAbeqXb8BqOqmw==
X-Google-Smtp-Source: ABdhPJyInegwyoqTS8cRa6/cUJDIBKWJI1TxuVcPFp4K3pOVTZUZfmlps+HAw+OZHnDCtDU4US75qQ==
X-Received: by 2002:a17:90a:13c8:: with SMTP id s8mr4210464pjf.6.1609853699177;
        Tue, 05 Jan 2021 05:34:59 -0800 (PST)
Received: from localhost ([2402:800:63a8:983e:ea74:656b:d810:41f8])
        by smtp.gmail.com with ESMTPSA id ck20sm2870385pjb.20.2021.01.05.05.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 05:34:58 -0800 (PST)
Date:   Tue, 5 Jan 2021 20:34:56 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: test-tool: bloom: generate_filter for multiple string?
Message-ID: <X/RrAAXsQXdMJbpo@danh.dev>
References: <20201231035438.22533-1-congdanhqx@gmail.com>
 <dfe3fbf9-4708-cd53-d78e-780375224b8e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dfe3fbf9-4708-cd53-d78e-780375224b8e@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-12-31 06:31:52-0500, Derrick Stolee <stolee@gmail.com> wrote:
> On 12/30/2020 10:54 PM, Đoàn Trần Công Danh wrote:
> > I'm reading the code for Bloom Filter to see if arXiv:2012.00472
> > could be an improvement.
> > 
> > I'm not sure if I'm missing something or it's our test-bloom generate_filter
> > doesn't really support testing for multiple inputs.
> 
> It doesn't support creating a _realistic_ filter of the given size. The tests
> at this level are more about keeping the filters consistent so we can trust
> that we are not accidentally changing the hashing algorithm and its file format.

(Sorry for this late reply)

Yes, make sense.

> The test works if we provide multiple inputs, the problem is that the resulting
> filter has a higher density of bits than we expect, since we didn't size it
> according to the number of inputs.

OK.

> > If I understand correctly, we should either:
> > * allocate more entry for inputs; or
> > * abort if argc != 3
> 
> Either approach would be fine. I wonder what your goal is for testing the
> multiple inputs. Are you expecting a larger filter to demonstrate some
> behavior that is not tested by a small filter?

I was expecting a larger filter to trying with some ideas that I had
in mind before implement it in real code.
However, after toying with my idea, I think it's more of a solution
looking for problem.
(The original post was posted before I realised that).

> > diff --git a/t/helper/test-bloom.c b/t/helper/test-bloom.c
> > index 46e97b04eb..1026facc59 100644
> > --- a/t/helper/test-bloom.c
> > +++ b/t/helper/test-bloom.c
> > @@ -68,12 +68,14 @@ int cmd__bloom(int argc, const char **argv)
> >  	if (!strcmp(argv[1], "generate_filter")) {
> >  		struct bloom_filter filter;
> >  		int i = 2;
> > -		filter.len =  (settings.bits_per_entry + BITS_PER_WORD - 1) / BITS_PER_WORD;
> > -		filter.data = xcalloc(filter.len, sizeof(unsigned char));
> >  
> >  		if (argc - 1 < i)
> >  			usage(bloom_usage);
> >  
> > +		filter.len = (settings.bits_per_entry * (argc - 2) + BITS_PER_WORD - 1)
> > +			/ BITS_PER_WORD;
> > +		filter.data = xcalloc(filter.len, sizeof(unsigned char));
> > +
> 
> Whitespace issues aside, this is the right approach to make the filter grow with
> the input.
> 
> >  		while (argv[i]) {
> >  			add_string_to_filter(argv[i], &filter);
> >  			i++;
> > diff --git a/t/t0095-bloom.sh b/t/t0095-bloom.sh
> > index 7e4ab1795f..6d83927c86 100755
> > --- a/t/t0095-bloom.sh
> > +++ b/t/t0095-bloom.sh
> > @@ -67,6 +67,17 @@ test_expect_success 'compute bloom key for test string 2' '
> >  	test_cmp expect actual
> >  '
> >  
> > +test_expect_success 'compute bloom key for multiple string' '
> > +	cat >expect <<-\EOF &&
> > +	Hashes:0xb270de9b|0x1bb6f26e|0x84fd0641|0xee431a14|0x57892de7|0xc0cf41ba|0x2a15558d|
> > +	Hashes:0x20ab385b|0xf5237fe2|0xc99bc769|0x9e140ef0|0x728c5677|0x47049dfe|0x1b7ce585|
> 
> Multiple hash outputs work already, helping us build confidence that our
> hash algorithm hasn't changed.
> 
> > +	Filter_Length:3
> > +	Filter_Data:45|ba|ac|
> 
> And this is the part of the output that you are changing.
> 
> > +	EOF
> > +	test-tool bloom generate_filter "Hello world!" file.txt >actual &&
> > +	test_cmp expect actual
> > +'
> > +
> 
> So, your suggested change has merit. I just wonder what value it provides on top
> of the current implementation? If your goal is to create a way to inspect a full-sized
> filter, then that would be interesting to explore.

Yes, originally, I was trying to creat some way to inspect a full-size
filter, i.e. a bloom filter for some set of object_id during fetch
negotiation.
But, I realise it's not a good idea, now.

-- 
Danh
