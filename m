Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB81EC433E0
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 16:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B77620738
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 16:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tlDSr3/D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbgHCQOZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 12:14:25 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53922 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbgHCQOZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 12:14:25 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7ADA9F3C75;
        Mon,  3 Aug 2020 12:14:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LN2qiG60k8YsJ576sU/emQ9XamA=; b=tlDSr3
        /DERT6vETinuT0lNKTAwCJWj0pNrA/TJY7xg0I/DvEAvPnG2/IUiXsrHZrb2B4Xc
        eqPniwobQYf811ScIKDjmw7funxKXpZUYhKl/fsuhPikUM+N2Ruj5jMYzXAp+Zxs
        NiH0DOSXfEpBR5VZ9TSGT3O03S8NX5+xMzY4o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MT3XhihWW7DimH/OOSv+01RxzAkX+Yju
        5OErMGoDu9nkYNKf8NDoqadi4B2LSpufsMdW9VFlDt23zvPISmwmFJGWHO13SHKm
        yg4NdPYqbMkaeDOwNJGBDoZnkRaclO4M8z8SIowodtRYrD3RhOmo73jdOjQgPxbU
        9eyELZBlWf8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 73A35F3C74;
        Mon,  3 Aug 2020 12:14:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BA080F3C72;
        Mon,  3 Aug 2020 12:14:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matt McCutchen <matt@mattmccutchen.net>
Cc:     git@vger.kernel.org
Subject: Re: Renaming the "master" branch without breaking existing clones
References: <ec960483f5008e9948271c678d51876920ab62c9.camel@mattmccutchen.net>
Date:   Mon, 03 Aug 2020 09:14:19 -0700
In-Reply-To: <ec960483f5008e9948271c678d51876920ab62c9.camel@mattmccutchen.net>
        (Matt McCutchen's message of "Mon, 03 Aug 2020 08:15:58 -0400")
Message-ID: <xmqqlfivwvtw.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 636E91EA-D5A4-11EA-A4B5-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matt McCutchen <matt@mattmccutchen.net> writes:

> 3. Ensuring that tools detect the default branch of a given repository
> in an appropriate way rather than assuming "master".  Where applicable,
> the remote HEAD symref is probably the best thing to use.

I wonder if that would work well.  Your refs/remotes/origin/HEAD is
designed to be tweaked by you to indicate which remote branch is of
interest to you to your local Git.  Those who are interested in
following along 'maint' can update refs/remotes/origin/HEAD to point
at refs/remotes/origin/maint in their clone of this project, and
they can say "git fetch origin && git log origin" to see the history
leading to the tip of 'maint' in my repository.

At least, that is how it is designed to work.  So "compare local
refs/remotes/origin/HEAD and what 'git ls-remote origin' sees where
they point at with their HEAD---if they are different, ours have old
name and theirs have new name" is not a good heuristics.

If we wanted to do this properly, I'd imagine we'd need to add a
mechanism for repositories to convey "this branch that used to exist
got renamed to this other name", not specifically for any "special"
branch name (like 'master').  If we plan to never allow reusing the
old and banned name, it probably is enough to turn the old name into
a symbolic ref that points at the new name, e.g. in my repository

    $ git update-ref refs/heads/seen refs/heads/pu
    $ git update-ref -d refs/heads/pu
    $ git symbolic-ref refs/heads/pu refs/heads/seen

which would create a symbolic reference 'pu' that points at 'seen'
to say "pu used to exist but it is now seen".

But that would not work well, as we must allow reusing the old name,
as the primary point of renaming 'pu' to 'seen' in this project was
so that we can accept topics from contributors whose anglicized name
has 'p' and 'u' in capital letters as pu/$topicname branches.  Having
a symbolic ref 'pu' would defeat that plan.

So perhaps we'd need to emply the usual trick to have a blob on
"meta" ref, say "refs/meta/ref-rename" might contain multiple tuples
that tells the receiving end about each moved ref:

    - the name of the 'old' ref (e.g. 'refs/heads/pu')
    - the name of the 'new' ref (e.g. 'refs/heads/seen')
    - (optional) when the 'move' happened

As it does not make much sense to perform the local side migration
silently and behind the user's back while the user is actively
working in the repository, it is likely that the migration
instruction would be written as a "perform this when it is
convenient for you" one-time event.  It may start by fetching the
"meta/ref-rename" blob and perform "what to do when remote ref X is
moved to remote ref Y" procedure.

That procedure should also be executable offline, without the remote
end publishing the "meta/ref-rename" data.  If you know your upstream
has changed 'pu' to 'seen', you should be able to do

    $ git ref-migration-helper refs/remotes/origin/pu refs/remotes/origin/seen

so that many things related to these names are changed (and that is
the most complex part---compared to that, conveying what rename the
remote end did to the local Git is much simpler), including

    - renaming the remote-tracking branches (obvious)

    - reconfiguring local branches that have their upstream branch
      set to the 'old' remote-tracking branch to make their upstream
      branch to the 'new' remote-tracking branch.

There may be others.

