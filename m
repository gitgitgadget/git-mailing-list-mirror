Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB00C388F7
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 21:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA7042236F
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 21:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="V/1Vjk5z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733052AbgKCVdd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Nov 2020 16:33:33 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51213 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733075AbgKCVdb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Nov 2020 16:33:31 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0AC7B9B614;
        Tue,  3 Nov 2020 16:33:29 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MWZtGN52TMWcXQMwOfuih9U54/Y=; b=V/1Vjk
        5z6/ek2HcZ2CsuYquYxA/8cGQ0nGkDvkgBCFdTf8jtj9AG8AN88RmWGig2PSA/vC
        C4QYfJCwiTFjA4ujX0NTY+bZRozx3PMDyhqonBJbkWvravAGhrvE5cEljnsIikNi
        hHUcaMWFJ1syAUCHC4lmkFaEFvizpjt9TtiLs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xx3KIfq5lj1LsRHZM7cxeVzE933FQMWL
        n/Lj2hTGf+h+lL+FRTXdt8+qcGxS/4v938smraoAiTgY/nMnsvOSQNWVcyJKU1yi
        l5veIFRi4OnXwkf76qbacxK35uFHWV36RXK4yRVnzqm/XoQ3ShtCZWi5lrgXv5dI
        Aw4wK3NLb+s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 011389B613;
        Tue,  3 Nov 2020 16:33:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7A5EA9B612;
        Tue,  3 Nov 2020 16:33:28 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 01/11] docs: new capability to advertise trace2 SIDs
References: <cover.1604006121.git.steadmon@google.com>
        <cover.1604355792.git.steadmon@google.com>
        <d04028c3c7574e3ca0f9c1b3d711192ca756158d.1604355792.git.steadmon@google.com>
Date:   Tue, 03 Nov 2020 13:33:27 -0800
In-Reply-To: <d04028c3c7574e3ca0f9c1b3d711192ca756158d.1604355792.git.steadmon@google.com>
        (Josh Steadmon's message of "Mon, 2 Nov 2020 14:30:59 -0800")
Message-ID: <xmqq5z6mqg60.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3660E6F6-1E1C-11EB-8A87-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> +trace2-sid=<session-id>
> +-----------------------
> +
> +If trace2 tracing is enabled on the server, it may advertise its session ID via
> +this capability. The client may choose to log the server's session ID in its
> +trace logs, and advertise its own session ID back to the server for it to log
> +as well. This allows for easier debugging of remote sessions when both client
> +and server logs are available.
> diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
> index e597b74da3..a5b9ef04f6 100644
> --- a/Documentation/technical/protocol-v2.txt
> +++ b/Documentation/technical/protocol-v2.txt
> @@ -492,3 +492,12 @@ form `object-format=X`) to notify the client that the server is able to deal
>  with objects using hash algorithm X.  If not specified, the server is assumed to
>  only handle SHA-1.  If the client would like to use a hash algorithm other than
>  SHA-1, it should specify its object-format string.
> +
> +trace2-sid=<session-id>
> +~~~~~~~~~~~~~~~~~~~~~~~
> +
> +If trace2 tracing is enabled on the server, it may advertise its session ID via
> +this capability. The client may choose to log the server's session ID in its
> +trace logs, and advertise its own session ID back to the server for it to log
> +as well. This allows for easier debugging of remote sessions when both client
> +and server logs are available.

Have we documented what a session-id should look like anywhere in
the documentation?  This document is to help third-party to write
implementations of the protocol, but the above description leaves
things "implementation defined" a bit too much, I am afraid.

For example, as this must fit on a single pkt-line as an advertised
capability, there would be some length limit.  Are there other
inherent limitations due to our protocol?  Are there some artificial
limitations that we may want to impose to make it easier to harden
implementations against common mistakes?  For example are bytes in
<session-id> allowed to contain LF, CR, NUL, etc.?
