Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2994C433EF
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 21:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbhK2VMO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 16:12:14 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59419 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbhK2VKN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 16:10:13 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8EA2F160995;
        Mon, 29 Nov 2021 16:06:55 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=dF2n8PObMHiB
        VzLAzJxvCZy+RlKbUcoykkEgTN3n8Rk=; b=SXYXf5grcTOr4y9qqSvm4fZ+DbP7
        ulI/iVaqYqkqayUdGZ+hk14RradpuURks1ju3XrIvqVVhxvHuYhAkZrtQUR8ZNWv
        noZ8P5B9MnPg33aUotxEp/hi5Xsb4C2Gtn6detRWh4PUp8u1Ha+YyFkk8LsKL0su
        xvi7agghvnRfFUQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 87AE1160993;
        Mon, 29 Nov 2021 16:06:55 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7C8FF160992;
        Mon, 29 Nov 2021 16:06:51 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 0/7] grep: simplify & delete "init" & "config" code
References: <cover-v2-0.8-00000000000-20211110T013632Z-avarab@gmail.com>
        <cover-v3-0.7-00000000000-20211129T143956Z-avarab@gmail.com>
Date:   Mon, 29 Nov 2021 13:06:49 -0800
In-Reply-To: <cover-v3-0.7-00000000000-20211129T143956Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 29 Nov
 2021 15:50:46
        +0100")
Message-ID: <xmqqk0gq6592.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 46035470-5158-11EC-98A3-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> In v1 and v2[1] of this series more code in grep.c was deleted by
> changing what I think is a really obscure interaction between
> "grep.extendedRegexp=3Dtrue" and "grep.patternType".
>
> Junio preferred having a deprecation period[2], so here's a re-roll
> that preserves all existing behavior, at the cost of bit less code
> deletion & simplification (from "97 insertions(+), 174 deletions(-)"
> to "106 insertions(+), 131 deletions(-)").

Deprecating grep.extendedRegexp and forcing users to only use the
grep.patterntype would be a lot more sensible way forward than
giving it a new meaning and letting these two variables interact
with each other.

Depending on how cleanly the internal code can become, with the
former variable still supported for backward compatibility, we might
not need to break working set-up existing end-users have, though.

We'll see.

Thanks.
