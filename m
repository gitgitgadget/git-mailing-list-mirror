Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 444AE1FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 22:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755808AbcHWW0R (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 18:26:17 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52019 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753868AbcHWW0Q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 18:26:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 963BB371C9;
        Tue, 23 Aug 2016 18:26:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nOVAZ586PDoj+9m2oxE67ZT87vU=; b=PAEbvT
        AFRF+U/6i6AquUQgfzpUvubUO2j+DCNa9xz6f+nk8bV+w+KFx0woI2qdMRDGBFZv
        kZOlfymyd12owc4eyFnufEhfxOYp4gPMCrj63pJIZ0HKzZorfW8LAOrgTOsFq8FV
        uzFfUH2XyL3TRmt1nB6/R9C6YPONMOOJP0qbc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yPoNutUfDtNIeYFwPWN59sG0SbsPipeT
        EghAPfPHw+0GPMrJzyKnUtQX1toB4SD7qtutYX+oLLHeUiasQSpAC7d/2BSTzJIJ
        WnQksEuUkl4zN9KY19o6O1rRdo3YmGCDkjGRrsmBTCwRNZrUyXe7YsKILq4VOyJl
        1oXOnEBIWb0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8F34C371C8;
        Tue, 23 Aug 2016 18:26:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 18972371C7;
        Tue, 23 Aug 2016 18:26:15 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 6/7] delta_base_cache: use hashmap.h
References: <20160822215725.qdikfcaz3smhulau@sigill.intra.peff.net>
        <20160822220007.lh3wzv6orlupfjmr@sigill.intra.peff.net>
Date:   Tue, 23 Aug 2016 15:26:13 -0700
In-Reply-To: <20160822220007.lh3wzv6orlupfjmr@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 22 Aug 2016 18:00:07 -0400")
Message-ID: <xmqqoa4jt94q.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9A8E2D6E-6980-11E6-8122-FCB17B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So while the value for that case _isn't_ as good as the
> optimal one measured above (which was 2048 entries), given
> the bouncing I'm hesitant to suggest that 2048 is any kind
> of optimum (not even for linux.git, let alone as a general
> rule). The generic hashmap has the appeal that it drops the
> number of tweakable numbers by one, which means we can focus
> on tuning other elements, like the LRU strategy or the
> core.deltaBaseCacheLimit setting.
>
> And indeed, if we bump the cache limit to 1G (which is
> probably silly for general use, but maybe something people
> with big workstations would want to do), the linux.git log-S
> time drops to 3m32s. That's something you really _can't_ do
> easily with the static hash table, because the number of
> entries needs to grow in proportion to the memory limit (so
> 2048 is almost certainly not going to be the right value
> there).
>
> This patch takes that direction, and drops the static hash
> table entirely in favor of using the hashmap.h API.

Sounds very sensible.
