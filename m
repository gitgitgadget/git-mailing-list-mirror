Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A697C433E1
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 15:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CDF920855
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 15:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wwYvB02r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgHUPoi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 11:44:38 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59968 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgHUPoh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 11:44:37 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1F20C79D96;
        Fri, 21 Aug 2020 11:44:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=14Gai3Py3HBO
        QaHjAt3IoohwFL8=; b=wwYvB02r7BC5REa/SUKAhcV8aOovxm+2SAmDmm9vyHNf
        YgOCT7f98nr1A7bKxXRjpwrEwSFqLgHwbPUBsGziaKBH+scQkdn8cVvT8ktszTE4
        lg46Pp+sT2/IgToIG7hNMCpeg7SQ+4wgmniqZhQQ7KZZfn0nu5K+Vkv6q82f07I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=xtjGnV
        qXzsQwgBftuc+OOY/7U9BDP2jm4cmqx94msv6eh95Ahxq5IJPDu7Bq2pG464I/8H
        bL10pxOTE/p5+T2VfIxljXw2y7/qthmMOKzBGYdeqzkK/1zE04kamv1GKCjPllzd
        oEASnlcJLB9pz5fzYQ+g/0Mzetngwkvyk1rdw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 14F3779D93;
        Fri, 21 Aug 2020 11:44:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3694879D92;
        Fri, 21 Aug 2020 11:44:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 1/2] t4013: improve diff-post-processor logic
References: <cover.1596887883.git.congdanhqx@gmail.com>
        <cover.1597926783.git.congdanhqx@gmail.com>
        <a52d0e59ecd5777f2a1d242a37c6bb6aaafb1ed2.1597926783.git.congdanhqx@gmail.com>
        <xmqqr1s1ayj2.fsf@gitster.c.googlers.com>
        <20200821120525.GA599@danh.dev>
Date:   Fri, 21 Aug 2020 08:44:31 -0700
In-Reply-To: <20200821120525.GA599@danh.dev> (=?utf-8?B?IsSQb8OgbiBUcg==?=
 =?utf-8?B?4bqnbiBDw7RuZw==?= Danh"'s message
        of "Fri, 21 Aug 2020 19:05:25 +0700")
Message-ID: <xmqqzh6o9f6o.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 357244D8-E3C5-11EA-AC2F-01D9BED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

> On 2020-08-20 12:49:05-0700, Junio C Hamano <gitster@pobox.com> wrote:
>> > diff-processor logic.
>> >
>> > Let's fix the bug for all-zero object names and extend object names'
>> > abbrev to 16 while we're at it.
>>=20
>> "and support abbreviation of object names up to 16 bytes"?
>>=20
>> Also while we are at it, we fixed the post-processing not to touch
>> the file modes, which were mistakenly munged in the older code as if
>> they were object names abbreviated to 7 hexdigits.
>
> I've integrated your suggestion into newest series.
> I think you meant 6 hex-digits here, and I took the liberty to change
> to 7 digits.

Thanks, yeah, 100644 has 6 digits but I somehow couldn't count ;-)
