Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F24371F97E
	for <e@80x24.org>; Mon, 26 Nov 2018 03:14:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbeKZOGo (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Nov 2018 09:06:44 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60640 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbeKZOGo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Nov 2018 09:06:44 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E50731117D6;
        Sun, 25 Nov 2018 22:13:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7ZPdfwbAKwwK4frw979xshre8r0=; b=GxOheh
        NJbnqf7Q9n18UqMiZ+cPZtlTghepINAfXsWjAZEC5Km6u3VCmYskveRX5a3oVwZJ
        amrq99+M7JdEoftPaEufEIUOL4FBE9t+rOcHohU1/rW8R6WLTX8Wkzr1lOZAkoEs
        FnnL9+RQvUOuu00751f8+2s36d8N7C5Dde2ps=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XwiBSTQsZxljzJ7egConLfSy+TIjj/7+
        rrW6qmHEDizMaW2RMLIWRi0+CQNB14Mq+He6lUh9Zim14vYgzkiAFsWmhnbMjWir
        z6R6YMoPvHiGhG7xBS7q5n1czxnrr4wHWuwvhc3OLrxAZjZ06bwKuE9hto2OxxeG
        aVJ3/LqOk04=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DDB8D1117D5;
        Sun, 25 Nov 2018 22:13:57 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 510AB1117D4;
        Sun, 25 Nov 2018 22:13:57 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Anders Waldenborg <anders@0x63.nu>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/5] pretty: allow showing specific trailers
References: <20181104152232.20671-1-anders@0x63.nu>
        <20181118114427.1397-1-anders@0x63.nu>
        <20181118114427.1397-3-anders@0x63.nu>
        <xmqqy39o9tmq.fsf@gitster-ct.c.googlers.com> <87a7lw7oct.fsf@0x63.nu>
Date:   Mon, 26 Nov 2018 12:13:56 +0900
In-Reply-To: <87a7lw7oct.fsf@0x63.nu> (Anders Waldenborg's message of "Mon, 26
        Nov 2018 00:02:10 +0100")
Message-ID: <xmqqva4kzg23.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5007C768-F129-11E8-B13F-063AD72159A7-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Anders Waldenborg <anders@0x63.nu> writes:

> Junio C Hamano writes:
>> Also, use of 'key=' automatically turns on 'only' as described, and
>> I tend to agree that it would a convenient default mode (i.e. when
>> picking certain trailers only with this mechanism, it is likely that
>> the user is willing to use %(subject) etc. to fill in what was lost
>> by the implicit use of 'only'), but at the same time, it makes me
>> wonder if we need to have a way to countermand an 'only' (or
>> 'unfold' for that matter) that was given earlier, e.g.
>>
>> 	%(trailers:key=signed-off-by,only=no)
>>
>> Thanks.
>
> I'm not sure what that would mean. The non-trailer lines in the trailer
> block doesn't match the key.

I was confused by the "only" stuff.

When you give a key (or two), they cannot possibly name non-trailer
lines, so while it may be possible to ask "oh, by the way, I also
want non-trailer lines in addition to signed-off-by and cc lines",
the value of being able to make such a request is dubious.

The value is dubious, but logically it makes it more consistent with
the current %(trailers) that lack 'only', which is "oh by the way, I
also want non-trailer lines in addition to the trailers with
keyword", to allow a way to countermand the 'only' you flip on by
default when keywords are given.
