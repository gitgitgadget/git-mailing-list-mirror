Return-Path: <SRS0=wu5b=B6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F70C433E1
	for <git@archiver.kernel.org>; Thu, 20 Aug 2020 04:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64E4420786
	for <git@archiver.kernel.org>; Thu, 20 Aug 2020 04:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="P/Lmzm99"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725885AbgHTE4m (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Aug 2020 00:56:42 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51101 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgHTE4l (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Aug 2020 00:56:41 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4E6AFF41E8;
        Thu, 20 Aug 2020 00:56:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=UW+QUm5BJQQS
        0XWcC+UhcLaZL6o=; b=P/Lmzm9943qHtPA1Eyh7/76OR4k7B41XtStrH/8ZGu+j
        JDsr1YNVEp3z9CkvFh1E8H3euJ8tk2Rk+TfqkWCCv6OZdbndzn2TJ/e/kehLmKw9
        r1Hh3LTd4SNqVNIas6OsKpKY1kcIarlZf2RLhvuB8RJWWMeRAc1+HG3wuQSlISc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=F6rINm
        mHbO0W+wcWEaNmg4a63C1xVwKxM6aBGuXT6pbRzhTE2IgVyL8eJBeXphPORFBCfi
        O4En5fe0w9USc5cB56lC8epbO/zNBvZRUhq61dW4p/VBXaMoaTcdi68Ghj7yFbQc
        POiOR5UIPQvgWNQbnk6r7huIoHrZS2uTrnudo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 46417F41E7;
        Thu, 20 Aug 2020 00:56:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3F529F41E4;
        Thu, 20 Aug 2020 00:56:35 -0400 (EDT)
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
Date:   Wed, 19 Aug 2020 21:56:33 -0700
In-Reply-To: <20200815022759.GC12363@danh.dev> (=?utf-8?B?IsSQb8OgbiBUcg==?=
 =?utf-8?B?4bqnbiBDw7RuZw==?= Danh"'s
        message of "Sat, 15 Aug 2020 09:27:59 +0700")
Message-ID: <xmqqv9hdc3um.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 85ECD79A-E2A1-11EA-BFD4-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

>> Anyone is welcome to have my sign-off if they pick up any part of this
>> patch.
>
> This one seems to work with:
>
> 	make -j9 test GIT_TEST_DEFAULT_HASH=3Dsha256
>
> If noone step up and write this into a patch in some days,
> I'll take this as first step in my series.

So, is there anything happening on this front?

Thanks.
