Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 240EBC004D4
	for <git@archiver.kernel.org>; Thu, 19 Jan 2023 22:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjASWjR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Jan 2023 17:39:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbjASWij (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2023 17:38:39 -0500
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006FA182
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 14:20:32 -0800 (PST)
Date:   Thu, 19 Jan 2023 22:20:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail3; t=1674166829; x=1674426029;
        bh=P1xlvXmeBQCwOKVyyoRVxBROSyG9pvyJwPs+M6VlPao=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=Ytw3AG1YvBw6Kp8MRfxLazM4sPsrFV3ufylUQb3Fr53UaMRVR2iiPzK1mBGgpfZEm
         UFcBlQp/Xay1VpkQ22FAtvqweNXjhzsDSXkecgyF9rq8mMEbEJZrlWX74YOqI9OKVb
         VZslhwL2xdoHZlw2pRIi+zSLdvUsrLLHr5x+BvH2g3reJYcQRpp+8D751jPdCRmlLZ
         jGvfxFlddweM4JEVt1VcmVvlsO1agjtwLpyRvAwsF3FwVgl5q9ZrOMGoPGr5T26n71
         v8dXcYdiwv5P9UhhPBszt2C3N3C9qsbdy0MEVaieqAiEfC/zYXrDtFp3+C9tN6/QcY
         H9DV1/BMs24Vw==
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
Message-ID: <20230119222003.qcdrhcsvjlyab6af@phi>
In-Reply-To: <df2c0ae0-0654-a3e1-cc02-be2d970ea287@dunelm.org.uk>
References: <20221104010242.11555-1-jacobabel@nullpo.dev> <20230107045757.30037-1-jacobabel@nullpo.dev> <20230109173227.29264-1-jacobabel@nullpo.dev> <20230109173227.29264-4-jacobabel@nullpo.dev> <e5aadd5d-9b85-4dc9-e9f7-117892b4b283@dunelm.org.uk> <20230114224715.ewec6sz5h3q3iijs@phi> <70a01a52-f16c-e85f-297e-c42a23f95a9a@dunelm.org.uk> <20230118224020.vrytmeyt3vbanoh2@phi> <df2c0ae0-0654-a3e1-cc02-be2d970ea287@dunelm.org.uk>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/01/19 04:18PM, Phillip Wood wrote:
> On 18/01/2023 22:40, Jacob Abel wrote:
> > [...]
> > Understood.
> >
> > I'm not entirely opposed to making this change to OPT_BOOL but I have t=
o wonder
> > how often `--orphan` will actually be used by a given user and whether =
the
> > slightly shorter invocation will be used regularly.
> >
> > With the base `git worktree add $path`, the shorthand/DWYM makes sense =
as it's
> > used regularly but I don't see users working with `--orphan` outside of=
 trying
> > to create the first branch in a repository.
>
> Your example use in the commit message shows the user using the same
> name for the branch and worktree. If that really is the likely use than
> I think we should make --orphan OPT_BOOL. If it is not the likely use
> perhaps you could update the commit message to show how you think it
> will be used.

The example in the commit message is mostly a trivial example to show the
change. I think whether someone uses the same name for the branch and workt=
ree
depends on how they use the feature. At least personally, generally I name =
my
worktree based on either the relevant project/"hat" or using an "a/, b/, c/=
" or
"alpha/, beta/, gamma/" style.

So in my personal use, it'd look something like:

    git worktree add --orphan main alpha/

---

Or to occassionally break out a scratchpad that I may want to keep around f=
or a
while but not actually integrate into the feature branch in it's current fo=
rm.
This isn't really for code but rather so I can scratch out and document my =
logic
prior to doing a formal write up at the end of a given feature. Of course s=
ince
it doesn't make it into the main tree, when everything is written up, I can=
 just
toss the branch and let gc take care of it.

This ends up looking like so:

    git worktree add --orphan scratch-1234-foobar-feature scratchpad/

And since `worktree add` only needs to be done once, I only do this the fir=
st
time I set up my dev environment on a machine. After that I can just use
`git switch --orphan` to create new scratchpad branches and `git switch` to
swap between existing scratchpads.

---

The first example I see as being the main use case (which could hopefully b=
e
DWYMed eventually) and the latter example is a quirk of my admittedly niche
personal usecase for worktrees.

> > And I'd like that operation of creating the first branch in a repo to e=
ventually
> > "just work" with the base command, i.e. `git worktree add main/`. The r=
eason I
> > hadn't yet added that is because I've yet to figure out how to get it t=
o work
> > without accidentally introducing potentially confusing situations and I=
 didn't
> > want to hold up introducing the core functionality itself.
> >
> > Once that main use-case "just works", I don't see users utilising `--or=
phan`
> > except in very rare circumstances. Doubly so since the average user lik=
ely
> > shouldn't be using `--orphan` in most cases.
>
> This brings us back to the question that we discussed earlier of whether
> we need --orphan at all. If we can get the main use-case working without
> it we'd perhaps be better doing that rather than adding an option no one
> ends up using.

At least personally, I'd rather expose the option for users who may potenti=
ally
want it. I think it'd be useful regardless but in the same way `--orphan` i=
s
currently useful in `git switch`, which is for very specific niche cases an=
d
really only for power users rather than as a common tool everyday users are
expected to know.

And for the main use case, my concerns were:

1. If we DWYM and create a branch when there are no existing branches, what
about the case where a user sets up the repo but forgot to fetch. i.e. if a=
 user
does:

    # Or instead of init --template, use some language's project init tool =
to
    # setup git hooks.
    % git init --bare --template <tmpldir> .git
    % git remote add origin <remote>
    % git worktree add main/

Should we just warn the user that they haven't fetched their remote yet whi=
le we
prepare the worktree?

2. Suppose we also check whether the remote has been fetched and the remote=
 has
a branch matching the current branch name.

Should we fail (as it currently does on main) with an advise to try the com=
mand
`git worktree add main main` instead? Or should that command also "just wor=
k"

3. If we want to do the above, should it do this for all commands trying to
create a worktree until at least one real branch (with commits) exists in t=
he
repo or should we only do this when the branch name matches the one defined=
 in
`init.defaultBranch`?

> Best Wishes
>
> Phillip
>
> > [...]

