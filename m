Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19019C433EF
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 16:09:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236010AbiBPQJP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 11:09:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235995AbiBPQJP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 11:09:15 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99127BD2CD
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 08:09:02 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id t21so4732968edd.3
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 08:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IMVytOcgJObDg0T/7oOSy8BOuzbxns7hZUb+7WIVQ3E=;
        b=L6bN3XV9qwZjPp6MkLcgGapgV7HI4ga6lspK9fNYd0aRaK/P0gfGaUPofWrSBxEurC
         9whSiNYP8GdvNKyiie+JWBK9Ei06PtYq2k95BvTJ+2/iRVPNJJgXAOnWa354VZQPewkF
         Tsxe5KNpY/pKTDwFaTPkDCmqGMZ8zeipdAo2AVm/AF+k8Q+xgD4fE1P7oEYopMMU6Lsm
         7Q6ASCc27VpD7WHnmoNP6iPkXEbtVZduuGIu2cprSh8P/MYyz44aRCValjnFy8VSoB+u
         zLJ9w/uFgbNbmjBvCkHT0M6ECdhh6jI/B4NQgj0LOb1ytXaAv/qsozGW7OAgOJ7Zofhp
         5PQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IMVytOcgJObDg0T/7oOSy8BOuzbxns7hZUb+7WIVQ3E=;
        b=o0haie1NAUiWkmdL1Tl5eu2hcCJZkByr+M3HMnt8kd8Rv4JoUqajNlrrzL9BkZ8anB
         qyodSlOWBnfmDFusz17k01Fxb1bdHVKmb6sM8eO5axjazM3mHfukhJecn49O1PxxqqR2
         L7XbBp2VKB2M9QjP7gj9O4iGin462DJsWfh0cKhtOvUIJaa1KYGye1lFlvpZnLDyMNk8
         f6IAzOFeQtvHFHZTFDbKfRuw/zOw/++5jbbUasAnDWl47hfDB1grNrDtt92laU0+a2eB
         VGPmkRry84UzmQ7Lo2a3qDLuXRQxfwly29+BhP7IFVgaLJrO0i/1MBFGd1htVVAtMPKp
         MZwg==
X-Gm-Message-State: AOAM5310X/h8Oz8Kn58BlWk1VVIc3KPHjzARzMbdNiMhCACd7ofc9e62
        WS8jGEFjuTlzf5BxzEFWkpSdmbPg3b8FgiBhqUMj3azu6zE=
X-Google-Smtp-Source: ABdhPJwSC9XY3b+z5wyoRp0TI0DOy76DRxrfl+ISkBPUA3xbjI7QdudvtoagJXPjHCoPJGArYs3tFLLBBeDBQwJMUuM=
X-Received: by 2002:aa7:c04e:0:b0:400:4daf:bab1 with SMTP id
 k14-20020aa7c04e000000b004004dafbab1mr3739163edo.101.1645027741010; Wed, 16
 Feb 2022 08:09:01 -0800 (PST)
MIME-Version: 1.0
References: <pull.1114.git.1642092230.gitgitgadget@gmail.com>
 <pull.1114.v2.git.1642175983.gitgitgadget@gmail.com> <11d46a399d26c913787b704d2b7169cafc28d639.1642175983.git.gitgitgadget@gmail.com>
 <220216.86o837uqak.gmgdl@evledraar.gmail.com>
In-Reply-To: <220216.86o837uqak.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 16 Feb 2022 08:08:49 -0800
Message-ID: <CABPp-BHsZ=TPfJ-wohpmYVMAD_3umAffNqV+EXn0xr0cDBRzpw@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] repo_read_index: clear SKIP_WORKTREE bit from
 files present in worktree
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Victoria Dye <vdye@github.com>,
        Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 16, 2022 at 1:14 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Fri, Jan 14 2022, Elijah Newren via GitGitGadget wrote:
>
> > From: Elijah Newren <newren@gmail.com>
> > [...]
> >       # Set up a strange condition of having a file edit
> > -     # outside of the sparse-checkout cone. This is just
> > -     # to verify that sparse-checkout and sparse-index
> > -     # behave the same in this case.
> > +     # outside of the sparse-checkout cone. We want to verify
> > +     # that all modes handle this the same, and detect the
> > +     # modification.
> >       write_script edit-content <<-\EOF &&
> > -     mkdir folder1 &&
> > +     mkdir -p folder1 &&
> >       echo content >>folder1/a
> >       EOF
> > -     run_on_sparse ../edit-content &&
> > +     run_on_all ../edit-content &&
>
> The end-state of this series will pass its tests with this on top, only
> the last "mkdir -p" you added for the ls-files test seems to do
> anything:
>
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-ch=
eckout-compatibility.sh
> index 2a04b532f91..160c119e17d 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -639,7 +639,7 @@ test_expect_success 'update-index modify outside spar=
se definition' '
>         # condition in which a `skip-worktree` enabled, outside-of-cone f=
ile
>         # exists on disk. It is used here to ensure `update-index` is sta=
ble
>         # and behaves predictably if such a condition occurs.
> -       run_on_sparse mkdir -p folder1 &&
> +       run_on_sparse mkdir folder1 &&
>         run_on_sparse cp ../initial-repo/folder1/a folder1/a &&
>         run_on_all ../edit-contents folder1/a &&
>
> @@ -665,7 +665,7 @@ test_expect_success 'update-index --add outside spars=
e definition' '
>         EOF
>
>         # Create folder1, add new file
> -       run_on_sparse mkdir -p folder1 &&
> +       run_on_sparse mkdir folder1 &&
>         run_on_all ../edit-contents folder1/b &&
>
>         # The *untracked* out-of-cone file is added to the index because =
it does
> @@ -949,7 +949,7 @@ test_expect_success 'checkout-index outside sparse de=
finition' '
>
>         run_on_sparse rm -rf folder1 &&
>         echo test >new-a &&
> -       run_on_sparse mkdir -p folder1 &&
> +       run_on_sparse mkdir folder1 &&
>         run_on_all cp ../new-a folder1/a &&
>
>         test_all_match test_must_fail git checkout-index --ignore-skip-wo=
rktree-bits -- folder1/a &&
> @@ -996,7 +996,7 @@ test_expect_success 'clean' '
>         test_all_match git commit -m "ignore bogus files" &&
>
>         run_on_sparse mkdir folder1 &&
> -       run_on_all mkdir -p deep/untracked-deep &&
> +       run_on_all mkdir deep/untracked-deep &&
>         run_on_all touch folder1/bogus &&
>         run_on_all touch folder1/untracked &&
>         run_on_all touch deep/untracked-deep/bogus &&
>
> A bit nit-y I guess, but I do think tests are much easier to follow when
> it's clear when we're doing initial setup v.s. using already set-up
> data. In this case
>
> More importantnly I think between this and 19a0acc83e4 (t1092: test
> interesting sparse-checkout scenarios, 2021-01-23) that introduced this
> pattern there's a large foot-gun being left in place here by using these
> "run_on_all" and "run_on_sparse" helpers to run POSIX tooling, as
> opposed to git itself.
>
> Utilities like "mv", "rm", "mkdir" etc. are differently chatty between
> platform, and this helper captures their stdout/stderr for a later
> test_cmp.
>
> Now, I think actually there isn't a bug *now* because we clobber the
> output, and seem to only call test_all_match() and other test_cmp
> helpers right after we've run "git", not these POSIX utilities.
>
> But since all we want in those cases is just a "run these commands in
> these N dirs" it would be good to split up the helper.

Maybe, but that sounds like a comment on the series from 13 months ago
rather than this series.  It's somewhat orthogonal to what I'm doing
here...  ;-)
