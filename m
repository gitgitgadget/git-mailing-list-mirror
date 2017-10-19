Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 860631FF72
	for <e@80x24.org>; Thu, 19 Oct 2017 00:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751110AbdJSAlc (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Oct 2017 20:41:32 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51529 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750829AbdJSAlb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Oct 2017 20:41:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 18A4AB7833;
        Wed, 18 Oct 2017 20:41:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+BA2fa8C2c+ZGS+Rbop8pKW+NX8=; b=dnBdJp
        V2oZOJkyPKnxuoZCW0p9pHtTCLd6V+Iu4A9HLKdwirORafRqtZ9UTILoMRX74xge
        1eM2v8vjdG6uvQG8S8ZXkZiSR0LIikaF0qOCfgHxfCDT7il/BxcNvTtLpCO/tD4E
        WSawhpXKLFqjjP4oXdolOIH1W058R/AwU8l74=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OVAW6F2rkbnh1USfMe4xF+e+TYxy+Ga3
        OHC1+MR6hvlieBvO0Ki7WcrwG02R3dd4sQthTaAuoN/A6rKByl5YrUReZfQ6+WPJ
        SJKyEMeu9SQgHdnSh14gRrGNnk0L/Z++UjrcMYhnBKYv9V38sRi5YQs+FVf43Gl8
        7fgFw4KuZdk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 10EEEB7832;
        Wed, 18 Oct 2017 20:41:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2EE3AB7831;
        Wed, 18 Oct 2017 20:41:30 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Andrey Okoshkin <a.okoshkin@samsung.com>, git@vger.kernel.org,
        pclouds@gmail.com, l.s.r@web.de, avarab@gmail.com, krh@redhat.com,
        rctay89@gmail.com, Ivan Arishchenko <i.arishchenk@samsung.com>,
        Mikhail Labiuk <m.labiuk@samsung.com>
Subject: Re: [PATCH] commit: check result of resolve_ref_unsafe
References: <CGME20171018170047epcas2p4310be357e11e194d6d08ac3bdc478ba3@epcas2p4.samsung.com>
        <0e396c24-167f-901e-9122-cdc17164ec1e@samsung.com>
        <20171018183453.lr67zw455bkdmrlz@sigill.intra.peff.net>
Date:   Thu, 19 Oct 2017 09:41:29 +0900
In-Reply-To: <20171018183453.lr67zw455bkdmrlz@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 18 Oct 2017 14:34:53 -0400")
Message-ID: <xmqqo9p4j7eu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3F7A47FA-B466-11E7-B26D-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Tangential to your patch, I also wondered why we did not pass
> RESOLVE_REF_READING to resolve_ref_unsafe(). I think the answer is that
> for symref lookups, we normally don't pass it so that we can handle
> dangling symrefs. Of course we _just_ wrote HEAD ourselves, so we'd
> expect it to exist, so it shouldn't really matter either way.

If we do expect it to exist, shouldn't we checking with READING and
catching a funny situation if it arises?
