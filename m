Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6697C433EF
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 21:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8075C60D43
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 21:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbhJ2VxO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 17:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbhJ2VxL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 17:53:11 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82599C061570
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 14:50:42 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id r8so5981359wra.7
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 14:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=vfPhEnGlGzUVo03Nv777AUYyivNngehlJI2ezXJeM5c=;
        b=eZKjoR4WSp65+Ju/RFhF0cUEazgXL4rMgH3hMNqvZ7TvY1cwuDUktPbuNEcofVHfb+
         7E6TPjwVM0GpxIAHpbmPqtIjnVoXI+jpu8wQZi97EsqlSLZ3nJXctaNqxvvP6yPYkcKv
         f8V6RQ8jQ6WKQKm7iXbbwMQzYFG22lEtX6sSDuVhXN6pQAF6mA3mqupfn9W792D0K0e0
         glnbhXFl6RhpDkkuPETmyTM9EV5gD39jc1DK+3XitQDMg1QSp6gocllQ79lR3j6fmEWm
         2g/ygfla1hBQlE0n/nvUtWvJk1AgqEWLjnl8QQv6/iPWrpUFsa3NXQ0YEP2DCLCK6qnv
         9qDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=vfPhEnGlGzUVo03Nv777AUYyivNngehlJI2ezXJeM5c=;
        b=RJ+MBnr7j+AdakiPzH2qplOWSh1fbOdrUaq5nQtwoG4X/g8p6V5MrrdpXGSdLk4Ax0
         OzdkRfCR68mz9cQccFEVDVcWRsLV/88OQkW1FYQbfs7Lz6KtMHcBygGIPIrHA6TNQeTn
         gOoqlV/fLP8u/T5jv+hbMOVuk/nzgqG42cn1V5M61E8ZEjQitg6OZMXSDj22GdTiWzLZ
         am6ZuU41z/4kwbAKt4CwBijBr5neMy61N1OP9OMm/sr1KbdtOACV5mBNHnKg+KPms+7d
         XSj2hK0h37vZnjk2oTRhihw/OZZSBFtwKLxczzGtgFZQhJLLuVphhPqzmmtM7c8A3gBk
         bIBw==
X-Gm-Message-State: AOAM533wnyb7quy7ibvH+zOXnUiscrhfqIKOuvvnjfsuGIWT9YQJl2GM
        Oq0KCZB+Rk4MchdodlaXTgoSW9dg8AG8ZA==
X-Google-Smtp-Source: ABdhPJx8IThtlalYs4tJFFheldbo46O4Ko5jLZ8Bl0DoQM9RAa9Ofl8W+DULMrz5x4TPsLH44ktxng==
X-Received: by 2002:a1c:a592:: with SMTP id o140mr7767398wme.10.1635544241076;
        Fri, 29 Oct 2021 14:50:41 -0700 (PDT)
Received: from [172.20.119.151] (cgn-213-196-213-29.nc.de. [213.196.213.29])
        by smtp.gmail.com with ESMTPSA id c1sm3783270wrt.14.2021.10.29.14.50.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Oct 2021 14:50:40 -0700 (PDT)
Date:   Fri, 29 Oct 2021 23:50:38 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmail.com>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     rsbecker@nexbridge.com, git@vger.kernel.org
Subject: Re: [Bug] wrapper.c uses unportable unsetenv
In-Reply-To: <xmqqwnlvik3v.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2110292348530.56@tvgsbejvaqbjf.bet>
References: <012301d7cd01$90428960$b0c79c20$@nexbridge.com>        <xmqqsfwjk1s3.fsf@gitster.g>        <013501d7cd06$8c8281e0$a58785a0$@nexbridge.com>        <013a01d7cd09$72d91cb0$588b5610$@nexbridge.com> <xmqqwnlvik3v.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 29 Oct 2021, Junio C Hamano wrote:

> ----- >8 --------- >8 --------- >8 --------- >8 --------- >8 -----
> Subject: unsetenv(3) returns int, not void
> 
> This compatilibity implementation has been returning a wrong type,
> ever since 731043fd (Add compat/unsetenv.c ., 2006-01-25) added to
> the system, yet nobody noticed it in the past 16 years, presumably
> because no code checks failures in their unsetenv() calls.  Sigh.
> 
> For now, make it always succeed.

Makes sense, but...

> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  compat/unsetenv.c | 2 +-
>  git-compat-util.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git c/compat/unsetenv.c w/compat/unsetenv.c
> index bf5fd7063b..46d49c2c5e 100644
> --- c/compat/unsetenv.c
> +++ w/compat/unsetenv.c
> @@ -1,6 +1,6 @@
>  #include "../git-compat-util.h"
>  
> -void gitunsetenv (const char *name)
> +int gitunsetenv(const char *name)
>  {
>  #if !defined(__MINGW32__)
>       extern char **environ;

... but we are missing this:

@@ -24,4 +24,5 @@ void gitunsetenv (const char *name)
 	  ++dst;
      }
      environ[dst] = NULL;
+     return 0;
 }

Thanks,
Dscho

> diff --git c/git-compat-util.h w/git-compat-util.h
> index b46605300a..0f7e369a5d 100644
> --- c/git-compat-util.h
> +++ w/git-compat-util.h
> @@ -726,7 +726,7 @@ char *gitmkdtemp(char *);
>  
>  #ifdef NO_UNSETENV
>  #define unsetenv gitunsetenv
> -void gitunsetenv(const char *);
> +int gitunsetenv(const char *);
>  #endif
>  
>  #ifdef NO_STRCASESTR
> 
> 
> 
> 
