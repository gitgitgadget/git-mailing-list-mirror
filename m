Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DED3F20899
	for <e@80x24.org>; Mon, 14 Aug 2017 20:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752504AbdHNUfj (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 16:35:39 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57979 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752499AbdHNUfi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 16:35:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 33ADDB07E6;
        Mon, 14 Aug 2017 16:35:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=OPOCHGKJNfsT
        DdaHzXDjEY6rUWE=; b=kzA8rpE/cPZrUnrWn2Rs7YeiQmyWd1tkLWCxNa/yOhHl
        itE5JbJEN93Q0hPIGnZupnxHITK7ZutUB4E4ijO1+lK6nbgIa2NWy892sbd9MKQS
        QeWlwZivx88be2T5MpJgRxRHIpg4rHf4N9x/mhu8pj9UIZY03IwLlguWTwLVscw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=v5JukV
        wm/bFh263EBWukExTP/mIklczLEvm3zAUQgmbhaMIFEmtuYaQxgQVjd1jOmWp2ov
        Tnh4hi2gu0D6+5SMlMnwwkOiEYXFlKyBC2/VjlePqAK631LLtNjKpmibdatNN/W8
        8UD75lZlkQfJIrCLpAvEx9v2aZ/AyRtB7nEh0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2BE60B07E5;
        Mon, 14 Aug 2017 16:35:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7B9B6B07E1;
        Mon, 14 Aug 2017 16:35:37 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
        Benoit Lecocq <benoit@openbsd.org>
Subject: Re: [PATCH] t1002: stop using sum(1)
References: <9f6e13d3-07ff-1eaa-9453-05ca26a3c1ff@web.de>
Date:   Mon, 14 Aug 2017 13:35:36 -0700
In-Reply-To: <9f6e13d3-07ff-1eaa-9453-05ca26a3c1ff@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Mon, 14 Aug 2017 22:16:34 +0200")
Message-ID: <xmqqtw19ubtz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 214D37E2-8130-11E7-8D0F-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> It's more convenient because it shows differences nicely, it's faster o=
n
> MinGW because we have a special implementation there based only on
> shell-internal commands,...

This made me wonder why we are not using that "faster" one
everywhere, but it turns out that it depends on bash-ism "local",
which is perfectly fine when limited to MinGW but not safe to assume
in general.

> ...
> With all sum(1) calls gone, remove the MinGW-specific implementation
> from test-lib.sh as well.
>
> [1] http://minnie.tuhs.org/cgi-bin/utree.pl?file=3DV3/man/man1/sum.1
> [2] http://minnie.tuhs.org/cgi-bin/utree.pl?file=3D4.4BSD/usr/share/man=
/cat1/cksum.0
> [3] http://pubs.opengroup.org/onlinepubs/9699919799/utilities/cksum.htm=
l
> ---
>  t/t1002-read-tree-m-u-2way.sh | 67 ++++++++++++++++++++++-------------=
--------
>  t/test-lib.sh                 |  3 --
>  2 files changed, 35 insertions(+), 35 deletions(-)

Sounds like a sensible approach to clean things up; I didn't check
with fine toothed comb if the patch does follow that approach
correctly without breaking things, though.

