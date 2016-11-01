Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A8A720229
	for <e@80x24.org>; Tue,  1 Nov 2016 20:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752116AbcKAUcv (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Nov 2016 16:32:51 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59038 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750889AbcKAUcu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2016 16:32:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1347349D75;
        Tue,  1 Nov 2016 16:32:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4mWikOpSId+jnyjRh/Do7pIi3Wo=; b=slaHsV
        YXEM7dkWdtJrzkZ2oe2cPtkIcazOHyTphdQHvNxznqfdnciZk4FhnM1GjHMGqids
        F06e+vaSDevqb8tbFY8bbWKxIP6a59uAk/DrYP4s49wiZmLrZwD+MLXOf+XC1yew
        bXEpJiSZ14bm8EPX8Bv9UQJGzxuXskf9YozyE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rE/vs3B1Svbwl43NUBh3kno6K3E/BOts
        IF6nYlFXJ7kTlR6fnaGoW4zayyN2oMO0jYzjOd5QCSv6ZerKGoSRJ6zBD+wYT8bB
        C4cCH9WIudqXHRPmxyuhlSyrRLuac2MhpDsvWxLkLYnIj+HCzv/RGwaOvKEcFrM7
        n1ER68VTmPc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0898B49D73;
        Tue,  1 Nov 2016 16:32:49 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7D7F349D72;
        Tue,  1 Nov 2016 16:32:48 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com
Subject: Re: [PATCH v2 1/5] trailer: be stricter in parsing separators
References: <cover.1478028700.git.jonathantanmy@google.com>
        <cover.1477698917.git.jonathantanmy@google.com>
        <cover.1478028700.git.jonathantanmy@google.com>
        <c7db0aafb543845382e1835e3704273d3596e6bb.1478028700.git.jonathantanmy@google.com>
Date:   Tue, 01 Nov 2016 13:32:47 -0700
In-Reply-To: <c7db0aafb543845382e1835e3704273d3596e6bb.1478028700.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Tue, 1 Nov 2016 13:08:21 -0700")
Message-ID: <xmqqvaw7ndow.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5A6E915A-A072-11E6-8666-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Currently, a line is interpreted to be a trailer line if it contains a
> separator. Make parsing stricter by requiring the text on the left of
> the separator, if not the empty string, to be of the "<token><optional
> whitespace>" form.

Hmph.  The optional whitespace is to allow for what kind of line?

It is not for "Signed off by:" that is a misspelt "Signed-off-by:";
it may not hurt but I do not think of a case that would be useful
offhand.




> (The find_separator function distinguishes the no-separator case from
> the separator-starts-line case because some callers of this function
> need such a distinction.)
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  trailer.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
>
> diff --git a/trailer.c b/trailer.c
> index f0ecde2..0ee634f 100644
> --- a/trailer.c
> +++ b/trailer.c
> @@ -563,15 +563,26 @@ static int token_matches_item(const char *tok, struct arg_item *item, int tok_le
>  }
>  
>  /*
> - * Return the location of the first separator in line, or -1 if there is no
> - * separator.
> + * If the given line is of the form 
> + * "<token><optional whitespace><separator>..." or "<separator>...", return the
> + * location of the separator. Otherwise, return -1.
>   */
>  static int find_separator(const char *line, const char *separators)
>  {
> -	int loc = strcspn(line, separators);
> -	if (!line[loc])
> -		return -1;
> -	return loc;
> +	int whitespace_found = 0;
> +	const char *c;
> +	for (c = line; *c; c++) {
> +		if (strchr(separators, *c))
> +			return c - line;
> +		if (!whitespace_found && (isalnum(*c) || *c == '-'))
> +			continue;
> +		if (c != line && (*c == ' ' || *c == '\t')) {
> +			whitespace_found = 1;
> +			continue;
> +		}
> +		break;
> +	}
> +	return -1;
>  }
>  
>  /*
