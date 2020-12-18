Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05DCCC2BBD4
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 06:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFC1323A79
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 06:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732612AbgLRGBq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 01:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgLRGBq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 01:01:46 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C827C0617A7
        for <git@vger.kernel.org>; Thu, 17 Dec 2020 22:01:06 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id a109so988883otc.1
        for <git@vger.kernel.org>; Thu, 17 Dec 2020 22:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Of4AELxqV/0nR8kIWCQJKR7bW1xY8EQc17EBHI8g1a8=;
        b=le6U7VqC2llizRjEo6ihJ74IwRll+HOA29eEFzzSM/q53wXvkPB5dQhfNUh2Tzzvsq
         bxi5Nm/Zs6Img5+Or+FEUO8XH5HUW75p78/3SQbtXc2x9Q5zsUH4Goc9wplgm5C+bb/a
         LgPKm9QNFSEz5+b5Rqpp+fJh9e+JXTmkC3/OOlpKJsIBa+VZKhrD6ARJsL6iETn0lmG3
         T4SA1e2cbg3yUJ2iMXj0q1XlLiGyNSwtWv9gITGZpx546oJKxtftI+OPEqT+xkmSfnr4
         9jhJJxhH+qnU3ITgtzMZyLRGvgYEjF2p6aCUOJCqkE7i8qpl+MrhXZCEtqqr5wPgzXwY
         e1Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Of4AELxqV/0nR8kIWCQJKR7bW1xY8EQc17EBHI8g1a8=;
        b=p48cjEIyUssei4tZk8qPNjVm9T3u52ZlhuusTyQ40r3nbn36uQk4MinKsnqDYUoHe0
         e80DE9685JAL+B4rIXdXRaOHqh3ChqtumEHv9jMR+iBtyHhF/+qBqlfuo0L3jnOAZzgA
         3OUOgiLkI970pmmkMGv9j0Uhm0aeqnMQWuK0TsXlnWbrbYGZW3Zap3tffsrCZdP3vXwD
         0ouRkLXLLUhlf3wg/5yF/1mhNZxw1Si2XO39/9LHqAR7mFDk0ZEQY8sabZgpE8ZXGk8o
         FTsfOEjr9iWXuGwMzPQb6f0LhciZkFrnsNgYBGJjQ8kuTIy6jbzlBccagNlCLU0b7g24
         rpaA==
X-Gm-Message-State: AOAM5325FWhK4aLbKWLa7wW9jsvmpOkpxZIo7ECLs7XuPIhawEjHLR/t
        AHZlCPbgGhXbsiEao33MtsNeBXefG4drnTlX04k=
X-Google-Smtp-Source: ABdhPJymS6iygYqQuXLF3cbdqlHfMFVgaTf3Ltdpfs7/bYfg0W7ZV7E2rg3BBA3Avafa68QzRiJGxxvETDdItEQuF8E=
X-Received: by 2002:a9d:b8e:: with SMTP id 14mr1795681oth.316.1608271265587;
 Thu, 17 Dec 2020 22:01:05 -0800 (PST)
MIME-Version: 1.0
References: <20201101193330.24775-1-sorganov@gmail.com> <20201216184929.3924-1-sorganov@gmail.com>
 <20201216184929.3924-25-sorganov@gmail.com>
In-Reply-To: <20201216184929.3924-25-sorganov@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 17 Dec 2020 22:00:54 -0800
Message-ID: <CABPp-BHh4VSTQ=VOzik5H34OcJaQ63wSgPgrZqJ5-_XvBSow+g@mail.gmail.com>
Subject: Re: [PATCH v2 24/33] diff-merges: handle imply -p on -c/--cc logic
 for log.c
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 16, 2020 at 10:50 AM Sergey Organov <sorganov@gmail.com> wrote:
>
> Move logic that handles implying -p on -c/--cc from
> log_setup_revisions_tweak() to diff_merges_setup_revs(), where it
> belongs.

A very minor point, but I'd probably drop the "where it belongs";
while I think the new place makes sense for it, it reads to me like
you're either relying on a consensus to move it or implying there was
a mistake to not put it here previously, neither of which makes sense.

Much more importantly, this patch doesn't do what you said in
discussions on the previous round.  It'd be helpful if the commit
message called out that you are just moving the logic for now and that
a subsequent patch will tweak the logic to only trigger this for
-c/--cc and not for --diff-merges=.* flags.


> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> ---
>  builtin/log.c | 4 ----
>  diff-merges.c | 7 ++++++-
>  2 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/log.c b/builtin/log.c
> index 63875c3aeec9..c3caf0955b2b 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -723,10 +723,6 @@ static void log_setup_revisions_tweak(struct rev_info *rev,
>             rev->prune_data.nr == 1)
>                 rev->diffopt.flags.follow_renames = 1;
>
> -       /* Turn --cc/-c into -p --cc/-c when -p was not given */
> -       if (!rev->diffopt.output_format && rev->combine_merges)
> -               rev->diffopt.output_format = DIFF_FORMAT_PATCH;
> -
>         if (rev->first_parent_only)
>                 diff_merges_default_to_first_parent(rev);
>  }
> diff --git a/diff-merges.c b/diff-merges.c
> index 0165fa22fcd1..2ac25488d53e 100644
> --- a/diff-merges.c
> +++ b/diff-merges.c
> @@ -127,6 +127,11 @@ void diff_merges_setup_revs(struct rev_info *revs)
>                 revs->first_parent_merges = 0;
>         if (revs->combined_all_paths && !revs->combine_merges)
>                 die("--combined-all-paths makes no sense without -c or --cc");
> -       if (revs->combine_merges)
> +       if (revs->combine_merges) {
>                 revs->diff = 1;
> +               /* Turn --cc/-c into -p --cc/-c when -p was not given */
> +               if (!revs->diffopt.output_format)
> +                       revs->diffopt.output_format = DIFF_FORMAT_PATCH;
> +       }
> +
>  }
> --
> 2.25.1
>
