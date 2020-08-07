Return-Path: <SRS0=eX0j=BR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F2D9C433E0
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 20:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08C082075A
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 20:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qhQcKBy0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbgHGUSx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Aug 2020 16:18:53 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61123 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgHGUSx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Aug 2020 16:18:53 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 90100F68A2;
        Fri,  7 Aug 2020 16:18:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=22Q9YRv0lw63StNftWAJsA96NVM=; b=qhQcKB
        y0FQf900V3z9Ed4Tt2J3Tv6Fkr37ta6yQRmcu5UDmv0NRraVYeMQqXcKWF30FyQz
        8znNwZxeRgTh1iTlBMujhf30mnVn6L9uPHR1FqTPlb2nFy528GBo3Ib2tqrU70UR
        7QokQTg850J94vWnUBRz/CGaq9aiwBj70JZuQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qUMC1ymFIKh0MNcH11QY01zb0YSRV5TN
        JHYlcR1VVtERWJCuvaVaCauu8ThIxoolFzd4LAzQ37Iq1WL3rm+bON+XyzEBAr7R
        eI1uoa9UeegaTLKXmEMQdabrz+EVFWtBUwb1UTjd2gE261xYScM1J13aoqYSaHZW
        dA0mRcM2KU0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 88D20F68A1;
        Fri,  7 Aug 2020 16:18:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D04C6F68A0;
        Fri,  7 Aug 2020 16:18:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH] sideband: mark "remote error:" prefix for translation
References: <20200805084240.GA1802257@coredump.intra.peff.net>
        <20200805090641.GR2898@szeder.dev>
        <20200805092658.GA1803042@coredump.intra.peff.net>
        <xmqqwo2dnjk5.fsf@gitster.c.googlers.com>
        <20200807085649.GA34210@coredump.intra.peff.net>
Date:   Fri, 07 Aug 2020 13:18:47 -0700
In-Reply-To: <20200807085649.GA34210@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 7 Aug 2020 04:56:49 -0400")
Message-ID: <xmqq4kpegqfs.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 33F2C34C-D8EB-11EA-888F-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Aug 05, 2020 at 09:28:42AM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > By the way, grepping for "remote error:" shows that when we get an error
>> > over sideband 3 we produce the same message but _don't_ translate it.
>> > That seems inconsistent.
>> 
>> IOW
>> 
>>     die(_("remote error: %s"), buf + 1);
>> 
>> in sideband.c?  I think it makes sense.
>
> Yes. Patch is below so we don't forget about it. I'm not sure if we
> ought to be going further, though. The "remote:" prefix for sideband 2
> isn't translated either. It would be easy to do so, but it's much more
> lego-like. We don't have "remote: %s" ever as a string. We just have
> "remote:", and then we maybe_colorize_sideband() the result.
>
> Would that be annoying for translators, especially with RTL languages?
> Do people actually want to see "remote:" (or "remote error:" for that
> matter) translated, or does mixing translated and untranslated messages
> on one line end up more confusing? I'm out of my element here, as I
> wouldn't ever use the translations myself.
>
>> IIRC, the current thinking is to let the remote side localize their
>> message before sending them over the wire and we'll worry about how
>> we let the receiving end tell what l10n it wants later.  So "remote
>> error:" prefix may have to be translated on receiving end and the
>> remainder of the line, which is already localized, can just be
>> interpolated.
>
> Yeah, that part makes sense. The local client shouldn't be translating
> what it gets from the server (and won't, because it is filled in via the
> %s). Adding a capability for preferred language would be easy, though I
> imagine it might be irritating in practice.  As a server admin, I want
> to see everything in the C locale; but what gets shown to users and what
> might get dumped into server logs is not well specified in Git. I have a
> feeling that just setting LANG based on the user's request would be a
> bit broad.
>
> Anyway, here's the patch. It doesn't seem to cause any test failures,
> even with GETTEXT_POISON. :)

;-)  Thanks.  Queued.
