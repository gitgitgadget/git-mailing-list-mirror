Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE7CC43464
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 23:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2814A20853
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 23:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="ygM/KgNA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgIQXNv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 19:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgIQXNv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 19:13:51 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE38FC06174A
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 16:13:48 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id g3so3397424qtq.10
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 16:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=yYQZs12pa/T8yj8UHFmC8gltvhBNRunvN+LZRHwqQ6o=;
        b=ygM/KgNAVBssPHyOzS5mzaCz8kBuC6I7yXhFLyNPBMSIwdttzi/GcGw5X0EG0klrLq
         77njPqMQJNq99WDeXu2Hir3t0q8toQeF45KTpsCq9dP398lwjJbVyUZSvUWNPNzlbtRd
         VYzLNhRYrhMJWrYC2R8bcDFm/eUTAMKhkKg4OzTHa9TzQUnIOqK2P9x94SeCJLW1kiCp
         I1TstDiXtYGgiGLdRSkkvmlXgXqGJ2BaXv/Vzpo5yiIb2w2O//dyIIJB8zkLi6YHONNP
         sH2KEI6WYKe12lVu9MBPJhZdMPqp0KA9hfBYrNy+xyWfSzQalQOb9vu2VJ0oEdfbrYQK
         cj/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=yYQZs12pa/T8yj8UHFmC8gltvhBNRunvN+LZRHwqQ6o=;
        b=jE4bQQoUxpUZR5GhvEH6BslUDvApvuR//qmtsqc+mrZfdx28QVxQ4m0D50p1AjiX0k
         1inQ7gsE76wvxu+p8P2HrBpfdsxEfiSYzKvhW/obPMvFFimyYyuZdZ6bKiBuWxN5xhmQ
         dIfQaZ9c8aFWTGNMQjpXpzdGDzBAFdH2TWUEKiLII7zxrTGGvQ8dzHC/VG1yoreT9oWi
         VyMIXiXlH/YTBRPzfgOWfPvTEZhN8NCqTZXbS1MBU3BZ54HKEYc7tzhL1vBEyZ+acHJI
         MqutgHvWFuVQzuCj9AwVRECQh618V1w5xvWqYNX3oiZujjqf5Q3b53BtkNmgizbkqHUE
         hCnw==
X-Gm-Message-State: AOAM531oXX6OT93aH7xK/EJcWs89lZ4bPxlcQAfIo3eIh7X+GKsUjC8d
        afzJ83MEhTaipbbLguT7lV22RA==
X-Google-Smtp-Source: ABdhPJw+cEBQun5BZk9Uq84LejTnOXUaJdFuQJQHsM1Vf/OlbhePuZ00+G3SI/P9/8YWaF/NynHyow==
X-Received: by 2002:aed:35f9:: with SMTP id d54mr4416780qte.376.1600384427829;
        Thu, 17 Sep 2020 16:13:47 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:2003:d617:ca70:4fd1])
        by smtp.gmail.com with ESMTPSA id g25sm874542qto.47.2020.09.17.16.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 16:13:47 -0700 (PDT)
Date:   Thu, 17 Sep 2020 19:13:44 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com, gitster@pobox.com, peff@peff.net
Subject: Re: [PATCH v2 10/13] bloom: encode out-of-bounds filters as non-empty
Message-ID: <20200917231344.GA1591704@nand.local>
References: <cover.1599664389.git.me@ttaylorr.com>
 <cover.1600279373.git.me@ttaylorr.com>
 <4653b5b4bcd254a3791797214b46722b4062dc18.1600279373.git.me@ttaylorr.com>
 <20200917221302.GC23146@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200917221302.GC23146@szeder.dev>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 18, 2020 at 12:13:02AM +0200, SZEDER Gábor wrote:
> > Clients will invoke the Bloom machinery in more cases than before, but
> > this can be addressed by returning a NULL filter when all bits are set
> > high. This can be addressed in a future patch.
>
> OTOH, clients will invoke the tree-diff machinery in fewer cases than
> before, because querying the Bloom filter of commits not modifying any
> files will now return "definitely not".

Absolutely right.

> > Finally, note that this does increase the size of on-disk commit-graphs,
> > but far less than other proposals. In particular, this is generally more
> > efficient than storing a bitmap for which commits haven't computed their
> > Bloom filters. Storing a bitmap incurs a penalty of one bit per commit,
> > whereas storing explicit filters as above incurs a penalty of one byte
> > per too-large or too-small commit.
>
> s/too-small/empty/

Fair enough, although I'm not planning to alter this or any other patch
now that it's picked up unless there's a real show-stopper (this doesn't
seem like one).

> > In practice, these boundary commits likely occupy a small proportion of
> > the overall number of commits, and so the size penalty is likely smaller
> > than storing a bitmap for all commits.
>
>                  |      Percentage of
>                  |    commits modifying
>                  |   0 path   |  >= 512 paths
>   ---------------+------------+----------------
>   android-base   |   13.20%   |   0.13%
>   cmssw          |    0.15%   |   0.23%
>   cpython        |    3.07%   |   0.01%
>   elasticsearch  |    0.70%   |   1.00%
>   gcc            |    0.00%   |   0.08%
>   gecko-dev      |    0.14%   |   0.64%
>   git            |    0.11%   |   0.02%
>   glibc          |    0.02%   |   0.10%
>   go             |    0.00%   |   0.07%
>   homebrew-cask  |    0.40%   |   0.02%
>   homebrew-core  |    0.01%   |   0.01%
>   jdk            |    0.26%   |   5.64%
>   linux          |    0.01%   |   0.51%
>   llvm-project   |    0.12%   |   0.03%
>   rails          |    0.10%   |   0.10%
>   rust           |    0.07%   |   0.17%
>   tensorflow     |    0.09%   |   1.02%
>   webkit         |    0.05%   |   0.31%

This is very useful information to have! Without the total number of
commits, it's impossible to know whether or not this is a win over the
BFXL chunk. But, since the number of commits is probably "large" versus
the percentage of boundary commits which is "small", it's almost
certainly an advantage.

> > A test to exercise filters which contain too many changed path entries
> > will be introduced in a subsequent patch.
>
>
> > diff --git a/bloom.h b/bloom.h
> > index c6d77e8393..70a8840896 100644
> > --- a/bloom.h
> > +++ b/bloom.h
> > @@ -93,6 +93,7 @@ enum bloom_filter_computed {
> >  	BLOOM_NOT_COMPUTED = (1 << 0),
> >  	BLOOM_COMPUTED     = (1 << 1),
> >  	BLOOM_TRUNC_LARGE  = (1 << 2),
> > +	BLOOM_TRUNC_SMALL  = (1 << 3),
>
> s/SMALL/EMPTY/
>
> This "small" suffix in the constant, variable, and trace2 key names is
> misleading, because we only mean empty commits.

I could buy that it might be misleading; I only picked this since it was
the opposite of "large". You could imagine that BLOOM_TRUNC_X means
"truncated in the direction of 'x'", but to be honest I don't think that
this matters.

I understand the churn of coming back to this after the topic has
already been merged creates more hassle, but frankly this series has
already gone on for quite a while, and it has been holding up important
bug fixes that are unrelated to the main feature.

So, I think that if it's truly misleading, we could revisit this after
the topic is merged. But, I'm not planning on changing anything at this
point.

Thanks,
Taylor
