Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2755C433C1
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 22:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C06C61985
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 22:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbhC2Wqe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 18:46:34 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55705 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbhC2WqK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 18:46:10 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 090A0B913E;
        Mon, 29 Mar 2021 18:46:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=2vACNOTfoZQU
        9xuYfHfYQa4j9PY=; b=kb0xV+Spy0Nq5dNjCT3af5XhAb3dLIuni/SsEX+YcWQ+
        Ddf+yzBl7IfvRvegrdjMdJYTyFJ8c8ad21m9e7fEObfHg5rLpY5erPiNqE1QK6qC
        QTEfSetgVg+BHLcRCwKPwLA9M21yTgPvcvi6fwRkdb4QgmeIMC0CRfNqBEkJ9/Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=vgN3Te
        s3bps+/N5HdeSQhWiPEozBO6EeyaEDsNlDLwxxUoDA6qL/CjcY8G5sAMhqIf34Ro
        nhJkkRGZzQh2ji+G1IRgTdKvsmGQsSnnUAXiMNVq1pZx27dKptns5dv6b3Omij0H
        53cAyVW4e2JN0391Xh3K7YCwtL1i93O8cGEy4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 008E2B913C;
        Mon, 29 Mar 2021 18:46:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 61381B913B;
        Mon, 29 Mar 2021 18:46:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Andreas =?utf-8?Q?F?= =?utf-8?Q?=C3=A4rber?= 
        <andreas.faerber@web.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 5/6] Makefile: use "ln -f" instead of "rm && ln"
References: <cover-0.6-00000000000-20210329T161723Z-avarab@gmail.com>
        <cover-0.7-00000000000-20210329T162327Z-avarab@gmail.com>
        <patch-5.7-f81708f6120-20210329T162327Z-avarab@gmail.com>
Date:   Mon, 29 Mar 2021 15:46:08 -0700
In-Reply-To: <patch-5.7-f81708f6120-20210329T162327Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 29 Mar
 2021 18:31:43 +0200")
Message-ID: <xmqqim59h93j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8DFDBD94-90E0-11EB-A71B-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change the invocations and behavior of "ln-or-cp.sh" to not assume
> that we're going to "rm" the file in question beforehand.
>
> This reduces the complexity of these rules, and as a bonus means it's
> now safe to "make install" on a system that may have running "git"
> programs, before this we'd be racing the "rm && ln/cp" and wouldn't
> have a working "git" (or one of the built-ins) in the interim.

Neither link(2) nor symlink(2) has the equivalent of the -f flag, so
"ln [-s] -f" has to be implemented as an unlink(2) followed by
link(2) or symlink(2) anyway, so you didn't solve the "racing"
problem (if that is a problem in the first place, that is), did you?

The only reason why "rm -f t && ln s t" makes sense over "ln -f s t"
is because there could be a leftover 't' directory from a previous
build or rogue testing process or whatever.  It avoids creating a
hardlink at t/s, unlike "ln -f s t" which would happily do so.  It
would let us notice there is something fishy going on by failing to
remove the stray directory that should not exist.

I do not object to replace "rm then ln" with "ln -f", as the "be
cautious against somebody mistakenly making a directory there" is
not something I find valuable all that much.

But I do not want to be associated with a commit that claims that
"ln -f" avoids race in "rm && ln" ;-).

Thanks.

