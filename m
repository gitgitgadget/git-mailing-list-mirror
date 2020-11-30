Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76828C63777
	for <git@archiver.kernel.org>; Mon, 30 Nov 2020 23:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19A1420725
	for <git@archiver.kernel.org>; Mon, 30 Nov 2020 23:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="muNQLih0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388714AbgK3XdM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Nov 2020 18:33:12 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62310 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388510AbgK3XdM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Nov 2020 18:33:12 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 03D9410D8C3;
        Mon, 30 Nov 2020 18:32:30 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=xWwY08ZqyP6rO062m0p75Ohjj
        i0=; b=muNQLih0GRBRGtu9Ps5X5uCPQdmfdEXb9IXDTYvPmt9sQnT3JeAsNUvnv
        3uE4d73Y9Bd4nz64E8Qh9VWhxbN/FVNwntII7F2stcEWZZNTAcWQdJG/CPRc3fiA
        +Lr2bhLXfHUaVkNXa5QO80o0e37wq/UkLEiaC79ZeTA4nk25zA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=v2oBkkCR/V1Gr+QMUR8
        YlaQK8Xk4XjC5M7OASBz96vNWxH5X6SM2YN2yNatULVDwi1X2cqf3SRcdrXxjmBF
        FaqZoVGbitInBXVtZcHplG3+lqgefAJo0dBbd+w5cwRT9kF+qLllNrXVO5qV5Nc8
        v62Gx1nVpWewTOnbAJgw7gSc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EF8B510D8C2;
        Mon, 30 Nov 2020 18:32:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3125510D8C1;
        Mon, 30 Nov 2020 18:32:27 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
        Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 0/2] make macOS `git maintenance` test work on Windows
References: <20201130044224.12298-1-sunshine@sunshineco.com>
        <87blffjkne.fsf@evledraar.gmail.com>
Date:   Mon, 30 Nov 2020 15:32:25 -0800
Message-ID: <xmqqr1oato8m.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4E8781BA-3364-11EB-AA43-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Also as another aside (but your patch is fine as it is), my suggestion
> used Perl+Perl RX but you switched it to sed+BRE. Do we want to avoid
> "sed -E"? I wondered that for something else the other day, we have
> this:
>
>     t/check-non-portable-shell.pl:  /\bsed\s+-[^efn]\s+/ and err 'sed o=
ption not portable (use only -n, -e, -f)';
>
> So maybe it means "nothing but -nef, or maybe "don't use -efn". The ERE
> (-E and -r) options aren't mentioned, and a na=C3=AFve log search of of=
 "sed
> -E" and "sed -r" in t/ returns nothing.

Correct.  We currently do not use "sed -E", and the script says
"Let's not use it; it's not even in POSIX" for things other than
'n', 'e', and 'f'.

https://pubs.opengroup.org/onlinepubs/9699919799/utilities/sed.html

Thanks.
