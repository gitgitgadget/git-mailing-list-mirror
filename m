Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E09C38147
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 22:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjARWk4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 17:40:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjARWkz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 17:40:55 -0500
Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4EB54B0C
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 14:40:49 -0800 (PST)
Date:   Wed, 18 Jan 2023 22:40:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail3; t=1674081647; x=1674340847;
        bh=scsmrdkf+ehOHN5zE8a8jr3fmKxMTZziMJZGBEMv5Mw=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=Gm/daLRaNspJ0MHw0+9g6UKSNSvvMuqSDFU/wLLKMl6TVvVlficEGoKKFxwuzaDUo
         4908bHiG3J8OIs1nEyWeYb4o7qIVfLOzEa2oJCXp3j+8sA3w/35Z9bKwyuxYj8gE3c
         5ztuyBX7PjwdgSPwXx7sFIv1iTGb5MkhXKneKznV7ovopAK9d1GAN44qwhy1kH12eI
         K9lVEvyYU2RpQe9PpMnrU0alM71jOi4ljvXm2LBeeQGydRGKzlE6wDbdsDw/Y/m2co
         k9Ih8LnrKuI8tLc2Hgpza5SgyQpy3/iIpG+f0j/ydpVfoD/dD6BgHxm3RY47Sq4zJB
         yqwaL3NhZZx/Q==
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
Message-ID: <20230118224020.vrytmeyt3vbanoh2@phi>
In-Reply-To: <70a01a52-f16c-e85f-297e-c42a23f95a9a@dunelm.org.uk>
References: <20221104010242.11555-1-jacobabel@nullpo.dev> <20221220023637.29042-1-jacobabel@nullpo.dev> <20221228061539.13740-1-jacobabel@nullpo.dev> <20230107045757.30037-1-jacobabel@nullpo.dev> <20230109173227.29264-1-jacobabel@nullpo.dev> <20230109173227.29264-4-jacobabel@nullpo.dev> <e5aadd5d-9b85-4dc9-e9f7-117892b4b283@dunelm.org.uk> <20230114224715.ewec6sz5h3q3iijs@phi> <70a01a52-f16c-e85f-297e-c42a23f95a9a@dunelm.org.uk>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/01/16 10:47AM, Phillip Wood wrote:
> Hi Jacob
>
> On 14/01/2023 22:47, Jacob Abel wrote:
> > On 23/01/13 10:20AM, Phillip Wood wrote:
> >> Hi Jacob
> >>
> > [...]
> >
> > I'll reply to this message with the one-off patch to get feedback. Sinc=
e this is
> > essentially a discrete change on top of v8, I can either keep it as a s=
eparate
> > patch or reroll depending on how much needs to be changed (and what wou=
ld be
> > easier for everyone).
> >
> >> =09git worktree add --orphan -b topic main
> >> =09git worktree add --orphan -B topic main
> >
> > I am hesitant to add these as they break away from the syntax used in
> > `git switch` and `git checkout`.
>
> When I wrote my original email I wrongly though that --orphan did not
> take an argument for "git checkout". While I think it is a mistake for
> checkout and switch to have --orphan take an argument they do at least
> always need a branch name with that option. "git worktree" add already
> has the branch name in the form of the worktree directory in the common
> case.

Understood.

I'm not entirely opposed to making this change to OPT_BOOL but I have to wo=
nder
how often `--orphan` will actually be used by a given user and whether the
slightly shorter invocation will be used regularly.

With the base `git worktree add $path`, the shorthand/DWYM makes sense as i=
t's
used regularly but I don't see users working with `--orphan` outside of try=
ing
to create the first branch in a repository.

And I'd like that operation of creating the first branch in a repo to event=
ually
"just work" with the base command, i.e. `git worktree add main/`. The reaso=
n I
hadn't yet added that is because I've yet to figure out how to get it to wo=
rk
without accidentally introducing potentially confusing situations and I did=
n't
want to hold up introducing the core functionality itself.

Once that main use-case "just works", I don't see users utilising `--orphan=
`
except in very rare circumstances. Doubly so since the average user likely
shouldn't be using `--orphan` in most cases.

Hence the question of whether this change would be worth it vs the existing
`--orphan $branchname $path` which is (for better or worse) consistent with=
 `-b`
and `-B`.

>
> > Also apologies for the tangent but while researching this path, I notic=
ed that
> > --orphan behaves unexpectedly on both `git switch` and `git checkout` w=
hen mixed
> > with `-c` and `-b` respectively.
> >
> >      % git switch --orphan -c foobar
> >      fatal: invalid reference: foobar
> >
> >      % git switch -c --orphan foobar
> >      fatal: invalid reference: foobar
> >      % git checkout -b --orphan foobar
> >      fatal: 'foobar' is not a commit and a branch '--orphan' cannot be =
created from it
> >
> >      % git checkout --orphan -b foobar
> >      fatal: 'foobar' is not a commit and a branch '-b' cannot be create=
d from it
>
> The messages for checkout look better than the switch ones to me as they
> show the branch name which makes it clearer that we're treating what
> looks like an option as an argument. What in particular is unexpected
> here - --orphan and -b take an argument so they'll hoover up the next
> thing on the commandline whatever it is.
>
> Best Wishes
>
> Phillip
>
> > [...]

Agreed. I wasn't sure if this would be something worth addressing in a patc=
h but
at the very least I can work on putting together a small patch for `git swi=
tch`
since it doesn't seem to be hoovering the flags like `git checkout` does.

