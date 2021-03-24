Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3F6C433C1
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 19:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FCC0619B1
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 19:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237654AbhCXTDS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Mar 2021 15:03:18 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52115 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237755AbhCXTC7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Mar 2021 15:02:59 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EA2D612A2E7;
        Wed, 24 Mar 2021 15:02:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=dBUE20x8HwVW
        L/9d/d1xz/ybhDU=; b=LYei+SLtp4rlujLexLLBlGBvi0cU8Ce6VVd3WRUrznHw
        6N5Fpv9+rjKxXC/OQQh00pbRRXdKYdKMXjYdWOGilas55GYVxNtCknIlvDVojoae
        eeDcPqDI4PyGjmem9O4h06GFJ1ZTKxV1JJ78MXTP+Uw+fjLzY9XCZf6pDdDc+G4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=n2oOgb
        0B3BJKhK6Im4ZV8h6XtYogycprDA8oO431UUFb5WAraVHf6RzysqAMLI09jsfBo1
        jK0nQzaQBkplt+TSZnQpmR2KFQ9s6zZVQeKvAfuH6y57Zp0cwSs6g53x0JR+2wjw
        HUT62t2imC7zeoy4AngGmOLXwEp+X6x5/5Yl0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E1C6412A2E6;
        Wed, 24 Mar 2021 15:02:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2F35A12A2E5;
        Wed, 24 Mar 2021 15:02:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v4 00/10] userdiff: refactor + test improvements
References: <20210224195129.4004-1-avarab@gmail.com>
        <cover-00.11-00000000000-20210324T014604Z-avarab@gmail.com>
        <7c560336-c087-5159-06c2-5b22e949902e@kdbg.org>
Date:   Wed, 24 Mar 2021 12:02:54 -0700
In-Reply-To: <7c560336-c087-5159-06c2-5b22e949902e@kdbg.org> (Johannes Sixt's
        message of "Wed, 24 Mar 2021 18:19:54 +0100")
Message-ID: <xmqq5z1gz869.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8AF34076-8CD3-11EB-9B64-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 24.03.21 um 02:48 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>> This is a restart of the 35-patch v3 of this topic at
>> https://lore.kernel.org/git/20210224195129.4004-1-avarab@gmail.com/
>>=20
>> I still plan on submitting the rest of it, but wanted to start with
>> the early parts of that series that hasn't been controversial or has
>> outstanding feedback I haven't addressed.
>>=20
>> The range-diff to v3 is just for those patches I'm re-rolling here.
>
> I'm mostly relying on the interdiff below. I think I had no comments on
> these patches in the earlier round, so:
>
> Acked-by: Johannes Sixt <j6t@kdbg.org>

Thanks.  I've read through everything in the patch this round,
ignoring anything that came before, and them looked mostly fine.
Peff's comment on 01/10 to make it if/else if cascade does make
sense to me, too, though.

