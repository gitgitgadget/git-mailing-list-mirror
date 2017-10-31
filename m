Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C2BA20437
	for <e@80x24.org>; Tue, 31 Oct 2017 01:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752264AbdJaBmf (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 21:42:35 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52984 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752132AbdJaBme (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 21:42:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A0E9EA851B;
        Mon, 30 Oct 2017 21:42:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ayN/Pc11y3sjpPqK7DhluCtY31c=; b=qLNaZs
        WIynnbsRimmMNEcSw4H3WgCHpTN5FSxgSfqbKUQa0DuTWtjCIkP6y4tLmHLo05gh
        7xCthtlk5PMJwL/lXFsOBYlvY2I53e2lkDKYVp5gnjC3o5Y/MKmzy/nXKk25atc4
        bxOjGzospog0hIIwnt3twK1fFHMKK5D4A9fwg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=P5/rRPLhDXXM5kKeU6AG83Zp7OYvqfQS
        u01HhBJB6ihSE+DUXgYSgeimBsSYlMt1FCSOkrCLpg8tFA1fEA89rg2S8kAaaCw9
        UKEJZqs1gXtxJknmZo4wA3qetzDvh2+ZGzPQ3ty/3zysiH680eY3WBg8m2AmjbJL
        hn9RWw7VaHY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 97FC3A851A;
        Mon, 30 Oct 2017 21:42:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E4979A8519;
        Mon, 30 Oct 2017 21:42:32 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andrey Okoshkin <a.okoshkin@samsung.com>
Cc:     Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        vmiklos@frugalware.org
Subject: Re: [PATCH v4] merge-recursive: check GIT_MERGE_VERBOSITY only once
References: <CGME20171024152727epcas2p4fb7dcf147e44aadf7733098151d469a5@epcas2p4.samsung.com>
        <3aed764b-388c-d163-08fc-32b294c6b9d3@samsung.com>
        <CAGZ79kaSZG9WriqX0SLbTnEDRr-4YdFRuK17+9wnxyrftfnMmg@mail.gmail.com>
        <CAPig+cRTL2amjsgdp1=T3GMZLa=favugOfnQw9XjWzC+U=v5Sw@mail.gmail.com>
        <CAN0heSp7b_6n3y=s4++oWhkPUuM=s9L7LWVx5vn8o=5aH6DKKw@mail.gmail.com>
        <20171024195221.gqgtibwjaztgeel6@sigill.intra.peff.net>
        <xmqq8tg0j8vb.fsf@gitster.mtv.corp.google.com>
        <CAPig+cSjQd=p1CdizU5oUaz91z=j02UnWLtTguWzvkjS+v6ETA@mail.gmail.com>
        <20171025072717.7svdq4kqlfxlwszi@sigill.intra.peff.net>
        <38a80069-abdb-0646-a20c-eca39dd4f519@samsung.com>
        <CAPig+cRq1AEOgDoXeH-hDMvhEMnfiNK5CuSBbbio-mbHros=QQ@mail.gmail.com>
        <bd7eb593-75f9-0dd1-9dff-9dc420532217@samsung.com>
        <CAGZ79kZ9EV=qaYyuA3kfuQ04EhLWax52MhtkmGJto2Lommc_SQ@mail.gmail.com>
        <2b507ce0-0d18-d9d6-11ba-6fb0d4f4a473@samsung.com>
Date:   Tue, 31 Oct 2017 10:42:31 +0900
In-Reply-To: <2b507ce0-0d18-d9d6-11ba-6fb0d4f4a473@samsung.com> (Andrey
        Okoshkin's message of "Mon, 30 Oct 2017 10:42:33 +0300")
Message-ID: <xmqqd1543xfc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C399D6A2-BDDC-11E7-9B71-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andrey Okoshkin <a.okoshkin@samsung.com> writes:

> Get 'GIT_MERGE_VERBOSITY' environment variable only once in
> init_merge_options() and store the pointer to its value for the further check.

OK, that is "what this thing does" description.

> No intervening calls to getenv(), putenv(), setenv() or unsetenv() are done
> between the initial getenv() call and the consequential result pass to strtol()
> as these environment related functions could modify the string pointer returned
> by the initial getenv() call.

That holds true for the code before or after this patch equally.  In
other words, that sounds like a justification for rejecting this
patch (i.e. explanation of why this change is not needed).

If we are worried about another thread calling these functions after
the time we call getenv() and before the time we pass the result to
strtol(), then I do not think this patch gives a better protection
against such race, so I do not think that is why you are doing this.

So... why do we want to do this change?  I am puzzled.


>
> Signed-off-by: Andrey Okoshkin <a.okoshkin@samsung.com>
> Reviewed-by: Stefan Beller <sbeller@google.com>
> ---
> Added 'reviewed-by' field.
>  merge-recursive.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index 1494ffdb8..60084e3a0 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -2163,6 +2163,7 @@ static void merge_recursive_config(struct merge_options *o)
>  
>  void init_merge_options(struct merge_options *o)
>  {
> +	const char *merge_verbosity;
>  	memset(o, 0, sizeof(struct merge_options));
>  	o->verbosity = 2;
>  	o->buffer_output = 1;
> @@ -2171,9 +2172,9 @@ void init_merge_options(struct merge_options *o)
>  	o->renormalize = 0;
>  	o->detect_rename = 1;
>  	merge_recursive_config(o);
> -	if (getenv("GIT_MERGE_VERBOSITY"))
> -		o->verbosity =
> -			strtol(getenv("GIT_MERGE_VERBOSITY"), NULL, 10);
> +	merge_verbosity = getenv("GIT_MERGE_VERBOSITY");
> +	if (merge_verbosity)
> +		o->verbosity = strtol(merge_verbosity, NULL, 10);
>  	if (o->verbosity >= 5)
>  		o->buffer_output = 0;
>  	strbuf_init(&o->obuf, 0);
