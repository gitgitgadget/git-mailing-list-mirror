Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 704E6C433F5
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 19:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F955611CE
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 19:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbhIJTGX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 15:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhIJTGW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 15:06:22 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72CEEC061574
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 12:05:11 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id r18so1932757qvy.8
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 12:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=J2FMJBwcRStpEek1NPBQMEDTNx0kri2S7MLDbYmrG20=;
        b=OEyFloEByGrFXp7U3d+NCeHolHL5mhK8VeuS9WBkp3/OJ3uUpgIHU1c4GlPIQP5786
         4BFmPcHGt8K5M/7sRLowWiSM20FIdhHFhs3nZi9mJd9wI7EyTsbSwwMKNm8sYnNMzoIV
         kKpn5fRv2RNb2RGAZhCKflDLdjKhuj6tjYUQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J2FMJBwcRStpEek1NPBQMEDTNx0kri2S7MLDbYmrG20=;
        b=fay530OjNzuMCRYDKVM7Aumqt6s1ch6DuIz8dXsBvbxEjc0IY27EZAj0TEDsXCQFhN
         XH6pUJQKUQJJVfzNespfBzZYqB15kLMk0eN8ifTmf9xJfxCxxbWQpnhkQ8arbSyUnKmU
         JM7MCYAgiCC0TZiJ0zuWIJhXIIZ8QyU61GNuhgGTD9mIyVPPMLJU8LGdTSELAS/yKc47
         76pSSXtXKOzBQmyGkneyQYuP0PYYjYu+bCpMRTaXNXRwRCZSiEOTU7LGAqh1v0HKtMIP
         tyrneTpKYtmxlRjElfKbfg2xwzsp7gI30eTbwLJPAm/Z0Vg6xxjGG6rA9CcBz5LLISV5
         nqmg==
X-Gm-Message-State: AOAM530zG49pDomqP9UT3+rQX/KBFmK2fWABIz36BjpVMoA5ehVM9Crg
        UWdc6uwX27HMNkRqpv6sprFvZA==
X-Google-Smtp-Source: ABdhPJzSv0DnVGsx05tryTTsiabr8Ebfj2+FwWP1aZVj3HZyhaNMDV+uxg1MwdoR6usBvTPcOkRG9A==
X-Received: by 2002:a0c:8161:: with SMTP id 88mr10103029qvc.20.1631300710216;
        Fri, 10 Sep 2021 12:05:10 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-32-216-209-220-181.dsl.bell.ca. [216.209.220.181])
        by smtp.gmail.com with ESMTPSA id h13sm3965502qkk.67.2021.09.10.12.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 12:05:09 -0700 (PDT)
Date:   Fri, 10 Sep 2021 15:05:07 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v2 0/8] post-v2.33 "drop support for ancient curl"
 follow-up
Message-ID: <20210910190507.k6gxpsdnwtqyog5c@meerkat.local>
References: <cover-0.5-00000000000-20210908T152807Z-avarab@gmail.com>
 <cover-v2-0.8-00000000000-20210910T105523Z-avarab@gmail.com>
 <xmqqbl50tkte.fsf@gitster.g>
 <xmqq7dfotjy3.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7dfotjy3.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 10, 2021 at 10:32:52AM -0700, Junio C Hamano wrote:
> >> This is a follow-up to the already-integrated topic for dropping
> >> support for older curl versions submitted before the v2.33 release[1].
> >
> > To which commit are these expected to apply?  I am having trouble
> > wiggling 5 and 7 in.
> 
> Nevermind.  I seem to be getting garbage from "b4 am", possibly an
> operator error.  I've seen "b4 am" getting confused on a thread with
> multiple versions (like the config-based-hook thing where the
> mixture of Emily's v9 and your v5 for base in the same huge thread
> seem to confuse it).

Yeah, sorry, the thread is not great for figuring out which patch goes where
(there are two v2 versions, one from July and one from today, and a v4 from
July that b4 considers the latest). 

The only solution I can offer is doing "b4 mbox" first, then deleting
everything you don't want, and then doing "b4 am -m that.mbox".

I could add extra heuristics that also looks at series age, but I'm worried
that the "what you get is what you (probably) meant" logic will just get more
and more tortured.

-K
