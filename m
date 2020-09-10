Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB6BC433E2
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 03:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6C962080C
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 03:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="xnfiGpbz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbgIJDgM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Sep 2020 23:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbgIJDgD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Sep 2020 23:36:03 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94ED0C061573
        for <git@vger.kernel.org>; Wed,  9 Sep 2020 20:36:01 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id e7so3752928qtj.11
        for <git@vger.kernel.org>; Wed, 09 Sep 2020 20:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LlP/MhkCSyc2B2WP+xn5NkLbz211Nz7khUWUqV1WM28=;
        b=xnfiGpbzUpQ614QvU+L+udFwWKN+KcUMNbG6L/iZ4GL5h97+tr0oOr2a82ViVZuci1
         Gf1/Z6zHELBP6PiRH3ENr6mO8WEawMoBB+I11QoZNMK5IYEhwKj7ZLJuTGOoTlROLXGf
         Wm5W1IewuAiqpNcn7ytlPuHiJ/ne/snW/3u/l29A64KpaeHabzV2fRay6it/WiH+69Ds
         zncJtwo79uWi/fjFpwLqRj0uIwNV+cx9b/FYBM+vZ+DaKLtmhtfr7t3p0iyFSSOPpvpM
         Vqq1l/W53DHzndLeJEvnqBc0shtsDaefjGg58S5bQvxs59A7dJR0Fy2N3I/K0vNPpJRk
         iE2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LlP/MhkCSyc2B2WP+xn5NkLbz211Nz7khUWUqV1WM28=;
        b=j0oWhnd+w/KosDQWcVFBhDIDJeNwKrvnEZwKt/TR4oQ/lmguSV1+gX9OvKw3DE3Zr8
         azwm72J02P9jWBTbD8/6bv0+yS7N1I6dyQSwuEH8RnsIDRQ6RYXkQIsRV8SMfFRJAiIs
         XJru+P9Mo4ZWs8v/ocLVO35rCAA2d4+j/jXKXZZlpx0a/N8wLQXae/IUaXuxCyF6RGDN
         MSsFPTj8TwIZ6XY1k7o6i1VmXwgrruu0HczwQBC0lSw01oCAVy+/8HZW6V6eqbAHdaxQ
         W80jwIREsmPCaeKWEd9JPuYHRYDYDLnsb/5VREA+F8iFYcahXfvbhcaXMeFmRh4RvaPb
         JWtQ==
X-Gm-Message-State: AOAM532ayTYG4x7hjB34ptfhnN7CiZMddpfVt/udkpKy/yLXhwVat8uP
        kV84/x64HKdU2t85ZfvQuziD10PNcqAQUOk/
X-Google-Smtp-Source: ABdhPJxD1sPC7VIxvlmHmf7IMsvimfEPJUMju4x24otXfxCVjnXAbCqPhZ8MS5zoQovNfpi45EKvEg==
X-Received: by 2002:ac8:376d:: with SMTP id p42mr6210940qtb.288.1599708960761;
        Wed, 09 Sep 2020 20:36:00 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:b02c:9c0a:1a83:70bb])
        by smtp.gmail.com with ESMTPSA id s20sm4814424qkg.65.2020.09.09.20.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 20:36:00 -0700 (PDT)
Date:   Wed, 9 Sep 2020 23:35:57 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
Subject: Re: [PATCH 10/12] bloom: encode out-of-bounds filters as non-empty
Message-ID: <20200910033557.GA2178@nand.local>
References: <cover.1599664389.git.me@ttaylorr.com>
 <1c993b83980e77594b0de2b1884cbc4cf484f9ab.1599664389.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1c993b83980e77594b0de2b1884cbc4cf484f9ab.1599664389.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 09, 2020 at 11:23:48AM -0400, Taylor Blau wrote:
> -		filter->data = NULL;
> -		filter->len = 0;
> +		filter->data = xmalloc(1);
> +		filter->data[0] = 0xFF;
> +		filter->len = 1;
>
>  		if (computed)
>  			*computed |= BLOOM_TRUNC_LARGE;

Oops, I missed the case that added by the previous patch where the
number of diff entries is smaller than the limit, but the hashmap
entries (after directories are added and such) crosses the threshold.

Specifically, this patch doesn't write the 0xFF filter like it should.
I'll send a different version of this patch tomorrow.

Thanks,
Taylor
