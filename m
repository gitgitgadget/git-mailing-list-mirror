Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 755EFC4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 528E361212
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:10:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbhHXVKv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 17:10:51 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60651 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbhHXVKu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 17:10:50 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8D5AD144A23;
        Tue, 24 Aug 2021 17:10:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=3DT4rq8hgpDl
        66aXsCAuYmMvGxmsnX31IMLQbpZfvOk=; b=OdRUPBsVV1OhObyVaYVeT5H5IFGP
        Mx6j2db658mZnKQgk2hKmIUb+9HZIo6ScKb9idXL7Y0Ly5kZVhhXZCB8FUQuxRRf
        pgR4mXH8PrE3LZBWd+50QA+NeUNcspgq4giG+wmvzgKG2ayJaZIEsTLdVuv+ruL5
        29640wFcnBS/V3I=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 85357144A20;
        Tue, 24 Aug 2021 17:10:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4CAE8144A1E;
        Tue, 24 Aug 2021 17:10:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Mickey Endito <mickey.endito.2323@protonmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] t5582: remove spurious 'cd "$D"' line
References: <tV8xl8isDPhmGxCNmN06tTwhJTve0PsrkakKwLMcFQJybDZO2SGHHbDLZFrcLp1Yda1_KRygSm7-lVDSZSaG-antdalcPnhSqYqcK5Fpifk=@protonmail.com>
        <xmqq8s0rpwiw.fsf@gitster.g> <20210824185942.GE2257957@szeder.dev>
Date:   Tue, 24 Aug 2021 14:10:00 -0700
In-Reply-To: <20210824185942.GE2257957@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message
        of "Tue, 24 Aug 2021 20:59:42 +0200")
Message-ID: <xmqqv93umtw7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A5AC78DC-051F-11EC-B81F-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> On Mon, Aug 23, 2021 at 04:32:39PM -0700, Junio C Hamano wrote:
>> Mickey Endito <mickey.endito.2323@protonmail.com> writes:
>>=20
>> > The variable D is never defined in test t5582, more severely the tes=
t
>> > fails if D is defined by something outside the test suite, so remove
>> > this spurious line.
>>=20
>> Wow.  Well spotted.
>>=20
>> When D is left unset, we end up executing
>>=20
>> 	cd "" && ...
>>=20
>> and it explains why nobody noticed the breakage for nearly a year
>> since c0192df6 (refspec: add support for negative refspecs,
>> 2020-09-30) was written.
>>=20
>>=20
>> Unlike the apparent
>> copy-and-paste source, this is a more modern script that limits the
>> chdir inside subshells to avoid moving around in the main flow of
>> the test, and the fix proposed here looks the most sensible. =20
>
> 'grep " cd $" test-results/*.out' shows that there is a similar case
> in 't5323-pack-redundant.sh' as well, in test 'master: pack-redundant
> works with no packfile'.

OK.  A candidate for a separate patch, which would be a low-hanging
fruit, I guess.

