Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDEB7201C2
	for <e@80x24.org>; Tue, 14 Nov 2017 02:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751642AbdKNCDe (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 21:03:34 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65418 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751296AbdKNCDd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 21:03:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EDD6DAB046;
        Mon, 13 Nov 2017 21:03:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=H0oOHHvQq5p0fwvvqD40R8bCpSM=; b=CpCjVb
        UZ8LRID5KP056FG0FD9005mwwPXWdTJG7daAu6Q9bC+Z0UEqrCHMP/KhAT4ONltk
        ZDKhOF51l1aBxwrDg5AGv8k97hcrSl8piDzFSvfvDCrsKe1dPv1/gyz76vg3Hyci
        z1DGEReFbv7xvlfmAJvjsXi4CoDVWZhSzSOOM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=l7tXyejs4plzDwL6Xg9S9XXhSkphGs73
        KnyZ/phxJ048yYVZs3ZM/h2xzheZdCZCb5f8t0G1ClrieOHMx1pkQ24V7H3pBuD6
        hr6FpgSvr5Lh+Dx0OIDaqpwjVX9zeXOkNOU+BAOV4+mnl6fx+dvL5mZaXh2vJZhQ
        9W4esm8v1uw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DE4D9AB045;
        Mon, 13 Nov 2017 21:03:32 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 53C71AB044;
        Mon, 13 Nov 2017 21:03:32 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Elijah Newren <newren@gmail.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH 04/30] directory rename detection: basic testcases
References: <20171110190550.27059-1-newren@gmail.com>
        <20171110190550.27059-5-newren@gmail.com>
        <CAGZ79kbmt7jt13D-HY90+LBaCHsqvDOYnrmJ41hR3YsgEceirg@mail.gmail.com>
Date:   Tue, 14 Nov 2017 11:03:30 +0900
In-Reply-To: <CAGZ79kbmt7jt13D-HY90+LBaCHsqvDOYnrmJ41hR3YsgEceirg@mail.gmail.com>
        (Stefan Beller's message of "Mon, 13 Nov 2017 14:04:35 -0800")
Message-ID: <xmqqmv3p7h1p.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0402ADBE-C8E0-11E7-BF6F-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Fri, Nov 10, 2017 at 11:05 AM, Elijah Newren <newren@gmail.com> wrote:
>> Signed-off-by: Elijah Newren <newren@gmail.com>
>> ...
>> +#      B
>> +#      o
>> +#     / \
>> +#  A o   ?
>> +#     \ /
>> +#      o
>> +#      C
>> + ...
>> +# Testcase 1a, Basic directory rename.
>> +#   Commit A: z/{b,c}
>> +#   Commit B: y/{b,c}
>> +#   Commit C: z/{b,c,d,e/f}
>
> (minor thought:)
> After rereading the docs above this is clear; I wonder if instead of A, B, C
> a notation of Base, ours, theirs would be easier to understand?

I had a similar thought, but as long as everything in this file is
consistent, as we have that picture upfront, I am OK with it.  FWIW,
t1000 uses O (original--common ancestor) A and B, which was the
notation commonly used in our codebase since the early days when we
needed to call them with single letters.

>> +test_expect_success '1a-setup: Simple directory rename detection' '
>> +test_expect_failure '1a-check: Simple directory rename detection' '
>
> Thanks for splitting the setup and the check into two different test cases!
>
>
>> +       git checkout B^0 &&
>
> Any reason for ^0 ? (to make clear it is a branch?)

I think it is to make it clear that no matter what this test does
(or fails to do), the branch B is *not* affected by it because we'd
be playing on a detached head.

>> +test_expect_success '1b-setup: Merge a directory with another' '
>> +       git rm -rf . &&
>> +       git clean -fdqx &&
>> +       rm -rf .git &&
>> +       git init &&
>
> This is quite a strong statement to start a test with.

Yes.  If a test before this one did cd ../.. and forgot to come
back, we'd be in trouble.  If we want a fresh repository perhaps
test-create-repo inside the trash repository may be a less evil
option.
