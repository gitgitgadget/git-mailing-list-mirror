Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19423C11F66
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 06:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1F9B61D92
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 06:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbhF2GLx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 02:11:53 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50784 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbhF2GLu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 02:11:50 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 04E39D50F6;
        Tue, 29 Jun 2021 02:09:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=Xy7WZ7L6WcMnKPV6qDi17s0TJ
        ukp3ij2usENPS9FHGw=; b=ogdCDbCJM2q5iu0cfhWf2F0EvAbWutpX8pQBYJwmr
        dhqz3SWLuwt4ugXgNuO6jFrncHoFM2nwZemmBD4tsw7MWn9LukwGZPmKlZJEbfIR
        pIWznVJ2uIY8iRTBWIvKlquGWiG+5gjMYx3QIutwvftE+pnhp/mIqCzrJIp1/FcA
        FI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DEA72D50F4;
        Tue, 29 Jun 2021 02:09:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 57A16D50F3;
        Tue, 29 Jun 2021 02:09:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Avishay Matayev <me@avishay.dev>, phillip.wood@dunelm.org.uk,
        git@vger.kernel.org
Subject: Re: Forcing git to use a pager without a tty
References: <CAJ-0OswsrnAuCwU6U=S2i1qKkg=66U-8RHSGqD2kh9T_30Yw9w@mail.gmail.com>
        <077d147c-c22f-6463-6545-3aa991e7868b@gmail.com>
        <b5462f20-5d9d-4775-ad5c-c8de686167af@gmail.com>
        <CAJ-0Osy9JhGD0=6eF3jgZuoHJEzymksCWZZZC+A4FtHxzOrdhA@mail.gmail.com>
        <87pmwazygf.fsf@evledraar.gmail.com>
Date:   Mon, 28 Jun 2021 23:09:21 -0700
Message-ID: <xmqqlf6tyzfy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8C3775D8-D8A0-11EB-BBAB-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> What do you do about things like "git status" etc. that produce a lot o=
f
> output, but don't invoke the pager even then (but perhaps should), ditt=
o
> for all the plumbing or plumbing-like such as "ls-files", "ls-tree" etc=
?

I am puzzled.  Doesn't "git -p status" force spawning the pager?

    ... goes and checks ...

Ahh, OK, -p does force us to try to see if pager is warranted, and
then we decide it is not because the output is not sent to the tty.

This behaviour makes sense if we are truly driving a pager via
GIT_PAGER, but I agree with you that it probably is inconvenient if
you are abusing the GIT_PAGER mechanism to drive something that is
not about paging output but about grabbing the output and
post-processing it.
