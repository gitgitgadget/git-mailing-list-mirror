Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D895EC433EF
	for <git@archiver.kernel.org>; Sat, 22 Jan 2022 12:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234482AbiAVMIl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Jan 2022 07:08:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiAVMIk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Jan 2022 07:08:40 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE91C06173B
        for <git@vger.kernel.org>; Sat, 22 Jan 2022 04:08:40 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id d10so7510580eje.10
        for <git@vger.kernel.org>; Sat, 22 Jan 2022 04:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=auTU/g86lgUqLOsmAIyZGQovyfDmkP84wm4QgcH3zUg=;
        b=fNPMAlJ5H3gMiPo/O8Rki4ccHTPOVyj9wwD82xWSMTKWFBXTMG7Uw/KO/5XCAlVsYC
         s4TEhhw0fqJweSrTAWqSxlJV1vn9E+0yoCJb2v3KYdvE58F6BWy7cMBu933qF4mKKWBj
         embGlApECXVexTzJ0fcywl2mE9pnuTRcJ0cqC/02zwmpDp6TfZSg3cBhqvDPng8cxxqd
         aZ/HsCfe6ZpgUiB8Jxo7eCYhuQfoTlXqQ0c7w0z/csl+vvcXlZrFm7Pekqs3Rs8RXq9T
         DdfZaHCMvUYt8XoQLoxO00cncgb9Xcq4KOA07Q4Noc7UJouqMYhdKyX6DJkV6hNitm0m
         CfZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=auTU/g86lgUqLOsmAIyZGQovyfDmkP84wm4QgcH3zUg=;
        b=UjK1R/nenDqDvjsHi4EIC5SaIeRT4rLBh541C6klpJRPII9UdXLxwpIJwk3XfmXLCu
         libAPWyeGJ78peffgeUMFxPftbCEcs56mBRBml0Otf6gDzWu1IP3NhMeMHehqaluZ1FV
         a73Q8/S3IxR2gif8XHWfFB0j2RuGIhIxwDGGTTW1kN5xWFY4afHMQ4l/ChBUCmOzDV/g
         GUpG0qTOuoOUuzqemT58xzRFD1R3jDbr+ZdhfT10RPPPL5bU6SGFOnrSAKRJAlq3+aKc
         byyPNqdNChbKCdUET4rB7sWJ1+RMrCTVuXKJz9zy3+O9dA2jnyEk4K44nJzcpCPhWuMl
         cyaA==
X-Gm-Message-State: AOAM531hbGZTtfdBB5XrawFGOz4iUphM67ZRlWCHNBWtnblRWe+5bg5I
        BUptH6FISYBfztKAPteJ1FqicS49djk=
X-Google-Smtp-Source: ABdhPJxZNdqxD/M8dlWeeEV1pZ6hwhoDxd29E/Ie8PitLFePeb96xOMFJBgD74EzJlcMMGaUR/6W4Q==
X-Received: by 2002:a17:906:a955:: with SMTP id hh21mr6411272ejb.360.1642853318530;
        Sat, 22 Jan 2022 04:08:38 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id dk3sm3616025edb.33.2022.01.22.04.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jan 2022 04:08:37 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nBFC8-002LzS-S0;
        Sat, 22 Jan 2022 13:08:36 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, jabolopes@google.com
Subject: Re: [PATCH v2] sparse-checkout: create leading directory
Date:   Sat, 22 Jan 2022 13:06:02 +0100
References: <20220120185548.3648549-1-jonathantanmy@google.com>
 <20220121174441.3991963-1-jonathantanmy@google.com>
 <220121.8635lgkj17.gmgdl@evledraar.gmail.com>
 <CABPp-BHgRQ+qNvq19wsBsMCR+Cn7FS+0FMYXVyyzEAZTsg-wjA@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <CABPp-BHgRQ+qNvq19wsBsMCR+Cn7FS+0FMYXVyyzEAZTsg-wjA@mail.gmail.com>
Message-ID: <220122.86tudwht17.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jan 21 2022, Elijah Newren wrote:

> On Fri, Jan 21, 2022 at 6:12 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>> On Fri, Jan 21 2022, Jonathan Tan wrote:
>>
> ...
>> This partial application of the fix-up I suggested in
>> https://lore.kernel.org/git/220120.86mtjqks1b.gmgdl@evledraar.gmail.com/
>> leaves the now-unused "blank-template"
>
> Good point; no need to remove something that isn't being created anymore.
>
>>
>> >  - added attribution to Jose Lopes for finding and making the first
>> >    draft of this patch (after confirming with them)
>> >
>> > =C3=86var mentioned "git sparse-checkout add" but I think that that is=
 a
>> > different problem - in the "git sparse-checkout init" case, we could g=
et
>> > into this case with a template that does not have .git/info, but in the
>> > "git sparse-checkout add" case, the user would have had to explicitly
>> > remove the info directory. So I'll limit this patch to the "init" case,
>> > for now.
> ...
>>
>> I agree that it's a slightly different problem, but I was just
>> advocating for us testing what happened in these cases.
>>
>> The below fix-up does that.
>
> Different problem...addressed with a "fix-up"?  Why would we squash
> extra testing of a different problem into the same commit?  I think
> it'd at least deserve its own commit message.

Sure, or split up, or with an amended commit message etc.

>> I think we should use warning_errno() there
>> instead of some specutalite "file may not exist", but with/without this
>> patch these tests show that only the "init" case was broken.
>>
>> As a more general issue I don't understand why "add" and "init" need to
>> be conceptually different operations. If what defines a sparse checkout
>> is just that it has that file and the 2 default patterns, which unless
>> I'm missing something is the case.
>>
>> Why isn't "add" merely an "init"
>> that'll optimistically add whatever pattern you asked for, in addition
>> to doing an "init" if you didn't already?
>>
>> Then "add" and "init" will share the same error recovery behavior, and
>> you won't needlessly have to run "init/add x" just to start using
>> sparse-checkout with a pattern of "x".
>
> The high level idea you propose (" 'add' can initialize sparsity state
> if not currently in a sparse checkout") could make sense.  It isn't
> just a straightforward switchover with the various other config
> settings and such, and would also necessitate adding additional
> command line flags to the 'add' subcommand, but it could be done.
> Didn't occur to me before; I'm not sure if such a change in UI would
> be better or worse.  I'm inclined to leave it as it is, though,
> especially since...
>
> The low level idea you propose (sharing code down to error paths) does
> not make sense in this particular case, for reasons that are rather
> non-obvious.  In particular, we need to be careful to avoid sharing
> some code with "init".  The "init" subcommand is deprecated as of
> ba2f3f58ac ("git-sparse-checkout.txt: update to document
> init/set/reapply changes", 2021-12-14).  I initially wanted to remove
> the separate "init" codepath, and just forward "git sparse-checkout
> init" calls over to the "git sparse-checkout set" codepath (the only
> difference being that "init" always comes with an empty set of
> directories/patterns).  However, "init" had some problematic behavior
> that I didn't want to copy to "set".  I also didn't want to kill that
> behavior in "init" for backwards compatibility reasons.  And, this
> xfopen call was tied up in that tangle, which means that it will
> definitely remain separate, and thus needs to be fixed in isolation.

....

>> But I've never *actually* used this command, so maybe I'm just missing
>> something obvious...
>>
>> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkou=
t-builtin.sh
>> index 3189d3da965..6b56d9d177f 100755
>> --- a/t/t1091-sparse-checkout-builtin.sh
>> +++ b/t/t1091-sparse-checkout-builtin.sh
>> @@ -80,11 +80,37 @@ test_expect_success 'git sparse-checkout init' '
>>  '
>>
>>  test_expect_success 'git sparse-checkout init in empty repo' '
>> -       test_when_finished rm -rf empty-repo blank-template &&
>> +       test_when_finished rm -rf empty-repo &&
>
> This hunk looks like a good fixup to Jonathan's patch.
>
>>         git init --template=3D empty-repo &&
>>         git -C empty-repo sparse-checkout init
>>  '
>>
>> +test_expect_success 'git sparse-checkout add -- info/sparse-checkout mi=
ssing' '
>> +       test_when_finished "rm -rf empty" &&
>> +       git init --template=3D empty &&
>> +       git -C empty sparse-checkout init &&
>> +       rm -rf empty/.git/info &&
>> +
>> +       cat >expect <<-\EOF &&
>> +       fatal: unable to load existing sparse-checkout patterns
>> +       EOF
>> +       test_expect_code 128 git -C empty sparse-checkout add bar 2>actu=
al &&
>> +       test_cmp expect actual
>> +'
>> +
>> +test_expect_success 'git sparse-checkout list -- info/sparse-checkout m=
issing' '
>> +       test_when_finished "rm -rf empty" &&
>> +       git init --template=3D empty &&
>> +       git -C empty sparse-checkout init &&
>> +       rm -rf empty/.git/info &&
>> +
>> +       cat >expect <<-\EOF &&
>> +       warning: this worktree is not sparse (sparse-checkout file may n=
ot exist)
>> +       EOF
>> +       git -C empty sparse-checkout list 2>actual &&
>> +       test_cmp expect actual
>> +'
>> +
>
> So...you're trying to test what happens when a user intentionally
> bricks their repository?

I'm just saying that it's cheap to add a regression test for this
missing bit of related coverage, so why not add it?

We need to deal with the real world, a repo might be in all sorts of odd
states, including because of a user mistake.

> (Note that `sparse-checkout init` sets core.sparseCheckout=3Dtrue, as
> explicitly documented.  core.sparseCheckout=3Dtrue instructs git to pay
> attention to $GIT_DIR/info/sparse-checkout for every unpack_trees()
> call that updates the working tree, which basically means nearly any
> significant Git operation involving a worktree update now needs that
> file in order to function.  So, your commands told Git that this
> directory is mandatory, and then you nuked the directory.)

*nod*. But in that case shouldn't the errors say that you've configured
core.sparseCheckout=3Dtrue but you're missing XYZ file?

> Now, if you could find a testcase based on `git worktree add ...`
> (which doesn't create an "info" directory) and then triggers problems
> somehow without the intentional bricking, then what you'd have would
> be more in line with what Jonathan is addressing here, but as it
> stands it's hard to even call your testcases related.  There may be
> some merit to testing deliberately broken repositories, but I'm just
> not sure if that's what you really intended and were suggesting.  Was
> it?  Or am I just missing something here?

Doesn't the worktree case just use the "main" info/*, e.g. for
info/excludes (didn't have time to test it now).
