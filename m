Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F76EC433EF
	for <git@archiver.kernel.org>; Fri,  6 May 2022 02:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241822AbiEFC4W (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 May 2022 22:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388390AbiEFCz7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 May 2022 22:55:59 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E87463BF1
        for <git@vger.kernel.org>; Thu,  5 May 2022 19:52:10 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id t11so5018933qto.11
        for <git@vger.kernel.org>; Thu, 05 May 2022 19:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tcLdnF2AbRtBP0cd+m1kjjMM/LhplIy28ucaq++2raA=;
        b=COL0n4+rgGJ2SCtg6/RKJVC4XzVXnmVlEF8GocW+mUCG+XkAk88VwMXYYbXk6Ce5tO
         YYomFDBUu3M72ItN0lXw2XVEE5xJsFB2HpRSa0X7At+qU/Qv4Um/ojjehGnrUkCnXkK6
         MujacavgIgaRX0x/5y6On8PcndDDFSCNgGICtKkCvgYBWPEBibLiZbDKrxPIvnH10lfr
         sI5bw6hNc0gUkrT8qaL+V7xkApla+EGt1PqHf8bUmDju/4W5MF1Q85LpIKM5m9+d1ij0
         ApEZNG5zUjbGdVLSPlUNs/P5DloMKWcNlIsGY6oRls+e0KezevksDGjFC62tem/d4pJl
         VCRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tcLdnF2AbRtBP0cd+m1kjjMM/LhplIy28ucaq++2raA=;
        b=KwZ++z8UWo+35HRH0Wu+Y7J8PrE3/Obs1VYW+EyhbMbTv/EhuBXdx1acRKpooG3hMW
         aLLOZOpScE1hRpFLJnrL91nQgpTumvrobYs3hbzetONgsu5WhOjix8IIcFJk8TospZeQ
         l/dWdSohvro5hiXZa/85sm/uMEi5to83L/p6Yhju4zAqNOO1p4ttpF1g40OqZ1Y24vsN
         JwiZ9MYS12qNDdfCdJFciYkY1h5AVlA5vg3ZylV9DphfVT5esH2HSS1306nL/iuBAA+6
         w+16Rsbgk3AEFh34q4e6v1snnSHk0Lf2xxHbkznMmeFLowO5zQ0nA8DNGd/m8RYjW7rx
         q+ng==
X-Gm-Message-State: AOAM532Wfbn61MHM4j1J0TrGC/OWzRrp6pTcj9t1nb1G8QoEHc/fPBXL
        IIVlUZhp397gFYsLt1rMH7CZDQ==
X-Google-Smtp-Source: ABdhPJy0igEDHL0VR/T8/cvQlM44NhaC8FrUeUxooUAYV5dTcrwNU9lBf6Dx1PoK83SW2ozxSjM0YQ==
X-Received: by 2002:a05:622a:1814:b0:2f3:b073:760 with SMTP id t20-20020a05622a181400b002f3b0730760mr1023566qtc.628.1651805529774;
        Thu, 05 May 2022 19:52:09 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id o27-20020a05620a15db00b0069fc13ce203sm1750597qkm.52.2022.05.05.19.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 19:52:09 -0700 (PDT)
Date:   Thu, 5 May 2022 22:52:08 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Chris Down <chris@chrisdown.name>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Christian Couder <chriscool@tuxfamily.org>, kernel-team@fb.com
Subject: Re: [PATCH v2 1/2] bisect: output state before we are ready to
 compute bisection
Message-ID: <YnSNWMBRZA0S8X26@nand.local>
References: <cover.1651796862.git.chris@chrisdown.name>
 <11edd3e4dbaac7fada8a3bcd43f4bbd353087637.1651796862.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <11edd3e4dbaac7fada8a3bcd43f4bbd353087637.1651796862.git.chris@chrisdown.name>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 06, 2022 at 01:52:46AM +0100, Chris Down wrote:
> In order to avoid situations like this, make it more clear what we're
> waiting for:
>
>     $ git bisect start d93ff48803f0 v6.3
>     status: waiting for good commit(s), bad commit known

Makes sense. It would be kind of nice to realize that (in your example)
"v6.3" likely wasn't a pathspec that matched any files, either, and
after trying to DWIM it into something sensible, printed an error and
quit.

But I think the behavior here is slightly more subtle, since we really
care about whether or not a pathspec would match any revisions along the
bisection, not just the tips or the currently checked-out revision.

So I think the approach here makes sense.

> +static void bisect_print_status(const struct bisect_terms *terms)
> +{
> +	const struct bisect_state bs = bisect_status(terms);
> +
> +	/* If we had both, we'd already be started, and shouldn't get here. */
> +	if (bs.nr_good && bs.nr_bad)
> +		return;
> +
> +	if (!bs.nr_good && !bs.nr_bad)
> +		printf(_("status: waiting for both good and bad commits\n"));
> +	else if (bs.nr_good)
> +		printf(Q_("status: waiting for bad commit, %d good commit known\n",
> +			  "status: waiting for bad commit, %d good commits known\n",
> +			  bs.nr_good), bs.nr_good);
> +	else
> +		printf(_("status: waiting for good commit(s), bad commit known\n"));
> +}

Could or should these printf()'s be advise() calls instead? That would
make it easier for users to turn them off if they don't want the extra
output. At the very least, we should make sure that they are sent to
stderr to discourage scripting around them.

Thanks,
Taylor
