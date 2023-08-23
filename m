Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF35CC27C40
	for <git@archiver.kernel.org>; Wed, 23 Aug 2023 20:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjHWUBn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Aug 2023 16:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233188AbjHWUBh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2023 16:01:37 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B29010CB
        for <git@vger.kernel.org>; Wed, 23 Aug 2023 13:01:36 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-58e6c05f529so65219657b3.3
        for <git@vger.kernel.org>; Wed, 23 Aug 2023 13:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1692820895; x=1693425695;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VK1XW+MdgyFHvIyMjPVmswcgTXL7dCY20XDN71Bt4l4=;
        b=0iIEsx7xv7EFHh/tD2oYnu7QVE1QyUWnj4xElPUI+vaVW2fz34I4taeleFHJPMBq4Y
         fYc8A/MwxW16+5Ndf5QJx9AGY3/wBvhSVk02zvqG3w2i1I5YPGBTWMoyw5LBfmAGKDMj
         /izYNKPJqj4KRRx2Pc1R4wTzKiSpnSmJjKZOfa84dxDWB3egRnI0vm7s2oSm5O6i+Qjo
         STZixI9qnvq1GjFR6f3bF9Rx8BajSUJmjpUNisQqgIcOQgZu5Dfevivhk+r83IU5buyv
         Ko2ZGW58f3T2Nf6cZDoDIKIHU685nNcYsPaLx6eSnOtWz1BMb+ioDuVlRFInoWqcQRAM
         wKLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692820895; x=1693425695;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VK1XW+MdgyFHvIyMjPVmswcgTXL7dCY20XDN71Bt4l4=;
        b=QydjdLBHvYEIu8HT0bz5CEgQ61wJQfUz50CsXr1PTmTgz6rksDO6gtP8IwOaGFCnmJ
         /YE84yWk9bZffLdRazN9qB3AYWCrpJ0iSB+DJHPSXZi8D+/aqAziYOkzX/GfCp+ZNYkQ
         73S6C+PSJB3/g05I3ZoJcDYm6bBUSVQ0WhCnYW/RjT1F+bOYcbeEEYVF4CqeTJjpePHs
         Q4yOTuaaa3VC3/TPhfSEdXflDna0Hqc5F2vPa9rZLFZFM5roCups+bpkPUGUdLT3XDu1
         ++Ria5HbplNGv3ZD3iV3OAYDU1iI/uxyDzm4pohARfbyEibAKQl50qLdQXD2uZPQ9lqV
         aRFQ==
X-Gm-Message-State: AOJu0Yx+w2hzfJXcrh3AnAWVy819Xre+FwpxNZLxG4xeIcO399QAp1Mv
        P11M4jR1TvvALKRQkPv3xxQEnQ==
X-Google-Smtp-Source: AGHT+IFlsJybdrsHm+oVXFRzJ3hi7nqZe7QFJWwglWX2IB57z7gRHWczht3YxVlH8o8zIm+G+59/aQ==
X-Received: by 2002:a81:93c4:0:b0:584:2ea4:a24b with SMTP id k187-20020a8193c4000000b005842ea4a24bmr14526688ywg.19.1692820895456;
        Wed, 23 Aug 2023 13:01:35 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id p66-20020a0de645000000b00589dbcf16cbsm3540359ywe.35.2023.08.23.13.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 13:01:35 -0700 (PDT)
Date:   Wed, 23 Aug 2023 16:01:34 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3] format-patch: add --description-file option
Message-ID: <ZOZlnu1wC70BFp9p@nand.local>
References: <xmqq1qg9qmyq.fsf@gitster.g>
 <20230821170720.577820-1-oswald.buddenhagen@gmx.de>
 <xmqq4jksoxu8.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4jksoxu8.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 21, 2023 at 03:05:35PM -0700, Junio C Hamano wrote:
> Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:
>
> > +test_expect_success 'cover letter with --description-file' '
> > +	test_when_finished "rm -f description.txt" &&
> > +	cat >description.txt <<\-EOF &&
>
> "<<\-EOF"  ->  "<<-\EOF"

I'm late to the party, but this was the only thing that I noticed with
the patch, too. The rest LGTM.

Thanks,
Taylor
