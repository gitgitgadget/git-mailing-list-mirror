Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3AA01F45F
	for <e@80x24.org>; Wed,  8 May 2019 03:12:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfEHDMZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 23:12:25 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59362 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbfEHDMZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 23:12:25 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 02F5A58819;
        Tue,  7 May 2019 23:12:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=FFvuyW9HNgGr
        oRfkD1cWQ2+VfDE=; b=df/ElthTEvRqDYvRl+CnRD5gRfbkPpJh6B2y/3rR94mu
        KQ6UnzOmhgWZzhQHqVYjzPOIKGGdDu3olr56ug0JGMOm+TALYRJM+ie+lKv7RCHh
        2scan6KpfOaymnBx1ABJUgER6xH4vN49L0jrwt5cdH2ypADvSmZOVc9Q//ZVQpA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=RBpYCV
        fPd9lKdaTtLX66f6xhh1BdbIXXTg/lI7YeHTlbKFxe8auUoE5licccKbL0yMU4lY
        t3ELLzI0jddIet3MU8xTUpq9wa8Da6MYErU14MSIu6uabtBx4QmQApAMJeZXNSOd
        G7Wzqs6fqcFZT1HaPT/+lrcds0hNWTgHA//U4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EEED658818;
        Tue,  7 May 2019 23:12:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 231DF58817;
        Tue,  7 May 2019 23:12:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Ben Peart <benpeart@microsoft.com>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 0/2] Fix fsmonitor after discard_index()
References: <pull.165.v2.git.gitgitgadget@gmail.com>
        <20190507111021.12840-1-avarab@gmail.com>
        <xmqqh8a6l5zh.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 08 May 2019 12:12:19 +0900
In-Reply-To: <xmqqh8a6l5zh.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 07 May 2019 23:00:18 +0900")
Message-ID: <xmqqtve5iqr0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 18A11180-713F-11E9-BB04-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> This v3 is all Johannes's patches. The outstanding review on v2 could
>> be clarified with a commit message change, which I've addressed, and
>> v2 conflicted with a cache.h change that's since landed in "master",
>> which I've rebased this on.
>>
>> Junio: We're getting closer to the release so it would be great to
>> have this. It's been broken for a long time, but having this finaly
>> fixed in v2.22 would be great. The functional code changes are also
>> isolated to the fsmonitor code path, which reduces the risk and makes
>> this easier to review/reason about.
>
> Thanks.  With this many topic backlog in flight (and not yet in
> 'pu'), a resend like this, which is much easier to handle than mere
> reference to the previous discussion thread, is really appreciated.

Hmph, surprisingly, 1/2 alone did not reproduce any breakage.

    ... goes and looks ...

Ah, that's false alarm.

As I use prove, "make test" treats known breakage as a non-event and
does not show, which made me lose a few minutes scratching my head
wondering what I did wrong.  It would have been nicer if it were
easy to use 1/2 alone with the new test marked to expect success,
but with a patch split into two like this, it requires going in to
the test script and changing s/_failure/_success/, which is a bit
suboptimial.

Anyway, will queue this to 'pu' and hopefully we can merge it down
soonish.

Thanks.
