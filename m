Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF112C433F5
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 16:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB37B60F6D
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 16:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235573AbhI0Qu0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 12:50:26 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51566 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235467AbhI0Qu0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 12:50:26 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9FDDDF67C4;
        Mon, 27 Sep 2021 12:48:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=3526dbcA8VmA
        ChsqgAo7/5f8NMG9mhH0E983Vtnyy7I=; b=XbFuOK0R7H+PLKzsenoI3ZsPqWcS
        CpmelUSvs6Ve9gmdSB6NSSmu5Hn5N4o3FV5q5qknb9190ykbVHsQwywv9Nx3orct
        VyLkguHx8aH7y2UduLMTHJsGQ8zbGe3WvBxwGvXI4Ig6tUsVi2aFJQk3u2Hzcd90
        WXUwdn7B/MiBW6Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 96A01F67C3;
        Mon, 27 Sep 2021 12:48:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0A937F67C2;
        Mon, 27 Sep 2021 12:48:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v2 8/8] hook-list.h: add a generated list of hooks, like
 config-list.h
References: <cover-0.8-00000000000-20210923T095326Z-avarab@gmail.com>
        <cover-v2-0.8-00000000000-20210926T185800Z-avarab@gmail.com>
        <patch-v2-8.8-7420267ce09-20210926T185800Z-avarab@gmail.com>
Date:   Mon, 27 Sep 2021 09:48:44 -0700
In-Reply-To: <patch-v2-8.8-7420267ce09-20210926T185800Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sun, 26 Sep
 2021 21:03:29
        +0200")
Message-ID: <xmqqfstqq80j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C7EFBC1C-1FB2-11EC-B84A-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> +sed -n \
> +	-e '/^~~~~*$/ {x; s/^.*$/	"&",/; p;}' \
> +	-e 'x' \
> +	<Documentation/githooks.txt |
> +	LC_ALL=3DC sort

Thanks.  It is not wrong per-se, but if you are willing to do a
multi-line script for readability, wouldn't a much more readable
"single long and multi-line string" approach, i.e.

    sed -ne '
	/^~~~~*$/ {
		x
		s/^.*$/ "&",/
		p
	}
	x
    ' Documentation/githooks.txt |
    LC_ALL=3DC sort

work better?
