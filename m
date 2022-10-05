Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FC0C433F5
	for <git@archiver.kernel.org>; Wed,  5 Oct 2022 05:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiJEFXK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Oct 2022 01:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiJEFXI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2022 01:23:08 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F3A6746A
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 22:23:07 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id k19so3974171lji.12
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 22:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=brKA6aEavkLWnbY5lnq+8WDTIXUdpEYa+w+9jnEHyTc=;
        b=Ml8IQ8OcKExVY2b8ZZfWWWcUOC6CxgKs5OPJRqOHhJGVeOTVHhPAdD+EVAn+xo67Nj
         R7MRaU8sv/EK/ONebp+Vzhc7C48swsIqS/v3NB84MBGmyUrQLzjeRvwjYTn9OQw7MLVd
         8rEghgSH3UmRfmI/8pmXLYjwWXbPLnwJxwBYXm5Ofec9McujwDqYNzUE9jefX86NAP8N
         iBPa20Is7/Tourf7AcvtzG3kTQ5EQYctos5yaxvTZzlPZUcZgX/LZ1F8UUot6RyJPGLf
         nF2gxovzmp2w8DbjwNFid+T/XpNjxUzgBD2GwHUlAu33utnyorNHMYzJKf+DvqYVr1YZ
         AWEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=brKA6aEavkLWnbY5lnq+8WDTIXUdpEYa+w+9jnEHyTc=;
        b=Ry8JXXXIc1rR6bZIDLNedFOOz7gd37Ag6R//Nn/FiLr7tfR8FJ/ldLv8SF/8rBd2Am
         srnkijlqtCcKuccv0XSNoweliwUH/AMbdNYRVtgkMi8BW1N8ZxUInQtKS+Rcsj6fmlPk
         hzlfvPZh0sZXxImqciueFXlqWOhrtUPmpljjm7FqodTugME1H1U7KkW6xubfnpapPnMx
         axhmHNTwiK/1MryTb6pOyJLNBWR50FBpgsLKi32rchaDcqgQzSN5ifFK4uiSvMbjpm93
         y3RrdgoalZgSRcKz6kPtkdtEiapjR2EnlrqeLhNZWzGVgfG3C/YRF1KgxFaiZCU5QeJ6
         k/aA==
X-Gm-Message-State: ACrzQf2BJYyYUq/xzkdanTwhRS12sO26dnjGtn7Reunsa/u01PNbckju
        auQ3cFDA7NHrtZukWOmH79PKbbn0Px4drkfAmZA=
X-Google-Smtp-Source: AMsMyM44IWJIO/AgJRt3joeFxDtt8/MpZ51KySf5TEo2MWJ8MSnuwvQOoJJF++z9Ez314OYAeuFf0j7+oGFpdTZeP/w=
X-Received: by 2002:a2e:808c:0:b0:26c:33d3:a91d with SMTP id
 i12-20020a2e808c000000b0026c33d3a91dmr9877290ljg.73.1664947385361; Tue, 04
 Oct 2022 22:23:05 -0700 (PDT)
MIME-Version: 1.0
References: <kl6l35c4mukf.fsf@chooglen-macbookpro.roam.corp.google.com>
 <54ee4a2a-1937-8640-9297-8ad1516596cc@github.com> <CAESOdVAh68HoQoyicfZn4XbjGfiRFCu1zFQmUjMcSAg3tUzr4Q@mail.gmail.com>
 <96c4f52e-bc66-f4ee-f4f6-d22da579858e@github.com>
In-Reply-To: <96c4f52e-bc66-f4ee-f4f6-d22da579858e@github.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 4 Oct 2022 22:22:53 -0700
Message-ID: <CABPp-BGeC3hXw-v3voniY5ZU2f6W8NXfXVvq0C03eGGhvSefgg@mail.gmail.com>
Subject: Re: Bug report: `git restore --source --staged` deals poorly with sparse-checkout
To:     Victoria Dye <vdye@github.com>
Cc:     Martin von Zweigbergk <martinvonz@google.com>,
        Glen Choo <chooglen@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 4, 2022 at 1:35 PM Victoria Dye <vdye@github.com> wrote:
>
[...]
> >> Thanks for reporting this! There are a few confusing things going on with
> >> 'restore' here.
> >>
> >> First is that the out-of-cone was even restored in the first place.

Yep, agreed.  I'll add this example to the Known bugs section.

[...]
> >> Theoretically, 'restore' (like 'checkout') should be limited to pathspecs
> >> inside the sparse-checkout patterns (per the documentation of
> >> '--ignore-skip-worktree-bits'), but 'Documentation' does not match them.
> >> Then, there's a difference between 'restore' and 'checkout' that doesn't
> >> seem intentional; both remove the 'SKIP_WORKTREE' flag from the file, but
> >> only 'checkout' creates the file on-disk (therefore avoiding the "deleted"
> >> status).
> >
> > Restoring only into the index (as I think `git restore --staged` is supposed
> > to do) is weird.
>
> 'git restore --staged' is intended to restore to both the worktree and index
> (per 183fb44fd2 (restore: add --worktree and --staged, 2019-04-25)). The bug
> you've identified is that it's not restoring to the worktree.

I think that commit message is easy to mis-read.  --staged means
restore to the index, and does not restore to the working tree unless
the user also specifies --worktree.  Duy considered adding a
`--no-worktree` option but decided against it.

(In constrast, `checkout` always restores to both places and gives no
way to do just one.  Defaulting to just the worktree and letting the
user pick was one of the two big warts that `restore` fixed relative
to `checkout` -- the other being the --no-overlay mode.)

[...]
> > If we now do `git restore --staged --source HEAD^` and that
> > command doesn't remove the `SKIP_WORKTREE` flag on any paths, that logically
> > means that we have modified the working copy, and I think `git
> > sparse-checkout disable` would agree with me.
>
> If you aren't using '--ignore-skip-worktree-bits', the entries with
> SKIP_WORKTREE shouldn't be touched in the first place. If you *do* specify
> it, by virtue of restoring to the working tree, SKIP_WORKTREE must be
> removed.
>
> But suppose you're doing something like 'git restore --staged --no-worktree
> --ignore-skip-worktree-bits --source HEAD^'. In that case:

That'd be `git restore --staged --source=HEAD^
--ignore-skip-worktree-bits -- <paths>`, but I think I understand the
point you're conveying...

> - you are restoring to the index
> - you are *not* restoring to the worktree
> - you're restoring files with SKIP_WORKTREE applied

minor nit: you may also be restoring files that do not exist in HEAD
or the index.  So, I'd rather say here "you're restoring files outside
the sparse specification" to handle those too.

> Right now, SKIP_WORKTREE is removed from the matched entries, but suppose

Right, any code outside of unpack-trees.c that tweaks index entries
tends to replace existing ones with new ones without carefully setting
or copying various flags (like SKIP_WORKTREE) over.  I suspect we just
have another case of that here.  sparse-checkouts are forcing us to
audit all these paths...

> (per your comment) it wasn't. That wouldn't mean that we've "modified the
> working copy"; the working tree is defined with respect to the index, and if
> the index entry says "I don't care about the worktree", then there are no
> differences to reflect.
>
> This raises an interesting question about the current behavior, though: if
> you restore a SKIP_WORKTREE entry with '--staged' and '--no-worktree',
> should we remove SKIP_WORKTREE? I'd lean towards "no", but I'm interested to
> hear other contributors' thoughts.

My current $0.02...

I'd say that, without the --ignore-skip-worktree-bits override, we
should behave like `git-add` and `git-rm` and not operate on paths
outside the sparse specification.  If the paths the user specified
don't match anything in the sparse specification, we should throw an
error and tell the user of the flag to use to override.

With the override...I'd agree that we should only update the index and
still keep (or appropriately set) the SKIP_WORKTREE bits.  Yes, it has
some weirdness (as Martin points out), but that's part of the reason
of requiring the --scope=all override, much as we do with `git-add`
and `git-rm`.  (The override for add/rm is currently named `--sparse`
so it's not quite the same, but we're planning on renaming all these
so that'll make it clearer that it's the same situation for them all.)
