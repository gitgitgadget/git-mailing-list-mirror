Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0530A1F453
	for <e@80x24.org>; Fri,  2 Nov 2018 15:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbeKCA57 (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 20:57:59 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36290 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbeKCA57 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 20:57:59 -0400
Received: by mail-io1-f67.google.com with SMTP id o19-v6so1695190iod.3
        for <git@vger.kernel.org>; Fri, 02 Nov 2018 08:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k9YqZBDrqaNCJQXHqUvj3onFvKNqBecXO9o0mVuCnJo=;
        b=hAFe/2dFd1cG16VhDARo54iBCvbmCI2NqARN/Lyy0ahkoJH0Vb02ZfzznWoWDYEWuE
         OxCH49pLvj3SfLaCaPSCab76E/eH3uCGt/lvuxUQkAh3dwLuJwGpgRU+cKO0BP9Q7PGS
         8yTUqMVb4XXdqr9yAq2+wVKogSwEPWsA5/UZby7nxXZ5FO2bF/LgkvgcSOTvfoRfX9Zc
         lf9XrZUNOoJyuSPZyT12ZmyQko4aoE/l5MwqMViVmoXwGSA/DTxguUY2n4Y9TN1oqKny
         yVOWb2BlkSl+zNB7gcjYgb30dpziiaF5r1AoeQ8ODibjKl5BdbOGM9O7HAv2LreLUvAR
         tJsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k9YqZBDrqaNCJQXHqUvj3onFvKNqBecXO9o0mVuCnJo=;
        b=OQqob2bDEg1RIO/2j4TTzS4OgpBe06nU9WpFb9+888jQr6ox0OMCdJmNVvk+7aLC+Z
         63942tPqh4p9wNpYHjXlt3e7f4jgwPhQ1l1gtDft3O1m/ea2uAH+yPBdwngvzDVGIkB+
         TVfYfjDuuqiwUx8Er0Guy9MUHlrYNzYPkm4u1SZ5OblL/m7y+drJzYH0ot4YT5rbrAPA
         B9sx2U0X2tXjRp923BM12iCEx4eAgFIEIUIzXwfBSVB22+oG/lCHzj3+tlMDNATV5w4C
         9bCi7fsRycqEGERwGs6j2v2ok4DuLPnQYapyIWMPfT/fxRb7FPCdQ0cOlWXyYdZHVuTb
         XA0Q==
X-Gm-Message-State: AGRZ1gJcMPeUnXSRbJ1cFmuaCYp6/cqC8RrFLjL3MM6tz93NzM4s22ho
        d9NH02rXa4M8SYQ2o3RuczCbZsaykk0pWpXwOkg=
X-Google-Smtp-Source: AJdET5e73d44JSWftQlY2s7Cpqm5YgUpGkAzimr8pfBF+E9RF+h0qVdI7mHZWLFLeg1OwVmXzEzZk5tQgwppGKWFlQo=
X-Received: by 2002:a6b:216:: with SMTP id 22-v6mr9568652ioc.118.1541173826379;
 Fri, 02 Nov 2018 08:50:26 -0700 (PDT)
MIME-Version: 1.0
References: <20181102133050.10756-1-peartben@gmail.com>
In-Reply-To: <20181102133050.10756-1-peartben@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 2 Nov 2018 16:49:59 +0100
Message-ID: <CACsJy8CVPSe8TWYMrK9MiRCaG36qyWfd42cEPo5844XWuTmqew@mail.gmail.com>
Subject: Re: [PATCH v1] add: speed up cmd_add() by utilizing read_cache_preload()
To:     Ben Peart <peartben@gmail.com>
Cc:     Ben Peart <benpeart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 2, 2018 at 2:32 PM Ben Peart <peartben@gmail.com> wrote:
>
> From: Ben Peart <benpeart@microsoft.com>
>
> During an "add", a call is made to run_diff_files() which calls
> check_remove() for each index-entry.  The preload_index() code distributes
> some of the costs across multiple threads.

Instead of doing this site by site. How about we make read_cache()
always do multithread preload?

The only downside I see is preload may actually harm when there are
too few cache entries (but more than 500), but this needs to be
verified. If the penalty is small enough, I think we could live with
it since everything is fast when you have few entries anyway.

But if that's not true, we could add a threshold to activate preload.
Something like "if you have 50k files or more, then activate preload"
would do. I notice THREAD_COST in preload code, but I don't think it's
the same thing.

>
> Because the files checked are restricted to pathspec, adding individual
> files makes no measurable impact but on a Windows repo with ~200K files,
> 'git add .' drops from 6.3 seconds to 3.3 seconds for a 47% savings.
>
> Signed-off-by: Ben Peart <benpeart@microsoft.com>
> ---
>
> Notes:
>     Base Ref: master
>     Web-Diff: https://github.com/benpeart/git/commit/fc4830b545
>     Checkout: git fetch https://github.com/benpeart/git add-preload-index-v1 && git checkout fc4830b545
>
>  builtin/add.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/add.c b/builtin/add.c
> index ad49806ebf..f65c172299 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -445,11 +445,6 @@ int cmd_add(int argc, const char **argv, const char *prefix)
>                 return 0;
>         }
>
> -       if (read_cache() < 0)
> -               die(_("index file corrupt"));
> -
> -       die_in_unpopulated_submodule(&the_index, prefix);
> -
>         /*
>          * Check the "pathspec '%s' did not match any files" block
>          * below before enabling new magic.
> @@ -459,6 +454,10 @@ int cmd_add(int argc, const char **argv, const char *prefix)
>                        PATHSPEC_SYMLINK_LEADING_PATH,
>                        prefix, argv);
>
> +       if (read_cache_preload(&pathspec) < 0)
> +               die(_("index file corrupt"));
> +
> +       die_in_unpopulated_submodule(&the_index, prefix);
>         die_path_inside_submodule(&the_index, &pathspec);
>
>         if (add_new_files) {
>
> base-commit: 4ede3d42dfb57f9a41ac96a1f216c62eb7566cc2
> --
> 2.18.0.windows.1
>


-- 
Duy
