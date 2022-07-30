Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7B3C00144
	for <git@archiver.kernel.org>; Sat, 30 Jul 2022 02:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239614AbiG3CQY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 22:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbiG3CQV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 22:16:21 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695EBE0BD
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 19:16:20 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id m16so4860309qka.12
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 19:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8iC0pACGPLDgekQtuOBf9OBRSSWQqb/ufVExB6CLNvg=;
        b=BIZVB05d29m1yOqZPTtEdUteW0BdgW6rJzafI3ikw+6giJM5+EHsdCcVMRb0PyL1Wb
         hzvhGfDoPYD+XXq9L2tZAqWKD/vNIsyfijoe9+2fLnj5T7RqUs3ta08QPxVbhjKwgm0c
         /pSH/ZFrBwqnN5UFtedFvryc0uQivBizRQvYeRCuzZ6MRqcLe5lqYMu+zntMJyyc1T7+
         o/Ki+35W+WFmUHDq+RB1RL/X486b773ZqWJTrWMFt410N2oZSYi/aix5zGAFJEuNID6Z
         F2cfh6bcdUQq3NOjDbt089cMLKZG8d4ufJmOZ0yJKoy5mBvw7s0Ejr01YsUjVrbKnDOI
         h+YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8iC0pACGPLDgekQtuOBf9OBRSSWQqb/ufVExB6CLNvg=;
        b=Cor53jDAAa0osAGCxcrN7VlGyb65FZJxgNXnEfCSBuLBAWWNaBrs81HNGfOnlFVuoy
         Uto2t2KNzHF7Y2FfH0MH0z95sx+n6x08Xvk1TaTMvBR40J2jx8e5feNtP/R2x+adbtVY
         IQND4IYNCJULhmiqDHKxW6+SIWqbzR/UAtTNAgdRo/9TW4demjMNKhhGwje7UUgVXkoF
         Ks/ZcSrSJHG46Fufcq/HuSieJXRC5QZm+2xPvv/caBuioWA+e2mgJ7uzot03e5s/AMeH
         DbFc0pDPFvLkj59tJ0KXh4LTFtFf5DS98bj/RXx8WaaQuGkeE+j93y4t2YXuRJ1d2W/D
         eZCg==
X-Gm-Message-State: AJIora8RMa/26iWeUr6nbc0fwDNOPVtNrdK7EEPZQ7rIbzfuPOSrFGD3
        +fjOBCpdbktgu7T5OIN50osWV+GrOuSaxAmHRaM=
X-Google-Smtp-Source: AGRyM1u/ATry4kpBx5Y0Ni7PHBjrte+6MXIXLecgGFC6UmzGX23b+PBmeKhVIIVBNRoLvsfi1GdHtXTkEga5xSpqUC4=
X-Received: by 2002:a05:620a:4551:b0:6b6:1d51:99a0 with SMTP id
 u17-20020a05620a455100b006b61d5199a0mr4882432qkp.187.1659147379536; Fri, 29
 Jul 2022 19:16:19 -0700 (PDT)
MIME-Version: 1.0
References: <HE1PR0501MB24096E2FBDB66318A2FDADAAF8969@HE1PR0501MB2409.eurprd05.prod.outlook.com>
 <220728.865yjhl8wk.gmgdl@evledraar.gmail.com> <xmqqilnhcgd7.fsf@gitster.g> <701c318c-1a1b-1793-90e8-807cf97dc948@web.de>
In-Reply-To: <701c318c-1a1b-1793-90e8-807cf97dc948@web.de>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 29 Jul 2022 19:16:08 -0700
Message-ID: <CABPp-BE4saKAboS=SPQmQe6n2=Fnhv7pL4_JfF2Zwg5Zhp7Vjw@mail.gmail.com>
Subject: Re: Lost file after git merge
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?B?TGHEj2EgVGVzYcWZw61r?= <lada.tesarik@olc.cz>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 29, 2022 at 1:34 PM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>
> Am 28.07.22 um 19:11 schrieb Junio C Hamano:
> > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
> >
> >> On Thu, Jul 28 2022, La=C4=8Fa Tesa=C5=99=C3=ADk wrote:
> >>
> >>> 1. I added a file called 'new_file' to a master branch.
> >>> 2. Then I created branch feature/2 and deleted the file in master
> >>> 3. Then I deleted the file in branch feature/2 as well.
> >>> 4. I created 'new_file' on branch feature/2 again.
> >
> > It heavily depends on how this creation is done, i.e. what went into
> > the created file.  Imagine that a file existed with content A at
> > commit 0, both commits 1 and 2 removed it on their forked history,
> > and then commit 3 added exactly the same content A to the same path:
> >
> >           1---3
> >          /     \
> >     ----0---2---4---->
> >
> > When you are about to merge 2 and 3 to create 4, what would a
> > three-way merge see?
> >
> >     0 had content A at path P
> >     2 said "no we do not want content A at path P"
> >     3 said "we are happy with content A at path P"
> >
> > So the net result is that 0-->3 "one side did not touch A at P" and
> > 0-->2 "one side removed A at P".
> >
> > Three-way merge between X and Y is all about taking what X did if Y
> > didn't have any opinion on what X touched.  This is exactly that
> > case.  The history 0--->3 didn't have any opinion on what should be
> > in P or whether P should exist, and that is why there is no change
> > between these two endpoints.
>
> The last sentence is not necessarily true.  You could also say that
> 0--->3 cared so much about path P having content A that it brought it
> back from the void.  Determining whether a de-facto revert
> - intended to return to an uncaring state of "take whatever main has" or
> - meant to choose *that* specific content which incidentally is on main
> is not possible from the snapshots at the merge point alone, I think.
>
> Checking if 0...3 touched P and leaving that path unmerged out of
> caution shouldn't be terribly expensive.

I think it might be terribly expensive.

Walking history can easily be the slow part of such an operation, e.g.
can_fast_forward() taking roughly 100 times as long as doing the
merge_incore_recursive() portion that creates the new merged toplevel
tree[1].  (And can_fast_forward() is a form of history walk that
doesn't involve traversing into any trees, so I suspect it's a cheaper
history traversal than what is being suggested).

Focusing on the tree traversal side, this suggested change would
essentially disable the trivial directory resolution optimizations in
merge-ort[2].  (Note that the trivial directory resolution sped up a
rebase that didn't involve very many renames by a factor of 25).  The
whole point of that optimization was to avoid walking into trees that
were only changed on one side, where possible.  Your proposed change
would be saying we always have to walk into trees that either side
modified...and do so for every intermediate commit as well so that we
can fully enumerate all (temporarily) changed files.


[1] https://lore.kernel.org/git/CABPp-BE48=3D97k_3tnNqXPjSEfA163F8hoE+HY0Zv=
z1SWB2B8EA@mail.gmail.com/
[2] https://lore.kernel.org/git/pull.988.v4.git.1626841444.gitgitgadget@gma=
il.com/
