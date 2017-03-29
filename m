Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55AA820958
	for <e@80x24.org>; Wed, 29 Mar 2017 16:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752515AbdC2QFj (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 12:05:39 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59635 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751953AbdC2QFi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 12:05:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 46F86849EF;
        Wed, 29 Mar 2017 12:05:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+k/Kkln+yqum13gt/i9hRANJEPY=; b=pahVf5
        0BHjT3ELGx4alRkfEYQsKAqcprQ6SBLM7sUSruyKHycOZD2bf52OHPBu2LcUZ/0Q
        7Ib9Aw7EcNtyllpUA9QAPinUX/PrrmHsxbRZpjplLczmuCch1Rie52lt92TrEi/+
        O/dDkG2a0trXAvcuC4Z+QIqzmRnsURDdTezdk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=V5WklQdsNHuz87JfazS3QeWN5Qfcyq6T
        DoeF9Oh0cRQIovcsoMq/llFhmoqsYxKHHWClRPi0HEOLqewhbOK2iX0wMM07ggvh
        MpV+K/RUYntpTTPVhkUDAFmiZP8MzwhTFYRXlx3XOAo60PpfzOXzQgQv7ufJhbp7
        rfVA0nsSBns=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3C9DD849EE;
        Wed, 29 Mar 2017 12:05:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9D1D0849ED;
        Wed, 29 Mar 2017 12:05:36 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/18] snprintf cleanups
References: <20170328194255.vf7nfzzmmzxsbn36@sigill.intra.peff.net>
        <xmqq60itc9pv.fsf@gitster.mtv.corp.google.com>
        <20170329034105.bfgh4tutgrmjp2lc@sigill.intra.peff.net>
Date:   Wed, 29 Mar 2017 09:05:33 -0700
In-Reply-To: <20170329034105.bfgh4tutgrmjp2lc@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 28 Mar 2017 23:41:05 -0400")
Message-ID: <xmqqr31gax0y.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8BD3B248-1499-11E7-B5AE-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Mar 28, 2017 at 03:33:48PM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > It's a lot of patches, but hopefully they're all pretty straightforward
>> > to read.
>> 
>> Yes, quite a lot of changes.  I didn't see anything questionable in
>> there.
>> 
>> As to the "patch-id" thing, I find the alternate one slightly easier
>> to read.  Also, exactly because this is not a performance critical
>> codepath, it may be better if patch_id_add_string() filtered out
>> whitespaces; that would allow the source to express things in more
>> natural way, e.g.
>> 
>> 		patch_id_addf(&ctx, "new file mode");
>> 		patch_id_addf(&ctx, "%06o", p->two->mode);
>> 		patch_id_addf(&ctx, "--- /dev/null");
>> 		patch_id_addf(&ctx, "+++ b/%.*s", len2, p->two->path);
>> 
>> Or I may be going overboard by bringing "addf" into the mix X-<.
>
> I think there are two things going on in your example.
>
> One is that obviously patch_id_addf() removes the spaces from the
> result. But we could do that now by keeping the big strbuf_addf(), and
> then just walking the result and feeding non-spaces.
>
> The second is that your addf means we are back to formatting everything
> into a buffer again....

You are right to point out that I was blinded by the ugliness of
words stuck together without spaces in between, which was inherited
from the original code, and failed to see the sole point of this
series, which is to remove truncation without adding unnecessary
allocation and freeing.

Thanks for straighten my thinking out.  I think the seeming
ugliness, if it ever becomes a real problem, should be handled
outside this series after the dust settles.



