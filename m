Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD4FC388F9
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 21:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84BC120B80
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 21:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yS4UcIY9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbgKSVZe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Nov 2020 16:25:34 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59779 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbgKSVZe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Nov 2020 16:25:34 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1F2A3993DB;
        Thu, 19 Nov 2020 16:25:29 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=McZX0sLDcFmJfqzAdB9lR7rTX4E=; b=yS4UcI
        Y9O26tKW6A97dSnVvyvypqSIcOvlJ5p0gF6zhKVoYTX50xXoWY8FtHOYYMX+Jij3
        AbI+inmKJS2QA4XUr5BD7Q/Krw7/Q9woUoILJ+oGjk6I93NJ8Wc46+4OBpsoVYji
        nIGdzqgpEcUOicqMILoVwloA8D3zPv52zbqy0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Sn6c3ZgM62DVgNF/VPDASXzmXI1eSu3Z
        46Qw+Y1dDoGlBeK27naknpr84Rx3jxI4gkC2X0eUPDuCleWlCcg/WodqJT/TXR7a
        FobiOUKvf+Ek4DP3QQOgjClSWXTug/tW3RqyV8dS9fnEbueT9/6BCowK6L5c00Jg
        a9A8K8KhTW8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 132AA993D9;
        Thu, 19 Nov 2020 16:25:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 79916993D8;
        Thu, 19 Nov 2020 16:25:28 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Brandon Casey <drafnel@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Lukasz Niemier <Lukasz.Niemier@kobil.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Don Goodman-Wilson <don@goodman-wilson.com>
Subject: Re: The master branch rename, and avoiding another v1.6.0 git-foo
 fiasco
References: <CAMP44s3BJ3dGsLJ-6yA-Po459=+m826KD9an4+P3qOY1vkbxZg@mail.gmail.com>
        <20201113010107.GL6252@camp.crustytoothpaste.net>
        <CAMP44s1U1FevS7NrAYxvgVyzfR5tnD9-+BbPdw5bKnaNHkyD+A@mail.gmail.com>
        <20201113051408.GA3985404@mit.edu>
        <CAMP44s3AeESm7VBKbar0ir_Py35g99ZW6bNX_=AK4N=OFkcrdA@mail.gmail.com>
        <20201113145802.GB3985404@mit.edu>
        <CBC2DBAA-A409-49CD-B932-AC82D3C20D55@kobil.com>
        <20201115034649.GC3985404@mit.edu>
        <CA+sFfMfWrSMKAogg-5dsaO_beXUV-JCBLBPeLZ5g_0jGqsom8Q@mail.gmail.com>
        <20201119133705.7q7yghymvvo7zeq4@chatter.i7.local>
Date:   Thu, 19 Nov 2020 13:25:27 -0800
In-Reply-To: <20201119133705.7q7yghymvvo7zeq4@chatter.i7.local> (Konstantin
        Ryabitsev's message of "Thu, 19 Nov 2020 08:37:05 -0500")
Message-ID: <xmqq4kllxcmw.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BEE3CB90-2AAD-11EB-BCD9-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Konstantin Ryabitsev <konstantin@linuxfoundation.org> writes:

>> So we're changing the default branch name from "master" to "main"?
>
> To my knowledge, there are no concrete plans to change anything at this 
> time. All recent work was to remove any special-case treatment of 
> "master" as the default branch name, so people are free to use any 
> configuration they like.

That is a fair description of one state which is a bit stale.

All recent work has been to make sure our tests will not lose test
coverage when we decide to change the fallback default value for
init.defaultBranch to a value other than 'master'.  In other words,
we have been talking about changing (or not changing).

The question most useful to ask at this point are to what name
(fixed? computed?) and what the transition plan would look like.

>> For what purpose?  What problem are we trying to solve?
>
> People want to be able to use arbitrary branch names.

What you gave was the purpose of init.defaultBranch we've introduced
in the last release, but that does not answer the question you are
answering.

The discussion thread you posted to, however, is already talking
about changing (or not changing) the fallback default value for that
variable, i.e. what name does the initial branch get upon "git init"
for end-users who do not indicate any preference.

Some understand well that the primary reason to switch to 'main' is
to help people who will need to interact with projects and hosting
providers that have done the same switch already [*1*].  Some do not
buy that reason well and ask "why?".  You need to give an answer to
the latter.

>> Is the word "master" now going to become a taboo word that we're all
>> afraid to say?
>
> No, everyone is welcome to use it if they like. It has perfectly 
> legitimate usage cases -- for example, some of the staunchest opponents 
> of this terminology continue to list their "Master of Arts" degree on 
> LinkedIn.

Correct.

>> Isn't this all a little silly? What's wrong with the term "master"?
>
> It is misleading in the context of git, because it implies that a branch 
> carrying that name is in some way special compared to other branches 
> (e.g. like "trunk" in the SVN world). In reality, the "master" branch is 
> just a branch like all others (and can be missing entirely or have junk 
> in it), so it really shouldn't be called "master".

I find the above answer even more confusing, in the context of major
projects and hosting sites all moving to 'main'.  If 'master' is
misleading for all the reasons stated in the above paragraph, 'main'
would equally be misleading.  In other words, "It is just a branch
like all others, so it really shouldn't be 'master'" leads to "it
shouldn't be 'main' or 'primary', either".

I personally am fond of this line of "let's not treat one single
thing any special among others" thinking, but I think the way people
use the initially created branch tends to make it special at the end
of the day.

While the project is still in its infancy, you may use that as the
only branch until the tree of the project starts to take its shape,
perhaps with subdirectories dedicated to sources, documentation, and
overall build procedure, etc.  Then you may start to fork different
branches off of it to work on topics that last more than one
commit's worth of time.  At that point, it is likely you'd use the
initially created branch as the primary integration branch, until
you start to need the second and third integration branches.  Like
it or not, the primary integration branch would inevitably end up
being something more special than others, and it is likely that
using the initially created branch for that purpose would be the
most convenient.  There however may exist two or more equally
significant branches, not just one special one, though, but it is
reasonable to have at least one special one.

And for this reason, it does not make much sense to change the
fallback default to "unnamed"---that would force everybody to
immediately rename it (or set init.defaultBranch).


[Footnote]

*1* We expect many projects end users would interact with to be
    using 'main' as the branch of primary interest, and cloning from
    such a project would give you 'main' (i.e. "git clone" finds
    what name the other side users, and uses the same name locally).
    If a new user is starting their Git experience from scratch in
    such a world, it would be more helpful if their "git init"
    placed them on the 'main' branch, and their hello world project
    built on that single branch is pushed to the 'main' branch in
    their publishing repository at hosting sites'.  In such a world,
    tutorial books will all be written with 'main' as the initial
    branch name, too, even though good ones would mention that
    historically 'master' has been used and the readers would see
    projects with history longer than readers' Git lifetime may
    still use 'master' as the primary branch.
