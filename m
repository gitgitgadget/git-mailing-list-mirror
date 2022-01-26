Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D09BC2BA4C
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 10:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240102AbiAZKmh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 05:42:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240100AbiAZKmd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 05:42:33 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7BE8C06161C
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 02:42:32 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id g14so69951859ybs.8
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 02:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8SN6f8gWP+e+8KC3jCVVJvU97gLgMqUhCqU9ks6AfbI=;
        b=g28I1NVgYcpmwYbGwGyF1R+4Yxqu/noyUBsTJGsq2qu7Kcl9p4bbCAHvVNn4xx/9cg
         NnSmHDvn+amU13mJtGETo5IsDwZbm+6v8nCYKsjf75Yz1mtda9Uhy/2skCw1PihGP+nX
         DXQUg3AO0gPIlTiUzsX/xY/pIsKoSFofbZ66W2SrsQTp5pv5w/mFRzk6Ey6x+u7CNlO1
         IdKrTc5RIq/FUCjWZ7/mLs5GXQMu4/oylh7I+l5i2ehh/KK5BOL9edSQMwyStviGWSFL
         BsWAIjnvWvhuY/bUuCvAQF1nhaFubx3SEGHtdfaPZFLnKI6XfJsiD07zC3toeGlAjF/+
         70aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8SN6f8gWP+e+8KC3jCVVJvU97gLgMqUhCqU9ks6AfbI=;
        b=Ao1FaKipi4xMtiNrcvJMB6j5MhOwOCwHcv7lk6mw8dBYof/zTslIgF4B0sQWOzqULt
         P9HYXOlQv/TeaeqJIwqlrplT25mP/HLQ711Ssw542pomWaoFuvwgOzyM04/ItrpJFB+1
         YzW5MydOJGJxGjbrEi2LK8q+2JHcjUhhnbUM3T2uJmBFIwRbiEJlFs65XQwnnINvnONj
         lmzuQ24xPYegpsigyaba36AlivqMI2Aj504AbxzvhWPux8qPncxb611ZvEaQBN8T6zUo
         hB/RHY8AyMqBrUZ9X+8+tMDnqrbdE4CJpviQIgN9YUCegP/2hz5vPS9qu9W/vMJVCYfv
         LWSQ==
X-Gm-Message-State: AOAM532ar21mNboSFfKO7yAehH7peV4AoPYFr6nc6FkT1fmpakf3st64
        OqKaFT1glqYV/eG7kve7UEEyxn2mF48uaLUNZkAW+O8aBpE=
X-Google-Smtp-Source: ABdhPJwhDezQRHFtd5MbuzOGfLsDK14lw7R4rIaf41BtYwdTuxzihcvISf/64juqfqxbb8jiXeIkf/juA7uUtgKlLlM=
X-Received: by 2002:a25:8883:: with SMTP id d3mr36791348ybl.404.1643193751802;
 Wed, 26 Jan 2022 02:42:31 -0800 (PST)
MIME-Version: 1.0
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com> <2f296aeeefbf8340cfb8b7fa4fef5ad49c8b4aa1.1642888562.git.gitgitgadget@gmail.com>
In-Reply-To: <2f296aeeefbf8340cfb8b7fa4fef5ad49c8b4aa1.1642888562.git.gitgitgadget@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 26 Jan 2022 11:42:20 +0100
Message-ID: <CAP8UFD0fRTw0Uh6oWNtCdotRb3F6fvZnpUwm=vT0qzmfeuBvEQ@mail.gmail.com>
Subject: Re: [PATCH 07/12] merge-tree: support including merge messages in output
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 22, 2022 at 10:56 PM Elijah Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:

>  EXIT STATUS
>  -----------
> @@ -72,7 +102,8 @@ be used as a part of a series of steps such as
>
>  However, it does not quite fit into the same category of low-level
>  plumbing commands since the possibility of merge conflicts give it a
> -much higher chance of the command not succeeding.
> +much higher chance of the command not succeeding (and NEWTREE containing
> +a bunch of stuff other than just a toplevel tree).

Is this hunk really related to this commit or should it go into a
previous commit?

> @@ -440,22 +441,30 @@ static int real_merge(struct merge_tree_options *o,
>                 commit_list_insert(j->item, &merge_bases);
>
>         merge_incore_recursive(&opt, merge_bases, parent1, parent2, &result);
> -       printf("%s\n", oid_to_hex(&result.tree->object.oid));
> +
>         if (result.clean < 0)
>                 die(_("failure to merge"));

So this addresses the comment I made in a previous commit related to
the fact that if result.clean < 0 we might not have a valid tree that
we can print. I think though that it would be better if that was
addressed in a previous commit.

> -       else if (!result.clean)
> -               printf(_("Conflicts!\n"));

Ok, so we don't print "Conflicts!\n" now, which makes me wonder if we
should have printed it in the first place in previous commits.

>         if (o.real && o.trivial)
>                 die(_("--write-tree and --trivial-merge are incompatible"));
> +       if (!o.real && original_argc < argc)
> +               die(_("--write-tree must be specified if any other options are"));

Is this necessary? It looks to me like another thing that would be
simplified if we were just adding a new command...
