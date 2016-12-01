Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7F451FBB0
	for <e@80x24.org>; Thu,  1 Dec 2016 23:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753435AbcLAXjK (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 18:39:10 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63087 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751260AbcLAXjJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 18:39:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 96CC654841;
        Thu,  1 Dec 2016 18:37:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=sDdqvUtvP5bP
        X+4S3jHVxwxnY68=; b=GPbug1oAXfqiVDFxoOBoKbsJ3tgLEdz2u+opjZ1I9PJK
        cNdEUPO1XckexByHxKyzMOxHI/gabJEDdxatP5OenWaiB/pYukEDqaOruhyxYkZS
        oSHBZqODNf6N6Ao6wzH0f+jA8GW1Y7HsY0U4jqjLKH8AK3IzrSoPTsXOlAu43qY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=YeZ1gg
        WSmhLckqnMqUWEolWDIrSZU/4kFIlcpG0kuzMcvvXU99xd9WWv44Krk4Pm2Tv2s1
        NV7a/AgJHh0A0qLMkWPjpMJz56VtvtpPfsIdhXpUs6/hWGiX+nm96Z09V+MNtLSc
        PqYqpNpJ9kQ8boDGTJ+cMavURVpjAEEaOo3Ew=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8893B54840;
        Thu,  1 Dec 2016 18:37:56 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ECE1D5483F;
        Thu,  1 Dec 2016 18:37:55 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/3] compat: add qsort_s()
References: <3083fbf7-d67e-77e4-e05f-94a7e7e15eba@web.de>
        <fc602a66-a06c-203e-b50b-55fd7b258b54@web.de>
        <20161201193556.j2odwy3sepaxxq5a@sigill.intra.peff.net>
        <xmqq7f7j9zkd.fsf@gitster.mtv.corp.google.com>
        <20161201201917.nqx3v5fl2ptl3bhr@sigill.intra.peff.net>
        <955e9bf4-d1cd-f01a-13f1-7a335dea011a@web.de>
Date:   Thu, 01 Dec 2016 15:37:54 -0800
In-Reply-To: <955e9bf4-d1cd-f01a-13f1-7a335dea011a@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Thu, 1 Dec 2016 23:30:49 +0100")
Message-ID: <xmqqd1hb6x0t.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2F62B53A-B81F-11E6-A814-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

>> You can hack around it by passing a wrapper callback that flips the
>> arguments. Since we have a "void *" data pointer, that would point to =
a
>> struct holding the "real" callback and chaining to the original data
>> pointer.
>>
>> It does incur the cost of an extra level of indirection for each
>> comparison, though (not just for each qsort call).
>
> Indeed.  We'd need a perf test to measure that overhead before we
> could determine if that's a problem, though.

I agree.  Hopefully it won't be too much cost.

>> You could do it as zero-cost if you were willing to turn the compariso=
n
>> function definition into a macro.
>
> Ugh.  That either requires changing the signature of qsort_s() based
> on the underlying native function as well, or using a void pointer to
> pass the comparison function, no?  Let's not do that, at least not
> without a good reason.

Let's not go there.  It may be zero runtime cost, but the cognitive
cost for people who need to code the comparison callback using the
macro is high.
