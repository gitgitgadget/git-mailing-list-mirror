Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50C4A1F97E
	for <e@80x24.org>; Sun, 25 Nov 2018 01:16:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbeKYMGU (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Nov 2018 07:06:20 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:65425 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbeKYMGU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Nov 2018 07:06:20 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E430F3BE9E;
        Sat, 24 Nov 2018 20:16:30 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=XwEqEr9HNTKI
        7vMyi5Wdzv0iwv8=; b=tSxoxlPZzx4ccQmTzIoZzuP10L1WO+ilPmDiFFZUmi2K
        EIPRZtPxGlX9AdOqT8bGzr1K+A+eIWbpevDapLwVEfqx5Cp/sP9lPJ/7nj5ppQHY
        BeNGp0fVNaxK7bQy8bjWfHwdPRs7qc99DRcgIIJam3BCNyzQqnGkmzUxrVnwmLM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=gVmmj5
        cAgwrih0O6n0gxsC+T/ijfOyNREav7fbvt8IB9/j8GTjJRXkwW+OGt6ZLVv973fe
        WmCb7uwZJNzYhzMlW2NLvjx9oC2/j394Sda1By4HoWU92gzzJJE8BpQjPC/fsfdl
        Ikw0WW712vG3Jg3KoAno60mtWvkaG2yiJ8DgQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DCE0B3BE9D;
        Sat, 24 Nov 2018 20:16:30 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F00D63BE9C;
        Sat, 24 Nov 2018 20:16:27 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Guilhem Bonnefille <guilhem.bonnefille@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: How to efficiently backup a bare repository?
References: <CA+BUw6gjfpiHhy+jYzxeO4NDOKiMUH0XZ3-c5o7ygdKBCKWm2Q@mail.gmail.com>
        <8736rq14fe.fsf@evledraar.gmail.com>
Date:   Sun, 25 Nov 2018 10:16:25 +0900
In-Reply-To: <8736rq14fe.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Sat, 24 Nov 2018 23:44:37 +0100")
Message-ID: <xmqqy39i0xee.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BBE15024-F04F-11E8-ACB9-F5C31241B9FE-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> There's no easy out of the box way to do exactly what you've
> described. A few things come to mind:
> ...

Wouldn't it suffice to have a cron job that runs something like

	D=3D$(date +"%Y-%m-%d")
	git fetch $serving "refs/*:refs/backup-$D/*"

on the back-up box to fetch from the repository on the box the
end-users push into once a day?  In the back-up repository, the
refs/backup-2018-11-25/heads/master reference would be today's tip
of the master branch of the serving repository.  You can set the
expiry timeout to "now" (i.e. "gc" will immediately drop unreachable
objects, and that is fine because you expicitly have refs to pin
these objects anyway), get the dedup from "git fetch" for free,
repack the backup repository as a whole, and dropping the whole
refs/backup-2018-10-25/* hierarcy on 2018-11-25 is all you need to
expire the refs.

You may want to play with the ref-advertisement limiting options in
the recent Git, if it is too much to grow the amount of "have"s by
30x for the common ancestry negotiation.  But that is a small
implementation detail.

