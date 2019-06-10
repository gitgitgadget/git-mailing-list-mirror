Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D87741F462
	for <e@80x24.org>; Mon, 10 Jun 2019 20:49:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387489AbfFJUtt (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jun 2019 16:49:49 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60170 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727588AbfFJUts (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jun 2019 16:49:48 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B826587BAF;
        Mon, 10 Jun 2019 16:49:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2Z72ExNQZtBmCGUq/9AdE5MvprQ=; b=xSnZrZ
        cystdfAtx48M9zapGK5QWG+RfIeunFd4WZLXYnkV98sp7dVh8tTBZkGFV4ttekAU
        YQ68VCp995MrSHW2075+szTNaT13wwBykqtJLhxM+TSQ/0PlVeN4KUvdeF4NDUwu
        0UMGMFeCcEwIhJg8pEjx2kYom1oaKcll5fNuk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=K2jmKoe9YOj07dIhxjlPRp6fJSNtremm
        71IdtQFGz+U7fhAMWOR7aE7mHWEOT+Nagurh4UqHvXeJCLO+Sc9SKIUjK5s5W18o
        Tf8oYY6WtRN5srrXm1a3sMw9iJnUI7Vih+4/yUIKIIVvONar5rDuDBKvG+EhgNpM
        k2sbItmm4+k=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B087387BAE;
        Mon, 10 Jun 2019 16:49:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E566987BAD;
        Mon, 10 Jun 2019 16:49:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] documentation: add tutorial for revision walking
References: <20190607010708.46654-1-emilyshaffer@google.com>
Date:   Mon, 10 Jun 2019 13:49:41 -0700
In-Reply-To: <20190607010708.46654-1-emilyshaffer@google.com> (Emily Shaffer's
        message of "Thu, 6 Jun 2019 18:07:08 -0700")
Message-ID: <xmqq7e9tmahm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4683D870-8BC1-11E9-A5EB-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> +My First Revision Walk
> +======================
> +
> +== What's a Revision Walk?
> +
> +The revision walk is a key concept in Git - this is the process that underpins
> +operations like `git log`, `git blame`, and `git reflog`. Beginning at HEAD, the
> +list of objects is found by walking parent relationships between objects. The
> +revision walk can also be usedto determine whether or not a given object is
> +reachable from the current HEAD pointer.

s/usedto/used to/;

> +We'll put our fiddling into a new command. For fun, let's name it `git walken`.
> +Open up a new file `builtin/walken.c` and set up the command handler:
> +
> +----
> +/*
> + * "git walken"
> + *
> + * Part of the "My First Revision Walk" tutorial.
> + */
> +
> +#include <stdio.h>

Bad idea.  In the generic part of the codebase, system headers are
supposed to be supplied by including git-compat-util.h (or cache.h
or builtin.h, that are common header files that begin by including
it and are allowed by CodingGuidelines to be used as such).

> +#include "builtin.h"
> +
> +int cmd_walken(int argc, const char **argv, const char *prefix)
> +{
> +        printf(_("cmd_walken incoming...\n"));
> +        return 0;
> +}
> +----

I wonder if it makes sense to use trace instead of printf, as our
reader has already seen the psuh example for doing the above.

> +Add usage text and `-h` handling, in order to pass the test suite:

It is not wrong per-se, and it indeed is a very good practice to
make sure that our subcommands consistently gives usage text and
short usage.  Encouraging them early is a good idea.

But "in order to pass the test suite" invites "eh, the test suite
does not pass without usage and -h?  why?".

Either drop the mention of "the test suite", or perhaps say
something like

	Add usage text and `-h` handling, like all the subcommands
	should consistently do (our test suite will notice and
	complain if you fail to do so).

i.e. the real purpose is consistency and usability; test suite is
merely an enforcement mechanism.

> +----
> +{ "walken", cmd_walken, RUN_SETUP },
> +----
> +
> +Add it to the `Makefile` near the line for `builtin\worktree.o`:

Backslash intended?
