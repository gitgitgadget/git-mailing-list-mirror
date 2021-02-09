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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 535C9C433E9
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 10:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0330F64E15
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 10:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbhBIKQ2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 05:16:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbhBIKHi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 05:07:38 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E009EC061793
        for <git@vger.kernel.org>; Tue,  9 Feb 2021 02:06:57 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id r75so5215751oie.11
        for <git@vger.kernel.org>; Tue, 09 Feb 2021 02:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RB9GH2aOxkdceRb7YWYsD+iVgg3ITTSLiKum7QcXBHY=;
        b=p5xc/0SalPsRsDm2klU6f4RF8stLezqb+2g2QKVLki0hQerp+OYxtpH5mAZS5RYyDS
         bMWMvuP82RVW9w9mX9MzAZyfuckg0Is091GjNdoF+OeJAYIxo6ebLZDqOE0y/fJZ+eLQ
         XTh7qqTy3idMIdbFq1KHPo3zBlKWZRR8K6q9FCcnXcL7RpgDjCbF0+aGmFz5dniAAFVO
         6Ez1anNouepwjtZK4kIfPw4/RBEFRPH/BE1Z0fBWSXBQz4GW0nmOAa/AvwMm2drORBKt
         uAx3EAzusliWOY4w7Eog0WcGARnmW63KmM1pR8XBDmZ8a0hH3M2GNg4PC1vgYh9YWWFS
         sRkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RB9GH2aOxkdceRb7YWYsD+iVgg3ITTSLiKum7QcXBHY=;
        b=GXTIt9HTYoucJV80XVFkGndu9gn2PneZ6oT+HVOyx+NAIkk1x8cmn5vazuFw2L4M4/
         bwUVsH6IsgEXtH4W0BtxSAHXxI+cuwL0Azgf6qTd/x2TKxSLLrSvQoEBvUnNZEHw9QPm
         rkXTNUsMLtmZ2gBsoJXtkxoV4LocU9hconBRcRRR48qs+YbwMad4B67YU8JKif+NdIFZ
         xnbh7v2be+5xxywUG3FHLzFicoHmsECNLm0NLIl1mRBPkOnRJoMDPXUhwwddK4+Deuce
         jjoGGEwfU6a07njtEX+ankjzAhh4oWVcLZgRKDvoXxSWfj1sLaZbcXX8bZG8MMJeFXjj
         q5Xg==
X-Gm-Message-State: AOAM531ieQrMakEseHQIAmOYcJjlhcPGjFUOFYskF+VqozKnB1m7CI1n
        TwGzi46mzZqFYDe/uvhLXsxBDCPL8QNQMQ8aObo=
X-Google-Smtp-Source: ABdhPJzDlDFvRkKmbFLhCXi0SWWB50KsKG6TbPi48G2qzMCCSBNgJFkxWCXxgf15xKLnkUkWs2/aalKt6LSjGCyra+g=
X-Received: by 2002:a54:4790:: with SMTP id o16mr1924572oic.39.1612865217185;
 Tue, 09 Feb 2021 02:06:57 -0800 (PST)
MIME-Version: 1.0
References: <YCGxos2vB6mgHOTA@nand.local> <20210208232159.100543-1-matheus.bernardino@usp.br>
In-Reply-To: <20210208232159.100543-1-matheus.bernardino@usp.br>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 9 Feb 2021 02:06:46 -0800
Message-ID: <CABPp-BFouwiACwwS5mDdgBRF=YK--=NfqZ9r=qkFouEvyJfnGQ@mail.gmail.com>
Subject: Re: [PATCH] grep: error out if --untracked is used with --cached
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 8, 2021 at 3:27 PM Matheus Tavares
<matheus.bernardino@usp.br> wrote:
>
>
> On Mon, Feb 8, 2021 at 6:48 PM Taylor Blau <me@ttaylorr.com> wrote:
> >
> > On Mon, Feb 08, 2021 at 04:43:28PM -0300, Matheus Tavares wrote:
> > > The options --untracked and --cached are not compatible, but if they are
> > > used together, grep just silently ignores --cached and searches the
> > > working tree. Error out, instead, to avoid any potential confusion.
> > >
> > > Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> > > ---
> > >  builtin/grep.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/builtin/grep.c b/builtin/grep.c
> > > index ca259af441..392acf8cab 100644
> > > --- a/builtin/grep.c
> > > +++ b/builtin/grep.c
> > > @@ -1157,6 +1157,9 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
> > >       if (!use_index && (untracked || cached))
> > >               die(_("--cached or --untracked cannot be used with --no-index"));
> > >
> > > +     if (untracked && cached)
> > > +             die(_("--untracked cannot be used with --cached"));
> > > +
> >
> > Are these really incompatible? --untracked says that untracked files are
> > searched in addition to tracked ones in the working tree.
> > --cached says that the index is searched instead of tracked files. From
> > my reading, that seems to imply that the combination you're proposing
> > getting rid of would mean: "search the index,and untracked files".
>
> Yeah, I agree that there is nothing conceptually wrong with the use case
> "search the index, and untracked files". The problem is that git-grep is
> currently not able to search both these places in the same execution.
> In fact, I don't think it can combine working tree and index searches
> in any way (besides with --assume-unchanged paths).
>
> When --cached is used with --untracked, git-grep silently ignores
> --cached and searches the working tree only:
>
> $ echo 'cached A' >A
> $ git add A
> $ git commit -m A
> $ echo 'modified A' >A
> $ echo 'untracked' >B
> $ git grep --cached --untracked .
> A:modified A
> B:untracked
>
> Perhaps, instead of erroring out with this currently invalid
> combination, should we make it valid by teaching git-grep how to search
> the two places on a single run? I.e. something like:
>
> diff --git a/builtin/grep.c b/builtin/grep.c
> index ca259af441..b0e99096ff 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -699,7 +699,7 @@ static int grep_objects(struct grep_opt *opt, const struct pathspec *pathspec,
>  }
>
>  static int grep_directory(struct grep_opt *opt, const struct pathspec *pathspec,
> -                         int exc_std, int use_index)
> +                         int exc_std, int use_index, int untracked_only)
>  {
>         struct dir_struct dir;
>         int i, hit = 0;
> @@ -712,7 +712,13 @@ static int grep_directory(struct grep_opt *opt, const struct pathspec *pathspec,
>
>         fill_directory(&dir, opt->repo->index, pathspec);
>         for (i = 0; i < dir.nr; i++) {
> -               hit |= grep_file(opt, dir.entries[i]->name);
> +               struct dir_entry *ent = dir.entries[i];
> +
> +               if (untracked_only &&
> +                   !index_name_is_other(opt->repo->index, ent->name, ent->len))
> +                       continue;
> +
> +               hit |= grep_file(opt, ent->name);
>                 if (hit && opt->status_only)
>                         break;
>         }
> @@ -1157,9 +1163,14 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>         if (!use_index && (untracked || cached))
>                 die(_("--cached or --untracked cannot be used with --no-index"));
>
> -       if (!use_index || untracked) {
> +       if (cached && untracked) {
> +               hit = grep_cache(&opt, &pathspec, 1);
> +               hit |= grep_directory(&opt, &pathspec, !!opt_exclude, 1, 1);
> +
> +       } else if (!use_index || untracked) {
>                 int use_exclude = (opt_exclude < 0) ? use_index : !!opt_exclude;
> -               hit = grep_directory(&opt, &pathspec, use_exclude, use_index);
> +               hit |= grep_directory(&opt, &pathspec, use_exclude, use_index, 0);
> +
>         } else if (0 <= opt_exclude) {
>                 die(_("--[no-]exclude-standard cannot be used for tracked contents"));
>         } else if (!list.nr) {
>
> With this, the `git grep --cached --untracked .` search from the
> previous example would produce the following output:
>
> A:cached A
> B:untracked
>
> In this case, should we also add an 'untracked:' / 'cached:' prefix to
> the filenames, like we do for revision searches (e.g. 'HEAD:A:cached A') ?

Ick, no.  --untracked was a modifier on working tree searches.  I
think doing this adds a really weird inconsistency for all the other
option combinations.  I say mark --untracked and --cached as
incompatible like you did in your original patch, unless you're
willing to make grep generally be able to have options to search two
or more locations from any of (revisions of history, the cache, the
working tree), including being able to simultaneously search two
different revisions of history.  Even then, I'd be tempted to say that
--untracked is only used in combination with a search of the working
tree.
