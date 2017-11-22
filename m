Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D4492036D
	for <e@80x24.org>; Wed, 22 Nov 2017 04:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751549AbdKVEoo (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 23:44:44 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54494 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751767AbdKVEom (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 23:44:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D47A8BC206;
        Tue, 21 Nov 2017 23:44:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Gr9CpCpBxwyeqXjoq6auDI4A8ak=; b=yifHpK
        BIT6vdCTM0x8yeSenIs599ZB/tGUaR4PrWcp6/xdYaAoTM9Q60mm5NLihg1RjIWa
        3wodROWCGBE0g9SMOAP3BX0CDtHTQZiigssGTeg0LH9U/KaIc0fHbQAXEKB8ltCG
        w8/+jl7gx70gd8+nHaoXIJ4RWB7e0Iwxj4Vpg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=O8fCi1qGU1ONijYBt9AmUIJvxGy7NKeA
        FfwpCjAlLhtLOqAuHspzPQ+u8Z3K77u7uY656wovFi4LY3OY0nCqw++nmHMoDO5q
        GfQYYZqn0p61uj3RTblZYWiuWaovenBvvT8fR29hQdD5ZeZYVE68kZUWauTp2xJp
        dCr9VbPPQDQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CCA72BC205;
        Tue, 21 Nov 2017 23:44:41 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4CE66BC204;
        Tue, 21 Nov 2017 23:44:41 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phil Hord <phil.hord@gmail.com>
Cc:     Git <git@vger.kernel.org>, Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH] stash: Learn to parse -m/--message like commit does
References: <20171121232643.8380-1-phil.hord@gmail.com>
Date:   Wed, 22 Nov 2017 13:44:40 +0900
In-Reply-To: <20171121232643.8380-1-phil.hord@gmail.com> (Phil Hord's message
        of "Tue, 21 Nov 2017 15:26:42 -0800")
Message-ID: <xmqqh8tmvs5j.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DA78B004-CF3F-11E7-BC40-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phil Hord <phil.hord@gmail.com> writes:

> `git stash push -m foo` uses "foo" as the message for the stash. But
> `git stash push -m"foo"` does not parse successfully.  Similarly
> `git stash push --message="My stash message"` also fails.  Nothing
> in the documentation suggests this syntax should work, but it does
> work for `git commit`, and my fingers have learned this pattern long
> ago.
>
> Teach `git stash` to parse -mFoo and --message=Foo the same as
> `git commit` would do.
>
> Signed-off-by: Phil Hord <phil.hord@gmail.com>
> ---
>  git-stash.sh | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)

Makes sense.  Thanks.

I wonder if you want to add a trivial test or two for this, if "git
stash [save|push|nothing] -m foo" is already tested.  It appears
that t3903 already has a test that does 'push -m "test message"' and
sees if that appears in the output of "list", which looks like the
ideal place to do so.

