Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DFA7C4332F
	for <git@archiver.kernel.org>; Wed, 21 Dec 2022 00:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234216AbiLUAnH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Dec 2022 19:43:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiLUAnG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2022 19:43:06 -0500
Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E4C1FCEE
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 16:43:04 -0800 (PST)
Date:   Wed, 21 Dec 2022 00:42:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail3; t=1671583382; x=1671842582;
        bh=uOJ3nM9CgJFknDF8ybuBzSoDG4XAUQw2cmyAEgYtktU=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=o/3+Jim6371WBiblLe0nu0wr8JAX9nRpdW49Hcv+T5agBSA7H++mknKqQ+4pS+i7I
         hX1c6UVCk1+BEjXXNIsUxblqh7S+T6++8OCJmNMlcYiAxtjKsGbugXuwkzeUJfRUgc
         tLflzTyp5uFyqbpgancLbVnNWOL380eKGoQH95mW4ZsgbK2PX2YCyBXnoU5nNXe07g
         +lniMur7kb7dVP2bkbdV3qelp4DZhJ/tVyCI0O+vo20dX/gop84cAOXdnHc308PYmG
         C8GfiFrHuinS1f0yHUAFic6MVQV+AveH/jV3u3fcH0s5YApNGJcltFatso2Kfn5BD7
         Up6hw+sKA9w9w==
To:     Junio C Hamano <gitster@pobox.com>
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: Re: [PATCH v5 4/4] worktree add: Add hint to use --orphan when bad ref
Message-ID: <20221221004246.an5633ccwljhwzzs@phi>
In-Reply-To: <xmqqfsdawqbw.fsf@gitster.g>
References: <20221104010242.11555-1-jacobabel@nullpo.dev> <20221104213401.17393-1-jacobabel@nullpo.dev> <20221110233137.10414-1-jacobabel@nullpo.dev> <20221212014003.20290-1-jacobabel@nullpo.dev> <20221220023637.29042-1-jacobabel@nullpo.dev> <20221220023637.29042-5-jacobabel@nullpo.dev> <xmqqfsdawqbw.fsf@gitster.g>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/12/20 03:18PM, Junio C Hamano wrote:
> Jacob Abel <jacobabel@nullpo.dev> writes:
>
> > Subject: Re: [PATCH v5 4/4] worktree add: Add hint to use --orphan when=
 bad ref
>
> Incomplete sentence that invites "when bad ref, what?"

Noted. Changed commit title to the following:

    worktree add: add hint to direct users towards --orphan

>
> > +=09=09=09"=09git worktree add --orphan %s %s\n"), new_branch, path
>
> OK.  "git worktree add -b <name-of-branch> <path>" is how you create
> a worktree and have it on a named branch.  And instead of saying -b,
> you would say --orphan.  This sounds like a fairly easy-to-understand
> parallel to how "git checkout [-b/-B/--orphan] name-of-branch" takes
> its parameters.

Yes. Originally it was a direct reproduction of `git checkout --orphan` wit=
h the
syntax being `git worktree add --orphan new_branch path/ old_branch` and th=
e
operation checking out `old_branch` then discarding the commit history to m=
ake
the orphan branch `new_branch`. However after some discussion[1], the optio=
n was
changed to match `git switch --orphan` with the syntax and behavior we have=
 now.

>
> > +test_wt_add_empty_repo_orphan_hint() {
> > +=09local context=3D"$1"
> > +=09shift
> > +=09local opts=3D"$@"
> > +=09test_expect_success "'worktree add' show orphan hint in empty repo =
w/ $context" '
> > +=09=09test_when_finished "rm -rf empty_repo" &&
> > +=09=09GIT_DIR=3D"empty_repo" git init --bare &&
> > +=09=09test_must_fail git -C empty_repo worktree add $opts foobar/ 2> a=
ctual &&
>
> The comments on "$@" (vs "$*") in an earlier step equally applies here.

Noted. Changed.

1. https://lore.kernel.org/git/CAPig+cSVzewXpk+eDSC-W-+Q8X_7ikZXXeSQbmpHBcd=
LCU5svw@mail.gmail.com/

