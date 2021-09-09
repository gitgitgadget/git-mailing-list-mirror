Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B945DC433F5
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 14:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A38D7611C2
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 14:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243009AbhIIOsu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 10:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238050AbhIIOsn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 10:48:43 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70839C066427
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 07:40:59 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id a15so2592509iot.2
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 07:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=fo67UKk1vzMGy62wU1oDmfjJjL+BbY7rCq7joYfu/SE=;
        b=Xt634gBOtQQnZmx16nfb6xKHcGgjmvEpZ1IX2y4Inyy85fx5SlyMFR2+9+PyPw5HbW
         Ufl0SNfYWzas5AHUPzrRLeWNzzm8xupGda9wFpnFjlyYRp9sqCAKNZM78gTfIjtorBDB
         RT19rNjUcLffGVj1VKMbULcBdDqkIgbvtqbYRAxTAXqlafBCeqSFRcSSSdjvL8exJ1sD
         449V6LMRM1D3dYXBGKtLum5sZoMbOBnqs3FZB7COOuG61Tevbm3EWMljlBbcyVdXtvwl
         NH1vZg4Kbi2iAK/it4uEppBCKpCINW81ztZkEA/ub3b/kgDsAMTm4oxo2rIJJNlu0EUZ
         QVdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=fo67UKk1vzMGy62wU1oDmfjJjL+BbY7rCq7joYfu/SE=;
        b=CnrAUJVVhgMaMwuD/uBciXA/ZputXya0laFE44T9sT5lJR+ff4SAiVVsPfm/xczQyl
         oD9aiCFMXplDVKYSZZPkl/HtpDi+vM9NhPp6PpBdc+lVqVCE/VqeUIMd+5zTcnmo5AeJ
         rUqx3FMtgVa/EySdkv6kpdlS8jyfl91eIToFe/CDjGDhXmYaFsDYVaGvOXD2NprgtsQd
         /uDKmRsAK146YE8NBC+QRC1vL9vRGIVF8YdsOZb9EYem77shSdWsmLKO9hnS+mJi4JCV
         9RDXBDa5cYoSpScMojic+gS5i+ox2VwufixGZ+ujT6yTOg0s0oPkqW92TsXdqNJ+6Qzr
         ktaA==
X-Gm-Message-State: AOAM5339coL5ceQMWa0/lzt8+5uUz1kb3JzUvS/xYTqq6N+gbZBRFvbj
        OrwT/TuSrasZIBxtQ8Xj9wIITw==
X-Google-Smtp-Source: ABdhPJzpNXfEqVBIK6ue78x19nVkIIRlwy4PvVpRGJAyzcABrxalOGSwvgPqwCKxsNBoQC4MM3/QTw==
X-Received: by 2002:a02:958e:: with SMTP id b14mr114465jai.123.1631198458888;
        Thu, 09 Sep 2021 07:40:58 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id k21sm975749ioh.38.2021.09.09.07.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 07:40:58 -0700 (PDT)
Date:   Thu, 9 Sep 2021 10:40:57 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH 0/9] packfile: avoid .idx rename races
Message-ID: <YToc+W7q1F8IXYK+@nand.local>
References: <cover.1630461918.git.me@ttaylorr.com>
 <cover.1631157880.git.me@ttaylorr.com>
 <874kauf9wq.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874kauf9wq.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 09, 2021 at 10:06:24AM +0200, Ævar Arnfjörð Bjarmason wrote:
> I think it's probably redundant to note it at this point but I've given
> this a thorough review and it all looks good to me. I left some
> comments/musings on minor points in the series, but none of those IMO
> require a re-roll except perhaps the duplicate Signed-off-by headers,
> depending on what Junio thinks & if he's going to fix those while
> queuing.

Thanks, and likewise your parts of this series look good to me
(obviously, or I wouldn't have sent it otherwise ;)).

The duplicate s-o-b's are intentional, but see my response in 2/9 (I'd
link to it, but vger seems to be a little sluggish for me this morning)
for why. If I made an error there, I'm happy to fix it up for Junio.

Thanks,
Taylor
