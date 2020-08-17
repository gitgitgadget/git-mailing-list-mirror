Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32134C433E1
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 16:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E87462054F
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 16:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UPepnJZC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388691AbgHQQWu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 12:22:50 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63583 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730794AbgHQQSH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 12:18:07 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CD54CDDDEE;
        Mon, 17 Aug 2020 12:18:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=aHI1N57sy0eY
        C+nZqRABvGLGxnQ=; b=UPepnJZCAW5ji8ZtNJQlTngWluwEfn9nIvsW1MOEUhNi
        aPi3QibeCDcw5qu4JmJVTZTPXGWGqZBn8ou019BlwUVKeWzftpncaczF3Q86eGji
        HzE39zDGfphpzGIcJTVJr+LnKS2GosOYt1S/S7qhaPPD3Ot1Oek8DIbXLKacOM0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=hlNIPb
        6C1YjABmiCLhZHOwBVnKvbXyDixiOsCCsLPFd8YpCBKpPyXOpBilnmnwPzb70/ei
        /YRnq80mMHe6Yum/v4FXowXtX0uK3lTjoL5xg0GjfLOhLomEMmc6Hd3kVgNfn7xo
        uzytybgdZ6QSYyz439Fe4625ayOH/y3FTBYso=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C6713DDDED;
        Mon, 17 Aug 2020 12:18:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.190.152.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 15D1DDDDE9;
        Mon, 17 Aug 2020 12:18:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= 
        <szeder.dev@gmail.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/2] diff: index-line: respect --abbrev in object's name
References: <cover.1596887883.git.congdanhqx@gmail.com>
        <cover.1597364493.git.congdanhqx@gmail.com>
        <760df7782dad9e9df7bb284ec57249e697a4cc92.1597364493.git.congdanhqx@gmail.com>
        <20200814151815.GA29528@szeder.dev>
        <xmqqwo21xiuy.fsf@gitster.c.googlers.com>
        <xmqqy2mhvys6.fsf@gitster.c.googlers.com>
        <20200815002120.GQ8085@camp.crustytoothpaste.net>
        <20200815022759.GC12363@danh.dev>
Date:   Mon, 17 Aug 2020 09:17:59 -0700
In-Reply-To: <20200815022759.GC12363@danh.dev> (=?utf-8?B?IsSQb8OgbiBUcg==?=
 =?utf-8?B?4bqnbiBDw7RuZw==?= Danh"'s
        message of "Sat, 15 Aug 2020 09:27:59 +0700")
Message-ID: <xmqqo8n9456w.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 388A0B88-E0A5-11EA-AC19-843F439F7C89-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

>> Anyone is welcome to have my sign-off if they pick up any part of this
>> patch.

Likewise.

> This one seems to work with:
>
> 	make -j9 test GIT_TEST_DEFAULT_HASH=3Dsha256
>
> If noone step up and write this into a patch in some days,
> I'll take this as first step in my series.
>
> Also waiting some days so other people could come up with better idea,
> sed's y seems to be able to work if we don't have the constraint
> on all-0 oid.

y/// would help with the "same length" transformation, but I think
the primary reason why "sed" would not work well in this example is
"locate the things to tranform" part is harder to separate from
"here is how to transform a token" part when written in "sed".

Yes, you could use /pattern/{ s/from/to/; s/from2/to/; ...} but
at least I didn't see an obvious way to simplify the original and
reduce its repetitiveness.
