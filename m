Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D1FD1FC3E
	for <e@80x24.org>; Thu, 27 Apr 2017 06:20:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162104AbdD0GUk (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Apr 2017 02:20:40 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:1668 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1162101AbdD0GUf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2017 02:20:35 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3wD6JJ57NFz5tlS;
        Thu, 27 Apr 2017 08:20:32 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 68E0B303E;
        Thu, 27 Apr 2017 08:20:32 +0200 (CEST)
Subject: Re: [PATCH 10/26] Check for EOF while parsing mails
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
References: <cover.1493237937.git.johannes.schindelin@gmx.de>
 <1fb841cee32996ee9194c2bd33b9dfe74cc37726.1493237937.git.johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <6cc5670f-2de3-33f2-3c85-5a6d99fcca12@kdbg.org>
Date:   Thu, 27 Apr 2017 08:20:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <1fb841cee32996ee9194c2bd33b9dfe74cc37726.1493237937.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 26.04.2017 um 22:20 schrieb Johannes Schindelin:
> Reported via Coverity.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/mailsplit.c | 2 +-
>  mailinfo.c          | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/mailsplit.c b/builtin/mailsplit.c
> index 30681681c13..c0d88f97512 100644
> --- a/builtin/mailsplit.c
> +++ b/builtin/mailsplit.c
> @@ -232,7 +232,7 @@ static int split_mbox(const char *file, const char *dir, int allow_bare,
>
>  	do {
>  		peek = fgetc(f);
> -	} while (isspace(peek));
> +	} while (peek >= 0 && isspace(peek));
>  	ungetc(peek, f);
>
>  	if (strbuf_getwholeline(&buf, f, '\n')) {
> diff --git a/mailinfo.c b/mailinfo.c
> index 68037758f2f..60dcad7b714 100644
> --- a/mailinfo.c
> +++ b/mailinfo.c
> @@ -1099,7 +1099,7 @@ int mailinfo(struct mailinfo *mi, const char *msg, const char *patch)
>
>  	do {
>  		peek = fgetc(mi->input);
> -	} while (isspace(peek));
> +	} while (peek >= 0 && isspace(peek));
>  	ungetc(peek, mi->input);
>
>  	/* process the email header */
>

Why? isspace(EOF) is well-defined.

-- Hannes

