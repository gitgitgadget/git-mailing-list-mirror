Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E7EC433C1
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 20:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91DCB6193A
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 20:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbhCTULM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Mar 2021 16:11:12 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53965 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhCTUKu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Mar 2021 16:10:50 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id ADD3411FEA0;
        Sat, 20 Mar 2021 16:10:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Fj8dm7QKevu1
        r+YYqIE6YsObrUM=; b=qXRo+/ek/9lyA7MGYqnFRXwXXf6MDHKbhTaxpIkvKwWa
        3ncvXF/P2KAGXE8PdKvONFNoePQEnYrlAI2NlFim5pz5mt3E1vNlOs1IUcMxSrsF
        SC1Xjd+um9ORx8cwQSXHFLA1C1kmCBJvlVttP7N3aQvFsoeiZm33shuS0lNaCXA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=RDTMPy
        2M0liGpguJ2GyB3TgQSLWqTFNI6FWClmauKxCt3nIed/jM2NbBa8bbuiFBeCmpSI
        RmZ2XaDs0QkWjeGfDNGTYQG22cwJZ+hiion2+VHgvgQbsV4kNjmex8ojoNc2pBZO
        2l/7KqNhQAKIfayQgcn3UeqI4os3QLBorp+y4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A629B11FE9F;
        Sat, 20 Mar 2021 16:10:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EA80B11FE9E;
        Sat, 20 Mar 2021 16:10:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v6 16/21] mingw: try to work around issues with the test
 cleanup
References: <pull.31.v5.git.gitgitgadget@gmail.com>
        <pull.31.v6.git.gitgitgadget@gmail.com>
        <991b41afa4a83a73f59a72504d269d64d12ecf8f.1548771561.git.gitgitgadget@gmail.com>
        <87zgzbgp1i.fsf@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.2103191515430.57@tvgsbejvaqbjf.bet>
        <87a6qxzocs.fsf@evledraar.gmail.com>
Date:   Sat, 20 Mar 2021 13:10:46 -0700
In-Reply-To: <87a6qxzocs.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Sat, 20 Mar 2021 19:12:03 +0100")
Message-ID: <xmqqmtuxk2m1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5C428566-89B8-11EB-B52A-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> In any case, your patch clearly undoes whatever canary for gc issues
> df4c0d1a792 was trying to put into the test-lib, but didn't say so in
> its commit message.
>
> So I figured it was something that was missed at the time, and that I
> should send a quick E-Mail to both authors to see if anyone cared, mayb=
e
> nobody does.
>
> It's just something I ran into while reviewing test-lib.sh for some
> unrelated changes I was making...

Good eyes.

I am not quite sure if we are better off catching a transitory
failure, which could go away when retried in 5 seconds, to remove
the test directory (in which case, the change in question is a clear
regression from what df4c0d1a (test-lib: abort when can't remove
trash directory, 2017-04-20) intended to catch), or we only want to
catch permanent failures (in which case the patch in question is a
clear improvement).

In either way, the decision and the rationale behind it should be in
the log message.

Thanks.
