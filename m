Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C6ECC433FE
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 11:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7592861102
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 11:02:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349085AbhIHLED (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 07:04:03 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51086 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233694AbhIHLEB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 07:04:01 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9EBE2EB198;
        Wed,  8 Sep 2021 07:02:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=ZwPRWdR9R7rW4z2PlZIg8qfdj
        eSklze35rU9Oj7fqwc=; b=rHp7nLipIE1LST2NGaTOKHjYP5TScwUvJnfYpHb7E
        /RcgJgNqA0YaJWjpDRreUVJT/DItmg7Vf74R/JwqB9VqC5C/DflMS2L6zAEiM3xh
        +jkxzwkEGqkcPVraKSC55OuQ67gg+Mw6Muq5qzYYn8PmLrPjWNno/O1OD9tB41ff
        OA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 959A9EB195;
        Wed,  8 Sep 2021 07:02:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 18E42EB194;
        Wed,  8 Sep 2021 07:02:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Andrzej Hunt <andrzej@ahunt.org>,
        =?utf-8?B?TMOpbmHDr2M=?= Huard <lenaic@lhuard.fr>,
        Derrick Stolee <dstolee@microsoft.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?xJBv?= =?utf-8?B?w6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 0/3] add a test mode for SANITIZE=leak, run it in CI
References: <cover-v4-0.3-00000000000-20210907T151855Z-avarab@gmail.com>
        <cover-v5-0.3-00000000000-20210907T212626Z-avarab@gmail.com>
Date:   Wed, 08 Sep 2021 04:02:50 -0700
Message-ID: <xmqq35qf72jp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4F2D8BE2-1094-11EC-9FCB-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> We can compile git with SANITIZE=3Dleak, and have had various efforts i=
n
> the past such as 31f9acf9ce2 (Merge branch 'ah/plugleaks', 2021-08-04)
> to plug memory leaks, but have had no CI testing of it to ensure that
> we don't get regressions. This series adds a GIT_TEST_* mode for
> checking those regressions, and runs it in CI.
>
> Since I submitted v2 the delta between origin/master..origin/seen
> broke even t0001-init.sh when run under SANITIZE=3Dleak, so this series
> will cause test smoke on "seen".
>
> That failure is due to a bug in es/config-based-hooks [1] and the
> hn/reftable topic, i.e. these patches are legitimately catching
> regressions in "seen" from day 1.

So is there a point in sending this out to the list, before sending
fixes to these broken topic and making sure they get corrected?

Because the CI does not "bisect" to tell us "ok, up to this point in
'seen', all the topics merged play well together", the overall
effect in the bigger picture is that 'seen' with this series would
cause CI to stay in failed state.

For now, I'll keep this near the tip of 'seen'.

Thanks.

