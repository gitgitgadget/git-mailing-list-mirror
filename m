Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC40C71155
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 20:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C05021741
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 20:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IhdxrcpM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730567AbgLAUdz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 15:33:55 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63792 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbgLAUdy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 15:33:54 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E4E45114B76;
        Tue,  1 Dec 2020 15:33:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=oQ1Soup2vLJr
        5jcbdc1QbHH12Xg=; b=IhdxrcpM3Ak8SD1UodQNQdkgYml3qJjKYlCNJ15AIn4C
        zgEx08x5i00hjmX3VY5cHS9o8XDzoy2djzSLUV0EWNndRCwp2xtg6oylMTJoH7Bf
        Ja6yUIyG7gifrsHrDALALuqZP0TYOUlpFPmemOnv4jS0QUbrSAvB0J2gsYdTEQE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ha0DNE
        IDfBwLFw8eGcE9rUfL+5e112B7jDMEupU241z+6ubumf1gry78Vuraq8FLZYpzyf
        8LnadylUAGqrOqBENPJDg8yLyvIEtnhOaoZArpr5CRWUf0ZIs4xQ7/E40ynY4cHf
        SFQI0XCtsS8M5Z7dI20fWTZvpeQ+DscH0AZsY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DCED0114B75;
        Tue,  1 Dec 2020 15:33:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 274FA114B74;
        Tue,  1 Dec 2020 15:33:10 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 08/10] fsck: add new "extra" checks for "mktag"
References: <20201126012854.399-1-avarab@gmail.com>
        <20201126222257.5629-9-avarab@gmail.com>
Date:   Tue, 01 Dec 2020 12:33:08 -0800
In-Reply-To: <20201126222257.5629-9-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 26 Nov 2020 23:22:55 +0100")
Message-ID: <xmqqo8jdnu63.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6D3EA1FA-3414-11EB-A7F8-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Add optional "extra" checks to fsck, these are needed to eventually
> replace the custom not-quite-fsck code in mktag.c.
>
> The mktag checks differ from fsck_tag() in several ways, one of those
> is that fsck doesn't know how to refuse an object with custom headers,
> and isn't strict about header and body newline separation.

You say "there must be only one blank line between the header and
the body", but viewing from the way we parse header and body, I
think that such a rule actually forbids a leading blank line in the
body and steps into checking whitespace errors---makes readers
wonder if we should be also detecting trailing whitespaces on lines,
etc.

Is there actually such a check enforced in the original?  Or is this
a new rule that appeared out of thin air?  We'd have to inspect the
lines deleted from builtin/mktag.c in the next step, I gues.

> By adding an "extra" category and only reporting it based on a flag in
> fsck_options callers can opt-in to these "extra" messages, which
> they'll then need to deal with in their own "error_func".

Makes sense.

