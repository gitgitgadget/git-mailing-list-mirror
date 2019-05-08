Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D07E91F45F
	for <e@80x24.org>; Wed,  8 May 2019 10:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfEHKQU (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 06:16:20 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64430 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfEHKQU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 06:16:20 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5F1BE149832;
        Wed,  8 May 2019 06:16:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Lez0whyInpzoG4QhyOPg7k200wY=; b=BIMFnB
        OhVlgZ+KE2fsSfr62kmfyKP6uDmyW79yUPJ61gNjbnLXqKDNQVX2e6mHhlx7OcVm
        NbQAfZnUpurYNzo7xeksepYzf4RrAL9LSTm6otU8e3GkKTOnotvgV8lwJnx5ZXLk
        5TLySDAr9yxxzPgL3TXCARbaz/khYu06SVTgc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VaxS+G9VL90hvpGNyNUaM24ZRuFRlKlD
        lxcoYV/12h8WFk1350QnB0qAjz+u80eC4lqbYxfODFK17pYaoSxqe2hCkKNOaDhL
        5AuectG3SNuIR4qkBa+N8EE93BxtzuWpEPtP//a/PtKywibP0nHkARS+6KSFOQZP
        QWMOJ0QA4OM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 56EB714982F;
        Wed,  8 May 2019 06:16:18 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B5B9D14982E;
        Wed,  8 May 2019 06:16:17 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Dan McGregor <dkm560@usask.ca>,
        "McGregor\, Dan" <dan.mcgregor@usask.ca>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v2] git-compat-util: undefine fileno if defined
References: <20190201193004.88736-1-dan.mcgregor@usask.ca>
        <20190209023621.75255-1-dan.mcgregor@usask.ca>
        <20190212134537.GA26137@ash>
        <D8E7C7D0-04E5-4802-80FA-2477F2C0D240@usask.ca>
        <xmqqk1f1gzgs.fsf@gitster-ct.c.googlers.com>
        <CACsJy8BcyD199L4qGv6-TP-8HD+GS+ZDNN5jspkh5uVaWekkoQ@mail.gmail.com>
Date:   Wed, 08 May 2019 19:16:16 +0900
In-Reply-To: <CACsJy8BcyD199L4qGv6-TP-8HD+GS+ZDNN5jspkh5uVaWekkoQ@mail.gmail.com>
        (Duy Nguyen's message of "Wed, 8 May 2019 17:09:05 +0700")
Message-ID: <xmqqv9ylfdzj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 516DFC68-717A-11E9-AB3C-E828E74BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> I don't think the other two were the problem. Even in the mail you
> pointed to, only fileno() is acknowledged the problem in the commit
> message.
>
> At least for BSDs fflush() and rewind() are not macros.

I can drop the dm/some-stdio-functions-are-macro-on-freebsd topic
safely then.  That was the most important thing I wanted to know
about ;-)

> Let's see if there are still problems with more exotic platforms. I'm
> reluctant of adding unused compat/ code because to me compat/ is
> scary.

Right.  Thanks.

