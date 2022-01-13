Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2909FC433F5
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 22:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238032AbiAMWj7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 17:39:59 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62140 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235281AbiAMWj7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 17:39:59 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 85CC116103A;
        Thu, 13 Jan 2022 17:39:58 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ph97jcBAMbgf
        jdAxbXjkqYGRr0GcbM5tw28SZLImbrA=; b=jJ6nU2DhwsIzq193upcFGxnAZGv7
        PGRNjtK/vL85Hizj+nXxu6W4HOayEo1/VRKMZIx8v8gRfnpzw82NmNSUJUL4QSQl
        MhS/T77JiHrp1bQzK63vL/sqElM2axLQI6JlkIQkk/7wabJ8rcRI9dTZHbJfaLMU
        LMtUFLTJ9ewxL+Q=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7F3CC161039;
        Thu, 13 Jan 2022 17:39:58 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E7164161037;
        Thu, 13 Jan 2022 17:39:55 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH v7 1/6] object-name tests: add tests for ambiguous
 object blind spots
References: <cover-v6-0.6-00000000000-20211228T143223Z-avarab@gmail.com>
        <cover-v7-0.6-00000000000-20220111T130811Z-avarab@gmail.com>
        <patch-v7-1.6-28c01b7f8a5-20220111T130811Z-avarab@gmail.com>
Date:   Thu, 13 Jan 2022 14:39:54 -0800
In-Reply-To: <patch-v7-1.6-28c01b7f8a5-20220111T130811Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 12 Jan
 2022 13:39:20
        +0100")
Message-ID: <xmqq8rvjgszp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BB3048FC-74C1-11EC-BF84-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> +test_cmp_failed_rev_parse () {
> +	cat >expect &&
> +	test_must_fail git -C "$1" rev-parse "$2" 2>actual.raw &&
> +	sed "s/\($2\)[0-9a-f]*/\1.../" <actual.raw >actual &&
> +	test_cmp expect actual
> +}

That's dense, especially without a comment (or named variable) that
hints readers what the arguments to this helper (and its standard
input) ought to be.

As long as messages from rev-parse on the error stream never has
more than one abbreviated object name on a single line, the above
should give us a copy of the message with expected object name
abbreviated to $2; otherwise we might be missing a /g in the sed
script.
