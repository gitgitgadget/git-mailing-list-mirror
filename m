Return-Path: <SRS0=xHKm=7B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06CFEC433E0
	for <git@archiver.kernel.org>; Tue, 19 May 2020 22:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCB61205CB
	for <git@archiver.kernel.org>; Tue, 19 May 2020 22:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qIIe1kEU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgESWBN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 May 2020 18:01:13 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54337 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbgESWBN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 May 2020 18:01:13 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0EDC96CF51;
        Tue, 19 May 2020 18:01:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MJ6sSkPUqJXhCHkwFTSs5Qfueqw=; b=qIIe1k
        EU04qQEgHF0pYpmy//FbT1aie6rGmHGyeq++VMH33E28+fgo0Po5L4DVDNXGmu5U
        VBoHApIFanDYjQL9BUF7nJM3V99nTIKd9YgWaKr25VEAlCb7qwoDlnI9ln1FVhPy
        I6knkx04RmfnJZcr+5lToKjIxv/T0pLNR1s9c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PB4W1+0GLC9fQnQ0/TTDhStMbzhAGo/6
        gylTdOpqACyI7UMyry8MH2is7ThPH94W9j/82D5Lg+ENZigP6lXBoEGIOWgV5h7o
        hjbo0M8JDrt6xmFrJGKZTzyHXsyPXgk5eVNBPyoECx8DPQjKju0ILJNtQQqqvfwH
        TGOLZCAjPUo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 07A926CF50;
        Tue, 19 May 2020 18:01:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 588946CF4F;
        Tue, 19 May 2020 18:01:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v13 05/13] reftable: clarify how empty tables should be written
References: <pull.539.v12.git.1588845585.gitgitgadget@gmail.com>
        <pull.539.v13.git.1589226388.gitgitgadget@gmail.com>
        <7aa3f92fca0c33eced848d560272d0b948fd5cf3.1589226388.git.gitgitgadget@gmail.com>
Date:   Tue, 19 May 2020 15:01:09 -0700
In-Reply-To: <7aa3f92fca0c33eced848d560272d0b948fd5cf3.1589226388.git.gitgitgadget@gmail.com>
        (Han-Wen Nienhuys via GitGitGadget's message of "Mon, 11 May 2020
        19:46:20 +0000")
Message-ID: <xmqqa723zisa.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3F8686F2-9A1C-11EA-B14B-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> The format allows for some ambiguity, as a lone footer also starts
> with a valid file header. However, the current JGit code will barf on
> this. This commit codifies this behavior into the standard.

Nice to see the documentation being careful.

>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  Documentation/technical/reftable.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/Documentation/technical/reftable.txt b/Documentation/technical/reftable.txt
> index 8bad9ade256..6223538d64e 100644
> --- a/Documentation/technical/reftable.txt
> +++ b/Documentation/technical/reftable.txt
> @@ -715,6 +715,13 @@ version)
>  
>  Once verified, the other fields of the footer can be accessed.
>  
> +Empty tables
> +++++++++++++
> +
> +A reftable may be empty. In this case, the file starts with a header
> +and is immediately followed by a footer.
> +
> +
>  Varint encoding
>  ^^^^^^^^^^^^^^^
