Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD47C5519F
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 19:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19772246B4
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 19:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="CLqfa0Fy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgKRTwG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 14:52:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbgKRTwF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 14:52:05 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C372C0613D4
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 11:52:04 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id 63so1653304qva.7
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 11:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Gzgscs9ibDf4X2MmTzIR9bxc0hoau+JkmLBS3Q2LlR4=;
        b=CLqfa0FykIUOMQaE+Z9iqsxd+cJrssnJClJ3i6oIrrzFGDgrcUfVljz38JAz0h5XDF
         R0c+1DhDRNffAh9BuaPcAParYLaCj8vh9bIC8jBKb0XKl5CwEMPUO+Vp+ZT/vBf/ZFqJ
         Q8m8C0QFEYH1WFAWxhKtLz3Anv/o4HUiQUqkI2G51+Nf204t08osK+u4RznWFEToRJq/
         e/ll+OkQVZWnC1p3yxzwt2H3aNEj0RL3o5XsOzLGmT/fOYgc5k4wnQW4bsk9Po0kSc+L
         u4WnnVBIgVb2ETTiUllfkq53aLpywbXE39NI5SEivzhK8aZCYI4yB7s0LBC1Hk+ZCaIt
         8uFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Gzgscs9ibDf4X2MmTzIR9bxc0hoau+JkmLBS3Q2LlR4=;
        b=XmVyZQvBrFfiMnmVo/kY/topoSHUBIYxPU6oKd78ZFHqGZqdPefyJoE/WRLFpai+ZR
         RsLlRTg/T5RZ/gtC6v/fdqpIoC4Chp7Mrak4XnQ9eYHxcMOmN+V15FZvRKncw3JuuU4n
         pBmw0N1ltTagY8YDItm0ckuKGejWdfDdwRTbxvsC+LLJr1OGslAj1mwZq8/dS8pZaryG
         b58bbmewzcY9ag1I/9IQILh0Usjrknbsrc75xGGnkdWt43cv07xQkMuwW1Y6W9f5ggDM
         zYto5jPeWIHYR0Yd/0egwlsnFMPh4YWRUgD9zd7eqxkp6LkzmMvoDW8EYCU5IPgUzwpb
         Suyg==
X-Gm-Message-State: AOAM530FxSI6rk4ovYA/WpQauj8t3DkNba3rXd311a5e7wkMdIPjBs5x
        YlRp+sYHwQSUr6+M2wYNUjR4gw==
X-Google-Smtp-Source: ABdhPJypxr1WFy10DNPF+IaIj/y9VxgFOVEJwvTDfxBlq1S/359uXu6XGMZaNNnifVjPcW40Lagv3g==
X-Received: by 2002:a0c:f981:: with SMTP id t1mr6218054qvn.60.1605729123337;
        Wed, 18 Nov 2020 11:52:03 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:7fe5:c4d6:f587:dc1f])
        by smtp.gmail.com with ESMTPSA id h142sm1199305qke.104.2020.11.18.11.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 11:52:02 -0800 (PST)
Date:   Wed, 18 Nov 2020 14:51:59 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        martin.agren@gmail.com
Subject: Re: [PATCH v2 00/24] pack-bitmap: bitmap generation improvements
Message-ID: <X7V7X/qDfN0udr2u@nand.local>
References: <cover.1605123652.git.me@ttaylorr.com>
 <cover.1605649533.git.me@ttaylorr.com>
 <20201118183225.GB8396@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201118183225.GB8396@szeder.dev>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 18, 2020 at 07:32:25PM +0100, SZEDER Gábor wrote:
> On Tue, Nov 17, 2020 at 04:46:16PM -0500, Taylor Blau wrote:
> >   - Harden the tests so that they pass under sha256-mode (thanks SZEDER,
> >     and Peff).
>
> Fixing this is good, of course, but...
>
> > 16:  86d77fd085 ! 18:  5262daa330 pack-bitmap-write: build fewer intermediate bitmaps
> >     @@ t/t5310-pack-bitmaps.sh: test_expect_success 'setup repo with moderate-sized his
> >       '
> >
> >       test_expect_success 'rev-list --test-bitmap verifies bitmaps' '
> >     +@@ t/t5310-pack-bitmaps.sh: test_expect_success 'truncated bitmap fails gracefully (ewah)' '
> >     + 	git rev-list --use-bitmap-index --count --all >expect &&
> >     + 	bitmap=$(ls .git/objects/pack/*.bitmap) &&
> >     + 	test_when_finished "rm -f $bitmap" &&
> >     +-	test_copy_bytes 256 <$bitmap >$bitmap.tmp &&
> >     ++	test_copy_bytes 270 <$bitmap >$bitmap.tmp &&
> >     + 	mv -f $bitmap.tmp $bitmap &&
> >     + 	git rev-list --use-bitmap-index --count --all >actual 2>stderr &&
> >     + 	test_cmp expect actual &&
>
> Please don't simply sneak in such a change without explaining it in
> the commit message.

Ah, I certainly didn't mean to go under the radar, so to speak ;-). From
my perspective, the final patch looks like it picked a magic number in
the same way was the original version of this patch did, so I didn't
think to add any more detail there.

I did try and highlight this a little bit in the patch just before the
one you're commenting on, though:

  - Adding more tests in this area. Testing these truncation situations
    are remarkably fragile to even subtle changes in the bitmap
    generation. So, the resulting tests are likely to be quite brittle.

Thanks,
Taylor
