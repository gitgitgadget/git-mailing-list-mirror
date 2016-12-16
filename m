Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 017E61FF40
	for <e@80x24.org>; Fri, 16 Dec 2016 17:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756137AbcLPR7H (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Dec 2016 12:59:07 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56334 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754517AbcLPR7G (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2016 12:59:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4FA9C56FB6;
        Fri, 16 Dec 2016 12:59:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GS/HW6dx+by3Qdaj95N3HiENJec=; b=WikuTy
        c5ddlzk4X9S3TxcyX1R6xqZUIEsJgErn1gynzqoU03PToxSnQGYgaUJ44S6otGpF
        NRd0zMkvwX2fFIzWjTrd4jlm4Xxy+Z8nG7l4laPUtz744IpM91Tjye9wb1x6QBsJ
        bLIfQB/D+1D6RF6dyA9A0MpFr6fQWANO9PXV8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fpvhcqUlhcTPu+TWMT7GEM1mSgCvGXtg
        qlztpEv/dgf46sx5Lde29ruaS646egELLMCQ3At7aqhebsL2ZF3RtEcO2CtdcBie
        xunJq08tKGHRyVsGDONtZWs8T7f9yuy1aQg78hzxMN0yXM/h5llaYormI502S8AQ
        3uea2XpyeRc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 46DCC56FB5;
        Fri, 16 Dec 2016 12:59:05 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B4F0956FB4;
        Fri, 16 Dec 2016 12:59:04 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: index-pack outside of repository?
References: <20161215204000.avlcfaqjwstkptu2@sigill.intra.peff.net>
        <xmqqshpou3wt.fsf@gitster.mtv.corp.google.com>
        <20161216013728.in2dazshtarrnnq3@sigill.intra.peff.net>
        <20161216022904.cjang6napnl2vkc6@sigill.intra.peff.net>
        <xmqqd1gru5fw.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 16 Dec 2016 09:59:03 -0800
In-Reply-To: <xmqqd1gru5fw.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Fri, 16 Dec 2016 09:52:51 -0800")
Message-ID: <xmqq7f6zu55k.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 553968A8-C3B9-11E6-9A4E-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> On Thu, Dec 15, 2016 at 08:37:28PM -0500, Jeff King wrote:
>>
>>> But if this case really is just "if (from_stdin)" that's quite easy,
>>> too.
>>
>> So here is that patch (with some associated refactoring and cleanups).
>> This is conceptually independent of jk/no-looking-at-dotgit-outside-repo-final,
>> though it should be fine to merge with that topic. The BUG will actually
>> pass the new test, because it calls die, too. I wonder if we should die
>> with a unique error code on BUGs, and catch them in test_must_fail
>> similar to the way we catch signal death.
>>
>>   [1/3]: t5000: extract nongit function to test-lib-functions.sh
>>   [2/3]: index-pack: complain when --stdin is used outside of a repo
>>   [3/3]: t: use nongit() function where applicable
>
> I think 2/3 is a good change to ensure we get a reasonable error for
> "index-pack --stdin", and 3/3 is a very good cleanup.  Both of them
> of course are enabled by 1/3.
>
> We still fail "nongit git index-pack tmp.pack" with a BUG: though.

Wait.  

This only happens with a stalled-and-to-be-discarded topic on 'pu'.
Please don't waste time digging it (yet).
