Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED3AC433ED
	for <git@archiver.kernel.org>; Sun, 16 May 2021 22:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5328E61073
	for <git@archiver.kernel.org>; Sun, 16 May 2021 22:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbhEPW7D (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 May 2021 18:59:03 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51788 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbhEPW7D (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 May 2021 18:59:03 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EF81A1375B9;
        Sun, 16 May 2021 18:57:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wFQBjjU0xHQD3nczs5Putmy0atuNdWfDvR26BN
        0WKNQ=; b=s2dFJVe94QKZv1y91nJy3NNEu0jO+JUKBK85us9WsMrxeyaPjtgR/s
        ChC1EzoqE41ClsdF1HBUGFs4JX/JWlqJP6628aibLgXAYh42G0ckYkd+ppqR42+Z
        lb6/lg7Fl84dl9meSL95Bw0NRafLEoIP+2yi39NKSbquJF0pNf8lc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E8DB71375B8;
        Sun, 16 May 2021 18:57:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 302041375B7;
        Sun, 16 May 2021 18:57:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     edef <edef@edef.eu>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] mailinfo: don't discard names under 3 characters
References: <20200130100654.GA840101@coredump.intra.peff.net>
        <20210516150719.49710-1-edef@edef.eu>
Date:   Mon, 17 May 2021 07:57:43 +0900
In-Reply-To: <20210516150719.49710-1-edef@edef.eu> (edef@edef.eu's message of
        "Sun, 16 May 2021 15:07:19 +0000")
Message-ID: <xmqq4kf25lso.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 208A5170-B69A-11EB-9998-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

edef <edef@edef.eu> writes:

> I sometimes receive patches from people with short mononyms, and in my
> cultural environment these are not uncommon. To my dismay, git-am
> currently discards their names, and replaces them with their email
> addresses.
>
> Link: https://www.kalzumeus.com/2010/06/17/falsehoods-programmers-believe-about-names/
> Signed-off-by: edef <edef@edef.eu>
> ---
> Rebased and with Signed-off-by this time :)
>
>  mailinfo.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mailinfo.c b/mailinfo.c
> index 95ce191f38..626228654c 100644
> --- a/mailinfo.c
> +++ b/mailinfo.c
> @@ -19,7 +19,7 @@ static void cleanup_space(struct strbuf *sb)
>  static void get_sane_name(struct strbuf *out, struct strbuf *name, struct strbuf *email)
>  {
>  	struct strbuf *src = name;
> -	if (name->len < 3 || 60 < name->len || strpbrk(name->buf, "@<>"))
> +	if (!name->len || 60 < name->len || strpbrk(name->buf, "@<>"))
>  		src = email;
>  	else if (name == out)
>  		return;

Wow.  The original of this was from very late in 2019, wasn't it?

Thanks for updating; will queue.
