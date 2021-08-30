Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED6CAC432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 16:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0C17604D7
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 16:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237767AbhH3QgH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 12:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbhH3QgG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 12:36:06 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A246C061575
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 09:35:13 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id t190so16316989qke.7
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 09:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kuL4pt8jMteNEjbXZJSKh8Vz5t528O7FxqeQwAqhh3k=;
        b=AIOyDsZ+Yb+DYndycfE4lO+1hh+/tyNPPRVn/SaLFz7voRErGsZpljjsPcOmWFgew7
         JHGQX0YRSfgwRZwENIGYog/+kSHYd7BAW6WhYP5dJNIc+KUWVJcQ1uuCffXBFrYZoTs8
         1jBX9uMwWFh8Xuo37icJAv9foNz57j0Gh/nXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kuL4pt8jMteNEjbXZJSKh8Vz5t528O7FxqeQwAqhh3k=;
        b=DMV8vETjyMS9EM+EPszwzdVOSeQUl2vWQMjwTwUULu2wDpNweE9yf6uS0uccLm1OoR
         ai/ph28FXlhLMTIWUfu+9Y/dY33iTmnWv/lPN7Q/z6MUsCGa9rEZcaFkIidzdJf7Oswm
         BMNt2nlkvJrJ2Z11M/vb15hgipGljn888j3IZw4/1JqBArOmsoJNclb2R42+IcmpOGGF
         cjzZFMDDCM8vaCMKXd/Xa3iGQ08tWh5ndWLithawt+cK3TEU2jY7FvwznMtEOYJDdgJs
         mM6kBy5c1NEza6fZc6KyZCNFBk+WEPliMsFDJzEn+R9jDrbVFqH9I8qbU3SvKa6hRjvZ
         /qEA==
X-Gm-Message-State: AOAM531JSfkft3S7ABiU+18tXQaS5YxNb7z5J9wGzlfrmYfscuZiVayF
        zG4CanvflNmMM76d5SsJq4ib72r6/SaCl2Wk
X-Google-Smtp-Source: ABdhPJysnPWa0N2cKLUi4p2G7mFD5kx3SQ6Uou5k71d0qQcBpC119XJP/rAIJZrnz2ZYzGy56sRaRw==
X-Received: by 2002:a37:6297:: with SMTP id w145mr23207589qkb.258.1630341312303;
        Mon, 30 Aug 2021 09:35:12 -0700 (PDT)
Received: from nitro.local (bras-base-mtrlpq5031w-grc-32-216-209-220-181.dsl.bell.ca. [216.209.220.181])
        by smtp.gmail.com with ESMTPSA id j18sm11379934qke.75.2021.08.30.09.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 09:35:12 -0700 (PDT)
Date:   Mon, 30 Aug 2021 12:35:10 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     git@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: Problem accessing git.kernel.org with git v2.33 plus gitproxy
Message-ID: <20210830163510.4rhfeim7ceqbtti7@nitro.local>
References: <20210830161149.xggfosjthnjxcoxp@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210830161149.xggfosjthnjxcoxp@box.shutemov.name>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 30, 2021 at 07:11:49PM +0300, Kirill A. Shutemov wrote:
> I've stepped on a problem after upgrading git to v2.33.0. git fetch-pack
> fails with an error:
> 
>         fetch-pack: unexpected disconnect while reading sideband packet
> 
> It only happens when I access git.kernel.org over git:// (github over
> git:// works fine) and if there's a gitproxy configured.
> 
> For test I used a dummy gitproxy:
> 
>         #!/bin/sh -efu
>         socat - "TCP:$1:$2"
> 
> It is enough to trigger the issue.
> 
> I'm not sure if it's kernel.org problem or git problem.

For the record, the git.kernel.org server-side version is 2.31.1 and it is
invoked via the usual xinetd straight to git-daemon with the following flags:

server_args = --interpolated-path=/var/lib/git/%H%D --init-timeout=10 --timeout=600 --export-all --syslog --inetd --verbose

-K
