Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7D531F4F8
	for <e@80x24.org>; Tue, 11 Oct 2016 21:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754008AbcJKV0y (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 17:26:54 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58844 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752995AbcJKV0x (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 17:26:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 643E543D7E;
        Tue, 11 Oct 2016 17:26:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gW1nlZQ9++bbabEI7hvOpI2phQc=; b=rpV8bd
        RWRavhFJmJaz7vOv2XmS9y/p1fLTSlE/emK5n6UMmAU9pgPqIu9HTGGG/Ze6Awcp
        pHkgHQep1U2uD9bqNfAef4VEsQshcvsT4r3RzAqw+Eot89c2BmlBWMyZvZZqnAu1
        wuygN/T+5QOqNoJpVCYnrLBJCjjLjxdarHgIE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iObXuPzOK4eAhSt8BP9awGcUV9F3OHgb
        E9qKoO5NR+zR0J1fHekZYpj1C8tL9BkfQcHy0Zfoth1xIRClLZ5akOQ9Hqguhdpd
        h7MV/NXhVLF0Ai/bFPvPtbY4afcr9P2NWz1Ny1bVPahz9o4zV9iblpQYdPxBdyke
        z8oaeWZ/m1g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5A43543D7D;
        Tue, 11 Oct 2016 17:26:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B08AE43D7C;
        Tue, 11 Oct 2016 17:26:32 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] upload-pack: use priority queue in reachable() check
References: <20161011212016.hnw4dl473puhyax7@sigill.intra.peff.net>
Date:   Tue, 11 Oct 2016 14:26:30 -0700
In-Reply-To: <20161011212016.hnw4dl473puhyax7@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 11 Oct 2016 17:20:16 -0400")
Message-ID: <xmqqshs27f21.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 618913F4-8FF9-11E6-9DE8-5F377B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Like a lot of old commit-traversal code, this keeps a
> commit_list in commit-date order, and and inserts parents
> into the list. This means each insertion is potentially
> linear, and the whole thing is quadratic (though the exact
> runtime depends on the relationship between the commit dates
> and the parent topology).
>
> These days we have a priority queue, which can do the same
> thing with a much better worst-case time.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> This was inspired by a real-world case where several instances of
> upload-pack were chewing minutes of CPU, and backtraces in each instance
> pointed to this function.  Unfortunately, I only saw the server side of
> these requests. I pulled the contents of have_obj and want_obj out of
> the process via gdb, but I wasn't able to reproduce the slow fetch.
>
> So I'm not 100% sure that this fixes it, but the problem hasn't happened
> again. And it certainly seems like it couldn't _hurt_ to optimize this.

This does look good and looks like a quite straight-forward change.

Will queue; thanks.
