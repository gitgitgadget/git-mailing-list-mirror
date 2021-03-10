Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5572C433DB
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 01:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58D17650F2
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 01:12:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbhCJBLf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 20:11:35 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57227 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbhCJBLY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 20:11:24 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F131B1121D9;
        Tue,  9 Mar 2021 20:11:23 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=jUOzdOUsH5p/
        U7iFQcoNnNb6eSY=; b=uyAQ8v0vza+z6LfKxiuHdbGNTHaQuvGGhZieJVlYhoJO
        8LYctVmx7NmIrrqluL+xt3AphCuTmeVzV6SNmBXa8EiRJGtLIEdNj+5p7dFeGd90
        nZSZDWCccgA73szLxsjMI1o9qtmFSigqgMwRz/Jnb1MsgGZ0Nxg6QN1jBqEcWCc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=qQbZxy
        WLcVptrl8cerHXLO0WmUVUgSDCE1iuPOkxKQnwXrHZS3OPVJ2ijoV64+oRKnuIsz
        hc6duznCCmGi1TE+n0JPTaR9vWA7kTE7t5LqMz4vu1B4GYRHlGsHh3IKX2lTS0IU
        ZadadMCyujlDM7/jXB3h5loux9eAGv4kc2fQ0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E85381121D7;
        Tue,  9 Mar 2021 20:11:23 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3BA021121D4;
        Tue,  9 Mar 2021 20:11:21 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= 
        <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 6/7] test-lib: make --verbose output valid TAP
References: <87r1kzj7xi.fsf@evledraar.gmail.com>
        <20210309160219.13779-7-avarab@gmail.com>
Date:   Tue, 09 Mar 2021 17:11:19 -0800
In-Reply-To: <20210309160219.13779-7-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 9 Mar 2021 17:02:18 +0100")
Message-ID: <xmqqo8fryfrc.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8663B474-813D-11EB-829B-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Replace it with a simple method for ensuring that we have valid TAP
> both on stdout, and in any verbose output we write. When we detect
> that we're running under "prove" we prefix all legitimate TAP
> directives with "GIT_TEST_TEE_STARTED":
>
>     $ GIT_TEST_TEE_STARTED=3D1 ./t5547-push-quarantine.sh
>     GIT_TEST_TEE_STARTED ok 1 - create picky dest repo
>     GIT_TEST_TEE_STARTED ok 2 - accepted objects work
>     [...]
>     GIT_TEST_TEE_STARTED 1..6

Ah, OK, so these perl scripts that use Test::More think they are
emitting TAP, but because the prefix is not added to any of their
output, they are not considered to be a tap output at all.

So did the "external" tests lose a lot of value with this change?
They used to point out individual breakage, but now it is just
"passed as a whole (or not)" boolean?
