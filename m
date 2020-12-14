Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD81C4361B
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 23:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 270EE22512
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 23:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393073AbgLNXPF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Dec 2020 18:15:05 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51684 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392978AbgLNXPB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 18:15:01 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 42FAE10E495;
        Mon, 14 Dec 2020 18:14:17 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IIHOGTOzOpMhe5HnutZIksIPkp8=; b=IF1K8m
        3rBlWVbDEfZu6X9PP7FpVgutyD9Smf4wXldtvbKjDc6RarKlta6bTG8r+0o36nYr
        XPYClnAQZFz+Gy1OE5SB+nZ4Qn+H8PjfYzgK5Vte75+cFwjk6tGONFX7+So+zqRI
        4uDOIx1YVn2veUvx7edIdCycySee9H0vYgQiw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FHBp6rOFIx1AuireWdebUR9S+F549mBU
        PJKqGT3CbhNPtubPezY6jnnyp9fkJjJedrQJG0aAteVfLJZ5c7HLX2QTpflTI/fv
        aRKlwjHhMEjXmi5vHxvFiipv2IDRjQX9W+pe1V8nzdkwL9uN6lduGIv9waHHzpyc
        /gXMbLCLlJ0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3A03C10E494;
        Mon, 14 Dec 2020 18:14:17 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8226510E490;
        Mon, 14 Dec 2020 18:14:14 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?Q?V=C3=ADt?= Ondruch <vondruch@redhat.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        John Keeping <john@keeping.me.uk>,
        Richard Hansen <rhansen@rhansen.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH v2 02/14] pull: improve default warning
References: <20201204061623.1170745-1-felipe.contreras@gmail.com>
        <CABPp-BF4rXBOKsn8bG6y3QUEtNVV9K2Pk5NmwrU5818CqhRt_Q@mail.gmail.com>
        <CAMP44s2L24jhCG9ps72--ZiJkXUovR726jCf8JTLHAs0jV7Whg@mail.gmail.com>
        <CABPp-BGdNt8TBMTE9zvaicF5AtvyTBhpiJXqkuZc7mBLGbw0Qw@mail.gmail.com>
        <xmqqeek2cc14.fsf@gitster.c.googlers.com>
        <CAMP44s2XFQoda_PMULWha-rj9HhNfEddO5fikmswk9=AWN4RCw@mail.gmail.com>
        <xmqqpn3lbhxn.fsf@gitster.c.googlers.com>
        <CAMP44s2nmVnXiBA8S=vHBZznuRNKKe=xGOEBJ80MYhA_XCqNkg@mail.gmail.com>
        <xmqqlfe99yvy.fsf@gitster.c.googlers.com>
        <CA+P7+xp=UGd0iK8uLxnqH0iycrxo--8on3d0Z+jsuyhpV-fVew@mail.gmail.com>
        <xmqq360h8286.fsf@gitster.c.googlers.com>
        <CAMP44s3KCoDfRXzarJw5AE7UsY-=eP6GbHzdDcdrs2rsw5tL+w@mail.gmail.com>
        <xmqqy2i86ok1.fsf@gitster.c.googlers.com>
        <CAMP44s13YFZeOMz6V5sPdOnLXD-v3aQZiP7vvXXNfQLZP4Puwg@mail.gmail.com>
        <CABPp-BGZcmHhge7JnM12baL_86yV-+7z4kkvFwUUrP+db8QD8Q@mail.gmail.com>
        <xmqqy2i6w45c.fsf@gitster.c.googlers.com>
        <CAMP44s3NNDL+zJjaukV9D2dJyU=ugSrnWz9o-whO9hKnBTxAow@mail.gmail.com>
        <xmqqtussirsl.fsf@gitster.c.googlers.com>
        <CAMP44s3CcNAT4dFogyo61zV+D1pZ-0K+1rDBk_BUk-RYVUW0RQ@mail.gmail.com>
        <xmqqh7ooje03.fsf@gitster.c.googlers.com>
        <5fd7e77c78e06_d59852083e@natae.notmuch>
Date:   Mon, 14 Dec 2020 15:14:12 -0800
In-Reply-To: <5fd7e77c78e06_d59852083e@natae.notmuch> (Felipe Contreras's
        message of "Mon, 14 Dec 2020 16:30:20 -0600")
Message-ID: <xmqqzh2g9e0r.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 15087896-3E62-11EB-8AAF-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> We do not have to or implement both, but either should give us the
>> "when pull sees a non-ff history, it should stop without merging or
>> rebasing, and the user won't be given the advice on how to choose
>> between merge and rebase" behaviour, I would think.
>
> Right, so both should error out.

One of them, not both; the one we choose to implement would make it
fail, I would think.

> And what should these do?
>
>   git -c pull.rebase=no -c pull.ff=only pull --merge

There is no --merge, so let's reread with s/--merge/--no-rebase/;
the command line would be saying "I only want to fast-forward, or I
want the command to fail".  The advice code should not trigger
(i.e. we gave an explicit preference to merge and not to rebase, so
rebase_unspecified would be false), but the configured preference
that says "we take only fast-forward merges" will still be in effect.
If the history is fast-forward, the merge backend will happily
advance our history.  If not, the merge backend will happily fail
the pull.

If you want to countermand the configured preference from the
command line and allow a merge to be done when non-ff history is
given, what you'd need to override is not --merge/--no-rebase.  The
configuration pull.rebase=no already says you do not want rebase and
you want merge).  You want to override --ff-only, so I'd expect
"pull --ff" (or "pull --no-ff") to be how you override your
configured preference and merge in a non-ff history, either by fast
forwarding or creating an extra merge commit.

>   git -c advice.pullnonff=false pull --merge

Again with s/--merge/--no-rebase/; but that is showing the
preference not to rebase and to merge from the command line, so
shouldn't it just go ahead and merge without any advice?


> I'm going to answer because I think it's obvious what you would expect:
> if you pass --merge, both should succeed.
>
> Except they won't, because "git pull --ff-only --merge" fails.
>
> Correct?

See above.

