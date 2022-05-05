Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384A4C433F5
	for <git@archiver.kernel.org>; Thu,  5 May 2022 11:21:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238682AbiEELZE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 May 2022 07:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234449AbiEELZA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 May 2022 07:25:00 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462674BFCC
        for <git@vger.kernel.org>; Thu,  5 May 2022 04:21:20 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-e656032735so3921440fac.0
        for <git@vger.kernel.org>; Thu, 05 May 2022 04:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/C2gKTgl2/9v0nIW/htbcngSPcM2nAIWXFaX7bv4Gfo=;
        b=Ykp+yjFmIFmyUNnbT+iVKCsE/PTLiYXXaR5A30RN6MS02yEWNXy7yZVYGLsotrFmV9
         +aE7uTog7t8c/o9ET5/7x7GdXsVNNOynul6yiSRvaOeE1JYr+GwWLM40wMvpolvIFl+j
         rTVRGk1i3ME9p/RvJIsf3B101ZAfgQB492zgRL8uTMErZGQYyelLwSuLfUOfoVIryWRf
         7b6itxiSo4XQ/3zCcJ7EwFuoh+aTgSAZ6h7CYJEseoJqN5UzBKROIYeh5oEQV9V1ezn7
         4eY8NQRl98yyq69h3DBBUmJi8byq2XnHD2F5iGFLYIzBNgY/+4YPeWHHmwIfOPOHCtp4
         g+2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/C2gKTgl2/9v0nIW/htbcngSPcM2nAIWXFaX7bv4Gfo=;
        b=J6xrUSe8LOKuUH+a9uQ9W27jQduyn4KnnZfXUl9pMRQLEaVR11Cki4svKzjib2uKoV
         rRbh5kYSG4owXWI5x1FJM1uaBvJd+1mh3+6p+toWxS7wO42ES3Hb5lRQ5p6TJggYV2Xt
         qGnSIOCwVWprkg1gN07Ix3X5ILiZdAQMlqajKh0TkIKnC+UIe+f9E/3qiIRdInX8EvFd
         2Kxv4o1F3FbnAEw2xkKKk59odzLpYbONolYVsHhSL+3Jj+dtQRYTUxdinEHx/XUlnT4z
         eBPy1XnTlmQ2qGgEKQyYGZygpn0PE3NU4Qd7bwqwZaplKK61XiLu3PGYGnSZJ+1d2aKx
         G3JA==
X-Gm-Message-State: AOAM530cORa4nciidnZkv9DrNiZehenT5p2H8joj/VfRUU9RPGiB+Qd2
        +yl02/wyoYN1o0+JX3AIZ1B+ZSUqlpM=
X-Google-Smtp-Source: ABdhPJwqXgVHaWPDZXCzxGEXdfv+pqA0ydct9YJCsQi0qExVx3cZy5VSzoimnfN7worO4OrPyP1kCA==
X-Received: by 2002:a05:6870:8a25:b0:ed:9fa4:8dd3 with SMTP id p37-20020a0568708a2500b000ed9fa48dd3mr1853105oaq.1.1651749679536;
        Thu, 05 May 2022 04:21:19 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id b5-20020aca3405000000b00325cda1ffb3sm520376oia.50.2022.05.05.04.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 04:21:19 -0700 (PDT)
Date:   Thu, 5 May 2022 04:21:14 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2] http: add custom hostname to IP address resolutions
Message-ID: <20220505112114.ktki3dgjbyukzhlm@carlos-mbp.lan>
References: <20220502083639.610279-1-chriscool@tuxfamily.org>
 <20220504104601.136403-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504104601.136403-1-chriscool@tuxfamily.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 04, 2022 at 12:46:01PM +0200, Christian Couder wrote:
> diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
> index f92c79c132..d97380be87 100755
> --- a/t/t5551-http-fetch-smart.sh
> +++ b/t/t5551-http-fetch-smart.sh
> @@ -567,4 +567,11 @@ test_expect_success 'client falls back from v2 to v0 to match server' '
>  	grep symref=HEAD:refs/heads/ trace
>  '
>  
> +test_expect_success 'passing hostname resolution information works' '
> +	BOGUS_HOST=gitbogusexamplehost.com &&

minor nitpick, but better to use example.com here which is reserved for this
type of uses and therefore unlikely to conflict with a possibly assigned
domain.

Carlo
