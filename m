Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A017A1FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 21:57:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932231AbcLSV5c (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 16:57:32 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62131 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752786AbcLSV5c (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 16:57:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3C2B35871C;
        Mon, 19 Dec 2016 16:57:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ExNP4AcVX9d4TS6QZg5yNdnLZ6M=; b=E18T33
        eg8skrDtgBehplNl4xd8Rs+BZriDd5LUDzUc1gnvLnURfJF0RBvtsAU7TDYliOg0
        qDoHmOcodbLtVjvBUjHrhg97pEBberHv6fWULe+SfMgKWu3ohQSRp7PT2lpuk0Pa
        BrXV+W1WlIRnx+MDx8rR/8Iez1u3J86qNZqx4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SXn8dUj5/KxyszeDtCO6Oj1OxWOawgZJ
        kvUunJPCItlnw0SzVe7K8wHL4yY7Oou9tXFR9tRFzGvIT4iLHFkyHdn4mYr/87bI
        V3HMQihX3s3PGoA+w47htOny30vqr5+ox31p4TFSVWVE0tMRQEM7aA8PHWTVBbwZ
        B7dtPj7EHgo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 34DC35871B;
        Mon, 19 Dec 2016 16:57:31 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B01B45871A;
        Mon, 19 Dec 2016 16:57:30 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Max Kirillov <max@max630.net>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Karsten Blees <blees@dcon.de>, git@vger.kernel.org,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] mingw: consider that UNICODE_STRING::Length counts bytes
References: <1482183120-21592-1-git-send-email-max@max630.net>
Date:   Mon, 19 Dec 2016 13:57:29 -0800
In-Reply-To: <1482183120-21592-1-git-send-email-max@max630.net> (Max
        Kirillov's message of "Mon, 19 Dec 2016 23:32:00 +0200")
Message-ID: <xmqqtw9zmvjq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 237E6ED8-C636-11E6-944B-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Max Kirillov <max@max630.net> writes:

> UNICODE_STRING::Length field means size of buffer in bytes[1], despite of buffer
> itself being array of wchar_t. Because of that terminating zero is placed twice
> as far. Fix it.
>
> [1] https://msdn.microsoft.com/en-us/library/windows/desktop/aa380518.aspx
>
> Signed-off-by: Max Kirillov <max@max630.net>
> ---

Max, I see this is a resend from a few days ago.  I suspect that we
are in a slow season, so there may be longer delay until we see
responses to a patch.

I will wait until taking any patch to files specific to MS Windows
platform (compat/win*, compat/mingw*, and compat/vcbuild*) without
first seeing it reviewed and acked by either of the two Johannes's
(well, there might be other people in addition to those two, whose
Acked-by/Reviewed-by I should be trusting; if that is the case, it
only shows how unqualified I would be as the first contact to be on
the To: line of such a patch).

I do not mind "see the patch, ping Johanneses as needed, wait and
then apply it to my tree" flow, but I also wonder if the process can
be made more efficient.  Dscho (one of the Johanneses) gets many
patches specific to Windows port via the Git-for-Windows project and
then "upstreams" by forwarding with his sign-off in my direction,
and I do not mind that flow, either.  Whichever one is the most
efficient for all three parties involved is fine by me, but if one
is preferred over the other, perhaps I should write it down in the
"notes from the maintainer" or somewhere?

Dscho, J6t, what do you think?

Thanks.

> Access outside of buffer was very unlikely (for that user needed to redirect
> standard fd to a file with path longer than ~250 symbols), it still did not
> seem to do any harm, and otherwise it did not break because only substring is
> checked, but it was still incorrect.
>  compat/winansi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/compat/winansi.c b/compat/winansi.c
> index 3be60ce..6b4f736 100644
> --- a/compat/winansi.c
> +++ b/compat/winansi.c
> @@ -553,7 +553,7 @@ static void detect_msys_tty(int fd)
>  			buffer, sizeof(buffer) - 2, &result)))
>  		return;
>  	name = nameinfo->Name.Buffer;
> -	name[nameinfo->Name.Length] = 0;
> +	name[nameinfo->Name.Length / sizeof(*name)] = 0;
>  
>  	/* check if this could be a MSYS2 pty pipe ('msys-XXXX-ptyN-XX') */
>  	if (!wcsstr(name, L"msys-") || !wcsstr(name, L"-pty"))
