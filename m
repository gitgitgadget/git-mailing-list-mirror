Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E76C4361A
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 23:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A86A22CAE
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 23:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730287AbgLDXj4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 18:39:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbgLDXj4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 18:39:56 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B9CC0613D1
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 15:39:30 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id p126so8114110oif.7
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 15:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k01578jRcKu7QI/82TxilemS57rWxa7ptc9yxL3BRck=;
        b=u/XN+dje8UnapjRAfHLFsZjAUTs4M2PhscU5I4wmQYhNctzmydfqF1LzsR0mAqWl+6
         Ww59l06e21qA10DJjglJMPQP3KMvTTKV1IgF2zuaFbk3tBcNuYx8mMAS3dOleQFQ0EVE
         s8zEKgcZEF643u7M3J4fcrozqF/PPPyj9AyKDIkGUNNNjRBxqnw6snvZTwzqOZRbac2O
         jer2rEFH9330bLGyLjbilR5pJDHlYSiLO6Pbxu78ZlovXxU6pmHIy+w1Jp/p2HocE/JJ
         oL6dcjROR/gffOg8PMcAugFbKBN6FoF843pt2lmEu273FIiJJiRmNUWuzy1xOUTd6sK4
         anhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k01578jRcKu7QI/82TxilemS57rWxa7ptc9yxL3BRck=;
        b=Zjdy+ZHGv9xofo6Hax+Dh5BxUNBJcYYmNBEbTUuJFsPEHEd2AexOVWNVXe877KI+yg
         boOigxrT6v2genkYggEXXPiaQNQyUn2Tnd2JrMYLhlw6T5CQTUXbKKpfEqjdNGbl/B47
         Vn8UUm8PfVutwrz2EUYVpPN3j564fqrkQ8xad6hmSD9ciiW+MTGu4eRyTCmX5SVBUR78
         ZXjMmTlglK0bEU25UBlLuWljqE7lxW2zsmGmziNAa8+iivWWKT/9Gd4/6sjhs7B4DKvr
         nmalPs+hZtXwZO6dRj71ptpgt5gDYQP3gomqQiktFnJZlqIYXPxf10zeItau4r5hKZ+O
         WOxA==
X-Gm-Message-State: AOAM531lakst76EgoTqh8dT4x+8PLbRHX5KwvSufOjWJ0dUBWGbb+8lK
        o7FbFCHTfUa8dvSX9YC7EcqX5hZ+iJM0JyJEHiU=
X-Google-Smtp-Source: ABdhPJzoTUrnuJEN9CYcPi8oF3idVyRfzq1wbljLuaxqXELrAFc6z9ZGkD3p8ohyUPI4NgnVWXwMfFLv7kds5ke1ZSY=
X-Received: by 2002:a54:4704:: with SMTP id k4mr4872755oik.39.1607125169927;
 Fri, 04 Dec 2020 15:39:29 -0800 (PST)
MIME-Version: 1.0
References: <20201204061623.1170745-1-felipe.contreras@gmail.com> <20201204061623.1170745-12-felipe.contreras@gmail.com>
In-Reply-To: <20201204061623.1170745-12-felipe.contreras@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 4 Dec 2020 15:39:19 -0800
Message-ID: <CABPp-BG0WWvk96T757WMx=004qVqkf+SU8m3cCZsb1feTZJ80Q@mail.gmail.com>
Subject: Re: [PATCH v2 11/14] tentative: pull: change the semantics of --ff-only
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jacob Keller <jacob.keller@gmail.com>,
        John Keeping <john@keeping.me.uk>,
        Richard Hansen <rhansen@rhansen.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 3, 2020 at 10:16 PM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> We want --ff-only to make sense only when no --merge or --rebase option
> is specified.

A lot of git commands have opposite options, and git allows them both
to be specified with the last one winning.  Thus, much like
  git log --patch --no-patch
mean show logs without patches and
  git log --no-patch --patch
means show logs with patches, I would similarly expect the following
two commands to have opposite behavior:
  git pull --merge --no-ff
  git pull --no-ff --merge


> Currently --rebase already ignores --ff-only (or any other --ff option),
> but --merge fails.
>
> Make it so --ff-only is only considered in the default mode.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  builtin/pull.c  | 4 ++++
>  t/t5520-pull.sh | 2 +-
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/pull.c b/builtin/pull.c
> index f54ff36b57..ebf2ac687b 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -1037,6 +1037,10 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>                 }
>         }
>
> +       /* Disable --ff-only when --merge is specified */
> +       if (!can_ff && !default_mode && !opt_rebase && opt_ff && !strcmp(opt_ff, "--ff-only"))
> +               opt_ff = NULL;
> +
>         if (opt_rebase) {
>                 int ret = 0;
>                 if ((recurse_submodules == RECURSE_SUBMODULES_ON ||
> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> index fdd1f79b06..eec6224fb0 100755
> --- a/t/t5520-pull.sh
> +++ b/t/t5520-pull.sh
> @@ -843,7 +843,7 @@ test_expect_success 'git pull non-fast-forward (ff-only)' '
>         test_must_fail git pull
>  '
>
> -test_expect_failure 'git pull non-fast-forward with merge (ff-only)' '
> +test_expect_success 'git pull non-fast-forward with merge (ff-only)' '
>         test_when_finished "git checkout master && git branch -D other test" &&
>         test_config pull.ff only &&
>         git checkout -b other master^ &&
> --
> 2.29.2
>
