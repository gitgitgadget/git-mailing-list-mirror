Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7CCC2BA18
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 18:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43F1220721
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 18:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xl3h8Amw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388823AbgDBSOl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 14:14:41 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58215 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbgDBSOk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Apr 2020 14:14:40 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 65E1140367;
        Thu,  2 Apr 2020 14:14:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=F7lavaAfTGeK
        GyUg0c9Hyukxy5I=; b=xl3h8AmwJr0x6N9Nwt9iV4+8WhlNbS/tQQhF/t5jAx/v
        69LTXnDBHfAeyrSbyc19T7RajOJKMp0xH5+YRkcpwxmfT5eKwX0Buvsv2zFuTF6s
        81Z9F/DxmsjYaMajOPAPexAz3HdI0IuL+HCW3fMduw+HOr+w2TD92Hf25NwI1Q0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ZOI8zZ
        rYm7joXumATsgzNdkPXP56Rjtdt7zdhK5OA6U8yt98T62ELo0SOJot3R8Ke8TX4L
        NqtDlSz3PYeafy8p1m24OxMEhstU99KoIT1wPyxWVEeK8tO6OkvLCAGaHmosu/oN
        7Pw724H93VJDnTRCkD1LBQdnYHMgSX+CzDepk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5D22540366;
        Thu,  2 Apr 2020 14:14:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B07BA40362;
        Thu,  2 Apr 2020 14:14:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Subject: Re: [PATCH] ci: make MAKEFLAGS available inside the Docker container in the Linux32 job
References: <20200401212151.15164-1-szeder.dev@gmail.com>
        <xmqqftdl4y7s.fsf@gitster.c.googlers.com>
Date:   Thu, 02 Apr 2020 11:14:36 -0700
In-Reply-To: <xmqqftdl4y7s.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 02 Apr 2020 10:03:03 -0700")
Message-ID: <xmqqk12x3gc3.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D04499CE-750D-11EA-BF07-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:
>
>> Once upon a time we ran 'make --jobs=3D2 ...' to build Git, its
>> documentation, or to apply Coccinelle semantic patches.  Then commit
>> eaa62291ff (ci: inherit --jobs via MAKEFLAGS in run-build-and-tests,
>> 2019-01-27) came along, and started using the MAKEFLAGS environment
>> variable to centralize setting the number of parallel jobs in
>> 'ci/libs.sh'.  Alas, it forgot to update 'ci/run-linux32-docker.sh' to
>> make MAKEFLAGS available inside the Docker container running the 32
>> bit Linux job, and, consequently, since then that job builds Git
>> sequentially, and it ignores any Makefile knobs that we might set in
>> MAKEFLAGS (though we don't set any for the 32 bit Linux job at the
>> moment).
>>
>> So update the 'docker run' invocation in 'ci/run-linux32-docker.sh' to
>> make MAKEFLAGS available inside the Docker container as well.  Set
>> CC=3Dgcc for the 32 bit Linux job, because that's the compiler install=
ed
>> in the 32 bit Linux Docker image that we use (Travis CI nowadays sets
>> CC=3Dclang by default, but clang is not installed in this image).
>>
>> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
>> ---
>>
>> The 'dd/musl-libc-travis-ci' topic needs some more updates, and those
>> will depend on this fix.
>
> Thanks.  I'll queue this on top of v2.26.0 so that others can be
> rebased on top of it.

Actually, the updated dd/ci-musl-libc has this at the bottom of the
series, so I won't have a separate topic for this patch.

Thanks anyway.
