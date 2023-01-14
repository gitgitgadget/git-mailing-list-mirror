Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C90CC3DA78
	for <git@archiver.kernel.org>; Sat, 14 Jan 2023 22:47:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjANWro (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Jan 2023 17:47:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbjANWrn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jan 2023 17:47:43 -0500
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8BD9EF4
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 14:47:40 -0800 (PST)
Date:   Sat, 14 Jan 2023 22:47:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail3; t=1673736457; x=1673995657;
        bh=6zJadpb808QIr7Cr4nq9xm50TLQqgELyW2DAsPCdd00=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=mQpkTcD6evap6U4wiOesMi6GElIgGp1vCIYfZLHnq81XOLw3/URr/TwUysvSYDpkn
         7RqimDU/iZJvlT6j6B2K7XIDky3IaIoUGLPDIERSIH+UMKOwDGwGA6DBf4zfyuLSdh
         B74mAMBKAvYPotW6VAbxaHEvdDid0iMY1dUvm5Uy+Xt/jum8pk9CXNJ/QeXLzRNIDQ
         VKDQvSfbwfDiXJ+J+igtFAje57Lh4UHGL7HIlp/uzoZbBNZtGMPW1D/QxRlTnYCyKE
         gGlHfX3IB19a6EbUR/ux48y55EfDoFYZtYTSebnMaV7HkSvOVbKWm0WS/sEPp+Xz4d
         dyCjz2iYO8dvg==
To:     phillip.wood@dunelm.org.uk
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: Re: [PATCH v8 3/4] worktree add: add --orphan flag
Message-ID: <20230114224715.ewec6sz5h3q3iijs@phi>
In-Reply-To: <e5aadd5d-9b85-4dc9-e9f7-117892b4b283@dunelm.org.uk>
References: <20221104010242.11555-1-jacobabel@nullpo.dev> <20221104213401.17393-1-jacobabel@nullpo.dev> <20221110233137.10414-1-jacobabel@nullpo.dev> <20221212014003.20290-1-jacobabel@nullpo.dev> <20221220023637.29042-1-jacobabel@nullpo.dev> <20221228061539.13740-1-jacobabel@nullpo.dev> <20230107045757.30037-1-jacobabel@nullpo.dev> <20230109173227.29264-1-jacobabel@nullpo.dev> <20230109173227.29264-4-jacobabel@nullpo.dev> <e5aadd5d-9b85-4dc9-e9f7-117892b4b283@dunelm.org.uk>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/01/13 10:20AM, Phillip Wood wrote:
> Hi Jacob
>
> On 09/01/2023 17:33, Jacob Abel wrote:
> > [...]
>
> It's perhaps a bit late to bring this up but I've only just realized
> that it is unfortunate that --orphan takes a branch name rather than
> working in conjunction with -b/-B. It means that in the common case
> where the branch name is the same as the worktree the user has to repeat
> it on the command line as shown above. It also means there is no way to
> force an orphan branch (that's admittedly quite niche). If instead
> --orphan did not take an argument we could have
>
> =09git worktree add --orphan main
> =09git worktree add --orphan -b topic main
> =09git worktree add --orphan -B topic main
>
> Best Wishes
>
> Phillip
>
> > [...]

I think this is a good idea and something similar was brought up previously
however I originally wanted to handle this and a common --orphan DWYM in a =
later
patch.

> =09git worktree add --orphan main

I am OK implementing this option and have been workshopping it prior to
responding. I think I have it worked out now as an additional patch which c=
an be
be applied on top of the v8 patchset.

I'll reply to this message with the one-off patch to get feedback. Since th=
is is
essentially a discrete change on top of v8, I can either keep it as a separ=
ate
patch or reroll depending on how much needs to be changed (and what would b=
e
easier for everyone).

> =09git worktree add --orphan -b topic main
> =09git worktree add --orphan -B topic main

I am hesitant to add these as they break away from the syntax used in
`git switch` and `git checkout`.

Also apologies for the tangent but while researching this path, I noticed t=
hat
--orphan behaves unexpectedly on both `git switch` and `git checkout` when =
mixed
with `-c` and `-b` respectively.

    % git switch --orphan -c foobar
    fatal: invalid reference: foobar

    % git switch -c --orphan foobar
    fatal: invalid reference: foobar

    % git checkout -b --orphan foobar
    fatal: 'foobar' is not a commit and a branch '--orphan' cannot be creat=
ed from it

    % git checkout --orphan -b foobar
    fatal: 'foobar' is not a commit and a branch '-b' cannot be created fro=
m it

I tried this on my system install as well as from a fresh fetch of next FWI=
W.

[Info: fresh build from next]
git version 2.39.0.287.g8cbeef4abd
cpu: x86_64
built from commit: 8cbeef4abda4907dd68ea144d9dcb85f0b49c3e6
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh

[Info: system install]
git version 2.38.2
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh

If this bug is something that needs to be addressed, I can dig a bit deeper=
 and
put together a patch for it in the next few days.

VR,
Abel

