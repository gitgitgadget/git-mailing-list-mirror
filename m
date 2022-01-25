Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C7A5C433F5
	for <git@archiver.kernel.org>; Tue, 25 Jan 2022 04:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S248956AbiAYEDM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 23:03:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S3418581AbiAYCOU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 21:14:20 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DF6C024145
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 16:22:35 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id f21so12808626ljc.2
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 16:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1GlHLXoOmdyOym1k4K6xI8nhKi59JtqBUWKAMuBMWZ4=;
        b=nAv0jJ+euOVVkmHdgC0YToP+d7Gw0hdSm5aNyv+NRcKIdT8OO2DV/N+tU6C7HEHC9L
         abY67RNHogfCSmEndg5DAHF3McajEy8ZTJ2E1MCV5NRI+HMMg39CqsRA6eQ72YC1YvHB
         ogp7XPpmWYMm9nbrEyABixa+qTSGhMBS8WSXsC7QXBrvn58Pi2pn58dRpl5am2lN/q0I
         sUSKUIyGC7znSZ75631est9qKEwuEUyZvbJ0jwgg+aFOMVgCmF2YEhH99jTIDD79TRFe
         RNQzJhuBC2pAv2P3SvyiHfF+3zAPtFuV24+bvlDgCLDQgSNZVbPdcpvsgYNJ+yIodw9q
         qddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1GlHLXoOmdyOym1k4K6xI8nhKi59JtqBUWKAMuBMWZ4=;
        b=Lu3Y+Soya9wJl9gANhG02FRctTO51U4ENkeVRT84YD/YfayNoXy7RstxlkFkqsli2f
         0qX4y9mBIwLPPvjVk4CpGMfQEZ/gXh/fzJtZ1cTeid2oVRsfmp4tgrEVqQFFBmPCZNBs
         RyyQ5PiVzYYN7b9wHTVRu5wo2xM7lbYLF/43/w1F+8LvlnlLoXpcpOLTQ1YdjW7pxcGe
         fIVX+EM3L3Y4Uojue6hx7TbQinD4kujy74FakqOavVJ/F8Emgl5rPHNY/g07GsfOgD6G
         AIl9JWui7e7EF0QttkBsMqOTAqdD5N+0hOpIYPLVaeXzltwVvRN2ANuoLNWMPzOcyHMj
         B8sw==
X-Gm-Message-State: AOAM531KuLNu7wwaCKKmnnaLxUKteU2oEOHR8SHpSfERBmzDwk0MpBQ/
        rtGciOrprHsp+H2aFblW7VW1e8DCizhil87fs8rp49HX1z0=
X-Google-Smtp-Source: ABdhPJylABAK/BCZRK1dcbnF7iN0iH13ofpcRIAKuXUGnWAEPWLRp1NOQD0hdqjy8yrxm6QkFMeQer+yIGWQzW0TJzI=
X-Received: by 2002:a05:651c:4d4:: with SMTP id e20mr12896262lji.195.1643070153710;
 Mon, 24 Jan 2022 16:22:33 -0800 (PST)
MIME-Version: 1.0
References: <pull.1124.git.1642987616372.gitgitgadget@gmail.com>
In-Reply-To: <pull.1124.git.1642987616372.gitgitgadget@gmail.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Tue, 25 Jan 2022 08:22:19 +0800
Message-ID: <CANYiYbGJc6RStoCfJjh0Y3BzQ1QdnoN_xSFz4keYVik1dq0cnw@mail.gmail.com>
Subject: Re: [PATCH] receive-pack: purge temporary data if no command is ready
 to run
To:     BoJun via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>, BoJun <bojun.cbj@gmail.com>
Cc:     Chen Bojun <bojun.cbj@alibaba-inc.com>,
        =?UTF-8?B?5r6z5piO?= <tenglong.tl@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 24, 2022 at 11:12 PM BoJun via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> -mk_empty () {
> +mk_empty() {

That's wrong. We prefer a space between the function name and the
parentheses for shell script, see:

 * https://github.com/git/git/blob/master/Documentation/CodingGuidelines#L138

>         repo_name="$1"
>         rm -fr "$repo_name" &&
> -       mkdir "$repo_name" &&
> -       (
> -               cd "$repo_name" &&
> -               git init &&
> -               git config receive.denyCurrentBranch warn &&
> -               mv .git/hooks .git/hooks-disabled
> -       )
> +               mkdir "$repo_name" &&
> +               (
> +                       cd "$repo_name" &&
> +                               git init &&
> +                               git config receive.denyCurrentBranch warn &&
> +                               mv .git/hooks .git/hooks-disabled
> +               )

The indent your made is ugly.

>  }
>
> -mk_test () {
> +mk_test() {
>         repo_name="$1"
>         shift
>
>         mk_empty "$repo_name" &&
> -       (
> -               for ref in "$@"
> -               do
> -                       git push "$repo_name" $the_first_commit:refs/$ref ||
> -                       exit
> -               done &&
> -               cd "$repo_name" &&
> -               for ref in "$@"
> -               do
> -                       echo "$the_first_commit" >expect &&
> -                       git show-ref -s --verify refs/$ref >actual &&
> -                       test_cmp expect actual ||
> -                       exit
> -               done &&
> -               git fsck --full
> -       )
> +               (
> +                       for ref in "$@"; do

Code style of the original is goold, yours is bad. See:

 * https://github.com/git/git/blob/master/Documentation/CodingGuidelines#L100

> +                               done &&
> +                               git fsck --full
> +               )
>  }
>
>  mk_test_with_hooks() {

This is the place you can fix by adding a space between the function
name and the parentheses.

> +               (
> +                       cd "$repo_name" &&
> +                               mkdir .git/hooks &&
> +                               cd .git/hooks &&
> +                               cat >pre-receive <<-'EOF' &&
> +                                       #!/bin/sh
> +                                       cat - >>pre-receive.actual

Too deep indent. The original implementation is good, yours is bad.

>
> -for head in HEAD @
> -do
> +for head in HEAD @; do

Bad coding style, please read through the "CodingGuidelines" for bash.

--
Jiang Xin
