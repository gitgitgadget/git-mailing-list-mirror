Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C60C433EF
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 17:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C1E661362
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 17:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242067AbhI1RqX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 13:46:23 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50726 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242041AbhI1RqW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 13:46:22 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B77C015F289;
        Tue, 28 Sep 2021 13:44:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=m7oO1GYs05Uz
        Kf1dq10KFHw6VeGDu5/n7R8tqyytVBQ=; b=ZD9h+aXMUkGZO1ES0GG5v2gN/c+v
        U37K+fu/RQ61oh0IE7mbY39xBG+cuUqHZDkucQzBtbmYgyBhykkSLn0ouvN78DXq
        6nb1k6wAORBZnx/2h8yMsAKd5n6f7CuY+94AnYRlt7MwomcYzGcgE17a/8Kq/qXY
        7XE/TDu4OB1PbYQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B01DB15F288;
        Tue, 28 Sep 2021 13:44:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1E25F15F286;
        Tue, 28 Sep 2021 13:44:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Denton Liu <liu.denton@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v4] Makefile: add a non-.PHONY "sparse-incr" target
References: <patch-v3-1.1-b6ba99ca4cc-20210928T011319Z-avarab@gmail.com>
        <patch-v4-1.1-f31fa3e8282-20210928T014023Z-avarab@gmail.com>
Date:   Tue, 28 Sep 2021 10:44:38 -0700
In-Reply-To: <patch-v4-1.1-f31fa3e8282-20210928T014023Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 28 Sep
 2021 03:43:31
        +0200")
Message-ID: <xmqqy27gk321.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C1885F74-2083-11EC-BADC-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> I.e. per [2] want "make <file>.sp" to *always* run "sparse", even
> though a corresponding "make <file>.o" would only re-run the "real"
> compilation if needed.

It is different from my reading.  If <file>.c and what it includes
haven't changed, it would be fine not to run "sparse".  The point of
running "make <file>.sp" is to see it fail if there is something
problematic.  If there is any room for the word "*always*" to come
into the observation, it would be more like "if we cannot make it
follow the usual dependency rules like the real compilation, we can
live with it always running, as it is fast enough".  If we can make
it honor the dependencies, that would give the best of both worlds,
and we do not have to add an extra target.

