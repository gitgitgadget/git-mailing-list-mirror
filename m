Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95AC6C433E0
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 22:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 642BD64F6B
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 22:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235672AbhCLWvS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 17:51:18 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51545 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235616AbhCLWvM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Mar 2021 17:51:12 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 11B2F12BAC1;
        Fri, 12 Mar 2021 17:51:02 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=O2S7QkUjfK1ed5i/IJfDGqiCq7A=; b=dOw9F3
        SoG3x/c6LkLZ0C4aum/4YqAji7DZ3uBG46eJiY5+gNmdbrrJbJtI6cH4X9uasqBc
        GBheYlCAUDIeWWwDEuaISxB9Uw0jcWGsyadeRRHjz0E4LoXc7Lxce00Z1PvFTOBb
        24sFhu68aJyHhFvupVUXyYZlBfy5wolZpNY3w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wglpZPeD1BJx4weXDYQOZ/i7ubOlIQJR
        ivsK9bsUw356trzUsSKjKgBjE4ZI7BfkMytTvQoL0MlIo/DmDbJOmUN+11syPrD5
        lUS+rofNOgotxhm01o1VWLtURogcq+p+XKhgTPnTcyp88Dm3NcU1xvYxdJzyLch1
        TqvJI1OL0Fo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 09C5712BAC0;
        Fri, 12 Mar 2021 17:51:02 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3A35412BABD;
        Fri, 12 Mar 2021 17:50:58 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Taylor Blau <ttaylorr@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v3] [GSOC][RFC] format-patch: pass --left-only to
 range-diff
References: <pull.898.v2.git.1615278830804.gitgitgadget@gmail.com>
        <pull.898.v3.git.1615285726482.gitgitgadget@gmail.com>
Date:   Fri, 12 Mar 2021 14:50:56 -0800
In-Reply-To: <pull.898.v3.git.1615285726482.gitgitgadget@gmail.com> (ZheNing
        Hu via GitGitGadget's message of "Tue, 09 Mar 2021 10:28:46 +0000")
Message-ID: <xmqqpn0456lr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 69206DEA-8385-11EB-9812-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: ZheNing Hu <adlternative@gmail.com>
>
> In https://lore.kernel.org/git/YBx5rmVsg1LJhSKN@nand.local/,
> Taylor Blau proposing `git format-patch --cover-letter
> --range-diff` may mistakenly place upstream commit in the
> range-diff output. Teach `format-patch` pass `--left-only`
> to range-diff,can avoid this kind of mistake.

The above is a bit too dense for average readers to grok.  Even if
the readers refer to the external reference, it is unclear where the
"may mistakenly" can come from and why "--left-only" would be
useful (and our log message should not depend on external material
so heavily to begin with).

So let's think aloud to see what use case this may be helpful, and
how the proposed solution makes the world a better place.

If I understand correctly, the use case this tries to help is this:

 * You had sent the v1 iteration of topic.  It was in the range
   B1..T1 where B1 is the tip of the integration branch (like
   'master') from the upstream.

 * To prepare for the v2 iteration, not only you updated individual
   commits, you rebased the series on a new upstream.  Now the topic
   is in the range B2..T2, where B2 is the tip of the integration
   branch from the upstream, and it is very likely that B2 is a
   descendant of B1.

And you want to find out how your commits in T2 (new iteration)
compares with those in T1 (old iteration).  Normally,

    $ git range-diff T1...T2

would be the shortest-to-type and correct version but that is
invalidated because you rebased.

    ---o---B1--b---b---b---B2
            \               \
	     t---t---T1      s---s---s---T2

You'd have commits B1..T1 on the left hand side of the range-diff,
while the right hand side has not just B2..T2 but also commits in
the range B1..B2, too.

By using --left-only (i.e. show only those pair that maps from
commits in the left range), you can exclude the commits in the
B1..B2.

    $ git range-diff --left-only T1...T2

I however wonder what --left-only (Suppress commits that are missing
from the first range) would do to commits in range B2..T2 (they are
all yours) that are (1) added since the v1 iteration, or (2)
modified so drastically that no matching commit is found.  With the
right invocation, of course,

    $ git range-diff B1..T1 B2..T2

you would not have such a problem.  If 2 't's in B1..T1 correspond
to 2 of the 3 's's in B2..T2, at least the presense of the third 's'
that did not match would show up in the output, making it clear that
you have one more commit relative to the earlier iteration.  If use
of --left-only filters it out, the output may be misleading to the
readers, no?

I started writing (or "thinking aloud") hoping that I can help
coming up with a better log message to describe the problem being
solved, but I ended up with "does this make the system better?"
