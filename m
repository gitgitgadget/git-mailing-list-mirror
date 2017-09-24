Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D33B320281
	for <e@80x24.org>; Sun, 24 Sep 2017 01:15:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751355AbdIXBPw (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Sep 2017 21:15:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65225 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750839AbdIXBPv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Sep 2017 21:15:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 08F45A1B72;
        Sat, 23 Sep 2017 21:15:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=44sMpmA+SXnBu5sszR+OpHJYh3k=; b=xrWnZC
        2xwFdSs9ZThLOLafXkoNCdZAet+uRBli2NTav/GDDKBy5nuO8WpzUi/zZekm9iBK
        PdjG9KqocgA1ICMA1lnAiXAAboQ+qgYCyiIGRSdlEmO6yOwbrX7CFtATLGjqnY8H
        d+kHtbLA0PYUCqwP3anja/QLIjQdFBuQSN9zI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YHKw519GnrCMjMBABjV/ALYiIbXjrRGT
        9FXYDWuNDyz04MqTcbl3tkzYuV1ksyMJpEmWNRnu1uT1jVe/uVLIPfoQ9sB3xEXv
        FNOlPnWk8RmaBXLuP/AjTMZst8R23T9jEdfE7+O5838yxyNYm5HIFIvl5CXijgo0
        fKBLT3pLZo0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F3DBAA1B71;
        Sat, 23 Sep 2017 21:15:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 63711A1B70;
        Sat, 23 Sep 2017 21:15:50 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ilya Kantor <iliakan@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] userdiff: fix HTML hunk header regexp
References: <CAFU8umjZL0nXUFbuZWVapTaCfAjtAoTT=G3GCKczDE7O8bzAOw@mail.gmail.com>
Date:   Sun, 24 Sep 2017 10:15:49 +0900
In-Reply-To: <CAFU8umjZL0nXUFbuZWVapTaCfAjtAoTT=G3GCKczDE7O8bzAOw@mail.gmail.com>
        (Ilya Kantor's message of "Sat, 23 Sep 2017 10:53:47 +0300")
Message-ID: <xmqqa81kj3qy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E7180F9C-A0C5-11E7-8412-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ilya Kantor <iliakan@gmail.com> writes:

> Current HTML header regexp doesn't match headers without attributes.
>
> So it fails to match <h1>...</h1>, while <h1 class="smth">...</h1> matches.
> The fix makes attributes optional.
> The regexp is still far from perfect, but now it at least handles the
> common case.
>
> Signed-off-by: Ilya Kantor <iliakan@gmail.com>
> ---
>  userdiff.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/userdiff.c b/userdiff.c
> index 6321103ce..dbfb4e13c 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -38,7 +38,7 @@ IPATTERN("fortran",
>   "|//|\\*\\*|::|[/<>=]="),
>  IPATTERN("fountain", "^((\\.[^.]|(int|ext|est|int\\.?/ext|i/e)[. ]).*)$",
>   "[^ \t-]+"),
> -PATTERNS("html", "^[ \t]*(<[Hh][1-6][ \t].*>.*)$",
> +PATTERNS("html", "^[ \t]*(<[Hh][1-6]([ \t].*)?>.*)$",
>   "[^<>= \t]+"),


What you sent seems to be whitespace damaged, but it was small
enough for me to tweak it to apply ;-)

Will queue.  Thanks.

