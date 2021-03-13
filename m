Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8ECC433E0
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 07:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B825A61554
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 07:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbhCMHIQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Mar 2021 02:08:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbhCMHHe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Mar 2021 02:07:34 -0500
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C494C061574
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 23:07:34 -0800 (PST)
Received: by mail-oo1-xc36.google.com with SMTP id a10-20020a4aae4a0000b02901b5e4460160so2117963oon.3
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 23:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lWvbLkSm4RJRzyP14AfNA5dRxYikFyKtSRl0queZVKE=;
        b=i384FtU106bBCpF67ackJCr0Y8dYlrClkJ/gdwNvHbvRcyWPQxlsUMxWBcBvKq6hIP
         DtinQyQ1DIgQBIfbaBJfmWfE3tVaoiVu5eKnwhvdaGAdAB8gFeGP2+Otp0EFuEb6PsOC
         v5RzOKgmuffDFJ5Y+k1U92pJ/g0x6upp2VAfq9CYFq1fAljFT8jmJhN4Kt9Hsy39e+r3
         CMNyTIogiCxlhEE/NQ4neaAC6InMynb5Mwpvcmi1URvGkLJ1mhj4WuJjtKxIEdD2V16P
         +azhUYHnWK5KSYa7yWjI0lyYqVeNR/8GJMnEOB01VO232g0r4ENcYl6GnQdaP/D0Uay2
         +oIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lWvbLkSm4RJRzyP14AfNA5dRxYikFyKtSRl0queZVKE=;
        b=UH54hYWLpA0ik1fwTl0O2D8rTSXLdF8LcYa7H8LE9jq/lKFciQpXIayi/Ygdo5kpUW
         z08laJtMSiNIt98mqeW0UxJZd6dCj1eIihSciTcqR4FfpuVBQwEkGLSaRsdseMkK7qRg
         p2vxiBaJDhi8lRikEU89Ru01y55OiQkzLeIsdFU/WiJou+YNwLv6o0Fu3zGAKEd4RoL7
         QVGVU5m0SUZlPoFVJEtkkZVoykIecOAZBbTv+LJUSPAazN/0NsBCHkOTsqQbSa3bgAF3
         bk6gO0CSRLB8+pFBeTj6DflAqmcpW6Wrk02r0wCEBA+vombXophyXsaQfaXKKxJBoEw/
         5Msw==
X-Gm-Message-State: AOAM531czAL+ITFix9lyXxAmeztnHnFSrWftLhJE2Dl288trCoIPuay7
        FFmAPaCWnqpxik3Vp3IGngmD4eKdXNviLwg+nio=
X-Google-Smtp-Source: ABdhPJysJByqR9yjiXOYkj0+NSv4HtAtJNRlwL/8qWHEiszy8BtCFOduoffEk3Q+qABn/cmEn4RRBdrZWW6Mss/MK/A=
X-Received: by 2002:a4a:bd1a:: with SMTP id n26mr6104247oop.45.1615619252673;
 Fri, 12 Mar 2021 23:07:32 -0800 (PST)
MIME-Version: 1.0
References: <cover.1614138107.git.matheus.bernardino@usp.br> <cover.1615588108.git.matheus.bernardino@usp.br>
In-Reply-To: <cover.1615588108.git.matheus.bernardino@usp.br>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 12 Mar 2021 23:07:21 -0800
Message-ID: <CABPp-BEriPaDY=84=j0tT62+U93jKePTyTKPZA4+dYtSFJaSTg@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] add/rm: honor sparse checkout and warn on sparse paths
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 12, 2021 at 2:48 PM Matheus Tavares
<matheus.bernardino@usp.br> wrote:
>
> Make `rm` honor sparse checkouts, and make both `rm` and `add` warn
> when they are asked to update sparse entries.
>
> Main changes since v2:
>
> Patch 2:
> - Removed unnecessary `rm` in t3705's auxiliary function and added
>   comment about why `update-index --force-remove` is used there.
>
> Patch 4:
> - Replaced the boolean function parameter with a more descriptive enum.
>   This way, readers don't have to go to the function definition to
>   understand what the caller wants.
>
> Patches 5 and 6:
> - Reworded both commit messages and the advice.updateSparsePath docs to
>   avoid saying "pathspecs that *only* match sparse entries", as the
>   situations to which they refer might also include matches among
>   ignored paths.
> - Rephrased the warning message about sparse paths so that it doesn't
>   contradict the message on ignored paths when they are displayed
>   together.
>
> Patch 7:
> - Adjusted the tests to check for the new sparse warning message.

v2 already looked pretty good to me; even if I still had lots of
little comments on that series.  This version addresses all my
remaining concerns with v2.  So this gets my:

Reviewed-by: Elijah Newren <newren@gmail.com>


Thanks for all your work on this!
