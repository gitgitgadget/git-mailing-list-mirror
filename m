Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DA3C432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 22:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B28C360FF2
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 22:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243777AbhHZWjB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 18:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbhHZWjB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 18:39:01 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86724C061757
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 15:38:13 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id v16so4940832ilo.10
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 15:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=234Pqh0F3HFeItOGsjVylRnPO2UEnkdeQ6+5xEAvtZU=;
        b=cyp8Ywc2T0Pe1nTsm6dyeLMg3OL9nqZ5P0a/NUXWX6Su40qWfxhTtvSW54qoEgwaEw
         ar7hQg8Ryudrs1nmkVC5n7tzJAuLfIzigOWqlljRULpl48UKm/dtKpGE8i3JJM/EhLO6
         m6A14gTAoMrOTtX4B0ZUScV3nV3ECKGNaWrm/mDDfPKt5XDI1KwRezKOu820MvxKEmcG
         PdraEEr3m1nphNmdRLq2b0LPUXqyXA6oR8cAXJZn2GcQLoIeFHnM4XNdohBjzloSrsVa
         AmO+2B28T1idiNdYx0mJ/LDh2QJk7TFh9sRTTOWYJ8+yxZuqpebv5iuLAOd4DIwLbNR9
         QxZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=234Pqh0F3HFeItOGsjVylRnPO2UEnkdeQ6+5xEAvtZU=;
        b=LlqgTaYjXs81WrTIW8GZneq/usDsYd2Rm9I+9Rewfv1A2iA6BA9/MswJv13yg0k/mn
         ZEwtwd+rVAKs1WZIXhdioPQ2BDPVdMa2rwsAjjL4tCDjlASihuN6PNjLwP9JSN2209mB
         N22EchU1+848x4n4KaHVNEDaI2vX0WxWKszEYEYd0Uc5fFkUVVuOT3IS6GrPyA8LeV3Q
         S0ByeAZtS17DJdYLytzEQHLIGKsK1Fwm6sl6UwKSjmrI7ggp2r0Biz2AqkFKZ21UQAHr
         Or0aFcbzgCTFlmGQkaeq6OJL5CnzeVcOfF04QMAR8ur43IBEXyoKK856XU3MyUfaQLgb
         sIvg==
X-Gm-Message-State: AOAM531mNJAd/3R4CDyv6CKc0oaeUc87ALyjDiiM8xTAZRK8grDBV2I0
        jwMbbi95nZaEgPTsmycaLURJ1g==
X-Google-Smtp-Source: ABdhPJzvNXl1PcUOW6FQKfrEbSV2N3g7NFs9BjJJRpQsA0oDduxP+Rc9Ye4PU06iybaf8EAmDXo4Vg==
X-Received: by 2002:a05:6e02:1d9c:: with SMTP id h28mr4559018ila.266.1630017493032;
        Thu, 26 Aug 2021 15:38:13 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u15sm2425641ilk.53.2021.08.26.15.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 15:38:12 -0700 (PDT)
Date:   Thu, 26 Aug 2021 18:38:12 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 0/6] tr2: plug memory leaks + logic errors + Win32 &
 Linux feature parity
Message-ID: <YSgX1ON+FvpwPjKB@nand.local>
References: <cover-0.6-00000000000-20210825T231400Z-avarab@gmail.com>
 <cover-v2-0.6-00000000000-20210826T121820Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-v2-0.6-00000000000-20210826T121820Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 26, 2021 at 02:22:18PM +0200, Ævar Arnfjörð Bjarmason wrote:
> An early re-roll due to some very good & early review by Taylor Blau,
> this also fixes the grammar/typo pointed out by Eric Sunshine. Thanks
> both:

Thanks; aside from the cosmetic issues that Junio and Eric already
brought up, this version looks good to me. I probably would have avoided
4/6 and jumped straight to 6/6, but your approach is good, too.

Thanks for being so receptive to my comments (public and private) in the
earlier round of this series.

    Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
