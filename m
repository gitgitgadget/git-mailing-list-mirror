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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F55C433FE
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 23:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E405122D01
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 23:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725986AbgLDXAq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 18:00:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbgLDXAp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 18:00:45 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97915C0613D1
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 15:00:05 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id y24so6875250otk.3
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 15:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=llTD+BcgrxraXLyT6Hd7guHPxGyCJ5x6KXvrY2nUzc0=;
        b=pslU6x+O4EmoaeFah5O5Nh+sEUj6dls3et1VNS2LQ0Ks2kQoEvGdLkiriCRPY1V7iK
         G2WXmMhnRcOjKbmVXPUFslGH6/b6CrZSKEMGIT1bevNx6nauYYwJf7d8FRf9i8jLhBMe
         XLEambxD+aqBNnNqwuCN/SJyaSSe/40DhNCzRvcQQPcz2m3QofW9y8ni0ytOSuA3ba42
         aKyhSO3+OBZye3fySdJVZ06f3ObJOheZSUzYcYOtkC484z1Pn+IT25Jq6fcdWewKDHXD
         CH2BSEieZV8wW0RYOwp7je2bZifCdlrmXOIhJSDkBy5COFzryvMQwpRQ5TBdUHz2vO+0
         e59Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=llTD+BcgrxraXLyT6Hd7guHPxGyCJ5x6KXvrY2nUzc0=;
        b=U6o8G55OFHKj+Zcb6TTVIpG9r6zelAmayg5PLFogLPtZvpFAlj1mTvOwbmZ05sDwO8
         +DoscRyUxV5wOBgVseKdFDAedjZipvZ1WC3bhSiXVW1aofZ9lu5B/ZSXL45vk1OWGPtK
         mms76dVbRF7uDTcTF6Tq6Nv+iXZUmlWbHWhxIeDE8RbCuahxEA52qwEelcO2Cgx+iP6M
         3mU9jwYROc6qFEtpJeWdtYWI53Lq1XJsosM7tv9IW0EnAq4O8UmIqdexRkPm8coFMF+G
         TaQQBHYO5qIg3K/VXPsR2130SzvYWROmAQHnO8g/ByKQ3GQljy6S2qPnOhSH7AN9q7dZ
         a0fA==
X-Gm-Message-State: AOAM532QnOwjjmTYk1J2ivYYUiIMSbhhG5Y/pQDHmfB2tKSjQCTVzWjz
        BhPc1iT43i2ZvjcHQEfHttdxIjURQzgWViNMyZ3iKONoUGFEgA==
X-Google-Smtp-Source: ABdhPJwU7lyhhqyO7E7OrbEeTjBGFQnLC4+OrsTjje5YYLI39WGtCuxgYe6eqz3jczhoAh9HKd8UAVdj604OVKhfmLc=
X-Received: by 2002:a9d:b8e:: with SMTP id 14mr3371979oth.316.1607122804294;
 Fri, 04 Dec 2020 15:00:04 -0800 (PST)
MIME-Version: 1.0
References: <20201204061623.1170745-1-felipe.contreras@gmail.com> <20201204061623.1170745-3-felipe.contreras@gmail.com>
In-Reply-To: <20201204061623.1170745-3-felipe.contreras@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 4 Dec 2020 14:59:53 -0800
Message-ID: <CABPp-BFdjj=+4jk0vo=kpNc6ug1=UgtKfXJZkseyyxut2VB=Uw@mail.gmail.com>
Subject: Re: [PATCH v2 02/14] pull: improve default warning
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
> We want to:
>
> 1. Be clear about what "specifying" means; merge or rebase.
> 2. Mention a direct shortcut for people that just want to get on with
>    their lives: git pull --no-rebase.

This is a shortcut for what?

> 3. Have a quick reference for users to understand what this
>    "fast-forward" business means.
>
> This patch does all three.
>
> Thanks to the previous patch now "git pull --help" explains what a
> fast-forward is, and a further patch changes --no-rebase to --merge so
> it's actually user friendly.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  builtin/pull.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
>
> diff --git a/builtin/pull.c b/builtin/pull.c
> index 1034372f8b..22a9ffcade 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -346,17 +346,18 @@ static enum rebase_type config_get_rebase(void)
>
>         if (opt_verbosity >= 0 && !opt_ff) {
>                 advise(_("Pulling without specifying how to reconcile divergent branches is\n"
> -                        "discouraged. You can squelch this message by running one of the following\n"
> -                        "commands sometime before your next pull:\n"
> -                        "\n"
> -                        "  git config pull.rebase false  # merge (the default strategy)\n"
> -                        "  git config pull.rebase true   # rebase\n"
> -                        "  git config pull.ff only       # fast-forward only\n"
> -                        "\n"
> -                        "You can replace \"git config\" with \"git config --global\" to set a default\n"
> -                        "preference for all repositories. You can also pass --rebase, --no-rebase,\n"
> -                        "or --ff-only on the command line to override the configured default per\n"
> -                        "invocation.\n"));
> +                       "discouraged; you need to specify if you want a merge, or a rebase.\n"

...want a merge, a rebase, or neither.

> +                       "You can squelch this message by running one of the following commands:\n"
> +                       "\n"
> +                       "  git config pull.rebase false  # merge (the default strategy)\n"

Should this be labelled as the default given the desire to make
--ff-only the default?  Perhaps I'm jumping ahead and you plan to
change that later in this series.

> +                       "  git config pull.rebase true   # rebase\n"
> +                       "  git config pull.ff only       # fast-forward only\n"
> +                       "\n"
> +                       "You can replace \"git config\" with \"git config --global\" to set a default\n"
> +                       "preference for all repositories.\n"

Good up to here.

> +                       "If unsure, run \"git pull --no-rebase\".\n"

Why is that safe to suggest?  The original text may not have been the
easiest to parse, but this seems more problematic to me.

> +                       "Read \"git pull --help\" for more information."

Nice addition.


> +                       ));
>         }
>
>         return REBASE_FALSE;
> --
> 2.29.2
>
