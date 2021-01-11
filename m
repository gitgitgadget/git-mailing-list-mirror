Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E17C433DB
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 16:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B8F0223E4
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 16:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731396AbhAKQYj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jan 2021 11:24:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728506AbhAKQYj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jan 2021 11:24:39 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD0CC061794
        for <git@vger.kernel.org>; Mon, 11 Jan 2021 08:23:58 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id 22so15020231qkf.9
        for <git@vger.kernel.org>; Mon, 11 Jan 2021 08:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lHtyJXwNzTk7qUSrkoOCGcnFHY9Z0XprHUkWuJeZLl4=;
        b=dPSmU/YgtmsLGr94X9M3kAZPQwE/RXryzsFZpK3urdu4iF+3pkc20Zw52LFoEww07M
         fJkq2G1LWJcNFTLoWIhxXS+3oXkPaZovvBfIc6WrrF+Bvseh+Cb6fuBAe/M9B8rBtbuG
         1GoNkMSjhymS+1mr/6tr0RNdAOzhmKvEAl2i299J5v4ucpySrG/RXLo7DL8Nly7C7dez
         7CXyWre2ZV10RkF651490HvFqmUhwXOLDdg4ozvF2V3fPXULKYfwVyXh/y+L+Pt5Whf4
         9KWOTqVka7XJdYgL0ecCSGmU68gfQ3nhZiV6aRGX/MXh4kCKnK4mYSqLsuwdMA7mOl2b
         STag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lHtyJXwNzTk7qUSrkoOCGcnFHY9Z0XprHUkWuJeZLl4=;
        b=e2cPp9Yi83f6283ryK09i5P6JlMGqFCuM+5V0xeGiMtfdYP8JvpXKL6ra7lzx+5P0H
         TGyaBp/71FmFzyhGHZ7K8pde9ItiEzZMB+F9qHZqtL47Zz8YhOjsiVE2wE1I6km/AL24
         +cYw6s3sMLev3Or59Q+84lB2B3tlLPdQrfHKLBIzmTAHDmTHVMUwTZgrvccGnfSLNnt/
         s8nf85ET7bi/o6Vds3RZ3f0x0p7kENKtNQ7eWjsCENDYXFlD3MGs/QK1fAileh6R9jWI
         p5/AM7naL4cYPIDpeojVK642eEPCry/kzC5axgOhZTrT9WfXa+qzZOVq7ak1MARB4Lnx
         TpoA==
X-Gm-Message-State: AOAM5329M2ZnOLykX02sMKLK5JwjHOnO6esCPT3OC/Beho0n1nrJPEBA
        npVrN5vpIvEwAP9X0RbF/IRsig==
X-Google-Smtp-Source: ABdhPJyURc7BAo3U3JZpIkW+zqMGhc+SvSJFFkNw0J0rngUXFRLRc6cvjvXoJA/u83GkLaVBoDzKAQ==
X-Received: by 2002:a37:c0b:: with SMTP id 11mr117199qkm.32.1610382238034;
        Mon, 11 Jan 2021 08:23:58 -0800 (PST)
Received: from localhost ([8.9.92.205])
        by smtp.gmail.com with ESMTPSA id u4sm8521qtv.49.2021.01.11.08.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 08:23:57 -0800 (PST)
Date:   Mon, 11 Jan 2021 11:23:54 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net,
        jrnieder@gmail.com
Subject: Re: [PATCH 16/20] builtin/gc.c: guess the size of the revindex
Message-ID: <X/x7mrcwfxGO8xH7@nand.local>
References: <cover.1610129796.git.me@ttaylorr.com>
 <7c17db7a7df8b524f13969efd1cb5e6e95de5a2d.1610129796.git.me@ttaylorr.com>
 <87cd1b2c-7a28-da77-4ae4-99ffbbdfda72@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87cd1b2c-7a28-da77-4ae4-99ffbbdfda72@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 11, 2021 at 06:52:24AM -0500, Derrick Stolee wrote:
> This is so far the only not-completely-obvious change.
>
> > But, this is an approximation anyway, and it does remove a use of the
> > 'struct revindex_entry' from outside of pack-revindex internals.
>
> And this might be enough justification for it, but...
>
> > -	heap += sizeof(struct revindex_entry) * nr_objects;
> > +	heap += (sizeof(off_t) + sizeof(uint32_t)) * nr_objects;
>
> ...outside of the estimation change, will this need another change
> when the rev-index is mmap'd? Should this instead be an API call,
> such as estimate_rev_index_memory(nr_objects)? That would
> centralize the estimate to be next to the code that currently
> interacts with 'struct revindex_entry' and will later interact with
> the mmap region.

I definitely did consider this, and it seems that I made a mistake in
not documenting my consideration (since I assumed that it was so benign
nobody would notice / care ;-)).

The reason I didn't pursue it here was that we haven't yet loaded the
reverse index by this point. So, you'd want a function that at least
stats the '*.rev' file (and either does or doesn't parse it [1]), or
aborts early to indicate otherwise.

One would hope that 'load_pack_revindex()' would do just that, but it
falls back to load a reverse index in memory, which involves exactly the
slow sort that we're trying to avoid. (Of course, we're going to have to
do it later anyway, but allocating many GB of heap just to provide an
estimation seems ill-advised to me ;-).)

So, we'd have to expand the API in some way or another, and to me it
didn't seem worth it. As I mentioned in the commit message, I'm
skeptical of the value of being accurate here, since this is (after all)
an estimation.

Perhaps a longer response than you were bargaining for, but... :-).

Thanks,
Taylor

[1]: Likely negligible, since all "parsing" really does is verify the
internal checksum, and then assign a pointer into it.
