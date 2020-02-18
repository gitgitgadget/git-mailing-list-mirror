Return-Path: <SRS0=PlGQ=4G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A81C34031
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 21:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAB0D21D56
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 21:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ELtBvlLD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgBRVT4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Feb 2020 16:19:56 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51578 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgBRVTz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Feb 2020 16:19:55 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EAE435D0B8;
        Tue, 18 Feb 2020 16:19:53 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zh0jCYn0RD51jMFQtBSRIw4iu2w=; b=ELtBvl
        LDslkTLg4ORdiHgUrMG8aBwGRxa1DCwkfglbmu9IERTjLMK2zvLoml9Xz7dKwIwa
        TQcTTvzfYRNN9MO+50UtoMwMvUmJGKVDUFE5Zr7p2vGsWWxR2ePejCy2+Y2JDH7x
        AiGhWxaWyTKZSmWLWT8H69TaqFrOFSxhSjL+w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LwOKgLoj/OK27F1bLUE2Yqv78Mvi+U5O
        oq5U1NokSU1+8VJsH4aKE9WWCirzriUkH3QwYyL8iBN50Cc0VRJ5lXE/tsNXfujL
        gO3J5+PeOYgI+mjAmW7OHyXKA3YvKMsKQXI91WV+19G7LHde4xZYBFEF8kD1Cn2p
        YFLy+9r/Jas=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E2FA05D0B7;
        Tue, 18 Feb 2020 16:19:53 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 516A55D0B6;
        Tue, 18 Feb 2020 16:19:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 06/15] rev-list: make --count work with --objects
References: <20200214182147.GA654525@coredump.intra.peff.net>
        <20200214182220.GF150965@coredump.intra.peff.net>
        <20200215004216.GA15192@syl.local>
        <20200215064818.GB1633703@coredump.intra.peff.net>
        <xmqqwo8mm7ii.fsf@gitster-ct.c.googlers.com>
        <20200218052438.GB1641086@coredump.intra.peff.net>
        <xmqqsgj7kdog.fsf@gitster-ct.c.googlers.com>
        <20200218195531.GA21774@coredump.intra.peff.net>
Date:   Tue, 18 Feb 2020 13:19:51 -0800
In-Reply-To: <20200218195531.GA21774@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 18 Feb 2020 14:55:31 -0500")
Message-ID: <xmqqpnebioeg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6782F516-5294-11EA-BD95-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Feb 18, 2020 at 09:28:31AM -0800, Junio C Hamano wrote:
>
>> >> I think the question reader had was "why *right*?"
>> >
>> > Ah. The answer is: because it's not SYMMETRIC_LEFT. ;)
>> >
>> > The counting code accumulates there by default when there are no side
>> > markings, so that's what it will report when there's no left_right or
>> > cherry_mark (which we know will be the case here, since we die()
>> > otherwise).
>> 
>> Yup.
>> 
>> 	/*
>> 	 * The object count is always accumulated in the .count_right
>> 	 * field for traversal that is not a left-right traversal,
>> 	 * and cmd_rev_list() made sure that a .count request that
>> 	 * wants to count non-commit objects, which is handled by
>> 	 * the show_object() callback, does not ask for .left_right.
>> 	 */
>> 
>> Overkill?  I dunno.
>
> No, I think it looks good. Want to squash that in (and I'll do likewise
> locally)?

It's too late for squashing anything in, as they are in 'next'
already.

