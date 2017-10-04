Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DEE22036B
	for <e@80x24.org>; Wed,  4 Oct 2017 04:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751335AbdJDEHJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 00:07:09 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64470 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751299AbdJDEHI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 00:07:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AE417A0352;
        Wed,  4 Oct 2017 00:07:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2OsBputjeekgCCoeGEySKHiQIzQ=; b=qpQdW7
        rLVySlpMvI/n1ezO7tGk2z4QHUTxCE27s+gVwWFZqCXvQcMCkpJzOrjOoW6fE7dO
        5lizoTBRzTB1iFE+ehszA1lJgb/8KfKR8Fp++7mTYNW51+5zkx0IFhHLku4s2qq6
        CqLolkmQCm12rXeo6FSLuowKgE8u+SpTraFCY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XmKxutcNAw+yZ5bD971tQbvxEBpWNE9z
        r6zqJecpMj0WS9vhxtS+v5Bjj3kBHgWMO7bpK6zMmEsjeD9LIHZ8D5tlLZGP4JMF
        /vbLN9a0yLYtm0ZIEt4ct5EyPTNTVhjNQYVpCr68Po3XbpxFMPf7iBFcD+p4dvAz
        ZWXAGSv4yOg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A7619A0351;
        Wed,  4 Oct 2017 00:07:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2B055A0350;
        Wed,  4 Oct 2017 00:07:07 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH v16 1/6] bisect--helper: use OPT_CMDMODE instead of OPT_BOOL
References: <CAFZEwPOjK25m84BgTF7AL72DL_K1dHf7OrYoX=_vky9r3GayNw@mail.gmail.com>
        <0102015ecc65d695-22151d3b-752b-4c10-a3a3-b8ef52491664-000000@eu-west-1.amazonses.com>
        <5ca7a863-5b85-23b1-4432-cf74dcc7c4e0@ramsayjones.plus.com>
        <CAFZEwPN2BeogeVqXp7xh+GPUF6SDJa5JwQ3knZzOD_H6zcEwvQ@mail.gmail.com>
        <72995d24-d337-39c0-0abd-64bce1c22028@ramsayjones.plus.com>
        <xmqqa818lwi7.fsf@gitster.mtv.corp.google.com>
        <b2816cf9-4657-1124-2172-e15b619d6d42@ramsayjones.plus.com>
Date:   Wed, 04 Oct 2017 13:07:06 +0900
In-Reply-To: <b2816cf9-4657-1124-2172-e15b619d6d42@ramsayjones.plus.com>
        (Ramsay Jones's message of "Wed, 4 Oct 2017 03:22:21 +0100")
Message-ID: <xmqq1smjfted.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7CA857B0-A8B9-11E7-BB15-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> On 03/10/17 04:51, Junio C Hamano wrote:
>> 
>> It seems that Pranit needs a bit more work to take known fixes from
>> your efforts and we should wait for the series to be rerolled?
> 
> This series is just the first few patches from the original 28/29
> patch series; in particular, patches 1-5 and 8 of that series.
> ...
> So, the major differences and bug fixes are in later patches.

OK.  So these are good to go separately (as prerequistes for the
follow-on work)--thanks for clarification.
