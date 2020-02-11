Return-Path: <SRS0=9mHE=37=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CFBFC352A3
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 16:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF3CD2082F
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 16:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gDhuqk09"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730051AbgBKQRh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Feb 2020 11:17:37 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57213 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729022AbgBKQRh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Feb 2020 11:17:37 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 72567BFCB0;
        Tue, 11 Feb 2020 11:17:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8FLjV8m34A+Yn5qyWM6gKw71Hvg=; b=gDhuqk
        09gz8fB4j23e+L46Ureap9gRi+iNzgN8qbE9vtg0PZY3pwaW0L5V5wsrfpjryr6B
        7KKsxnrvdVSYSNQh9XE+GCg6yO2oyNFF8QHtiW7HVEdXaFSYI35XMl7fTaemM8d7
        O76u2bVXb4/n7eIJAOSZ1hTWyj/rQlHjWi0gE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uVxNWYwmlLcc6KTSWTdRZCSiU8Znp1wx
        esqPtXph2xPlZxqpVfqkLsuG/b0IRVjG52QbUUUNy34v6ZDG65ylWVD0AApRvQs8
        X9hedt3aJrDsNVS5r29EZydq7cFFs+ta8cyPlHhbEYxKY69bKu/yZy1+4oTWcTRH
        r34hCccqHvc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 57309BFCAF;
        Tue, 11 Feb 2020 11:17:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6BCC4BFCAE;
        Tue, 11 Feb 2020 11:17:32 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2] strbuf: add and use strbuf_insertstr()
References: <019be197-e0aa-1234-e16f-6561d8340023@web.de>
        <b31c46a8-380b-3528-27a5-a2dddacaf837@web.de>
        <CAPig+cQdJ0NJSWZN-2ckeLB7RfU9GZ7LGvVX4y+Q1daPnW8WsA@mail.gmail.com>
        <20200210234427.GA632160@coredump.intra.peff.net>
Date:   Tue, 11 Feb 2020 08:17:30 -0800
In-Reply-To: <20200210234427.GA632160@coredump.intra.peff.net> (Jeff King's
        message of "Mon, 10 Feb 2020 18:44:27 -0500")
Message-ID: <xmqq1rr1xfmt.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 01CE77D6-4CEA-11EA-B854-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Something like the (largely untested) patch below. That would also make
> it easy to support arbitrary amounts of whitespace after the header,
> which I think are allowed by the standard (whereas now we'd parse
> "Content-type:    text/plain" as "    text/plain", which is silly).
>
> Worth doing?

The result does look cleaner.  I do not think we've seen much
polishing in this area of the code for quite a long time, which
might indicate that what we have may be good enough, but at the same
time it would mean it is quiescent time for the code and it is safe
to clean it up.

