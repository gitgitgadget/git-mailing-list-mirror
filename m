Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04730C433E0
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 22:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD3C52078A
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 22:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="EUtbG+Ng"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387747AbgFWWny (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 18:43:54 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54055 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387666AbgFWWny (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 18:43:54 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 066A6D1F51;
        Tue, 23 Jun 2020 18:38:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Q7pERj63WSTb63PrdDZht82N+Go=; b=EUtbG+
        Ng+cs+O6T4LQZzOwgjAbYyWdZJ0eVehtdupCKytQiFVUWElWDZcdsGJB8Qgwt3dT
        leieDPZ+4TbCfpcjc27l1Q+sP64iG8TsYIYRAWjD+nDlpAkT6JGGhKMxj/TMPSDo
        sIaNQVN1QDYpkEClEi924lukJZE9IU5XGaygk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WvfGZm+I0leDaW1HGh6mPPm7dfkvmVVv
        BZcwpWaN/d8Cjd1eo2k8AdtH286uu2b3HsWY5h7wpSLRp1j/VTf/WZTg5ppyZsA0
        MX8hmWD5TpUgttQAA71PsSqNHwdkU8NPZCs1UzrZodM1r2cwgj6mMzetJFqnMf7Z
        fxeRXIUhtA0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F1C0ED1F50;
        Tue, 23 Jun 2020 18:38:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 45EE7D1F4F;
        Tue, 23 Jun 2020 18:38:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Sergey Organov <sorganov@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Tiran Meltser <Tiran.Meltser@mavenir.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Amir Yosef <Amir.Yosef@mavenir.com>
Subject: Re: Request for adding a simple mechanism to exclude files from Git merge operation
References: <DM6PR11MB27958B80E3994CEEF13971ECE5990@DM6PR11MB2795.namprd11.prod.outlook.com>
        <20200622194122.GN6531@camp.crustytoothpaste.net>
        <871rm6x86y.fsf@osv.gnss.ru>
        <CABPp-BHa=jppGtoDiTz_NCXrd2zhTfALb_UrQjcF-VDcv+vuNA@mail.gmail.com>
Date:   Tue, 23 Jun 2020 15:38:48 -0700
In-Reply-To: <CABPp-BHa=jppGtoDiTz_NCXrd2zhTfALb_UrQjcF-VDcv+vuNA@mail.gmail.com>
        (Elijah Newren's message of "Tue, 23 Jun 2020 10:08:30 -0700")
Message-ID: <xmqqk0zxbe6f.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4F014436-B5A2-11EA-A4C7-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> I think you'd have an uphill battle to convince me that this isn't
> net-negative value:

>   * You can just do "git merge --no-commit ...; git restore ...

>   * The "ours" vs. "theirs" wording means you're going to ...

>   * The pathspec limiting is going to be a bug factory ...

>   * I've run into "branch-specific" files in the wild and even
> supported repositories that used them for years.  In my opinion, they
> are almost always nasty code smells that are artifacts from
> CVS/SVN-like thinking.  Although I wanted to stamp them out
> immediately, there was opposition to it.  However, over time, people
> removed those branch-specific files from the repository (and it wasn't
> just by me or at my prodding either; many were cleaned away by others
> without my involvement as other folks just found better ways to handle
> things over time).  Giving special support to bad practices will just
> enshrine them, which I'd rather avoid.

Also if you consider what would happen to future merges after making
such a half-merge, you would not recommend it, whether with an even
easier "feature" to encourage a bad workflow or with existing tools.

Every time you create a commit (be it a single parent commit or a
merge commit with multiple parents), you are making this statement:

    Where the histories leading to the parent commits want to go
    aligns with my goal, and with this commit, I am extending their
    effort to get us even closer to our shared goal.

After a side branch forked and worked on two parts of the system (A
and B) while the mainline did not do anything to these two parts but
worked on other parts, you look at the histories (not just the trees
of tip commits) leading to the current mainline and the tip of the
side branch, convince yourself that you agree with both of the
changes the side branch made to A and B, and because the mainline
left these two parts intact, you take their changes wholesale and
record the result in a merge commit.  Because you also made sure all
the other developments happened while the side branch forked took
you closer to your goal, you too them too, so the resulting merge
commit records a tree that is closer to either of its parents to
your goal.

And readers cannot dismiss this fact as mere philosophy; it is
fundamental and ingrained in the behaviour of Git tools,
specifically how three-way merge works.

Once you dismiss a part of what a side branch did as irrelevant by
taking "our" version for selected paths in a merge, the goal you had
when you made the merge will no longer align with the goal the folks
who worked on the side branch had.  Perhaps you only took changes to
the A part and discarded changes to the B part they made, because it
suited your goal better.  Now after the folks who care about both
parts further work on part A and B, you may try to merge their work
into the updated mainline (whose history contains the declaration
you made earlier that the work did on the B part made up to the
point you made the earlier merge is worthless).  The new merge will
use the older tip of the side branch that was partially merged with
the old merge as the merge base and will consider what was done on
the side branch (which would contain changes to both A and B---after
all they care about both A and B).  This mismatch will either cause
heavy conflicts in part B, or (worse yet) silent mismerges.

So in short, sure, you can use the existing machinery, or invent a
new "easier" machinery, to create and record such a half-merge, and
you may declare victory after creating your first such merge.  But
you left a disaster for future merges from the same side branch by
doing so.

As to handling configuration files, what you and Brian mentioned to
keep recommended template(s) in-tree and have the build procedure
copy it out and keeping the customization out of merge is the BCP.
We shouldn't butcher the tool and make it even easier to use a bad
workflow, as you said.

Thanks.

