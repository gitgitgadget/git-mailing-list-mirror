Return-Path: <SRS0=tbmj=EA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F54C388F7
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 10:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B58622269
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 10:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAZyqVti"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1414986AbgJYKYO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Oct 2020 06:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1414941AbgJYKYN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Oct 2020 06:24:13 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24506C0613CE
        for <git@vger.kernel.org>; Sun, 25 Oct 2020 03:24:01 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id j8so5540148ilk.0
        for <git@vger.kernel.org>; Sun, 25 Oct 2020 03:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KDK0Caj5Cf0P40tV8yWWy7Z6AKrz5f565k86k1Xh+mI=;
        b=BAZyqVtiJE7QX11VNuInQPqJHicmy0MjjgF+MyaXL5ilPNhRWAHfiY4a4etGHVMqfD
         fJFc348W5QxvbLS6LmteMgSCYVby3MhNi8kox/uf2HJxuyo5ZQYIQrP4TxRZdiN7yy9q
         yZPlkV4VzxtkipOsE6T+0SlQx+sQDOsITsb28jDUnAtITK4IIC1vV+2wqGIkxuiOYGjk
         slxRwyVl30NB1nt132tR3rd4YO0MId4YoMIteDRpnWxBdwelsNol9qzmNR/7jAip68Oo
         Tg7BsUOkk2CePp4JEf6X17I6iFfVPgCx4y1JKHVU5v9atrA/Q+dozqJLXD9xKp8Mhco/
         zypQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KDK0Caj5Cf0P40tV8yWWy7Z6AKrz5f565k86k1Xh+mI=;
        b=kNaHQGnKVrIy7iJI0kh0UucbEIrESWPB+Vgc2mAXpjuwbNQ7Q6hyovGkLBW57DuzWj
         mIjozIUKpFMBerblC3UiV7L+2kPBnSrYS9hQBkUXLOiehPcArsAW0Q8WQB5/hZT24OUy
         An4NGqEo8iU0KKgvSV5Sz2Dbd5mVfqHVVABpmsZ4c2LBwihqznd5hPdVDKZ1e2IqBI7v
         IfjQxlncAORHVqsieguYCGiW42IO/gjYbreNQSw2DG2KFsSLJ/otVgD5kDBfAME2RuLi
         2ee9Y4IG29pXrIx8hGP5ZdDBcHyEV/EOhcStXC++Fdjleqsvu6PQOrP77nofH0uAMvEj
         LMig==
X-Gm-Message-State: AOAM532eSZD/CJZQCpfV/FBbgdkalUYETWn3mC8P6IePwU9F2hDyVcva
        xWdjP1XZLRcmM/RMXvewkQeCmDa1eNxn87dhnjWW2Av9eFU=
X-Google-Smtp-Source: ABdhPJzbt4wvfiFZXGTP+zkxcujnlorCwwG7yUVQ8WUNO514+3wsXbOgi7Hz4vMjUaTIE199rQN011t7DFhCtbuPUVs=
X-Received: by 2002:a05:6e02:1305:: with SMTP id g5mr7589121ilr.237.1603621440309;
 Sun, 25 Oct 2020 03:24:00 -0700 (PDT)
MIME-Version: 1.0
References: <pull.751.git.1602781723670.gitgitgadget@gmail.com>
 <20201023111827.40188-1-sangunb09@gmail.com> <xmqqmu0cfx9a.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqmu0cfx9a.fsf@gitster.c.googlers.com>
From:   Sangeeta NB <sangunb09@gmail.com>
Date:   Sun, 25 Oct 2020 15:53:49 +0530
Message-ID: <CAHjREB6fC6j30MH1Lb7enE3KJaGdX--Ft8+hwVeDfwApab5FNQ@mail.gmail.com>
Subject: Re: [Outreachy] [PATCH v4] diff: do not show submodule with untracked
 files as "-dirty"
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 24, 2020 at 2:58 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Sangeeta Jain <sangunb09@gmail.com> writes:
>
> > diff --git a/t/t4027-diff-submodule.sh b/t/t4027-diff-submodule.sh
> > ...
> > +test_expect_success 'git diff HEAD with dirty submodule (untracked) (none ignored)' '
> > +     git config diff.ignoreSubmodules none &&
> > +     git diff HEAD >actual &&
> > +     sed -e "1,/^@@/d" actual >actual.body &&
> > +     expect_from_to >expect.body $subtip $subprev-dirty &&
> > +     test_cmp expect.body actual.body &&
> > +     git config --unset diff.ignoreSubmodules
> > +'
>
> If any step concatenated by && in the above sequence fails, the test
> repository will have diff.ignoreSubmodules set to none (without
> getting it reset, since &&-chain prevents the last "config --unset"
> step from running).  Unless the test is run under the --immediate
> option, that would affect the environment in which subsequent tests
> are run.
>
> Instead, our test usually do this:
>
>         test_expect_success 'test title' '
>                 test_config diff.ignoresubmodules none &&
>                 git diff HEAD >actual &&
>                 ...
>                 test_cmp expect.body actual.body
>         '
>
> "test_config" sets up a trigger, which will _always_ fire, whether
> the test fails at any intermediate steps or runs to the end and
> succeeds, to remove the configuration it just added.  It is a
> short-hand for writing
>
>         test_when_finished test_unconfig diff.ignoresubmodules &&
>         git config diff.ignoresubmodules none
>
> i.e. to use test_when_finished to set up the trigger.
>

Oh, okay! I would make these changes. Thanks for the explanation.
There are also other places where `git config` is used in test
scripts. Should I change that too? Or maybe as they are not relevant
to this patch, we can create an issue or even a microproject for other
first-timer contributors?


> > -     git diff HEAD >actual &&
> > +     git diff --ignore-submodules=none HEAD >actual &&
> >       sed -e "1,/^@@/d" actual >actual.body &&
> >       expect_from_to >expect.body $subprev $subprev-dirty &&
> >       test_cmp expect.body actual.body &&
> >       git diff --ignore-submodules=all HEAD >actual2 &&
> >       test_must_be_empty actual2 &&
> > -     git diff --ignore-submodules=untracked HEAD >actual3 &&
> > +     git diff HEAD >actual3 &&
>
> This line can be left as-is, no?

Ya, they can be left as it is but I removed the
--ignore-submodules=untracked because we also have to check the
default git behavior and adding that doesn't change anything in the
code so I removed that.
In general, in all the tests I followed this practice:
1. I added --ignore-submodules=none where there were no options
specified(as this was the earlier default)
2. I removed --ignore-submodules=untracked(as this should even work if
no options are specified)

I would put that back if you still want it?

Thanks and Regards,
