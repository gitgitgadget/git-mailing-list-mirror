Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 099AB1F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 23:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752201AbdAYXZO (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 18:25:14 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51440 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752081AbdAYXZN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 18:25:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C5D1063DEF;
        Wed, 25 Jan 2017 18:25:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tjMTs6q3X6RPf2zkEGuR1P2N/Y0=; b=YUZGol
        nFVcM+qEplVjVk+nDIGBYCNCnJVKt5J5yXe10M4HpyOlDzpkA5FCPouKyGz1ONqz
        IzEoubNayzZDEoqdQ8SuSDt6iODKUSjvLwa3er8JpZiKFWH21YUUdcA16x31JDQK
        cmH50AH1T3WxNQhrj/9n92yyqMqQnwqbvZohA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=E+owT5mLwu1mSgRONmGUbRI8M7MEjq9s
        A25wNz0+nMVcYo22wCRTD4Oo0V3OU/WqSnhcPjp+ldLEiP85biGW5bw/P01xsOb3
        lihnQoGavR0TPQDIFUQxYAwRl227A95nJ+k1vJkkkPst52HqFbky9a6KIByywvF6
        jXOwxygbDBY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B8BE263DEE;
        Wed, 25 Jan 2017 18:25:11 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7272E63DED;
        Wed, 25 Jan 2017 18:25:10 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Segev Finer <segev208@gmail.com>
Subject: Re: [PATCH] connect: handle putty/plink also in GIT_SSH_COMMAND
References: <2ff29a4d00e0e13d460122d8008e762361ca90aa.1483358673.git.johannes.schindelin@gmx.de>
        <xmqqy3ym1dsc.fsf@gitster.mtv.corp.google.com>
        <xmqq4m1911mf.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1701090825510.3469@virtualbox>
        <xmqqh958y44c.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1701091207480.3469@virtualbox>
        <xmqqmvf0wc2h.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1701251327090.3469@virtualbox>
        <xmqqinp2939j.fsf@gitster.mtv.corp.google.com>
        <20170125224043.jxjc4avuy4ztnkm4@sigill.intra.peff.net>
Date:   Wed, 25 Jan 2017 15:25:08 -0800
In-Reply-To: <20170125224043.jxjc4avuy4ztnkm4@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 25 Jan 2017 17:40:43 -0500")
Message-ID: <xmqqpoja7mej.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 83D7BCD0-E355-11E6-A728-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Jan 25, 2017 at 02:35:36PM -0800, Junio C Hamano wrote:
>
>> -- >8 --
>> Subject: [PATCH] connect: core.sshvariant to correct misidentification
>
> I have been watching this discussion from the sidelines, and I agree
> that this direction is a big improvement.
> ...
> IIRC, the "const" in git_config_get_string_const is only about avoiding
> an annoying cast. The result is still allocated and needs freed. Since
> you are not keeping the value after the function returns, I think you
> could just use git_config_get_value().

It is too late for today's pushout (I have this topic near the tip
of 'pu', so it is possible to tweak and redo only 'pu' branch, but I
generally hate tweaking things after 15:00 my time), but I'll fix
that before the topic hits 'jch' (which is a bit more than 'next'
and that is what I use for everyday work).

Thanks.  
