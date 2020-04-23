Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C54AC54FD0
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 22:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25E7B2077D
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 22:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CFj9rZb7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbgDWWLa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 18:11:30 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51599 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgDWWL3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 18:11:29 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A6C024D7B1;
        Thu, 23 Apr 2020 18:11:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MZ+HGmczFiREJEuTcd4rM087raE=; b=CFj9rZ
        b7SiPvbdhvg20ufroXnIHwwdR1hlhyuPX66c5EHDIcaY1URUNstngDY+fNitF0oT
        tTvEOnDehIvjR13q6Ws/sQGFk3bp+AHKzLlavUuSARe/rPOuR4TagNj7oglkedTX
        ysYZpEjS7DhE+Z0Hv7Gbsg/WOZRt3PIuZ83p0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xfF0G0+NP0Z2rw9V2wMd2BvVxgYoxPZd
        Ub+DdFR4oFKVvwNW80z3+hAr/XwJn8GX3LEzItl1UquS1yYNqIxyc6jh5FGj+E7T
        Lh/h8l6wZu0cf9u6P80ZyExs1nWH5yf/UHZj4sSLgHD5CMm6dGczKJ2cVaJqAuMr
        7s0+OqlU/XE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 93D804D7B0;
        Thu, 23 Apr 2020 18:11:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D57314D7AF;
        Thu, 23 Apr 2020 18:11:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ilya Tretyakov <it@it3xl.ru>
Subject: Re: [PATCH 2/3] credential: teach `credential_from_url()` a non-strict mode
References: <pull.615.git.1587588665.gitgitgadget@gmail.com>
        <1081841b16de31693473e72ff817bed5f0064dda.1587588665.git.gitgitgadget@gmail.com>
        <20200422233854.GE140314@google.com>
        <CAPUEspgJvN6f6Wjo-yjYj-x+bYtC3vdSvwUtrF=MbJDjwYUTdA@mail.gmail.com>
        <nycvar.QRO.7.76.6.2004231433060.18039@tvgsbejvaqbjf.bet>
        <20200423212212.GA20669@Carlos-MBP>
        <nycvar.QRO.7.76.6.2004232359120.18039@tvgsbejvaqbjf.bet>
Date:   Thu, 23 Apr 2020 15:11:25 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2004232359120.18039@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Fri, 24 Apr 2020 00:03:17 +0200
        (CEST)")
Message-ID: <xmqqy2qlette.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5FA93EB0-85AF-11EA-9F05-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Yes (modulo doing "greater than" comparison on pointers which is IIRC not
> permitted in C in general).

Of course, people write a loop like this

	char *cp, *ep = strchr(string, '\n');

	for (cp = string; cp < ep; cp++)
		...

all the time, and forbidding pointer comparison would make the
language impossible to use ;-)

I think you are confused with a different rule---what is not kosher
is to compare two pointers that do not point into elements of the
same array.  Whether the comparison is done in (ptr1 < ptr2) way, or
(ptr2 - ptr1 < 0) way, does not change the equation.
