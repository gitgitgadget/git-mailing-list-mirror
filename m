Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9872EB8FA5
	for <git@archiver.kernel.org>; Wed,  6 Sep 2023 05:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235520AbjIFFCy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Sep 2023 01:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjIFFCy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2023 01:02:54 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258128E
        for <git@vger.kernel.org>; Tue,  5 Sep 2023 22:02:50 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99bf3f59905so492392966b.3
        for <git@vger.kernel.org>; Tue, 05 Sep 2023 22:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google; t=1693976568; x=1694581368; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DEN37f+PgIaXZQ9xPyXahuOXsF/AD44HEI5gTQeR+6U=;
        b=aOpls86ZAsRfPndYa0xHvw94VDL3auk4TqvDdn0sJPByRyk9MHr+0sdBNOkHF14AeH
         iURDyOJSpJcnu5V7RIr04cLo1SqupX9Z5FsGpoImtV0zGXiVqpLhrDuqzy1tRDi96FWv
         DQrrAw/Rr/IApNeKYlXjP9sO72pbXJQbXfSHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693976568; x=1694581368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DEN37f+PgIaXZQ9xPyXahuOXsF/AD44HEI5gTQeR+6U=;
        b=b/3t4TxtQOP2DRnmIVnzwEKgvoVWZXGG3BnjQRhwxT1+QIXaZ0OKgsxWb4ybhmTKyc
         kR4JBO+o/V4Tj7hCbUWu821JKbTOiYWVtMOOAoWyNCxtODyYB+bwTP6hmPlNwaV2k4GN
         lccrXYo3jIwEIsPa/p0Xt+5uphRfayuBtKatfKvuqPChPDn3YeGd7O6bxm3RNWkuimm9
         vFrShNenC1DqBGtafnuJBcyq9ViaaS3O7cALS9WY7UiOHHs8t1aQwprNvMG05oAxP+vd
         MooMoTm8uSo1aYZBUuRHp4d1rVc1lC3PJrFKgnfagzr7VRyiC7XnzDWTRe/ubS/DUlMi
         6/hg==
X-Gm-Message-State: AOJu0YxzX7QZM7LXiKMkWXfJNQIgjCW6jBUzEYOoBwKzG/m/fm1Wt+rp
        1FzM14hRzqRGtGrGoNBXAVtx27ylP/G81X7Hy3S0sFaf3eqjsYbVSgB0LQ==
X-Google-Smtp-Source: AGHT+IFaD1nOyoMFFBFqbWZRmO70UKYkFwMH96yKTzFP2X53cvPejpc/2aKq4xq20p5guGzke3JR3Nd+3r8jgWGlbss=
X-Received: by 2002:a17:907:7893:b0:99b:d580:546c with SMTP id
 ku19-20020a170907789300b0099bd580546cmr1561298ejc.23.1693976568314; Tue, 05
 Sep 2023 22:02:48 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1535.git.1684830767336.gitgitgadget@gmail.com>
 <pull.1535.v2.git.1685264889088.gitgitgadget@gmail.com> <999f12b2-38d6-f446-e763-4985116ad37d@gmail.com>
In-Reply-To: <999f12b2-38d6-f446-e763-4985116ad37d@gmail.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Wed, 6 Sep 2023 07:02:39 +0200
Message-ID: <CAPMMpoj8udDuDferkaRfoKDV6EHMVO6fH3_GE9SUN51VKbwvJA@mail.gmail.com>
Subject: Re: [PATCH v2] cherry-pick: refuse cherry-pick sequence if index is dirty
To:     phillip.wood@dunelm.org.uk
Cc:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 30, 2023 at 4:16=E2=80=AFPM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> Hi Tao
>
> On 28/05/2023 10:08, Tao Klerks via GitGitGadget wrote:
> > From: Tao Klerks <tao@klerks.biz>
> >
> <SNIP>
>
> I found the changes up to this point a bit confusing. Maybe I've missed
> something but I don't think they are really related to fixing the bug
> described in the commit message. As such they're a distraction from the
> "real" fix.
>

Understood, thanks - *if* I kept them, they should be in a separate
"prep refactor" commit.

The reason I did all this was just that I needed to build a new
message that displayed the correct cherry-pick action name - something
that was, in the existing code, done by repeating the entire advice
message. I didn't want to do the same, and if I was going add what I
needed to construct the message more dynamically I figured I should
update the existing repetition-based approach.

>
> > +     requested_action_name =3D cherry_pick_action_name(requested_actio=
n);
>
> We already have the function action_name() so I don't think we need to
> add cherry_pick_action_name().

The reason I had added a new one was that action_name() also supported
"REPLAY_INTERACTIVE_REBASE", which should not be an option in the
codepath that I was refactoring. I wanted to retain the existing
"defensiveness", but that clearly got in the way of both brevity and
clarity.

> Also the name of the new function is
> confusing as it may return "revert".

Yeah, the name was supposed to reflect the context ("cherry-pick logic
which also covers revert, as opposed to rebase which also uses
sequencer but is a substantially separate flow"), rather than the
output value.

>
> > +     if (require_clean_index(r, requested_action_name,
> > +                                 _("Please commit or stash them."), 1,=
 1))
>
> How does this interact with "--no-commit"? I think the check that you
> refer to in the commit message is in do_pick_commit() where we have
>
>         if (opts->no_commit) {
>                 /*
>                  * We do not intend to commit immediately.  We just want =
to
>                  * merge the differences in, so let's compute the tree
>                  * that represents the "current" state for the merge mach=
inery
>                  * to work on.
>                  */
>                 if (write_index_as_tree(&head, r->index, r->index_file, 0=
, NULL))
>                         return error(_("your index file is unmerged."));
>         } else {
>                 unborn =3D repo_get_oid(r, "HEAD", &head);
>                 /* Do we want to generate a root commit? */
>                 if (is_pick_or_similar(command) && opts->have_squash_onto=
 &&
>                     oideq(&head, &opts->squash_onto)) {
>                         if (is_fixup(command))
>                                 return error(_("cannot fixup root commit"=
));
>                         flags |=3D CREATE_ROOT_COMMIT;
>                         unborn =3D 1;
>                 } else if (unborn)
>                         oidcpy(&head, the_hash_algo->empty_tree);
>                 if (index_differs_from(r, unborn ? empty_tree_oid_hex() :=
 "HEAD",
>                                        NULL, 0))
>                         return error_dirty_index(r, opts);
>         }
>
> I think it would be simpler to reuse the existing check by extracting
> the "else" clause above into a separate function in sequencer.c and call
> it here guarded by "if (!opts->no_commit)" as well as in that "else"
> clause in do_pick_commit()

That sounds very plausible.

I will (very belatedly) have a go, and submit another version sometime soon=
.

Thanks so much for taking the time to review, and my apologies for the
months-later context revival!
