Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC9E71F87F
	for <e@80x24.org>; Fri, 16 Nov 2018 05:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbeKPQGK (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Nov 2018 11:06:10 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56897 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727326AbeKPQGK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Nov 2018 11:06:10 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BDA8110A0AD;
        Fri, 16 Nov 2018 00:55:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VXR2wXhR68WAeTPqlRAzo2K/4/c=; b=AbCvB4
        RrmKCkZFGHazvCAQYR9NpNA4a3dFJRo/kF4+N1hoU82tkS+eWsuteEJsXQOR2TNW
        s6fQ6Wj8yXgzkC7cLi5cPIyhl/dLx/tYrHD+Tnn4aCP7U2YijVP9RixQVYeB/iwb
        38St+OQNKePzri/auurf3CtjrMpKRNaz8PsfY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=n3Kvk376DXUSDCHzwz4+MCidBZOHO1Al
        BZ0/niVgQSmsDoD+MteDqtxsvQZVmu5GmAPR1A86U6NedEFNQvMt90P35q6lKRcE
        UUMMfwTXPRl17qgeuVNPbk5zK7KMebRgcAcj8os8sO4qOKVik0SJvEyIekZKlWRB
        c6b5V78Eu/E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B3FDF10A0AC;
        Fri, 16 Nov 2018 00:55:10 -0500 (EST)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2870510A0AB;
        Fri, 16 Nov 2018 00:55:10 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Slavica Djukic <slavicadj.ip2018@gmail.com>
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        slawica92@hotmail.com
Subject: Re: [PATCH v2 1/2] [Outreachy] t3903-stash: test without configured user.name and user.email
References: <20181114221218.3112-1-slawica92@hotmail.com>
        <20181114222524.2624-1-slawica92@hotmail.com>
Date:   Fri, 16 Nov 2018 14:55:08 +0900
In-Reply-To: <20181114222524.2624-1-slawica92@hotmail.com> (Slavica Djukic's
        message of "Wed, 14 Nov 2018 23:25:24 +0100")
Message-ID: <xmqqsh01k1mr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2D5B93C4-E964-11E8-A321-063AD72159A7-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Slavica Djukic <slavicadj.ip2018@gmail.com> writes:

> +test_expect_failure 'stash works when user.name and user.email are not set' '
> +	git reset &&
> +	git var GIT_COMMITTER_IDENT >expected &&

All the other existing test pieces in this file calls the expected
result "expect"; is there a reason why this patch needs to be
different (e.g. 'expect' file left by the earlier step needs to be
kept unmodified for later use, or something like that)?  If not,
please avoid making a difference in irrelevant details, as that
would waste time of readers by forcing them to guess if there is
such a reason that readers cannot immediately see.

Anyway, we grab the committer ident we use by default during the
test with this command.  OK.

> +	>1 &&
> +	git add 1 &&
> +	git stash &&

And we make sure we can create stash.

> +	git var GIT_COMMITTER_IDENT >actual &&
> +	test_cmp expected actual &&

I am not sure what you are testing with this step.  There is nothing
that changed environment variables or configuration since we ran
"git var" above.  Why does this test suspect that somebody in the
future may break the expectation that after running 'git add' and/or
'git stash', our committer identity may have been changed, and how
would such a breakage happen?

> +	>2 &&
> +	git add 2 &&
> +	test_config user.useconfigonly true &&
> +	test_config stash.usebuiltin true &&

Now we start using use-config-only, so unsetting environment
variables will cause trouble when Git insists on having an
explicitly configured identities.  Makes sense.

> +	(
> +		sane_unset GIT_AUTHOR_NAME &&
> +		sane_unset GIT_AUTHOR_EMAIL &&
> +		sane_unset GIT_COMMITTER_NAME &&
> +		sane_unset GIT_COMMITTER_EMAIL &&
> +		test_unconfig user.email &&
> +		test_unconfig user.name &&

And then we try the same test, but without environment or config.
Since we are unsetting the environment, in order to be nice for
future test writers, we do this in a subshell, so that we do not
have to restore the original values of environment variables.

Don't we need to be nice the same way for configuration variables,
though?  We _know_ that nobody sets user.{email,name} config up to
this point in the test sequence, so that is why we do not do a "save
before test and then restore to the original" dance on them.  Even
though we are relying on the fact that these two variables are left
unset in the configuration file, we unconfig them here anyway, and I
do think it is a good idea for documentation purposes (i.e. we are
not documenting what we assume the config before running this test
would be; we are documenting what state we want these two variables
are in when running this "git stash"---that is, they are both unset).

So these later part of this test piece makes sense.  I still do not
know what you wanted to check in the earlier part of the test,
though.

> +		git stash
> +	)
> +'
> +
>  test_done
