Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2EEC433EF
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 09:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240312AbiBCJwa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 04:52:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234483AbiBCJw3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 04:52:29 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D44C061714
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 01:52:29 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id me13so6859101ejb.12
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 01:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=GF60Y4tw1SvXB64iiQ7H/y50yWcsTgthSTSsiQ79YZ4=;
        b=qmKz4tfekKIvS3aPi/Vf5oriPDcU97HZ9tXTX+baooaRfdzs24XgoEV5smjkIhRAFX
         nON49mInQtAaIp4bj2sUKlRUxgaT6YGcreumPtiVpEYE9MsPjEzI7x7YV4fC9YbilAaW
         Q0ZXUlxLLvzjK4zmpPFMC9NmR2R0YK32ERIW8coH2vWD7PmQ8/s5pGrp7Y7lJ5OxSXGv
         Qj9cPxAgxIni53kZ8Sefudd5Qt/yOyol7IWz4NrwM/Jnbiy5i9bLNkbUjIMbqH5yYZwS
         sH5z+UO/YY7P89MzHsa0ATmvUABcX+RtViclM0Ymy9l9GJxRkqClNgQ5X8IoVn84Rl8R
         s5Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=GF60Y4tw1SvXB64iiQ7H/y50yWcsTgthSTSsiQ79YZ4=;
        b=G7IHoW/58bvF2/0J4b3/p17QV8qC64tr0y0okAiAO5Z1hKM1vUjgFlZK6y3an8Iqyr
         D1mI7PYaRzGlWDDrMCOm1aSAiCac7esxOZzeQXX1n5dlYSfhvYHj6vWD5o9lt2a3KvOe
         KAq4EUgo08jMVMiGyQgF51aF3oJJYfdsFEpPBuwMfYuPD2w/xGvIc46+tWx9N3XXeGg4
         4uIJhvTV1GfkwjXTk2UkhywLz1awxRuMDRulVcnVTJI2Gu4jAwAFulsD5wm5tus7CSjE
         d2QNmPoSh/1JYbpQ8cZfdliv/S3LrWEDGqtlLv/O59CAZrXJguOJ3PHdRTu7oJlT1Lwf
         Dbig==
X-Gm-Message-State: AOAM530+M57rMSGlDIT3DvzNVXPV823UoCbe+jKxtsDFhT7iQfAm5PVn
        R/W5fsxiWzE4zMo06QUdC8M0GQG6PTCQxw==
X-Google-Smtp-Source: ABdhPJx0BQd8t26y64QB3jXobtMU+KLlBZy0//XEy8htZ06RzTOMVekcxNgL1de8rdP1tnqv7QcxYQ==
X-Received: by 2002:a17:907:d9f:: with SMTP id go31mr29826860ejc.282.1643881947345;
        Thu, 03 Feb 2022 01:52:27 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id cf24sm16586609ejb.133.2022.02.03.01.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 01:52:26 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nFYmv-004vEi-RB;
        Thu, 03 Feb 2022 10:52:25 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 03/15] merge-tree: add option parsing and initial
 shell for real merge function
Date:   Thu, 03 Feb 2022 10:45:56 +0100
References: <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
 <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com>
 <63f42df21aec5bda50e4414493eb59dcb64e5558.1643787281.git.gitgitgadget@gmail.com>
 <220203.86a6f87lbl.gmgdl@evledraar.gmail.com>
 <CABPp-BHKZnmaq3NM5_D6pwkw2+91EsdJ-uqjfFPBYiUSE28k1g@mail.gmail.com>
 <CABPp-BHZYUmWBvzgFkRYddnUJQWrtah=JJ-yaW9Km8+qWcCfUw@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <CABPp-BHZYUmWBvzgFkRYddnUJQWrtah=JJ-yaW9Km8+qWcCfUw@mail.gmail.com>
Message-ID: <220203.86wnic5lba.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 03 2022, Elijah Newren wrote:

> On Thu, Feb 3, 2022 at 1:04 AM Elijah Newren <newren@gmail.com> wrote:
>>
>> On Wed, Feb 2, 2022 at 6:09 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <a=
varab@gmail.com> wrote:
>> >
>> > On Wed, Feb 02 2022, Elijah Newren via GitGitGadget wrote:
>> >
>> > > From: Elijah Newren <newren@gmail.com>
>> > >
>> > > Let merge-tree accept a `--write-tree` parameter for choosing real
>> > > merges instead of trivial merges, and accept an optional
>> > > `--trivial-merge` option to get the traditional behavior.  Note that
>> > > these accept different numbers of arguments, though, so these names
>> > > need not actually be used.
>> >
>> > Maybe that ship has sailed, but just my 0.02: I thought this whole thi=
ng
>> > was much less confusing with your initial merge-tree-ort proposal at
>> > https://lore.kernel.org/git/CABPp-BEeBpJoU4yXdfA6vRAYVAUbd2gRhEV6j4VEq=
oqcu=3DFGSw@mail.gmail.com/;
>> > I.e. the end-state of merge-tree.c is that you end up reading largely
>> > unrelated code (various static functions only used by one side or
>> > another).
>>
>> Christian's merge-tree-ort proposal?
>>
>> > But maybe that's all water under the bridge etc, however...
>> >
>> > >  int cmd_merge_tree(int argc, const char **argv, const char *prefix)
>> > >  {
>> > > -     if (argc !=3D 4)
>> > > -             usage(merge_tree_usage);
>> > > -     return trivial_merge(argc, argv);
>> > > +     struct merge_tree_options o =3D { 0 };
>> > > +     int expected_remaining_argc;
>> > > +
>> > > +     const char * const merge_tree_usage[] =3D {
>> > > +             N_("git merge-tree [--write-tree] <branch1> <branch2>"=
),
>> > > +             N_("git merge-tree [--trivial-merge] <base-tree> <bran=
ch1> <branch2>"),
>> > > +             NULL
>> > > +     };
>> > > +     struct option mt_options[] =3D {
>> > > +             OPT_CMDMODE(0, "write-tree", &o.mode,
>> > > +                         N_("do a real merge instead of a trivial m=
erge"),
>> > > +                         'w'),
>> > > +             OPT_CMDMODE(0, "trivial-merge", &o.mode,
>> > > +                         N_("do a trivial merge only"), 't'),
>> > > +             OPT_END()
>> > > +     };
>> > > +
>> > > +     /* Parse arguments */
>> > > +     argc =3D parse_options(argc, argv, prefix, mt_options,
>> > > +                          merge_tree_usage, PARSE_OPT_STOP_AT_NON_O=
PTION);
>> > > +     if (o.mode) {
>> > > +             expected_remaining_argc =3D (o.mode =3D=3D 'w' ? 2 : 3=
);
>> > > +             if (argc !=3D expected_remaining_argc)
>> > > +                     usage_with_options(merge_tree_usage, mt_option=
s);
>> > > +     } else {
>> > > +             if (argc < 2 || argc > 3)
>> > > +                     usage_with_options(merge_tree_usage, mt_option=
s);
>> > > +             o.mode =3D (argc =3D=3D 2 ? 'w' : 't');
>> > > +     }
>> >
>> > Do we really need to make this interface more special-casey by
>> > auto-guessing based on argc what argument you want? I.e. instead of
>> > usage like:
>> >
>> >         N_("git merge-tree [--write-tree] <branch1> <branch2>"),
>> >         N_("git merge-tree [--trivial-merge] <base-tree> <branch1> <br=
anch2>"),
>> >
>> > Wouldn't it be simpler to just have the equivalent of:
>> >
>> >         # old
>> >         git merge-tree ...
>> >         # new
>> >         git merge-tree --new-thing ...
>> >
>> > And not have to look at ... to figure out if we're dispatching to the
>> > new or old thing.
>>
>> You seem to be focusing on code simplicity?  Sure, that'd be simpler
>> code, it'd just be a less useful feature.
>>
>> I think passing --write-tree all the time would be an annoyance.  I
>> don't see why anyone would ever use the other mode.  However, for as
>> long as both exist in the manual, it makes the manual easier to
>> explain to users, and example testcases more self-documenting by
>> having the flag there.  That's the sole purpose of the flag.
>>
>> I'm never going to actually use it when I invoke it from the command
>> line.  And I suspect most would leave it off.
>
> ...also, even if we did require the `--write-tree` flag, we'd still
> have to look at argc.  Since the option parsing handles both modes,
> someone could leave off --write-tree, but include a bunch of other
> options that only make sense with --write-tree.  Individually checking
> the setting of every extra flag along with write_tree is a royal pain
> and I don't want to repeat that for each new option added.  Simply
> checking argc allows you to provide an error message if the user does
> that.
>
> (And I think it's sad that in Git we often forgot to warn and notify
> users of options that are only functional with certain other
> arguments; it makes it harder for users to figure out, and has in the
> past even made it harder for other developers to figure out what was
> meant and how things are to be used.  I think I've seen multiple Git
> devs be confused over ls-files --directory and --no-empty-directory
> options, assuming they'd do something sensible for tracked files, when
> in fact those arguments are simply ignored because they are only
> modifiers for how untracked files are treated.)

There's a much simpler way to do what you're trying to do here which is
to only parse --write-tree, and as soon as you have that pass off two
one function or the other, and have those functions call
parse_options().

This is how builtin/{bundle,stash,commit-graph}.c etc. solve the same
problem. It avoids having to the sort of check you did in 09/15:

	+	if (o.mode =3D=3D 't' && original_argc < argc)
	+		die(_("--trivial-merge is incompatible with all other options"));

The builtin/submodule--helper.c then does it with a first argument that
--looks-like-an-option, but is really the same sort of sub-command
selector.

Which, at least for me brings this back to liking your merge-tree-ort
(or merge-tree-ng, merge-tree-new or whatever) better. I.e. both for the
code & manual we effectively have two completely different commands here
anyway. Splitting them up would make both the code simpler, and also
what we have to explain to users.

