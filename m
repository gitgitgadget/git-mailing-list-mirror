Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C0FC433EF
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 01:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3B8161108
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 01:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237530AbhINBN5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 21:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbhINBN4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 21:13:56 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E07C061574
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 18:12:39 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id a15so14732347iot.2
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 18:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mh3SEtbRIdsLu7vBWb4YI2qYdiAJiOmdyLKrHy3XDgU=;
        b=nQ15CPdQnWEPSMGkiQyGXwwrJHo2JdypTuOYzXHO/lo3OY/vqLHdZQCYWdRfo5IszX
         q7scsOJW0PorJmUEMtj2C+wZFd+wkslZ7Dr+d7tSQL+MYIEe5WI9U8jf5xGy4Yg1S1Pe
         FOWMu4Vx4NU5MmDDMC3KxtaX2tyC4sZ197uUp+nPEZmFcRvDHEQg6BaONpeTGwsaFe8B
         bM/JHSk8rdpjfPUpKbWKbTtakXTBDgVBUXKAhQFHGm15pV+3bb7raO/TF4wvQYsAyqBX
         2GCs0YansDS2plNsqE5pW3f5dk5lifCNPOFaShEsnmd4NMuJfP6DgSzOGmxgPhEm+Pxk
         Jgaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mh3SEtbRIdsLu7vBWb4YI2qYdiAJiOmdyLKrHy3XDgU=;
        b=mswEvKmvsqfZi9O9OHIvdk2eXRXUHPIIYdR2sEK/GGtPapwbWZfzd3GP3ppz9Qh4fu
         MjeAMXDw8gCIvRM+K/HrP0SLEsqTwKE+fgVu0fdOLy0UOnECEE+Q8uA3F6qY7DhxiB10
         VRSkjFEvrlAi5P16H4loyNux5xLb+mayN/oPygaT4ieyIAY9WsgRcQEtDdIXrb64rYVC
         DDEK76SB1uaWeLyaLqCSpylpNpSd7bqQWyAiT0TNg5C0GUynOOGdtv+jlXs1+9R42pNt
         Yynkxhv+dZQb67Vjysl2XGm0D1JFQQr8byusr92rBthA5Oc8z6us83gO4JDPxXGYwVhG
         JkIw==
X-Gm-Message-State: AOAM530h5fWFWzhqajhmMiEWjA/n3/BL2EKZy0LCsZ7SnF3sLGUmdm5J
        vFlDw97oESj/qSb8tZHgca50AKA/pgtYOuJZ
X-Google-Smtp-Source: ABdhPJwbNsSnSrSZnGGTNa9hCHIFs5UnYRsWGTSHl6JVhdSELGQb1Ywmc5kRNNV+3ce8sw0iSvV+sg==
X-Received: by 2002:a05:6602:2436:: with SMTP id g22mr11712254iob.109.1631581959108;
        Mon, 13 Sep 2021 18:12:39 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m11sm5881424ilc.2.2021.09.13.18.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 18:12:38 -0700 (PDT)
Date:   Mon, 13 Sep 2021 21:12:38 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 4/4] t5326: test propagating hashcache values
Message-ID: <YT/3BuDa7KfUN/38@nand.local>
References: <cover.1631049462.git.me@ttaylorr.com>
 <acf3ec60cb6f151a9f121d242f38fef6711cced4.1631049462.git.me@ttaylorr.com>
 <xmqqa6khi9ph.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa6khi9ph.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 12, 2021 at 05:46:18PM -0700, Junio C Hamano wrote:
> What I am wondering is if we can come up with a "now, because we no
> longer lose hashcache, we can do X so much better, here are the
> numbers".

Sure, here they are. Bear in mind that these numbers are (a) on git.git
and (b) with `pack.threads` set to 1 so the overall runtime looks more
like CPU time.

  Test                            origin/tb/multi-pack-bitmaps   HEAD
  -------------------------------------------------------------------------------------
  5326.4: simulated clone         1.87(1.80+0.07)                1.46(1.42+0.03) -21.9%
  5326.5: simulated fetch         2.66(2.61+0.04)                1.47(1.43+0.04) -44.7%
  5326.6: pack to file (bitmap)   2.74(2.62+0.12)                1.89(1.82+0.07) -31.0%

Apologies for taking a little while to respond, I spent longer than I'm
willing to admit double checking these numbers with Peff because of
inconsistencies in my testing setup.

Alas, there they are. They are basically no different than having the
name-hash for single pack bitmaps, it's just now we don't throw them
away when generating a MIDX bitmap from a state where the repository
already has a single-pack bitmap.

Thanks,
Taylor
