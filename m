Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1883C0007A
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 18:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8098A20793
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 18:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731435AbgLCSHl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 13:07:41 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63409 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgLCSHk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 13:07:40 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A7CEB10B90A;
        Thu,  3 Dec 2020 13:06:58 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ig0+V65oIr2f8GfJ+wR299bT9vE=; b=B/2+Ad
        lwBsIgKFGDuXgbLcOMPLQyIT8GV1l3UXaSBwMUTeiB+Eh0r1eSvByIp0AT2UrPzk
        yklu9QNu8on/ep7/KYIJ4zAqfpgenlgrOgf4UvH1jz4uJLG9mvdUtEtlE0s4ocGJ
        uglX89ukOPJfFg7jNUn3QGfPsQHjLUt9idVSw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wlXBbT9UHFlQ86lgNJLJtue19UvrS0Tr
        q2RMtRgrxqg/Nf9KO8/4L3BBfEUwlpuoDsl6jmJ6dRajj3LhbW373DH/D+foIoXF
        QDBXQmVhz5x7P+UZwH6qhaNmNf5+7JOMDokgWyW1ByNF9VnwWOc3J/6Au1uyfhkx
        3xvMOStSNWM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A030610B909;
        Thu,  3 Dec 2020 13:06:58 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DEC4D10B8FF;
        Thu,  3 Dec 2020 13:06:55 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>, Git <git@vger.kernel.org>,
        "Raymond E. Pasco" <ray@ameretat.dev>, Jeff King <peff@peff.net>,
        =?utf-8?Q?V=C3=ADt?= Ondruch <vondruch@redhat.com>,
        Theodore Tso <tytso@mit.edu>
Subject: Re: [RFC 2/2] pull: default pull.ff to "only" when pull.rebase is
 not set either
References: <20201125020931.248427-1-alexhenrie24@gmail.com>
        <20201125020931.248427-2-alexhenrie24@gmail.com>
        <xmqqmtyviq9e.fsf@gitster.c.googlers.com>
        <CAMP44s1Hwun+P=j5BBbVUT-ACS4hJCyRCJT-=6WvwK913fXq7g@mail.gmail.com>
Date:   Thu, 03 Dec 2020 10:06:54 -0800
In-Reply-To: <CAMP44s1Hwun+P=j5BBbVUT-ACS4hJCyRCJT-=6WvwK913fXq7g@mail.gmail.com>
        (Felipe Contreras's message of "Thu, 3 Dec 2020 03:07:59 -0600")
Message-ID: <xmqq7dpyix1d.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 54362F1E-3592-11EB-A41F-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> In other words: --rebase should disable the --ff-only mode.
>
> Also, we would want --no-rebase to disable the default --ff-only mode.

Yes, and for that a configured pull.rebase counts the same as a
command line option.  As you agreed earlier in the part omitted from
the quote with my "I would have expected...", we want to say:

    There are two ways to consolidate your own work with the history
    of the other side, that gives a result in vastly different
    shapes that suit for different workflows, and "git pull" will
    not choose between them for you.  Unless you say which one
    between rebase and merge you want to use, it will work only for
    fast-forward updating from the other side and nothing else.

and the "default to --ff-only when the user does not say" is a means
to do so.  When the end-user gives an explicit preference between
the merge/rebase, none of the above would apply.

> That would require changing the semantics of --ff-only, so that "git
> pull --no-rebase --ff-only" doesn't make sense (as --ff-only is
> overridden by --no-rebase).

I do not think such a conclusion follows from "we do not want to use
the 'by default force the --ff-only' when the user chooses between
merge and rebase".  Specifically, I do not agree with "as --ff-only
is overridden" in your statement.

When the end user says "git pull --no-rebase --ff-only", it means to
me:

    I choose not to use rebase---my preference is to merge in the
    other history into mine, and I want to reject any non-fast
    update in this invocation.

and I find it quite sensible, especially in a modern world where you
practically must set pull.rebase to one way or the other.  A
developer X, an individual contributor to the project who uses
rebase most of the time, may use "git pull --no-rebase" from
somebody else's repository (i.e. not X's "upstream") when a help is
offered by another developer Y who forked from X to advance X's
work.  If the upstream project does not want to see merge commits in
a side branch (i.e. the history X offers to the project), X may ask
Y to make sure Y builds on top of the whole of X's work, and adding
"--ff-only" to the command line would be a way to make sure the
result is fast-forward.

> If we do this, then the only time where --ff-only would make sense is
> in "git pull --ff-only" (no --rebase or --no-rebase), and if we change
> the semantics this way, then there's no need for my suggested
> pull.mode (although it still might be desired).
>
> Moreover, I see no tests that check for this new behavior.

A proposal to change behaviour needs to come with tests to protect
new behaviour before we can merge, but we should be more lenient on
a patch with RFC label on it ;-).

Apparently the patch had me say "I am not seeing what problem this
tries to solve, exactly", and a test may have helped to demonstrate
the intention of the change better, even in its RFC state.

