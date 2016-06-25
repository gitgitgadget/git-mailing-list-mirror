Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F36871FEAA
	for <e@80x24.org>; Sat, 25 Jun 2016 19:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751658AbcFYTpQ (ORCPT <rfc822;e@80x24.org>);
	Sat, 25 Jun 2016 15:45:16 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56252 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751357AbcFYTpP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jun 2016 15:45:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AA2E225207;
	Sat, 25 Jun 2016 15:45:13 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=C38oeaG6f/EmPQ8XgwQlbZoBISM=; b=s0TSyo
	xtuD1FhQWGlkMx1R6lxxBTk3S8gorT+UASJcXnCZpeBDil9WBQItkKa42Wa3dtr8
	JgIBJMV4AB1bpyVT3HzguH1aNCglCtKNMd6QAI6LBm4Isl8YrXVmzzsA2pddtxm2
	YQhNzZNbvLREACrZOropOi9iH3BrSbSTtjBuc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LC3nZmKcQ5CcwogoXjzM7nBMo69zV5SX
	SsvsxzAdxrjOTUj0aLdsteMurccMPl7F0qEpo2jOGjD9gn8Sc6smJD5n8oGm5Ttn
	tsOa7m6jGY7ao9Xvlsa6S2upNQShW2n8YBztO0vQK3FrC2etptiVQJuU1AB2khaO
	1Y3QYG8Bz8I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A134F25206;
	Sat, 25 Jun 2016 15:45:13 -0400 (EDT)
Received: from pobox.com (unknown [104.133.2.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1D72A25205;
	Sat, 25 Jun 2016 15:45:13 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Barret Rennie <barret@brennie.ca>
Cc:	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Michael Rappazzo <rappazzo@gmail.com>
Subject: Re: [PATCH] builtin/worktree.c: add option for setting worktree name
References: <20160625051548.95564-1-barret@brennie.ca>
	<576E2FA9.7070008@kdbg.org>
	<1FEF5F90-6534-4D91-B27C-16FE6D16EC3F@brennie.ca>
Date:	Sat, 25 Jun 2016 12:45:10 -0700
In-Reply-To: <1FEF5F90-6534-4D91-B27C-16FE6D16EC3F@brennie.ca> (Barret
	Rennie's message of "Sat, 25 Jun 2016 01:29:49 -0600")
Message-ID: <xmqq1t3ldpdl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 553C1B28-3B0D-11E6-9715-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Barret Rennie <barret@brennie.ca> writes:

>> What is "the name for the worktree"? Is it the directory where it lives in?
>>Is it how it is listed with 'git worktree list'?
>
> The name of the worktree is the name of the created directory in
> `.git/worktrees`.
>
>> How is --name different from the <path> argument?
>
> Currently, if you run:
> 	
> 	git worktree add /my/worktree/checkout <branch>
>
> you get a worktree "named" checkout, i.e., `.git/worktrees/checkout`. The
> idea with this patch is to allow you use a more specific name when you would
> otherwise have mulitiple worktrees of the form `checkout`, `checkout1`, etc.
>
> That is, you could do
>
> 	git worktree add --name branch1 /worktrees/branch1/src branch1
> 	git worktree add --name branch2 /worktrees/branch2/src branch2
> 	git worktree add --name branch3 /worktrees/branch3/src branch3
>
> and have `.git/worktrees/branch1`, `.git/worktrees/branch2` and
> `.git/worktrees/branch3` instead of `.git/worktrees/src`,
> `.git/worktrees/src1`, `.git/worktrees/src2`. That way, it becomes more clear
> when poking inside `.git/worktrees` which directory points to which checkout.

That is a way better justification of "why we need to use a custom
name, not the default one" than the previous "with this we can use a
custom name".

As long as you can justify why having anything underneath branch$n/
is necessary, that is.  In your explanation above, it is still
unclear why you need a checkout at /worktrees/branch$n/src/, and why
it would not work if it is at /worktrees/branch$n/.

Note that I am not saying "there cannot be a good reason, do not add
this feature" when I say "it is unclear why".  I am encouraging you
and others in this discussion thread to find good use cases for the
proposed new feature and come up with materials to help improving
the documentation part of the patch.  That way, the users with
similar needs can find how the feature is supposed to be used and
understand the feature better.

I suspect that this new feature might be useful when two more more
interdependent projects (they could be organized as submodules in a
superproject, but they can be independent checkouts of different
projects) are used together.  Imagine frotz and nitfol projects, and
without fancier setup to have multiple checkouts, you may be
expected (by these two projects) to check them out like so:

    $top/frotz/
    $top/libs/nitfol/

where $top can be anywhere but to clarify the line of thought, lets
pick a concrete place, say $HOME/xyzzy.  So without worktrees, you
would have

    $HOME/xyzzy/frotz
    $HOME/xyzzy/libs/nitfol

Now, if you do the worktree, you may still want the relative
structure between these two, i.e. if you want to work on two
different branch combinations of the whole thing, you would want to
do this:

    $HOME/xyzzy-1/frotz       - borrow from $HOME/xyzzy/frotz
    $HOME/xyzzy-1/libs/nitfol - likewise for nitfol

    $HOME/xyzzy-2/frotz       - borrow from $HOME/xyzzy/frotz
    $HOME/xyzzy-2/libs/nitfol - likewise for nitfol

where xyzzy-$n may be for topic-$n branch both in frotz and nitfol.

And explained that way, it becomes clearer that you would want to
name $HOME/xyzzy-1/frotz worktree after "topic-1", not the default
name you would get "frotz" (because the default gives you the leaf
level name of the newly created worktree).

After the discussion above (which may or may not match what you
raised this topic for), I think a feature to let you override the
default name makes sense.

It just needs to be explained better to help the users when the
feature eventually becomes part of Git.  Also, others (especially
Duy) may have even better ideas (e.g. instead of having to always
use --name to give custom name for all worktrees, set a "hint" just
once to help the logic that comes up with the default name give a
better name), so while the feature may be desirable, your exact
implementation may or may not be what we eventually want to adopt.

Thanks.


