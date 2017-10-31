Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19B3B20281
	for <e@80x24.org>; Tue, 31 Oct 2017 02:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751484AbdJaCtx (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 22:49:53 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61316 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750916AbdJaCtw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 22:49:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6D004A915E;
        Mon, 30 Oct 2017 22:49:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WUw0BkvHszExCPWlpVYHQ5H9x6k=; b=p10dVv
        j9KQDrEYKNh3rp68oX5L6T7p1hAQwS7Zxhb2lcFRn4rZu4sFQwjjhKoRgwF1NTXP
        AcZOii0Qe1V5GiQlNwwYM57fIdJA4OgnVdgYI89emW8RuhFCOkpeZX+UXQJJtYOf
        U+2e0wLfUc+EZ4y6DUSnT41GGHhkji/3hywWA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=my0iMGlx55DW23cn2kSZqowS1lSG16PK
        XWHYD4MMa6GO7Cy2J+oW+/YH0JNPCVmM9B8O6DKM8rrawQAC11oKOtEWY+LiAndZ
        p1xg0cocM7Pw0/KEboFBfF3oQNNE26BgA0vMICaiTpWcoFh1i4kJ5CmtsUX/rRWI
        ffRr/YSjBBA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 65F1FA915D;
        Mon, 30 Oct 2017 22:49:52 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D5C00A915C;
        Mon, 30 Oct 2017 22:49:51 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/3] diff: convert flags to be stored in bitfields
References: <20171027222853.180981-1-bmwill@google.com>
        <20171027222853.180981-4-bmwill@google.com>
        <xmqqk1zeafaq.fsf@gitster.mtv.corp.google.com>
        <xmqqzi898olb.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 31 Oct 2017 11:49:50 +0900
In-Reply-To: <xmqqzi898olb.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 30 Oct 2017 09:29:52 +0900")
Message-ID: <xmqqlgjs2fqp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2AF4D974-BDE6-11E7-A0E6-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> I still haven't brought myself to like the structure being passed by
>> value and the singleton diff_flags_cleared thing, but I suspect that
>> we may get used to them once we start using these.  I dunno.
>
> Just bikeshedding, but I just had to prepare an evil merge to add a
> new use of diff_flags_cleared to a codepath that evolved in a topic
> still in flight, and realized that I really hate the name.  Perhaps
> I wouldn't have hated it so much if it were named diff_flags_none or
> diff_flags_empty, I guess.

As to the "passing by value" thing, as long as we have the _or()
helper function, no sensible person will add anything but a bitfield
into the structure, so I am fine with it.
