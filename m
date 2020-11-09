Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E109C2D0A3
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 19:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3782206B6
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 19:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uH6Q9d4H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729875AbgKITxy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 14:53:54 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57442 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbgKITxx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 14:53:53 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2D18B9190D;
        Mon,  9 Nov 2020 14:53:50 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nS44FiySmYNUvdDVr9sygEqT2RM=; b=uH6Q9d
        4Hx3XRIowkCQfkGPgUkokv60kR9Wvc5z8Cfhv+Ozi/nnCjBc8RipxmJO0Py4Ze/O
        iudi6VvpyYbqJVboxbY/dP4IOlSP6+1kuAUmCSAl7Rl5oxWbGg+CKRqkiUz53Wiw
        9J/xaYY7/JjqUu2FmQWJAkjS1sQW/OuNwW7II=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XoJPQuCJWkFjOfJZ06Oh1Sh1cdtYIhy8
        T+004zc6MHBtnFocsEEAPzzSl006otFwiNo8lXTZWejbAKh7x35mX5G6fHJbx/Ha
        42AtICYNnTWG3dM9ZPonDhci+B8ZWNQOP5kaJqPmz+Gw3lbUUBwqZdtCH5z0s9OH
        Mx4h2CrPu3M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 247A69190C;
        Mon,  9 Nov 2020 14:53:50 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A381F9190B;
        Mon,  9 Nov 2020 14:53:49 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v2 4/4] update-ref: Disallow restart of ongoing
 transactions
References: <cover.1604501265.git.ps@pks.im> <cover.1604908834.git.ps@pks.im>
        <d9abffef71466a0752c210878bb6b8fca7a72287.1604908834.git.ps@pks.im>
Date:   Mon, 09 Nov 2020 11:53:48 -0800
In-Reply-To: <d9abffef71466a0752c210878bb6b8fca7a72287.1604908834.git.ps@pks.im>
        (Patrick Steinhardt's message of "Mon, 9 Nov 2020 11:07:01 +0100")
Message-ID: <xmqqlffab92r.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4932203A-22C5-11EB-8208-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> Subject: Re: [PATCH v2 4/4] update-ref: Disallow restart of ongoing transactions

Our convention (cf. "git shortlog --no-merges") is not to Capitalize
the first word after the "<area>:".  Shared across all four patches.

> It is currently possible to write multiple "start" commands into
> git-update-ref(1) for a single session, which doesn't make a lot of
> sense to do in the first place. It's also not quite obvious what should
> actually happen. Would this just go on with the current transaction as
> if nothing was written or would it recreate a new session which doesn't
> yet have any references? Silently ignoring this usage isn't helping
> either as it may indicate erroneous use of the interface.
>
> This commit catches this use and instead raises an error if the user is
> trying to restart an ongoing transaction.

Hmph, if you think of it as "restart", perhaps it would not make
sense, but in other contexts where the concept of "transactions" are
commonly used, it is not so unusual to support "nested" transactions
where inside an ongoing transaction, a subtransaction whose effect
can be rolled back as a whole, can be opened.  So wouldn't it be
more appropriate to explain this change like so?

    Since we do not support nested transactions, make sure a "start"
    command, seen after we saw "start" that is not closed by either
    "abort" or "commit", is flagged as an error.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/update-ref.c  |  2 ++
>  t/t1400-update-ref.sh | 11 +++++++++++
>  2 files changed, 13 insertions(+)
>
> diff --git a/builtin/update-ref.c b/builtin/update-ref.c
> index bb65129012..6029a80544 100644
> --- a/builtin/update-ref.c
> +++ b/builtin/update-ref.c
> @@ -436,6 +436,8 @@ static void update_refs_stdin(void)
>  		switch (state) {
>  		case UPDATE_REFS_OPEN:
>  		case UPDATE_REFS_STARTED:
> +			if (state == UPDATE_REFS_STARTED && cmd->state == UPDATE_REFS_STARTED)
> +				die("cannot restart ongoing transaction");
>  			/* Do not downgrade a transaction to a non-transaction. */
>  			if (cmd->state >= state)
>  				state = cmd->state;
> diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
> index 7ed41bb328..e53d973d04 100755
> --- a/t/t1400-update-ref.sh
> +++ b/t/t1400-update-ref.sh
> @@ -1583,4 +1583,15 @@ test_expect_success 'transaction can commit after abort' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'transaction cannot restart ongoing transaction' '
> +	cat >stdin <<-EOF &&
> +	start
> +	create refs/heads/restart $A
> +	start
> +	commit
> +	EOF
> +	test_must_fail git update-ref --stdin <stdin >actual &&
> +	test_must_fail git show-ref --verify refs/heads/restart
> +'
> +
>  test_done
