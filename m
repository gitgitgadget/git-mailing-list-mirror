Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AF981F4BD
	for <e@80x24.org>; Wed,  2 Oct 2019 02:10:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729779AbfJBCKN (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Oct 2019 22:10:13 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56672 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbfJBCKM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Oct 2019 22:10:12 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 836173257B;
        Tue,  1 Oct 2019 22:10:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=teTll8Pw5fPBf4/fqgxtI137YQg=; b=hC+Sl3
        Qsps7zzCDu6kto5v/BBQBatP8ufEaYgl6E9Ybn/DajmJM/gSZLNwB/Yr+YRWVlQr
        b+xx5duGCdAaGD0BYtTxzaLrj4CZNWQwvYVvHfXvssmjosWC6WovAM7gmWWsbpbz
        nuLsiMESnLnPApzrtHmTJiVp/p6YJoVg01r1o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wtDLqjGgnbvxLuaxwMBYLas6EBfbn442
        pK8KjbQtKsns8IewoJNphKy8GwvAJGJENZ3OseByVryHqJuQEfGbPJt6cZiYSFnP
        yj9B5MCxzTGlz21cjMHAJIOLdK5c4N1JE4X9wVD7kwuasy0OUKtjeICjAema36UN
        SVP7TivIggU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 637A23257A;
        Tue,  1 Oct 2019 22:10:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D30D232575;
        Tue,  1 Oct 2019 22:10:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v1 1/5] sequencer: update `total_nr' when adding an item to a todo list
References: <20190925201315.19722-1-alban.gruin@gmail.com>
        <20190925201315.19722-2-alban.gruin@gmail.com>
Date:   Wed, 02 Oct 2019 11:10:07 +0900
In-Reply-To: <20190925201315.19722-2-alban.gruin@gmail.com> (Alban Gruin's
        message of "Wed, 25 Sep 2019 22:13:11 +0200")
Message-ID: <xmqqbluzhp8g.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C2258E6E-E4B9-11E9-9045-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

> `total_nr' is the total amount of items, done and toto, that are in a
> todo list.  But unlike `nr', it was not updated when an item was
> appended to the list.

s/amount/number/, as amount is specifically for something
that cannot be counted.

Perhaps a stupid language question but what is "toto"?


> This variable is mostly used by command prompts (ie. git-prompt.sh and
> the like).
>
> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> ---
>  sequencer.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/sequencer.c b/sequencer.c
> index d648aaf416..575b852a5a 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2070,6 +2070,7 @@ void todo_list_release(struct todo_list *todo_list)
>  static struct todo_item *append_new_todo(struct todo_list *todo_list)
>  {
>  	ALLOC_GROW(todo_list->items, todo_list->nr + 1, todo_list->alloc);
> +	todo_list->total_nr++;
>  	return todo_list->items + todo_list->nr++;
>  }
