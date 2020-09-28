Return-Path: <SRS0=i2G4=DF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EBD7C2D0A8
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 21:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE7422100A
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 21:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="soJcD/e/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgI1VUB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 17:20:01 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:65400 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbgI1VUB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 17:20:01 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 47338F0705;
        Mon, 28 Sep 2020 17:19:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=V/Tdah6DdaLujWk6noZyca6s0ws=; b=soJcD/
        e/Nd6ydzOSY5YjDWj2Uz3lpnyvEXhNVLWhmW5yC6h9oKWgbFDa7SxeSjNWKtlDKn
        nPNWJiHmov7YfIcnaHMzlP+egV9xwbF8vazQMsG8+Ccg9bXeLBpde55S+U71OfeV
        Sc7o5xbWlJThiOuk9/Z+G4BVn/WwVLOZMb96U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ShyGvDM/3ny0dgylsjAFtqlItgJRkwZn
        bHERYmeKQ4RObo9iaUuEJG6xam0RiZiwD604oVrhC5NkdtGfwWB6LToPsGzEddBT
        q2ewmSQ3emGz1Fho0DvyCzUlPFnyMO90BKEmusSyxvT7TuseTxA1c6q24mdxYbA8
        wu/mS3ghCzs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 40754F0704;
        Mon, 28 Sep 2020 17:19:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 72AE1F0703;
        Mon, 28 Sep 2020 17:19:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rafael Silva <rafaeloliveira.cs@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [RFC PATCH 0/2] teach `worktree list` to mark locked worktrees
References: <20200928154953.30396-1-rafaeloliveira.cs@gmail.com>
Date:   Mon, 28 Sep 2020 14:19:53 -0700
In-Reply-To: <20200928154953.30396-1-rafaeloliveira.cs@gmail.com> (Rafael
        Silva's message of "Mon, 28 Sep 2020 15:49:51 +0000")
Message-ID: <xmqqft71lhty.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5AE7465E-01D0-11EB-8D46-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rafael Silva <rafaeloliveira.cs@gmail.com> writes:

> This patch series introduces a new information on the git `worktree list`
> command output, to mark when a worktree is locked with a (locked) text mark.
>
> The intent is to improve the user experience to earlier sinalize that a linked
> worktree is locked, instead of realising later when attempting to remove it
> with `remove` command as it happened to me twice :)

Change with a good intention, it seems.

> The patches are divided into two parts. First part introduces
> the new marker to the worktree list command and small documentation
> change. And the second adds one test case into t2402 to test
> if the (locked) text will be properly set for a locked worktree, and
> not mistankely set to a unlocked or master worktree.

Probably they belong together in a single patch (I am saying this
after only seeing the above five lines, without reading either of
these two patches, so there may be some things in them that makes it
make sense to have them separate).

> This is the output of the worktree list with locked marker:
>
>   $ git worktree list
>   /repo/to/main                abc123 [master]
>   /path/to/unlocked-worktree1  456def [brancha]
>   /path/to/locked-worktree     123abc (detached HEAD) (locked)

Looks OK to me

> This patches are marked with RFC mainly due to:
>
>   - This will change the default behaviour of the worktree list, I am
>     not sure whether will be better to make this tuned via a config
>     and/or a git parameter. (assuming this change is a good idea ;) )

The default output is meant for human consumption (scripts that want
to read from the command and expect stable output would be using the
"--porcelain" option).

The ideal case is a new output is universally useful for everybody,
in which case we can just change it without any new configuration or
command line option.

>   - Perhaps the `(locked)` marker is not the best suitable way to output
>     this information and we might need to come with a better way.

It looks good enough to me.  I am not qualified to have a strong
opinion on this part, as I do not use the command all that often.

    $ git shortlog --no-merges --since=18.months builtin/worktree.c

tells me that Eric Sunshine (CC'ed) may be a good source of wisdom
on this command.

>   - I am a new contributor to the code base, still learning a lot of git
>     internals data structure and commands. Likely this patch will require
>     updates.

Welcome.

> Rafael Silva (2):
>   teach `list` to mark locked worktree
>   t2402: add test to locked linked worktree marker
>
>  Documentation/git-worktree.txt |  5 +++--
>  builtin/worktree.c             |  6 +++++-
>  t/t2402-worktree-list.sh       | 13 +++++++++++++
>  3 files changed, 21 insertions(+), 3 deletions(-)
