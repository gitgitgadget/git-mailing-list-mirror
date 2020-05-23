Return-Path: <SRS0=yx/J=7F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6220CC433E0
	for <git@archiver.kernel.org>; Sat, 23 May 2020 01:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 285212072C
	for <git@archiver.kernel.org>; Sat, 23 May 2020 01:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lh2Fkm58"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387517AbgEWBxf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 May 2020 21:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387481AbgEWBxf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 May 2020 21:53:35 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BEFC061A0E
        for <git@vger.kernel.org>; Fri, 22 May 2020 18:53:34 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id t8so3701241pju.3
        for <git@vger.kernel.org>; Fri, 22 May 2020 18:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=b3OqQciWlGTiSAKsuircU5lL1r+Pu3mQiu4zyej7rmY=;
        b=lh2Fkm58lavVcNV2buDFqmnEF8tA8HqLu58ACu50mjMFDYh03gFI9ZQSd0yWOZMp2H
         DiI6SpiK5ASKQ3EsPmx+w5fgG0O4qFLlekrdUEg+DrOhtDiPAQWfVjhixEBeD/FZHAnI
         Io3m1auu+BUzGoprhi21VLvOEwRLEd8t4Q+CqFuF2j1mAfPn5ZdkaR/+kMHDOc8qlOfV
         zasCQdgz9OPZxuHsLfuiLDYvRZ+nlwfrdw6v3l1xGDKpuyOmKJ+JVXGuJzGzKcPirbtZ
         neBdjUldAg2c446LMZOJwiHBoOJ2HNGg6qlRcWmut76T0AiIq64b8NYUhQdaPbSbzr7Y
         1MkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b3OqQciWlGTiSAKsuircU5lL1r+Pu3mQiu4zyej7rmY=;
        b=sp0k+airJZVh0fbuibpwOwyK8iuP1N8WpUF1R4xYMoMBUek2wmHh4PgsR0XjpTvI+4
         Rov71WL/pPAA4pS7dkABTXsPdO//39+8L2EKxU0LUYBwxINgrTIUo//fIYIbUe0pxpmo
         eG42m2nf2S2W47AZ0pKCwHftuX+3liX7191R4Sg79ECBIYN63yB25x9UKZa35PVjpyqE
         O9keq20Sm8p7jIuIWAhab+QJiQTIYnGnBfYHDsGwhAMKnzddbJYABJIn1lX30ltJh2bq
         9gT/ZkWnYJBDQQ2+jicrTZaNhl9eIkrttRq9R48r8zw4FYTolCfSu6EAwxJQ8M3dpuer
         ArBQ==
X-Gm-Message-State: AOAM531+U+I2tFQ07+epJo0E9ky5oo9p3NAYE35VEf7T4yqDD431DwSg
        fRDSHrSYot09BvrM0S1FkNTjeGDJ
X-Google-Smtp-Source: ABdhPJxCHCoMu5mSht2bCQVHUhBI/b5W2PLjrerBY+KthkrbmccRy9ZmQ+tMtpDQLpek/8tkLqtktg==
X-Received: by 2002:a17:902:724a:: with SMTP id c10mr17294646pll.223.1590198813622;
        Fri, 22 May 2020 18:53:33 -0700 (PDT)
Received: from localhost ([2402:800:6374:cd6f:3908:64aa:a24d:1be1])
        by smtp.gmail.com with ESMTPSA id d15sm1721110pfh.175.2020.05.22.18.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 18:53:33 -0700 (PDT)
Date:   Sat, 23 May 2020 08:53:31 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Miriam Rubio <mirucam@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 03/12] bisect--helper: introduce new `write_in_file()`
 function
Message-ID: <20200523015331.GD3283@danh.dev>
References: <20200423070704.39872-1-mirucam@gmail.com>
 <20200423070704.39872-4-mirucam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423070704.39872-4-mirucam@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-04-23 09:06:55+0200, Miriam Rubio <mirucam@gmail.com> wrote:
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 0fbd924aac..d3b2b33df0 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -74,6 +74,28 @@ static int one_of(const char *term, ...)
>  	return res;
>  }
>  
> +static int write_in_file(const char *path, const char *mode, const char *format,...)

Nit: It looks like we want to add a space in the end ", ...)"
Since "one_of" above also has that space.

Otherwise, look good.

-- 
Danh
