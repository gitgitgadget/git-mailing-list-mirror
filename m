Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2725BC4361B
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 22:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02B8623D1F
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 22:11:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388609AbgLIWLf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 17:11:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388532AbgLIWLf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 17:11:35 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88DAC0613CF
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 14:10:54 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id d8so2981076otq.6
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 14:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Xqhus1ApMhUx+k1U2AMt44E+uB0uJI2S45B3q8JAvng=;
        b=NfsB1IITB/p2fgYnINnRksyMF59c+ILJnR76YWUAnjMNSt2uHDPriVTxW3eoPj55jY
         jqWu99DkudJ3hsquPbGp8ZYqtnlmAeSDU4hqLDeoBg0SAi+lgFNl3BlbPJU0QePgKeLM
         UYhYGiOFtsIFVQI0gUHSMAU/O0lhvixEzcZAis36FEfJXDPUNMW1JKhmi/qt41weH503
         OUoM7RPDji6P7Ir7GkSh5lMvtP7iTmzq2F1Oo9UO8NLFHSI10sCfw4olLvg1+BvEAsuw
         THwnZSNgz8P1Uei9W5BKgyPhH/IgsQACPDuccqW50vExEaDQ6DdYe3FkqEptVD8OafKA
         7AZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Xqhus1ApMhUx+k1U2AMt44E+uB0uJI2S45B3q8JAvng=;
        b=JC6veWKMUipDra8FrKVPAC00XkSrUD3NsUe2uvO4kYPCSbQEz97bbjI5/ebo8i1IdB
         CcHsfw9BjdJDy3YI6WMXWWf1o9nuQOn8iMQm3RLwWkDtC1suG/GI0f6Q3t1Y52S4gSQT
         xByXKFuZACViZHOz01vcs0LnDlnIt5vnANeKQdxFTnBwRBRt4maWPslaxFsXVmkn03E7
         yRIZd8e8GyeEdiOwI4kjukPBtk6w3t7tcUby+UGAH224AEaMOP+eMLNPUiOKvoHYTqvu
         O4JYGP4H8+/7NSt8r9RJGnC0tRfckFKmQpBzmQz7aVhXgG+NnGTVbT4rxjnC/vPxrh5M
         84Iw==
X-Gm-Message-State: AOAM532SH1eXEVqlazeuVEL2yQZfSvYi/D8tTUXTP4i62ukpNy1trivZ
        9S4x3yoAYLFbK4We1ujPr4cf5g==
X-Google-Smtp-Source: ABdhPJwoLGK3hX0/GYioTPd5GZQD+IGB9+CjhaUoSlsvRMsUv1F7qnxoKQ80B6XflQELT8PCqqU7RA==
X-Received: by 2002:a9d:12c:: with SMTP id 41mr3624732otu.77.1607551854003;
        Wed, 09 Dec 2020 14:10:54 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id i25sm657515oto.56.2020.12.09.14.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 14:10:53 -0800 (PST)
Date:   Wed, 9 Dec 2020 17:10:50 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/7] diffcore-rename: remove unnecessary if-clause
Message-ID: <X9FLaiuWpYely6es@nand.local>
References: <pull.929.git.git.1607223276.gitgitgadget@gmail.com>
 <f96bb36930a6e5e42f0d3b9c5dfa3b2cc27c1f9d.1607223276.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f96bb36930a6e5e42f0d3b9c5dfa3b2cc27c1f9d.1607223276.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 06, 2020 at 02:54:31AM +0000, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
>
> diffcore-rename had two different checks of the form
>
>     if ((a < limit || b < limit) &&
>         a * b <= limit * limit)
>
> Since these are all non-negative integers, this can be simplified to
>
>     if (a * b <= limit * limit)

Makes sense.

> The only advantage of the former would be in avoiding a couple
> multiplications in the rare case that both a and b are BOTH very large.
> I see no reason for such an optimization given that this code is not in
> any kind of loop.  Prefer code simplicity here and change to the latter
> form.

If you were really paranoid, you could perform these checks with
unsigned_mult_overflows(), but I don't think that it's worth doing so
here.

> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  diffcore-rename.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/diffcore-rename.c b/diffcore-rename.c
> index 68ddf51a2a1..0f8fce9293e 100644
> --- a/diffcore-rename.c
> +++ b/diffcore-rename.c
> @@ -450,9 +450,8 @@ static int too_many_rename_candidates(int num_targets, int num_sources,
>  	 */
>  	if (rename_limit <= 0)
>  		rename_limit = 32767;
> -	if ((num_targets <= rename_limit || num_sources <= rename_limit) &&
> -	    ((uint64_t)num_targets * (uint64_t)num_sources
> -	     <= (uint64_t)rename_limit * (uint64_t)rename_limit))
> +	if ((uint64_t)num_targets * (uint64_t)num_sources
> +	    <= (uint64_t)rename_limit * (uint64_t)rename_limit)

One small nit here (and below) is that not all of these need casting.
Only one operand of each multiplication needs to be widened for the
compiler to widen the other, too. So, I'd write this instead as:

> +	if ((num_targets * (uint64_t)num_sources) <=
> +     (rename_limit * (uint64_t)rename_limit))

or something. (I tend to prefer the cast on the right-most operand,
since it makes clear that there's no need to cast the "first" operand,
and that casting either will do the trick).

>  		return 0;
>
>  	options->needed_rename_limit =
> @@ -468,9 +467,8 @@ static int too_many_rename_candidates(int num_targets, int num_sources,
>  			continue;
>  		limited_sources++;
>  	}
> -	if ((num_targets <= rename_limit || limited_sources <= rename_limit) &&
> -	    ((uint64_t)num_targets * (uint64_t)limited_sources
> -	     <= (uint64_t)rename_limit * (uint64_t)rename_limit))
> +	if ((uint64_t)num_targets * (uint64_t)limited_sources
> +	    <= (uint64_t)rename_limit * (uint64_t)rename_limit)

Same notes here, of course. I was hoping that we could only do this
multiplication once, but it looks like limited_sources grows between the
two checks, so we have to repeat it here, I suppose.

Thanks,
Taylor
