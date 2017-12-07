Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D757E20954
	for <e@80x24.org>; Thu,  7 Dec 2017 23:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751014AbdLGXAb (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 18:00:31 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60832 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750919AbdLGXAa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 18:00:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2B11BC5ECF;
        Thu,  7 Dec 2017 18:00:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=icJPahl0v5b9
        UHMPLamcNi8x02s=; b=mpk1oOp3784/jJZMArCd2MoK3QyIo+I7YpoKpyqNUiN3
        VywBUgymgN0ztieYtUoy6mPpyhumWEDbsKgDMTbanBIiyaqhkowkygsOVZbErQR0
        LQvvNoYi4n1w03C1qT7Wat6vAtfGRm8D4ZKjw+eq23/v9n2RC4EJFALB/8E+s4g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=JtJQLU
        5aJUvVoC9guGctPSrVKjq/+8Y3GVJ1heL4/YK8a4/GfzcljNQOU2r1DUrhD/IjGS
        foDJvrC0u8e8vx0K8+HOCLOqxueM9JIAjdQNskyqwuf6zrgXl5xUKs5S5PGmK+sG
        1giOtpM4dGgCcD3PrlxpN9vkRMT9KE7cAGZFI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 21B80C5ECE;
        Thu,  7 Dec 2017 18:00:30 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 94161C5ECD;
        Thu,  7 Dec 2017 18:00:28 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v5 4/4] builtin/branch: strip refs/heads/ using skip_prefix
References: <20171129034620.4719-1-kaartic.sivaraam@gmail.com>
        <20171201055933.19368-1-kaartic.sivaraam@gmail.com>
        <CAM0VKjmy8J5VnROyv_O=iVdwn2yELUjPv=XNu6JzJ+OePWbh4w@mail.gmail.com>
Date:   Thu, 07 Dec 2017 15:00:27 -0800
In-Reply-To: <CAM0VKjmy8J5VnROyv_O=iVdwn2yELUjPv=XNu6JzJ+OePWbh4w@mail.gmail.com>
        ("SZEDER =?utf-8?Q?G=C3=A1bor=22's?= message of "Mon, 4 Dec 2017 05:29:15
 +0100")
Message-ID: <xmqqh8t2b0tw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6B1B0634-DBA2-11E7-8BB0-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> On Fri, Dec 1, 2017 at 6:59 AM, Kaartic Sivaraam
> <kaartic.sivaraam@gmail.com> wrote:
>> Sorry, missed a ';' in v4.
>>
>> The surprising thing I discovered in the TravisCI build for v4
>> was that apart from the 'Documentation' build the 'Static Analysis'
>> build passed, with the following output,
>>
>> -- <snip>
>> $ ci/run-static-analysis.sh
>> GIT_VERSION =3D 2.13.1.1972.g6ced3f745
>>      SPATCH contrib/coccinelle/array.cocci
>>      SPATCH result: contrib/coccinelle/array.cocci.patch
>>      SPATCH contrib/coccinelle/free.cocci
>>      SPATCH contrib/coccinelle/object_id.cocci
>>      SPATCH contrib/coccinelle/qsort.cocci
>>      SPATCH contrib/coccinelle/strbuf.cocci
>>      SPATCH result: contrib/coccinelle/strbuf.cocci.patch
>>      SPATCH contrib/coccinelle/swap.cocci
>>      SPATCH contrib/coccinelle/xstrdup_or_null.cocci
>>
>> The command "ci/run-static-analysis.sh" exited with 0.
>
> Perhaps Coccinelle should have errored out, or perhaps its 0 exit code
> means "I didn't find any code matching any of the semantic patches that
> required transformation".
>
>> I guess static analysis tools make an assumption that the source
>> code is syntactically valid for them to work correctly. So, I guess
>> we should at least make sure the code 'compiles' before running
>> the static analysis tool even though we don't build it completely.
>> I'm not sure if it's a bad thing to run the static analysis on code
>> that isn't syntactically valid, though.
>
> Travis CI already runs 6 build jobs compiling Git.  And that is in
> addition to the one that you should have run yourself before even
> thinking about submitting v4 ;)  That's plenty to catch errors like
> these.  And if any of those builds fail because Git can't be built or
> because of a test failure, then Coccinelle's success doesn't matter at
> all, because the commit is toast anyway.

Somehow this fell underneath my radar horizon.  I see v4 and v5 of
4/4 but do not seem to find 1-3/4.  Is this meant to be a standalone
patch, or am I expected to already have 1-3 that we already are
committed to take?

Thanks.

