Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53CC6C433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 03:27:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbiGUD1V (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jul 2022 23:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiGUD1U (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jul 2022 23:27:20 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62AE361D97
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 20:27:18 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id v28so425375qkg.13
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 20:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YHE9tOIvQGOyBZ/PEpkFiFrKsng8yMVa2iWRFL9Whc8=;
        b=BdEyf8WXv8HNIm03V2dG9QDx5jdWLTLzmkhy9Uw18RqKFoAq+wpxe3IqqgrV6n/f02
         db5MAKvA/GstiesE1JB0uqZLNyQI3a7+X5/iQgp61yxxrY/NUps4Q37Q1b6K0C4HNNcl
         cG2tnXfwUR/h3uf1xsXhXOxyvNUWSjCLZrKaRqP+SRMG/mGuQSZyEjyekq4UnIdg9BCl
         J69i03oZSMnMLOd5JRSKwlL0dSvms6LGODzaTPk416pSsjivC4BrGgXEihFlhGDLxXLg
         o4IP23C2+FSKp+djdn6uxfykL+62TOMnB+22Dx20W7oLEVwAHNy76CBkICO8XzYiJlIR
         V6NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YHE9tOIvQGOyBZ/PEpkFiFrKsng8yMVa2iWRFL9Whc8=;
        b=hfTOnXtK7eE7aPrv20n8A1ncfmL6qngCKPG35B15coRl6ruUW6CjrKBG4TpGuP+jiP
         318ujI9MdTB/q34HanGFr/oX5l8rm7lrDPbR/VtvSmW4WIS1PoWsm4+6AnHikCQKOFf1
         YrwQe6i5rpO0rWhaT7qrvKmW9NPBEIG599XrZfeW+2XkEGm2qxVZKhb9ar98kaXrusNi
         kGDfvpRDXazVGSHCn2BKKPJes3euVV99NA0hhPmMRhXx34W809UdvO4jUURMltV5nPsg
         GHO9qMQdzfGYnON94U2cq3sb82uGZ/Omx9H6h6VlTWTYRwyFsuaDkQ7RH3gPFgcPdr8v
         FWUw==
X-Gm-Message-State: AJIora8hHJY7NfeuN20IzbD8qL1hs0OaAK/I3iXv3rlaJwhr6MSkIQP5
        WC4f6rp3eExZXysu2hQ4X9+Ao1plZcCt2rZSjxhqLSALFmk=
X-Google-Smtp-Source: AGRyM1vVRBuvgqa2onibrQef/cCyQ4FiPm7z9IqtzZYZIZiJGYw9Gm8r1KofDVO7UE+npXgw3TLx89ouEO2q/O/H2S4=
X-Received: by 2002:a05:620a:741:b0:6b5:ee4f:35e8 with SMTP id
 i1-20020a05620a074100b006b5ee4f35e8mr11427837qki.131.1658374037449; Wed, 20
 Jul 2022 20:27:17 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1231.git.1652977582.gitgitgadget@gmail.com>
 <pull.1231.v2.git.1655621424.gitgitgadget@gmail.com> <0783b48c121fe74051c13e7d9118d1a5b7cb9aa9.1655621424.git.gitgitgadget@gmail.com>
 <xmqqzgh466ia.fsf@gitster.g>
In-Reply-To: <xmqqzgh466ia.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 20 Jul 2022 20:27:06 -0700
Message-ID: <CABPp-BEywagXQtVQVxZgTCaH+TxrA9VBrMr2Lyv_3uADoqYY+Q@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] merge: do not exit restore_state() prematurely
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 19, 2022 at 4:13 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > Fix the main problem by making sure that restore_state() only skips the
> > stash application if the stash is null rather than skipping the whole
> > function.
>
> OK.
>
>
> > However, there is a secondary problem -- since merge.c forks
> > subprocesses to do the cleanup, the in-memory index is left out-of-sync.
> > While there was a refresh_cache(REFRESH_QUIET) call that attempted to
> > correct that, that function would not handle cases where the previous
> > merge strategy added conflicted entries.  We need to drop the index and
> > re-read it to handle such cases.
>
> Absolutely right.
>
> > diff --git a/builtin/merge.c b/builtin/merge.c
> > index aaee8f6a553..a21dece1b55 100644
> > --- a/builtin/merge.c
> > +++ b/builtin/merge.c
> > @@ -385,11 +385,11 @@ static void restore_state(const struct object_id *head,
> >  {
> >       const char *args[] = { "stash", "apply", "--index", NULL, NULL };
> >
> > -     if (is_null_oid(stash))
> > -             return;
> > -
> >       reset_hard(head, 1);
> >
> > +     if (is_null_oid(stash))
> > +             goto refresh_cache;
> > +
> >       args[3] = oid_to_hex(stash);
> >
> >       /*
> > @@ -398,7 +398,9 @@ static void restore_state(const struct object_id *head,
> >        */
> >       run_command_v_opt(args, RUN_GIT_CMD);
> >
> > -     refresh_cache(REFRESH_QUIET);
> > +refresh_cache:
> > +     if (discard_cache() < 0 || read_cache() < 0)
> > +             die(_("could not read index"));
>
> Don't we need refresh_cache() after re-reading the on-disk index, or
> do we have nothing to do further after restore_state() returns and
> the stat-info being stale does not matter?  Given that [3/6] exists,
> I suspect that we do want to make sure the in-core index is refreshed
> before we go ahead and run the next merge, no?

I don't think so; the situation for [3/6] is different.  The basic
timeline is as follows:
    1. <User does lots of stuff over weeks and months>
    2. User decides to merge one or more branches
    3. merge does save_state() [i.e. "git stash create"]
    4. The first strategy fails
    5. We restore the state before trying the next strategy

The current code is dealing with step 5.  Patch [3/6] was to prevent
failures in step 3 from users creating stat-dirty files in step 1.
Once step 3 runs, the only way to become stat-dirty again is if the
user simultaneously messes with their checkout while the "git merge"
command is running.  Attempting to preventatively handle users
modifying the working tree simultaneously with concurrent git commands
like `git merge` seems like a losing proposition to me; it'd be a huge
can of worms and have a million holes.  I don't think that's worth it.

> >  }
> >
> >  /* This is called when no merge was necessary. */
>
> > diff --git a/t/t7607-merge-state.sh b/t/t7607-merge-state.sh
> > new file mode 100755
>
> As long we are adding a brand-new script for new tests, probably we
> should add tests for other steps (like [4/6]) here, perhaps?

Yes.

>
> > index 00000000000..655478cd0b3
> > --- /dev/null
> > +++ b/t/t7607-merge-state.sh
> > @@ -0,0 +1,25 @@
> > +#!/bin/sh
> > +
> > +test_description="Test that merge state is as expected after failed merge"
> > +
> > +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
> > +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> > +. ./test-lib.sh
> > +
> > +test_expect_success 'set up custom strategy' '
> > +     test_commit --no-tag "Initial" base base &&
> > +git show-ref &&
>
> Is this part of the test, or a leftover debugging aid?

Looks like part of a leftover debugging aid; sorry about that.  Will clean up.

> > +
> > +     for b in branch1 branch2 branch3
> > +     do
> > +             git checkout -b $b main &&
> > +             test_commit --no-tag "Change on $b" base $b
> > +     done &&
> > +
> > +     git checkout branch1 &&
> > +     test_must_fail git merge branch2 branch3 &&
> > +     git diff --exit-code --name-status &&
> > +     test_path_is_missing .git/MERGE_HEAD
> > +'
>
> Hmph, I am not sure if the new behaviour is not too pessimistic.
> When octopus fails after successfully merging branch2 and then
> failing the merge of branch3 (i.e. the last one) due to conflict,

That's not what's happening here.  It is not failing due to conflict,
octopus is reporting that it cannot even leave things in a conflicted
state for the user, and is actually incapable of handling this
particular type of merge.  Part of the output seen when attempting
this merge includes:
    fatal: merge program failed
    Should not be doing an octopus.

See previous discussion at
https://lore.kernel.org/git/xmqq35hdd205.fsf@gitster.g/.  To make this
clearer, perhaps I should use "test_expect_code 2" instead of
test_must_fail, and also grep the output/error for the above messages.

> I think octpus users are used to be able to resolve it manually
> and make a commit.  Are we making it impossible by doing the
> reset-restore dance here?

No, we are not changing what octopus can handle here.  The code above
is not triggered when octopus returns that it ran into conflicts for
the user to resolve.  It is only triggered when octopus says it cannot
handle the merge in question.  See your commit 98efc8f3d8 ("octopus:
allow manual resolve on the last round.", 2006-01-13), and note that
the the "exit 2" code path is the one that we are hitting.  I'll add
some comments to the testcase and rewrite the commit message to try to
make this clearer.
