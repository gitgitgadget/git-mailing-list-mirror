Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA0FD20899
	for <e@80x24.org>; Thu, 17 Aug 2017 17:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753439AbdHQRxR (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 13:53:17 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62404 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753189AbdHQRxR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 13:53:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7D5D7A77A1;
        Thu, 17 Aug 2017 13:53:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CcLwfulNEefXx/KzNKdoJcDqE5U=; b=J/6fXx
        iXqJ86zMS1RJKivfy36Kr/efP3jL9EuPphjr14PbEp+XEMTapOsRdiJmZ73ofjax
        AfCr9QOWRT6tsX1nl0gR5zClzuOoGs4Z3+hmeCnKi5L7t7Mfyhx+e482h5z0JFnQ
        XII48xq7/BIY+46iF2ojqIkJD2Tq+ENuuW2tk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pr7z7pQh3ZAFTemBWwyg1lvEgJHFZrCJ
        7Nrr+KFUhL/+LqL97yMl7WCED1QgzOvwv8JKe/ArbiYIBliJbOfkwy/H9YBbG3+y
        zsgSX4frx5PGhOrWNlGn4IOzJbVPtxcAQUKX/k6a+22fAYIjJYtnIFB6MR17X2MQ
        Jkapv1y5pxU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 75321A77A0;
        Thu, 17 Aug 2017 13:53:16 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BFB56A779F;
        Thu, 17 Aug 2017 13:53:15 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin Koegler <martin.koegler@chello.at>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de
Subject: Re: [Patch size_t V3 18/19] Convert tree-walk to size_t
References: <1502914591-26215-1-git-send-email-martin@mail.zuhause>
        <1502914591-26215-19-git-send-email-martin@mail.zuhause>
Date:   Thu, 17 Aug 2017 10:53:14 -0700
In-Reply-To: <1502914591-26215-19-git-send-email-martin@mail.zuhause> (Martin
        Koegler's message of "Wed, 16 Aug 2017 22:16:30 +0200")
Message-ID: <xmqqshgqgjxx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F2066AB6-8374-11E7-AF07-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin Koegler <martin.koegler@chello.at> writes:

> From: Martin Koegler <martin.koegler@chello.at>
>
> Signed-off-by: Martin Koegler <martin.koegler@chello.at>
> ---
>  tree-walk.c | 17 +++++++++--------
>  tree-walk.h |  4 ++--
>  tree.h      |  2 +-
>  3 files changed, 12 insertions(+), 11 deletions(-)

In this one, I did not find anything suspicious.

> diff --git a/tree-walk.c b/tree-walk.c
> index 7c9f9e3..a7d8b2a 100644
> --- a/tree-walk.c
> +++ b/tree-walk.c
> @@ -22,10 +22,11 @@ static const char *get_mode(const char *str, unsigned int *modep)
>  	return str;
>  }
>  
> -static int decode_tree_entry(struct tree_desc *desc, const char *buf, unsigned long size, struct strbuf *err)
> +static int decode_tree_entry(struct tree_desc *desc, const char *buf, size_t size, struct strbuf *err)
>  {
>  	const char *path;
> -	unsigned int mode, len;
> +	unsigned int mode;
> +	size_t len;
>  
>  	if (size < 23 || buf[size - 21]) {
>  		strbuf_addstr(err, _("too-short tree object"));

The original was especially bad around here, as it didn't even use
ulong.  The conversion makes sense.

Thanks.
