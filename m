Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BE0A203C1
	for <e@80x24.org>; Tue, 15 Nov 2016 01:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933642AbcKOBCb (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Nov 2016 20:02:31 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54277 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755161AbcKOBCa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2016 20:02:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E877550878;
        Mon, 14 Nov 2016 20:02:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=x724UOcfpYptSatGb/HRzcCtyUA=; b=EpFL4i
        oWZsCAq6mTSNYgxW0mr6Z5fhdG84AkXhRP7yT7CFRKNfeYBKtgZ0SByOytwiFCAp
        h5oDN7rZIgNWVWTQ0m4sxuWgYU0zfAbCdtvyQqM4dx8OTIOOQcb5hjxfMqKlTIAi
        pc/SsZcd/HTgsTxvJ54pmEGkD/JG4rZyZhVrM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=X1SxK9gOwvv6v9eXGrbaCJ2B8VoIgKpK
        fKkvrbS5Gj19N70vVBRNXulu3X7fhzDU0WNsH1/zjIT0+R9nFGXb+5+AwTUdEegh
        iW8MrQbsagTmrPFuiEOC6NrXWMFnNHO1AOMpHeRXZTOpSOQxoDiAPefNmdsnC9lo
        Y5pqbhanvcA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DF9B450877;
        Mon, 14 Nov 2016 20:02:28 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 563A650876;
        Mon, 14 Nov 2016 20:02:28 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     David Turner <dturner@twosigma.com>, git@vger.kernel.org,
        spearce@spearce.org
Subject: Re: [PATCH] remote-curl: don't hang when a server dies before any output
References: <1478729910-26232-1-git-send-email-dturner@twosigma.com>
        <20161114182431.e7jjnq422c4xobdb@sigill.intra.peff.net>
        <20161114194049.mktpsvgdhex2f4zv@sigill.intra.peff.net>
        <20161115004426.unheihlmftlw6ex7@sigill.intra.peff.net>
Date:   Mon, 14 Nov 2016 17:02:27 -0800
In-Reply-To: <20161115004426.unheihlmftlw6ex7@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 14 Nov 2016 19:44:26 -0500")
Message-ID: <xmqqa8d1v9lo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2DC68254-AACF-11E6-ABA1-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Actually, I take it back. I think it works for a single round of ref
> negotiation, but not for multiple. Enabling GIT_TEST_LONG=1 causes it to
> fail t5551.
>
> I think I've probably made a mis-assumption on exactly when in the HTTP
> protocol we will see a flush packet (and perhaps that is a sign that
> this protocol-snooping approach is not a good one).

Hmph.  I think I tried David's original under GIT_TEST_LONG and saw
it got stuck; could be the same issue, I guess.
