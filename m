Return-Path: <SRS0=B37d=3G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6199FC33C9E
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 18:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 332ED2082F
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 18:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Oooytjvs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgAQSaJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jan 2020 13:30:09 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57432 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbgAQSaJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jan 2020 13:30:09 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D86D738211;
        Fri, 17 Jan 2020 13:30:05 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZFOdDXQNitrv9vHANv9M1/Sg1Cs=; b=Oooytj
        vsExmTiXTZq8qDciaBR1EYBW5KEL7vZWBBZAx7zgSd5arJ82nzCh96Tj9Io/3PqM
        vNGsLpLGKHwVEGF+KUx2wnMgHQbOTWI9UGVysEz07wmd9/1o4LCblCUhlhCVTUfk
        /qTHlWxsM843sqspkh0NRvv0dWWcC5lUZLQpI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uMvFyn7ik6C3dzF+gVu4TuA3djJlDWGW
        +qC9p7xcN3zPyKuycOfcUNqZ2OG/gT3kuXU6m5a6GDA/kziGWCdiM2ZvQanee26C
        9aMdUs4r1gn3Mc06Dq59SmO5lyURRAN2X6I6jEJIllM6BFwiHBP6sLgEzGfgKouX
        BCjQ+dgZrIQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1C93D3820E;
        Fri, 17 Jan 2020 13:30:05 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E987F38204;
        Fri, 17 Jan 2020 13:30:01 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Alban Gruin <alban.gruin@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/3] rebase -i: re-fix short SHA-1 collision
References: <pull.529.git.1579209506.gitgitgadget@gmail.com>
        <ad50cd1b92e3e52309536f3a84064571a224a0da.1579209506.git.gitgitgadget@gmail.com>
Date:   Fri, 17 Jan 2020 10:30:00 -0800
In-Reply-To: <ad50cd1b92e3e52309536f3a84064571a224a0da.1579209506.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Thu, 16 Jan 2020
        21:18:25 +0000")
Message-ID: <xmqqimladjh3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5FC369EC-3957-11EA-89E3-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> However, the bug resurfaced as a side effect of 393adf7a6f6 (sequencer:
> directly call pick_commits() from complete_action(), 2019-11-24): as of
> this commit, the sequencer no longer re-reads the todo list after
> writing it out with expanded commit IDs.

Ouch.  The analysis above is quite understandable.

> @@ -5128,6 +5128,18 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
>  		return -1;
>  	}
>  
> +	/* Expand the commit IDs */
> +	todo_list_to_strbuf(r, &new_todo, &buf2, -1, 0);
> +	strbuf_swap(&new_todo.buf, &buf2);
> +	strbuf_release(&buf2);
> +	new_todo.total_nr -= new_todo.nr;
> +	if (todo_list_parse_insn_buffer(r, new_todo.buf.buf, &new_todo) < 0) {
> +		fprintf(stderr, _(edit_todo_list_advice));
> +		checkout_onto(r, opts, onto_name, &onto->object.oid, orig_head);
> +		todo_list_release(&new_todo);
> +		return error(_("invalid todo list after expanding IDs"));
> +	}

The above happens after edit_todo_list() returns and then the
resulting data (i.e. new_todo) that came from the on-disk file has
been parsed with an existing call to todo_lsit_parse_insn_buffer()?

I am wondering when this if() statement would trigger, iow, under
what condition the result of "Expand the commit IDs" operation fails
to be parsed correctly, and what the user can do to remedy it.
Especially given that incoming new_todo has passed the existing
parse and check without hitting "return -1" we see above in the
context, I am not sure if there is anything, other than any
potential glitch in the added code above, that can cause this second
parse_insn_buffer() to fail.  Shouldn't the body of if() be simply a
BUG()?

Or am I somehow missing a hunk that removes an existing call to
parse&check?

> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index ae6e55ce79..1cc9f36bc7 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -1264,13 +1264,24 @@ test_expect_success SHA1 'short SHA-1 setup' '
>  test_expect_success SHA1 'short SHA-1 collide' '
>  	test_when_finished "reset_rebase && git checkout master" &&
>  	git checkout collide &&
> +	colliding_sha1=6bcda37 &&
> +	test $colliding_sha1 = "$(git rev-parse HEAD | cut -c 1-7)" &&
>  	(
>  		unset test_tick &&
>  		test_tick &&
>  		set_fake_editor &&
>  		FAKE_COMMIT_MESSAGE="collide2 ac4f2ee" \
> -		FAKE_LINES="reword 1 2" git rebase -i HEAD~2
> -	)
> +		FAKE_LINES="reword 1 break 2" git rebase -i HEAD~2 &&
> +		test $colliding_sha1 = "$(git rev-parse HEAD | cut -c 1-7)" &&
> +		grep "^pick $colliding_sha1 " \
> +			.git/rebase-merge/git-rebase-todo.tmp &&
> +		grep "^pick [0-9a-f]\{40\}" \
> +			.git/rebase-merge/git-rebase-todo &&
> +		git rebase --continue
> +	) &&
> +	collide2="$(git rev-parse HEAD~1 | cut -c 1-4)" &&
> +	collide3="$(git rev-parse collide3 | cut -c 1-4)" &&
> +	test "$collide2" = "$collide3"
>  '
>  
>  test_expect_success 'respect core.abbrev' '
