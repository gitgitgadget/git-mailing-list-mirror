Return-Path: <SRS0=KP1k=5N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97600C43331
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 22:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D7AB2073E
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 22:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vEvAvb9n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbgC1WXr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Mar 2020 18:23:47 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38415 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbgC1WXr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Mar 2020 18:23:47 -0400
Received: by mail-wr1-f66.google.com with SMTP id s1so16333604wrv.5
        for <git@vger.kernel.org>; Sat, 28 Mar 2020 15:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=gR0iuoiyoMDBivrt28CmMVg/JmvwAQRFPqF2+WJvmDE=;
        b=vEvAvb9nUpNzw0eq9qTA+0vVG2XHNZPhYc1Q5SdJWEOkptwPV2d1BvI7tF/oVIjPuD
         3C9G1DE8ucJc9uCF+DgoyK92GxXHLLPAOaQN37rKJ6r38qICapFMzESO/kBASPjBeTr5
         1tWYgcFxBVjHDbWLGbCJXsaw+K4tOHjJnINJJjlw13S95C4L8QvL51ZnmgV/ce45MTvP
         KsRqbK7NeU/aICz4X48ckJzz5lqb57Nz4KGfXJo+G1wsYdEFblGXoPGv1imdWTR+2ecB
         dPQE869DIPHStY6fVh1W1N361ji2I+omeyhouq337A+rhoPCiIMgRtE3r6CQhUFALIBL
         QYmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=gR0iuoiyoMDBivrt28CmMVg/JmvwAQRFPqF2+WJvmDE=;
        b=J5MkEtauPAk4DT8jPeS4bsm5VPiPsp0rvTlqP2IUKO78MgakrQ2y3Qt4Xs0uwyuPIE
         AIlrCqUoEIdkWdNvalZ44xAY7mkQI7+10OCy6eXfmsu6A6CDsLuU6IbBmCX33lcAHDE8
         fFaQTfNSqop6B8k+egJRwF3oaEs4k7sS88AEAGAZIN16BUP4ntdYyXr50SD//55yV1IX
         R3kizeDhKFMZ3o2beoTXCFsZBXWWA4uj7DKpZby45uPHb48DLcWRkjX1q096U1mQcb4X
         w5wGCKMcRAy7hDt2JIzf1q43XhqlYtMFIt7mGtp8C2N1buLGW7fyAlDDU3Bnf0EQEqmj
         ztRw==
X-Gm-Message-State: ANhLgQ2EI25beNQhbUB4D50reBc9G94kAuyds27rGrelKwuLOOkPMlsc
        Seebq8DpG7JroYqJIwG7mhI=
X-Google-Smtp-Source: ADFU+vuvAimXjcUkXuG5Al+ED7g5Y8iBGxepmds4qkaTzI7e74X9VAG0+wzpl0Vi6lWbdhQrZN8Kog==
X-Received: by 2002:adf:dd05:: with SMTP id a5mr454471wrm.18.1585434225181;
        Sat, 28 Mar 2020 15:23:45 -0700 (PDT)
Received: from doriath (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id w204sm14239253wma.1.2020.03.28.15.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2020 15:23:44 -0700 (PDT)
Date:   Sat, 28 Mar 2020 23:23:42 +0100
From:   Damien Robert <damien.olivier.robert@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Derrick Stolee <dstolee@microsoft.com>,
        William Baker <William.Baker@microsoft.com>
Subject: Re: [PATCH v4 1/1] midx.c: fix an integer overflow
Message-ID: <20200328222342.jfxsk3gvujgqdt4f@doriath>
X-PGP-Key: http://www.normalesup.org/~robert/pro/files/Damien_Olivier_Robert.asc
X-Start-Date: Sat, 28 Mar 2020 23:18:57 +0100
References: <20200326213534.399377-1-damien.olivier.robert+git@gmail.com>
 <xmqqbloiitnv.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqbloiitnv.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From Junio C Hamano, Thu 26 Mar 2020 at 16:27:16 (-0700) :
> I think this is underflow & wraparound, but I'll let it pass ;-)

Ah thanks for the 'wraparound' term, I was missing it, so that's why I
wrote overflow instead since everybody understand what I meant.

Mathematically I think of this as a truncating in the ring of 2-adic integers,
but I did not want to write this in the commit message :)

> The patch looks good; will queue.

Thanks. I just sent a v5 with a microfix (which is not really important, so
v5 can be dropped). Since pu is subject to be rewound anyway, I guess you
prefer a new version rather than a patch on top of v4?

-- 
Damien Robert
http://www.normalesup.org/~robert/pro
