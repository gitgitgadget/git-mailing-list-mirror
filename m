Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE80C433F5
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 01:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241776AbiBHBXJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Feb 2022 20:23:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241844AbiBHBWh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Feb 2022 20:22:37 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6223AC03CA4D
        for <git@vger.kernel.org>; Mon,  7 Feb 2022 17:18:30 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id qe15so5210679pjb.3
        for <git@vger.kernel.org>; Mon, 07 Feb 2022 17:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=etjFwJy+nHUNyJL0y3DC7h4VX3LKqUcj19jdYhoAxJE=;
        b=AcGPjH4YcA0Z5e66WpV/2z2pL9oQa48noemqHRXwvFmpl9OpJepsn+7QKO8X4+pkLy
         rV8NzawD9n1vz4xWOLRUkEhVqjA4xfMyGKnbWhXBXW7QGlKje+4rXFf5Q9MFDxWWCL4m
         +gZ38X/bvRC3KoRxpn5m8M+Z2nxVCG5LpgSiwOU2h6IPf9ddTp3G/+GtCx67qg+RPe00
         M38mw4t9qvHhui/7q9V3hhrg9JCFcLvH3uDgcdxch0VYuQwC/D2z/N7sHXdGLCpdvEkx
         itvaXW1wa6MhMOOLuNYsp2btdofdRNvDTjsu2rirPfX95fIHPl51BE0AO+gz7HCRW/Nh
         a1eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=etjFwJy+nHUNyJL0y3DC7h4VX3LKqUcj19jdYhoAxJE=;
        b=LiAwQipSvY9JHP0PpTZafiGfTQsQQt57OW5cbNu8ArvleiNEyEJ0I2YAFb6UBkIS4N
         O2L/vDpUvRRqujLS9ued9OpduxVXPggOEWFd6u5yuJYo0+oGAqB3Prnljx6fXENiJX0p
         tIkLr+/Mjy6T8DckzOVIHMKgQqDnoDjXv21wk89ktK/osC/Io/6ulM/65FP8bCna+srp
         jDQ46ZU7rFTLiQeXUxTARuNElwu5Q1Zmz5tRjE/6kVOqw5bHtvw12+Gm1aMykdYiHzs/
         Vi3F+VBEgkZ41Kr+kRSq7OlJAvZ3H5xh3/2OydFgvmB4+lFY8tZSfJpf+//gBlmA4DMP
         urIA==
X-Gm-Message-State: AOAM531loLslwX1s9etOuz48pZLGwpoLx4FphltLC1LfLWHYpCnK32oo
        E8E5/fqbDEvMYIZHQ/eVTBM=
X-Google-Smtp-Source: ABdhPJygKKSjlovcF2yjNOdfoFUF+XRUTu3es6C61thBdCDp93bAkG7wFYxvbjDqw96gQmRcnggm/w==
X-Received: by 2002:a17:902:f64a:: with SMTP id m10mr2043255plg.46.1644283109596;
        Mon, 07 Feb 2022 17:18:29 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:c3a3:275c:6d99:cf07])
        by smtp.gmail.com with ESMTPSA id m14sm13795015pfc.170.2022.02.07.17.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 17:18:29 -0800 (PST)
Date:   Mon, 7 Feb 2022 17:18:26 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
        Albert Cui <albertcui@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Jacob Keller <jacob.keller@gmail.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v6 0/5] teach submodules to know they're submodules
Message-ID: <YgHE4iaV8QHRw64U@google.com>
References: <20211117005701.371808-1-emilyshaffer@google.com>
 <20220203215914.683922-1-emilyshaffer@google.com>
 <220204.86pmo34d2m.gmgdl@evledraar.gmail.com>
 <YgF5V2Y0Btr8B4cd@google.com>
 <xmqqk0e6gt5j.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqk0e6gt5j.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> Here's a few examples:
>>
>> 1. Suppose I track my $HOME directory as a git repository.  Within my
>>    home directory, I have a src/git/ subdirectory with a clone of
>>    git.git, but I never intended to treat this as a submodule.
>>
>>    If I run "git rev-parse --show-superproject-working-tree", then it
>>    will discover my home directory repository, run ls-files in there
>>    to see if it has GITLINK entries, and either see one for src/git if
>>    I had "git add"ed it by mistake or not see one.  In either case,
>>    it would it would view my src/git/ directory as being a submodule
>>    of my home directory even though I hadn't intended it to be so.
>
> I am not sure about this one.  If you added an unrelated one with
> "git add" by mistake, you'd want to know about the mistake sooner
> rather than later, no?

My point with this example is that it's useful to have a definition of
what is a submodule repository, to make it unambiguous whether this
repository is a submodule or whether it's just a repository that
happens to have been cloned inside of a git-managed worktree.

For the specific example of having run "git add", I don't have any
very strong opinions.

[...]
>> 2. Suppose I have a copy of a repository such as
>>    https://gerrit.googlesource.com/gerrit/, with all its submodules.
>>    I am in the plugins/replication/ directory.
[...]
>>                         So for example, if I had run "git rm --cached
>>    plugins/replication" to _prepare to_ remove the plugins/replication
>>    submodule, then "git rev-parse --show-superproject-working-tree"
>>    will produce the wrong result.
>
> Yes, looking only at the index of the superproject will have that
> problem, but don't other things in the superproject point at the
> submodule, too, e.g. submodule.<name>.* configuration variables?

What all of those suggested alternatives have in common is that they
are pointers from another repository to the submodule.

This would be the first time in git history that we are saying a
property of a repository depends on having to examine files outside of
it.  I guess the main question I'd have is, why _wouldn't_ I want a
submodule to be able to point to the superproject containing it?  I
can think of many advantages to having that linkage, and the main
disadvantage I can think of is that it is a change.

I don't think that submodule.<name>.* is an adequate substitute for
having this setting, because it requires
- finding the superproject
- mapping the <name> to a path, using .gitmodules
- comparing the path to the submodule location

which would be complex, slow, and error-prone.

The one thing that I think could approach being an adequate substitute
is examining the path to the current repository and stripping off path
components until we find modules/; then the parent is the containing
superproject.  That would only work for absorbed submodules, though,
and it would be less explicit than having a config item.

> And then, after removing them to truly dissociate the submodule from
> the superproject, "git rev-parse --show-superproject-working-tree"
> may stop saying that it is a submodule, but this series wants to
> make it irrelevant what the command says.  Until you unset the
> configuration variable in the submodule, it will stay to be a
> submodule of the superproject, but the superproject no longer thinks
> it is responsible for the submodule.  You'll have to deal with an
> inconsistent state during the transition either way, so I am not
> sure it is the best solution to introduce an extra setting that can
> easily go out of sync.

This hints at a reason why one wouldn't want the linkage back ---
dealing with the ambiguity of inconsistencies (what if a submodule
declares a superproject but the superproject does not declare the
submodule?).

I would not expect that ambiguity to be much of a problem,
because the typical way to use superproject linkage would be to
print output from commands like "git status": for example,

	This is a submodule of ../../gerrit; you can run

		git -C ../../gerrit status

	to get the status of the superproject.

An inconsistency could occur due to the user using "mv" (instead of
"git mv") to move a submodule to a path a different number of path
components from its superproject.  One way to handle that would be to
make submodules record a boolean setting reflecting whether they are a
submodule, instead of the path to the superproject.  (This would be
similar to settings like core.bare.)  Alternatively, if the path to
the superproject is recorded and if "git fsck" is able to notice such
an inconsistency, then the user should be able to have an okay
experience repairing it.

[...]
>>    If "git status" runs "git rev-parse
>>    --show-superproject-working-tree", then git would walk up the
>>    filesystem above my mawk/ directory, looking for another .git dir.
>>    We can reach an NFS automounter directory and just hang.  Even
>>    without an NFS automounter, we'd expect this to take a while
>>    because, unlike normal repository discovery, we have no reason to
>>    believe that the walk is going to quickly discover a .git directory
>>    and terminate.  So this would violate user expectations.
>
> It would be a problem, but I do not know if "this is a submodule of
> that superproject" link is the only solution, let alone the most
> effective one.  It seems to me that you are looking more for
> something like GIT_CEILING_DIRECTORIES.

Who is the "you" addressed here?  The end user can use
GIT_CEILING_DIRECTORIES if they are expecting to run git commands
within an NFS automounter directory and outside of any git repository,
but they'd be right to be surprised if that suddenly became required
when inside git repositories.  I don't think we should assume that
running an extra .git discovery walk is cost-free to users who are not
using submodules and an acceptable burden to impose on them for the
sake of submodule users.

Thanks and hope that helps,
Jonathan
