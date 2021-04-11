Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18DA9C43460
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 11:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A43C4610CB
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 11:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235427AbhDKLn1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Apr 2021 07:43:27 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:65481 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235095AbhDKLn1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Apr 2021 07:43:27 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D91F9124686;
        Sun, 11 Apr 2021 07:43:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=bb1yAAbD/EUxNXTZmFynQXDKj6U=; b=Ba6USf9cTPoj++ZepL9T
        SranO+/5NQFWvDEuFjCHQOYXhrKQIP6WzqzMW+U8NqkUI7LLB5Da1xfDYLCwy80g
        STJWzL2Fs9xcwirZGLbEfgUhmJm9f3Jwh2bLnM7hO+8nW+alAmqU2xg1H0+N+LfB
        hixZgDsxMFCIBEbsu1AAlZ4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=kX06Aq+9X9B6LgNvO6VG2YC4S9eOU8OgbP2JMW732HyKA9
        MlJQFKtJ4yb4BBXXNclLDxF3urbzRsqCmGAqeAh+YibvhxnIYg/Vu8AKYAjnzxJC
        2eXHzDAU4/ooaUdxC5NdLP46k5ir6dYSs32eS1OWD2BIzJLldO6ah25nqQPIU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D1EB9124684;
        Sun, 11 Apr 2021 07:43:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0B88E124683;
        Sun, 11 Apr 2021 07:43:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Andrzej Hunt <andrzej@ahunt.org>,
        Andrzej Hunt <ajrhunt@google.com>
Subject: Re: [PATCH 09/12] mailinfo: also free strbuf lists when clearing
 mailinfo
References: <pull.929.git.1617994052.gitgitgadget@gmail.com>
        <130ef89218a47adc7ee558e75672e0e4eb5f30ca.1617994052.git.gitgitgadget@gmail.com>
Date:   Sun, 11 Apr 2021 04:43:05 -0700
Message-ID: <xmqq4kgdhws6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 153A2A02-9ABB-11EB-B778-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  void clear_mailinfo(struct mailinfo *mi)
>  {
> -	int i;
> -
>  	strbuf_release(&mi->name);
>  	strbuf_release(&mi->email);
>  	strbuf_release(&mi->charset);
>  	strbuf_release(&mi->inbody_header_accum);
>  	free(mi->message_id);
>  
> -	if (mi->p_hdr_data)
> -		for (i = 0; mi->p_hdr_data[i]; i++)
> -			strbuf_release(mi->p_hdr_data[i]);
> -	free(mi->p_hdr_data);
> -	if (mi->s_hdr_data)
> -		for (i = 0; mi->s_hdr_data[i]; i++)
> -			strbuf_release(mi->s_hdr_data[i]);
> -	free(mi->s_hdr_data);

So, the original allows mi->p_hdr_data to be NULL and does not do
this freeing (the same for the .s_hdr_data member).

> +	strbuf_list_free(mi->p_hdr_data);
> +	strbuf_list_free(mi->s_hdr_data);

Is it safe to feed NULL to the helper?

        void strbuf_list_free(struct strbuf **sbs)
        {
                struct strbuf **s = sbs;

                while (*s) {
                        strbuf_release(*s);
                        free(*s++);
                }
                free(sbs);
        }


