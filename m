Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C07FC433E6
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 22:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC96E64F53
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 22:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbhCRWaa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Mar 2021 18:30:30 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54314 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbhCRW34 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Mar 2021 18:29:56 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7597310F6B9;
        Thu, 18 Mar 2021 18:29:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=jmroPoFTVCAF
        +ztFytU//RzysSc=; b=lSch6+sEubFgKR0x2NuLRKZnuJ6gKWu3FtXMKTd6fUGA
        fGeOHXebRu9rF3jK/2m3ESXtrBtUcs/Lc9iC8raRX5BktRtVp1RjyW6NobMKSKdr
        tkY4S9MSiDbcUNm4y4ndhDlq9cVUXVbZFF140kwNUulQz5zUSxRDLWgthcJfRkA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=vtpXkP
        VA2eiL3kQJimScpZns88ilP8qJvJXTHMJHG4TO4+Z5foyF2dB+LUpqZqoLWPy+Do
        5cYVzZ9K2PyCDNC5kIjjdhHmScog8URfkNrC+2sQcorGjVPSsr2FckvjEz7TtUJ0
        RYiyq+8xVRwMC7ycGhquI/Ks3QT/Czo/V5DVI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6D76810F6B8;
        Thu, 18 Mar 2021 18:29:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B267A10F6B6;
        Thu, 18 Mar 2021 18:29:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Albert Cui via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Albert Cui <albertqcui@gmail.com>
Subject: Re: [PATCH] hooks: propose repository owner configured hooks
References: <pull.908.git.1616105016055.gitgitgadget@gmail.com>
Date:   Thu, 18 Mar 2021 15:29:51 -0700
In-Reply-To: <pull.908.git.1616105016055.gitgitgadget@gmail.com> (Albert Cui
        via GitGitGadget's message of "Thu, 18 Mar 2021 22:03:35 +0000")
Message-ID: <xmqqim5oqen4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 75E61C60-8839-11EB-B9C1-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Albert Cui via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Albert Cui <albertqcui@gmail.com>
>
> Hooks today are configured at the repository level, making it difficult=
 to
> share hooks across repositories. Configuration-based hook management, b=
y
> moving hooks configuration to the config, makes this much easier. Howev=
er,
> there is still no good way for project maintainers to encourage or enfo=
rce
> adoption of specific hook commands on specific hook events in a reposit=
ory.
> As such, there are many tools that provide this functionality on top of=
 Git.
>
> We propose adding native Git functionality to allow project maintainers=
 to
> specify hooks that a user ought to install and utilize in their develop=
ment
> workflows. This patch documents the requirements we propose for this fe=
ature
> as well as a design sketch for implementation.
>
> Signed-off-by: Albert Cui <albertqcui@gmail.com>
> Helped-by: Emily Shaffer <emilyshaffer@google.com>
> ---

A copy of Android or Chromium project I have on my disk is owned by
me in the distributed world---open projects do not and do not have
to care who makes and has copies, even though they may care who can
push to the project's own repository.

So avoid "repository owner configured", when you mean "project
configured" or "project controlled".

On the other side of the coin is that this document should avoid
reference to a "repository" in an ambiguous way, as it can refer to
the central meeting place the project controls, lets developers to
clone and fetch from, and push into, and it can also refer to the
copy of that central meeting place individual contributors work in.

In our own documentation, we often refer to the former as "the
central repository", and the latter as "a clone" (as in "you start
working in your own clone").

>     hooks: propose repository owner configured hooks
> ...
>     for this feature as well as a design sketch for implementation.

No need to duplicate this text twice. =20

> @@ -0,0 +1,294 @@
> +Repository Owner Hooks Administration
> +-------------------------------------

Ditto and throughout the document.

> +Background
> +~~~~~~~~~~
> +
> +Context
> +^^^^^^^
> +
> +Git has https://git-scm.com/docs/githooks[hooks] functionality to allo=
w users to
> +execute commands or scripts when certain Git events occur. Some use ca=
ses
> +include:
> +
> +* The `pre-commit` hook event: before committing, a developer may want=
 to lint
> +their changes to enforce certain code style and quality. If there are =
style
> +issues, the developer may want the commit to fail so that they can fix=
 the
> +issues.

This is irrelevant in the context of this proposal, no?  It is not
that "the developer may want".

Rather, it is "the project may want the commit to fail so that they
won't upload commits that violate the house style", no?

> +* The `commit-msg` hook event: after committing, repository owners may=
 want to
> +enforce a certain commit message style. This may be out of necessity:
> +https://www.gerritcodereview.com/[Gerrit Code Review], for example, re=
quires
> +each commit to have a Change-Id in the footer.

This is a more honest descrition ;-)

> +We propose adding native Git functionality to allow project maintainer=
s to
> +specify hooks that a user ought to install and utilize in their develo=
pment
> +workflows.

OK.

> +User Goals / Critical User Journeys
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +* As a repository owner / project maintainer,
> +
> +    ** I want to enforce code style so I require developers to use a
> +    standardized linter.
> +
> +    ** I want to prevent leaks / share code widely so I check that dev=
elopers
> +    are uploading code to the right place.

I understand "You want to prevent leaks", but not "I want to share
code widely".  Perhaps you meant s/widely/narrowly/?

> +    ** I want this to just work for all the developers in my repositor=
y, without
> +    needing to support them through configuration.
> +
> +* As a developer developing in a repository,
> +
> +    ** I want to set up my workspace
> +
> +    ** I want control over what code runs on my machine
> +
> +    ** I want to skip hooks from running (for various reasons)

Also I want to run hooks other people may not run.  And that is one
thing Emily's config based stuff makes easier.


> +Design Principles
> +~~~~~~~~~~~~~~~~~
> +
> +* *Make it easy:* Developers just want to get their work done. Introdu=
cing
> +friction is bad, especially when it prevents development from even sta=
rting e.g.
> +workspace set up.
> +
> +* *Treat hooks as software, not configuration:* We take seriously the
> +responsibility that comes with causing arbitrary code to run on a user=
's
> +machine. Such code needs to come from a reputable source, be automatic=
ally
> +updated, and run with user consent.

OK.

> +Feature Requirements
> +~~~~~~~~~~~~~~~~~~~~
> +
> +Minimum Feature Set
> +^^^^^^^^^^^^^^^^^^^
> +
> +* A repository owner can specify a configuration for what hook command=
s are
> +enabled for what hook events
> +
> +* A repository owner can specify, in this configuration, where the hoo=
k
> +commands reside
> +
> +    ** This could be a path to a script/binary within the repository
> +
> +    ** This could be a path to a script/binary contained within submod=
ules of
> +    the repository
> +
> +    ** This could be a user installed command or script/binary that ex=
ists
> +    outside of the repository and is present in `$PATH`
> +
> +* Users must explicitly approve hook execution at least once (yes/no)
> +
> +    ** This could happen during setup or at execution time
> +
> +    ** When a hook command changes, a user should re-approve execution=
 (note:
> +    implementation should not interfere with requirement listed in =E2=
=80=9CFast
> +    Follows")
> +
> +    * Users do not need to run setup scripts to install hooks --- the =
setup flow
> +    happens automatically at clone time

This one is probably unacceptable, as it makes it impossible to
perform unattended cloning.  A better alternative may be to make it
part of the build procedure.

> +* Automation is able to continue to use clone and other commands
> +non-interactively

This directly contradicts with the "setup flow happens
automatically", doesn't it?  The user can pretend to be (or the
"automation" detection may incorrectly misidentify the users to be)
an automated client when cloning the project, and would not trigger
any setup.  A separate setup procedure needs to be there to salvage
such users anyway.


> +* Works across Windows/Linux/macOS
> +
> +Fast Follows
> +^^^^^^^^^^^^
> +
> +* When prompted to execute a hook, users can specify always or never, =
even if
> +the hook updates

This contradicts the earlier claim to take the responsibility
seriously, doesn't it?  I think the convenience feature is useful,
but then we should tone down the claim---we allow users to be loose
and blindly trust their own project, instead of taking it always
seriously.

