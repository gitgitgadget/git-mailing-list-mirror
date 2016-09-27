Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93353209A6
	for <e@80x24.org>; Tue, 27 Sep 2016 20:28:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933955AbcI0U2U (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 16:28:20 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55395 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932573AbcI0U2T (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 16:28:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C81353EED2;
        Tue, 27 Sep 2016 16:28:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=0bNKQOL7QdRN
        wSm6bV5LMpzkuEY=; b=TidqAeX3G7NeEbuJaG9iVTEVlx7DVLMMgiEDCXmBf8mW
        y2pb01I++d/XYzBCxX3DCQ1pLCRf7/0SN8mivulJ3kC2/3a+kAK/8+rB5LmDROr+
        uGHpegyIwwckT6ynNqLoKIcroBSLCRnWJ3EeIhH0SlR+jSQMo4OloJDBgrMziBs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=uquySV
        svA1hvd71FWhlZhjCJPHhgTwd9t6N1iTRPnao6Xw7PC4iuDtfbLeK7Vj5MU1sZEL
        mFXkBCzS29jPOrocxEnZu3migfHFzO4kjxpPHi+hsJ2ZxRY/ApqYWPAiHQQUD5ev
        1Z8rPP2rHKCLXtA3AjMKQMtInQu48zYxdTYNo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C03453EED1;
        Tue, 27 Sep 2016 16:28:16 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3138C3EE89;
        Tue, 27 Sep 2016 16:28:14 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] use strbuf_add_unique_abbrev() for adding short hashes, part 2
References: <b7a61c78-3c46-375c-4cc3-7c363e551bc6@web.de>
        <29e75b7b-6dd0-8c52-e444-cad1ba613cd0@web.de>
Date:   Tue, 27 Sep 2016 13:28:11 -0700
In-Reply-To: <29e75b7b-6dd0-8c52-e444-cad1ba613cd0@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Tue, 27 Sep 2016 21:11:58 +0200")
Message-ID: <xmqqshslm6jo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: EA7DB778-84F0-11E6-A52E-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> diff --git a/diff.c b/diff.c
> index a178ed3..be11e4e 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -3109,7 +3109,7 @@ static void fill_metainfo(struct strbuf *msg,
>  		}
>  		strbuf_addf(msg, "%s%sindex %s..", line_prefix, set,
>  			    find_unique_abbrev(one->oid.hash, abbrev));
> -		strbuf_addstr(msg, find_unique_abbrev(two->oid.hash, abbrev));
> +		strbuf_add_unique_abbrev(msg, two->oid.hash, abbrev);

OK.

> diff --git a/submodule.c b/submodule.c
> index dcc5ce3..8cf40ea 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -396,7 +396,7 @@ static void show_submodule_header(FILE *f, const ch=
ar *path,
>  			find_unique_abbrev(one->hash, DEFAULT_ABBREV));
>  	if (!fast_backward && !fast_forward)
>  		strbuf_addch(&sb, '.');
> -	strbuf_addstr(&sb, find_unique_abbrev(two->hash, DEFAULT_ABBREV));
> +	strbuf_add_unique_abbrev(&sb->hash, two, DEFAULT_ABBREV);

I wonder how could this change come out of this definition:

    @@
    expression E1, E2, E3;
    @@
    - strbuf_addstr(E1, find_unique_abbrev(E2, E3));
    + strbuf_add_unique_abbrev(E1, E2, E3);

