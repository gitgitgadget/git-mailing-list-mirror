Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92FB3C433EF
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 21:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7143560F26
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 21:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234138AbhIPVlC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 17:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbhIPVlC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 17:41:02 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25CB6C061574
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 14:39:41 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id m4so8085523ilj.9
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 14:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=fUqpuGu6i8tVKLlyr95fr8Q9ciTIm4hzvAU6k+yGUdo=;
        b=jNS2zN/40LjJL0RHORERs8UW0vgQekgxQMJHauQYrtCnX75b9dTaSI5Z0rddX/jpY1
         ujpKwtwb30C3KahmOLOH3Zhm2iVfmkCnotbw5nx7wI6tSZwrTWOyO73vCf031gHbtA3j
         rQ9COmUe8f5rxQbjs0zDZ9FA/97Dt0YZ9G3oKIh62A5hr0poyLue1DlWUM1yxGsBrakB
         J7grAX3yByBWGkFP4JNY7preNLl5/kEZe1a3a0KK66AOpOxJIn9GJGL2e4ZkQRBMTtLL
         mdsh6PiJi+rTzLRLKDgecUhcW/RXP/VusbFEh7foc0ZCG3ubtY/E23TyyGb5uhL4Gl35
         oBFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=fUqpuGu6i8tVKLlyr95fr8Q9ciTIm4hzvAU6k+yGUdo=;
        b=anyZgxWT4bmoj1rqDbvYBql8dRutPGNoLhU0tSzO6+JBEXKydvxed7CLUatgrZY7km
         EFjK/ZcRcvdiHasuYQ+xoDvBe4NOrkDy0IVN/OOY6xUr80q1R1txWNU32dWaGOQF82La
         uLbrUOy13jC1jWpY0KMrMGJz5SLLhviuhZs+xUeAidhLXre8kyWfqhHLZi9N1N9BlM1e
         SIy0KK72hhZ0+0vzxJjR9l+wkcKPxNjq1d/Hf00WVeLx8rUoB7fuyOAB1BNQhzA15XDT
         yK6A0DwtV6PB5/CI+Bgikp2LFKz3D89Bgsrpf1KCMDNCn06p/70BJukK4kHfBCFCFxTK
         +TUA==
X-Gm-Message-State: AOAM533IQa3jTFkWs+O0UNavALHzQSJaDlVZPDok5JH4nwG/1ur1yMVE
        t8kCwBwAT8aXIEs4EVO9iNaaUA==
X-Google-Smtp-Source: ABdhPJxUYmmpehN1dzSKrq0k9jJndtPStOIR1Z/6THCWd39XgADeKHpsAd3IyO3ZzhCyQ7oPY5H13Q==
X-Received: by 2002:a05:6e02:eb2:: with SMTP id u18mr5523359ilj.138.1631828380538;
        Thu, 16 Sep 2021 14:39:40 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id t14sm2390138ilu.67.2021.09.16.14.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 14:39:40 -0700 (PDT)
Date:   Thu, 16 Sep 2021 17:39:39 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>
Subject: Re: [PATCH v6 10/22] object-file.c: make
 parse_loose_header_extended() public
Message-ID: <YUO5m9gukagBGiF3@nand.local>
References: <cover-00.21-00000000000-20210710T133203Z-avarab@gmail.com>
 <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com>
 <patch-v6-10.22-b15ad53414b-20210907T104559Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v6-10.22-b15ad53414b-20210907T104559Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 07, 2021 at 12:58:05PM +0200, Ævar Arnfjörð Bjarmason wrote:
> Make the parse_loose_header_extended() function public and remove the
> parse_loose_header() wrapper. The only direct user of it outside of
> object-file.c itself was in streaming.c, that caller can simply pass
> the required "struct object-info *" instead.
>
> This change is being done in preparation for teaching
> read_loose_object() to accept a flag to pass to
> parse_loose_header(). It isn't strictly necessary for that change, we
> could simply use parse_loose_header_extended() there, but will leave
> the API in a better end state.

All seems reasonable. I agree that this is not a necessary step, but at
least the clean-up is self contained and an easy enough read.

The flag that read_loose_object() is going to start passing to
parse_loose_header() is left a bit vague, but I'll continue reading to
figure out what it is.

Thanks,
Taylor
