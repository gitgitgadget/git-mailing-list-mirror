Return-Path: <SRS0=tECa=DD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC30C4727C
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 01:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08813207EA
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 01:53:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y32yIYky"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729623AbgIZBxA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 21:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbgIZBw7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 21:52:59 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD361C0613CE
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 18:52:59 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id s19so242281plp.3
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 18:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AJV42CZRsxtpxg1/gk3qBuZKbU4mIlfxZTPhfga2SL4=;
        b=Y32yIYkyTadNcXgNpTga0TOOc87Jll6WKZpKAeXjfPN9+T6Vw4HLcg1wO36rl5/jVQ
         qZkjegY0E2e63k1SBnJcV5lHXzhD/oq7wvs6MCdEQtZbKOMtGWZPv3qLMZp1XAxzKYSa
         amLv1mkzeg87FIj5mcWw8CDeHvZY55NlM1bLW72UHkGmOJZm6G9e9f851jJbRVrM2VFj
         xSdvcVjlcfmbeBn8ZlXq0r0jZr8hNJVSHDYp8YmN6OGWkwv2bu3nWjsbQ+e2hkVk4D3o
         TrtaSDVaDIyb/JbYzwjz2jcHCl7ALLsJpfQFSLFwGJ3brbrK1wIJoCOcrqNopFKpp8fz
         HWhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AJV42CZRsxtpxg1/gk3qBuZKbU4mIlfxZTPhfga2SL4=;
        b=q1P1xvOumKNNtnA2gSp7jbRA+2KdM7YNhSTAY/De4QQLELjAbZ+GAaylGtq7JylJuS
         ZypMZGc2Qp5gyqsH6UmAYEtoexnAcWS/JiSvwbDfarBM86ScFuxEWZ8481ya4t+9a/n8
         l0ToTSR8W0xAN69lYTDBz6P+cTxfBFG4peLZBnVqz03PCX9hi1viqdGsxfiIahjcP7Uh
         RiarQotxMCXjt97ruDE7AZbjeQ8BzaubOYb3vPI/d265AyPLoRzgwMEVB8o8mwtoSxn/
         j6Pk6A+/BPjNFYalvwyoGeDYMY8AybNzUubxPxyb1Y9sE5neUp7ZCbNGkdcErQHdEmOJ
         Gfbw==
X-Gm-Message-State: AOAM532i1YXOkVieaFk4ZJfT7vNkWwdbNW99UhPI2SCL3ffKxl857GJ3
        fgC8esqB04TTQZtT/U1uFFAyQFKO03M=
X-Google-Smtp-Source: ABdhPJzqlgbZD4MT06z9YNbN8F4MOS7C5mFmQCWXNv1AGi/dftzeReVkBBP6Ha/IW9J5OeNrJqjqFg==
X-Received: by 2002:a17:90a:db0f:: with SMTP id g15mr312041pjv.145.1601085178893;
        Fri, 25 Sep 2020 18:52:58 -0700 (PDT)
Received: from generichostname ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id j20sm3613815pfh.146.2020.09.25.18.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 18:52:57 -0700 (PDT)
Date:   Fri, 25 Sep 2020 18:52:56 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v3 09/10] builtin/diff-tree: learn --merge-base
Message-ID: <20200926015256.GA136085@generichostname>
References: <20200918104833.GB1874074@generichostname>
 <xmqqy2l7m3hk.fsf@gitster.c.googlers.com>
 <20200920110148.GA227771@generichostname>
 <xmqqzh5jf73t.fsf@gitster.c.googlers.com>
 <20200921172740.GA946178@generichostname>
 <xmqqwo0met17.fsf@gitster.c.googlers.com>
 <20200921215409.GA1018675@generichostname>
 <xmqqblhyepup.fsf@gitster.c.googlers.com>
 <20200923094716.GA1309694@generichostname>
 <xmqqh7rlk1t8.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh7rlk1t8.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, Sep 25, 2020 at 02:02:11PM -0700, Junio C Hamano wrote:
> Denton Liu <liu.denton@gmail.com> writes:
> 
> > And worst case scenario, if we receive user reports that they believe
> > the feature is inconsistent, it's 100x easier to change it to allow
> > ranges than attempting to remove support for ranges in the future.
> 
> If we allow ranges from day one, we do not even have to worry about
> it, no?

Yes, but I'm worried that being able to mix --merge-base with ranges
might cause more confusion for users since, in my opinion, it only
really makes sense for endpoints. That's why I restricted it in the
first place.

I think that since we're in disagreement, it makes more sense to take
the safer option where we can implement functionality later whereas if
we implement it and we want to remove it later, it'll be a much harder
time.

Thanks,
Denton
