Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC51C433EF
	for <git@archiver.kernel.org>; Thu, 12 May 2022 05:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349210AbiELFMq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 May 2022 01:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349230AbiELFMn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 May 2022 01:12:43 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F9B41622
        for <git@vger.kernel.org>; Wed, 11 May 2022 22:12:42 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id kq17so7913357ejb.4
        for <git@vger.kernel.org>; Wed, 11 May 2022 22:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C5Y6VofiICQSc3vrGJLdcc4mVgJfY9B98GDCrdZGzxo=;
        b=JTwm6BsR6KjQ3EAvap7SRa35TLyjwgBzVJMAy2X0r/M5uV2oLT4QoPLNDrBA9Pn9w/
         A51Yqy7Fn2DUKVODp7uHptDEup7DHi/5cKvDKtLJazb5ezq9UyD/7rKaLw0UYsOYVxs3
         n1f+VzyFj/pmTa9bTRI14PNMYCbDJRv9cNJk4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C5Y6VofiICQSc3vrGJLdcc4mVgJfY9B98GDCrdZGzxo=;
        b=k8aLk5w8nfWEjpRM501G7l7Dqm38jWqMTWiZtL+S3Yw71mvtIJjtIMCmoSuIr0Ii3P
         rFTBjrP29GHYfWAJad7XJHD3BkMlNTMKgdo7/VDobETVoZV6PJf9vSVZjWwiawSxN3B+
         0Krc9kXBOaVzyfwA9+c6tuPBq3sDdeuyrmD8aWXYBaKhnOGDpvFRt2uLzDWQBwwYWbOK
         TOwxBbbiebIhFwp/sJEHf0hHi2woGaZ4U6gPlCLCSrlVz+tAD/SqOm3PyxRlJc14TI5V
         aoM3UTMnTjs0tS3yDfR0k2P4DvTl8PI+KuyfvZWouHJ8CHpCPQXEoLUnedvia0iBDMnY
         SWNQ==
X-Gm-Message-State: AOAM531rJRF+D7UAUpnRq52bnTldE9QSLEt7C2dZ0hoK4oK6v/b0/Qg3
        smaH+H7j22dDMxfWTwLykgIiKIpBphE8sqGT77EsVg==
X-Google-Smtp-Source: ABdhPJyDlKslrjWcuIIXl/9ignnUdYhiMkk6E9m0mpsJky+Au486QflNssY31mq8QL8i+Mms7Szn0HVOi/Erm3VDsHw=
X-Received: by 2002:a17:907:1c87:b0:6f0:29ea:cc01 with SMTP id
 nb7-20020a1709071c8700b006f029eacc01mr28058752ejc.671.1652332360968; Wed, 11
 May 2022 22:12:40 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1182.v2.git.1647995031417.gitgitgadget@gmail.com>
 <pull.1182.v3.git.1651344174050.gitgitgadget@gmail.com> <xmqqh765mcn0.fsf@gitster.g>
In-Reply-To: <xmqqh765mcn0.fsf@gitster.g>
From:   Tao Klerks <tao@klerks.biz>
Date:   Thu, 12 May 2022 07:12:29 +0200
Message-ID: <CAPMMpogxDfmoc_9CnL6x2Hf79BgWDrq=3KfMrbc+xwyo1k=yJQ@mail.gmail.com>
Subject: Re: [PATCH v3] t3200: fix antipatterns in existing branch tests
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 4, 2022 at 7:27 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>
> > @@ -510,63 +512,57 @@ test_expect_success 'git branch --copy dumps usage' '
> >  test_expect_success 'git branch -c d e should work' '
> >       git branch --create-reflog d &&
> >       git reflog exists refs/heads/d &&
> > -     git config branch.d.dummy Hello &&
> > +     test_config branch.d.dummy Hello &&
> >       git branch -c d e &&
> >       git reflog exists refs/heads/d &&
> >       git reflog exists refs/heads/e &&
> > -     echo Hello >expect &&
> > -     git config branch.e.dummy >actual &&
> > -     test_cmp expect actual &&
> > -     echo Hello >expect &&
> > -     git config branch.d.dummy >actual &&
> > -     test_cmp expect actual
> > +     test_cmp_config Hello branch.e.dummy &&
> > +     test_cmp_config Hello branch.d.dummy
> >  '
>
> This test used to leave both branch.d.dummy and branch.e.dummy behind
> for later tests.  Now with this patch, we clean branch.d.dummy
> because we use test_config, but branch.e.dummy that was copied by
> successful "git branch -c" will still be left.
>
>  - It is unforunate that it is impossible to verify that the change
>    in behaviour for branch.d.dummy is correct.  Without checking all
>    the remainder of the test (and no, grepping for branch.d.dummy is
>    not "checking all the remainder"---a later "branch -c d x" would
>    have created brnach.x.dummy in the original, but with this patch,
>    it would not), which is time consuming, that is.
>
>    I trust you made sure that branch.d.dummy is never used after
>    this test is done---it would have been good to explain it either
>    in the proposed log message or after three-dash that you did
>    check and how to save reviewer bandwidth.

I will add a comment, and will (first) more diligently check for
dependencies on things now-removed.

My strategy was, frankly, a little more haphazard: eyeball the intent,
look for references in the following couple tests, and otherwise
assume that if the tests still pass, it means they didn't unexpectedly
depend on this.

Fwiw, the not-trivial-but-still-straightforward approach I'm using is
to search case-sensitively for the word "d" in this example. a, b, c
and d are all bad because they are common english words or flags used
throughout this test, but other letters and combinations are easier to
check in this reasonably-simple way.

>
>  - Are you deliberatly leaving branch.e.dummy uncleaned, or is it a
>    mere oversight?
>

Somewhere in-between. My intent with these changes was to use the
right helpers/patterns, but I did not aspire to making sure nothing
leaks between tests at all.

Generally speaking, none of the tests I've seen (in this file or
others) clean up / delete the *branches* they create - presumably
because there's no significant need - the existence of branches rarely
or never has side-effects unless explicitly referenced. Config, on the
other hand, is a good thing to clean up by default, because it is much
more likely to interfere with later tests.

Something like configuring "branch.x.dummy" (or the more meaningful
"branch.x.merge") straddles those 2 worlds - I would use test_config
to be consistent if setting one manually, but it's still
branch-specific stuff so I wouldn't be diligent about removing it if
it was created as a side-effect of another command like "git branch
-c" - just like I'm not removing the new branch itself.

That said, now that you've called my attention to it, I'll look for
leaky branch configs :)

I will also add a note clarifying "intend to use the right
patterns/helpers, but not necessarily to eliminate state leaks between
tests" in the commit message.

> >  test_expect_success 'git branch --copy is a synonym for -c' '
> >       git branch --create-reflog copy &&
> >       git reflog exists refs/heads/copy &&
> > -     git config branch.copy.dummy Hello &&
> > +     test_config branch.copy.dummy Hello &&
> >       git branch --copy copy copy-to &&
> >       git reflog exists refs/heads/copy &&
> >       git reflog exists refs/heads/copy-to &&
> > -     echo Hello >expect &&
> > -     git config branch.copy.dummy >actual &&
> > -     test_cmp expect actual &&
> > -     echo Hello >expect &&
> > -     git config branch.copy-to.dummy >actual &&
> > -     test_cmp expect actual
> > +     test_cmp_config Hello branch.copy.dummy &&
> > +     test_cmp_config Hello branch.copy-to.dummy
> >  '
>
> The same comment for branch.copy.dummy and branch.copy-to.dummy
> applies.
>
> I'll stop here for now.  Thanks for starting this clean-up.

Thank you!
