Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C541C433EF
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 18:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0538D600CD
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 18:52:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbhJ2Syb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 14:54:31 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:46976 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbhJ2Sy3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 14:54:29 -0400
Received: by mail-ed1-f49.google.com with SMTP id z20so42071484edc.13
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 11:52:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EC5UtP844VCrXh1jvsHre4bGluLntCJroIs+JVaX8Ag=;
        b=uFQfI5fFYJA+6pijNjOn/CcwPNsTQ1AfR9r5/Jr81x4jswIPW4ntNq9cj3DP2FK9kO
         C2S9gmGN1b4ORvwIfe4SJaahfd7b4XKme3stGoyILpdx5JCiyvuX3xs6LV3/F7hh8lkN
         KymdhTg/b6kkS65tCNqDrENNqC4bn9sBNxoLfSavHQnEYdzN+napSXNBAvglMs5RHhpY
         q+TGVvnt5ymHVSZMCkjFb9yALciGI/dD0B9/kiSJEv/a16KQMck9RmuP2kEWVo5AaJqb
         xiq68fPkcFWYJ+85PGhmT4bJyHd2+wK5Cd/R2aCOlf3tN0xdcCGcRdjZtxaSuHP2uWzl
         Zsgg==
X-Gm-Message-State: AOAM533731TRiZ3KIHLLdxEakE0KKWBOfuv+LsufS3WZE0xC/HyOzXRY
        YCJY6E0FTOAtmBlwQLz6NjXq8n41OVkM87wr2/5EJ34+
X-Google-Smtp-Source: ABdhPJxWbtdGgDJy4hV16fuvTBki7izbFXmqPYNztPQS0qT3JGCRyASUs6KC8bzFFBR1d1L52sUn6swcfcLRRf4f4QA=
X-Received: by 2002:a17:906:1451:: with SMTP id q17mr15462166ejc.36.1635533519700;
 Fri, 29 Oct 2021 11:51:59 -0700 (PDT)
MIME-Version: 1.0
References: <20211026013452.1372122-1-eschwartz@archlinux.org>
 <20211029184512.1568017-1-eschwartz@archlinux.org> <20211029184512.1568017-4-eschwartz@archlinux.org>
In-Reply-To: <20211029184512.1568017-4-eschwartz@archlinux.org>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 29 Oct 2021 14:51:48 -0400
Message-ID: <CAPig+cSvecU9XSVobxSO-72rFgAMh5D39UcS6SJ2=xFVvnGJBA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] pretty: add abbrev option to %(describe)
To:     Eli Schwartz <eschwartz@archlinux.org>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 29, 2021 at 2:45 PM Eli Schwartz <eschwartz@archlinux.org> wrote:
> The %(describe) placeholder by default, like `git describe`, uses a
> seven-character abbreviated commit object name. This may not be
> sufficient to fully describe all commits in a given repository,
> resulting in a placeholder replacement changing its length because the
> repository grew in size.  This could cause the output of git-archive to
> change.
>
> Add the --abbrev option to `git describe` to the placeholder interface
> in order to provide tools to the user for fine-tuning project defaults
> and ensure reproducible archives.
> [...]
> Signed-off-by: Eli Schwartz <eschwartz@archlinux.org>
> ---
> diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
> @@ -222,6 +222,10 @@ The placeholders are:
> +** 'abbrev=<N>': Instead of using the default number of hexadecimal digits
> +   (which will vary according to the number of objects in the repository with a
> +   default of 7) of the abbreviated object name, use <n> digits, or as many digits
> +   as needed to form a unique object name.

There's still an inconsistent mix of `<N>` and `<n>` here (mentioned
in my earlier review). Is that intentional or just a simple oversight?
