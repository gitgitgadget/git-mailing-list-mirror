Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C86DC28CF5
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 09:45:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbiAZJpL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 04:45:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbiAZJpL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 04:45:11 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BDACC06161C
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 01:45:11 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id r65so66060368ybc.11
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 01:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RXH/YUII1nT1OLQxLpTfAVPdpl55Dxvr1AhXiCbPxYU=;
        b=I44Da6Spnm1TtmYgrUp4wzdP0kRX3EelYazx+5e68bCLdyuA2P6VzJBXIJxdJ5GHrs
         0D/6Eon3SNIvwck+KvAkXkL6pSJqUifaamhcGo5QzDbAQVbh2piSxDD/Fca7eAEYTpwe
         yc4L1d2gxqAeIvrtYW8Ly/MbHdLPZZ3CuZcxAwqvKoo+eaM0FO+tRyu9aZ802M3/5Qdu
         ajAp51Yawi3iinuxamEj88XL8QrdMqg6U2KQU4UGk9WW63lBaYmmBBHXOP6jeY1qbmsB
         lAnwqPZ9PdSU+ZXZw4WDolMCa5tG5+vV4C0s2/sxnSV9SympOviAC8sCsSy0x6yCEYzp
         ahFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RXH/YUII1nT1OLQxLpTfAVPdpl55Dxvr1AhXiCbPxYU=;
        b=4yueuzZclVbAxvMGqyGSxtdBoAE86waV+Cl8OVUu77s15d6ye2qtYBBX2V879ewnF6
         sQY89gdbwQf9TFz7RU6OOR7MThxWqRrsZ6ZUSvAVSBWzR+qsyqba3wo3vtNygqUHxr2R
         buJVx/I/FydtMbKWa6lgokLk7fAy7EmhEzmuKN59rWSfw3N1rr9VbX8224bO2EsQdrC/
         BLzx7GvXe09lr5l7WEMOv2ibSfu2VfZwkOHD0167KZ6ets9fCIDa05appENmSxw+gpkg
         QFHZMO+Ev8OS3oitTKM6mApEGL1ViK9PbSJII+LbABfRReJmF3S/LtjjJ7Yhn/JbgV1s
         h3OA==
X-Gm-Message-State: AOAM532D6iHCf9uexrI1W/tf3KE6Moab8vcaBbpQyk9Wo0JtNp6tnlE3
        +6MOkK8z6Go9MfuiOtp8au4oh9eKg5Gbl8nPS008DtqNkEQ=
X-Google-Smtp-Source: ABdhPJzEJc97/+2BDPzOpHv9wVJW4qgn4t0yXibvemNB4jfRjMnan7VR2N2Dze6p13NMzK6sBBDNKrhKhxSA4bREFKU=
X-Received: by 2002:a25:ad9d:: with SMTP id z29mr28615826ybi.631.1643190310272;
 Wed, 26 Jan 2022 01:45:10 -0800 (PST)
MIME-Version: 1.0
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com> <05bd17686e1404c81542b6bbf69dcd3decb83c5b.1642888562.git.gitgitgadget@gmail.com>
In-Reply-To: <05bd17686e1404c81542b6bbf69dcd3decb83c5b.1642888562.git.gitgitgadget@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 26 Jan 2022 10:44:58 +0100
Message-ID: <CAP8UFD3_Dx2aZObbUp7dHkFCp5w9mJG-s03Soz=9YDU=yE2NoQ@mail.gmail.com>
Subject: Re: [PATCH 04/12] merge-tree: implement real merges
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
>
> From: Elijah Newren <newren@gmail.com>
>
> This adds the ability to perform real merges rather than just trivial
> merges (meaning handling three way content merges, recursive ancestor
> consolidation, renames, proper directory/file conflict handling, and so
> forth).  However, unlike `git merge`, the working tree and index are
> left alone and no branch is updated.
>
> The only output is:
>   - the toplevel resulting tree printed on stdout
>   - exit status of 0 (clean) or 1 (conflicts present)

The exit status can now actually be something other than 0 and 1
according to the doc and code below.

> +Performs a merge, but does not make any new commits and does not read
> +from or write to either the working tree or index.
> +
> +The first form will merge the two branches, doing a full recursive
> +merge with rename detection.

Maybe this could already tell that the first form will also write a
tree with the result of the merge (even in case of conflict) as this
could help understand the reason why the associated option is called
'--write-tree'. It could also help to say that we call such a merge a
'real' merge.

> The rest of this manual (other than the
> +next paragraph) describes the first form in more detail -- including
> +options, output format, exit status, and usage notes.

>  static int real_merge(struct merge_tree_options *o,
>                       const char *branch1, const char *branch2)
>  {
> -       die(_("real merges are not yet implemented"));
> +       struct commit *parent1, *parent2;
> +       struct commit_list *common;
> +       struct commit_list *merge_bases = NULL;
> +       struct commit_list *j;
> +       struct merge_options opt;
> +       struct merge_result result = { 0 };
> +
> +       parent1 = get_merge_parent(branch1);
> +       if (!parent1)
> +               help_unknown_ref(branch1, "merge",
> +                                _("not something we can merge"));

The second argument is supposed to be the command (it's called "cmd"),
so maybe "merge-tree" instead of "merge".

> +       parent2 = get_merge_parent(branch2);
> +       if (!parent2)
> +               help_unknown_ref(branch2, "merge",
> +                                _("not something we can merge"));

idem

> +       opt.show_rename_progress = 0;
> +
> +       opt.branch1 = merge_remote_util(parent1)->name; /* or just branch1? */
> +       opt.branch2 = merge_remote_util(parent2)->name; /* or just branch2? */

I think just:

       opt.branch1 = branch1
       opt.branch2 = branch2

might be better for users as it should show the name as it was passed
to the command.

> +       merge_incore_recursive(&opt, merge_bases, parent1, parent2, &result);
> +       printf("%s\n", oid_to_hex(&result.tree->object.oid));

I wonder if we can actually always output a valid tree when
result.clean < 0. In case we might not, the printing should go a few
lines below.

> +       if (result.clean < 0)
> +               die(_("failure to merge"));
> +       else if (!result.clean)

The "else" is not necessary above.

> +               printf(_("Conflicts!\n"));
> +       merge_finalize(&opt, &result);
> +       return !result.clean; /* result.clean < 0 handled above */
>  }

> diff --git a/t/t4301-merge-tree-real.sh b/t/t4301-merge-tree-real.sh
> new file mode 100755
> index 00000000000..e03688515c5
> --- /dev/null
> +++ b/t/t4301-merge-tree-real.sh

I wonder if it would be better named 't4301-merge-tree-write-tree.sh'...

> @@ -0,0 +1,87 @@
> +#!/bin/sh
> +
> +test_description='git merge-tree --write-tree'

... especially given this description.
