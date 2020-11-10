Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF25C56202
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 23:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DE59207E8
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 23:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bypyHlHF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732023AbgKJXw3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 18:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbgKJXw1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 18:52:27 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E785C0613D1
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 15:52:26 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id j205so656787lfj.6
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 15:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=BD4/QRjYTYpjrKQgSgUOrWR8CTAyBf9fIxmS9SFo+AY=;
        b=bypyHlHF2LC7Hk1ovtDyMKOPF+M6eaT0DXTaHm0/nRc0MtIPnuv31RpaUmKhoYcp4A
         ePtYziuGZ4siURzQGoIyywpAbBz4X0iO/T2PysWjvBe5yYEpK3cV+jcTtkM67wgyaCgN
         M17bQ8C0ua2NMSy01QHRFPWjJDT191Qcq+ij6t5LhaWHBTKHeDos2XPBhanCf4Fn1uOE
         SRjTGzFquCgh7wBYm2IisCdj5RGRH/LLKQiGRIMzPeowza30Co+eh/ojKgUfph7Z86K0
         Idbz/a62Z1beY57b821hvUzfxdYvJu/I0Cas3XFU4gpUFRhiMbfpYIf9vY6T0U9C5Vas
         iwpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=BD4/QRjYTYpjrKQgSgUOrWR8CTAyBf9fIxmS9SFo+AY=;
        b=hREDo5vW4VTbCeWbBCdhHx8K8MFzzwUTsMIOrtgmQI3u26X9mDd/YK8p+6mBwsCjUL
         vUW2ZvWf3cxX9JJ6fDm24a3O/GK5BIAF00wlmNfYE88T3jZPHNvVlrN7exyjkYGPTzT5
         8CC3WWmdCF7NTSaPdl660u/PEQY46M+3GnKGChqLtAym0tGvVSThGVP4Wvb1JuXyyqHq
         32hGsvjWZyLlBe4o+qOUe65yn5aDVMINCe19QX4TVfeD5Pg41A3XrdmemS/KXkIhU/DH
         N/av1s1matL3BrgrvMYqv2uT0DUKxlnkufAk5dcDPnDvnwOGycKVKrIBjp6WdtZ+mSQ4
         EP2g==
X-Gm-Message-State: AOAM533dvMGUDMu8AdtFsmyRtKzFmPLi75RKEviGlRP2pXAyS1ZF2a/C
        qUL2d0Gy+2DwAIV8VCyVLi5SqcC4sntSSOzu
X-Google-Smtp-Source: ABdhPJzj18YkrzRoar3xt90bLUf5IOMNlmlfSAfG0stmW4p9+z73cnvZ2lhbzMLjn2LweqCjd4twqQ==
X-Received: by 2002:a19:197:: with SMTP id 145mr7791607lfb.483.1605052323938;
        Tue, 10 Nov 2020 15:52:03 -0800 (PST)
Received: from LAPTOP-ACER-ASPIRE-F5 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id 187sm40691lfl.117.2020.11.10.15.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 15:52:03 -0800 (PST)
From:   jnareb@gmail.com (Jakub =?utf-8?Q?Nar=C4=99bski?=)
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        git@vger.kernel.org,
        Abhishek Kumar via GitGitGadget <gitgitgadget@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: Extending and updating gitglossary
References: <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
        <pull.676.v4.git.1602079785.gitgitgadget@gmail.com>
        <694ef1ec08d9dc96a74a2631b2710ad206397dbc.1602079786.git.gitgitgadget@gmail.com>
        <85r1pjzejg.fsf@gmail.com> <20201103114432.GA3577@Abhishek-Arch>
        <85pn4tnk8u.fsf@gmail.com>
        <efa3488a-3983-3435-e5e4-2eb71e76a33a@iee.email>
        <xmqqtuu3k6jf.fsf@gitster.c.googlers.com> <85zh3ujq9c.fsf_-_@gmail.com>
        <8d43335d-a0b4-511e-f132-057343234503@iee.email>
        <85imaej8nh.fsf@gmail.com>
        <8b6d49e3-fdb8-ce63-650e-c937a2da2c7a@iee.email>
Date:   Wed, 11 Nov 2020 00:52:02 +0100
In-Reply-To: <8b6d49e3-fdb8-ce63-650e-c937a2da2c7a@iee.email> (Philip Oakley's
        message of "Tue, 10 Nov 2020 14:04:23 +0000")
Message-ID: <85v9ecixct.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Philip,

Philip Oakley <philipoakley@iee.email> writes:
> On 10/11/2020 01:35, Jakub Nar=C4=99bski wrote:
>> Philip Oakley <philipoakley@iee.email> writes:
>>> On 06/11/2020 18:26, Jakub Nar=C4=99bski wrote:
>>>> Junio C Hamano <gitster@pobox.com> writes:
>>>>> Philip Oakley <philipoakley@iee.email> writes:
>>>>>
>>>>>> This may be not part of the the main project, but could you consider=
, if
>>>>>> time permits, also adding some entries into the Git Glossary (`git h=
elp
>>>>>> glossary`) for the various terms we are using here and elsewhere, e.=
g.
>>>>>> 'topological levels', 'generation number', 'corrected commit date' (=
and
>>>>>> its fancy technical name for the use of date heuristics e.g. the
>>>>>> 'chronological ordering';).
>>>>>>
>>>>>> The glossary can provide a reference, once the issues are resolved. =
The
>>>>>> History Simplification and Commit Ordering section of git-log maybe a
>>>>>> useful guide to some of the terms that would link to the glossary.
[...]
>> What terms you feel need glossary entry?
>
> While it was Junio that made the comment, I'd agree that we should be
> using the glossary to explain, in a general sense, the terms that are
> used is a specialist sense. As the user community expands, their natural
> understanding of some of the terms diminishes.

I was hoping for a list of terms from the abovementioned sections of
git-log manpage you feel need entry in gitglosary(7).

[...]
>> To be more precise, I think that user-facing glossary should include
>> only terms that appear in user-facing documentation and in output
>> messages of Git commands (with the possible exception of maybe output
>> messages of some low-level plumbing).
>
> And where implied, the underlying concepts when they aren't obvious, or
> lack general terms (e.g. the 'staging area' discussions)

True, 'staging area' should IMVHO be in glossary (replacing or in
addition to older less specific term 'index', previous name for 'staging
area' term).

>> I think that the developer-facing glossary should include terms that
>> appear in technical documentation, and in commit messages in Git
>> history.

Such as 'topological levels', 'commit slab' / 'on the slab', etc.

>>> However we do mention "topolog*"=C2=A0 in a number of the manual pages,=
 and
>>> rather less, as yet, in the technical pages.
>>>
>>> "Lexicographic" and "chronological" are in the same group of fancy
>>> technical words ;-)
>>
>> I think that 'topological level' would appear only in technical
>> documentation; if it would be the case then there is no reason to add it
>> to user-facing glossary (to gitglossary manpage).
>>
>> 'Topological order' or 'topological sort', 'lexicographical order' and
>> 'chronological order' are not Git-specific terms, and there are no
>> Git-specific ambiguities.  I am therefore a bit unsure about adding them
>> to *Git* glossary.
>
> It is that they aren't terms used in normal speech, so many folks do not
> comprehend the implied precision that the docs assume, nor the problems
> they may hide.

Right.

>> - In computer science, a _topological sort_ or _topological_ ordering of
>>   a directed graph is a linear ordering of its vertices such that for
>>   every directed edge uv from vertex u to vertex v, u comes before v in
>>   the ordering.
>
> Does this imply that those who aren't computer scientists shouldn't be
> using Git?

I think that in most cases where we refer to topological order in the
documentation we describe it there.  It might be good idea to add it to
the glossary, especially because Git uses it often in a very specific
sense.

On the other hand, should we define 'topology' or 'graph' as well? Or
'glossary' ;-) ? Those don't have any special meaning in Git, and can be
as well found in the dictionary or Wikipedia.

>>   For Git it means that top to bottom, commits always appear before
>>   their parents. With `--graph` or `--topo-order` Git also avoids
>>   showing commits on multiple lines of history intermixed.
>>
>> - In mathematics, the _lexicographic_ or _lexicographical order_ (also
>>   known as lexical order, dictionary order, etc.) is a generalization of
>>   the alphabetical order.
>>
>>   For Git it is simply alphabetical order.=20
>
> ASCII order, Case sensitivity, Special characters, etc.

Actually I don't know. Let me check: the only place this term appears in
the documentation is in git-tag(1) manpage and related documentation.
It simplly uses strcmp(), or strcasecmp() when using `--ignore-case`
option; so by default case sensitive.

It looks like it does not take locale-specific rules.

>> - _Chronological order_ is the arrangement of things following one after
>>   another in time; or in other words date order.
>
> Given that most r=C3=A9sum=C3=A9s (the thing most folk see that asks for =
date
> order) is latest first, does this clarify which way chronological is? (I
> see this regularly in my other volunteer work).

Right, it might be not obvious at first glance that Git outputs most
recent commits first, that is newest commits are on top. Though if you
think about it in more detail, it is the only ordering that makes sense,
especially for projects with a long history; first, it is newest commits
that are most interesting, and second Git always walks the history from
child to parent.

>>   Note that `git log --date-order` commits also always appear before
>>   their parents, but otherwise commits are shown in the commit timestamp
>>   order (committer date order)

[...]
>>> Git does rip up most of what folks think about version "control",
>>> usually based on the imperfect replication of physical artefacts.
>>
>> I don't quite understand what you wanted to say there.  Could you
>> explain in more detail, please?
>
> Background, I see Git & Version Control from an engineers view point,
> rather than developers view.
>
> In the "real" world there are no perfect copies, we serialise key items
> so that we can track their degradation, and replace them when required.
> We attempt to "Control" what is happening. Our documentation and
> monitoring systems have layers of control to ensure only suitably
> qualified persons may access and inspect critical items, can record and
> access previous status reports, etc. There is only one "Mona Lisa", with
> critical access controls, even though there are 'copies'
> https://en.wikipedia.org/wiki/Mona_Lisa#Early_versions_and_copies.
> Almost all of our terminology for configuration control comes from the
> 'real' world, i.e. pre-modern computing.
>
> Git turns all that on its head. We can make perfect duplicates (they're
> not copies, not replicas..). The Object name is immutable. It's either
> right or wrong (exempt the SHAttered sha-1 breakage; were moving to
> sha-256). Git does *not* provide any access control. It supports the
> 'software freedoms' by distributing the control to the user. The
> repository is a version storage system, and the OIDs allow easy
> authentication between folks that they are looking at the same object,
> and all its implied descendants.
>
> Git has ripped up classical 'real' world version control. In many areas
> we need new or alternative terms, and documents that explain them to
> screen writers(*) and the many other non CS-major users of Git (and some
> engineers;-)
>
> (*) there's a diff pattern for them, IIRC, or at least one was proposed.

Right, though for me the concept of 'version control' was by default
always about the digital, usually the source code.

There are different editions of books, changes to non-digital technical
drawings and plans (AFAIK often in the form of physical foil overlays as
subsequent layers, if done well; overdrawing on the same layer if not),
amendment and changes to laws, etc.


Anyway, the question is what level of knowledge can we assume from the
average Git user -- this would affect the spread of terms that should be
considered for the Git glossary.

Best,
--=20
Jakub Nar=C4=99bski
