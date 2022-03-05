Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93648C433F5
	for <git@archiver.kernel.org>; Sat,  5 Mar 2022 14:04:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbiCEOFX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Mar 2022 09:05:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbiCEOFT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Mar 2022 09:05:19 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9296E1E6EA7
        for <git@vger.kernel.org>; Sat,  5 Mar 2022 06:04:29 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id r13so23039600ejd.5
        for <git@vger.kernel.org>; Sat, 05 Mar 2022 06:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=rDi7O7nvl5HHV24B9iTOd+QZF1YJSP4lAAS9eRn1+QE=;
        b=kW+KFexlqYFXWcC5rsDN1h6t1Nafra4pAzvPqHu5c+zielgeAd9G3osthbk8bZvML+
         6da4BVHTclIyKks06Hl5QITH+ZAnbEuTvzZHRanJHZ+GKmFLTKBYDJKmjsBnbstFtikD
         DsSqNobCNeFNbRtwdwzB3IMJGXYWlPjsCsUXokrpf64/EhHWoOsmCnKW1XGHB3e8ahWH
         5CujnOeQCOlvep0mAUezq29G0Rt7m1E54d7OANwVdAgsX4S9ssQXmCStcBofZCC2MvyX
         EcETfOsb9JFiVFTdsdLKJGRo9ndicZ3BSBR2DombKVcnm0gqYe2GfumAlqCoWASS3xdz
         g47w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=rDi7O7nvl5HHV24B9iTOd+QZF1YJSP4lAAS9eRn1+QE=;
        b=AqEfQKEGf3pdI3F/IYRbRVjeCNGz6GsXBR0wuYng5eaz9sEgsbttFn9r85hyLZZ29o
         GyZObeVCYArif+oY/2X/ARgxoXzZGOYTpk5hXbZozbJ7OE7EM/bqeCZrXjMpVxm+psjC
         q0LDppkyiIAQIdX1bdoIz5Jlu4dzhy7A8WCOB3kaXS87Da4ccOByqu4NRQ3BmzwEsrry
         a2Mxz5pmKSCw3ihX6yo8Z/liOOwQt5EqvzCmz1IDjvAvoqEb8qp9eqrUcwBLzReS/xss
         twpsQiO+z5b+HFBO2mFSHRxNmR74TNm8mTW9xyRkLBRl8I9LxaSS5/bs9hebGvh7nxpr
         BvLg==
X-Gm-Message-State: AOAM533fXAXvhAxuLyVZJ7Ut9/GMnbHNbKhg+lTSdE/Gr/s1qHOs+vW9
        4+Euyb7wyUu8HxAVEHMngjax9DyAbDxvZw==
X-Google-Smtp-Source: ABdhPJwUJClv2bTpJmU/i2v3UDlEdnfOgKHcQSa7ehyi9sNcLICh3DMGy12diI+gYTrt0JInuGj1dQ==
X-Received: by 2002:a17:906:6a01:b0:6da:8143:11e7 with SMTP id qw1-20020a1709066a0100b006da814311e7mr2946211ejc.296.1646489067880;
        Sat, 05 Mar 2022 06:04:27 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id l4-20020a170907914400b006d9e0b46fabsm2886176ejs.193.2022.03.05.06.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Mar 2022 06:04:27 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nQV1H-000WOQ-82;
        Sat, 05 Mar 2022 15:04:27 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>, carenas@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/4] terminal: use flags for save_term()
Date:   Sat, 05 Mar 2022 15:02:56 +0100
References: <20220304131126.8293-1-phillip.wood123@gmail.com>
 <20220304131126.8293-2-phillip.wood123@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <20220304131126.8293-2-phillip.wood123@gmail.com>
Message-ID: <220305.867d984hsk.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 04 2022, Phillip Wood wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> The next commit will add another flag in addition to the existing
> full_duplex so change the function signature to take an unsigned flags
> argument. Also alter the functions that call save_term() so that they
> can pass flags down to it.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  compat/terminal.c | 41 +++++++++++++++++++++--------------------
>  compat/terminal.h |  5 ++++-
>  2 files changed, 25 insertions(+), 21 deletions(-)
>
> diff --git a/compat/terminal.c b/compat/terminal.c
> index d882dfa06e..bad8e04cd8 100644
> --- a/compat/terminal.c
> +++ b/compat/terminal.c
> @@ -34,7 +34,7 @@ void restore_term(void)
>  	sigchain_pop_common();
>  }
>  
> -int save_term(int full_duplex)
> +int save_term(unsigned flags)

Doing e.g.  ...

>  void restore_term(void)
> diff --git a/compat/terminal.h b/compat/terminal.h
> index 0fb9fa147c..f24b91390d 100644
> --- a/compat/terminal.h
> +++ b/compat/terminal.h
> @@ -1,14 +1,17 @@
>  #ifndef COMPAT_TERMINAL_H
>  #define COMPAT_TERMINAL_H
>  
> +/* Save input and output settings */
> +#define SAVE_TERM_DUPLEX (1u << 0)
	
	enum save_terminal_flags {
		SAVE_TERMINAL_FLAGS = 1 << 0,
	};
	
Here would be better IMO. See 3f9ab7ccdea (parse-options.[ch]:
consistently use "enum parse_opt_flags", 2021-10-08) for how it makes
debugging better.
