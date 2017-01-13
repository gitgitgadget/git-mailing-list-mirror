Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C0E020756
	for <e@80x24.org>; Fri, 13 Jan 2017 23:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750770AbdAMX4n (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jan 2017 18:56:43 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51650 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750718AbdAMX4m (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2017 18:56:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 649C25FE17;
        Fri, 13 Jan 2017 18:56:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=cqmKgEzClt76
        vNBeMuxIeR7IJok=; b=KDaz0sTfOn5pSUMuBxRhkbOgckxUL+iqIPVErPqVGi1s
        lXyM5mbw2PAv3HAey2UkhqeMBkeGt/eqd7sWki3m9hxsLNJ0dOMz4mYkVA/+opAG
        1SnD1LGTa+ggI6crgo+oBeqHx1QgxhgLz8eAw1JYF1PHBHqCvNf+y32tOw4an9U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=KkLQse
        GJvDwmHFPTnkuUDL7cVfqzsOd/N+ps0HMJ264bSB0KtJo0aprLXSElfDUSKZS82v
        ZIqccNqsjEt1kY+U/uv6eTQqcrRCEFewU58hn9+sTdQXn/JdQ1wnGuU+2mrN/Pfm
        RF4f6IInjGEovAC6CPQI7Dh30CQfUvwh1hSxU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5C8535FE16;
        Fri, 13 Jan 2017 18:56:24 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ADA555FE13;
        Fri, 13 Jan 2017 18:56:23 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>, git@vger.kernel.org
Subject: Re: [PATCH 2/3] xdiff: -W: include immediately preceding non-empty lines in context
References: <1484324112-17773-1-git-send-email-vegard.nossum@oracle.com>
        <1484324112-17773-2-git-send-email-vegard.nossum@oracle.com>
        <e55dc4dd-768b-8c9b-e3b2-e850d5d521f5@web.de>
        <xmqqeg06hh6z.fsf@gitster.mtv.corp.google.com>
        <c74c260d-1a4d-39f6-a644-4f90a67d6d82@oracle.com>
Date:   Fri, 13 Jan 2017 15:56:22 -0800
In-Reply-To: <c74c260d-1a4d-39f6-a644-4f90a67d6d82@oracle.com> (Vegard
        Nossum's message of "Fri, 13 Jan 2017 21:20:09 +0100")
Message-ID: <xmqqbmvaecpl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E369D566-D9EB-11E6-8995-FE3F13518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vegard Nossum <vegard.nossum@oracle.com> writes:

> The patch will work as intended and as expected for 95% of the users ou=
t
> there (javadoc, Doxygen, kerneldoc, etc. all have the comment
> immediately preceding the function) and fixes a very real problem for m=
e
> (and I expect many others) _today_; for the remaining 5% (who put a
> blank line between their comment and the start of the function) it will
> revert back to the current behaviour, so there should be no regression
> for them.

I notice your 95% are all programming languages, but I am more
worried about the contents written in non programming languages
(Ren=C3=A9 gave HTML an an example--there may be other types of contents
that we programmer types do not deal with every day, but Git users
depend on). =20

I am also more focused on keeping the codebase maintainable in good
health by making sure that we made an effort to find a solution that
is general-enough before solving a single specific problem you have
today.  We may end up deciding that a blank-line heuristics gives us
good enough tradeoff, but I do not want us to make a decision before
thinking.

>> The way "diff -W" codepath used it as if it were always the very
>> first line of a function was bound to invite a patch like this, and
>> if we want to be extra elaborate, I agree that an extra mechanism to
>> say "the line the funcline regexp matches is not the beginning of a
>> function, but the beginning is a line that matches this other regexp
>> before that line" may help.
>>
>> Do we really want to be that elaborate, though?  I dunno.
>
> Adding a regex instead of the simple "blank line" test doesn't seem ver=
y
> difficult to do, but I am doubtful that it will make any difference in
> practice. But that can be done incrementally as well by the people who
> would actually need it (who I strongly suspect do not exist in the firs=
t
> place).

At least, the damage can be limited to the cases we know would work
well if we go that way.
