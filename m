Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A49A41F461
	for <e@80x24.org>; Tue, 25 Jun 2019 20:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbfFYUpG (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 16:45:06 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62641 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfFYUpG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 16:45:06 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 19CEA6E3CF;
        Tue, 25 Jun 2019 16:45:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MgTB8/qSYRx3P1Lo1jBsosal9Ok=; b=a9Sad5
        l/OqeQePmU2eCE+SfQ96rsqW8Gf9Xti8cFLOjTdUKnPnsNxR1yufN7dJzwgkm2nv
        BBq5+kp8iq2yKeY1PUm7QfUrtrhus9xZXxNCxusSNG5z7azrir7gXkdqqQoRE+JR
        jYIys62yiTZcOW9s90TwCPp80qNR/roARc64w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=S4Uz/AqHORRuUUTt2Nd1fuMZzYi0vfvl
        4wxg42DO+98+UQHcISukOIbduhVb0WBfVugs8Pp2nX/YdmWJ5FenIqn6JPk4rdad
        0VSkTwZrNn64ZYLWmrl444C+qhL9KMyATv/1VjHMfbp+Qd1J8ePu+gccNuQTYucm
        /GaxK6HQXeQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EE3726E3CD;
        Tue, 25 Jun 2019 16:45:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EC6FB6E3CC;
        Tue, 25 Jun 2019 16:44:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 3/3] status: do not report errors in sequencer/todo
References: <pull.275.git.gitgitgadget@gmail.com>
        <af4b823caac84899b5ac71da61af5ec00f88bb2f.1561457483.git.gitgitgadget@gmail.com>
Date:   Tue, 25 Jun 2019 13:44:55 -0700
In-Reply-To: <af4b823caac84899b5ac71da61af5ec00f88bb2f.1561457483.git.gitgitgadget@gmail.com>
        (Phillip Wood via GitGitGadget's message of "Tue, 25 Jun 2019 03:11:26
        -0700 (PDT)")
Message-ID: <xmqqo92le6ns.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1842B150-978A-11E9-883A-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> commit 4a72486de9 ("fix cherry-pick/revert status after commit",
> 2019-04-16) used parse_insn_line() to parse the first line of the todo
> list to check if it was a pick or revert. However if the todo list is
> left over from an old cherry-pick or revert and references a commit that
> no longer exists then parse_insn_line() prints an error message which is
> confusing for users [1]. Instead parse just the command name so that the
> user is alerted to the presence of stale sequencer state by status
> reporting that a cherry-pick or revert is in progress.

I have to wonder what would happen when "git cherry-pick --continue"
is given from such a stale state.  It would have to fail as it would
not know the shape of the change to be replayed, no?  

Is it easy to detect and say "there is an abandoned state file from
stale cherry-pick" and optionally offer to remove it (as we have no
chance of continuing anyway)?

Or is it likely that such an effort would end up being wasted, as...

> Note that we should not be leaving stale sequencer state lying around
> (or at least not as often) after commit b07d9bfd17 ("commit/reset: try
> to clean up sequencer state", 2019-04-16).

...this already happened?

> Also avoid printing an error message if for some reason the user has a
> file called `sequencer` in $GIT_DIR.

I agree that it is not a good place for giving diagnostics, but
getting ENOTDIR would be an indication that next time when the user
wants to do a rebase, range pick or range revert, it would not work
unless somebody removes that `sequencer` file, right?  Are our users
sufficiently covered on that front (e.g. giving "we cannot do this
operation as $GIT_DIR/sequencer is in the way. please remove that
file" would be OK, but silently removing and possibly losing info we
didn't even look at may be bad)?

In any case, the "unable to open 'sequencer/todo'" you are removing
with this patch was *not* about helping the issue above which is an
unrelated tangent, so let me not be distracted by that ;-)

> +test_expect_success 'status shows cherry-pick with invalid oid' '
> +	mkdir .git/sequencer &&
> +	test_write_lines "pick invalid-oid" >.git/sequencer/todo &&
> +	git status --untracked-files=no >actual 2>err &&
> +	git cherry-pick --quit &&
> +	test_must_be_empty err &&
> +	test_i18ncmp expected actual
> +'
> +
> +test_expect_success 'status does not show error if .git/sequencer is a file' '
> +	test_when_finished "rm .git/sequencer" &&

In short, I was wondering what happens if we lose this line, and
then we later had a command that needs to use .git/sequencer/todo or
something.

> +	test_write_lines hello >.git/sequencer &&
> +	git status --untracked-files=no 2>err &&
> +	test_must_be_empty err
> +'
> +
>  test_expect_success 'status showing detached at and from a tag' '
>  	test_commit atag tagging &&
>  	git checkout atag &&
