Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92586C6379D
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 02:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A3C220BED
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 02:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cdhgFr0o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgKTCdq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Nov 2020 21:33:46 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56114 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgKTCdp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Nov 2020 21:33:45 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5B9AD84367;
        Thu, 19 Nov 2020 21:33:43 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+2IEARutyABRilzZey7bF11snI8=; b=cdhgFr
        0os8LjJL6w3IwtHMSWmMzufEsmpCoHKlMP9qat6+M+h2FnRoHj9GLnCUOB+KybT2
        lqqst7ei0U65dHliXCNtCZUSbsG0e1aqg4TYS1qmm4JAgpr3RRuLYAz7dkfcxh4X
        MWktafppgDnf3NyEQg0WS30uz18oq0uUxPwAk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PcuKo2QS8w3Wqh8vlNAca8FulogTBZzX
        7keM2O+BXAuDauylrT1Td+CnPTgdYxIQe8pA8wVTc9zDDNOsq9H02/s7jjrKdhmL
        ernwwsfa+IiF30k4WflY4IzRK9uc/SxuOqL5pp7uNyTzCx+0VvpOWsY0pgXcFPab
        DNTMbjYD4yE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5186084365;
        Thu, 19 Nov 2020 21:33:43 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CF5F284362;
        Thu, 19 Nov 2020 21:33:42 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/7] t1300: test "set all" mode with value_regex
References: <pull.796.git.1605801143.gitgitgadget@gmail.com>
        <2da2131114eb47e70ccaf8fb9c51bf7fb5b173b0.1605801143.git.gitgitgadget@gmail.com>
        <xmqqo8jtvvby.fsf@gitster.c.googlers.com>
        <20201120020924.GF389879@camp.crustytoothpaste.net>
Date:   Thu, 19 Nov 2020 18:33:42 -0800
In-Reply-To: <20201120020924.GF389879@camp.crustytoothpaste.net> (brian
        m. carlson's message of "Fri, 20 Nov 2020 02:09:24 +0000")
Message-ID: <xmqq8sawvjsp.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CE603C90-2AD8-11EB-8C8D-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2020-11-19 at 22:24:33, Junio C Hamano wrote:
>> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> 
>> > +test_expect_success 'set all config with value_regex' '
>> > +	q_to_tab >initial <<-\EOF &&
>> > +	[abc]
>> > +	Qkey = one
>> > +	EOF
>> > +
>> > +	cp initial .git/config &&
>> 
>> Not a new problem with this patch, but does the above pattern
>> introduce potential problems?  I am wondering if overwriting the
>> config file with a little piece that has only the stuff the test is
>> interested in, while wiping the parts that may be essential for
>> repository integrity (e.g. "extensions.objectFormat"), is OK in the
>> long run (brian cc'ed for his sha256 work).  There also are
>> autodetected crlf settings etc. that are in the .git/config when a
>> test repository is created, and we probably would want to keep them
>> intact.
>
> I haven't looked at the code, but if you're just using git config in a
> test, then overwriting the config file shouldn't be a problem with
> SHA-256.  If you're trying to read or write objects or the index, then
> that's definitely a problem, and you'll definitely notice exciting
> failures if you do that.

Yes, that is exactly what worries me.

And I was trolling for ideas from those on cc: list to come up with
a better convention to test the behaviour of "git config".  I think
taking "git config --list [--file FILE]" before and after the ops of
interest and basing the good/bad decision on the difference would be
a saner approach.  It obviously relies on "git config --list" to be
working correctly, which the current approach that uses hardcoded
"initial" state and expects result that is byte-for-byte identical
to a hardcoded file contents after the ops does not have to rely on,
but at the same time, the current approach assumes too much on the
actual file format (e.g. no user or script would care how "key =
val" line is indented, but the current approach insists that they
are indented exactly with one tab), so overall it may even be an
improvement.

Thanks.



