Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B70E61FADF
	for <e@80x24.org>; Mon,  8 Jan 2018 23:27:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933703AbeAHX1A (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 18:27:00 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55590 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933648AbeAHX07 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 18:26:59 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E5D89D7939;
        Mon,  8 Jan 2018 18:26:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=edwMFW4jfXJrDedUVyBVaDmAfH4=; b=TF6S4e
        Ct4bjhA11RfJSCdMQMPuZZZMnmXp1wVkFEFBjcrk9O9tBIyPOVCN+VstVYLgPViQ
        xQtv8TmUMGYLmprBm2wYbQXOkbSrWLRUBnmlvuYf13pt3C0ZQM4hUkvszA7gl1m8
        RAwdfh9+tZbtRhKRn/Vn5oettSGFyWBLZYRsI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Y1a24JKbXcu5lpgLajFeSlFw56qCsr9J
        q+OkrZ7his5D+AbNvzpHVpHjLmtgIobhKAJg5fdfNuAVyQJ7Sj/5xPu21JJHXmMt
        LfayHIU7kGZRNqFGJXTIV0eUmkZEeKzFDAObD4LNxf8WE5NvOWQh7+9wSMbQ4C7f
        u7BTdGu1n2I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DD39BD7938;
        Mon,  8 Jan 2018 18:26:58 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 275B6D7937;
        Mon,  8 Jan 2018 18:26:58 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH] oidset: don't return value from oidset_init
References: <20180107230404.23289-1-t.gummerer@gmail.com>
Date:   Mon, 08 Jan 2018 15:26:56 -0800
In-Reply-To: <20180107230404.23289-1-t.gummerer@gmail.com> (Thomas Gummerer's
        message of "Sun, 7 Jan 2018 23:04:04 +0000")
Message-ID: <xmqqincc6if3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6BC5B8D0-F4CB-11E7-B15B-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> c3a9ad3117 ("oidset: add iterator methods to oidset", 2017-11-21)
> introduced a 'oidset_init()' function in oidset.h, which has void as
> return type, but returns an expression.
> ...
> diff --git a/oidset.h b/oidset.h
> index 783abceccd..40ec5f87fe 100644
> --- a/oidset.h
> +++ b/oidset.h
> @@ -27,7 +27,7 @@ struct oidset {
>  
>  static inline void oidset_init(struct oidset *set, size_t initial_size)
>  {
> -	return oidmap_init(&set->map, initial_size);
> +	oidmap_init(&set->map, initial_size);
>  }

Makes sense.  Perhaps "inline" hids this from error-checking
compilers, I wonder?

