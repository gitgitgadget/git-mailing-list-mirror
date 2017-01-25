Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E80331F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 19:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752380AbdAYTAq (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 14:00:46 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59364 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752299AbdAYTAp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 14:00:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 92A6F6320C;
        Wed, 25 Jan 2017 14:00:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XdvLlqxaxyzg9LT1h96XR4/6XXk=; b=sl0iN9
        FfRRtmtRABfQmDwEnTQ5RnpXfZdxk2lTYv6UhcgQGo865WCJ7H/s8j/mhflwf0ot
        tJOz4s6KLyFLmEHm9fca1EJIudMjFdturJp6A+zlSWXpgbY9HeZedLJbhsvk4Sq4
        aud2eGwvOosMS4JM1PkhsECLeI+guHxrfPLLA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wRqAJhw/jor0zGyc3nnx5C5vzfr8DdeE
        6CLveaH5U+2Bg9vUBsX+iwof8VZn9/XcY/I+n8l5H/isL1OYyKUVApc/7dqseYJK
        zcNvUWaAipF8t44NFo8W7OjSEr2Ng+y4NPsDo+wM23YKT8lS2OoL+eMnvV02hgf0
        mJcopIQsxVQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 89AE96320B;
        Wed, 25 Jan 2017 14:00:44 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E72CA6320A;
        Wed, 25 Jan 2017 14:00:43 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 05/12] for_each_alternate_ref: replace transport code with for-each-ref
References: <20170124003729.j4ygjcgypdq7hceg@sigill.intra.peff.net>
        <20170124004409.py4eggvrtrej2bgi@sigill.intra.peff.net>
Date:   Wed, 25 Jan 2017 11:00:42 -0800
In-Reply-To: <20170124004409.py4eggvrtrej2bgi@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 23 Jan 2017 19:44:09 -0500")
Message-ID: <xmqqr33rars5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 92A5D5AA-E330-11E6-AED9-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> ...
> This patch omits the peeled information from
> for_each_alternate_ref entirely, and leaves it up to the
> caller whether they want to dig up the information.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I also tried adding "%(*objectname)" to for-each-ref to just
> grab the peeled information, but the peel implementation in
> ref-filter is _really_ slow. It doesn't use the packed-ref
> peel information, and it doesn't recognize duplicates (so in
> the 80 million case, it really parses 80 million tags).

That's an interesting tangent that may want to be looked into.

>  transport.c | 48 ++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 38 insertions(+), 10 deletions(-)

The updated code is a more pleasant read.

