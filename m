Return-Path: <SRS0=IFun=BX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADCCC433DF
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 15:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 402F020658
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 15:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="VEaJuCHR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgHMPEc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 11:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgHMPEc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 11:04:32 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9D7C061757
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 08:04:31 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id s23so4553007qtq.12
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 08:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8n8kLE8slyKpLlHcW0xfSBi44rW1h/RA1Dxlu0Ix4Gs=;
        b=VEaJuCHR7wUnMe5rETUpmt9QdDE5gEhZF1WxLCbruY9XGDjKiI4kE2D0j1fu0gI7WT
         28lhZ4Iv3/ILOp/rcsf5T/4lCka4USXK/ApLxMv5fpSWjSbrrbWdOrk+SJxyqVfOQhNS
         b1qv63XXJuUISduiJMmLQCnjp5XKdCNQxNoqovWLO5wrsA5iPSINvmF2ozlDi7Wu4L1o
         MIuuJZEE73BMGFgZ3sBW7JfYVNMWu5nmNi7PllNjwb70e3qIgp8kPxDU491pOaJ6dXGm
         APN4X7xBj5rP3Ohw+DDI5tsw63ahemgNh8VN9DchXzjdtC2sz4CwqvFxV/zMSBKQYDQJ
         /pQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8n8kLE8slyKpLlHcW0xfSBi44rW1h/RA1Dxlu0Ix4Gs=;
        b=oR2lmaV1AKn7Gbj8cOTnZMalbAEODkBqvm1+UccrrOnv2Gk5WDu31y+TEUQblqwrwt
         uiEalYZYZwi+6LbEDSfOyY4yZ4XS6jOx4wiYuJlo5o4bKWwGuVb8mOgrrD64AoILLDzI
         iwprSLzzh4hR3ZuQZnNKQsbTGeub/jsrl2SEAcdpS20kTbJhHIgmFTXXuktXY4oGF30S
         wv8VuPEC92nijwO8nNNN8NLMWYsrQ5AzfJUvw9VlJqEg3jYhhxyyeLu1bVOpe7N4FFSp
         2nwlK6RkD+51lreVOcQ6xI9xx67+XKn2R8ARNrqTw0FwbRWMjrry/uVqehUDyCDtF+nK
         hh7A==
X-Gm-Message-State: AOAM5316XV6FwC9gBc1iaQKq83HjH0RADOZDHdvWOtSucJ6by2mR45sE
        yogwMDGB8YHQaj755Wbl+Wn1Og==
X-Google-Smtp-Source: ABdhPJzgpGmOCwKr3TU+dxzP7OtMqIDWPR1Mi1r7dNJezkFcKyk3CtIlT9xUbM30Q787b+IC39Xuug==
X-Received: by 2002:ac8:74c7:: with SMTP id j7mr5675571qtr.254.1597331071012;
        Thu, 13 Aug 2020 08:04:31 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:cdcd:c658:5bb1:ebc9])
        by smtp.gmail.com with ESMTPSA id z67sm5640943qkb.27.2020.08.13.08.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 08:04:29 -0700 (PDT)
Date:   Thu, 13 Aug 2020 11:04:28 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 1/5] Makefile: drop builtins from MSVC pdb list
Message-ID: <20200813150428.GA2244@syl.lan>
References: <20200813145515.GA891139@coredump.intra.peff.net>
 <20200813145719.GA891370@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200813145719.GA891370@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 13, 2020 at 10:57:19AM -0400, Jeff King wrote:
> Over the years some more programs have become builtins, but nobody
> updated this MSVC-specific section of the file (which specifically says
> that it should not include builtins). Let's bring it up to date.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Given that nobody has mentioned this, it makes me wonder if anybody is
> even using this part of the Makefile at all these days. Or maybe having
> extra lines here isn't a problem (though it's also missing some entries,
> like one for git-bugreport).

If having extra entries didn't cause a problem, I would suspect that it
was just that. But that missing entries *also* doesn't cause a problem,
I'd suspect that this section of the Makefile just isn't being used.

Of course, I'm not using it since I'm not on Windows, but maybe dscho or
Stolee would know if there are legitimate uses. Of course, if there
aren't, I'm favor of getting rid of this section entirely.

>  Makefile | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 65f8cfb236..271b96348e 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2901,7 +2901,6 @@ ifdef MSVC
>  	# because it is just a copy/hardlink of git.exe, rather than a unique binary.
>  	$(INSTALL) git.pdb '$(DESTDIR_SQ)$(bindir_SQ)'
>  	$(INSTALL) git-shell.pdb '$(DESTDIR_SQ)$(bindir_SQ)'
> -	$(INSTALL) git-upload-pack.pdb '$(DESTDIR_SQ)$(bindir_SQ)'
>  	$(INSTALL) git-credential-store.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
>  	$(INSTALL) git-daemon.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
>  	$(INSTALL) git-fast-import.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
> @@ -2912,7 +2911,6 @@ ifdef MSVC
>  	$(INSTALL) git-remote-http.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
>  	$(INSTALL) git-remote-testsvn.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
>  	$(INSTALL) git-sh-i18n--envsubst.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
> -	$(INSTALL) git-show-index.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
>  ifndef DEBUG
>  	$(INSTALL) $(vcpkg_rel_bin)/*.dll '$(DESTDIR_SQ)$(bindir_SQ)'
>  	$(INSTALL) $(vcpkg_rel_bin)/*.pdb '$(DESTDIR_SQ)$(bindir_SQ)'
> --
> 2.28.0.573.gec6564704b
>
Thanks,
Taylor
