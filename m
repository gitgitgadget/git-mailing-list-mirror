Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFE3920133
	for <e@80x24.org>; Mon,  6 Mar 2017 18:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754133AbdCFSsx (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 13:48:53 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52911 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753436AbdCFSsv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 13:48:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 20F596C16D;
        Mon,  6 Mar 2017 13:43:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iw7xOaLKHF9muK71rXj/95BnfKk=; b=fV0vS3
        mFVA0mM70j8hxu7PpgudLCkwmUYKNJrYAI4f7YBV/hWyZ3LDy4nuk4rqJOTQZJDp
        bcG7SXBmxOKzqdq+usHSGJCuarBQrTN8GJOx+niSyZXG7/ALYNJy9GVWOkjQ7jUE
        BJky2gqZDx6tkAHeGhsbgM9HcSLTEcuzlmS0Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FpPhxkvtmvU4KvyVN4inGYVn1yqSaQcw
        l5t6I84iYRhNv5fBbbgWHsvKSVK+7glbQtqW/FpUaX0NIdccPsrLuOhok/8JdrJT
        y9XptzU7UMsI2068uQp2tvGpMgd+svdLGo2Zw7yq869usKZB3Yms9rs021BkJpLD
        YZlfDgShdhU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 193806C16C;
        Mon,  6 Mar 2017 13:43:36 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.84])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 61CEB6C16B;
        Mon,  6 Mar 2017 13:43:35 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        sbeller@google.com, bmwill@google.com, jonathantanmy@google.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: RFC: Another proposed hash function transition plan
References: <20170304011251.GA26789@aiede.mtv.corp.google.com>
        <20170306084353.nrns455dvkdsfgo5@sigill.intra.peff.net>
Date:   Mon, 06 Mar 2017 10:43:34 -0800
In-Reply-To: <20170306084353.nrns455dvkdsfgo5@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 6 Mar 2017 03:43:53 -0500")
Message-ID: <xmqqvarmnt49.fsf@junio-linux.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CE24C1C8-029C-11E7-8E26-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> You can use the doc URL
>> 
>>  https://goo.gl/gh2Mzc
>
> I'd encourage anybody following along to follow that link. I almost
> didn't, but there are a ton of comments there (I'm not sure how I feel
> about splitting the discussion off the list, though).

I am sure how I feel about it---we should really discourage it,
unless it is an effort to help polishing an early draft for wider
distribution and discussion.

> I don't think we do this right now, but you can actually find the entry
> (and exit) points of a pack during the index-pack step. Basically:

We have code to do the "entry point" computation in index-pack
already, I think, in 81a04b01 ("index-pack: --clone-bundle option",
2016-03-03).

> I don't think using the "want"s as the entry points is unreasonable,
> though. The server _shouldn't_ generally be sending us other cruft.

That's true.
