Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB65DC433F5
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 15:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C082460720
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 15:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbhJYP5m (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 11:57:42 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61512 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233158AbhJYP5l (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 11:57:41 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F001A169F0B;
        Mon, 25 Oct 2021 11:55:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xFIpWdjZLdB7vlRTbebDVWfZVIr4XPjt7PLdsP
        29SRk=; b=JxCQODUHcPNYW+6bYvidfeDmaHuY6kU3y2aDwAGbOAV/u236ttyZ4Q
        4+TeiFj1luur6CknVNw106IGeg1LP/mAABbKYSegwRLoK8bBWeglT8xGA1OwQEj5
        9E3Uwrp+bNk6jBhNYOTtYRRN8cfAb7bBLaOBObPjegPDOjydLq56s=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E7A50169F0A;
        Mon, 25 Oct 2021 11:55:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5081F169F07;
        Mon, 25 Oct 2021 11:55:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Robin Dupret <robin.dupret@gmail.com>
Cc:     git@vger.kernel.org, Robin Dupret <robin.dupret@hey.com>
Subject: Re: [PATCH] http-backend: remove a duplicated code branch
References: <xmqqbl3u5fhy.fsf@gitster.g>
        <20211024162859.6295-1-robin.dupret@hey.com>
        <20211024162859.6295-2-robin.dupret@hey.com>
Date:   Mon, 25 Oct 2021 08:55:11 -0700
In-Reply-To: <20211024162859.6295-2-robin.dupret@hey.com> (Robin Dupret's
        message of "Sun, 24 Oct 2021 18:28:59 +0200")
Message-ID: <xmqqsfwp2j6o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EFF9C4BE-35AB-11EC-A9AB-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robin Dupret <robin.dupret@gmail.com> writes:

> Try to make reading the computation of the gzipped flag a bit more
> natural.

... and did you succeed? ;-)

We are all imperfect human and anything we do is merely "trying to",
so let's not say "try to", unless the change is so involved that it
is hard to judge if the result has succeeded in trying.

Did you mean to send the same patch text (but with an updated log
message)?  Just making sure.

Thanks; will queue.

> Signed-off-by: Robin Dupret <robin.dupret@hey.com>
> ---
>  http-backend.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/http-backend.c b/http-backend.c
> index e7c0eeab23..3d6e2ff17f 100644
> --- a/http-backend.c
> +++ b/http-backend.c
> @@ -466,9 +466,7 @@ static void run_service(const char **argv, int buffer_input)
>  	struct child_process cld = CHILD_PROCESS_INIT;
>  	ssize_t req_len = get_content_length();
>  
> -	if (encoding && !strcmp(encoding, "gzip"))
> -		gzipped_request = 1;
> -	else if (encoding && !strcmp(encoding, "x-gzip"))
> +	if (encoding && (!strcmp(encoding, "gzip") || !strcmp(encoding, "x-gzip")))
>  		gzipped_request = 1;
>  
>  	if (!user || !*user)
