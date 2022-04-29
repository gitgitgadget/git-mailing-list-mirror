Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1CD1C433EF
	for <git@archiver.kernel.org>; Fri, 29 Apr 2022 17:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379538AbiD2SB2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Apr 2022 14:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbiD2SB1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Apr 2022 14:01:27 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E938FFB7
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 10:58:07 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E181F11ACBA;
        Fri, 29 Apr 2022 13:58:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Aa1ozq/hSACy
        WcZhKPM6M3YtqO/MLRVZ/fKDGUknbB8=; b=ILmtWgZdXeXaTcTwed7RM+AqYld1
        9Vzkd48y9OKt37oyiI66TI3etoEQRqY6mtNk5hQWitEkpRA425yJvQvKcvDGYUVH
        pmxQ2Aw5VweucykOCUZIrJne3n+z2pC3gZDWQ9oCXPNyyj6BW5nR0HKUWcoySx0I
        /9KwKL9PSfztCAw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8E1CB11ACB9;
        Fri, 29 Apr 2022 13:58:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 06F3311ACB8;
        Fri, 29 Apr 2022 13:58:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 2/3] t0033-safe-directory: check when 'safe.directory'
 is ignored
References: <pull.1215.git.1649863951.gitgitgadget@gmail.com>
        <20220427170649.4949-1-szeder.dev@gmail.com>
        <20220427170649.4949-3-szeder.dev@gmail.com>
        <xmqqr15il0uo.fsf@gitster.g>
        <a44b4f0e-038c-9bcd-80d6-f53c87bd7f2d@github.com>
Date:   Fri, 29 Apr 2022 10:57:58 -0700
In-Reply-To: <a44b4f0e-038c-9bcd-80d6-f53c87bd7f2d@github.com> (Derrick
        Stolee's message of "Fri, 29 Apr 2022 12:12:40 -0400")
Message-ID: <xmqq8rrndb6h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: EB512CE6-C7E5-11EC-8D10-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> On 4/27/2022 4:37 PM, Junio C Hamano wrote:
>> SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:
>>=20
>>> According to the documentation 'safe.directory' "is only respected
>>> when specified in a system or global config, not when it is specified
>>> in a repository config or via the command line option -c
>>> safe.directory=3D<path>".
>>>
>>> Add tests to check that 'safe.directory' in the repository config or
>>> on the command line is indeed ignored.
>>>
>>> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
>>> ---
>>>  t/t0033-safe-directory.sh | 13 +++++++++++++
>>>  1 file changed, 13 insertions(+)
>>>
>>> diff --git a/t/t0033-safe-directory.sh b/t/t0033-safe-directory.sh
>>> index 6f9680e8b0..82dac0eb93 100755
>>> --- a/t/t0033-safe-directory.sh
>>> +++ b/t/t0033-safe-directory.sh
>>> @@ -16,6 +16,19 @@ test_expect_success 'safe.directory is not set' '
>>>  	expect_rejected_dir
>>>  '
>>> =20
>>> +test_expect_success 'ignoring safe.directory on the command line' '
>>> +	test_must_fail git -c safe.directory=3D"$(pwd)" status 2>err &&
>>> +	grep "unsafe repository" err
>>> +'
>>> +
>>> +test_expect_success 'ignoring safe.directory in repo config' '
>>> +	(
>>> +		unset GIT_TEST_ASSUME_DIFFERENT_OWNER &&
>>> +		git config safe.directory "$(pwd)"
>>> +	) &&
>>> +	expect_rejected_dir
>>> +'
>>=20
>> I am debating myself if we want to remove the in-repository
>> safe.directory configuration setting after this test piece is done,
>> with test_when_finished.  We just made sure, with this test, that
>> having the variable does not affect anything, so the subsequent
>> tests should not care hence it is probably OK.  On the other hand,
>> to make sure those settings they make (e.g. setting it globally is
>> what the next test we can see below does) is what affects their
>> outcome, it removes one more thing we need to worry about if we
>> clean after ourselves.  I dunno.
>
> test_config would do the same, right? I think it automatically
> does the test_when_finished for us.

I thought it (specifically, anything depends on test_when_finished)
has trouble working well from inside a subprocess?
