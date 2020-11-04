Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E5E0C2D0A3
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 16:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E0A6206A5
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 16:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Bl2tS9n9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730853AbgKDQ0e (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 11:26:34 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62042 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731175AbgKDQ02 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 11:26:28 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7C9B684EC8;
        Wed,  4 Nov 2020 11:26:25 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dOn91M2+tKYDzv9s0d443WVhvAQ=; b=Bl2tS9
        n9+AlneofnC6GQqrR8AJgWSp4rsRK2r1+3UwthtSfNyzWqT/OttU0E/yTAe6rPTI
        r3cAi57TkyV4fMtR22skW5yBrKq6DJXidQQ557QyBjdyXnbs60zjgDbLoiX/hmay
        paXDuoob/GyQeOmlqANPkjDJzwNZmSnwo87lE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xBOY0JRHSaddRsFK6jqnFIZJPhbmBI+c
        hSsJ+h1U33miwaEQuxOfpNAdVTcydcYy2w8C+/YRtJt3w2382If08f+0rLC06myf
        d5EWwURMplT44DSxghBKIa5FThGUsb4gYyfak3mAuPkedRQHTqkKmL+8zKkBlSp9
        40XX4N5BA4g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7403984EC7;
        Wed,  4 Nov 2020 11:26:25 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F108884EC6;
        Wed,  4 Nov 2020 11:26:24 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Sathyajith Bhat <sathya@sathyasays.com>, git@vger.kernel.org
Subject: Re: Segfault in git when using git logs
References: <CAMsWJsyPVQWV++gc2YJriEOEWBELa_xj2G0NWFMSgNYt47swiQ@mail.gmail.com>
        <20201102144321.GA3962443@coredump.intra.peff.net>
        <20201103101553.GH24813@szeder.dev>
        <20201103182102.GA459792@coredump.intra.peff.net>
        <xmqq361qs31a.fsf@gitster.c.googlers.com>
        <20201103185711.GA461461@coredump.intra.peff.net>
        <xmqqimamqjhl.fsf@gitster.c.googlers.com>
        <20201104133129.GA3030480@coredump.intra.peff.net>
Date:   Wed, 04 Nov 2020 08:26:24 -0800
In-Reply-To: <20201104133129.GA3030480@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 4 Nov 2020 08:31:29 -0500")
Message-ID: <xmqqimalnl5b.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7B858EF0-1EBA-11EB-B1CC-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Nov 03, 2020 at 12:21:42PM -0800, Junio C Hamano wrote:
>
>> >> So something like this won't harm VS Code more than we currently do,
>> >> while telling users what is wrong with their command line?
>> >
>> > Yeah, I was wondering if we'd want the patch you sent, or if we should
>> > turn those die() calls into warning() and disable the flags up front.
>> [...]
>> >> diff --git c/builtin/log.c w/builtin/log.c
>
> Since we now have identified the caller that was passing in the bogus
> options, and it has already been fixed, I'm inclined to say we should go
> with your die() patch from earlier (modulo the pathspec.nr fixup) and
> call it done.
>
> Do you want to roll that up with a commit message?

OK, will try.

