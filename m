Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 346BCCDB47E
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 21:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233451AbjJKV06 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 17:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233390AbjJKV05 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 17:26:57 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF2890
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 14:26:54 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-66d093265dfso1520746d6.3
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 14:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1697059614; x=1697664414; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eYaO8ZXMtpwJ8BnMvMdKFuxlhGNjlyS/lSXUkY0puJo=;
        b=hZqN7uuQY1JHrh4SbibqhdPvhN5X1NGiZwW5D3mk38qJguBPHuQT+UNush0rf/Qcnd
         7IPQP4n1IUcJ3rgIizL3z3N8MCj4dDOIOnzzRRKeQdM0AEiFPTdgMz5NTYEhqUJelXgS
         +Hv6RnQbZSykgGOUaMXOeh95omdmAgU6TghRYcIvJGxoY614pNT+6MDw8poP/8hXpY0y
         3yzdrfDz3EfPknLRPatU+EkQOYJquUcK39jHlvaaHyyXLk4GA3lrcXWjhjTmbwOXNVhG
         OkQyBCS8DHlHKUCRhUhwqp0BrlwOkDy4JSOShn22eaL+HeQyEusVXW1skIMBjYdXa8zy
         9WLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697059614; x=1697664414;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eYaO8ZXMtpwJ8BnMvMdKFuxlhGNjlyS/lSXUkY0puJo=;
        b=IxJnmD1NhRLYR0J6c2iI2/75a7264vCGr2OiGvQnV3YBlibnCch3rVI0QFEVzHuwnX
         PpEXfwG2r3aMYZOKcpT1W4BACtOeED2qQtvuy6rJwrEKWTCHMAX4iFImrP+l+2ttew20
         db6sNK4LQ8IkRQw+8RCtEJiywELhArc4+N4ypllvbAEfibiaQa1nXdIowvg8R+v2SeCs
         X6fclCFCdpCZoKDtYvPbOGvspeifiqJDLTw/AsXL03vXymyOK63EPrzM0pvEQm+4GJH0
         ttynS+0HcGegKH59dsGn5m/QFtu1hnikOeaDZ9w7dMb2VChu89NCsyQa9TYFzBHFtYlR
         Vwuw==
X-Gm-Message-State: AOJu0YxRh7dlzH55p522tMpZR7a0oRItEWThPjhWxl27hcyW5X7vXXAZ
        vtrdnFoQ10S75fvY+CC2MaH2xw==
X-Google-Smtp-Source: AGHT+IEChnAZRV10iW+C5XTdLwkQL863+SaDkBhrte/NnyH+rjwSFluqkh41UGq4bJnD3zrBULY1Gg==
X-Received: by 2002:a0c:da02:0:b0:66c:fd11:14dd with SMTP id x2-20020a0cda02000000b0066cfd1114ddmr5797583qvj.29.1697059613957;
        Wed, 11 Oct 2023 14:26:53 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id b7-20020a0cf047000000b0064f4ac061b0sm6015049qvl.12.2023.10.11.14.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 14:26:53 -0700 (PDT)
Date:   Wed, 11 Oct 2023 17:26:51 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Robert Coup via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Robert Coup <robert@coup.net.nz>
Subject: Re: [PATCH] upload-pack: add tracing for fetches
Message-ID: <ZScTGyI/XVveu4M7@nand.local>
References: <pull.1598.git.1697040242703.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1598.git.1697040242703.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 11, 2023 at 04:04:02PM +0000, Robert Coup via GitGitGadget wrote:
> diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
> index d18f2823d86..bb15ac34f77 100755
> --- a/t/t5500-fetch-pack.sh
> +++ b/t/t5500-fetch-pack.sh
> @@ -132,13 +132,18 @@ test_expect_success 'single branch object count' '
>  '
>
>  test_expect_success 'single given branch clone' '
> -	git clone --single-branch --branch A "file://$(pwd)/." branch-a &&
> -	test_must_fail git --git-dir=branch-a/.git rev-parse origin/B
> +	GIT_TRACE2_EVENT="$(pwd)/branch-a/trace2_event" \
> +		git clone --single-branch --branch A "file://$(pwd)/." branch-a &&
> +	test_must_fail git --git-dir=branch-a/.git rev-parse origin/B &&
> +	grep \"fetch-info\".*\"haves\":0 branch-a/trace2_event &&
> +	grep \"fetch-info\".*\"wants\":1 branch-a/trace2_event

Not at all related to your patch here, but I feel like we have a bunch
of these greps sprinkled throughout the test suite which serve to
inspect some key(s) of a JSON object printed to the trace2 event stream.

It might be nice to have a more robust test-tool that could do this
heavy lifting for us instead of having to write these grep expressions
ourselves.

But definitely outside the scope of this patch ;-).

Thanks,
Taylor
