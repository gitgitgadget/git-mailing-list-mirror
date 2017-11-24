Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E35CA20A40
	for <e@80x24.org>; Fri, 24 Nov 2017 05:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752688AbdKXFrk (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Nov 2017 00:47:40 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52180 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751136AbdKXFrk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Nov 2017 00:47:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AA126AC3D0;
        Fri, 24 Nov 2017 00:47:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CeBW80I9fVCmXoiVWBAHP18GuLo=; b=n8Jncd
        cLqCcl707MFTZ/MjHcrF5evKjPvbgYT64V0PnGqaEBP5rF0/O2+I5oUiXwNOMCeV
        CC59uZUIPaXEwVnFmuuM7yAMdMZlM2Tptb1GL1/ucHKLAbB2AMR2gjGHfPZA3qbV
        /V0JlBiNLpq/1IAI04WrRHp3wYlX3Sb29AWmg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=v0XmtTWSuuuX7r1qRUmjKWMh/kvHO0i7
        OmlCZPsvDXHEEwOEr7uYDhgWw8Li2XyLF2D9kmg9FeqI2yE6D4XO/Gz4gGyxNQsl
        a/14+3Q0iFkMU2+9fjMzzxEksph+FfnTDGH93gCu/v5zGbSJWclL/CPcjhBHRRCh
        s7X4CWeSo/k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A21E2AC3CF;
        Fri, 24 Nov 2017 00:47:39 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1810BAC3CE;
        Fri, 24 Nov 2017 00:47:39 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phil Hord <phil.hord@gmail.com>
Cc:     Git <git@vger.kernel.org>, Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH v2] Teach stash to parse -m/--message like commit does
References: <20171122212031.5988-1-phil.hord@gmail.com>
Date:   Fri, 24 Nov 2017 14:47:37 +0900
In-Reply-To: <20171122212031.5988-1-phil.hord@gmail.com> (Phil Hord's message
        of "Wed, 22 Nov 2017 13:20:30 -0800")
Message-ID: <xmqq4lpkp6rq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FB084CAC-D0DA-11E7-A820-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phil Hord <phil.hord@gmail.com> writes:

> `git stash push -m foo` uses "foo" as the message for the stash. But
> `git stash push -m"foo"` does not parse successfully.  Similarly
> `git stash push --message="My stash message"` also fails.  The stash
> documentation doesn't suggest this syntax should work, but gitcli
> does and my fingers have learned this pattern long ago for `commit`.
>
> Teach `git stash` and `git store` to parse -mFoo and --message=Foo
> the same as `git commit` would do.  Even though it's an internal
> function, add similar support to create_stash() for consistency.

I sense some typo around "git store", but I am not exactly sure what
the right spelling should be. "git stash -m..", "git stash save -m..",
"git stash push -m.." and "git stash store -m..", if you want a full
enumeration, but stepping back a bit, mentioning "git stash" ought
to be sufficient.  A need to spell all of them whose handling of -m
you fixed would imply there may be some others whose handling of -m
is still broken, which is not a good place for us to end up with.

> Reviewd-by: Junio C Hamano <gitster@pobox.com>

Heh, I didn't review this version and certainly not its test.  

I didn't see anything questionable there after a quick read, though.

Thanks.



