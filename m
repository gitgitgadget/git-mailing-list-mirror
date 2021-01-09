Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD346C433E0
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 15:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86D3A23A23
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 15:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725850AbhAIPHt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Jan 2021 10:07:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbhAIPHt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jan 2021 10:07:49 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FDDC061786
        for <git@vger.kernel.org>; Sat,  9 Jan 2021 07:07:08 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id o19so30220869lfo.1
        for <git@vger.kernel.org>; Sat, 09 Jan 2021 07:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EvN/LlXdoykoqQITgWcgYsZ8eR9Y1kuJS7iHU18UuD4=;
        b=jmLd16v4TvE2AIetFeTdLMH8cDWs2GnNfSf3qpqMPUY0WCE0ls9ACrtOfDi5GJ/MID
         gK/4yhhuK7HRP5XhREurHyC4fAoSxRxRFkhcciuqok+2+HUVac/bZB9pitIpNasO3fID
         phxxoUGCrGIDgZGqRcAHcQ/GUNDf2dsY+LkwUXGsL6a7zabWJQLZ3wBTV8XTQImUYh9P
         eJaKp/Y12m7h+VGWzdGSeW7nLHmIeES3yq0X0sWRB/4l6ZnJf3QFvomrPKDjTmV+3E2U
         ayqzSfsIWENqBe2N7VWJ76Srf910QY0Z1ZgFWKhoogMZcdUUn4YHNUhItmXaAhd17yLR
         Atyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EvN/LlXdoykoqQITgWcgYsZ8eR9Y1kuJS7iHU18UuD4=;
        b=fBDxsyStzs+JSVeiPwdM4qvIzHEyIPfoWpvcYwRltdA0lB/oXAal+DKNleNpd87cjj
         erua4yl6bcj27TUnOgUacPkNWfRYZIabqfIGrWpu+nkyjVh0P1u/Ry+ILmZn3lbVb2wI
         yy6hs2HPZd0djUzSHNwvtBrSjr+Jc57v2c+wBQgnDXzBzQFjFQO4yTyqVechOsrG8GMr
         Fh93RSmcQM2lWCflUWpgHRB3Zb2TAYgHS+/I4SHtNmz3sSIOy1slUx/m2JOXkNE/5Cwn
         COhVJyvzJptpKBCP4BKXaEsJkYMLWIbiajBIwdzD/fNTLZScoBKrTMTZ7PSbD4APeMZW
         C+1g==
X-Gm-Message-State: AOAM5334Qxso6btybtchX3TD7YHekZZ/oKXAr5FeXNf1Sa/im/qaeWX0
        kIRLjgOMlaag6idwKmSAmC/E0RUmDKO2TWJZtXnVGA==
X-Google-Smtp-Source: ABdhPJyZoGM+eTgV5XNx82JHXkpsqyLHG8BnizauSgicICARZnxvuyR69YCcfrIUk9b3TohK5Gy5fMu/bD1+I3Jf6zM=
X-Received: by 2002:a19:8149:: with SMTP id c70mr3540808lfd.502.1610204826992;
 Sat, 09 Jan 2021 07:07:06 -0800 (PST)
MIME-Version: 1.0
References: <CAHd-oW7XJL_a1zMAUetHzvrh8DrLT4g2awv-fjbTdeLVLKVsew@mail.gmail.com>
 <20201223114431.4595-1-adam@dinwoodie.org>
In-Reply-To: <20201223114431.4595-1-adam@dinwoodie.org>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Sat, 9 Jan 2021 12:06:55 -0300
Message-ID: <CAHd-oW7r9D09F7=3JLTiQcbRDXyXhkYY3FFuRLbR9vH=p4M92w@mail.gmail.com>
Subject: Re: [PATCH] t4129: fix setfacl-related permissions failure
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     git <git@vger.kernel.org>, Achim Gratz <Stromeko@nexgo.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Adam

Apologies for the late reply.

On Wed, Dec 23, 2020 at 8:44 AM Adam Dinwoodie <adam@dinwoodie.org> wrote:
>
> When running this test in Cygwin, it's necessary to remove the inherited
> access control lists from the Git working directory in order for later
> permissions tests to work as expected.

Nit: Although this sentence is correct and the bug was first found on
Cygwin, the test may fail in any other environment which has a default
ACL set. In this sense, I think we could perhaps rephrase the commit
message to something like this:

This test creates a couple files and expects their permissions to be
based on the umask. However, if the test's directory has a default ACL
set, it will be inherited by the created files, overriding the umask.
To work around that, the test attempts to remove the default ACL, but
it erroneously passes a nonexistent path to the setfacl command. Fix
that by passing the working directory.

> ---
>  t/t4129-apply-samemode.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t4129-apply-samemode.sh b/t/t4129-apply-samemode.sh
> index 41818d8315..576632f868 100755
> --- a/t/t4129-apply-samemode.sh
> +++ b/t/t4129-apply-samemode.sh
> @@ -78,7 +78,7 @@ test_expect_success POSIXPERM 'do not use core.sharedRepository for working tree
>         test_config core.sharedRepository 0666 &&
>         (
>                 # Remove a default ACL if possible.
> -               (setfacl -k newdir 2>/dev/null || true) &&
> +               (setfacl -k . 2>/dev/null || true) &&

The change is obviously correct, thanks!

Reviewed-by: Matheus Tavares <matheus.bernardino@usp.br>
