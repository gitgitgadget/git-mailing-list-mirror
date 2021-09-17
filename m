Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B72CEC433F5
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 04:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9199961100
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 04:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244265AbhIQEVq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 00:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242139AbhIQEVp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 00:21:45 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7153DC061574
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 21:20:24 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id m11so10604671ioo.6
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 21:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ypCmwg+J1Qpc4JdF56Pccggbhhe69jbsZBAZzHf9Ex0=;
        b=XfqJYq3xHSylF9OZIKL638xIBEvz/1vhY/85Ul6G9U65lrt2jXpiEbbS2r7C0Tsa4N
         9rnrKg+soPy8PSha3qvErNW3avh7xcXCH1pTXsf+B9UESfutlbz59UVXxtkE3AyrPR8x
         zjtHOtWMUr2lsZrJs6qqJ5rqYq7TpGL8ts4jiy35+ijeyJoUKDHATJSFRMaiwk68zEbI
         Q/TEMfP+EMUenABc/NnJsDefbtOjglpYE2qfJvS7R9R5kQDd//fgPNM8wSm8nykZo9B7
         Sb9FSDnsKFFz39/vyib02aTJkEgh5JKjiFwbEnl/kjbXvfD7KPTWb2ALXhd3Q0PzUL1f
         RwpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ypCmwg+J1Qpc4JdF56Pccggbhhe69jbsZBAZzHf9Ex0=;
        b=jTIIqcXIcbX4nd0RCzkDAcOyix2V6wbAbZLDIpXJsrKLjABX0/muUrPVA2SwMoyMeB
         6KqCEjtMLK0vLjzhwu7bXOWR2q9MAGwoNDsooLJAIMVV9HIMeLWFVRdCL3hQ/d3ZgiEE
         yPBGd5Xjvyy20ZdOqurBtDbkCq7+wcBWSM6Ryef7RG2Tzfjux/6RRK0mW2Jcpb0LCwjr
         jGkrV+l4VZwJDli5rszyAKp/fj4Kys+9Lw/ADhx0Ib7l9L/cQqy4t6Jdu0kn9KbnJUES
         tHgeV/Lu1W1tqA9LKfmlkZ1EOQ0ZLfTi3qvqY6OcZsIgrdJ6kuinc7QHd9ZONrBEqr1q
         /8QA==
X-Gm-Message-State: AOAM533dBXu7WRyt9f0IfaXCueLZrql8j0Vn8YRRr8zx1F49cVttNqrF
        2M7z4RVVA6y5esla8wSypiN/T9xzuHHq6dOD
X-Google-Smtp-Source: ABdhPJwyN9L2yCLl5PgYnBekN7yBcnIL3zE7fqxx8xx8GLx4Bv5R/7nYjOgW4qOf4T5n7lWr03bVwg==
X-Received: by 2002:a6b:f819:: with SMTP id o25mr6947926ioh.21.1631852423854;
        Thu, 16 Sep 2021 21:20:23 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g12sm2830825iok.32.2021.09.16.21.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 21:20:23 -0700 (PDT)
Date:   Fri, 17 Sep 2021 00:20:22 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, gitster@pobox.com, avarab@gmail.com
Subject: Re: [PATCH v2 6/7] p5326: generate pack bitmaps before writing the
 MIDX bitmap
Message-ID: <YUQXhsJYhxGdjSfL@nand.local>
References: <cover.1631049462.git.me@ttaylorr.com>
 <cover.1631657157.git.me@ttaylorr.com>
 <040bb40548017bae807c1d349fa078c21ac46725.1631657157.git.me@ttaylorr.com>
 <YUPJDf7u8Nn5als3@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUPJDf7u8Nn5als3@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 16, 2021 at 06:45:33PM -0400, Jeff King wrote:
> It might be interesting to also do:
>
>   rm -f .git/objects/pack/pack-*.bitmap
>
> after generating the midx bitmap. That would confirm the further timing
> tests are using the midx bitmap, and not ever "cheating" by looking at
> the pack one (having poked in this direction before, I know that this
> all works, so it would be a future-proofing thing).

This and the suggestion to avoid timing the single pack bitmap
generation are both good ones.

I think to be totally accurate we would want to drop the pack bitmap
before every MIDX bitmap generation, but I also think that in practice
it does not matter much.

The reuse code currently does not try too hard to recognize the
situation of "oh, I selected the same exact commits and don't have to do
any work". It kind of does eventually, but only after doing a lot of
preparation.

So I'm dubious as to whether we're really timing anything *that* useful,
but it's probably worth keeping around anyway.

Thanks,
Taylor
