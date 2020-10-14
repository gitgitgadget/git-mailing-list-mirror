Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4906EC43457
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 02:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5F3D22257
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 02:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bs+qANrq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732582AbgJOCOk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 22:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730361AbgJOCOj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Oct 2020 22:14:39 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14E8C05BD19
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 15:35:43 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id 67so1580061iob.8
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 15:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=1WfRsCHeJlIqWx57yTvv//sQnCYnYIEjxMcL5ydX0VE=;
        b=bs+qANrqheRDLkH7dTeeUmOibN8rFZfxSS3hTZvweao2odD8CR3TafwJVnntekHgIR
         9QaoytSoeia2D10O7KVSuU4VrZxcY7eaKFVE+qzR+MkgXbtcFG9rc6FOnRYQIhEZpOpD
         x2mCWMmEYpR7lsjMVpiH4ZcwPThd0GG+8I9JqqeFU1/9YUYHhhdoOCM03MAtOSmLU3Ya
         tv2K/pnwBktka5RhdRn3DG2+yyIZEsh25MGBWrB5lIgSkWdMbdcu7p1FOSL6B7OhN12w
         NztVtvyU4rgmAmdkLBdxwvtcOu9yIdxSjiZuFxFTAVL8IpVuMUhzTLSM1mFfZHDahzUg
         0Lsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=1WfRsCHeJlIqWx57yTvv//sQnCYnYIEjxMcL5ydX0VE=;
        b=gF+27lkEE14BaWBPmnre2DIYqMpsev+2DyKXGE1PflXXqHjQKu9xj8wfx4Fw8tNOv3
         549saqWOuIp8xg9VFj6I/1TrnO/l+or2w4VIpZeON/aPU8yrG1u6rMmc0xjiaIhk+DP+
         v8mVRTjd0rQ0wHxI+YSNsZS6FgBMVQ1dMLGw3sbNoS/apZ2auS5PjOJAoWNFHyjjgFDx
         77l81etrrooMAzE8uFJ1Cz4k03uV6c226TICpxw8TnZRy4ov8sVCTFzUDc/yJhzkqLR4
         Yqy34IDJhTqO1lCSywyTZ1+L0rlFAOfIHCvvln1zzvo0NWZRsmsSVZF5vUUvNVcIsbcS
         0H0g==
X-Gm-Message-State: AOAM530JUAt4YJboHu+xRpdK153to3xp4yEOwUDcPqelERlUOOVSlInS
        vMV2BvJuIXZYpPoo+9ZCtkA=
X-Google-Smtp-Source: ABdhPJxf2V4c8ctTuyCX0toUbfNR/5PD2H/htzrWVGRprKr+mbuRNsECMDB7kXNnoVN7L/lFDJcNdw==
X-Received: by 2002:a02:110a:: with SMTP id 10mr1319714jaf.23.1602714942954;
        Wed, 14 Oct 2020 15:35:42 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id m2sm815924ion.44.2020.10.14.15.35.41
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 14 Oct 2020 15:35:42 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [BUG?] Weird interaction between `git -C`, aliases and worktrees
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <CABPp-BF2Stb_UfNEqYOBPjvm09oO8=ST685kZ0+U2PtPRz5_mg@mail.gmail.com>
Date:   Wed, 14 Oct 2020 18:35:39 -0400
Cc:     Git mailing list <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <88D2A179-806F-4321-828A-359692E646B1@gmail.com>
References: <020EB674-6A95-4E53-B2E7-F4EEBD6324C3@gmail.com> <CABPp-BF2Stb_UfNEqYOBPjvm09oO8=ST685kZ0+U2PtPRz5_mg@mail.gmail.com>
To:     Elijah Newren <newren@gmail.com>
X-Mailer: Apple Mail (2.3124)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

> Le 14 oct. 2020 =C3=A0 18:02, Elijah Newren <newren@gmail.com> a =
=C3=A9crit :
>=20
> On Wed, Oct 14, 2020 at 8:27 AM Philippe Blain
> <levraiphilippeblain@gmail.com> wrote:
>>=20
>> Hello all,
>>=20
>> Up to recently I had an alias 'st' for `git status`, i.e. `git config =
alias.st status`.
>> This works well in the main working tree as well as secondary =
worktrees (`git worktree add ...`),
>> and also shows paths relative to the current directory if I'm not at =
the root of the repo,
>> just like `git status`.
>>=20
>> Now I wanted to change my alias so that it ran `git status` and then =
an additional command, i.e.
>> `git config alias.st '!git status && date'` (for demonstration =
purposes).
>> This works correctly in the main worktree and secondary worktrees, =
but since aliases
>> run from the root of the repo, the paths in the output of 'git st' =
are not relative
>> to the current directory.
>>=20
>> So my next attempt was `git config alias.st '!git -C "${GIT_PREFIX}" =
status && date'`,
>> so that paths would be relative in the output. However, this works in =
the main worktree
>> but fails badly in the secondary worktree:
>>=20
>> ```
>> rm -rf test &&
>> rm -rf test2 &&
>> git init test &&
>> cd test &&
>> mkdir folder &&
>> date>>folder/file &&
>> git add folder/file &&
>> git ci -m "commit" &&
>> git config alias.st '!git -C "${GIT_PREFIX}" status && date' &&
>> date >>folder/file &&
>> echo '=3D=3D=3D `git st` in main worktree at root =3D=3D=3D' &&
>> git st &&
>> cd folder &&
>> echo '=3D=3D=3D `git st` in main worktree in folder =3D=3D=3D' &&
>> git st &&
>> git worktree add ../test2 &&
>> cd ../test2 &&
>> date >>folder/file &&
>> echo '=3D=3D=3D `git st` in secondary worktree at root =3D=3D=3D' &&
>> git st &&
>> cd folder &&
>> echo '=3D=3D=3D `git st` in secondary worktree in folder =3D=3D=3D' =
&&
>> git st
>> ```
>>=20
>> The last commands ouputs:
>>=20
>> ```
>> =3D=3D=3D `git st` in secondary worktree in folder =3D=3D=3D
>> On branch test2
>> Changes not staged for commit:
>>  (use "git add/rm <file>..." to update what will be committed)
>>  (use "git restore <file>..." to discard changes in working =
directory)
>>        deleted:    folder/file
>>=20
>> Untracked files:
>>  (use "git add <file>..." to include in what will be committed)
>>        file
>>=20
>> no changes added to commit (use "git add" and/or "git commit -a")
>> ```
>>=20
>> So something is wrong in the automatic worktree path detection...
>> If I replace the alias with
>>=20
>>    git config alias.st '!git -C "${GIT_PREFIX}" --work-tree=3D$PWD =
status && date'
>>=20
>> then it works correctly, but I have a feeling this should not be =
necessary...
>>=20
>> I've CC-ed Eric (because of his work on `git worktree`) and Elijah =
(because
>> I remember he worked on `dir.c` so maybe this is related to that =
code, but I'm
>> not sure).
>>=20
>> Cheers,
>> Philippe
>=20
> I don't think there's anything dir.c-specific here (thank
> goodness...).  I extended your aliases slightly to echo the command
> they would run (so I could see the value of $GIT_PREFIX) as well as to
> print all the GIT_* environment variables, and found that GIT_DIR was
> set as well as GIT_PREFIX, so you can duplicate the funny results with
>=20
> GIT_DIR=3D$WHEREVER git -C folder status
>=20
> or even
>=20
> git --git-dir=3D$WHEREVER -C folder status
>=20
> In fact, you don't need any special worktrees setup; using these
> commands will trigger the funny status output.  Looking at the
> documentation for core.worktree, I see
>=20
> "If --git-dir or GIT_DIR is specified but none of --work-tree,
> GIT_WORK_TREE and core.worktree is specified, the current working
> directory is regarded as the top level of your working tree."

Yes, this is in line with git(1) [1] :

"Specifying the location of the ".git" directory using this option (or =
GIT_DIR environment variable)
 turns off the repository discovery that tries to find a directory with =
".git" subdirectory
(which is how the repository and the top-level of the working tree are =
discovered),=20
and tells Git that you are at the top level of the working tree.=20
If you are not at the top-level directory of the working tree,
 you should tell Git where the top-level of the working tree is,=20
with the --work-tree=3D<path> option (or GIT_WORK_TREE environment =
variable)"

> and indeed, I find that if I run from the toplevel:
>=20
> git --work-tree=3Dfolder/ status
>=20
> then I see the same output that you are complaining about.  So, it
> seems that "the current working directory is regarded as the top level
> of your working tree" is implemented to take effect AFTER the "-C
> folder" first changes the current working directory.
>=20
> I haven't tracked down where in the code this happens, but I suspect
> that this is what is happening and is the culprit behind the behavior
> you are seeing.  If I am right, it doesn't answer whether this is a
> bug, of course -- it could be that this ordering is intentional and
> desired, or it could be that this ordering is not wanted.  Anyway,
> does this help you track it down?


I found two threads [2] and [3] which are manifestations of similar (or =
the same ?) problems...

Maybe git-config(1) could document which variables will=20
be set in aliases that shell out, but even that might be tricky because =
it
seems the answer is "it depends" (according to [2])...

I also found 57ea7123c8 (git.c: make sure we do not=20
leak GIT_* to alias scripts, 2015-12-20), in topic =
'nd/clear-gitenv-upon-use-of-alias',
which tries to clear out GIT_* variables from aliases environment,
which I guess is defeated by the fact that I run `git -C` in my alias...

Anyway thanks for your answer.

[1] https://git-scm.com/docs/git#Documentation/git.txt---git-dirltpathgt
[2] =
https://lore.kernel.org/git/20200130102933.GE840531@coredump.intra.peff.ne=
t/
[3] =
https://lore.kernel.org/git/20200228190218.GC1408759@coredump.intra.peff.n=
et/

Philippe.

