Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 174DF1F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 04:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbfJKEJu (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 00:09:50 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53959 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfJKEJt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 00:09:49 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 883F8251A4;
        Fri, 11 Oct 2019 00:09:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZFvdRGOgpubH6q5Fl6i/2qQGiYE=; b=CbrdF9
        YF6VW0JZ8UPQ662ce+O9Pl+X3rTiNRXwO+XaImQkZwHolbvL4V/rKQrBy6RaLF6L
        OeaWHuioH2aM9eJtgqupRkdwa81L1YFjV+ncpua/vxPRhaZEWjwuReDI1QHNicf7
        wH+l8iWCN0jYqLundSueEsmmPKXoAak0FcHOQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=O7gFKkFO2fDtEBPEfHmZ31C+cVhrVkWu
        ZlonwFW9wxQoeENlkS27YfI8FfcxF7O7uTaZAOFZAl+ht2m5O93Z8QxtYpUa6Dmo
        ISSTWxoFctHWHKuhgN/J/VhNJAWTxEONkERpXJ8RdW+Z7P+nxhDecYCSGtNpGGZM
        HhmhiZMZK5U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6E6B7251A3;
        Fri, 11 Oct 2019 00:09:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C085A251A2;
        Fri, 11 Oct 2019 00:09:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Toon Claes <toon@iotcl.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Zeger-Jan van de Weg <git@zjvandeweg.nl>
Subject: Re: [PATCH 1/1] commit: add support to provide --coauthor
References: <20191008074935.10972-1-toon@iotcl.com>
        <20191009014039.GA10802@szeder.dev>
        <xmqqr23mlkxo.fsf@gitster-ct.c.googlers.com>
        <20191009203105.GA7007@sigill.intra.peff.net>
        <87sgo1q92k.fsf@iotcl.com>
        <20191010163755.GA12756@sigill.intra.peff.net>
Date:   Fri, 11 Oct 2019 13:09:45 +0900
In-Reply-To: <20191010163755.GA12756@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 10 Oct 2019 12:37:56 -0400")
Message-ID: <xmqqwodbj52u.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F63D0AAE-EBDC-11E9-8768-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Yes, I agree that ordering and de-duplication rules are useful, too.
> Some of that can be expressed already in trailer.* config, but I don't
> know if it would be capable enough to do everything you want (though
> again, it would be really nice to _make_ it capable enough so that other
> types besides co-authored-by can make use of them).

Yup, absolutely.

As a mature system, unlike the early days, randomly adding a
"desired" feature without first considering if a generalized form
can be added is simply irresponsible to our users.  Response by
Brian on the side thread also indicates that we have already spent
enough effort to the generalized trailer support and building on
top, instead of randomly adding an ad-hoc "feature", may be the
right and feasible approach.

