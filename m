Return-Path: <SRS0=eTRQ=EM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43676C2D0A3
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 21:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8B8F20735
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 21:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uQ25vSxi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbgKFVnj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Nov 2020 16:43:39 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59009 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728193AbgKFVnj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Nov 2020 16:43:39 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BE9E4EB79D;
        Fri,  6 Nov 2020 16:43:37 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WpiQnikALimwwQ2SU3iQGXAjJSk=; b=uQ25vS
        xiYKyZ2UjjYQEgi+FwTNsJmb83oJf2+1Y5tjQiiLRu+8ADvuoQTNu8Yey6hZ5OiZ
        dRK/pqV/gnhp0iCi9u28PdYbIfqUi1qwTb+Kcz+L5cTbpdW1+w6sGVQz3zhyHEWO
        rtEiHfFTgMdu+n2HLUGkBADb4h3ShBCpTfcMk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ps83A3qxgbFuWP21G1bVhkT9Dz8pJa/T
        T7OMy0h2pgbJ18PgQWm/HxP3jplBs8jqMC5jo2kLgw5GdHI0l4C5CEFeInb61KDM
        yN1GZ51AJ4yTjgRruO480cY6hIglF2BalQJdt1C34ud/56T5GFxg7/6HSXy/d0J8
        i3IlwaP1uZA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B77B1EB79C;
        Fri,  6 Nov 2020 16:43:37 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 018E1EB79A;
        Fri,  6 Nov 2020 16:43:34 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Jeff King <peff@peff.net>, GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH 2/8] Documentation/Makefile: conditionally include
 ../GIT-VERSION-FILE
References: <32b7e1dc-8cc3-2236-08b8-4d268bbf8c0b@ramsayjones.plus.com>
        <20201106181804.GA183267@coredump.intra.peff.net>
        <a654c95f-2367-5805-d4f8-56c466a141d4@ramsayjones.plus.com>
Date:   Fri, 06 Nov 2020 13:43:33 -0800
In-Reply-To: <a654c95f-2367-5805-d4f8-56c466a141d4@ramsayjones.plus.com>
        (Ramsay Jones's message of "Fri, 6 Nov 2020 19:38:06 +0000")
Message-ID: <xmqqsg9mduuy.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1F1F366E-2079-11EB-B701-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

>>     It's built around evals. In fact, I suspect you could build a
>>     function around eval that actually works similar to include, but
>>     lazy-loads the file only when one of its stubs is referenced. I.e.,
>>     something like:
>> 
>>       GIT_VERSION = $(eval include GIT-VERSION-FILE)
>> 
>>     would probably work (and for other includes, multiple variables
>>     could mention the same file; as soon as it gets included, it
>>     overwrites the stubs).
>> 
>
> Heh, in another reply in this thread, I mentioned that I had an alternate
> patch I was toying with.

Yup, I was wondering if you're going to present that variant, which
I was more curious about.

