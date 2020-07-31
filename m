Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65F2C433DF
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 20:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC4932072A
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 20:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wmaBg8Ru"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgGaUa1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 16:30:27 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57646 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbgGaUa0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 16:30:26 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BABB9EE155;
        Fri, 31 Jul 2020 16:30:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DXTGhWmYlbUwhjNkBIP8TpEYRjg=; b=wmaBg8
        RufuuwE8H9V5cPmnWdhWzU3qJ7kHUEo2V8nA5iw06zOz6GfSLXvSYTn6q6pnrCMI
        ZzPvDb6KtCNc3EOHpRpZdhchNTAr3UfTGhpE60lASPjzT8vVq/iCg0ksNHvfyH2K
        7P7U1EW0snt56k8qHUlVAy5TIxo8cFOAbJlx4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NWsh57tOdxAbNQ9+3a3rnTNYEBpRzv4Q
        Ps3gGA/bCBKJLVxSYW6RWpgjjC1S+7iCS+uxP2Xa6jq31iRIX8mFmcJfEMEPMoZV
        08o60OVIyiI8H3V8MMyzulXQKEfppl7N2zS7PUji/5/W1+Zx0pCnMuQvKBk/UUN3
        3Vjl3L6U0CE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B2FD3EE154;
        Fri, 31 Jul 2020 16:30:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AE8B5EE153;
        Fri, 31 Jul 2020 16:30:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Jeff King <peff@peff.net>, Alban Gruin <alban.gruin@gmail.com>,
        git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v5 3/3] ref-filter: add support for %(contents:size)
References: <20200710164739.6616-1-chriscool@tuxfamily.org>
        <20200716121940.21041-1-chriscool@tuxfamily.org>
        <20200716121940.21041-4-chriscool@tuxfamily.org>
        <21bb2dad-5845-8cee-8f6a-1089ef7cae3b@gmail.com>
        <20200731174547.GC843002@coredump.intra.peff.net>
        <CAP8UFD15+p+xKwJ=B9WVsrc+2TvLHKmu78SBCLUFZVSYoTtbbg@mail.gmail.com>
Date:   Fri, 31 Jul 2020 13:30:19 -0700
In-Reply-To: <CAP8UFD15+p+xKwJ=B9WVsrc+2TvLHKmu78SBCLUFZVSYoTtbbg@mail.gmail.com>
        (Christian Couder's message of "Fri, 31 Jul 2020 22:12:13 +0200")
Message-ID: <xmqqa6zf2zs4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A7702834-D36C-11EA-B67E-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> Hi Alban and Peff,
>
> On Fri, Jul 31, 2020 at 7:45 PM Jeff King <peff@peff.net> wrote:
>>
>> On Fri, Jul 31, 2020 at 07:37:22PM +0200, Alban Gruin wrote:
>>
>> > > +           # Leave $expect unquoted to lose possible leading whitespaces
>> > > +           echo $expect >expected
>> > > +           test_expect_${4:-sucess} $PREREQ "basic atom: $1 contents:size" '
>> >
>> > There is a typo here, and $expect is written to `expected', but
>> > `test_cmp' wants `expect'.  Fixing those mistakes does not reveal any
>> > broken tests.
>>
>> I thought at first you meant that the typo was s/expected/expect, and
>> wondered how this could possibly have passed. But the typo is
>> s/sucess/success/, so we were in fact not running the test at all (and
>> were generating "test_expect_sucess: not found" messages to stderr, but
>> outside of any test block. Yikes.
>>
>> Thanks for spotting.
>
> Yeah, I copied a suggestion from Junio in the last iteration without
> properly checking it. Sorry about that and thanks for spotting and
> fixing it.

I probably should stop giving "perhaps along the lines of this"
suggestion too lightly and/or when I do not have enough time to
apply and test myself.  Sorry for the gotcha.
