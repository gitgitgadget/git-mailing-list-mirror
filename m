Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91B3CD80C1
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 12:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbjJJMsW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Oct 2023 08:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjJJMsV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2023 08:48:21 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6327AB0
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 05:48:19 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9b96c3b4be4so952721666b.1
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 05:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696942098; x=1697546898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sqWGf4bjTz38vwUQYqy0JSheKfE5uUgdaAbZ+nmWx1c=;
        b=PhDcM3fySqeTg9LoKISfUtAhbM2qbCb4axM8PBZ22PPwmcLl9i2UifuYqrUnZFvUY9
         EHOTJCi0y4DUl74fO76CnG0/MvIbzNb668YRCqgYjD4fJIUPWmUNtn+TbK51FL7mLl7J
         1sMTBzHgBW1YkZkklTC3XPQ8V8L3EAwUW2rh8a7CBW+l9ykHK8tAEhWtRxM0ZhUrRwgg
         skl5mkGZH0Xueobp0vu/kZGqBdOsBsrhK68ZBjvULp2h9NvR6OZjVdgObFdNC+hC6LHD
         PBf6g2y1wI4BC/SKqXQh81qUTaA0zpB1u34EzSavXH0PjfFh3R7DKwPh380TomWwdpmn
         H+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696942098; x=1697546898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sqWGf4bjTz38vwUQYqy0JSheKfE5uUgdaAbZ+nmWx1c=;
        b=pTEg8oJxihAgTKRGU9ZRleyqy3EroThOraViQQUJZokTEFw++PQjFa1vKEeORtos1p
         FFHkZ9sUnM1kW1qrqYtAcF2LJHdHcBxMXf72R6X7jibecIV5xgKs4gTfSlswGucoq2A+
         DjInNU7jmXoYxd1qBTyFvam/S0hiSgkLfLeSc+fceuVpgg/yEGXqpr6mE+qpE1//ahkK
         TyEB9z0m9NweDuqnmDYK1V/qvSWPsZSkb/MJ4B8zdkXMz6iM0Mv1qssQ+ZsuAzGEZ4lE
         PmR3W3+FlgDXEE/4aB3UCeyiJWKo3wPqw5ree1/G8PdJE46Swdh3MH5bCmv3UlLYVmkh
         Wy7A==
X-Gm-Message-State: AOJu0YxM/izU9M4wiFLjP+njX7mcb81TQbXjRDGEmVfy+kH4D5WHBfYA
        CbeeatEzz1ti2NmuuFlX5Eg4E/BErvUdkUkwVxw=
X-Google-Smtp-Source: AGHT+IFNDkD0VI9Ddns3wAgqHRavvauTgKo1XQc4oAZeK79gu0JZCNOJfoxTATkXXJB5ruvU3NGNz7rGHMVoSK+3aHM=
X-Received: by 2002:a17:906:9c9:b0:9ae:4f9e:7813 with SMTP id
 r9-20020a17090609c900b009ae4f9e7813mr14184487eje.73.1696942097576; Tue, 10
 Oct 2023 05:48:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230602102533.876905-1-christian.couder@gmail.com>
 <20230907092521.733746-1-christian.couder@gmail.com> <20230907092521.733746-12-christian.couder@gmail.com>
 <owlyo7icl1g3.fsf@fine.c.googlers.com>
In-Reply-To: <owlyo7icl1g3.fsf@fine.c.googlers.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 10 Oct 2023 14:48:00 +0200
Message-ID: <CAP8UFD3f94NnBgkzkezcALJxamsz+-oPfqKe8XGNMuJ+g--z6g@mail.gmail.com>
Subject: Re: [PATCH v4 11/15] replay: use standard revision ranges
To:     Linus Arver <linusa@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Calvin Wan <calvinwan@google.com>, Toon Claes <toon@iotcl.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 9, 2023 at 12:55=E2=80=AFAM Linus Arver <linusa@google.com> wro=
te:
>
> Hi Christian,
>
> I am only reviewing the docs. To assume the mindset of a Git user
> unfamiliar with this command, I purposely did not read the cover letter
> until after this review was done.

Ok, thanks!

> Christian Couder <christian.couder@gmail.com> writes:
>
> > [...]
> >
> > diff --git a/Documentation/git-replay.txt b/Documentation/git-replay.tx=
t
> > new file mode 100644
> > index 0000000000..9a2087b01a
> > --- /dev/null
> > +++ b/Documentation/git-replay.txt
> > @@ -0,0 +1,90 @@
> > +git-replay(1)
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +NAME
> > +----
> > +git-replay - Replay commits on a different base, without touching work=
ing tree
>
> How about using the same language ("new location") as in the DESCRIPTION
> heading?

I actually think that "base" is better than "location", also perhaps
saying things a bit differently than in the description can help
better understand the command.

I am Ok with replacing "different" with "new", mainly because it is
shorter, though.

> Also, the "without touching working tree" part is incomplete
> because as explained later on, the index and refs are also left alone.

I agree that it is incomplete.

> How about just "safely"?

I think that we want to say that the command can work on bare repos,
and I don't think "safely" conveys that meaning well. So now it is:

"git-replay - Replay commits on a new base, works on bare repos too"

> > +SYNOPSIS
> > +--------
> > +[verse]
> > +'git replay' --onto <newbase> <revision-range>...
> > +
> > +DESCRIPTION
> > +-----------
> > +
> > +Takes a range of commits, and replays them onto a new location.
>
> OK.
>
> > Does
> > +not touch the working tree or index, and does not update any
> > +references.
>
> How about this version?
>
>     The new commits are created without modifying the working tree,
>     index, or any references.

I agree it's nicer, but I prefer Dragan Simic's version.

> Also, by "references" we mean the refs in ".git/refs/*". In the
> gitrevisions man page we use the term "refnames" to refer to these bits,
> so maybe "refnames" is better than "references"? The simpler "branches"
> is another option.

"references" seems to be used much more often in the docs than
"refnames" (204 vs 18 occurrences). And deciding between "refnames"
and "references" in the docs is a global issue clearly outside the
scope of this series. So for now I will keep "references".

I don't like "branches" as I think tags and other refs are concerned too.

> > However, the output of this command is meant to be used
> > +as input to `git update-ref --stdin`, which would update the relevant
> > +branches.
>
> Before we get to this sentence, it would be great to explain why this
> command is useful (what problem does it solve)?
>
> Also, it would help to add "(see OUTPUT section below)" as a
> navigational aid in case some readers are wondering what the output
> looks like (and have not yet gotten to that section).
>
> I've noticed that you're using the phrase "starting point" in the
> OPTIONS section. I think this is better than "location" or "base" (FWIW
> we started using "starting point" in 0a02ca2383 (SubmittingPatches:
> simplify guidance for choosing a starting point, 2023-07-14)).
>
> The following is a version of this section that attempts to address my
> comments above (I've included the other bits already reviewed earlier to
> make it easier to read):
>
>     Takes a range of commits, and replays them onto a new starting
>     point. The new commits are created without modifying the working
>     tree, index, or any branches. If there are branches that point to
>     the commits in <revision-range>, list them in the output with both
>     the original commit hash and the corresponding (replayed) commit
>     hash (see OUTPUT section below) .

I like the "(see OUTPUT section below)" part, but I don't like the
fact that passing the output as input to `git update-ref --stdin`
isn't mentioned anymore.

So I have just added "(see the OUTPUT section below)".

>     This command is like linkgit:git-rebase[1], but notably does not
>     require a working tree or index.

I don't quite like this as the command will later also be like
cherry-pick (with the --advance mode).

> This means you can run this command
>     in a bare repo (useful for server-side environments). And because
>     nothing is modified (only new commits are created), it's like a "dry
>     run" rebase.

Bare repos are now mentioned in the title of the page, so I am not
sure it's worth mentioning.

>     By combining this command with `git update-ref --stdin`, the
>     relevant branches can be updated. That is, the branches that were
>     pointing originally to the commits given in the <revision-range>
>     will be updated to point to the replayed commits. This is similar to
>     the way how `git rebase --update-refs` updates multiple branches in
>     the affected range.

I am not sure this is very useful, also I'm afraid that with all the
changes you propose the description section would be a bit too long.

Maybe you should propose some of the changes above in a follow up
patch series after this patch series has been merged.

> > +THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
> > +
> > +OPTIONS
> > +-------
> > +
> > +--onto <newbase>::
>
> How about 'starting-point' instead of 'newbase'?

I think "newbase" is very short and to the point. With --onto we
clearly want something that can do a rebase, so I think using
something with "base" in it is a good choice here.

> > +     Starting point at which to create the new commits.  May be any
> > +     valid commit, and not just an existing branch name.
>
> Add "See linkgit:gitrevisions[7]." at the end?

I don't think it's worth it to mention "linkgit:gitrevisions[7]"
everywhere we can pass a revision. I think it makes the doc heavier
than it should be, especially here where the command is a plumbing one
for now and users should be quite experienced with Git already.

> > +The update-ref command(s) in the output will update the branch(es) in
> > +the revision range to point at the new commits, similar to the way how
> > +`git rebase --update-refs` updates multiple branches in the affected
> > +range.
>
> Ah, good example. I've moved this to my larger example above, so I don't
> think this paragraph is needed here any more (it probably didn't belong
> in OPTIONS anyway).

I think it's important here to help users understand that with this
option they have something very similar to "rebase".

> > +<revision-range>::
> > +     Range of commits to replay; see "Specifying Ranges" in
> > +     linkgit:git-rev-parse.
>
> OK.
>
> > +OUTPUT
> > +------
> > +
> > +When there are no conflicts, the output of this command is usable as
> > +input to `git update-ref --stdin`.
>
> What happens if there are conflicts? Probably good to mention in the
> DISCUSSION section. Some questions you may want to answer for the
> reader:
>
> (1) Is git-replay an all-or-nothing operation? That is, if there are any
> conflicts, is the output always empty (or do we still output those
> branches that *can* be updated without conflicts)?
>
> (2) What is meant by "conflict" for git-replay? Is it the same meaning
> as the case for git-rebase?
>
> For (1), in your cover letter under "# Important limitations" you say
> "No resumability" but I am not sure if this means git-replay will output
> *something* before exiting with an error, or simply nothing at all.

In a follow up series we might add options to generate some output in
case of conflicts. When we do that we will discuss this. So I think
for now it should be Ok to not talk more about the output in case of
conflicts.

> Speaking of the limitations section, perhaps it's worth pointing those
> out under DISCUSSION as well?

I don't think it's worth officially discussing the limitations in the
docs when some of them might be lifted soon after this series
graduates. The command is experimental, so I think users can
understand it if everything is not spelled out. Also if we spell out
things too much, users might rely on what we say when it could
actually change soon.

> > It is basically of the form:
>
> Why "basically"? Are there cases where the output can be different than
> the example given below? If not, then perhaps drop the word "basically"?

Ok, I have dropped "basically".

> > +     update refs/heads/branch1 ${NEW_branch1_HASH} ${OLD_branch1_HASH}
> > +     update refs/heads/branch2 ${NEW_branch2_HASH} ${OLD_branch2_HASH}
> > +     update refs/heads/branch3 ${NEW_branch3_HASH} ${OLD_branch3_HASH}
> > +
> > +where the number of refs updated depends on the arguments passed and
> > +the shape of the history being replayed.
>
> Let's use "number of branches" instead of "number of refs" here to be
> consistent with the language elsewhere.

I prefer "refs" or "references" here.

> > +EXIT STATUS
> > +-----------
> > +
> > +For a successful, non-conflicted replay, the exit status is 0.  When
> > +the replay has conflicts, the exit status is 1.
>
> OK.
>
> > If the replay is not
> > +able to complete (or start) due to some kind of error, the exit status
> > +is something other than 0 or 1.
>
> Not sure how useful "due to some kind of error" is here --- presumably
> the inability to replay is always due to some kind of error.

I think here "due to some kind of error" means something else than a
conflict which could also prevent the reply from fully "working".

> Would it be worth including a brief explanation about why git-replay
> might be unable to complete or start (is this behavior in practice a
> common-enough thing to document here)?

I don't think it's worth it at this step for this new command.

> > +EXAMPLES
> > +--------
> > +
> > +To simply rebase mybranch onto target:
>
> Looking at the CLI arguments, I think this phrase should be:
>
>     Replay the commits in `origin/main..mybranch` onto `target`:

We suppose that users can understand that "rebase mybranch onto
target" means the same thing as what you suggest. Also I think it's
useful to associate "rebase" with "--onto" by deliberately using
"rebase" here.

However to make it a bit clearer, I agree that quoting `mybranch` and
`target` is better, so I have changed it to:

"To simply rebase `mybranch` onto `target`:"

> > +------------
> > +$ git replay --onto target origin/main..mybranch
> > +update refs/heads/mybranch ${NEW_mybranch_HASH} ${OLD_mybranch_HASH}
> > +------------
> > +
> > +When calling `git replay`, one does not need to specify a range of
> > +commits to replay using the syntax `A..B`; any range expression will
> > +do:
> > +
> > +------------
> > +$ git replay --onto origin/main ^base branch1 branch2 branch3
>
> Instead of `base`, how about `olderbranch`?

Sorry but like above, I like "base" here.

> > +update refs/heads/branch1 ${NEW_branch1_HASH} ${OLD_branch1_HASH}
> > +update refs/heads/branch2 ${NEW_branch2_HASH} ${OLD_branch2_HASH}
> > +update refs/heads/branch3 ${NEW_branch3_HASH} ${OLD_branch3_HASH}
> > +------------
> > +
> > +This will simultaneously rebase branch1, branch2, and branch3 -- all
> > +commits they have since base, playing them on top of origin/main.
>
> How about
>
>     This will rebase the commits in `branch1`, `branch2`, and `branch3`
>     (excluding those in `base`), preplaying them on top of `origin/main`.
>
> > +These three branches may have commits on top of base that they have in
> > +common, but that does not need to be the case.
>
> s/base/`base`

I am Ok with quoting `branch1`, `branch2`, `branch3`, `base` and
`origin/main`, but otherwise I prefer to keep the original wording.

> > +GIT
> > +---
> > +Part of the linkgit:git[1] suite
>
> One question I do have is what happens if you run git-replay twice
> (successfully)? Does the second invocation create another set of (new)
> successfully replayed commits?

Yes, I think it does that.

> I ask because I'm interested in informing
> the readers of our docs about any potential pitfalls from abusing this
> command by mistake.

I appreciate your desire to give high quality docs to our users, but I
don't think it's a big pitfall and I think that this command is still
very much "in the works" and is also designed for experienced users
for now, so I am not sure it's the right time to spend too much time
on this.
