Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2A02201C8
	for <e@80x24.org>; Mon, 13 Nov 2017 03:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751358AbdKMDkU (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 22:40:20 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54911 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751241AbdKMDkT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Nov 2017 22:40:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C0EBD96C96;
        Sun, 12 Nov 2017 22:40:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gFr3kRz0q3irp2anvOkvdbA7hoU=; b=fEe9/p
        jzcVqFV8UGZx13V0xYPgGs5nJbpZQx+2M8LG108PVMgNatP6dNM0AiZ2TjnH2w5+
        tDsc6fEumtasq10BNyKu+OXJvJdGGAqlA/xcLbyEIzU1uBhA+HQsdQ3mUP9HTYoD
        KziRr25DTWOcjADW3puh7c5B1gNFMm6oUt0NQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uFD7M/ws1A1cBaglxSWzSQQkv4fzkoA2
        WNRH2HTC0tgmDYGsBwrrRhcXTXIEThRaHFlyF0Bc+6RcWN5qxRumUllx/FQEZxrW
        2CrnCIlLPgZJDGJTb/ZslnOGQ65LFJlPyjEpby9mTRLwa6Lyn/s3zyt5OXqE2pez
        sO4i1moPd3w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B9E1396C91;
        Sun, 12 Nov 2017 22:40:18 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3D17C96C8F;
        Sun, 12 Nov 2017 22:40:18 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Soukaina NAIT HMID <nhsoukaina@gmail.com>, git@vger.kernel.org
Subject: Re: [add-default-config 2/5] adding default to color
References: <0102015fb0bf2f74-cb456171-fe65-4d83-8784-b553c7c9e584-000000@eu-west-1.amazonses.com>
        <0102015fb0bf3002-3462777a-2363-40cf-af37-80e26c0db65b-000000@eu-west-1.amazonses.com>
        <20171112153659.lt77rn6h6faeqfpb@sigill.intra.peff.net>
Date:   Mon, 13 Nov 2017 12:40:16 +0900
In-Reply-To: <20171112153659.lt77rn6h6faeqfpb@sigill.intra.peff.net> (Jeff
        King's message of "Sun, 12 Nov 2017 15:37:00 +0000")
Message-ID: <xmqqvaiealsv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5E2FD3DC-C824-11E7-A35A-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> @@ -47,6 +48,7 @@ static int show_origin;
>>  #define ACTION_GET_COLOR (1<<13)
>>  #define ACTION_GET_COLORBOOL (1<<14)
>>  #define ACTION_GET_URLMATCH (1<<15)
>> +#define ACTION_GET_COLORORDEFAULT (1<<16)
>
> I'm not sure I understand this part, though. Providing a default should
> be something that goes along with a "get" action, but isn't its own
> action.

I agree that it is not.

As an aside.  Over time we accumulated quite a many actions that are
all mutually exclusive by nature.  I have a feeling that we might be
better off to move away from this implementation.  The only thing
that we are getting from the current one-bit-in-a-flag-word is that
we can name the variable "actions" (instead of "action") to pretend
as if we can be given more than one, and then having to check its
value with HAS_MULTI_BITS(actions) to confuse ourselves.

Instead, perhaps we should introduce an "enum action" that includes
ACTION_UNSPECIFIED that is the initial value for the "action"
variable, which gets set to ACTION_GET, etc. with OPT_SET_INT().  If
we really care about erroring out when given

	$ git config --add --get foo.bar

instead of the "last one wins" semantics, we can use OPT_CMDMODE.

The above is of course outside the scope of this series, and I am
not sure if it should be done as a preparatory or a follow-up
clean-up.
