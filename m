Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 420E61FC43
	for <e@80x24.org>; Fri,  6 Oct 2017 12:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751997AbdJFMC2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 08:02:28 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53112 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751925AbdJFMC1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 08:02:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3B429A192D;
        Fri,  6 Oct 2017 08:02:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=XK1vlJHWGoKq
        fNNEFP0GW93b94w=; b=JKnGXnhYw85h2IMs40HcDgD7i7BP5zHEdtFskl2SDrMo
        7Y7EznCmF6mi0o/6ouP/0PZPuSgWwu44EtZCX6Tb+J/AwfXDdhIVZLhe7Dmfmfxz
        6Ax5iu0ub0jrkJEEfKCXAiExvi59kTJV/FIj9FPq6wEuqtEFute1OZ2Qb2aPSh0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=nFaJe8
        ZbUKAbes+gHBupUwgD00vpgqQ1j9y4DeBHOT+f71lF2oX11D2LL8lzBoJClTaIwy
        BvNO0nJpkFKNRiIXVctPyJISOjQ9D+ud4U8qY0KXrLz0Qk6KiBwCQ9Ygw3riBZOA
        Ha+B2wUhsVYrVqEdCLQG8eFWFEDjgfMF3nFHA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 319D6A192C;
        Fri,  6 Oct 2017 08:02:27 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8CD89A1929;
        Fri,  6 Oct 2017 08:02:26 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2 11/12] read-cache: leave lock in right state in `write_locked_index()`
References: <xmqqy3osiwe6.fsf@gitster.mtv.corp.google.com>
        <cover.1507228170.git.martin.agren@gmail.com>
        <b5fc950e4594fb9dec07ec8872c0df8514d149ff.1507228170.git.martin.agren@gmail.com>
        <xmqqefqhyqyg.fsf@gitster.mtv.corp.google.com>
        <CAN0heSojqHEQQfwUaGuLH2TjN+aHSFHg4WAvcd5Ksnxd-54YMg@mail.gmail.com>
Date:   Fri, 06 Oct 2017 21:02:25 +0900
In-Reply-To: <CAN0heSojqHEQQfwUaGuLH2TjN+aHSFHg4WAvcd5Ksnxd-54YMg@mail.gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Fri, 6 Oct 2017 13:04:53
 +0200")
Message-ID: <xmqqvajsv60e.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 385F1AF4-AA8E-11E7-AB3E-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> On 6 October 2017 at 04:01, Junio C Hamano <gitster@pobox.com> wrote:
>> Martin =C3=85gren <martin.agren@gmail.com> writes:
>>
>>> v2: Except for the slightly different documentation in cache.h, this =
is
>>> a squash of the last two patches of v1. I hope the commit message is
>>> better.
>>
>> Yeah, it is long ;-) but readable.
>
> "Long but readable"... Yeah. When I rework the previous patch (document
> the closing-behavior of `do_write_index()`) I could address this. I
> think there are several interesting details here and I'm not sure which
> I'd want to leave out, but yeah, they add up...

I didn't mean "long is bad" at all in this case. =20

Certainly, from time to time we find commits with overlong
explanation that only states obvious, and they are "long and bad".
But I do not think this one falls into the same category as those.


