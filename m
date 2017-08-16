Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B2211F667
	for <e@80x24.org>; Wed, 16 Aug 2017 21:57:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752346AbdHPV5b (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 17:57:31 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55003 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752262AbdHPV5a (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2017 17:57:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F2DB58D14D;
        Wed, 16 Aug 2017 17:57:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IyZHnu/Nrs3KVrPvhaUKWTS0aic=; b=bf3f3o
        Rbd7GX3kAYq9IFxcLHTPGTx2deTaZCX2I6GA0pUZsJw06g9Q7N4Ld3oc9Xs/jZlR
        0wkGnHdBanX46De+/XkPLsXzRgJCcYRba/3JkpZNoVEk5CmDCTrPWYTPymQ076Ai
        BM8xCzjyn71EMHXm2XJVxqT4lbmvcl1R2+Mj4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=U6p5n67+rts31KIQ33oxTLSaJqUbsgTv
        4K6Oh/KziWagsMsqKE2L7NF0G6nfvp5wvO5BwUUgNJbqgwYiqPpBpHrhGdOviJFf
        VcYuJSdJ30dWVXVGzAhCU1GmR5LtGfFKBWqdSDJ1rvkqwyFeOjCKgPxgap2C5ILU
        dmpPRbpvqIo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E9DE88D14C;
        Wed, 16 Aug 2017 17:57:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5EA518D14B;
        Wed, 16 Aug 2017 17:57:22 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andreas Heiduk <asheiduk@gmail.com>
Cc:     ryenus <ryenus@gmail.com>, Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] fix revisions doc about quoting for ':/' notation
References: <CAKkAvazj28RR1nHEWNNeZeyE6mpkb3opk6kvrxP6Lau6tcCbJQ@mail.gmail.com>
        <956ccc83-c291-4217-795c-fcef33fac35b@gmail.com>
Date:   Wed, 16 Aug 2017 14:57:21 -0700
In-Reply-To: <956ccc83-c291-4217-795c-fcef33fac35b@gmail.com> (Andreas
        Heiduk's message of "Wed, 16 Aug 2017 23:15:47 +0200")
Message-ID: <xmqqo9rfi3b2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E1A9F6BC-82CD-11E7-8888-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andreas Heiduk <asheiduk@gmail.com> writes:

> Am 16.08.2017 um 05:21 schrieb ryenus:
>> To make sure the `<text>` in `:/<text>` is seen as one search string,
>> one should quote/escape `<text>` properly.
>> 
>> Especially, the example given in the manual `:/fix nasty bug` does not
>> work because of missing quotes. The examples are now corrected, and a
>> note about quoting/escaping is added as well.
>
> Right now the documentation describes the syntax as git sees the
> parameters. This is agnostic of the shell or other UI with their
> different quoting rules.  For example users of fish must quote
> `rev@{2}`. A GUI might require no quoting at all. In that case `:/"fix
> nasty bugs"` would be given to git verbatim and hence not find the revision.

These are all good points that I didn't consider when responding.

> Also: Other examples like `HEAD@{5 minutes ago}` need the same quoting.
>
> So my suggestion is to not use quoting in the examples and provide only
> a hint in the text. Example:
>
>  <rev>{caret}{/<text>}', e.g. 'HEAD^{/fix nasty bug}'::
>     A suffix '{caret}' to a revision parameter, followed by a brace
>     pair that contains a text led by a slash,
>     is the same as the ':/fix nasty bug' syntax below except that
>     it returns the youngest matching commit which is reachable from
>     the '<rev>' before '{caret}'.
> +   Depending on the given text the shell's word splitting rules
> +   might require additional quoting.

That sounds like a very safe change to adopt, regardless of what we
decide to do to the other part of the proposed change.

Thanks.
