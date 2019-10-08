Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BA7B1F4BD
	for <e@80x24.org>; Tue,  8 Oct 2019 03:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729927AbfJHDQS (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 23:16:18 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63747 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729536AbfJHDQS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 23:16:18 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8371891A18;
        Mon,  7 Oct 2019 23:16:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ssSvr0kih3/18p39bEMpat7xgbE=; b=UvnxDA
        usEWbqeD1j8OSmdpWFwJzha7qWj9DihNhovxUOB8RNF2SauoasF5DD/0Ek2QHSv4
        HbVb5m/ldSGgdwIaf2tQHU7cEA92v1VQVyoCAIOQgdps/R3+GYiQbXYGi6s47Dcq
        8xkTCnQdVjwSQZ98k/cjbxfe5s3DKCcWiJI5M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WhoAnfMxk8nuyBWxFzJVryzziWKjM9KW
        ojVseonnblslrCql2Q37l2UNxg5BMEYELa0O9y8f/rSIA+xtaP7sGfKcHixbiHuO
        hvvt2eNZ1yj0iFZlqPlMzH+9tKOigGmLLVp0znBpoJYU26djN78Velu3GqzuVHUT
        gOa+uWLoriE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7ADA591A17;
        Mon,  7 Oct 2019 23:16:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5AC8B91A16;
        Mon,  7 Oct 2019 23:16:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, garimasigit@gmail.com, jeffhost@microsoft.com,
        stolee@gmail.com, Garima Singh <garima.singh@microsoft.com>
Subject: Re: [PATCH v4 1/1] sq_quote_buf_pretty: don't drop empty arguments
References: <pull.314.v3.git.gitgitgadget@gmail.com>
        <pull.314.v4.git.gitgitgadget@gmail.com>
        <a6a0217ce6fa2a7436724d76fc50fd6f8b925de5.1570477135.git.gitgitgadget@gmail.com>
Date:   Tue, 08 Oct 2019 12:16:10 +0900
In-Reply-To: <a6a0217ce6fa2a7436724d76fc50fd6f8b925de5.1570477135.git.gitgitgadget@gmail.com>
        (Garima Singh via GitGitGadget's message of "Mon, 07 Oct 2019 12:38:56
        -0700 (PDT)")
Message-ID: <xmqqd0f8nczp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FB0EEAF8-E979-11E9-830D-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Garima Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Garima Singh <garima.singh@microsoft.com>
>
> Empty arguments passed on the command line can be a represented by
> a '', however sq_quote_buf_pretty was incorrectly dropping these
> arguments altogether. Fix this problem by ensuring that such
> arguments are emitted as '' instead.
>
> Reported by: Junio Hamano <gitster@pobox.com>
> Signed-off-by: Garima Singh <garima.singh@microsoft.com>
> ---
>  quote.c          | 9 +++++++++
>  t/t0014-alias.sh | 7 +++++++
>  2 files changed, 16 insertions(+)
>
> diff --git a/quote.c b/quote.c
> index 7f2aa6faa4..26f1848dde 100644
> --- a/quote.c
> +++ b/quote.c
> @@ -48,6 +48,15 @@ void sq_quote_buf_pretty(struct strbuf *dst, const char *src)
>  	static const char ok_punct[] = "+,-./:=@_^";
>  	const char *p;
>  
> +	if (!src) 
> +		BUG("Cannot append a NULL token to the buffer");

Remove these two lines.

I do not want to see "if (!ptr) BUG("don't give a NULL pointer")"
sprinkled to every function that takes a pointer that must not be
NULL.  Any caller that violates the contract with the callee
deserves a segfault, so let's leave it at that.

> +	/* Avoid losing a zero-length string by adding '' */ 
> +	if (!*src) {
> +		strbuf_addstr(dst, "''");
> +		return;
> +	}
> +

Nice.

>  	for (p = src; *p; p++) {
>  		if (!isalpha(*p) && !isdigit(*p) && !strchr(ok_punct, *p)) {
>  			sq_quote_buf(dst, src);
> diff --git a/t/t0014-alias.sh b/t/t0014-alias.sh
> index a070e645d7..2694c81afd 100755
> --- a/t/t0014-alias.sh
> +++ b/t/t0014-alias.sh
> @@ -37,4 +37,11 @@ test_expect_success 'looping aliases - internal execution' '
>  #	test_i18ngrep "^fatal: alias loop detected: expansion of" output
>  #'
>  
> +test_expect_success 'run-command formats empty args properly' '
> +    GIT_TRACE=1 git frotz a "" b " " c 2>&1 |
> +    sed -ne "/run_command:/s/.*trace: run_command: //p" >actual &&
> +    echo "git-frotz a '\'''\'' b '\'' '\'' c" >expect &&
> +    test_cmp expect actual
> +'
> +
>  test_done
