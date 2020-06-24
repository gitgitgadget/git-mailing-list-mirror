Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D363CC433E3
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 15:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99D162168B
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 15:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r3P1arLy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404428AbgFXPH4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404150AbgFXPHv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jun 2020 11:07:51 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1558CC061573
        for <git@vger.kernel.org>; Wed, 24 Jun 2020 08:07:51 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id e2so1179089qvw.7
        for <git@vger.kernel.org>; Wed, 24 Jun 2020 08:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pL/qTcmSDxsw7bGipB5Qubd86dbepOjYYLWVbtkQ4cg=;
        b=r3P1arLyE1yOpEWkSpdc0YCZPky5s2oCW+EAbQM7xUw2ib0ahFlpxOsztlWhoxal+s
         5L+Jhf4yDUgGkhLA86Kh/kbiccGLcf8U0TQJdugqAaIY0tXjK8MpmqCGpVGSmn+4+RkW
         WV+bfwGTNOyfDdEAnAf10AWy0NRHX+Z8wpdW85Vcut/BKxDKRZYsdd4lDhkvz7BZTmhE
         Cbq9n+tUjPSKeA91Xshpg06WYQDzbW4MSobi99jwMmr554afdKb4JxGiSOhH767MZ1TX
         r/dvpp6eKLQDZXM+8fpnCEoUjMxmabq4EwTpdCcoBXCunHkqgeMREDgDtXu4RhTRFbfj
         DOAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pL/qTcmSDxsw7bGipB5Qubd86dbepOjYYLWVbtkQ4cg=;
        b=UoRcK0W/1QsR5bOrmRZfi7tEduQqaJJ1yz6yUeADhP/B6KBq+7aNesQR1xlCHClAeu
         ONeIhJn63cXhZJHyIfg4Lam0Qip5ht5097TtBx5c8JA2DLIAkSj/c3DHubL0jcvcJoNO
         14qNlOGHIOHIiRlu/jBezeTO/RFII/t0620+olHxAXN+ZHSFNfQLseH8RqOvg3UjkJtx
         58YBjO0r6WW8m2ZynF3ITc+m7yfRg7l32iaZQFs+0AT36+P3WPxM0ufHyUi/LiJWX1/M
         js7uwPeWgC5KqdJxTOROcsqKFFYm1Qbxm+v9so5jNczbsjwi27lLk/YBbB/l+29Tledk
         u+1A==
X-Gm-Message-State: AOAM530QZhrBMm5Ymjhz4Hsd5s7Z28FxWdCiFrxZK6rBiAJeLWOXYyxz
        N2/FJep5SPj9boavvy+6IW4=
X-Google-Smtp-Source: ABdhPJxLkoWMYfrrRd985AjalEY+8h/7hHWABw5ZWLrPBQX8Sv0XThz8eE9gPRhVeA5s/LKoY/jcVA==
X-Received: by 2002:a0c:e554:: with SMTP id n20mr19862359qvm.14.1593011270205;
        Wed, 24 Jun 2020 08:07:50 -0700 (PDT)
Received: from generichostname (CPEc05627352ede-CM185933998587.cpe.net.cable.rogers.com. [174.112.146.193])
        by smtp.gmail.com with ESMTPSA id q24sm3621126qkj.103.2020.06.24.08.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 08:07:49 -0700 (PDT)
Date:   Wed, 24 Jun 2020 11:07:47 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 1/3] docs: adjust for the recent rename of `pu` to
 `seen`
Message-ID: <20200624150747.GA141904@generichostname>
References: <pull.668.git.1592924655.gitgitgadget@gmail.com>
 <pull.668.v2.git.1593010120.gitgitgadget@gmail.com>
 <35e3dafd6a0b9bc2278933378f04cf13072ee298.1593010120.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35e3dafd6a0b9bc2278933378f04cf13072ee298.1593010120.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Wed, Jun 24, 2020 at 02:48:38PM +0000, Johannes Schindelin via GitGitGadget wrote:
> diff --git a/Documentation/gitworkflows.txt b/Documentation/gitworkflows.txt
> index abc0dc6bc7..0965b60884 100644
> --- a/Documentation/gitworkflows.txt
> +++ b/Documentation/gitworkflows.txt
> @@ -85,15 +85,15 @@ As a given feature goes from experimental to stable, it also
>  
>  There is a fourth official branch that is used slightly differently:
>  
> -* 'pu' (proposed updates) is an integration branch for things that are
> -  not quite ready for inclusion yet (see "Integration Branches"
> -  below).
> +* `seen` (patches seen by the maintainer) is an integration branch for
> +  things that are not quite ready for inclusion yet (see "Integration
> +  Branches" below).

Tiny nit: we should use sq instead of backticks to match the style of
the rest of the document.

-Denton
