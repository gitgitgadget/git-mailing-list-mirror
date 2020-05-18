Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65ACDC433E0
	for <git@archiver.kernel.org>; Mon, 18 May 2020 16:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FBAC20758
	for <git@archiver.kernel.org>; Mon, 18 May 2020 16:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQjSySpm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbgERQvK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 12:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbgERQvJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 12:51:09 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060F6C061A0C
        for <git@vger.kernel.org>; Mon, 18 May 2020 09:51:09 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id n14so10765511qke.8
        for <git@vger.kernel.org>; Mon, 18 May 2020 09:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VH6slfCKTMLpUl5ANsHbXJmnVrNfkzHZmuSKMc09oPQ=;
        b=KQjSySpmgYXh3wLKEgwIqqciOMXhKyG07F//cr6WI8Hwkc/hlqmYTq8v9lUNdBaE1K
         ALiprIHvt3Y5EO3xPBfkrbw5+yEZlx5IJLNO+daeNzftG/8m6+mpy4rtxFZKjpwsYgjW
         +cDx/GiHHj7dP4IHHcVngUOHbrqym37jXw114Jp9NHsOoH22Bi2DuNNuHHSR6xbveFz6
         CBjSM0hQZsdjTZ5Ffj+/awLBn/WRph+75OeMHN6SfngXR5zftxHC6jauIS516SdNctjZ
         iHtKhGS42QE260MIQ5pc0qh+6ahV0hsLyVkxLN1b/v0HAArpLVITvb7eYzWSApwLPB0f
         Y9Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VH6slfCKTMLpUl5ANsHbXJmnVrNfkzHZmuSKMc09oPQ=;
        b=hAUopBS1GN1WuRI4OqmYhHWlVYRpb6aG+7G5dQs8UIPqHbSNpBdvKqs3vn4Ywq67lU
         BnW0XkJb0NtGK9MjRDSmEcvM8zUrsvPqXW8LmQO7HJC2SyUWBe+hrobq3ZBlCSOFPyOK
         Q+nFRQkLmICNdnaPDu7yWj45DqLYNAkJyulbgrzsgx8qCf4g6TpVzB1fPqIN7rXZEREt
         JiC1y6Ve2E0ThPGlzUFG5GO0uc/fecDgQxFYYkkksLR+I3wZyJWxoiUF7hvoRzIXRZEz
         y5OfZ8ltTxKFMjethh+vW0kS9HTFp6w87EqYHX4/wjPzW1Dx8Hk4Lgm3EQJz2CMFF2hO
         advg==
X-Gm-Message-State: AOAM532CvhfngtP5H7+7rl0dfwkmI8kyq44yZfEv2NHrH87ad1bqDJWk
        6rih7+I7g5VqGUaCp0ZdK/A=
X-Google-Smtp-Source: ABdhPJxfREvpeBQA/iPO1mI+MPr1Hpqc7gRDNDTk+wA1zbcFIWN1Gf9gGvpfE5rahaQ6N+UhXZdaTg==
X-Received: by 2002:a37:544:: with SMTP id 65mr6341851qkf.115.1589820668308;
        Mon, 18 May 2020 09:51:08 -0700 (PDT)
Received: from generichostname (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id e3sm9637673qtj.25.2020.05.18.09.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 09:51:07 -0700 (PDT)
Date:   Mon, 18 May 2020 12:51:05 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 5/7] remote-curl: error on incomplete packet
Message-ID: <20200518165105.GA2461535@generichostname>
References: <cover.1589393036.git.liu.denton@gmail.com>
 <cover.1589816718.git.liu.denton@gmail.com>
 <52ce5fdffd6741eeee8d69b804403383da0d879d.1589816719.git.liu.denton@gmail.com>
 <20200518162225.GB42240@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518162225.GB42240@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

Thanks for reading over the patch carefully. It is much appreciated :)

On Mon, May 18, 2020 at 12:22:25PM -0400, Jeff King wrote:
> I'm not sure if it's worth replacing "4" with ARRAY_SIZE(state->len_buf).
> I generally try to avoid magic numbers, but it's certainly not like one
> could change the size of len_buf and this code would still be useful. :)

Yeah, I'm a bit sad about all the magic 4's that are strewn in the code
too. I was thinking about consolidating all of the magic 4's into a
constant in pkt-line as a preparatory patch but I didn't want to risk
holding up this series. I think once the dust settles here, I'll go
ahead and do that. For now, though, I think I'll leave it as is.
