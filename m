Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B041C433EF
	for <git@archiver.kernel.org>; Sat, 29 Jan 2022 04:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352393AbiA2ErG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 23:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241498AbiA2ErA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 23:47:00 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3ACDC061714
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 20:46:58 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id k25so22873075ejp.5
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 20:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hAvWyvNyEdtdZqFV0gJyhYCuYFJK0kVvxubp4MplHws=;
        b=PLVkO5+VMg/LBmo8BOl3L6FrLaNntnGyZARWGaATecfCUHUvO0yMCvhR33B4+GAOwF
         7VTvnQ5rpMeLnXMEHv1LhalVzL2enbWFrNqLiD/Z4l4e1lEfJbf/BtUavzPIOQNFPI9s
         DycH8iz6Z676MzysVaUd6+9lDVwtLOe+0r71qI/2j7meozQaOXwzHCWRKAk3UfTf9OyK
         dkk7PQQfmaWxmBu8PztNyaf85k3NLv3dZ0NnW8BO8sQF2ovpwakeFA6ntIszWUW6UWxO
         wU5zeoSQ5XmTFua4TTu0GF80vfZ4DlyWMR3LOpYzHD11pARnvW5+1/FXFw1Vzy7SuSes
         o2Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hAvWyvNyEdtdZqFV0gJyhYCuYFJK0kVvxubp4MplHws=;
        b=c3OdlHqMV7Pj7VOBRxev6xN6DaRXPW5Sosj3tHtkVIQQ2HuGK/tZUF76s8HZPmCdXf
         p3W7OvjAIPKQ4BT+FXDLKW6f3DMyio8tgLpTh2iFCmpaud/0R6EpoJMdQnRKlDs2XwtZ
         gvxijHtm8ZTJnRLcs9FHU5cuZU5EkOCt4icYoYTdm7Mqk5xPFd4RTcm+kUVghgipb4Ns
         kII8+cRByUCYgetEvPacOceB78bf9qdKeyJAdvSKy7Dq4nfXx6FDlAmkbjpWVp3fnv6G
         KVKmzVgAcGasjnXTuQA6TEDwIKxv3laBEInhOWAPP0xygExdIse0rEK2NaE6icIY/Lm/
         49Eg==
X-Gm-Message-State: AOAM533d8TgNALsS8sOcqR11JPhtA38tHfEhg9B1wWffCDHgL3jci2j+
        HxN8sgydCTqBHp6NODGQWjjfTglkShlaKbsJX9Q=
X-Google-Smtp-Source: ABdhPJxPmGWwFdbR1UvVro7worYQTrnyBMf69HJVjTMpDy+dGQ2lRZ3Jzm3j9h7BWqV6me9mc8fTiZ3uJhB1MvAPx+w=
X-Received: by 2002:a17:907:60d5:: with SMTP id hv21mr9595301ejc.476.1643431617486;
 Fri, 28 Jan 2022 20:46:57 -0800 (PST)
MIME-Version: 1.0
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
 <2f296aeeefbf8340cfb8b7fa4fef5ad49c8b4aa1.1642888562.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2201281731240.347@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2201281731240.347@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 28 Jan 2022 20:46:46 -0800
Message-ID: <CABPp-BEnH-DeQnReUSCg+CH4ZZr-GzPogCnQvZ76po_BzEPjuw@mail.gmail.com>
Subject: Re: [PATCH 07/12] merge-tree: support including merge messages in output
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 28, 2022 at 8:37 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Elijah,
>
> On Sat, 22 Jan 2022, Elijah Newren via GitGitGadget wrote:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > When running `git merge-tree --write-tree`, we previously would only
> > return an exit status reflecting the cleanness of a merge, and print out
> > the toplevel tree of the resulting merge.  Merges also have
> > informational messages, ("Auto-merging <PATH>", "CONFLICT (content):
> > ...", "CONFLICT (file/directory)", etc.)  In fact, when non-content
> > conflicts occur (such as file/directory, modify/delete, add/add with
> > differing modes, rename/rename (1to2), etc.), these informational
> > messages are often the only notification since these conflicts are not
> > representable in the contents of the file.
> >
> > Add a --[no-]messages option so that callers can request these messages
> > be included at the end of the output.  Include such messages by default
> > when there are conflicts, and omit them by default when the merge is
> > clean.
>
> Makes sense.
>
> > diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
> > index 0c19639594d..560640ad911 100644
> > --- a/builtin/merge-tree.c
> > +++ b/builtin/merge-tree.c
> > @@ -440,22 +441,30 @@ static int real_merge(struct merge_tree_options *o,
> >               commit_list_insert(j->item, &merge_bases);
> >
> >       merge_incore_recursive(&opt, merge_bases, parent1, parent2, &result);
> > -     printf("%s\n", oid_to_hex(&result.tree->object.oid));
> > +
> >       if (result.clean < 0)
> >               die(_("failure to merge"));
> > -     else if (!result.clean)
> > -             printf(_("Conflicts!\n"));
> > +
> > +     if (o->show_messages == -1)
> > +             o->show_messages = !result.clean;
> > +
> > +     printf("%s\n", oid_to_hex(&result.tree->object.oid));
> > +     if (o->show_messages) {
> > +             printf("\n");
> > +             merge_display_update_messages(&opt, &result, stdout);
> > +     }
>
> Excellent.
>
> >       merge_finalize(&opt, &result);
> >       return !result.clean; /* result.clean < 0 handled above */
> >  }
> >
> >  int cmd_merge_tree(int argc, const char **argv, const char *prefix)
> >  {
> > -     struct merge_tree_options o = { 0 };
> > +     struct merge_tree_options o = { .show_messages = -1 };
> >       int expected_remaining_argc;
> > +     int original_argc;
> >
> >       const char * const merge_tree_usage[] = {
> > -             N_("git merge-tree [--write-tree] <branch1> <branch2>"),
> > +             N_("git merge-tree [--write-tree] [<options>] <branch1> <branch2>"),
> >               N_("git merge-tree [--trivial-merge] <base-tree> <branch1> <branch2>"),
> >               NULL
> >       };
> > @@ -464,6 +473,8 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
> >                        N_("do a real merge instead of a trivial merge")),
> >               OPT_BOOL(0, "trivial-merge", &o.trivial,
> >                        N_("do a trivial merge only")),
> > +             OPT_BOOL(0, "messages", &o.show_messages,
> > +                      N_("also show informational/conflict messages")),
> >               OPT_END()
> >       };
> >
> > @@ -472,10 +483,13 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
> >               usage_with_options(merge_tree_usage, mt_options);
> >
> >       /* Parse arguments */
> > +     original_argc = argc;
> >       argc = parse_options(argc, argv, prefix, mt_options,
> >                            merge_tree_usage, 0);
> >       if (o.real && o.trivial)
> >               die(_("--write-tree and --trivial-merge are incompatible"));
> > +     if (!o.real && original_argc < argc)
> > +             die(_("--write-tree must be specified if any other options are"));
>
> Hmm. Well. Hmm.
>
>
> I'd rather keep `--write-tree` neat and optional. What's wrong with
> allowing
>
>         git merge-tree --no-messages HEAD MERGE_HEAD
>
> ?

Yeah, oops.  Nothing is wrong with that...but do note that there is
something wrong with this:

    git merge-tree --no-messages MERGE_BASE HEAD MERGE_HEAD

because the three argument form is signalling the deprecated trivial
merge, and the trivial merge code doesn't handle any options.  You
were right to call out my code since I placed it too early and made it
a bit obtuse.  I've changed it to:

    if (o.mode == 't' && original_argc < argc)
        die(_("--trivial-merge is incompatible with all other options"));

where o.mode is guaranteed to be set before that check.

> To be clear, I think we need this instead:
>
>         if (o.trivial && o.show_messages >= 0)
>                 die(_("--trivial-merge is incompatible with additional options"));

Most of that is better, assuming the o.trivial check handles the
implicit case too.  Thanks.  I'm not so sure about the check on
o.show_messages, though, because then I'll have to keep adding
additional checks for each new additional option (and future patches
will add more).  So, I think I'll keep the original_argc < argc part
of the check instead of that.  :-)

> I like the rest of the patch very much!

Thanks!
