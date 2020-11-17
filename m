Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4C4C63777
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 22:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F31224699
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 22:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lw9j3esg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729382AbgKQWzu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 17:55:50 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55828 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbgKQWzu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 17:55:50 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 29BB992EFA;
        Tue, 17 Nov 2020 17:55:48 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Psp1QS3IfYKMHzQbE71imR5blYw=; b=lw9j3e
        sgAlj1tsoHCFMMm5bF0njckGzOoOKcHLAw6bWYPIS5Gqb9ao1Br2KKQIbhO4PbFD
        +vKUSEuLrGvnInDwwkvetedlfx4ssWQIhLLefYA3A9j6hsMfE3Cz4Jkb6QZt4h7u
        PyQE78ajIrh561VMgFY+i+S4FISYzWmTs3t7c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vCowriNK/vXy6yKvozFLpiHqlvw+IoE8
        752ftmJlX4C39jPxFb4ji35F/EHRAXYpIjPQR7ATD426ND6I2EN+ipY8n/xTUmgS
        R0R8h3eqBASQMgrFhFWwFGEfZowqAM2poCqIBPPTkWctrgtL5iJnyTBoqIIyFpdE
        XTHGrxvhxoA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 218BE92EF9;
        Tue, 17 Nov 2020 17:55:48 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9E7C092EF8;
        Tue, 17 Nov 2020 17:55:47 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     ebiederm@xmission.com (Eric W. Biederman)
Cc:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 00/28] Use main as default branch name
References: <pull.762.git.1605221038.gitgitgadget@gmail.com>
        <87r1oraewl.fsf@x220.int.ebiederm.org>
Date:   Tue, 17 Nov 2020 14:55:46 -0800
In-Reply-To: <87r1oraewl.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Tue, 17 Nov 2020 14:48:10 -0600")
Message-ID: <xmqqv9e34mq5.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 081FABDA-2928-11EB-ADB5-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> This is the big one. This changes the default of init.defaultBranch to main,
>> reflecting what many open source projects already did (which was followed by
>> GitHub, Azure Repos and others).
>
> Can we please not simply replace one hard coded branch name with
> another?
>
> Having a blessed name for the initially created branch continues to
> imply the branch has special significance.  As the initially created
> branch does not have special significance can we please do
> something that does not imply that?

I personally am fond of this line of "let's not treat one single
thing any special among others" approach, but I think the way people
use the initially created branch tends to make it special at the end
of the day.

While the project is still in its infancy, you may use that as the
only branch until the tree of the project starts to take its shape,
perhaps with subdirectories dedicated to sources, documentation, and
overall build procedure, etc.  Then you may start to fork different
branches to work on topics that last more than one commit's worth of
time and then it is likely you'd use the initially created branch as
the integration branch, until you start to need the second and third
integration branches.  Like it or not, the primary integration
branch would inevitably end up being something more special than
others, and it is likely that using the initially created branch for
that purpose would be the most convenient.  There however may exist
two or more equally significant branches, not just one special one,
though, but it is reasonable to have at least one special one.

I think using some word that is derived from $(basename $(pwd)) as
the name of the initial branch may be a more reasonable choice than
using any single word that tries to fit everybody (which will *not*
exist).  When a user says "git init tinyshell" to start a project to
create a tiny shell, "tinyshell" may be one reasonable choice to
refer to its primary integration branch.  Everything that goes into
it will become part of the tinyshell project.

But if there is a woke-safe word that can refer to "the primary
integration branch", calling the initially created branch with that
word by default is also equally a reasonable approach.  I personally
do not like the word 'main' used as such, but the rest of the world
seems to be moving in that direction, so being consistent with them
would help users who want to do

	mkdir project && cd project
	git init
	... some workflow specific 'git config' here ...
	git remote add $URL origin
	git pull origin

and have it be an enhanced equivalent to

	git clone $URL project

The latter will try to find the name used for the primary branch on
the other side and use the same name; the former would not work that
way, but if "git init" uses a fallback default that is most common,
it would hurt less.

In any case, the updated version of these 28 patches no longer has
the final "switch the fallback default to 'main'" step, and the good
thing is that the other 27 patches will help us moving in any
direction.  If we choose to dynamically derive the initial branch
name, these steps make sure that such a change won't break our
testsuite.

> Instead of having a fixed name across all repos for the initially
> created branch can we instead use the directory name of the repo for the
> branch name?
>
> Advantages:
>
> - The branch name that is somewhat meaningful to the creator of the git
>   repo.
>
>   I have at least two repos where I wound up doing this by hand.  So at
>   least for me it is something I am doing anyway.

Direct "other side" of the coin is that the name meaningful to the
creator may be different from project to project, so those who want
to try peeking projects that are so far unknown to them will have to
guess what that meaningful thing is.  When visiting a random github
repository and presented by 47 different branches, it would be more
helpful for such a visitor to have a reliable "this is likely to be
the primary integration branch" cue.  Not having a convention is
worse than having a convention some folks may find suboptimal from
usability's point of view.

> - Tools can not hard code the name of an initially created branch and
>   expect it to work.

Cannot?  Is this a dogmatic declaration?

If tools that are meant to work with variety of projects with a
single "special" branch and do things relative to that special
branch (e.g. perhaps the special branch is the primary integration
branch, and the tool may list commits that are not yet in that
branch), a toolsmith has multiple choices.  The tool can take the
name of the "special" branch from the end-user to be most flexible,
of the tool can hardcode the most commonly used name for the
"special" branch to be out-of-the-box useful for majority of
projects.  Most sensible folks may do the former, but I do not think
the latter is a bad choice.  And even those who do the former has to
fall back to some hardcoded value when the user didn't give the name
of the "special" branch, because end-users are greedy and will
demand such a "convenience" feature, saying "in most repositories,
this name is commonly used for the 'special' branch---why force us
to type the same thing?"

