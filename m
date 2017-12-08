Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46F051FC34
	for <e@80x24.org>; Fri,  8 Dec 2017 21:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752208AbdLHVJ0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 16:09:26 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50909 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751474AbdLHVJZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 16:09:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F3F10B0577;
        Fri,  8 Dec 2017 16:09:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=d5DkfY8Ie+r67brWwafEUYPiRLU=; b=mj/wc5
        EFrHcaalIS+v+0GLKZ971X30Wqkj7TSjfXWgWtbrhevqC94HG5PAbyCXoz5iJoOq
        JNZm3OELzvxmM/Bu6ga2qNnWsbq0w3g2ZJv+EEnAWQYshfzIzjGVDNmE9+Aypgh+
        h2AjJxc2nPFR2nHOCvwdpVDh1kwlql8JTJ1GA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=X35/iLvBCWB350iubZAYjIIJSLu/jPod
        rmHJohWkT6E42swMoaXST1eKGHhOSAKFkI5v0jWajIjSBKN+csAatgYWodUFEOG1
        5gFR8GxptvNcKDF9+bsgjtSkBH7W0F4ZTmw0baMIOL0/WKIt7qmLhPmRrCK3Y5Nm
        LXsOIwBxNBY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EA55DB0575;
        Fri,  8 Dec 2017 16:09:24 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 66769B0574;
        Fri,  8 Dec 2017 16:09:24 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        jacob.e.keller@intel.com
Subject: Re: [PATCH v2 5/7] diff: use skip-to-optional-val in parsing --relative
References: <20171207003517.11729-1-jacob.e.keller@intel.com>
        <20171207173034.12865-1-gitster@pobox.com>
        <20171207173034.12865-2-gitster@pobox.com>
        <20171207211102.GA12850@sigill.intra.peff.net>
        <xmqqpo7qb3n8.fsf@gitster.mtv.corp.google.com>
        <20171207222143.GA14845@sigill.intra.peff.net>
        <xmqqlgieb25x.fsf@gitster.mtv.corp.google.com>
        <20171208090531.GC26199@sigill.intra.peff.net>
Date:   Fri, 08 Dec 2017 13:09:23 -0800
In-Reply-To: <20171208090531.GC26199@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 8 Dec 2017 04:05:31 -0500")
Message-ID: <xmqqindh6i64.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 115B07BA-DC5C-11E7-8B28-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Dec 07, 2017 at 02:31:38PM -0800, Junio C Hamano wrote:
>
>> If this goes on top as a standalone patch, then the reason why it is
>> separate from the other users of _default() is not because the way
>> it uses the null return is special, but because it was written by a
>> different author, I would think.
>
> Mostly I was just concerned that we missed a somewhat subtle bug in the
> first conversion, and I think it's worth calling out in the commit
> message why that callsite must be converted in a particular way. Whether
> that happens in a separate commit or squashed, I don't care too much.
>
> But I dunno. Maybe it is obvious now that the correct code is in there.
> ;)

It probably is too obvious to me only because the use case like this
one that wanted to treat --foo and --foo="" differently was the only
reason why I pushed against Christian's original one that hardcoded
the equivalence without allowing what the _default() variant lets us
do, I think.
