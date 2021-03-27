Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC12C433C1
	for <git@archiver.kernel.org>; Sat, 27 Mar 2021 00:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC320619F7
	for <git@archiver.kernel.org>; Sat, 27 Mar 2021 00:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbhC0AAe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Mar 2021 20:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbhC0AAI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Mar 2021 20:00:08 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BA3C0613AA
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 17:00:08 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id kr3-20020a17090b4903b02900c096fc01deso3213508pjb.4
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 17:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Mg6+cFxdcnyiwYWjEqh+yrTvxqZLdLILwXwBeTGM0gs=;
        b=GnI/QvOFHp4CVz+ceJ4wL40f9RKfEWmBFaHrxlCdG4/de4ChbNr+SlTsiM6Rvtf2gQ
         uJOr4qt+EiG8CZn/x035wyCrnhAQRoeBuuS3HpRfxoY8ouql772Ic7rzC2HgYb3KLYvN
         lQEZI3M+2F3FwidNrKfDevFabgaZoL9k+U3e5RFBRzelR89qjCf18MfaZITPv5AW+REA
         9OIkWC6uYhA/2j2sZt+Ntw0jxH9YSgSWOihbKqyEoyKuUWciwaSxdhQT7a0WaGLTxI2y
         qICbJUWYFtr4Rt0cGvQPtrZHLGHP8kaS3G4wPHZOhjZFAQ0we0YrMsW7qYq1w94xDYNN
         7GGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Mg6+cFxdcnyiwYWjEqh+yrTvxqZLdLILwXwBeTGM0gs=;
        b=hJ6Dr4fO6s2dwkT2luCBIeHL8RG2e2Znd4sW/hs795M3wF8QcULmkxVXoi5Q9iVQ+f
         QaQypF4HnPuzCs+k3pa9HfAkZXw33JXo0I+PtRrPSdw6flPeOZsB3/Gm6y1yltUui5mO
         qB3DZd7uBe8yGKb/i9bU2QCxcDaMjreYVdHa0SBCWETT46hiUdST0xi0jzMpBLzXryWa
         mBMG/tt+l6Ne2/mPDGO5NQC0wizK66BdYQl/t6/QRLuIGyavtRLCkoxoZwztMZrWkZsb
         UgV4iQ6M7gdKpVi2ceHuaHw2EKQnx6GVVgdEOSDydp1X0eOCJgy/h31NhGMWkQY+CpNJ
         UYpw==
X-Gm-Message-State: AOAM531OfCynGDtQdrurwZQECyA9KqUoNpMs82iVuZ5TnzzA+Ec8xSaF
        B6zu6FgYm82WXMPBZ0CtAt0=
X-Google-Smtp-Source: ABdhPJw+eKrzQxMYgzrYCz4B0qpF1J8fi6OJhW5fHrtfhmQZ2+uxa5X8t8AAb1a6xT+Sl88twVFrQA==
X-Received: by 2002:a17:90a:4a8f:: with SMTP id f15mr16372826pjh.19.1616803207536;
        Fri, 26 Mar 2021 17:00:07 -0700 (PDT)
Received: from generichostname ([172.92.165.181])
        by smtp.gmail.com with ESMTPSA id w67sm6858441pgb.87.2021.03.26.17.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 17:00:06 -0700 (PDT)
Date:   Fri, 26 Mar 2021 17:00:04 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/2] SECURITY: describe how to report vulnerabilities
Message-ID: <YF51hOQlNlBRQRcl@generichostname>
References: <pull.917.git.1616796767.gitgitgadget@gmail.com>
 <2c9f5725d96fe45aa5d1a6bbc522f9ed6161173c.1616796767.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c9f5725d96fe45aa5d1a6bbc522f9ed6161173c.1616796767.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Fri, Mar 26, 2021 at 10:12:45PM +0000, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> In the same document, describe that Git does not have Long Term Support
> (LTS) release trains, although security fixes are always applied to a
> few of the most recent release trains.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  SECURITY.md | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 SECURITY.md
> 
> diff --git a/SECURITY.md b/SECURITY.md
> new file mode 100644
> index 000000000000..282790164e78
> --- /dev/null
> +++ b/SECURITY.md
> @@ -0,0 +1,51 @@
> +# Security Policy
> +
> +## Reporting a vulnerability
> +
> +Please send a detailed mail to git-security@googlegroups.com to
> +report vulnerabilities in Git.
> +
> +Even when unsure whether the bug in question is an exploitable
> +vulnerability, it is recommended to send the report to
> +git-security@googlegroups.com (and obviously not to discuss the
> +issue anywhere else).
> +
> +Vulnerabilities are expected to be discussed _only_ on that
> +list, and not in public, until the official announcement on the
> +Git mailing list on the release date.
> +
> +Examples for details to include:
> +
> +- Ideally a short description (or a script) to demonstrate an
> +  exploit.
> +- The affected platforms and scenarios (the vulnerability might
> +  only affect setups with case-sensitiv file systems, for

Small typo: s/sensitiv/&e/
