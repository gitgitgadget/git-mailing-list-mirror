Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3491820958
	for <e@80x24.org>; Wed, 29 Mar 2017 15:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932188AbdC2POa (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 11:14:30 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59306 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932153AbdC2PO1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 11:14:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 122687ED89;
        Wed, 29 Mar 2017 11:14:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OLP/EYxdjCFiin1Z3SmvG3GHkGo=; b=DQ9w4y
        h+YrPeORvJcVWNJUEEWZb8ZOOpPOTwvsHFGoUVD2jX/cFQxA0A2Yi4XfODabNlwL
        IAwobCiOfiWb37HPeAKWcRiZDKwgLRC3ymU2+yUEH6xGX2GXMN356N1K+9ZOJWp9
        Zm6lxHiDB8NvSaOqLI9aCXfbI+SqoYoxO0aTw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HnZVdtx9TTVSU9lE7uuLkRvuvpGhWrRq
        lvPWf97JT8E8NofLV73ehTJI3Ul8mUUywJQ5FkEH4GjtckmBZBc2WjDXOq//9y7O
        MsbNMsgVXMxQQooAOhr4X4RttsUxQVrEYN10huvfh5xcglihHc2YVPp6J+rRPbTr
        0nk76BB/4nk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 09E1F7ED88;
        Wed, 29 Mar 2017 11:14:21 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 70C117ED87;
        Wed, 29 Mar 2017 11:14:20 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eQ==?= =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?= Duy 
        <pclouds@gmail.com>
Subject: Re: [PATCH v2 16/21] Make sha1_array_append take a struct object_id *
References: <20170326160143.769630-1-sandals@crustytoothpaste.net>
        <20170326160143.769630-17-sandals@crustytoothpaste.net>
        <xmqq7f39e2gi.fsf@gitster.mtv.corp.google.com>
        <20170329000648.vb2hdqfizjqjyryr@genre.crustytoothpaste.net>
Date:   Wed, 29 Mar 2017 08:14:19 -0700
In-Reply-To: <20170329000648.vb2hdqfizjqjyryr@genre.crustytoothpaste.net>
        (brian m. carlson's message of "Wed, 29 Mar 2017 00:06:48 +0000")
Message-ID: <xmqqvaqsazec.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 62487F28-1492-11E7-B195-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On Tue, Mar 28, 2017 at 10:27:41AM -0700, Junio C Hamano wrote:
>> ... 
>> After all, the original written by a human said E2[E3].hash (or
>> array->sha1[i]) because to the human's mind, E2 is a series of
>> things that can be indexed with an int E3, and even though 
>> 
>>     *(E2 + E3)
>>     E2[E3]
>>     E3[E2]
>> 
>> all mean the same thing, the human decided that E2[E3] is the most
>> natural way to express this particular reference to an item in the
>> array.  &E2[E3] would keep that intention by the original author
>> better than E2 + E3.
>
> I'm happy to make that change.  I'm an experienced C programmer, so a
> pointer addition seems very readable and natural to me, but if you think
> it's better or more readable as &E2[E3], I can certainly reroll.

The obvious three possible variants I listed above are equivalent to
the language lawyers and the compiler ;-).

This change is about dropping the need for ".hash", and I think a
faithful, boring and mechanical conversion that tries to preserve
the intent of the original author would be more appropriate.  It is
entirely possible that some places where the original said E2[E3]
were easier to understand if it were *(E2 + E3), thus we may want to
further rewrite such a place to (E2 + E3) instead of &E2[E3] after
the mechanical conversion.

Thanks.
