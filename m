Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6330C433E7
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 20:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 819FB208D5
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 20:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NGXzt+If"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbgJMUqL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Oct 2020 16:46:11 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52645 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727498AbgJMUqL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Oct 2020 16:46:11 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E6BC47405C;
        Tue, 13 Oct 2020 16:46:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=y5CdDWKkqun9KZlU/qIlhTAaG30=; b=NGXzt+
        IfpUEFI7oCUOJf2fLdUu934d+4Sr0a//E9TQvPMFncHAfn8fiGX/FEj6kp6YDx2I
        a9Tvv0zE3/+F7ySKtOJc0yJIoLqQiz5Cjm+0LK9+zgEoNnKDb3Do2DivRXEUUlK2
        RWDEwcYe4J4OFcEFxlqrdsJZ5o5U6m+Ns2g1k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ql+E0fxiDuh+Kf+H8Gdk5vd6y/yuHhQl
        cnIzncH5I8C+G3cTsaK/OjkwcD0SDRC5CkQKQKm/AavRB7ZAuZIgLUUdVnOMISLe
        jwl3uRFCHnbXmW1MOwyw+3jjlDNTaYYM+CouT09OqBj15OB2H+8CNkhcqkDSV1Hd
        mZi+vBq5mJs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DB4777405A;
        Tue, 13 Oct 2020 16:46:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 46A3574056;
        Tue, 13 Oct 2020 16:46:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sean McAllister <smcallis@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, masayasuzuki@google.com,
        jrnieder@gmail.com
Subject: Re: [PATCH v2 2/3] replace CURLOPT_FILE With CURLOPT_WRITEDATA
References: <20201013191729.2524700-1-smcallis@google.com>
        <20201013191729.2524700-2-smcallis@google.com>
Date:   Tue, 13 Oct 2020 13:46:07 -0700
In-Reply-To: <20201013191729.2524700-2-smcallis@google.com> (Sean McAllister's
        message of "Tue, 13 Oct 2020 13:17:28 -0600")
Message-ID: <xmqq7drtkg6o.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1ED22B90-0D95-11EB-95E3-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sean McAllister <smcallis@google.com> writes:

> CURLOPT_FILE has been deprecated since 2003.

I thought that Dscho already mention this, but updating the above
description to mention that _WRITEDATA was introduce to overtake
_FILE as an equivalent in the same timeframe would be more helpful
to readers.


> Signed-off-by: Sean McAllister <smcallis@google.com>
> ---
>  http-push.c   | 6 +++---
>  http-walker.c | 2 +-
>  http.c        | 6 +++---
>  remote-curl.c | 4 ++--
>  4 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/http-push.c b/http-push.c
> index 6a4a43e07f..2e6fee3305 100644
> --- a/http-push.c
> +++ b/http-push.c
> @@ -894,7 +894,7 @@ static struct remote_lock *lock_remote(const char *path, long timeout)
>  	slot->results = &results;
>  	curl_setup_http(slot->curl, url, DAV_LOCK, &out_buffer, fwrite_buffer);
>  	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, dav_headers);
> -	curl_easy_setopt(slot->curl, CURLOPT_FILE, &in_buffer);
> +	curl_easy_setopt(slot->curl, CURLOPT_WRITEDATA, &in_buffer);
>   ...
