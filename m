Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1200220969
	for <e@80x24.org>; Sat,  1 Apr 2017 18:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751841AbdDASQ1 (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Apr 2017 14:16:27 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64633 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751791AbdDASQ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2017 14:16:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0BEA26B440;
        Sat,  1 Apr 2017 14:16:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=j4ZsUGfRTDSbF2UiW758M6o/bn4=; b=VLHuke
        eRBHNOJXg77xm3oV/UsQwDGKZRxm90jpgnk6NgjyT9jHEf5dHU/hRx0lhg/mdKgK
        +u0OUBK84QAEjTTlSKwWOGPofViO9v3FGyVrFJQuQijjRQCaLj1cSNFWn1TyaJdM
        tgZKNIuf1KTXGTThrYTPsYtd1BauyUIn63Uws=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tmTvc/ssu4np0IJNWunwpnUfJsdQpKop
        y2UFbT9O0fSb0gCoL8+Le8zLsh6Mf1dQQxqm/2n78arBtjDVy6Oj3BtIF3Y3SDV6
        SJ1yCIaXru0CcP/82cL75bIQ6roEDrblFVg385VAOZQIvgefLMAAWe9y5DEL8Skf
        yYBymjlAZPA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 042CD6B43F;
        Sat,  1 Apr 2017 14:16:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 21EF76B43D;
        Sat,  1 Apr 2017 14:16:25 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Kevin Willford <kewillf@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH] name-hash: fix buffer overrun
References: <20170331173214.47514-1-git@jeffhostetler.com>
        <20170331173214.47514-2-git@jeffhostetler.com>
        <xmqqo9whxmrq.fsf@gitster.mtv.corp.google.com>
        <xmqqy3vlw3f9.fsf@gitster.mtv.corp.google.com>
        <CAPc5daWU5XDVNiYk_pTFk_qziuDr6W2XDHXXH-0oR49_KiCUYA@mail.gmail.com>
        <xmqqh928wyu7.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1704011411460.3742@virtualbox>
Date:   Sat, 01 Apr 2017 11:16:23 -0700
In-Reply-To: <alpine.DEB.2.20.1704011411460.3742@virtualbox> (Johannes
        Schindelin's message of "Sat, 1 Apr 2017 14:12:31 +0200 (CEST)")
Message-ID: <xmqqk274uh6w.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5136C092-1707-11E7-B6D4-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Fri, 31 Mar 2017, Junio C Hamano wrote:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>> 
>> > Ah, of course. Avoid GNUism to spell HT as "\t" in a sed script.
>
> Sorry about that, I suggested this snippet to Kevin, it is my fault for
> not remembering BSD sed's idiosynchracies.

Heh, don't fret about that.  We all make mistakes and that is why we
review on the list so that patches get exposure to more sets of
eyes.  We may be interested to learn from our common mistakes, but
for that purpose, "whose fault is it?" is far less interesting than
"how it came about?", i.e. what made that mistake common and if/how
we can help people avoid it (removing cuttable-and-pastable bad
examples is one way to do so).

Thanks.
