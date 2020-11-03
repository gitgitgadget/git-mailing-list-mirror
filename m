Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B16C388F7
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 21:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 233EA20786
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 21:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LzPWjtDO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732929AbgKCVmz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Nov 2020 16:42:55 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62304 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732278AbgKCVmy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Nov 2020 16:42:54 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7CE75EE610;
        Tue,  3 Nov 2020 16:42:53 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=thKIUgVG/XE0l62lPElX0bemuuE=; b=LzPWjt
        DOaBunkRUKNRA940WGrBU1pxV1G0IhDo/kRpL7rzWqWK7byUvV/9UkmpNnE+x842
        Xl6ob9E9ruRoZHgETqa0Ek9ehsl6MYEmKCLMvuljvoTRwJIvMjzP74k6l9KbRjeI
        vLIPeG4tg2AFsDnSSEzu0iJFHSSylXEhYuzgI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yWcNRCXWLqWmzLUDFT2wHQnRD30coOLJ
        CpKmY+WGkJj5bQviR4emuCsqAg0fudfQf0NvlsrqcBmwvbUTW+W2J2WQ7J5PLzXx
        4veEzJyuq6Lzcbv7/yQSLrBTBRa23g1Ucsn76YIWbigeN2hbA9jcCJ2UASoKfeqF
        iaZVqHmZzJc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 76853EE60F;
        Tue,  3 Nov 2020 16:42:53 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 710C5EE60D;
        Tue,  3 Nov 2020 16:42:49 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 02/11] docs: new trace2.advertiseSID option
References: <cover.1604006121.git.steadmon@google.com>
        <cover.1604355792.git.steadmon@google.com>
        <5d5097b67109554e0763724633810ea616b5e2b2.1604355792.git.steadmon@google.com>
Date:   Tue, 03 Nov 2020 13:42:47 -0800
In-Reply-To: <5d5097b67109554e0763724633810ea616b5e2b2.1604355792.git.steadmon@google.com>
        (Josh Steadmon's message of "Mon, 2 Nov 2020 14:31:00 -0800")
Message-ID: <xmqq1rhaqfqg.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 84BC4FBA-1E1D-11EB-80CA-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> Document a new config option that allows users to determine whether or
> not to advertise their trace2 session IDs to remote Git clients and
> servers.

I do not think placeing this in the trace2 hierarchy is a good idea.

It is not like concept of "session" belongs to trace2; each
operation we perform inherently is done on behalf of a session.
The trace2 subsystem may have been the first to externalize the
concept, but even after trace2 gets superseded, we would want to
key our log records with some "session ID".  After we introduce
an improved mechanism that is successor to trace2, we still would
want to exchange some session ID if the advertiseSID option the
users define in their repository today (well, maybe in 3 months
after this series lands in a released version and widely
deployed), no?

We are not exposing the session ID anywhere but the transports, so
how about calling it transport.advertiseSID, perhaps?

We also may want to call that just "session ID", not "trace2
session ID" in the description.

Thanks.

> Signed-off-by: Josh Steadmon <steadmon@google.com>
> ---
>  Documentation/config/trace2.txt | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/config/trace2.txt b/Documentation/config/trace2.txt
> index 01d3afd8a8..3f2e3b4425 100644
> --- a/Documentation/config/trace2.txt
> +++ b/Documentation/config/trace2.txt
> @@ -69,3 +69,7 @@ trace2.maxFiles::
>  	write additional traces if we would exceed this many files. Instead,
>  	write a sentinel file that will block further tracing to this
>  	directory. Defaults to 0, which disables this check.
> +
> +trace2.advertiseSID::
> +	Boolean. When true, client and server processes will advertise their
> +	trace2 session IDs to their remote counterpart. Defaults to false.
