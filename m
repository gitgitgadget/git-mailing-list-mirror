Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4846BC433B4
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 13:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00CF361184
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 13:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244030AbhDPNdj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Apr 2021 09:33:39 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61342 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244015AbhDPNdi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Apr 2021 09:33:38 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 872D1129716;
        Fri, 16 Apr 2021 09:33:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kl3XaRdnQIbVMsoBdNr3CnTKIYk=; b=VlQxVe
        Mg9vSuwJUho8pC/Ej1XEhM9NkwD4SUtQrgbEZmyqVRxZi7T6gpJVKmq3MZVjMKoL
        i6H6jS6mQ0NAomZB+cHVxfh64M8tKuYNBHbTqnmFGXBr/MQfC8SwD7F8g3Pz6pzf
        ZsvByeC1SY64WMtIYsjdxC+tQ8MNjPmTBeL8A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YPWLGy1Our4ixNqgu0MCzWadXq9PjQoB
        jsypnJ0xzSCtxE+aU+s4ruTOcK5ieImUz7S4v0uXF7LKb6TxGoHmg7vMjowrubgt
        4WfxsNiiqE1tnyi5/qBsw7OitePpyjzdrRnLxpHK7iBJriREy4SC4v7kaEj6WQ61
        /5RLrxP0cTM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7FA3A129715;
        Fri, 16 Apr 2021 09:33:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BF807129714;
        Fri, 16 Apr 2021 09:33:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2021, #04; Thu, 15)
References: <xmqqa6pznlgq.fsf@gitster.g>
        <YHj9mUzs+jlgNuVE@coredump.intra.peff.net>
        <nycvar.QRO.7.76.6.2104161320250.52@tvgsbejvaqbjf.bet>
Date:   Fri, 16 Apr 2021 06:33:07 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2104161320250.52@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 16 Apr 2021 13:21:01 +0200 (CEST)")
Message-ID: <xmqq5z0mnylo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 48D4A684-9EB8-11EB-B970-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Seems that this fixes it for me:

I can see that we avoid passing X_OK to _waccess() for normal paths
(outside the post context of this hunk).  Hence, it is consistent to
answer "yes" if somebody ever asks if NUL (/dev/null) is executable.

IOW, unconditional return of 0 this patch adds is the right thing to
do.

Thanks for a quick turnaround.


> -- snipsnap --
> From 754593d6bda3754ab4afaa98b814351e922a1fe3 Mon Sep 17 00:00:00 2001
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> Date: Fri, 16 Apr 2021 13:11:05 +0200
> Subject: [PATCH] msvc: avoid calling `access("NUL", flags)`
>
> Apparently this is not supported with Microsoft's Universal C Runtime.
> So let's not actually do that.
>
> Instead, just return success because we _know_ that we expect the `NUL`
> device to be present.
>
> Side note: it is possible to turn off the "Null device driver" and
> thereby disable `NUL`. Too many things are broken if this driver is
> disabled, therefore it is not worth bothering to try to detect its
> presence when `access()` is called.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  compat/mingw.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/compat/mingw.c b/compat/mingw.c
> index a43599841c6c..aa647b367b0f 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -685,6 +685,8 @@ ssize_t mingw_write(int fd, const void *buf, size_t len)
>  int mingw_access(const char *filename, int mode)
>  {
>  	wchar_t wfilename[MAX_PATH];
> +	if (!strcmp("nul", filename) || !strcmp("/dev/null", filename))
> +		return 0;
>  	if (xutftowcs_path(wfilename, filename) < 0)
>  		return -1;
>  	/* X_OK is not supported by the MSVCRT version */
> --
> 2.31.1.windows.1
