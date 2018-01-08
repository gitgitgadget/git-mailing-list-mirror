Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D24881FADF
	for <e@80x24.org>; Mon,  8 Jan 2018 22:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757875AbeAHWPt (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 17:15:49 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56062 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757064AbeAHWPt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 17:15:49 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AD9C9B837A;
        Mon,  8 Jan 2018 17:15:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=BMeUaT1Z+6X2
        p/hf/4GAwvsDSN8=; b=NpWdmc6KGJ9WLMG+zTAEJzV5pYA3IRkWRVRYlc03cD6H
        O79jetllupZDwDq+uVkn8iJiIhcTt8KIVz9eddzMfUw1syHpepvmpwr8wn/76sjJ
        Z4NTdd9y/LEG53kgfEsck+WUk7gJDR2hh7nJiEg7pWPhn1FOi/M13sLubUvIwgU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=b/6H87
        XFUfVx2BpxRXzOwSo0wknU6lRDHICmXLD18yDPEcXW6o6ThCNl1Vqy1xARiExrS2
        Iva4fpM6FZD53PznijUE9wJqS6Qmdu+FVkLOqLLCi3iZAu7kq6a1OoDImco5lOCy
        ksDVDxpJYiPzgDdx+ybnOV7O/ynM/WXJQkF10=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A5FB5B8379;
        Mon,  8 Jan 2018 17:15:48 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 25AF6B8378;
        Mon,  8 Jan 2018 17:15:48 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] bisect: avoid NULL pointer dereference
References: <07a8cdae-8f8c-8560-c450-c6089a942c96@web.de>
Date:   Mon, 08 Jan 2018 14:15:46 -0800
In-Reply-To: <07a8cdae-8f8c-8560-c450-c6089a942c96@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Mon, 8 Jan 2018 21:36:55 +0100")
Message-ID: <xmqqr2r06lpp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7AA680E6-F4C1-11E7-80C9-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> 7c117184d7 (bisect: fix off-by-one error in `best_bisection_sorted()`)
> fixed an off-by-one error, plugged a memory leak and removed a NULL
> check.  However, the pointer p *is* actually NULL if an empty list is
> passed to the function.  Let's add the check back for safety.  Bisectin=
g
> nothing doesn't make too much sense, but that's no excuse for crashing.
>
> Found with GCC's -Wnull-dereference.
>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---

Thanks.  I think this is the same as 2e9fdc79 ("bisect: fix a
regression causing a segfault", 2018-01-03) but the log we see here
explains what goes wrong much better than the other one ;-)

>  bisect.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/bisect.c b/bisect.c
> index 0fca17c02b..2f3008b078 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -229,8 +229,10 @@ static struct commit_list *best_bisection_sorted(s=
truct commit_list *list, int n
>  		if (i < cnt - 1)
>  			p =3D p->next;
>  	}
> -	free_commit_list(p->next);
> -	p->next =3D NULL;
> +	if (p) {
> +		free_commit_list(p->next);
> +		p->next =3D NULL;
> +	}
>  	strbuf_release(&buf);
>  	free(array);
>  	return list;
