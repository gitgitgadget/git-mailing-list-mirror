Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4D90207DF
	for <e@80x24.org>; Tue, 13 Sep 2016 00:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752778AbcIMALQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 20:11:16 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53732 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751097AbcIMALQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 20:11:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 385093E035;
        Mon, 12 Sep 2016 20:11:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NhRexMxkxxdcw+i2RrKQgtKMg50=; b=sNtOQs
        BzPPzG2CVSFDh6fNK4Dts4fEq3qvgWRAktKhr5k5IzFCNqhJ8K3bsQ6IQ+mu7xaG
        MU88SiJ93epjVlNl457aokKKYhlDyoclcnTI+lmO7uWa6AlnjKLC+v0m19q5OPs9
        GWTUvDnPr/7NovtDB9T4jUETE/FirLnB3TsOE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rWDH+8N2suS6MHDzq9mufDAC2SAvGdTV
        4cSzaUmFio9rAkBdhrwrn1QoHXprQWs6lClzH7CbKtKr2XI6AsKJUanwFUgftzjc
        M9HP9+6cB1usj1Y+TKNUKsw/t2ShLvv+XKJTowZtf1qVawZ6miPGe+52PaclYlz3
        10Nmh2rSFEQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 285B93E034;
        Mon, 12 Sep 2016 20:11:14 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9DB083E033;
        Mon, 12 Sep 2016 20:11:13 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <stefanbeller@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 06/10] diff.c: emit_line_0 can handle no color
References: <1473572530-25764-1-git-send-email-stefanbeller@gmail.com>
        <1473572530-25764-7-git-send-email-stefanbeller@gmail.com>
Date:   Mon, 12 Sep 2016 17:11:11 -0700
In-Reply-To: <1473572530-25764-7-git-send-email-stefanbeller@gmail.com>
        (Stefan Beller's message of "Sat, 10 Sep 2016 22:42:06 -0700")
Message-ID: <xmqqoa3swteo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 950B6D7C-7946-11E6-B7C7-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <stefanbeller@gmail.com> writes:

> From: Stefan Beller <sbeller@google.com>
>
> ---

"X can do Y" can be taken as a statement of fact (to which "so
what?"  is an appropriate response), a desire (to which "then please
say 'make X do Y' instead" is an appropriate response), or a report
of a bug (to which "please explain why X should be forbidden from
doing Y" is an appropriate response).

This is way under-explained.  I think this is "make X do Y" kind,
and if so, please say so and possibly why it is a good idea to teach
X how to do Y.

Thanks.



>  diff.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index 87b1bb2..2aefd0f 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -473,11 +473,13 @@ static void emit_line_0(struct diff_options *o, const char *set, const char *res
>  	}
>  
>  	if (len || !nofirst) {
> -		fputs(set, file);
> +		if (set)
> +			fputs(set, file);
>  		if (!nofirst)
>  			fputc(first, file);
>  		fwrite(line, len, 1, file);
> -		fputs(reset, file);
> +		if (reset)
> +			fputs(reset, file);
>  	}
>  	if (has_trailing_carriage_return)
>  		fputc('\r', file);
