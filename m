Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AAB8C11F67
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 21:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0841261CF1
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 21:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235238AbhF2VlQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 17:41:16 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59317 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233660AbhF2VlQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 17:41:16 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B61AC13B49C;
        Tue, 29 Jun 2021 17:38:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=Ex/bvjhX8GSVy6F5CKAUvYGtK
        I/qkbee8zSHMsHjKRY=; b=FYW4QhsWwbjEmMsAJHi/VxfIqxAqzprchK2p01eIC
        jHCIJx9Qyo+dWArtFaTfxlFvLDssdaJuRN2woNffQCd8OtXz1VtrDCK9OpE7XYkb
        KIO2aVKJeHHBTKhAokj/n680WKilSoJe4OXr0TcN1WRIKLz2Za+zFerKmFnoyESb
        WE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AF0DA13B49B;
        Tue, 29 Jun 2021 17:38:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F327613B49A;
        Tue, 29 Jun 2021 17:38:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] Makefile: add and use the ".DELETE_ON_ERROR" flag
References: <patch-1.1-9420448e74f-20210622T141100Z-avarab@gmail.com>
        <YNIBRboFiCRAq3aA@nand.local> <8735t93h0u.fsf@evledraar.gmail.com>
        <YNI3WVu5SK7pHI7T@coredump.intra.peff.net>
        <87r1gs1hfx.fsf@evledraar.gmail.com>
        <YNOz1GD/8+CaUvRz@coredump.intra.peff.net>
        <871r8r1hwe.fsf@evledraar.gmail.com>
        <YNSbe0At6SaQu1Z4@coredump.intra.peff.net>
        <87fsx6xn0b.fsf@evledraar.gmail.com>
        <YNqE8BIRF6NeYQcd@coredump.intra.peff.net>
        <xmqqfsx1yyza.fsf@gitster.g> <875yxxgkav.fsf@evledraar.gmail.com>
X-Gnus-Delayed: Tue, 29 Jun 2021 20:01:59 -0700
Date:   Tue, 29 Jun 2021 14:38:44 -0700
Message-ID: <xmqqv95wuza3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 61EF566A-D922-11EB-BD23-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Even if you don't care about the end result or making git easier to hac=
k
> on for people who don't share your setup, I'd think that making those
> rules consistent across the board makes things less complex, not more.

I think that it is where we disagree.  "Remove $@+ and $@, generate
into $@+ and then move it to $@" idiom has a legitimate reason to be
used, and I do not want to see it blindly used where there is no
reason to do so.  It misleads less experienced readers.

If we write a custom script that does not promise atomicity, it is a
quite natural pattern to use, and it is clear to readers what is
going on, especially when "generate into $@+" step is done via
redirection.  I despise "$(CC) -o $@+ && mv $@+ $@" because there
simply shouldn't be a need to do so---unlike our custom script that
sends its output to its standard output, $(CC) ought to know better.

But as you said elsewhere, the patch in question is *not* about
adding more use of "mv $@+ $@" in inappropriate contexts, so let's
stop discussing it now.  We take advantage of .DELETE_ON_ERROR that
allows us to use the upfront "rm -f $@ $@+" we do in the idiom,
which is a good thing.
