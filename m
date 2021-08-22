Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2C0C432BE
	for <git@archiver.kernel.org>; Sun, 22 Aug 2021 14:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1BD16023E
	for <git@archiver.kernel.org>; Sun, 22 Aug 2021 14:37:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234503AbhHVOi0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Aug 2021 10:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234391AbhHVOiZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Aug 2021 10:38:25 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CAFC061575
        for <git@vger.kernel.org>; Sun, 22 Aug 2021 07:37:44 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id m24-20020a17090a7f98b0290178b1a81700so10380596pjl.4
        for <git@vger.kernel.org>; Sun, 22 Aug 2021 07:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=LUbv4XuYsfT+1EwY1MMCx9XEJlawuM7CeYB1hfz61As=;
        b=BgZm+DT/D88hC8/cSUj97/e9TPlQsD6lzxjl8Lw9+WGpSSrjWD+sp56UI78htGcWkU
         nNAqlBVknTPIHch1Xz3r+rFvB1SA7zuJEWnM2od12UW9a3BSK/GYiUE2jtDX/wt5AWgE
         US1GV+fhsAnoJDCidVhhobzGa4DwrL3LPLRUMJrK4phMDmDb7fDG0FdDDqSbV0eZnRb/
         ebHVSC/v+ZoT0Rw5jpleVBA3rIhLTeZlAwf6mN0KAFYoQoFs///CV9Qp5q7FcuAt5B17
         n3AT4SFHOjMwzAm3eVM0QKa2JZDrVNa39/gzbvI3owvZhybR7ykSTx8Y61C5JCyFZGM/
         brtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=LUbv4XuYsfT+1EwY1MMCx9XEJlawuM7CeYB1hfz61As=;
        b=ggQB6lXvEfuIpsFKjmXBLd3hBHIzOfrGN4RrA5Tt9Rm/J/IM4nyz+6w28dnIajIUxG
         yaerOVUCwrk83qoYccV7DjwaKPV8BpU1cBx00TndxA7bi+eJt3htYJ8KSLAoSR0DfvnP
         mgMca3eBRp/9aj2NtLbRao3uyDmhT6kBPuoHad24rLQ4hYdNXEpmWJD1XKRFvOS9EgMr
         fw/6fADl6z1w+1YW5l19ukCF0B/Dafuciz9MzwfWwZHcY4ZsVf7ZeTWROh6AJCbzDbw7
         6UB9ycUfhckKco001gcZilQmcauTuNsRcfOrls2dgzbdxO1WEVAKSODwPfXScV3YNtvS
         xU3g==
X-Gm-Message-State: AOAM532kAV3jDbjqUZBfaAh6Afsr+cFYK2mtKuvyKRRT1Tfl6cLLKaoj
        zTtOIvr8LWp2tNa+yPwSCk4=
X-Google-Smtp-Source: ABdhPJweeV0yRiOVLG2Bcb3r+yTwWVv/C1MMe22v+WjyvnMXqFGqutG11SSmFwBESA13CC0Qx+Fp/A==
X-Received: by 2002:a17:903:310e:b0:12d:c3e7:a8d9 with SMTP id w14-20020a170903310e00b0012dc3e7a8d9mr24503323plc.35.1629643063614;
        Sun, 22 Aug 2021 07:37:43 -0700 (PDT)
Received: from localhost ([2402:800:63b8:c1e5:7ba1:cab2:978b:f7f6])
        by smtp.gmail.com with ESMTPSA id g20sm12821639pfo.20.2021.08.22.07.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 07:37:43 -0700 (PDT)
Date:   Sun, 22 Aug 2021 21:37:39 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] make: add INSTALL_STRIP variable
Message-ID: <YSJhM2x82c7ardUm@danh.dev>
References: <20210821112510.50468-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210821112510.50468-1-bagasdotme@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-08-21 18:25:11+0700, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> In some environments (most notably embedded systems and small production
> servers), it is often desirable to have stripped Git binaries due to
> tight disk space constraint.
> 
> Until now stripped Git can be built wih `make strip install`. Add
> INSTALL_STRIP make variable so that they can install stripped Git
> binaries with `make INSTALL_STRIP=yes install`.
> 
> Also document stripping and using INSTALL_STRIP in INSTALL.
> 
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Changes from v1 [1]:
> 
>    - install target depends on strip when INSTALL_STRIP is defined
>      (sugested by Đoàn)
> 
>  [1]: https://lore.kernel.org/git/YSDW3nsG2iWPGakF@danh.dev/T/#t

We may want to see this discussion[2] settled first, I think.

2: https://lore.kernel.org/git/YSBhPdK8jYIQUNhP@danh.dev/

-- Danh

> 
>  INSTALL  | 8 ++++++++
>  Makefile | 5 +++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/INSTALL b/INSTALL
> index 66389ce059..98e541ee4d 100644
> --- a/INSTALL
> +++ b/INSTALL
> @@ -58,6 +58,14 @@ suite has to be run using only a single CPU.  In addition, the profile
>  feedback build stage currently generates a lot of additional compiler
>  warnings.
>  
> +You can also strip debug info from built binaries by:
> +
> +	$ make strip
> +
> +or for stripping and installing together:
> +
> +	$ make INSTALL_STRIP=yes install
> +
>  Issues of note:
>  
>   - Ancient versions of GNU Interactive Tools (pre-4.9.2) installed a
> diff --git a/Makefile b/Makefile
> index 9573190f1d..43c47f5560 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -8,6 +8,8 @@ all::
>  # Define SANE_TOOL_PATH to a colon-separated list of paths to prepend
>  # to PATH if your tools in /usr/bin are broken.
>  #
> +# Define INSTALL_STRIP if you want to install with stripped binaries.
> +#
>  # Define SOCKLEN_T to a suitable type (such as 'size_t') if your
>  # system headers do not define a socklen_t type.
>  #
> @@ -3004,6 +3006,9 @@ profile-install: profile
>  profile-fast-install: profile-fast
>  	$(MAKE) install
>  
> +ifdef INSTALL_STRIP
> +install: strip
> +endif
>  install: all
>  	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(bindir_SQ)'
>  	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
> 
> base-commit: 225bc32a989d7a22fa6addafd4ce7dcd04675dbf
> -- 
> 2.25.1
> 

-- 
Danh
