Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF27C433FE
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 23:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECA7960F0F
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 23:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbhKAXWv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Nov 2021 19:22:51 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59185 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbhKAXWt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Nov 2021 19:22:49 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 203C815638E;
        Mon,  1 Nov 2021 19:20:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=05iE+pVztXTFqOlvuIPJRGq8m9VFH3Pfi7jMGs
        A+cCc=; b=AbkXjhq6alHVqBhaNCV0AB0R7MAWrOyCfDPGvDcgPRczKo+VSPbDep
        tkKSg4+cz0aritPoK5zXEK7v2JS9m/JB6gWxFEdCHcV3gLKCWBOP0sAylUH0gXWi
        D/MqeXsmGa6TD6eGUBa3Ppi3nhQDZtsK9uSpELyngCNdjUzlkgRw4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 184A915638D;
        Mon,  1 Nov 2021 19:20:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A345A15638B;
        Mon,  1 Nov 2021 19:20:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        Victoria Dye <vdye@github.com>, Theodore Ts'o <tytso@mit.edu>
Subject: Re: [Discussion] The architecture of Scalar (and others) within Git
References: <b67bbef4-e4c3-b6a7-1c7f-7d405902ef8b@gmail.com>
Date:   Mon, 01 Nov 2021 16:20:08 -0700
In-Reply-To: <b67bbef4-e4c3-b6a7-1c7f-7d405902ef8b@gmail.com> (Derrick
        Stolee's message of "Wed, 27 Oct 2021 17:51:05 -0400")
Message-ID: <xmqqbl33a2fr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 41B8EF64-3B6A-11EC-91CD-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> Optimization Factors
> --------------------
>
> There are multiple factors involved that we wish to optimize. Here is my
> understanding of the most-important factors and how they interact:
>
> ### Value
>
> The main reason to include Scalar within the Git codebase is to make it
> available to more users. This should have downstream effects based on user
> feedback about what they like or dislike about the Scalar CLI that can
> inform future features in core Git that simplify repository management at
> scale.

In other words, Scalar wants to piggyback on Git's popularity, yet
wants to retain total control of how its end-user experience should
look like, eating the cake and having it at the same time?

I do not think it is fair to proceed with this discussion without
having "Scalar lives in its own tree, uses this mailing list to
discuss how it should evolve, drawing expertise from the
contributors found here, but otherwise would stay to be a spearate
project" as another option and debating its pros-and-cons, next to
the spectrum among contrib/scalar, scalar/, and scalar.c approaches.
IIUC, cgit has one-directional coupling to depend on libgit.a just
like the Scalar wants to link with it---I am not saying Scalar should
do the same, but just raising it as an example that you do *not* have
to live in my tree anywhere to be able to link with libgit.a; that
would probably count as an "**Option 0:** A separate project that
borrows from Git by having it as a submodule".

I can think of only one obvious advantage going that route, and that
is why I said "I am not saying Scalar should do the same", which is
that the Scalar project will then retain total control over how it
is built and how its end-user experience should stay the same.

I do not think it is an option to refuse to take any input from
others on this list on parts of what you have already done, if you
want to be in my tree, anywhere, not even in contrib/.

Just like we say "the plumbing command X has behaved this way
forever, and we cannot break the backward compatibility" to some
possible changes to any of our tools, however, "Scalar has been used
with that subcommand behaving this particular way even before the
code was donated to Git project, so we cannot lightly change it"
would equally be a good input when we evaluate when some things in
it may need to be changed, so I do not think it would pose a great
backward compatibility issue (after all, we do not change things
lightly just for the sake of changing it).

But approaching our developers with a new piece of code, saying "I
want to piggyback on your popularity.  Among the stuff given to you,
some are out of limit and you may not even discuss about modifying
it" upfront, is a problematic attitude.

Now, the goal from purely Git project's point of view would be to
improve Git's user experience, not necessarily Scalar's, by exposing
more of our users to the way its opinionated (which is *not*
necessarily a bad thing) decisions work to help its users, and our
developers to the scalar codebase.  Some of our developers may not
even agree with the design decisions Scalar made and that is
expected and is fine; based on such a reaction, the lesson Git
learns from Scalar to solve a similar issue may turn out to be solve
it differently.

I do not know how much Options 1-3 would help such cross pollination
more over the Option 0, offhand, though.


> Possible approaches to land in our final target
> -----------------------------------------------

Here I sense the "final target" is somehow Scalar is delivered to
end-users through my tree and being maintained there, but from my
point of view, that is merely an early step.  Wasn't the final
target for "git" to learn from Scalar's successes and mistakes and
give native support to itches Scalar wanted to scratch?

And if that is indeed the goal, when it is achieved, Scalar would
become a historical curiosity just like Cogito is today.  With
Cogito, we cross-pollinated just fine without having both in the
same tree at all, and when Cogito outlived its usefulness, we did
not have to remove anything from our tree.  With cgit, we did not
cross-pollinate at all, unfortunately, and gitweb more or less stays
the same way as it was years ago, and cgit is still a project with a
useful product.  We can reach both extremes even if we take Option
0.  But it would have been messy for something like Cogito, which
was an early UI and workflow experiment, if we took a more
integrated approach.

> **Phase 1.** Keep code in contrib/ while we contribute the Scalar features.
>
> Since the current patches on the mailing list are not feature complete, it
> can be beneficial to move forward with the code in `contrib/scalar/` until
> we reach feature parity. At that point, we could move the source into its
> final resting place.
>
> This leans into the fact that `contrib/` contains "interesting tools...
> maybe even experimental ones". While Scalar is not feature complete, it
> can be isolated as experimental here until it is ready for promotion to
> non-experimental.

I personally have no problem with this approach, but with less
scrutiny, being in contrib/ longer, with "some stuff are not subject
to discussion" attitude, would inevitably lower the code quality of
the product, and it is dubious it would become "ready for promotion"
ever.  The contrib/ hierarchy, especially in early days when we
wanted a way to grow the ecosystem, as a place to host "these are
done externally, and we only carry them for convenience", was a
successful model, but I do not think of anything that successfully
used contrib/ as a nursery to later graduate to the core and to be
seen as the same quality as other things that started their life in
core.  I am pessimistic to the model that uses contrib/ as such a
place.

> Depending on the final goal, we could drop some of the work that is currently
> built within the `contrib/scalar/` directory, such as `-c`/`-C` parsing or
> documentation builds. These features would be reimplemented in the new
> location, so we can prevent that duplicate effort if we have a different
> final location in mind.

> **Phase 2.** Establish community standards on optional components
>
> While the work in `contrib/scalar/` continues to reach feature parity, we
> can work as a community to set some ground rules about these kinds of
> optional features (depending on how "optional" we land). This can include
> standards such as how the files are laid out in the repository and how
> they interact with the `Makefile`. Whatever we do for Scalar is likely to
> form an example for a future contribution that we can't predict today.
> Many of the questions we are asking today can be written for posterity:
>
> * What is an appropriate level of coupling with the Git codebase?
> * Where should code custom to the component live?
> * How should documentation and tests be organized?
> * How do we initialize builds of a component?
> * Who is responsible for supporting the component? Who fixes the bugs?
> * Who is responsible for reviewing changes to the component?

I am afraid that the answer to the first four are "it depends" (but
the remaining two would fall out naturally out of them).

Thanks.  My brain is fried with the -rc work, rereading the material
that went to -rc0 since the last release, so I may have more to add
later, but for now, the above is what came to my mind.


