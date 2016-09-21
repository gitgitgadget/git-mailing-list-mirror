Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D0AE1F935
	for <e@80x24.org>; Wed, 21 Sep 2016 19:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934335AbcIUTSB (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 15:18:01 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62957 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932771AbcIUTSA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 15:18:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 423573E626;
        Wed, 21 Sep 2016 15:17:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=EMROIcqmWMnHinLOghGqT4pCheQ=; b=vL4oeAlreTspOfG7NL9E
        6542amcAG1Zgf2TYpusgYPO3UWOSS6bYvpJGBcwCPvxnTb1L7T2LYuJPzP+ARb0g
        dbCqcvu6/aHSz5ENrt317N/YvxaG/ohWhCZMO8IP95k7pKQ9wszMPyRSDRBWSt0/
        o629XKT1YIUi23isa39ApSA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=EH1NOhRpJjZ315tjlX6pySahLSTEvpHMIaMrTf8zliBPyX
        +FKmbwAP9r6mem5sfVRQc90jeNapzyWPJyR4DbfEn2FTZuv1vWsD09eljjMCf1XC
        rCgk13WN4oNhQLOkSypn+NRw09qQ6225fQGM4sQ+76qZP0I7j4co06IowHLkY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3AFDB3E625;
        Wed, 21 Sep 2016 15:17:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B467E3E622;
        Wed, 21 Sep 2016 15:17:58 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Benjamin Kramer <benny.kra@googlemail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v4 2/3] regex: add regexec_buf() that can work on a non NUL-terminated string
References: <cover.1473321437.git.johannes.schindelin@gmx.de>
        <cover.1474482164.git.johannes.schindelin@gmx.de>
        <270cea11c4d8bfb332a6c014a11673b7f4666ee4.1474482164.git.johannes.schindelin@gmx.de>
Date:   Wed, 21 Sep 2016 12:17:56 -0700
Message-ID: <xmqqtwd96p0b.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1B616A8A-8030-11E6-A589-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> ...
> Happily, there is an extension to regexec() introduced by the NetBSD
> project and present in all major regex implementation including
> Linux', MacOSX' and the one Git includes in compat/regex/: by using
> the (non-POSIX) REG_STARTEND flag, it is possible to tell the
> regexec() function that it should only look at the offsets between
> pmatch[0].rm_so and pmatch[0].rm_eo.
>
> That is exactly what we need.

Wonderful.

> Since support for REG_STARTEND is so widespread by now, let's just
> introduce a helper function that uses it, and fall back to allocating
> and constructing a NUL-terminated when REG_STARTEND is not available.

I'd somehow reword the last paragraph here, though ;-)

    Since support for REG_STARTEND is so widespread by now, let's just
    introduce a helper function that always uses it, and tell people
    on a platform whose regex library does not support it to use the
    one from our compat/regex/ directory.

The patch itself looks very sane.  Thanks.
