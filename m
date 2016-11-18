Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 170591FE4E
	for <e@80x24.org>; Fri, 18 Nov 2016 18:28:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752995AbcKRS2n (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Nov 2016 13:28:43 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58244 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752765AbcKRS2m (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2016 13:28:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EBD234E1CD;
        Fri, 18 Nov 2016 13:28:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tH5C7mlyju9nZ3tm8BQNGYAbj5I=; b=ISNpzH
        O7ZSPMcVuBRWlPk97zmiJXaGhbw0VFaPUW7Al1NmBA7qXrKcjdnRZx2+E/U9hM/N
        eVVaZy8BWMPl8oKd5DX6Z+zoUPatjd/2zOTAZY5qIXkxPiAQ38QRzWRVtiKndoez
        /Up+fitEzTqMv/p9+xw+YTf4EtfwkMyQr3NDE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GPFGd1/CDkJ1e6rZfzCeLaZCEavE4MKh
        ynsgWJpal9hIOfk074O3m0jJ4qjs9DB3mXpGuFMPIpIstPFp3orzXWQPGJ3vbpBl
        ie+xzuyeUjlIjiochY7mOd1krqlYSlRRJgVp0M9W25OshRdOzUvj1WxP4P6fmHBP
        JbN4735DAAM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E25354E1CC;
        Fri, 18 Nov 2016 13:28:41 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 63B454E1CB;
        Fri, 18 Nov 2016 13:28:41 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     David Turner <dturner@twosigma.com>, git@vger.kernel.org,
        spearce@spearce.org
Subject: Re: [PATCH] remote-curl: don't hang when a server dies before any output
References: <1478729910-26232-1-git-send-email-dturner@twosigma.com>
        <20161114182431.e7jjnq422c4xobdb@sigill.intra.peff.net>
        <20161114194049.mktpsvgdhex2f4zv@sigill.intra.peff.net>
        <20161115004426.unheihlmftlw6ex7@sigill.intra.peff.net>
        <xmqqa8d1v9lo.fsf@gitster.mtv.corp.google.com>
        <20161115035844.e6ehuy7uigqinbnv@sigill.intra.peff.net>
        <xmqqzil0tza6.fsf@gitster.mtv.corp.google.com>
        <20161118170147.g7nbkxpyihwkk6fw@sigill.intra.peff.net>
Date:   Fri, 18 Nov 2016 10:28:39 -0800
In-Reply-To: <20161118170147.g7nbkxpyihwkk6fw@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 18 Nov 2016 09:01:47 -0800")
Message-ID: <xmqqlgwgmylk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D4A219AE-ADBC-11E6-8E3D-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So I don't feel like we have a good patch for the general case yet, and
> I'm probably not going to get around to implementing it anytime soon. So
> I'd suggest taking David's original patch (to punt when the response is
> empty) in the meantime.

Yup, we are on the same page; the above matches what I wrote in the
draft of the next issue of What's cooking report last night.

> I do think the commit message could be improved based on the discussion
> here, though (at the very least to describe the nature of the deadlock,
> and that we are choosing only one of the possible solutions, and why).

Thanks.  That sounds sensible.


