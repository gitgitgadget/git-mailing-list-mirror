Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C6D2EED61A
	for <git@archiver.kernel.org>; Fri, 15 Sep 2023 17:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234018AbjIORtc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Sep 2023 13:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235386AbjIORtU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2023 13:49:20 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3EC10D
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 10:49:15 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0F4DC19F768;
        Fri, 15 Sep 2023 13:49:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=WK7INMvXNI2H
        3PZOzm9tMHM/wGu3hAoSdz+/hFpbqY0=; b=tDRV/mtQjLxfYiikOYXY1FqavKQ6
        5W52Reyfo+9PIj20dmNnSSTabpEKaubClpen/BUfVqF7purQ/dgZxMgEEnLjQlzo
        kLHAGHgr1CY9BPXPgptvBdSTizfI4FGN4Om4mUNgckx+V1EhOR7CNlIZAaHXMl/3
        sL/Ju+7Msen8O5U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 07EAF19F767;
        Fri, 15 Sep 2023 13:49:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6B92A19F766;
        Fri, 15 Sep 2023 13:49:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 2/2] test-lib: fix GIT_TEST_SANITIZE_LEAK_LOG
In-Reply-To: <2890b210-c42f-41cf-e676-0b1c56310f73@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
        message of "Fri, 15 Sep 2023 02:28:15 +0200")
References: <68522960-edda-26d3-ddca-cee63f2d859e@gmail.com>
        <64825651-00d2-d2c5-2da2-91a9917bef21@gmail.com>
        <20230912082742.GB1630538@coredump.intra.peff.net>
        <2890b210-c42f-41cf-e676-0b1c56310f73@gmail.com>
Date:   Fri, 15 Sep 2023 10:49:13 -0700
Message-ID: <xmqqcyyjfht2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2F38A9A6-53F0-11EE-B150-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

>> And the problem is in (3). You switch it to trigger only if we have no
>> failures (fixing the inversion). But should we have the same a/b split
>> for this case? I.e.:
>>=20
>>   3a. if we saw no test failures, invert to cause a failure
>>   3b. we saw other failures; do not invert, but _do_ mention that the
>>       log found extra leaks
>>=20
>> In 3b we are explaining to the user what happened. Though maybe it is
>> not super important, because I think we'd have dumped the log contents
>> anyway?
>
> I think so too.  At that point we've already dumped the contents of the
> $TEST_RESULTS_SAN_FILE file.
> ...
> However, if you or anyone else thinks it adds value, I have no objectio=
n
> to re-roll with it.

I do not know offhand if we need the code update to implement what
Peff called "maybe it is not super important", but if we decide not
to, at least it would help future developers to document the fact
that we were aware of the issue when the code was developed, and why
we decided not to address it (in other words, describe why we
decided it is not super important).

Thanks both for polishing the series and making it better.
