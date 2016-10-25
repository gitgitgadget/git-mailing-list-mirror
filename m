Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36CBF2035F
	for <e@80x24.org>; Tue, 25 Oct 2016 18:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932267AbcJYSh1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Oct 2016 14:37:27 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53681 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1759417AbcJYSh0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2016 14:37:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6D48F476D7;
        Tue, 25 Oct 2016 14:37:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EwzjhsB/ME71DC/3I0N0RtPHxPU=; b=EtcOK6
        GNjv1yKD1jQvx9959PBS00Pg2Ivj+PKHPm2y7vHpsPhcRoGEbv4yba2w/6gxqFGW
        jgfGe4fgbpci63xYhJeOF6eS0/XwuWiLB2LJExOWOwHXhFo4KZtyX9zIbiGLTcBN
        RYUYYQGlt7UoWGPwyenom8xOT3LuSoU+y+Ulw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=A2PmP5pYbaRkZQ9Ij4buYEDyB0J+Dsdl
        TmDnWB6WwVw1pB4Sts+HLM7whZ4n8Iep0S8LGVz1oikbIXHvidAmGVZx9F8ECDDZ
        Sgdqn3bvSmJnl3X7GoFjOLi27TwkvLe7gCIbIouVK5J9cHHBQ/4bsfDA4jTIX3eX
        y71LO3bpUO0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 64D18476D6;
        Tue, 25 Oct 2016 14:37:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DB872476D5;
        Tue, 25 Oct 2016 14:37:24 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] hex: use unsigned index for ring buffer
References: <ebf769d4-771f-499e-c7fc-f0377d8df18e@web.de>
        <20161023091146.p2kmqvgwxdf77dnn@sigill.intra.peff.net>
        <fb816dd5-8fb9-c6a6-2ec2-9ea4dddfdb26@web.de>
        <20161024130015.awlmgpfzixiy6wkb@sigill.intra.peff.net>
        <xmqqwpgx7jn6.fsf@gitster.mtv.corp.google.com>
        <xmqqshrl7j42.fsf@gitster.mtv.corp.google.com>
        <b1f9054e-fadb-c2d3-bf95-00e88e1fb85b@web.de>
        <xmqq60ohtib5.fsf@gitster.mtv.corp.google.com>
        <20161025003023.6vaqofsixana3zno@sigill.intra.peff.net>
        <xmqqd1ios2p3.fsf@gitster.mtv.corp.google.com>
        <20161025183347.u3cvowf2h6tabtuw@sigill.intra.peff.net>
Date:   Tue, 25 Oct 2016 11:37:22 -0700
In-Reply-To: <20161025183347.u3cvowf2h6tabtuw@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 25 Oct 2016 14:33:48 -0400")
Message-ID: <xmqq4m40s2al.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 12BE52F4-9AE2-11E6-A67E-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> diff --git a/path.c b/path.c
>> index fe3c4d96c6..9bfaeda207 100644
>> --- a/path.c
>> +++ b/path.c
>> @@ -24,7 +24,8 @@ static struct strbuf *get_pathname(void)
>>  		STRBUF_INIT, STRBUF_INIT, STRBUF_INIT, STRBUF_INIT
>>  	};
>>  	static int index;
>> -	struct strbuf *sb = &pathname_array[3 & ++index];
>> +	struct strbuf *sb = &pathname_array[index];
>> +	index = (index + 1) % ARRAY_SIZE(pathname_array);
>>  	strbuf_reset(sb);
>>  	return sb;
>
> This converts the pre-increment to a post-increment, but I don't think
> it matters.

Yes, I think that using the ring buffer from the beginning, not from
the second element from the beginning, is conceptually cleaner ;-).

