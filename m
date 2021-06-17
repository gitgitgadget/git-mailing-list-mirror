Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC840C48BE5
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 00:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2ECD613B9
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 00:18:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234947AbhFQAUv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 20:20:51 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59428 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbhFQAUu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 20:20:50 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 60999B7463;
        Wed, 16 Jun 2021 20:18:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=0YC9OVTHwaW+
        7FBkygSgdFDfL9RyG8W2WKwHn8S6eek=; b=w6O1KMC/55dcxTeaLS34v+c1VuqB
        aDgdYjO2E2eqUNWZTLcVX6znB/XgZ4xMvmtKD4R5O1d1j/ZWQOrXBAkqQG54grqc
        qOAenCUoWcFXvE9F6D5MJCW+YR8t7QtdWp5kQ+/SabR2dHJGe/SfYHlcFnjWueyo
        FyA23d8T9OmepH0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 579DAB7462;
        Wed, 16 Jun 2021 20:18:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D9742B7460;
        Wed, 16 Jun 2021 20:18:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 3/5] t0041: use test_line_count_cmd to check
 std{out,err}
References: <20210615172038.28917-1-congdanhqx@gmail.com>
        <20210615172038.28917-4-congdanhqx@gmail.com>
        <xmqqlf7ase3d.fsf@gitster.g> <YMoJAnvigwexX5b5@danh.dev>
Date:   Thu, 17 Jun 2021 09:18:42 +0900
In-Reply-To: <YMoJAnvigwexX5b5@danh.dev> (=?utf-8?B?IsSQb8OgbiBUcuG6p24g?=
 =?utf-8?B?Q8O0bmc=?= Danh"'s message of
        "Wed, 16 Jun 2021 21:21:54 +0700")
Message-ID: <xmqqpmwlny1p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 92C25DA8-CF01-11EB-8DEC-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

>> By the way, my opinion would be quite different if example like this
>> one ...
>>=20
>> >  test_expect_success 'tag --no-contains <existent_tag>' '
>> > -	git tag --no-contains "v1.0" >actual 2>actual.err  &&
>> > -	test_line_count =3D 0 actual &&
>> > -	test_line_count =3D 0 actual.err
>> > +	test_line_count_cmd --out =3D 0 --err =3D 0 git tag --no-contains =
v1.0
>> >  '
>>=20
>> ... were the majority, but I do not think that is the case.  Most
>> tests that employ the new test_line_count_cmd in this patch still
>> create either actual or actual.err in the working tree anyway, so I
>> do not see much point in adding this new helper---it is hard to
>> explain to new test writers when to use it.
>
> I'm not sure if I get your opinion.  Did you mean you wouldn't take
> whole helper? Or you meant you still wanted to see a new helper for
> checking only stdout?  If it's the former, I'll send a different
> series to only clean "git ls-files ... | wc -l" in t6400 and t6402,
> if it's the latter, I'll rewrite without --err.

I did not see much point in adding test_line_count_cmd with --out
and/or --err options; the upside of having it was dubious after
looking at the users of it in the patch that we are discussing.

I did not consider test_line_count_cmd that only works on the
standard output stream.  From the patch under discussion, it is not
immediately obvious how much such a simplified helper would help
clean up the existing tests, so I have no opinion without seeing
at least some sample uses.

