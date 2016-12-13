Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 460C3203EC
	for <e@80x24.org>; Tue, 13 Dec 2016 20:12:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933459AbcLMULE (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 15:11:04 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59769 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753753AbcLMUK0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 15:10:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2C92957F3D;
        Tue, 13 Dec 2016 15:10:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lsf31wcHIDNZwXtq09dlPwTaBX8=; b=ZL6dFw
        met2LWhktEmuRetRyPBdmRjP65ozJrOglzX1TE1y0h0+kpY5S9hpkx9tTru86S5e
        4U8M4GtcbllmQEg3Nb1wg7EP2Y2cc1JS5/2kgECKcynzgZPQYV40jgJIGgmpDZvL
        WjKHR1juejRdYDhvXTtqwTlvrN0wQHWkheiN0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TBIH+VO6h3JjJwMIVxOsXd7NglCU8zqc
        RJZvPD4xwetUUj+cIecQyXRzI7MK3bWoiO3cbl6IAHddiSiqEMHdzV7kregJpvNy
        Qdk5XyHgZmfEMQPgKVYM6aNcKA/d7hcfbv3kMlKuQTk/svsfsFUWBr7qDvKKci3p
        +byQCdtTORs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 24CC957F3C;
        Tue, 13 Dec 2016 15:10:24 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9B81A57F3B;
        Tue, 13 Dec 2016 15:10:23 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Sixt <j6t@kdbg.org>, Klaus Ethgen <Klaus@Ethgen.ch>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] tmp-objdir: quote paths we add to alternates
References: <20161212194929.bdcihf7orjabzb2h@sigill.intra.peff.net>
        <20161212195355.znqlu44lgnke3ltc@sigill.intra.peff.net>
        <d83cd58f-9b52-cbc5-04dd-5aafe2822533@kdbg.org>
        <20161213114414.masgfo7lf7e3utym@sigill.intra.peff.net>
        <xmqqwpf34s5f.fsf@gitster.mtv.corp.google.com>
        <20161213181538.6gv4it4b33uhbuud@sigill.intra.peff.net>
Date:   Tue, 13 Dec 2016 12:10:22 -0800
In-Reply-To: <20161213181538.6gv4it4b33uhbuud@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 13 Dec 2016 13:15:38 -0500")
Message-ID: <xmqqoa0f1tg1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2E2C612A-C170-11E6-AAF5-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Dec 13, 2016 at 10:10:04AM -0800, Junio C Hamano wrote:
>
>> > -	git clone --bare . xxx:yyy.git &&
>> > +	git clone --bare . xxx${path_sep}yyy.git &&
>> 
>> Don't you want to dq the whole thing to prevent the shell from
>> splitting this into two commands at ';'?  The other one below is OK.
>
> After expansion, I don't think the shell will do any further processing
> except for whitespace splitting. E.g.:

Ah, my mistake.  Staring at too many `eval`s does it to me.

Thanks.
