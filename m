Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB87C433EF
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 05:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357048AbiFVFhS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 01:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356811AbiFVFhQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 01:37:16 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1AB36325
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 22:37:16 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E354113C0C5;
        Wed, 22 Jun 2022 01:37:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=rNKI24HLHOrm
        Cvudjap4SmFmRTHWEAXxcnqxYx5lpPo=; b=g/cWHdzlENQEu3esybExw8JTRj7l
        DHKoVRTeu6dj5RS+gs76uFizS9JNa5qdSZcZWnZ94Q0C9A33QK1/hdGGsoqeD2N/
        pHpXSI/rl0hZwjUu4HUtvtkrFqAhxYPYdzWUDToi7hBrVZS7JSJ9l3wa1m7Bj9Lu
        lsqfEvuB/xbI4s8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CCFA113C0C4;
        Wed, 22 Jun 2022 01:37:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 30B0613C0C3;
        Wed, 22 Jun 2022 01:37:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        rsbecker@nexbridge.com,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] config tests: fix harmless but broken "rm -r" cleanup
References: <cover-0.3-00000000000-20220621T221928Z-avarab@gmail.com>
        <patch-3.3-f787b19f8c2-20220621T221928Z-avarab@gmail.com>
        <xmqq4k0dfxxm.fsf@gitster.g>
Date:   Tue, 21 Jun 2022 22:37:12 -0700
In-Reply-To: <xmqq4k0dfxxm.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        21 Jun 2022 15:34:29 -0700")
Message-ID: <xmqq8rpp8div.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5ED44A14-F1ED-11EC-AAC8-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>>  test_expect_success 'override global and system config' '
>> -	test_when_finished rm -f "$HOME"/.config/git &&
>> +	test_when_finished "rm -rf \"$HOME\"/.config/git" &&
>
> As this string is evaled, isn't it safer to defer dereferencing the
> environment variable at the runtime by quoting the dollar-sign, too?
>
> I.e.
>
> 	test_when_finished rm -rf \"\$HOME\"/.config/git &&
>
> or something?

It probably would matter if $HOME had a double-quote in it, I think
