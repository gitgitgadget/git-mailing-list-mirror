Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787CFC433F5
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 14:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240007AbiCJOyz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 09:54:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346150AbiCJOmi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 09:42:38 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6910D106614
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 06:40:19 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id bg10so12583105ejb.4
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 06:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=oBMEuMhBXxYMDLAFKP8erewEof68WPJc8KfvAk+rDIM=;
        b=Ixs2b5l9m5wSn89mF0plXC5EOlkTJu+xHslpGhKAe1rPeZCK5cDtGUH2u6Q7IVle0C
         KL/e33scg86BynDIrcpPgjsp9Wn5v4pDP5FwXiWIdDiTYj5WAa98+zf30WWZLr8jf6FW
         qWpwR9TugA0V0VWYiDIgFPq7qPwYKsgr27GfotqdNAR0/IV01Fkzg1NBdpVKRyGVdm0w
         +eTqdzA0MDzXP4XXxFF9iMPZ2XeOAidkLmmPdox6y+CCuwi0oybaBEnfV1ke9bFD92aH
         meB6banwDSr/KQ/mEYdDljj16rBb+mw5v94Ck8y3Uqw2BlgUxRWxwwMYe/f3WFrhzNFt
         lcCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=oBMEuMhBXxYMDLAFKP8erewEof68WPJc8KfvAk+rDIM=;
        b=xI2a6ctEsttLIsxjQzOKevN1Z0SwkurIbzvJx1J02w69OU54d/4w9VWNRrFk9SSXtp
         5TW61WFdC5fKfw0sbv15df+I4EfseKoAF3MVb/sG1V26CLfy6LrNnT+ej1teybwwZ5BL
         3NMGNtu+xhFqQg9dd/pTCrpQ9QYZ6GGjDhg24O30YC0aEfE38lppA9E+s08XU8VL1aXX
         wwYH0tMneXkpM4lAaoGkKhG35A92mcTMgXPa1pAbFYi/XnUwZhwkzSdfg9yFvIXB6mtN
         x0v7TW1HGjDZjEKNBYqymdo8wl0SpsgAYgi8GBlf9YyS0RGkxCdXZrdMi0y+QdIJ0ft1
         G5HA==
X-Gm-Message-State: AOAM532A+9NBlhQeU+Dc8pUl0MXa50GJUHn+H5txyYhYoYSBfTuT1RZF
        z0RQuW3YGWrXDV2xL9VUWGc=
X-Google-Smtp-Source: ABdhPJwyQd4dHLW4PP/mukEFeCn7stWyKXACXJ3b8IR7/rs6tcz2ngIjjQVlk2ku2FfZeJBbxNGgnQ==
X-Received: by 2002:a17:907:d8b:b0:6db:77c1:1889 with SMTP id go11-20020a1709070d8b00b006db77c11889mr4430285ejc.84.1646923217844;
        Thu, 10 Mar 2022 06:40:17 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id fd16-20020a1709072a1000b006d90b4c029asm1819008ejc.28.2022.03.10.06.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 06:40:17 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nSJxg-000Wxg-Ms;
        Thu, 10 Mar 2022 15:40:16 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 4/4] trace2 docs: clarify what `varargs` is all about
Date:   Thu, 10 Mar 2022 15:37:44 +0100
References: <pull.1172.git.1646919331.gitgitgadget@gmail.com>
 <2eecea50e5132b09574451f37ca76a5d4af8697f.1646919331.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <2eecea50e5132b09574451f37ca76a5d4af8697f.1646919331.git.gitgitgadget@gmail.com>
Message-ID: <220310.86ee39kh0v.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 10 2022, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  Documentation/technical/api-trace2.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
> index 285f713ed84..91985512867 100644
> --- a/Documentation/technical/api-trace2.txt
> +++ b/Documentation/technical/api-trace2.txt
> @@ -170,7 +170,7 @@ Some functions have a `_va_fl()` suffix to indicate that they also
>  take a `va_list` argument.
>  
>  Some functions have a `_printf_fl()` suffix to indicate that they also
> -take a varargs argument.
> +take a `printf()` style format with a variable number of arguments.

This is correct, but I think better would be to explicitly describe the
_printf_va_fl() suffix in this list, i.e. now that implicitly falls
under _va_fl(), so it's *technically* redundant.

But either describing it explicitly, or saying that `_printf_*_fl()` are
function that take a printf format before either a "va_args" or "..."
would make the end-state a bit more obvious.

I wonder if the pre-image wanted to describe `_printf_va_fl()` (which
would make it correct), and we just omitted a `printf_fl()` description.
