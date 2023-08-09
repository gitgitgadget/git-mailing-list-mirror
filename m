Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B0A8C001B0
	for <git@archiver.kernel.org>; Wed,  9 Aug 2023 21:18:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjHIVSz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Aug 2023 17:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjHIVSz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2023 17:18:55 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8F410CA
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 14:18:54 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-586b78aa26eso4057137b3.1
        for <git@vger.kernel.org>; Wed, 09 Aug 2023 14:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1691615934; x=1692220734;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YGrNoPQUedQkkgYkmsDm8ZtQVLsleZIGiaSmuCMEpLM=;
        b=KKQnofc6NKTKPn29F4UiXQYopT10nxLOY39AruSrfTEHwqSpCfJrgQ/ynwVL75Xus+
         BwJx8ImPzzahAFhVu9qUNJaV2wWnP01FrD2D9aINmIQ6ADbXJb6eHsY3KTVlZqJBvpVS
         +S/BmTWhG1jTE1k7u0JRitAJTUtQP2B/Ln0uqJJ2HoVniXXtHJGSE8YetspfoT/gMfDl
         XJo7kZm29MfjHf5AH03ti0kE+x947dOURw8RBiiAzciAJkjucCiNxX5IY1uIrV89p0Vf
         O/tiq7I+WBLCR2JilCNywvri5xbGUmMfKEMrv2g+V08tlZB03hpSfPF7SV3rtggQ1+ow
         6R8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691615934; x=1692220734;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YGrNoPQUedQkkgYkmsDm8ZtQVLsleZIGiaSmuCMEpLM=;
        b=FxqpI2XKOSogy0la443cbTVhZgHvHabcVZElsXplKS27bVyona69x2k96dV+qyQzxT
         4PvxwYa4v5DWAaekB4wiucT2HQZMUWdk06i3so/MA4iw/gIqk6V5emEYrzFJPElrlEIi
         d1uG6TBfayqJb2c5Wt1aSW6P+U3rr9krJSEsBodKg0HGIEFwf+YvFZHqumS5uDmVx677
         R+crG3dVPgEI3HSP/pPXHuxdPRvbirTeLm1q9Jo1AlDoCrubbvdUFo5RGVMikRbz1SNg
         csMFVc9Utub6Rmdxj633LyOJfkcotvy9KDAa6BScRRGQlWTJK+sMHgUN654IUu4IBjW5
         03Zg==
X-Gm-Message-State: AOJu0YwawgCHfTxO+4FO0OLI+kqpBTQ4IRS7qi+vOmI3qjjllbkdvjeo
        kmt82GxLNV/VtDI++hZ3OKyVVw==
X-Google-Smtp-Source: AGHT+IFmwcCViXH626kZ9DMHBK2lIpPK/Smk11XDwgUqUY8BCCK7I3HLcfF6dgdirZRCold76DPARw==
X-Received: by 2002:a81:a083:0:b0:56f:fa68:2e34 with SMTP id x125-20020a81a083000000b0056ffa682e34mr467268ywg.35.1691615933808;
        Wed, 09 Aug 2023 14:18:53 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j132-20020a816e8a000000b00586b5fa42c1sm3597491ywc.98.2023.08.09.14.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 14:18:53 -0700 (PDT)
Date:   Wed, 9 Aug 2023 17:18:52 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v4 2/8] t/helper: add 'find-pack' test-tool
Message-ID: <ZNQCvEJif4/VooyD@nand.local>
References: <20230724085909.3831831-1-christian.couder@gmail.com>
 <20230808082608.582319-1-christian.couder@gmail.com>
 <20230808082608.582319-3-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230808082608.582319-3-christian.couder@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 08, 2023 at 10:26:02AM +0200, Christian Couder wrote:
> +	if (count > -1 && count != actual_count)
> +		die ("bad packfile count %d instead of %d", actual_count, count);

I think there is an extra space between "die" and the opening
parenthesis. But obviously not worth a reroll here.

> diff --git a/t/t0080-find-pack.sh b/t/t0080-find-pack.sh
> new file mode 100755
> index 0000000000..67b11216a3
> --- /dev/null
> +++ b/t/t0080-find-pack.sh
> @@ -0,0 +1,82 @@

These new tests look great, thanks for adding them :-).

Thanks,
Taylor
