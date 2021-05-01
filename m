Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11BAAC433B4
	for <git@archiver.kernel.org>; Sat,  1 May 2021 19:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD32061490
	for <git@archiver.kernel.org>; Sat,  1 May 2021 19:16:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbhEATRN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 May 2021 15:17:13 -0400
Received: from mail-ed1-f44.google.com ([209.85.208.44]:45027 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbhEATRN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 May 2021 15:17:13 -0400
Received: by mail-ed1-f44.google.com with SMTP id bf4so1812438edb.11
        for <git@vger.kernel.org>; Sat, 01 May 2021 12:16:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t/SN8o82PfSWWWYpHJusJmw2YrJsi3KWYfHsoxJL/0o=;
        b=a4XVUWsgCWX++J8mEaPjjOqsBz64Kr9umJ8+FHwBkQa4Fcwjgf9rpEgyWd3TsXhwhn
         upSQT/7zscxi/ilUOpOpdCe/SBXO0HFE8QJCzyXz2RMjkt69hZlkTYr9DWMJ9e0uGhFh
         DfHltJ7LNPeIZJFlfU9RW2tIznw++AhHPO28eQ70v2Sf9g3lcbVUl9hp9956+0zBoCr8
         otQe5x8l+6ONpmElGAWmTDthiSVnpyGYuYJIi4mnx2RHhsNW/KtKoRwv8tzByXR1Azxh
         MnW1hU5OKT5mpL0WPDJgfAkjGONEDv6G3K4iYQqWEFmuO707yEQ4jHuiVSu1R+zdFKxu
         0JBg==
X-Gm-Message-State: AOAM532ARw9ySKmjgDLeAjfVa3SWJQtHbRPAIP9D1aWDKmIwy8Hb/ojV
        LGOV27aKxVvENZ5TXy9IhQrakc3+IrXQLFX45YQ7XsdLd+w=
X-Google-Smtp-Source: ABdhPJzUWv7J+x4s3Pfs84TcUxD3MSob2yEiL+pKw6u10PuEMPQ6hiujMBHRZBm5MMrIQW2/HwCtCc89qgcR79pi/qo=
X-Received: by 2002:aa7:c412:: with SMTP id j18mr12504876edq.163.1619896580985;
 Sat, 01 May 2021 12:16:20 -0700 (PDT)
MIME-Version: 1.0
References: <YI12hK4X/gfl3u29@coredump.intra.peff.net> <YI13DTkOpDRP4YGa@coredump.intra.peff.net>
In-Reply-To: <YI13DTkOpDRP4YGa@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 1 May 2021 15:16:09 -0400
Message-ID: <CAPig+cTmL3R=xB_zjFLZkZ3X4pOABj-OvLsbDsW91WKCv-bjHA@mail.gmail.com>
Subject: Re: [PATCH 9/9] docs: document symlink restrictions for dot-files
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 1, 2021 at 11:43 AM Jeff King <peff@peff.net> wrote:
> We stopped allowing symlinks for .gitmodules files in 10ecfa7649
> (verify_path: disallow symlinks in .gitmodules, 2018-05-04), and we
> stopped following symlinks for .gitattributes, .gitignore, and .mailmap
> in the commits from 204333b015 (Merge branch 'jk/open-dotgitx-with-nofollow',
> 2021-03-22). The reasons are discussed in detail there, but we never
> adjusted the documentation to let users know.
>
> This hasn't been a big deal since the point is that such setups were
> mildly broken and thought to be unusual anyway. But it certainly doesn't
> hurt to be clear and explicit about it.

Just a really microscopic nit... feel free to ignore...

> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
> @@ -1247,6 +1247,13 @@ to:
> +NOTES
> +-----
> +
> +Note that Git does not follow symbolic links when accessing a
> +`.gitattributes` file in the working tree. This keeps behavior
> +consistent when the file is accessed from the index or a tree versus
> +from the filesystem.

We're in the "NOTES" section, so it feels redundant to begin the
sentence with "Note that".

> diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
> @@ -98,6 +98,14 @@ submodule.<name>.shallow::
> +NOTES
> +-----
> +
> +Note that Git does not allow the `.gitmodules` file within a working
> +tree to be a symbolic link, and will refuse to check out such a tree
> +entry. This keeps behavior consistent when the file is accessed from the
> +index or a tree versus from the filesystem, and helps Git reliably
> +enforce security checks of the file contents.

Ditto.
