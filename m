Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55C7C433DF
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 20:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B4B8207FC
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 20:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="ONKml080"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbgHDUMu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 16:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbgHDUMu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 16:12:50 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05CF9C06174A
        for <git@vger.kernel.org>; Tue,  4 Aug 2020 13:12:50 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id a19so13687377qvy.3
        for <git@vger.kernel.org>; Tue, 04 Aug 2020 13:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fWZzzJKrJegaPQGxkFCrEtMYcQzfmJNDdkz3A7Cnqg4=;
        b=ONKml080HwvbZWx/jUZProav/z6mpybWNqxizOih+my0uBstt35B7rm5kwmWjKyehe
         38hoXQ6rCm1WWFeNH41WAGa/WZUXhEVwTi03vhlxknDlmIa7mkVYFRGJ+ZfwjS50WqB0
         lVSKNo64Jldrxc0WhPoaxr0kYIqd4VAtxLQrxVA91pb2ZOwUYGYsEFrS4IIDcUx9SBXd
         EXhg4YpxBpjkPduuW9UxlpCW8U1bK+D+4fcZKRyNtqhx5FyvKhXl4Gq91SDONSwY722V
         4doTNBuTuVgGz+xtm3yEOicL0m3N5heeLSV98vhgDPp5CNU8wSFCqnA5r/H/ss63NdL+
         uyzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fWZzzJKrJegaPQGxkFCrEtMYcQzfmJNDdkz3A7Cnqg4=;
        b=sl9TL3jM0pmfH9Sot7YJ9luTBABW/zxATkfqvgTDwTfRJXqVI77akZn9OZfalKum1+
         i+NKPMmdZuDxsCFcftbnizyW1XNpEOqOkqbRFiPRX+NoZCeH5iRZ5WF0/ZQJw8V4sitm
         FV5ynpkHw3K1fZwofKrtg46NH/avOcnA6eJvfjer5VJDdabrfjIrmWidSaolGXFtb0L+
         1sPnuTPbSmKyvx9lqxkS+iX+rFCR7V571EFYoeHUbH1R5Y95wYl8smcpkpj1YPd0CWWv
         8cobWfEbt0SKEL3tscY2FOatVN/UbZof0Iq+ISaO/+ZwHIq0iE545GYnwWBqEm1LzrMu
         5gfw==
X-Gm-Message-State: AOAM531Ki0xBgWt+X+vs9zzGDXAejdillGDfjg1OUk/LBi1W2pHxuWpQ
        EYmPBvmPdpUXRNYQk5YVQ9fNxQ==
X-Google-Smtp-Source: ABdhPJymw9mhVK0a8/dqCrdNy3hf+ypxiPsScuM7b44qR2fuZsR3F7WGqui9UJlZj0i+dCKT4nL4Aw==
X-Received: by 2002:a0c:9e4e:: with SMTP id z14mr72130qve.71.1596571969142;
        Tue, 04 Aug 2020 13:12:49 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:4176:744b:cf1a:a7e1])
        by smtp.gmail.com with ESMTPSA id d20sm21145136qkk.84.2020.08.04.13.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 13:12:48 -0700 (PDT)
Date:   Tue, 4 Aug 2020 16:12:47 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net,
        dstolee@microsoft.com
Subject: Re: [PATCH 08/10] bloom: split 'get_bloom_filter()' in two
Message-ID: <20200804201247.GD89277@syl.lan>
References: <cover.1596480582.git.me@ttaylorr.com>
 <a494094c10f9bddca5743973409ccb4540841116.1596480582.git.me@ttaylorr.com>
 <c54cc9a8-322c-6235-4170-228354c1ff33@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c54cc9a8-322c-6235-4170-228354c1ff33@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 04, 2020 at 09:00:31AM -0400, Derrick Stolee wrote:
> On 8/3/2020 2:57 PM, Taylor Blau wrote:
> > 'get_bloom_filter' takes a flag to control whether it will compute a
> > Bloom filter if the requested one is missing. In the next patch, we'll
> > add yet another flag to this method, which would force all but one
> > caller to specify an extra 'NULL' parameter at the end.
> >
> > Instead of doing this, split 'get_bloom_filter' into two functions:
> > 'get_bloom_filter' and 'get_or_compute_bloom_filter'. The former only
> > looks up a Bloom filter (and does not compute one if it's missing,
> > thus dropping the 'compute_if_not_present' flag). The latter does
> > compute missing Bloom filters, with an additional parameter to store
> > whether or not it needed to do so.
> >
> > This simplifies many call-sites, since the majority of existing callers
> > to 'get_bloom_filter' do not want missing Bloom filters to be computed
> > (so they can drop the parameter entirely and use the simpler version of
> > the function).
>
> > +struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
> > +						 struct commit *c,
> > +						 int compute_if_not_present,
> > +						 int *computed)
>
> Could we further simplify this by letting "computed" be the indicator
> for whether we should compute the filter? If "computed" is NULL, then
> we won't compute it directly. This allows us to reduce the "1, NULL)"
> to "NULL)" in these callers:

I like what you're getting at--that is, that we shouldn't make calling
this more complicated than necessary, and right now lots of callers
always pass "1, NULL)" as the last two arguments--but I'm not sure that
I like this suggestion.

I could imagine a future caller would want to compute the Bloom filters
if missing, but not care about whether or not they were computed from
scratch. In that case, they'd need a dummy variable. Not the worst thing
in the world, but I think it's less clear.

By the way, I think that this suggestion only helps for "0, NULL" into
just "NULL", not "1, NULL" (which requires a dummy variable with your
suggestion).

>
> > +			struct bloom_filter *filter = get_or_compute_bloom_filter(ctx->r, c, 1, NULL);
>
> > +	filter = get_or_compute_bloom_filter(the_repository, c, 1, NULL);
>
> Thanks,
> -Stolee

Thanks,
Taylor
