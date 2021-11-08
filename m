Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C146C433EF
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 20:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38361610D2
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 20:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238323AbhKHUIY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Nov 2021 15:08:24 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55724 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234723AbhKHUIX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Nov 2021 15:08:23 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 620AAEE615;
        Mon,  8 Nov 2021 15:05:38 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=zlMEKzUfKUof
        7LJnlORuOSauRqv983zpwl6aJWM7sug=; b=UJMp9eKhYFt3yv23kNysnBsS3qp2
        2EV7s5NmymQzR7FeguSGyKybftD3nE2NC8MfAGZoIz/5OpGts5WuogX4/YXLe4+F
        Z/eT8Pcijg/JQrhphs1Jo8kfYMytuqwffWFA7oVpsGFup0BcUeKVnzlI0I9kNABY
        r6AibBv/aOAjCy8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 58F85EE613;
        Mon,  8 Nov 2021 15:05:38 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BF929EE612;
        Mon,  8 Nov 2021 15:05:37 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Birk Tjelmeland <git@birktj.no>,
        git@vger.kernel.org
Subject: Re: [PATCH] stash: show error message when lockfile is present
References: <20211107213012.6978-1-git@birktj.no>
        <YYiXw41upJfPS7l0@nand.local> <xmqqlf1zunqe.fsf@gitster.g>
        <211108.868rxyfote.gmgdl@evledraar.gmail.com>
Date:   Mon, 08 Nov 2021 12:05:36 -0800
In-Reply-To: <211108.868rxyfote.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 08 Nov 2021 20:05:47 +0100")
Message-ID: <xmqqsfw6tnu7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3DA17EFE-40CF-11EC-A527-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> The "quiet" here is orthagonal, it's to disable the chatty output from
> read-cache.c.

It shouldn't be.  read-cache.c may want to report errors and
progresses, and among the errors it may not include lock-related
things.  If the change were to (1) extend the flag word to make it
more uniform, so that it does not special case ONLY the lock-related
errors, and to (2) figure out how to grab richer diagnoses out of
the lower level API functions, and to (3) reduce the messages issued
by the lower-level API functions and have it callers' responsibility
to give the messages, that would have been palatable, but the patch
as posted goes totally the opposite direction on all these points.

Yuck.
