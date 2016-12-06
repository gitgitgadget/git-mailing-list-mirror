Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A43071FC96
	for <e@80x24.org>; Tue,  6 Dec 2016 20:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752507AbcLFUbW (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 15:31:22 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64147 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751605AbcLFUbS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 15:31:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D423455BCF;
        Tue,  6 Dec 2016 15:31:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uhsV5MFqHRcCR02QaZL0fivY6fA=; b=C7iPNR
        gXFdxMo7FF0QCabOx7WOirbG6Bx8Crsh5yWsqq8PQGiM5s9wZjbK3HippbLVuo8d
        EH6hgdUI094ctrRGaBXfp+A4tioy46PKd4+h30RXs0nGoYbnXCgaawUc+zNdFiA6
        hdaH9uk//ibXmmS8yRFe0k8ag9fJCw4D59wJg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Fxp8HSQWgGMFLLT3dpduowDHm2jTCqqt
        toS5tjyFBKmoEjYZ+9ALzgs9pKsU5LdHMfsb+Lav9NXAenrvSL/2DfYWjRvD5L+t
        YKLSPmLphws+OGCXaaH8NSHbNavgPZXYnkydeuxXEaabnvQtd/Yw6+vbzeLb6Ohn
        f0bP0vGpaeU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B99AB55BCE;
        Tue,  6 Dec 2016 15:31:16 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 31D9755BCD;
        Tue,  6 Dec 2016 15:31:16 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Matthew Patey <matthew.patey2167@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] stash: disable renames when calling git-diff
References: <CAFQpxxKbn4vBMzVcLZgBVvuL2fsOGNMHR1WC+aTOG_RAWkZ_Gg@mail.gmail.com>
        <20161206142446.5ba3wc625p5o6nct@sigill.intra.peff.net>
        <CAFQpxx+PJ3FSoH9DFWyEw+ZLagji9Qou+aY9EB8A+=t+QX0o2A@mail.gmail.com>
        <20161206152530.snccf7buiosst3e4@sigill.intra.peff.net>
        <20161206154120.yyuca35ugyuifpq6@sigill.intra.peff.net>
        <xmqqh96g27bh.fsf@gitster.mtv.corp.google.com>
        <20161206193154.vf7cd7lk5gyxrra5@sigill.intra.peff.net>
        <xmqqd1h425vv.fsf@gitster.mtv.corp.google.com>
        <20161206201130.azfmqvtk3iettlx7@sigill.intra.peff.net>
        <xmqq37i024fy.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 06 Dec 2016 12:31:15 -0800
In-Reply-To: <xmqq37i024fy.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Tue, 06 Dec 2016 12:22:25 -0800")
Message-ID: <xmqqy3zsztnw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EFDE9DDE-BBF2-11E6-A518-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> I think you are right that diff-index could work, though. I always
>> forget that without "--cached", diff-index looks at the working tree
>> files.
>
> I'll reword the log message while queuing.

The last paragraph became like so:

    The correct solution is to move to an appropriate plumbing
    command. But in the short term lets ask git-diff not to respect
    renames.

