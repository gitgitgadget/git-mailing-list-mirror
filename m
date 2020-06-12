Return-Path: <SRS0=soZh=7Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9E9C433E0
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 00:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A74D20801
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 00:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eV+BwwAH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgFLAw3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Jun 2020 20:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbgFLAw2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jun 2020 20:52:28 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122F8C03E96F
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 17:52:27 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id q8so7500684qkm.12
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 17:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dGGGfe740p3Nzv4U7b+g7ELRBfsUjAYTZRGjWQiyUi4=;
        b=eV+BwwAHtkMBevkxf6Iev9Z0dzfvCQ4qNNIETfQclJPxQugEh3v1kOk6RYMJvwcdWc
         sZXmfif3ElV9x0M6xgOf7UL45lVrGTdRE1QJ9cuzXEA+vssoEYGFAiOU2dlSC2mATPPc
         3jX1aJqffr9BbFXEJCGby3c7LiFg++OK2F3ZT+1ObY1nHLbi+efHpRUHwSmI8FA5cU0C
         +FQa8flg9HnS7zUZwuP/Hs1QRrHDJxLCWwKmgy/DtibQ/eMSodn8poMmWEk6mcDlRJMU
         EP2vdviz7vHOxGAOxFiaNuKTxlV/bh6T4UTHr7yiFszW/XHfgc5FEMMuv/nKii1PHCAV
         mHvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dGGGfe740p3Nzv4U7b+g7ELRBfsUjAYTZRGjWQiyUi4=;
        b=slp+TJogKSI68u8J8eUxBiM4NVfmt9hpWHkcjw1w3RZmIESKSVaE6IIK/a1sFUV/Fw
         T3bvwBG9gkrx7hqGD+NKQ3DXRRislID74EwAYRTVAdwFalg4cWpuCz4YsPM0hkUspc8C
         FcN7CK1l9OIwn6FatQjHBvyPKnvZvlgc9FI9jMnJ/qMCbH17qcktCMCElj14rjPmXqNG
         R7PM093YyXcZXMRIciA+QppiPh/crtEMiNqtfQ6lo2i9Bb0v+odIu44xuwhe8CTFxWzO
         7HXUZvKks3X8HVyvFBksdyZfQ0HbZYlPwDHHB6hEzHsshvnNVz1BihResAzYlccUvfZo
         l78A==
X-Gm-Message-State: AOAM530jSiQgd83aL8GbPwRQy/1O3Nfc6I7uiGBVaJfrn4uBL+x/FX1m
        OKy2x1zZxg4WtSUcSF5vaS+o3fI1qR8=
X-Google-Smtp-Source: ABdhPJyAvttB5mMngwGAhlI6DlUgHUEvY6bwoA+Uf9OyCJ6Kz+aDk+TbBGvj1HB5sJLj0rBRaPZi6w==
X-Received: by 2002:a37:b883:: with SMTP id i125mr687517qkf.392.1591923146172;
        Thu, 11 Jun 2020 17:52:26 -0700 (PDT)
Received: from generichostname (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id k7sm3423807qth.10.2020.06.11.17.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 17:52:25 -0700 (PDT)
Date:   Thu, 11 Jun 2020 20:52:17 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] GIT-VERSION-GEN: update for the post 2.27 cycle
Message-ID: <20200612005217.GA3964@generichostname>
References: <4946cf3650b95191455630f85f59e5f93156d0ac.1591883410.git.liu.denton@gmail.com>
 <xmqq8sgtjsor.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8sgtjsor.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, Jun 11, 2020 at 12:41:56PM -0700, Junio C Hamano wrote:
> Denton Liu <liu.denton@gmail.com> writes:
> 
> > Signed-off-by: Denton Liu <liu.denton@gmail.com>
> > ---
> >  GIT-VERSION-GEN | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
> > index 06a5333ee6..7b0cfeb92e 100755
> > --- a/GIT-VERSION-GEN
> > +++ b/GIT-VERSION-GEN
> > @@ -1,7 +1,7 @@
> >  #!/bin/sh
> >  
> >  GVF=GIT-VERSION-FILE
> > -DEF_VER=v2.27.0
> > +DEF_VER=v2.27.GIT
> 
> I have been thinking about stopping this transition from ".0" to
> ".GIT" and left it at ".0" deliberately.
> 
>  - The target to create a tarball ("make dist") places the "version"
>    file that overrides whatever value is set here, so those who
>    build from a tarball will not care what the value described here
>    is.
> 
>  - Those who build from a repository would use "git describe".
> 
>  - In addition, I do not create tarballs and upload to public places
>    for a random version with .GIT suffix---I only do so for -rcX and
>    the releases.  If anybody else is doing so with "make dist",
>    there would be the "version" file included in the tarball,
>    recording what is obtained from "git describe HEAD".
> 
> So there is no strong reason to care what this value is, and that
> was why I was experimenting with the idea of leaving it at ".0",
> in the hope of hearing from people who do want to see ".GIT" why
> they want it.

Thanks for the explanation, it makes sense.

> Unfortunately, your patch does not say why, either, so it hasn't
> quite helped yet ;-)

I tried looking on the list but I didn't find any mention about this
experiment so I assumed that you unintentionally forgot to update the
version. Good to know that it was done deliberately :)

-Denton
