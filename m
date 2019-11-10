Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C0361F454
	for <e@80x24.org>; Sun, 10 Nov 2019 06:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbfKJG7D (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Nov 2019 01:59:03 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65501 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbfKJG7C (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Nov 2019 01:59:02 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A564EAB065;
        Sun, 10 Nov 2019 01:58:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+a5rvN1HSyaHx1q3ydpZHr/NHWs=; b=rkjN4G
        q0H1eGekOR5lESpAyF8Kj0xQddXBG0z/BJbVDY+4o7LtY26BeJQeRiwFnalfoy+O
        LqS/3JiJO2+/0AbcD9ZKSiYAOBzjYp/t54Q5lDhMUiN1ow7zWjQJaPGY14dvWKQY
        qSf7diXZ4PS7iPperO7abkNoVe5CcyGpKEs/U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eZ4aP0Bsay6A10ninfHaQ7JojTVoHX30
        PJAhIi/+OCX0OGcuIE9v7slf0KFbfRb6cGIA/6EjaKhYGe/K9o2kkqQB2jmMzwzk
        +fkmzYnrSpqsZK+52LFGq7r96NuK9MUrnk9zKjRpHsEXflStwoIlCsA90QJmlQHA
        50GCqIcuP0s=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 925C0AB064;
        Sun, 10 Nov 2019 01:58:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B5C21AB063;
        Sun, 10 Nov 2019 01:58:54 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v4 01/14] t: teach test_cmp_rev to accept ! for not-equals
References: <cover.1571739459.git.liu.denton@gmail.com>
        <cover.1573152598.git.liu.denton@gmail.com>
        <0d0696f310a6f8e13ed480b1a1e91cdc2debaa20.1573152599.git.liu.denton@gmail.com>
        <xmqqpni3nj8j.fsf@gitster-ct.c.googlers.com>
        <20191108082310.GA2497@generichostname>
        <xmqqa796mt35.fsf@gitster-ct.c.googlers.com>
        <20191108211909.GA80210@generichostname>
Date:   Sun, 10 Nov 2019 15:58:52 +0900
In-Reply-To: <20191108211909.GA80210@generichostname> (Denton Liu's message of
        "Fri, 8 Nov 2019 13:19:09 -0800")
Message-ID: <xmqq8sookyj7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8F4834FA-0387-11EA-B557-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Hi Junio,
>
> On Fri, Nov 08, 2019 at 09:49:02PM +0900, Junio C Hamano wrote:
>> Denton Liu <liu.denton@gmail.com> writes:
>>
>> >> >  		local r1 r2
>> >> >  		r1=$(git rev-parse --verify "$1") &&
>> >> >  		r2=$(git rev-parse --verify "$2") &&
>> >>
>> >> If either of the calls fail, the assignment itself would fail, and
>> >> the &&-cascade would stop without executing the if statment below.
>> >>
>> 	r1=$(git rev-parse --verify "$1") ||
>> 		error "'$1' does not name a valid object"
>> 	r2=$(git rev-parse --verify "$2") ||
>> 		error "'$2' does not name a valid object"
>> 	if ! test "$r1" $op "$r2"
>> 	then
>> 		... they do not compare the same ...
>> 	fi
>
> With your suggestion, we actually introduce subtle undesired behaviour.
> The `error` calls don't actually exit the function early. To make it
> work, we need to add && to the end of the `error` calls.

Not &&-at-the-end, but yes, we'd need some early return after
noticing a bad input from the caller.

You said earlier that one of the issues that motivated you to update
the helper was that this obvious typo

	r1=... r2= ... &&
	! test_rev_cmp "$r1" "$rr2"

would not be noticed.  For such a fix, I do not think it is
sufficient to tweak the return value from the test_rev_cmp
helper function if we allow callers to expect failure like so.

And for that reason, your "allow 'test_rev_cmp ! R1 R2' syntax" part
of the change makes quite a lot of sense.  That again allows the
callers to rely on failure return from test_rev_cmp as an error.

> I'm wondering why we want to do this, though. rev-parse should already
> output an error message on stderr in the case where the rev-parse fails.
>
> I guess the error message of "fatal: Needed a single revision" could
> probably be improved but that feels like an improvement that should be
> targeted to rev-parse.

Not really.  The callers of rev-parse plumbing should expect that
exact string, if they want to differenciate different errors from
the program.


	r1=$(git rev-parse --verify "$1") &&
	r2=$(git rev-parse --verify "$2") || return 1

before we start the comparison between $r1 and $r2 may be a good way
to clarify the intent of the code.  Using "&&" instead of "|| return"
and letting the whole function fail would not be incorrect, though.

Thanks.


