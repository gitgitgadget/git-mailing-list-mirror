Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 973ADC77B7D
	for <git@archiver.kernel.org>; Sat,  6 May 2023 00:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjEFANt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 May 2023 20:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjEFANs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2023 20:13:48 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92AEA65A4
        for <git@vger.kernel.org>; Fri,  5 May 2023 17:13:47 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-55a8e9e2c53so23029237b3.1
        for <git@vger.kernel.org>; Fri, 05 May 2023 17:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1683332027; x=1685924027;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2m7OUrVendGfFOflEM6OpGNR9xjm12Pecycfk6NZEEQ=;
        b=Aa628ZPaKvP+ahWH+xwk/cwOmj/noH+2KA+Ql0dFxbx4U9mDtvrbBb7ztLyvN/rmec
         jsGMfrqqwIsfH4yMHdTN6+0ZV3Xbem+pgs73fYMY1ZpHcIY9xGRdfV1OfD7u9ajlQfQ1
         4lOJSXNHX2714K9E1GsE1XoByN7dO7M5fqw/tkCX8wUkk43kHfwFLVRmo3UCfwk8wE5f
         qHaU3iT8q1JHxfTZUvABXN2G2HmYWdeYlBsHJDhEGKrZEcvKEKWkZ65vxct2joG+bUve
         MurcSrKYC7cnXS5jpQpPwWqf8W6mO87RHAKaj6Z5CoIlyj2LAClKdro7ZTHSKDXfTQUl
         4bng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683332027; x=1685924027;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2m7OUrVendGfFOflEM6OpGNR9xjm12Pecycfk6NZEEQ=;
        b=lEOSNM25dJ9NwjrYk1WOkQqMCBaKh9Bqx9k4NWDvjKEFHwESUY0fuuclvHjm6Ad6kl
         rNSzxnlGsrI/nqhAJBQo0RPCv8Yg3/roe7uBMF5DLXB4BB0fnjSK2pQE7eFMLUWdyXh7
         88RL4op3Lgl5InH8aIjneY9F3FfwBcJ5ODe57K2Cm6YofN5YZbAGu2H8ZHdJIwYnzAzW
         MKPVt/Vs7pbOmdaLyd3V5rvm2LC3IoUmr7+ovSJ510J4v2rmLxJwUDTAJvrVXzL8hri4
         6A5Vgn92PPzMaXjbeuEvGZB7cB6K6dKBKENXelzp1iQNjWn7uU/qnMikpY8Ol1LCGsOj
         pBrQ==
X-Gm-Message-State: AC+VfDw/rLm7emMusAmnTVVxcr8nOGXaxteYMETXAcu6ruHnBzgC/tty
        LT8o+vkMmOF4FriDlKrOYlfaKA==
X-Google-Smtp-Source: ACHHUZ7IafWe3C4aIKQAXSMu01AW0tnpgTC1A+1fGn9uOFGZxuU6/4f9wuFJzzKLBa9KNnNDJV9MSg==
X-Received: by 2002:a81:5a05:0:b0:545:fe8a:bc12 with SMTP id o5-20020a815a05000000b00545fe8abc12mr4417809ywb.0.1683332026705;
        Fri, 05 May 2023 17:13:46 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id p78-20020a25d851000000b00b9a63c60fefsm792509ybg.31.2023.05.05.17.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 17:13:46 -0700 (PDT)
Date:   Fri, 5 May 2023 20:13:45 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2] builtin/pack-objects.c: introduce
 `pack.extraCruftTips`
Message-ID: <ZFWbuf34pVxJyRiM@nand.local>
References: <8af478ebe34539b68ffb9b353bbb1372dfca3871.1682011600.git.me@ttaylorr.com>
 <73ad7b90e1fe6c15f41ff828651f7ab06076ffd8.1683072587.git.me@ttaylorr.com>
 <20230503195906.GA1796816@coredump.intra.peff.net>
 <ZFLSDS89y8P2+g/2@nand.local>
 <20230505212631.GB3321533@coredump.intra.peff.net>
 <20230505221357.GD3321533@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230505221357.GD3321533@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 05, 2023 at 06:13:57PM -0400, Jeff King wrote:
> One thing that could make this a lot simpler is if the code was added to
> "are we recent" code paths in the first place.
>
> Something like this:

This is quite nice, and I think that it's a good direction to push this
~series~ patch in before queuing. That said, I wasn't sure about...

> @@ -78,7 +144,7 @@ static void add_recent_object(const struct object_id *oid,
>  	struct object *obj;
>  	enum object_type type;
>
> -	if (mtime <= data->timestamp)
> +	if (!obj_is_recent(oid, mtime, data))
>  		return;
>
>  	/*

...this hunk. That only kicks in if you have other recent object(s),
since the hooks are consulted as a side-effect of calling your new
`obj_is_recent()` function.

I think in most cases that's fine, but if you had no otherwise-recent
objects around, then this code wouldn't kick in in the first place.

I wonder if it might make more sense to call the hooks directly in
add_unseen_recent_objects_to_traversal().

> That would affect both "repack -A" and "repack --cruft". It would also
> affect "git prune", but that seems like a good thing to me.

I was going to say, I'm not sure this would work since we don't use any
of this code from enumerate_cruft_objects() when the cruft_expiration is
set to "never", but that's fine since we're keeping all of those objects
anyway.

OK, my bad, I think that was the point you were trying to make in your
previous email, but I didn't quite grok it at the time. Yes, I agree,
this code only needs to kick in when pruning.

Thanks,
Taylor
