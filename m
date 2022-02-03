Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F06FC433EF
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 10:29:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345157AbiBCK3o (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 05:29:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344934AbiBCK3o (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 05:29:44 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271D1C061714
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 02:29:44 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id k25so7180387ejp.5
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 02:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=YbicwmIG963n9SVR7unVr5RYV6ymQGRpV6nlG9D0SFU=;
        b=H1rmU+bmGQGcUot5EIt1JTa60KGohpV02NNRl9vXPwy8r6hDdUeVHglpSVU5AglJ9l
         y1Uohk512uqV9RbG1uPzJo3o2GCiCGdE014no7teQ1y+zUfUNSj2l4WogNxKutSyZpR8
         0MQMXG3nDWLaMN02hB5FYbjqzl2Rdo1uox9eO2AkjrAJUiguZDxWAaQAQhROiv4H3iwm
         6hC68Vlz9bBQMt2AaWI0q9qjKKuFO1KTOuvB97riL4hopdb35C2dHusmG/4X7Fmdr/+n
         YquxT4Vq5q2ehQmmbjPIZG6yXTpOIT5vhOo66NB8srJygWDyjYhvoKdx87Igr8L+SN5r
         /ZUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=YbicwmIG963n9SVR7unVr5RYV6ymQGRpV6nlG9D0SFU=;
        b=Q1zFLKp0hIfgjWmuvqtF3+2f0U2XtIHyiWSrVpG0LFg65tjLvo41rbPm57isR6NOrS
         lq91OjzZWHPg8YwXs9o7dC1btSkfXVLwMmD2Ie8pUytW+Pp4aPlsMgQPY5mjLCoFvcuq
         t9K+QemTBh6JA8/vZsTedukDpu7aEkOju7mY2Qvbj22TRtZRdmYonf6ewBevoL6lzcVV
         y6T0lUgNTHR5IwfyOvW/GHXX5xUKRxB1RwvISRCYMGXr86pryH2znu+ZpAoutA+5htGS
         VuY/XargxGskefp/9R6afpG9bXMw7S7UT3I7T5Vv3Y8Lz1O7cVWjTRxkO01aFFKr1Rx6
         wPGw==
X-Gm-Message-State: AOAM533OQ79ZdhO87vUK1DPz1+u+zFlHqhRaBYddmPQZ6GKLDKKcFtZV
        dHr/uZZ9nz8EvTMb/p4qq+R9Y66nx9+mUg==
X-Google-Smtp-Source: ABdhPJyWdS649VqRNTMMzTqIRhOrVY23v0p+HnjBZi8hJFYK6QJ2TMLD+m+G3w2Gne+yZWWRLBd6Jw==
X-Received: by 2002:a17:907:948f:: with SMTP id dm15mr28839193ejc.52.1643884182409;
        Thu, 03 Feb 2022 02:29:42 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id z18sm16645754ejb.112.2022.02.03.02.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 02:29:41 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nFZMz-004wQl-13;
        Thu, 03 Feb 2022 11:29:41 +0100
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
Date:   Thu, 03 Feb 2022 11:26:27 +0100
References: <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
 <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com>
 <63f42df21aec5bda50e4414493eb59dcb64e5558.1643787281.git.gitgitgadget@gmail.com>
 <220203.86a6f87lbl.gmgdl@evledraar.gmail.com>
 <CABPp-BHKZnmaq3NM5_D6pwkw2+91EsdJ-uqjfFPBYiUSE28k1g@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <CABPp-BHKZnmaq3NM5_D6pwkw2+91EsdJ-uqjfFPBYiUSE28k1g@mail.gmail.com>
Message-ID: <220203.86k0ec5jl7.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 03 2022, Elijah Newren wrote:

> On Wed, Feb 2, 2022 at 6:09 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <av=
arab@gmail.com> wrote:
>>
>> On Wed, Feb 02 2022, Elijah Newren via GitGitGadget wrote:
>>
>> > From: Elijah Newren <newren@gmail.com>
>> >
>> > Let merge-tree accept a `--write-tree` parameter for choosing real
>> > merges instead of trivial merges, and accept an optional
>> > `--trivial-merge` option to get the traditional behavior.  Note that
>> > these accept different numbers of arguments, though, so these names
>> > need not actually be used.
>>
>> Maybe that ship has sailed, but just my 0.02: I thought this whole thing
>> was much less confusing with your initial merge-tree-ort proposal at
>> https://lore.kernel.org/git/CABPp-BEeBpJoU4yXdfA6vRAYVAUbd2gRhEV6j4VEqoq=
cu=3DFGSw@mail.gmail.com/;
>> I.e. the end-state of merge-tree.c is that you end up reading largely
>> unrelated code (various static functions only used by one side or
>> another).
>
> Christian's merge-tree-ort proposal?

Yes. I'm clearly getting the chronology wrong here. Sorry.

>> But maybe that's all water under the bridge etc, however...
>>
>> >  int cmd_merge_tree(int argc, const char **argv, const char *prefix)
>> >  {
>> > -     if (argc !=3D 4)
>> > -             usage(merge_tree_usage);
>> > -     return trivial_merge(argc, argv);
>> > +     struct merge_tree_options o =3D { 0 };
>> > +     int expected_remaining_argc;
>> > +
>> > +     const char * const merge_tree_usage[] =3D {
>> > +             N_("git merge-tree [--write-tree] <branch1> <branch2>"),
>> > +             N_("git merge-tree [--trivial-merge] <base-tree> <branch=
1> <branch2>"),
>> > +             NULL
>> > +     };
>> > +     struct option mt_options[] =3D {
>> > +             OPT_CMDMODE(0, "write-tree", &o.mode,
>> > +                         N_("do a real merge instead of a trivial mer=
ge"),
>> > +                         'w'),
>> > +             OPT_CMDMODE(0, "trivial-merge", &o.mode,
>> > +                         N_("do a trivial merge only"), 't'),
>> > +             OPT_END()
>> > +     };
>> > +
>> > +     /* Parse arguments */
>> > +     argc =3D parse_options(argc, argv, prefix, mt_options,
>> > +                          merge_tree_usage, PARSE_OPT_STOP_AT_NON_OPT=
ION);
>> > +     if (o.mode) {
>> > +             expected_remaining_argc =3D (o.mode =3D=3D 'w' ? 2 : 3);
>> > +             if (argc !=3D expected_remaining_argc)
>> > +                     usage_with_options(merge_tree_usage, mt_options);
>> > +     } else {
>> > +             if (argc < 2 || argc > 3)
>> > +                     usage_with_options(merge_tree_usage, mt_options);
>> > +             o.mode =3D (argc =3D=3D 2 ? 'w' : 't');
>> > +     }
>>
>> Do we really need to make this interface more special-casey by
>> auto-guessing based on argc what argument you want? I.e. instead of
>> usage like:
>>
>>         N_("git merge-tree [--write-tree] <branch1> <branch2>"),
>>         N_("git merge-tree [--trivial-merge] <base-tree> <branch1> <bran=
ch2>"),
>>
>> Wouldn't it be simpler to just have the equivalent of:
>>
>>         # old
>>         git merge-tree ...
>>         # new
>>         git merge-tree --new-thing ...
>>
>> And not have to look at ... to figure out if we're dispatching to the
>> new or old thing.
>
> You seem to be focusing on code simplicity?  Sure, that'd be simpler
> code, it'd just be a less useful feature.
>
> I think passing --write-tree all the time would be an annoyance.  I
> don't see why anyone would ever use the other mode.  However, for as
> long as both exist in the manual, it makes the manual easier to
> explain to users, and example testcases more self-documenting by
> having the flag there.  That's the sole purpose of the flag.
>
> I'm never going to actually use it when I invoke it from the command
> line.  And I suspect most would leave it off.

I think I mostly covered this in
https://lore.kernel.org/git/220203.86wnic5lba.gmgdl@evledraar.gmail.com/
in the side-thread.

I'm not opposed to them being in the same command, it just seems like
more work for those reasons in every way.

E.g. the current manual page doesn't really describe the format the
--trivial-merge emits, so we could do with a section on that, but then
it would say "only for this option, not the other" etc.
