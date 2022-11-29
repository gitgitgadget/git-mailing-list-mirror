Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CCBBC433FE
	for <git@archiver.kernel.org>; Tue, 29 Nov 2022 05:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235345AbiK2FKm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Nov 2022 00:10:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbiK2FKk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2022 00:10:40 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F7C4B768
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 21:10:38 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id g7so20774119lfv.5
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 21:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OeYSr7qSjWHjQGmokF9FZeZX5XxGysofhT86H63cSik=;
        b=kwqUemRIb9Py6/6zhovcjjQDwaxt/Ki9yVqKQpc/5snCVP6/Nh9as82FzVL6J8ol/W
         BqnfJIV46dDezjEl5+wuujrJ9YY5cUZr0dlHXJgwubTk26eWUwTo2yF5/wJeNPVuxNOQ
         ExZVDJEivmP6i3R8V0av+N6yDbVXKOcMVrErpEESU0Id2cASwZam9LZlr7XblEloo3ca
         uXHXS9USjOV4xvihBhrGE9YMUwLq7aTH5cnsRQSfBoXuX5DtDnlQNpFdrAoCRydI5xdj
         ppEyRzp5ZbPquJ4murRyg5YJmXWNdUhzuiHZGHPqIaUn9dJSCZzv57R6D9+j0fBJyDs1
         CEdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OeYSr7qSjWHjQGmokF9FZeZX5XxGysofhT86H63cSik=;
        b=KjC9YHfjYEBdUhkwIuxWj93mGsKEyMjEOCrSzqHZV30EvAbZhba41TyPzHsAseA/5W
         CNujRRrnlD+eTPASk3/2eAHZk+QplO9/+wUeM5BObfKk+O3RhEyOObGClQm8fbn8CK/E
         DdvDSsiUsDQs9nFTgAR977v8ylH4ziUCXEuXcnErL0K6PVasXxMkuF/ReyTlv8gLXPsc
         qKk0SYzNz0cTErcI6EPxgWYNEe/DNinJJN4XC0qTa7jMStfMyhA6jwFfbqVQt6FIV7NZ
         vRuM9aWHiNV8Q3jXfGQobHOr20j7GbuTiKvpaxM6dgxm8oRXnFNpndjeOUZ+sEpGE0Pc
         XduQ==
X-Gm-Message-State: ANoB5pn2HA/XXCNDwTUQRvvw/AkWHSbxd0U5bQAhigYEJG7Tx4huUdrZ
        otFrqeap3x8RubQkzMmzGAt0GiYxofHZh5wpq8Y=
X-Google-Smtp-Source: AA0mqf4uOg4we8SLTvKrWvCDiIBMHjlwBSx1L86w+aRZHUlxxQKF4VDUZXlAfrexYDZk/B9RvQzUV7Rx5Iozsvu+DPA=
X-Received: by 2002:a19:3803:0:b0:4b4:ce52:7a63 with SMTP id
 f3-20020a193803000000b004b4ce527a63mr11685278lfa.65.1669698636880; Mon, 28
 Nov 2022 21:10:36 -0800 (PST)
MIME-Version: 1.0
References: <20221127093721.31012-1-sorganov@gmail.com> <20221127093721.31012-4-sorganov@gmail.com>
In-Reply-To: <20221127093721.31012-4-sorganov@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 28 Nov 2022 21:10:23 -0800
Message-ID: <CABPp-BFHQ8KwNK=FKGc96iQYqr9xT--WH7kg5R-CzCaAiWiRZg@mail.gmail.com>
Subject: Re: [PATCH 3/5] diff-merges: implement log.diffMergesForce config
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        huang guanlong <gl041188@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 27, 2022 at 1:37 AM Sergey Organov <sorganov@gmail.com> wrote:
>
> Force specified log format for -c, --cc, and --remerge-diff options
> instead of their respective formats. The override is useful when some
> external tool hard-codes diff for merges format option.
>
> Using any of the above options twice or more will get back the
> original meaning of the option no matter what configuration says.
>
> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> ---
>  Documentation/config/log.txt | 11 +++++++++++
>  builtin/log.c                |  2 ++
>  diff-merges.c                | 32 ++++++++++++++++++++++++++------
>  diff-merges.h                |  2 ++
>  t/t4013-diff-various.sh      | 18 ++++++++++++++++++
>  t/t9902-completion.sh        |  3 +++
>  6 files changed, 62 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/config/log.txt b/Documentation/config/log.txt
> index 265a57312e58..7452c7fad638 100644
> --- a/Documentation/config/log.txt
> +++ b/Documentation/config/log.txt
> @@ -43,6 +43,17 @@ log.diffMergesHide::
>  log.diffMerges-m-imply-p::
>         `true` enables implication of `-p` by `-m`.
>
> +log.diffMergesForce::
> +       Use specified log format for -c, --cc, and --remerge-diff
> +       options instead of their respective formats when the option
> +       appears on the command line one time. See `--diff-merges` in
> +       linkgit:git-log[1] for allowed values. Using 'off' or 'none'
> +       disables the override (default).
> ++
> +The override is useful when external tool hard-codes one of the above
> +options. Using any of these options two (or more) times will get back
> +the original meaning of the options.

I didn't quite understand your intent here from this explanation.
When you pointed out to Junio that you wanted to override magit's
hard-coded `git log --cc` and turn it into `git log -m -p`, then it
suddenly made more sense.  And the two or more times I guess is your
escape hatch to allow users to say "I *really* do want this other
format, so `git log --cc --cc` will get it for me.".

Maybe something like:

Override -c, --cc, --remerge-diff options and use the specified
diff-generation scheme for merges instead.  However, this config
setting can in turn be overridden by specifying an alternate option
multiple times (e.g. `git log --cc --cc`).  Overriding the
diff-generation scheme for merges can be useful when an external tool
has a hard-coded command line it calls such as `git log --cc`.  See
`--diff-merges` in linkgit:git-log[1] for allowed values.  Using 'off'
or 'none' disables the override (default).

However:
  * This feels like we're trying to workaround bugs or inflexibility
in other tools with code in Git.  This feels like a slippery slope
issue and/or fixing the wrong tool.
  * Why is this just for -c, --cc, and --remerge-diff, and not for
also overriding -m?  It seems odd that one would be left out,
especially since tools are more likely to have hard-coded it than
--remerge-diff, given that -m has been around for a long time and
--remerge-diff is new.

> +
>  log.follow::
>         If `true`, `git log` will act as if the `--follow` option was used when
>         a single <path> is given.  This has the same limitations as `--follow`,
[...]
> diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
> index 1789dd6063c5..8a90d2dac360 100755
> --- a/t/t4013-diff-various.sh
> +++ b/t/t4013-diff-various.sh
> @@ -557,6 +557,24 @@ test_expect_success 'git config log.diffMerges-m-imply-p has proper effect' '
>         test_cmp expected actual
>  '
>
> +test_expect_success 'git config log.diffMergesForce has proper effect' '
> +       git log -m -p master >result &&
> +       process_diffs result >expected &&
> +       test_config log.diffMergesForce on &&

I think the default for `on` is bad; it made sense at the time, but I
think we have a better option now.  Perhaps we switch to it, perhaps
we don't, but if there's _any_ chance at all we change the default for
"on" (which I think there definitely is), then you should really use
the option that matches the actual mode you are using rather than a
synonym for it; doing so future-proofs this testcase.

> +       git log --cc master >result &&
> +       process_diffs result >actual &&
> +       test_cmp expected actual
> +'
> +
> +test_expect_success 'git config log.diffMergesForce override by duplicate' '
> +       git log --cc master >result &&
> +       process_diffs result >expected &&
> +       test_config log.diffMergesForce on &&

Matters less here, but just in case "--cc" were to become the default,
it'd be nice to explicitly use something else like separate here.

> +       git log --cc --cc master >result &&
> +       process_diffs result >actual &&
> +       test_cmp expected actual
> +'
