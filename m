Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23503C433E0
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 19:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D342620756
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 19:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZEdEAlwv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbgHKTGE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 15:06:04 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50919 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbgHKTGE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 15:06:04 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C9C18F286F;
        Tue, 11 Aug 2020 15:06:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=sG7yWM9dFpSa
        SHRMdyNjss6Dl1A=; b=ZEdEAlwvJynzwQ+7xiRnBpgG9lswVoGZ5jeS5N6DNH9K
        CoZlIO2kgXzMRSX6u1tuXHgJRraTVGqb2uzj1Yog8FgtqqJnIjBmNedJz1aGbRWd
        tS/3OfiAxs9cwI5GFD0bfMs1/zcxfVOvl+arJmhr9/0qIXECg2M8S5SnGKFT9Lc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=wvuKDx
        t6g8JAuX5jQVf3UHCJxWo1AayKCMzalyyAIhkYK4oOg4+MoqAeIAlLJYgK82U/ZV
        lR17UHUEYWgMKMZkOwMCwU7V2X00nto4gFL5BKQSLZOIVyfhTNNm+ImpY3oBzbtN
        an4xygqzRM+pzdF0I4GwPCdT+Oss3A4ZETeUw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C1BFCF286E;
        Tue, 11 Aug 2020 15:06:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 08E4CF286C;
        Tue, 11 Aug 2020 15:05:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Antti =?utf-8?Q?Ker=C3=A4nen?= <antti@keraset.fi>,
        phillip.wood@dunelm.org.uk,
        Antti =?utf-8?Q?Ker=C3=A4nen?= <detegr@rbx.email>,
        git@vger.kernel.org,
        Jussi =?utf-8?Q?Ker=C3=A4nen?= <jussike@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rebase -i: Fix possibly wrong onto hash in todo
References: <20200811131313.3349582-1-detegr@rbx.email>
        <ebdc0bc7-f48e-9f38-328d-b1181ac974d7@gmail.com>
        <20200811153621.GD19871@syl.lan>
        <20200811181537.qt7jkoxy7qn3k7mo@haukka.localdomain>
        <xmqqsgct9fi1.fsf@gitster.c.googlers.com>
        <20200811190139.GB34058@syl.lan>
Date:   Tue, 11 Aug 2020 12:05:58 -0700
In-Reply-To: <20200811190139.GB34058@syl.lan> (Taylor Blau's message of "Tue,
        11 Aug 2020 15:01:39 -0400")
Message-ID: <xmqqft8t9f55.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B195B512-DC05-11EA-895A-843F439F7C89-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Tue, Aug 11, 2020 at 11:58:14AM -0700, Junio C Hamano wrote:
>> Antti Ker=C3=A4nen <antti@keraset.fi> writes:
>>
>> > On Tue, Aug 11, 2020 at 11:36:21AM -0400, Taylor Blau wrote:
>> >> Ack, I noticed this too during my review, but apparently forgot to
>> >> comment on it. I'm puzzled by the first '..*'. If you're searching =
for
>> >> any non-empty string, how about '.+' instead?
>> >
>> > That's true. Good point. I pretty much copy&pasted the 'todo count' =
test
>> > so I didn't give this much thought. I'll fix this.
>>
>> Please don't shorten ..* into .+ if you are writing a portable sed
>> script---stick to the BRE.
>
> Sure, and sorry -- I didn't know that we cared about the difference
> between BRE and ERE. Do you prefer ..* over .\+? Both should be
> supported in BRE, if I'm reading [1] correctly.

I thought that BRE only commands taking backslash-quoted ERE was GNU
extension?

Look for "stick to a subset of BRE" in Documention/CodingGuidelines;
we may need to update the document to raise the baseline to match
the reality of year 2020, though.

