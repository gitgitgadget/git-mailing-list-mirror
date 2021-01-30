Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78CD3C433E0
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 18:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A5A264E13
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 18:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbhA3S5i (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Jan 2021 13:57:38 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64401 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbhA3S5h (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jan 2021 13:57:37 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8955010C816;
        Sat, 30 Jan 2021 13:56:53 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BiWx3XGY6ZnPcygqi3Dwx9rItQk=; b=SLlLDc
        BKjmCi0QD5cJAxZC+JmHIajNrW1J2455li+asQKgJExUY+hIdhEKtN2S0a23wvLa
        AbDWqEopMlwrz47eEJmweyRrexFVNjFpyGsRDYDBlAuyahZzW19Wd2jSes1q55uh
        peJGF/V9vbCCpYF2oBjWVPPQcyMieF1VsLaF4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WO7iU6Lr+jpnjNSkXUPRPJXtrgQGAX6Z
        4kN9E+U/cSKWRw2UH2rFZZ+4xL6rTaUk2mmpeLDu9WSCN0zHmM8MrkCYGrB7oWHT
        QxBIdyzVJ9qTi18ZZgEdbDbTXl1M+uT6PBfyQu8yWLpyyUCGP6ZrGjlEB28etwt/
        +lfju3yvw8Q=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 70F4110C815;
        Sat, 30 Jan 2021 13:56:53 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BB13C10C814;
        Sat, 30 Jan 2021 13:56:50 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Kyle J. McKay" <mackyle@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 1/2] t/t1417: test symbolic-ref effects on ref logs
References: <7c7e8679f2da7e1475606d698b2da8c@72481c9465c8b2c4aaff8b77ab5e23c>
        <fec7ef37962da584a89012234ae4a1a@72481c9465c8b2c4aaff8b77ab5e23c>
Date:   Sat, 30 Jan 2021 10:56:48 -0800
In-Reply-To: <fec7ef37962da584a89012234ae4a1a@72481c9465c8b2c4aaff8b77ab5e23c>
        (Kyle J. McKay's message of "Sat, 30 Jan 2021 03:19:08 -0700")
Message-ID: <xmqqa6sqp827.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E93DFC8C-632C-11EB-AA4B-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Kyle J. McKay" <mackyle@gmail.com> writes:

> The git command `git symbolic-ref <refname1> <refname2>` updates
> <refname1> to be a "symbolic" pointer to <refname2>.  No matter
> what future value <refname2> takes on, <refname1> will continue
> to refer to that future value since it's "symbolic".

Correct.  While you are on the my-topic branch, HEAD (that's the
<refname1> in your description) points at refs/heads/my-topic
(that's the <refname2> in your description).

And when you create a new commit from this state, the logs of these
two refs will gain one entry each.  "git log HEAD@{now} would show
the recent progress of HEAD, "git log my-topic@{now}" would show the
recent progress of my-topic ("my-topic@"now}" can also be spelled as
"@{now}).

The <refname1> (HEAD) will keep referring to <refname2> (my-topic)
until you switch branches, and does not change even if <refname2>
points at a different commit, as it is "symbolic".

> Since commit 523fa69c36744ae6 ("reflog: cleanse messages in the refs.c
> layer", 2020-07-10, v2.29.0), the effect of using the aforementioned
> "symbolic-ref" command on ref logs has changed in an unexpected way.

Please explain "in an unexpected way" here in the log message.  Not
every reader can read your mind and would expect the same as you do.

The said commit came as part of this topic, ...

https://lore.kernel.org/git/pull.669.v2.git.1594401593.gitgitgadget@gmail.com/

... so I've added the true author of it on the Cc: list.

> Add a new set of tests to exercise and demonstrate this change
> in preparation for correcting it (at which point the failing tests
> will be flipped from `test_expect_failure` to `test_expect_success`).

We usually prefer not to do the two-step "expect_failure first and
then in a separate patch flip that to _success", as it makes it hard
to see the "fix" step (because the change in the test would be shown
only 3 lines before and after _failure->_success line, and what the
test is doing cannot be seen in the patch by itself).

Thanks.

