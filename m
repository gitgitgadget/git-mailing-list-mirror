Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01552208B8
	for <e@80x24.org>; Tue, 15 Aug 2017 17:13:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753321AbdHORNZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 13:13:25 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60715 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752647AbdHORNY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 13:13:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4AEB3A260E;
        Tue, 15 Aug 2017 13:13:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FQd+4lekMYzwFvL1H7g7PKRzpaQ=; b=G/iilO
        JhtR1p+37/soxxnphKx24Jcnj58tAVkhmnGb1H8opGPKldz40NP4fDrfTiK+LOy/
        tU+oiqnqyV7BABAgi6eoetciqIzueWjwS5RHtZthGXB4w/M06ryFmqH78xWPtEg0
        L9gXHbE+REI0WbJGXWmtp4PHUMYo2PcXyy7ro=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=I28FYZ3h0lNzPcHxVl9YsFR2kI5zjOKq
        JsThCKnO+9MtFeut5FpM2FPhmcbf7Ny+SW6idEa/Jcr5KL4hL+6yzQYsnslLJpy/
        pBPLdYYxzYGh7FVyzEHb8iJGnYwC8fngqXVX0Ny3D+MUw1bN1Q2YvOmVD4Fn4YFs
        200cmoLNcd4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 42D01A260D;
        Tue, 15 Aug 2017 13:13:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A75EEA260C;
        Tue, 15 Aug 2017 13:13:23 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Richard Maw <richard.maw@gmail.com>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [RFC PATCH 0/7] Implement ref namespaces as a ref storage backend
References: <20170813193611.4233-1-richard.maw@gmail.com>
Date:   Tue, 15 Aug 2017 10:13:22 -0700
In-Reply-To: <20170813193611.4233-1-richard.maw@gmail.com> (Richard Maw's
        message of "Sun, 13 Aug 2017 20:36:04 +0100")
Message-ID: <xmqqefscsqj1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0B64F5AC-81DD-11E7-9C50-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Richard Maw <richard.maw@gmail.com> writes:

> This is not my first attempt to improve the git namespace handling in git.
> I tried last year, but it took me so long that all the ref handling code changed
> and I would have had to start from scratch.
>
> Fortunately the pluggable ref backends work provided an easier starting point.

Yeah, I also made an ultra-brief foray into ref backends a few weeks
ago, and found that Michael did an excellent job identifying the
building blocks backends may want to implement differently and
abstracting out major parts of the ref processing.  I also hit some
of the same issues you mention, e.g. "HEAD" and other funny refs.

I do suspect that the current GIT_NAMESPACE thing may have outlived
its usefulness and with the pluggable ref backend thing in place, we
may want to redesign how support for multiple views into the same
repository is done.  I do not have a need for such a thing myself,
but I am glad somebody is looking into it ;-)

