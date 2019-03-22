Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17BA920248
	for <e@80x24.org>; Fri, 22 Mar 2019 14:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbfCVOfB (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 10:35:01 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34650 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728681AbfCVOfA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 10:35:00 -0400
Received: by mail-qk1-f195.google.com with SMTP id n68so1344673qka.1
        for <git@vger.kernel.org>; Fri, 22 Mar 2019 07:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ARMcMpJEbifUv7V692pNEhVReLbBeUUUn+oxCczaOls=;
        b=KVfJQPEeJ+ckS8MibXbd2Mxuk/MsZzKa7gOpleMoYyG18z7YLbQa7jl326sjmc0NrO
         itANckV6YnOZ2o/puqdyK1V8PL7pcSG8dkmPaokWBBLzwcqzkuc9hB3CwMVphZKUD7e8
         ySdd605sDx9LmbigQrze8mjE7TCqsBZ9XKEII7zAuGqf8xz44RdZTzYqDR9SplxvCsMh
         52FC167pgGGmqO7jEGrdZ4twyWGWYoaFkRjr40TXzHB9tA75Vub5RDRZdTECof/rGC/o
         rZhDDXzTwTJjlzfWXPlEESgZzh+BAcPG6KlXQ+bXhzleDf2Q+QxEZvDrOs5P7XJeGo0k
         c1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ARMcMpJEbifUv7V692pNEhVReLbBeUUUn+oxCczaOls=;
        b=l/WuYATOGtNvoqG2WmBWRU8WHkLm2wIlk41BYklM/VlpMkgaSCN7UrjQ15OZWPBNfq
         YRMSDUWwR3n53G3M6xTKWrja2D63XzwOROYPf/GjmvGqJ1U4TLFj9zjtWgWFJ3vQXRnF
         UyCFAL3AYh1C0DcOXaaUWMrQ3Dz/UwD3xNF4OnEZ5wB94KrlN/Oz42VXvmbEGMKDahUc
         23xqRB6TfXDzjQDDG6yAK44eon85BFW08VeO/yCcxH7mMr2M/3cG4a1qwPlu1boOdpBL
         VJ6undyoj7AirhrsXFiD8xcURZ1xvwZyC0GXPFsKXnM8HBFEaXuo4/MEw40LtLr84PNH
         NQgg==
X-Gm-Message-State: APjAAAWjyHIh740jwfqvMKFP5txm1HwP8d5A7SGrOvefxH8q0610OAmv
        HhRknSeH/U+tFTb5aVav2b3NmXiols+pCg==
X-Google-Smtp-Source: APXvYqxUR7F/+Sgg2mxiR4PNjCqqLTKgjHUTRgnFdzkjjdGoYUuv8pEvMTORm8bbWvFOCCPw+X2vag==
X-Received: by 2002:a37:4887:: with SMTP id v129mr8282082qka.100.1553265299851;
        Fri, 22 Mar 2019 07:34:59 -0700 (PDT)
Received: from localhost ([173.225.52.220])
        by smtp.gmail.com with ESMTPSA id 75sm4227867qke.32.2019.03.22.07.34.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 07:34:58 -0700 (PDT)
Date:   Fri, 22 Mar 2019 10:34:57 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 1/2] refs/files-backend: handle packed transaction
 prepare failure
Message-ID: <20190322143457.GA14595@Taylors-MacBook-Pro.local>
References: <20190321092829.GA2648@sigill.intra.peff.net>
 <20190321092844.GA2722@sigill.intra.peff.net>
 <20190322000601.GA32671@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322000601.GA32671@sigill.intra.peff.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 21, 2019 at 08:06:01PM -0400, Jeff King wrote:
> On Thu, Mar 21, 2019 at 05:28:44AM -0400, Jeff King wrote:
>
> >   - instead of disconnecting backend_data->packed_transaction on error,
> >     we could wait to install it until we successfully prepare. That
> >     might make the flow a little simpler, but it introduces a hassle.
> >     Earlier parts of files_transaction_prepare() that encounter an error
> >     will jump to the cleanup label, and expect that cleaning up the
> >     outer transaction will clean up the packed transaction, too. We'd
> >     have to adjust those sites to clean up the packed transaction.
>
> This actually isn't too bad. Here's what it would look like as a
> cleanup patch on top. I dunno if it's worth it or not.

I am quite glad that you tried this out, since I was curious to see how
it would look when you mentioned it to Michael. While I think it can
often be convenient to have a local variable sharing the address of some
other pointer within a struct, I find the mixed usage here somewhat
confusing.

So, I think that this patch is worthwhile, but I think you should
introduce _this_ as 1/3, and then the existing 1/2 and 2/2 would become
2/3 and 3/3, respectively.

Introducing this as 1/3 means that you don't have to introduce changes
that immediately have the variables mentioned in them renamed in a
subsequent commit. I'm not sure which you feel is preferable to you,
though.

> -- >8 --
>
> [ ... ]

Thanks,
Taylor
