Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC70AC04A94
	for <git@archiver.kernel.org>; Tue,  8 Aug 2023 21:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234893AbjHHVJ4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Aug 2023 17:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235394AbjHHVJp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2023 17:09:45 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952746AAB
        for <git@vger.kernel.org>; Tue,  8 Aug 2023 13:22:16 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5844bb9923eso70005047b3.0
        for <git@vger.kernel.org>; Tue, 08 Aug 2023 13:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1691526136; x=1692130936;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=69D+HZZGYOJW8L4ddJHg7aXtPYAzj8/B65wdhwkuxPM=;
        b=3xfCiDLo0RSwta93NLapsWVgWHvHsyl+glMbx2l1wUem9Tkbv04kMxC2FRQtSzB/v4
         gWHtap8fXJOZsHvZtVVI8tNp6trIforUv2+SpFTCUUgbvR4DFIgHZda942VwxxZecNuf
         Lv9FVSvNrqcOa5Rsi/KRDyuYsGCquu4vq5rUurAeWN5abCiBzpSCpA+YX5u3f16KzUNk
         y7jeDTRwBkfDvX/+TJhpQbviTpdTeBySn1EW0cM77KCrKR/PqmRY5eLZ5BrySKqFtqzJ
         fIcdCg3z9wRerpWVMxD1JnkYI5fRS2hUp6GlRqnNMwnunNnsCS6tMnbwlQs3MOinXHPF
         ccYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691526136; x=1692130936;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=69D+HZZGYOJW8L4ddJHg7aXtPYAzj8/B65wdhwkuxPM=;
        b=T/V2OHzmc0ImCqaUR/h4GQ4cuAw419KgrKJDaEf8Ct+FJF5Vo3W5hY5ZMmYW7XO2m6
         mH9Pp6UOcDrQO32YpThJ11++cyR7oslat/gwo1RoU61KimrEf9XWJwiGZ7xNBfygJg7Y
         IYXBkAPQecVVuj5anBoccMx0Uvs1+xdadwezR34YFUkwfAlfTf9C8nT38n0IikDLVCcG
         lZ0PLGmwdgUISCskJxGkqNRQvJuZW1w4lbiEKNYMcC5pePJx7Nw+fQu0B7Tmpm3qt2wv
         pROPkaI6X6MJgt6adQkJcDJ0zpL3f7Xgq8Ank21b9NsGVrWVlzcyy1A5ENe7KQVKZD69
         NiJA==
X-Gm-Message-State: AOJu0Yx86hLMpCR2ElaUXwXuRvniEqLSrH7jDLsQLlcRN0W+9KY/DXJO
        S+Apna+uwz+th9ugK0H+BX+jGQ==
X-Google-Smtp-Source: AGHT+IFH0rsrNjoqiqMq5Q8+lMQW6aUVBlVSoLyNziGSvRGgVD8bWsEOkv0eWcGGeOwI77+A+sFVHw==
X-Received: by 2002:a81:6d57:0:b0:579:e8de:3580 with SMTP id i84-20020a816d57000000b00579e8de3580mr777583ywc.9.1691526135838;
        Tue, 08 Aug 2023 13:22:15 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id p7-20020a0dcd07000000b0056d31a089e9sm3526292ywd.126.2023.08.08.13.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 13:22:15 -0700 (PDT)
Date:   Tue, 8 Aug 2023 16:22:14 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: leak in jt/path-filter-fix, was Re: What's cooking in git.git
 (Aug 2023, #01; Wed, 2)
Message-ID: <ZNKj9vwZv4kKJEcL@nand.local>
References: <xmqqfs518gdh.fsf@gitster.g>
 <20230808192240.GA4091261@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230808192240.GA4091261@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 08, 2023 at 03:22:40PM -0400, Jeff King wrote:
> Since this hit 'next', Coverity complained about a small leak. Fixed by
> the patch below.

The patch below looks good and makes sense to me. That warning is
awfully long, though ;-).

In any event, I expect that 'next' will be rewound before this topic
graduates, since it is meaty and we are in the middle of the -rc phase.

...and we also have my series on top [1], so it may be worthwhile for
you, Jonathan, and I to figure out how to combine our efforts here. I
think that this could likely get squashed in to Jonathan's topic
if/after it gets ejected from 'next'. We can take my patches together in
the same series, separately in a different one, or discard them
altogether.

If we do decide to pursue the approach in [1], I think combining
everything together into one big series makes the most sense for ease of
merging.

[1]: https://lore.kernel.org/git/ZMv14grkM7x7Sf8m@nand.local/

Thanks,
Taylor
