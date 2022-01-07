Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 573F9C433F5
	for <git@archiver.kernel.org>; Fri,  7 Jan 2022 22:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbiAGWlY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 17:41:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiAGWlY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jan 2022 17:41:24 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F794C061574
        for <git@vger.kernel.org>; Fri,  7 Jan 2022 14:41:24 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id kk22so6897138qvb.0
        for <git@vger.kernel.org>; Fri, 07 Jan 2022 14:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZIN+89C0bigrPd+ZD9ureN22t13rXtlNJVHQUweM3c8=;
        b=Em3IVJmlt9UEGmxrQPjjYsmMef3QAL9j7sWskJnbLG4VHItmEszgb8aW6yZUKattCM
         RYyMI2oih5NElDlqG6NMlVLOTqegqWVEZJ0///2YMq8Wk1Xc6HC+IdNhKh+JmKMc4cWm
         dZmzCu0uu3GbqyODCjOD06n+4hi9gG0gQwbpraMb/NN4pNuO7/qQX7+YzyHZCmRYfc44
         1BfmNmmPjXxgs0DCSs4tNuaeJOD6P+qW2iFSlikcaagn/Uzf3aYyUvpQRxoC4LwN0CaM
         sRQ8bcBF3tOkouOqKzzaxAfKx01qc4scus2Snlx5gJ9rhl5WdJQnOqD/oVCw/uNePczN
         2LcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZIN+89C0bigrPd+ZD9ureN22t13rXtlNJVHQUweM3c8=;
        b=4B0jKPhpCV5YdxBr/XrumPRizSgycuABq1GIEMRdGnC6wEcyKtHjB6NOsnP3Q4XgWm
         hHwhU1ue4ODLEqjlpB/RybcZXYjvV7wMi/rzIDphAV0r1uJ3CC+qKuNJSfRZOCuf1TeZ
         D82Gf77ZrB/84kgaCatzT8yRBPPyvA4BLCJdYibc0jmShhEw2vJSrZK3/6H15eEsowNs
         XD3gP0J0GKq9NZHFBTiE3ES9DZfQhfGOKziSCZwGI5HShXOr8rkynZXwuKPJVdOOKJVb
         i5oS95xsqMmYTMdOoMo+uZ7ejZ5ILxFmRV1eLWnZBZ1oZ9sWwtZ67VMAMPCiq5f8ZzsS
         YbMg==
X-Gm-Message-State: AOAM53093CkJ30l9pTULXj53SJ6YPMgz4hgdxRtMxW7YYoOkPSrMsnRb
        hQrwxUPXkMzmTJUbzEvTOZIZCQ==
X-Google-Smtp-Source: ABdhPJyFzouBTxMiySmNxxIUmqQ2OhUJoaB+eu97TU1k8/IFtphVgnHKCRlpqL+6wADjrxqgaIdmDg==
X-Received: by 2002:ad4:48c5:: with SMTP id v5mr60244029qvx.64.1641595283336;
        Fri, 07 Jan 2022 14:41:23 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id k8sm4268489qko.130.2022.01.07.14.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 14:41:22 -0800 (PST)
Date:   Fri, 7 Jan 2022 17:41:21 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, iwiedler@gitlab.com
Subject: Re: [PATCH 1/1] fetch: fix deadlock when cleaning up lockfiles in
 async signals
Message-ID: <YdjBkZsnYd+zYne1@nand.local>
References: <cover.1641552500.git.ps@pks.im>
 <555ec6717ecab0fe6ef5660bcf0d61d59f84ef8b.1641552500.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <555ec6717ecab0fe6ef5660bcf0d61d59f84ef8b.1641552500.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 07, 2022 at 11:55:47AM +0100, Patrick Steinhardt wrote:
> diff --git a/transport.c b/transport.c
> index 92ab9a3fa6..2a3e324154 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -1456,13 +1456,18 @@ int transport_fetch_refs(struct transport *transport, struct ref *refs)
>  	return rc;
>  }
>
> -void transport_unlock_pack(struct transport *transport)
> +void transport_unlock_pack(struct transport *transport, unsigned int flags)
>  {
> +	int in_signal_handler = !!(flags & TRANSPORT_UNLOCK_PACK_IN_SIGNAL_HANDLER);
>  	int i;
>
>  	for (i = 0; i < transport->pack_lockfiles.nr; i++)
> -		unlink_or_warn(transport->pack_lockfiles.items[i].string);
> -	string_list_clear(&transport->pack_lockfiles, 0);
> +		if (in_signal_handler)
> +			unlink(transport->pack_lockfiles.items[i].string);
> +		else
> +			unlink_or_warn(transport->pack_lockfiles.items[i].string);

This puzzled me when I first read it. But unlink_or_warn() isn't
reentrant because it performs buffered IO on stderr, so if we reached
this signal handler while executing another function call modifying
those same buffers, the call within the signal handler would have
undefined behavior.

So that makes sense: freeing (with string_list_clear() below) and
performing buffered IO (with unlink_or_warn() here as just described)
are certainly off the table.

But is unlink() safe as-is? I'm not so sure. Reading signal-safety(7),
it's clearly on the list of functions that are OK to call. But reading
the errno section:

    errno
      Fetching and setting the value of errno is async-signal-safe
      provided that the signal handler saves errno on entry and restores
      its value before returning.

We certainly not doing that, though that's nothing new, and so I wonder
why it doesn't seem to be an issue in practice.

Thanks,
Taylor
