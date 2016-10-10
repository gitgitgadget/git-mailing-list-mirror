Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABA6F20989
	for <e@80x24.org>; Mon, 10 Oct 2016 19:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751488AbcJJTHx (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 15:07:53 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58788 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751147AbcJJTHx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 15:07:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AD43F445FF;
        Mon, 10 Oct 2016 15:07:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xwbY4WxoHJxBfBT+qxcMrfuYAdY=; b=aljB1L
        KSfOH90aJUaJtgXEfBkyzBHkmxHtP+Z0zUNHX0kRvkIPJ/r1KAr7TfdoWk1ZT9i2
        AdwyNQBuwvY5yTCbd4/visS4/vKkGxHBjRjmI0OxCx5MRA2zVzs6fzlhE9BpjTIp
        oaf0dOTUg/A7Pit2DuyjnkBfFHC+dogTmkx3k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fvmjR3c0QMurUBGr1xUy2x1AUK1jfXDb
        MoLa+alScan2x3GZI6OHCbY/WUzrc8Fm7vsty+jtTXh9bln4wZncBrBLGGLqmH3Q
        q09SvNZ0xwX6p5/teaGcoM7GQed73a0aoM8zO9oKcVFRPc1Ok4gh2trsbKH8Bftm
        SShzrVgQyx0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A5606445FE;
        Mon, 10 Oct 2016 15:07:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 291F9445FD;
        Mon, 10 Oct 2016 15:07:51 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH/RFC] git.c: support "!!" aliases that do not move cwd
References: <xmqq60p5l3om.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1610071319520.35196@virtualbox>
        <CACsJy8ASc7Fxm5XDHFiX9E+bQ8s1MtmEHfc7bZY4C-_GEQr0og@mail.gmail.com>
        <0347de20-72a7-b384-389f-4b2ad5789973@kdbg.org>
        <20161007175052.sxyk7y2ytjh36phr@sigill.intra.peff.net>
        <alpine.DEB.2.20.1610081034430.35196@virtualbox>
        <20161009060149.voqjoiltqi6jub7g@sigill.intra.peff.net>
        <CACsJy8BpYYJmBm32YsQyuP58uhLE+sn8WdhiHyY6xzcqPVjMVQ@mail.gmail.com>
        <20161009205854.byq2wqgemtmwudfb@sigill.intra.peff.net>
        <xmqqzimcf5wl.fsf@gitster.mtv.corp.google.com>
        <20161010182129.fta7j7m3lxcgsn2d@sigill.intra.peff.net>
Date:   Mon, 10 Oct 2016 12:07:49 -0700
In-Reply-To: <20161010182129.fta7j7m3lxcgsn2d@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 10 Oct 2016 14:21:29 -0400")
Message-ID: <xmqqwphgdnui.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D72056AA-8F1C-11E6-96C6-5F377B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> ... My main motive in switching to the
> "alias.$cmd.key" syntax is that it fixes the ancient mistake of putting
> arbitrary content into the key (just like pager.*, as we've discussed
> elsewhere).

Yup, we are on the same page.  It's not too grave a mistake (we said
"these are command names and do not have to be able to contain
random letters" and deliberately did without the usual three-level
hierarchy; I think the reasoning is even more valid for pager.*),
but it does imply case insensitivity not to use three-level names,
and I think it is a good move.

