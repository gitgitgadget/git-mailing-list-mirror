Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B14B71F461
	for <e@80x24.org>; Thu, 22 Aug 2019 18:04:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732483AbfHVSEa (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Aug 2019 14:04:30 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61562 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfHVSEa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Aug 2019 14:04:30 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 44323165D71;
        Thu, 22 Aug 2019 14:04:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OAMM8FxK1q5ZyyIbT4JjBx7fQV4=; b=bkEgxm
        t32rAh/t0ohszQpBKM0m748+BLT6T9uCpT1MtTd/TueYcph7jCsAxcRR9niwHXNf
        +tC5Foh3HpnbGrJd8r8NHQu1dg8aJdeGk6VuOAicG/n5kS1iiRiRmYrUGvJSi2L4
        JrvP0C01GjCOpnCpyBdcLb/yFz7W2Qzd1YeEY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fVIeoAUJYmE9PhbFiebeODYo8nnqfTju
        YO77fGR8/MOTQJ5Mh1dTGV381IcLnP9wz/RiCZOrV0uBpGwz29ltImfjrIrLsgph
        h0xdLS23BD/L5Rq44Qo7lOg2nMgv8LLzIAa3FaBmU5Zo9OI7xjUPOGzCs3EWgSM1
        ulVQzYgI5Kk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3A331165D70;
        Thu, 22 Aug 2019 14:04:28 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9DD97165D6E;
        Thu, 22 Aug 2019 14:04:27 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        rsbecker@nexbridge.com, johannes.schindelin@gmx.de,
        larsxschneider@gmail.com
Subject: Re: [PATCH] t0021: make sure clean filter runs
References: <20190820065625.128130-1-t.gummerer@gmail.com>
        <aea64308-fcba-77a1-1196-182b35ad405c@kdbg.org>
        <20190821145616.GB2679@cat>
        <a8de9661-7f6a-f953-93a0-8ef88e9a490a@kdbg.org>
        <20190821220355.GZ20404@szeder.dev> <20190822174901.GA71239@cat>
Date:   Thu, 22 Aug 2019 11:04:26 -0700
In-Reply-To: <20190822174901.GA71239@cat> (Thomas Gummerer's message of "Thu,
        22 Aug 2019 18:49:01 +0100")
Message-ID: <xmqqpnkxoz4l.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 481A6170-C507-11E9-ADE4-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

>>   # Make sure that the file appears dirty, so checkout below has to
>>   # run the configured filter.
>>   test-tool chmtime =-10 .git/index &&
>>   test-tool chmtime =+0 test.r &&
>
> I think the comment is a good idea.  I personally still prefer just
> using 'touch' though, as I find it slightly easier to read (I had to
> go look up what the =-/=+ in 'test-tool chmtime' does, while I knew
> what touch would be doing :)

Yup, I do not quite get why people feel 'touch' is a bad idea here.

I also think we should discourage "test-tool chmtime =<anything>"
(i.e. set to relative to the timestamp read from time(), as opposed
to relative to the timestamp read from the filesystem), when we can
avoid it, to allow tests on remote filesystem where the filesystem
clock and the system clock may not always be in sync.

> That said that's a minor preference for me, if people have a strong
> opinion that test-tool chmtime is really better here I'm fine with
> changing it.
