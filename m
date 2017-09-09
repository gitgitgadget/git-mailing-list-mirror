Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60D351FAD6
	for <e@80x24.org>; Sat,  9 Sep 2017 03:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757309AbdIIDWM (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Sep 2017 23:22:12 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61001 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753201AbdIIDWL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2017 23:22:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A2E1C9C4CF;
        Fri,  8 Sep 2017 23:22:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SdMkm9uB4HFnr69uALaGIsyHk+E=; b=x7614z
        8cMl7Ekj4Grxw5/YBVOPwGxvOnRj6HLuPU+/NRxKpW9s1T16fB16//qUF74VgEvM
        kpM46/G+fDWfF4xjdDWhR/b/mgxy0AJ3LKZO1z6F7z/P6RMpuRysL+03BCXpda0Y
        npPlWssAHScywyzUILqPQF+/yGepd1KDPrLbQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hNyluBkiuiIVefJdXGA7krVJoJl0IbpY
        3UY4ThFM6RO3bgh/gGsQOXDRdfa9h1HYMr6MIW1ENg+/bASgP5A6cG2BbF60V+qP
        sce4GYYjv3me5dsOvYUU67wF1/RKQ3V/+DYBL3b1qvuHa6UK9U69J19lq/sUmI/X
        9tHitNGao4k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 99B2D9C4CE;
        Fri,  8 Sep 2017 23:22:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0501C9C4CD;
        Fri,  8 Sep 2017 23:22:09 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ross Kabus <rkabus@aerotech.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] commit-tree: don't append a newline with -F
References: <20170907144111.7488-1-rkabus@aerotech.com>
        <xmqqa8260y7g.fsf@gitster.mtv.corp.google.com>
        <CAEVs+zYrKxX0S9LMoBLB3vqG5n3PuMGMCehipbpCmFA7dW95qw@mail.gmail.com>
Date:   Sat, 09 Sep 2017 12:22:08 +0900
In-Reply-To: <CAEVs+zYrKxX0S9LMoBLB3vqG5n3PuMGMCehipbpCmFA7dW95qw@mail.gmail.com>
        (Ross Kabus's message of "Fri, 8 Sep 2017 18:06:00 -0400")
Message-ID: <xmqqmv64y2sf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 10B3AA8C-950E-11E7-A9DC-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ross Kabus <rkabus@aerotech.com> writes:

> On Thu, Sep 7, 2017 at 9:35 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>     commit-tree: do not complete line in -F input
>>
>>     "git commit-tree -F <file>", unlike "cat <file> | git
>>     commit-tree" (i.e. feeding the same contents from the standard
>>     input), added a missing final newline when the input ended in an
>>     incomplete line.
>>
>>     Correct this inconsistency by leaving the incomplete line as-is,
>>     as erring on the side of not touching the input is preferrable
>>     and expected for a plumbing command like "commit-tree".
>
> That all makes sense to me and is clearer too, I like this change.
> Do I need to resubmit the patch or will you just use that text instead?

Unless the change is in the middle of a large series or require more
involved edit [*1*], it is perfectly fine to tell me the maintainer
to do these small menial changes on behalf of you---you explicitly
need to tell me what you want to happen, though.

Thanks.

[Footnote]

*1* ... in which case we have a larger chance of the maintainer
    screwing up while attempting to do so, and I'd prefer to see an
    updated version posted on the list.  That way, we can benefit
    from extra set of eyeballs watching our exchange from the
    sideline.

