Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F16CC433E1
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 18:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23440206EB
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 18:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmcG/Dnh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405752AbgFXSDv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Jun 2020 14:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405002AbgFXSDt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jun 2020 14:03:49 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECFFC061573
        for <git@vger.kernel.org>; Wed, 24 Jun 2020 11:03:47 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id a9so3587307ljn.6
        for <git@vger.kernel.org>; Wed, 24 Jun 2020 11:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=UqPmbr3UmNpKkJLZxQuhm2qwhXm54TUlQDn9K+VqXjs=;
        b=cmcG/DnhwVEXA78KWlTAMekT6RJhg7RNd6S9jjsV1MytAv1yWNhaboYLOWqYA2NOJF
         VdeWSEpCd43VnP9MN0ogIcHBggCiyY7JnDzChcVNcM2UMT0hEuYVUnjhXfzX0Fq7pDfe
         6ccmh7riA4Y9+kroORod/0za+JM5Uf7uQEuaUX5YOth0qnRjciHh6IjHpvnthzozM1hN
         jQmksGL+ytIbmnOnvUEjbmCbcCeKMqOK+s6bF0pFXREfWxAtag+vX8IzBnSvgeiFzhKw
         GYGTG4jx6fz1v/PW5OqqVYqdn54ifm0CdGdnDD7S7n6F+WeKgOUEOcoCGJhPjgJYbcKn
         viSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=UqPmbr3UmNpKkJLZxQuhm2qwhXm54TUlQDn9K+VqXjs=;
        b=FFTAF0zzclwXxAEYORBNM70TaaNqBA84+Tb/krwoTCiLU0qpXFm3Ed7bHFmeCeo0uh
         mHAaEls6KKI57Wnz1owhId9mAdxDKNfm2VWaQ9OUDN8TfDFq7bhhgEJMVLvJwvVP4SHc
         jRTdhxUBB/ShZZ4U7jUdWQm2cRMRjFYi/Nb/pOeNzQcjdz7fSTOj5jjFliuD1hKHcTso
         wjaBBg2pqcQHTgf4J2pDbIa9LlT49DoM1GNCs+//1Ex4r/0NoivblIqTzl/TYGzDib+B
         mS2oTmv60xpoatwLN2sz6JonQ1kW3X0CE7dHqY4pGs8bCZlfhy0WQJa/NCUIyO2OpXwc
         +USg==
X-Gm-Message-State: AOAM5322vnPJhVqbSvXjYygJKJgOwDKwqwaQUqsB74eRB55fQsRgW80L
        pkYp2rEnO0d+Z7VMGYArkU8905zT
X-Google-Smtp-Source: ABdhPJyMozcuUYRJ9foTo/LECFVNdXWiWaDPm5kbGjkVFM3A9vjwE2l/x8KOtRqOdybkb1G6HDnx0A==
X-Received: by 2002:a2e:9786:: with SMTP id y6mr13930474lji.398.1593021825148;
        Wed, 24 Jun 2020 11:03:45 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id r25sm2494004lfi.70.2020.06.24.11.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 11:03:43 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Tiran Meltser <Tiran.Meltser@mavenir.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Amir Yosef <Amir.Yosef@mavenir.com>
Subject: Re: Request for adding a simple mechanism to exclude files from Git
 merge operation
References: <DM6PR11MB27958B80E3994CEEF13971ECE5990@DM6PR11MB2795.namprd11.prod.outlook.com>
        <20200622194122.GN6531@camp.crustytoothpaste.net>
        <871rm6x86y.fsf@osv.gnss.ru>
        <CABPp-BHa=jppGtoDiTz_NCXrd2zhTfALb_UrQjcF-VDcv+vuNA@mail.gmail.com>
        <xmqqk0zxbe6f.fsf@gitster.c.googlers.com>
Date:   Wed, 24 Jun 2020 21:03:42 +0300
In-Reply-To: <xmqqk0zxbe6f.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 23 Jun 2020 15:38:48 -0700")
Message-ID: <87k0zw1gu9.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Elijah Newren <newren@gmail.com> writes:
>
>> I think you'd have an uphill battle to convince me that this isn't
>> net-negative value:
>
>>   * You can just do "git merge --no-commit ...; git restore ...
>
>>   * The "ours" vs. "theirs" wording means you're going to ...
>
>>   * The pathspec limiting is going to be a bug factory ...
>
>>   * I've run into "branch-specific" files in the wild and even
>> supported repositories that used them for years.  In my opinion, they
>> are almost always nasty code smells that are artifacts from
>> CVS/SVN-like thinking.  Although I wanted to stamp them out
>> immediately, there was opposition to it.  However, over time, people
>> removed those branch-specific files from the repository (and it wasn't
>> just by me or at my prodding either; many were cleaned away by others
>> without my involvement as other folks just found better ways to handle
>> things over time).  Giving special support to bad practices will just
>> enshrine them, which I'd rather avoid.
>
> Also if you consider what would happen to future merges after making
> such a half-merge, you would not recommend it, whether with an even
> easier "feature" to encourage a bad workflow or with existing tools.
>
> Every time you create a commit (be it a single parent commit or a
> merge commit with multiple parents), you are making this statement:
>
>     Where the histories leading to the parent commits want to go
>     aligns with my goal, and with this commit, I am extending their
>     effort to get us even closer to our shared goal.
>
> After a side branch forked and worked on two parts of the system (A
> and B) while the mainline did not do anything to these two parts but
> worked on other parts, you look at the histories (not just the trees
> of tip commits) leading to the current mainline and the tip of the
> side branch, convince yourself that you agree with both of the
> changes the side branch made to A and B, and because the mainline
> left these two parts intact, you take their changes wholesale and
> record the result in a merge commit.  Because you also made sure all
> the other developments happened while the side branch forked took
> you closer to your goal, you too them too, so the resulting merge
> commit records a tree that is closer to either of its parents to
> your goal.
>
> And readers cannot dismiss this fact as mere philosophy; it is
> fundamental and ingrained in the behaviour of Git tools,
> specifically how three-way merge works.
>
> Once you dismiss a part of what a side branch did as irrelevant by
> taking "our" version for selected paths in a merge, the goal you had
> when you made the merge will no longer align with the goal the folks
> who worked on the side branch had.  Perhaps you only took changes to
> the A part and discarded changes to the B part they made, because it
> suited your goal better.  Now after the folks who care about both
> parts further work on part A and B, you may try to merge their work
> into the updated mainline (whose history contains the declaration
> you made earlier that the work did on the B part made up to the
> point you made the earlier merge is worthless).  The new merge will
> use the older tip of the side branch that was partially merged with
> the old merge as the merge base and will consider what was done on
> the side branch (which would contain changes to both A and B---after
> all they care about both A and B).  This mismatch will either cause
> heavy conflicts in part B, or (worse yet) silent mismerges.

What is suggested is exactly a way to deal with heavy merge conflicts in
the first place, in particular, in the example you use, by telling git
that we are not interested in the side-changes in a given set of files.
Never.

If we change our mind later, we will simply need to start merging from
the point before that old, now rendered wrong, decision took place.

OTOH, if one tries to abuse the feature for different purposes, it will
hurt sooner than later, no questions.

>
> So in short, sure, you can use the existing machinery, or invent a
> new "easier" machinery, to create and record such a half-merge, and
> you may declare victory after creating your first such merge.  But
> you left a disaster for future merges from the same side branch by
> doing so.

I think I at least understand most of what you said, except I wasn't
able to figure what the definition of "half-merge", or "partial merge"
is.

To clarify, could you please tell if plain

   git merge -s ours

is a "partial merge" from your point of view?

If you think it is not, then what about:

  git merge -X ours

? Is it a "partial merge"?

Thanks,
-- Sergey
