Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A6ACC433E0
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 01:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C932B64FA6
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 01:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbhCKBTH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 20:19:07 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59135 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhCKBSt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 20:18:49 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 82CE51251DC;
        Wed, 10 Mar 2021 20:18:49 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=93CaNxN3pWjQ
        W4ofDr/PzKm8Mag=; b=npeoL0jrZuv11BvgVSJLlrJeXpMoj5tHuA132db6rNtW
        ZVacjgYV+fOrD4S6kCA8a88tJqNQd55RIlzuwx5W36EuiyVoZjPjW1I8oXzmojcq
        2ib/9vFKgXf7dIIsqHGdrHrUQQBmNVpgFMLFp1rCjI8WiTePSt91hrjarXDPmPI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=DPtLHJ
        dY1DAvx54QZP/lXIArEb8hFHP43AChSyT2Blip4cQBC4bVPZILRG4dslZcC8AVs7
        DSbfcbuleIwetmfuo0nlZQ9o3UKTgQ6ay5l16joo5ux5DRZZMK3MhX1v8JVSKmP4
        qyosVaySQshc4bRFxYG2s2X1KAgCkL1naKpSE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7B4021251DB;
        Wed, 10 Mar 2021 20:18:49 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BC0401251DA;
        Wed, 10 Mar 2021 20:18:46 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 3/4] shortlog tests: rewrite to get rid of --abbrev=35
 hardcoding
References: <YEj82fOf+F4xJC8S@coredump.intra.peff.net>
        <20210311001447.28254-4-avarab@gmail.com>
Date:   Wed, 10 Mar 2021 17:18:45 -0800
In-Reply-To: <20210311001447.28254-4-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 11 Mar 2021 01:14:46 +0100")
Message-ID: <xmqqczw6h4i2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BA5B2936-8207-11EB-B12B-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> +	cat >expect <<-EOF &&
> +	A U Thor (5):
> +	      $(git rev-parse HEAD~5)
> +	      $(git rev-parse HEAD~4)
> +	      $(git rev-parse HEAD~3)
> +	      $(git rev-parse HEAD~2)
> +	      $(git rev-parse HEAD~1)
> +
> +	Someone else (1):
> +	      $(git rev-parse HEAD~0)
> +
> +	EOF
> ...
>  test_expect_success '--abbrev' '
> -	sed s/SUBJECT/OBJID/ expect.template >expect &&
> +	cut -c 1-41 <expect >expect.abbrev &&
>  	git shortlog --format=3D"%h" --abbrev=3D35 HEAD >log &&

The hardcoded 35 is a bit curious, and 1-41 even more so.

Is the idea that the "expect" prepared earlier has full hexdigits
and indented by 6 columns, the full hexdigits for an object name is
longer than 35 chars in any hash algorithm we use, any sample name
plus (number) plus colon won't be 35 chars long, and 35+6 happens to
be 41 so cutting at 41 column we'd get the first 35 hexdigits of the
object names without losing anything on the summary line?

That's a bit too subtle to my taste, but=20

	test_expect_success '--abbrev' '
		abbrev=3D35 &&
		cut -c 1-$(( abbrev + 6 )) expect >expect.abbrev &&
		git shortlog --format=3D"%h" --abbrev=3D$abbrev HEAD >log &&
		...

may not make it much easier to follow (without explaining what that
6 is anyway), so I'll let it pass.

Otherwise the steps so far make quite a lot of sense.

Thanks.






