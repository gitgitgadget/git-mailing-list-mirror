Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C47C2D0DB
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 21:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37B2B20CC7
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 21:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="huFzUGyJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgAaVDf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 16:03:35 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57894 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgAaVDf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 16:03:35 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3E5C6ACE73;
        Fri, 31 Jan 2020 16:03:33 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YfhWCcRnxuFKQjpIRK0UZ16uigY=; b=huFzUG
        yJBL10Mydziy5Um/8ZbgCXNZelCYlntu4kIhTjeS4cP/w8Vz3srMws9eZLCTQ9cm
        a1uxiWWvoFT6B6BNjEkFhkSAWqg6tSIawEEuoBVH5eznIs3xPVeut/cY+p5Y/MN7
        A8293F3bVnqKNO/iMLetP5+Us+ljCr63XJUMM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=l5ElICIGEhdKsWiqC8CHJvNd2j3P3k+g
        xVBlOQxeDRFxJZFxgURzUnyzILgREtxkwvJSFNiPXOIo3CIiME20DDkieLpePFxh
        INL8btnjj0e7Wt1wOM58ydXsmEDNtnqp/jhuiu1y1rUsv6wDHVkAnoLFOzCci2DD
        umjUZs8dWGc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 371FEACE72;
        Fri, 31 Jan 2020 16:03:33 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 662F9ACE71;
        Fri, 31 Jan 2020 16:03:30 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] C: use skip-prefix to avoid hardcoded string length
References: <xmqqv9owa6cw.fsf@gitster-ct.c.googlers.com>
        <20200127232004.GE19360@coredump.intra.peff.net>
        <xmqq36c09zo0.fsf@gitster-ct.c.googlers.com>
        <xmqqa764d9f1.fsf_-_@gitster-ct.c.googlers.com>
        <CACayv=hcH=dvfup2fzm5-OKYxEyC1m7YBTfpm=6z0BhO=hK-cQ@mail.gmail.com>
Date:   Fri, 31 Jan 2020 13:03:28 -0800
In-Reply-To: <CACayv=hcH=dvfup2fzm5-OKYxEyC1m7YBTfpm=6z0BhO=hK-cQ@mail.gmail.com>
        (Andrei Rybak's message of "Fri, 31 Jan 2020 21:15:14 +0100")
Message-ID: <xmqq36bv9w4f.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2236A0BE-446D-11EA-887A-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andrei Rybak <rybak.a.v@gmail.com> writes:

> On 1/30/20 8:35 PM, Junio C Hamano wrote:
>> We often skip an optional prefix in a string with a hardcoded
>> constant, e.g.
>>
>>       if (starts_with(string, "prefix"))
>>               string += 6;
>>
>> which is less error prone when written
>>
>>       skip_prefix(string, "prefix", &string);
>
> Should the subject line say "skip_prefix" with an underscore instead of
> "skip-prefix" with a dash?

Perhaps.  Or "skip_prefix()" to clarify that we are talking about a
function.
