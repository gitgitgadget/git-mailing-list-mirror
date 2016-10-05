Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C20321F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 19:35:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755067AbcJETfj (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 15:35:39 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63015 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755053AbcJETfh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 15:35:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2C1BA44F1D;
        Wed,  5 Oct 2016 15:35:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UEghV4xBwuP1+P/vPE6Q2ggycmc=; b=TVsbdX
        mcYmBURFUigD90ZF/ZGwuWzCy0smTyV8FWj2oqKMGTrIm8e/mo5c9OTs10+i/Cq3
        1GyQ98yzmvkmEdc7iyYDTlNtxXme9Wsr+PX3OmFQy7lDvSptoJYQLHUL2CuTTaDT
        f1zDBIwrACZyuIbLfFMHAX+6tn+P1Dlb6f/X8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kSi4QzuQ/8ppyCjjAIoeUP3DLOuRDsmO
        +NpXG298tc2cJsT9S8f27cj4HJaxX4s7CIpSI31CnYzfzkYnHeSHLzUcqh+GTmyd
        2pnzFjzKxE+jR240wfjR7ju+oiT1rFzrmAlRwI17uQDdfAZX3Yv7zOVHbJKU0Gro
        Ejulit+VCS0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1884844F1C;
        Wed,  5 Oct 2016 15:35:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8459544F19;
        Wed,  5 Oct 2016 15:35:35 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git mailing list <git@vger.kernel.org>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 13/18] fill_sha1_file: write "boring" characters
References: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
        <20161003203555.6xadycotmmkuf34h@sigill.intra.peff.net>
        <CA+P7+xpOxoRBDZGF_CU1Q-SYiQZtMx2vuwQKS0og864awZod5g@mail.gmail.com>
        <xmqqbmyzss6z.fsf@gitster.mtv.corp.google.com>
        <CA+P7+xrBX684an5EzUUk+_Dtu6Ep_F+nB1JyWDWsZjUANWcFoA@mail.gmail.com>
Date:   Wed, 05 Oct 2016 12:35:33 -0700
In-Reply-To: <CA+P7+xrBX684an5EzUUk+_Dtu6Ep_F+nB1JyWDWsZjUANWcFoA@mail.gmail.com>
        (Jacob Keller's message of "Tue, 4 Oct 2016 14:49:10 -0700")
Message-ID: <xmqqvax6oagq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E31A6844-8B32-11E6-923C-F99D12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

>> The cost of fill function having to do the same thing repeatedly is
>> negligible, so I am OK with the result, but for fairness, this was
>> not "make the callers do this extra thing", but was "the caller can
>> prepare these unchanging parts just once, and the fill function that
>> is repeatedly run does not have to."
>
> Sure, but it's a pretty minor optimization and I think the result is
> easier to understand.

Yes; in case it wasn't clear, my comment was merely for fairness to
the original code.  I do agree that the end result of this series
makes a very pleasant read.
