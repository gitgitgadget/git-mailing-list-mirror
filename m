Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11DC31FF6D
	for <e@80x24.org>; Thu, 22 Dec 2016 17:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941804AbcLVR53 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Dec 2016 12:57:29 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58092 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932468AbcLVR52 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2016 12:57:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3CAA05922F;
        Thu, 22 Dec 2016 12:57:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ed2YvBBxeUOvExxi3CfAi4wmfRU=; b=w7VWqm
        fHydomMs2SgGtFtl1OsWcycm5ybCxOmnJ8duzGzLKdaTVF2LuuX5JBH5c5u7f99o
        KM0QN40cnmbMCV0fvI5+v0+d5OB1oi3b515GwCmWTOq5DuOOcBMQZULC97oPnH8i
        Lh7yMSCcPN26S/na1jmEbRtHN7DmNU9obG5UA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gFmViSRo27nUPFw2gxtYPqlRZBUxLz1+
        YRnswwFuWY/3XwnueGoBNmrAIczJ49CeXX0F6XQ8+0hY3r91aErd/Mytma52IPiq
        ZtEmKsjPI/O4nZ+UMsvbvvOf1yqnRRI++YqXrWH6huYB7LGLIF9pAEWP1riSK4ss
        XiGTzwbwrIw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 33F155922E;
        Thu, 22 Dec 2016 12:57:27 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9C0C85922C;
        Thu, 22 Dec 2016 12:57:26 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "Kyle J. McKay" <mackyle@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] mailinfo.c: move side-effects outside of assert
References: <900a55073f78a9f19daca67e468d334@3c843fe6ba8f3c586a21345a2783aa0>
        <20161219200259.nqqyvk6c72bcoaui@sigill.intra.peff.net>
        <A916CED6-C49D-41D8-A7EE-A5FEDA641F4A@gmail.com>
        <alpine.DEB.2.20.1612201511480.54750@virtualbox>
        <20161220164526.qnwnmr7cvyycmw6a@sigill.intra.peff.net>
        <222ACFD4-ED9A-4B94-8BDD-3C70648A684B@gmail.com>
        <20161221155539.aykcmkuzqvq733ri@sigill.intra.peff.net>
        <F5001DF2-20C2-4757-997F-9D40BD48E1D9@gmail.com>
        <20161222033418.dmslmuhq7mqhmkwq@sigill.intra.peff.net>
Date:   Thu, 22 Dec 2016 09:57:25 -0800
In-Reply-To: <20161222033418.dmslmuhq7mqhmkwq@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 21 Dec 2016 22:34:19 -0500")
Message-ID: <xmqq7f6rhmnu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 193AD9A2-C870-11E6-A480-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Well, no, I mostly just said that I do not think there is any point in
> defining NDEBUG in the first place, as there is little or no benefit to
> removing those asserts from the built product.
> ...
> Sure, if you want to mass-convert them, doing so with a macro similar to
> assert is the simplest way. I don't think we are in a huge hurry to do
> that conversion though. I'm not complaining that NDEBUG works as
> advertised by disabling asserts. I'm just claiming that it's largely
> pointless in our code base, and I'd consider die("BUG") to be our
> "usual" style. 

I agree with all of the above. Given the way how our own code uses
assert(), there is little point removing them and turning them over
time into "if (...) die(BUG)" would probably be better.

Borrowed code like nedmalloc may be a different story, but as you
said in a separate message in this thread, I think we are better off
leaving that to those who care about that piece of code.
