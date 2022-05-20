Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B4FC433F5
	for <git@archiver.kernel.org>; Fri, 20 May 2022 23:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353036AbiETXWI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 19:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354062AbiETXWE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 19:22:04 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70371A35A9
        for <git@vger.kernel.org>; Fri, 20 May 2022 16:22:02 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id x65so4665310qke.2
        for <git@vger.kernel.org>; Fri, 20 May 2022 16:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GAY9ThXc7nrq7MYj4SIZzClWFs4G3oOyA9zZ1pBEshc=;
        b=iQ1PoyobYvzcbGTyqfs8nh7RdJ1nBfETeLYs+wztnnJ7yI7p2bgcxkXmYsRvAg7cjR
         i0nvmWMTxzRiRWyxLOGvKXNX+Azm7XIqpP4nVV4BA0D/m4+ebj0onD55bBlEatk2cBg0
         s+Os757JgoQDt9QG+LdkBSgxceLFvF8rXM1JcIqwUfkEI9gQxNql14wnQIuIeRSYdwdt
         KRGFqTc8FaMxulRnHZHP+76RRJ5gX2B58wvIDpeMndhSJFcQDelqkBBybn1QTZuPdfUS
         xKgJfNfpvm2hvSu93z+EI5NzS+GFJdhSWLCPioGXfZKdAdeVBZzzvqsDQFRbnVCVw9nn
         DIfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GAY9ThXc7nrq7MYj4SIZzClWFs4G3oOyA9zZ1pBEshc=;
        b=lHPjgl7Porh76VZHf/EYWuOSpcnXuafLJSmLWe1UIwWpiRRjSCLmk1rN/UVkBfL0gH
         yB6zmk0PbfJdMOzTcSY5G0oyz9txT+2aIGChzNdSmPmgkM9BpxhtVPyH5e9osyY4w3eU
         D0gtn1IkHXAGA4wdjuYALw12ofb7GlxJE471hpou6JufJH9kOQNIAwIYYMiohx8gvFu5
         Tr4uKImKWwsi2274DogZbltiZMxQocM60vaNLp0KghNe54LAsnZIMuhVTkRZSXzvfJLe
         ZKeMrbZYB26Q0o1CIAMJAE7Shk4uaG/Ksm9aGUheaxbr+JiyvRMsi0h90cWXSdYcFHP4
         6nCA==
X-Gm-Message-State: AOAM5323YdN+bTljopcLWwlOExy9LE3zUBgWW6hA5x32EEQZmvblVEzl
        0g2wuNnINwP7T7VQvWytsZqQ3Q==
X-Google-Smtp-Source: ABdhPJxAKwtjWsCtUhhGw27XZygfqwuhTkFzri1B2CN9bzhzxsSazxOQKJXEkP/gmyAtSDZmzvMSHA==
X-Received: by 2002:a05:620a:cc1:b0:6a3:4f36:decb with SMTP id b1-20020a05620a0cc100b006a34f36decbmr2678717qkj.740.1653088921886;
        Fri, 20 May 2022 16:22:01 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a2-20020a05620a16c200b006a006c884f0sm414725qkn.106.2022.05.20.16.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 16:22:01 -0700 (PDT)
Date:   Fri, 20 May 2022 19:22:00 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Victoria Dye <vdye@github.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH 2/3] t7703: demonstrate object corruption with
 pack.packSizeLimit
Message-ID: <YogimAfbnkxCG8IP@nand.local>
References: <cover.1653073280.git.me@ttaylorr.com>
 <08da02fa74c211ae1019cb0a9f4e30cc239e1ab9.1653073280.git.me@ttaylorr.com>
 <a060d672-df82-95a3-072a-7ab7b0566556@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a060d672-df82-95a3-072a-7ab7b0566556@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 20, 2022 at 12:42:58PM -0700, Victoria Dye wrote:
> > @@ -230,4 +231,50 @@ test_expect_success '--geometric chooses largest MIDX preferred pack' '
> >  	)
> >  '
> >
> > +test_expect_failure '--geometric with pack.packSizeLimit' '
> > +	git init pack-rewrite &&
> > +	test_when_finished "rm -fr pack-rewrite" &&
> > +	(
> > +		cd pack-rewrite &&
> > +
> > +		test-tool genrandom foo 1048576 >foo &&
> > +		test-tool genrandom bar 1048576 >bar &&
> > +
>
> I was a bit worried about this test being flaky in the future (relying on
> particular pseudorandomly-generated file contents and the subsequent
> ordering of hashes on the packs). But, since neither 'genrandom' nor the
> pack hash generation seem likely to change (and I can't come up with an
> alternative to this approach anyway), the test looks good as-is.

Note that the "random" contents aren't so random (though I suspect
you're talking about _how_ genrandom interprets the seed changing), and
that we're really only depending on genrandom here to create a large
amount of data.

We are relying on the pack hashes appearing in a certain order, so in
that sense this test could "break" even if pack-objects reported the
packs it wrote in a different order.

But I agree in the sense that I also cannot come up with a less brittle
approach for writing this test ;).

Thanks,
Taylor
