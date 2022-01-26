Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D9F5C433EF
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 23:57:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbiAZX5e (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 18:57:34 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56235 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiAZX5e (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 18:57:34 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D714211F05A;
        Wed, 26 Jan 2022 18:57:33 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=dskb8TCVAp9v
        wIY3oGdqlBbXs+MiFql1VJ06Nq4ocGM=; b=wUs2H3fF5EJ4uJJe/0epj0t5rm3s
        3B5fH0D0pdhZbedqKH3A/P/wpor8dVgdcLF7friBV4mh0d2NN8SsgHqg8jcw4cBJ
        /90vqzOjRJGxqHfsWIBYAw7LntT39Z7siTgzHW+W44jPk6tStazMlAxYsRYMivKT
        wHYDeInjaePMLL8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CE64B11F059;
        Wed, 26 Jan 2022 18:57:33 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 223F711F058;
        Wed, 26 Jan 2022 18:57:32 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v4 1/2] sequencer: don't use die_errno() on
 refs_resolve_ref_unsafe() failure
References: <xmqqo84gu4sb.fsf@gitster.g>
        <cover-v4-0.2-00000000000-20220126T143427Z-avarab@gmail.com>
        <patch-v4-1.2-7f31277fd57-20220126T143427Z-avarab@gmail.com>
Date:   Wed, 26 Jan 2022 15:57:30 -0800
In-Reply-To: <patch-v4-1.2-7f31277fd57-20220126T143427Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 26 Jan
 2022 15:37:00
        +0100")
Message-ID: <xmqqpmoenj85.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B9DDADD6-7F03-11EC-82DE-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change code that was faithfully migrated to the new "resolve_errno"
> API in ed90f04155d (refs API: make resolve_ref_unsafe() not set errno,
> 2021-10-16) to stop caring about the errno at all.
>
> When we fail to resolve "HEAD" after the sequencer runs it doesn't
> really help to say what the "errno" value is, since the fake backend
> errno may or may not reflect anything real about the state of the
> ".git/HEAD".

OK.  Assuming that the eventual goal is to drop the return value
parameter from the resolve_ref_unsafe() function (because according
to this caller, it is not yielding any meaningful value), this
change makes perfect sense.

> With the upcoming reftable backend this fakery will
> become even more pronounced.

This too.

Nicely explained and executed.

Thanks.


