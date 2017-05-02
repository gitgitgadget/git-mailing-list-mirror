Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BBC3207D6
	for <e@80x24.org>; Tue,  2 May 2017 03:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751100AbdEBDWV (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 23:22:21 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34805 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751077AbdEBDWU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 23:22:20 -0400
Received: by mail-pg0-f67.google.com with SMTP id t7so18834224pgt.1
        for <git@vger.kernel.org>; Mon, 01 May 2017 20:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=vbtWheqae3qRueKopuXn7JaXRxpbjH+GVD7EY2aCYL0=;
        b=AobPAk6+Z5nxI+k6s18n5bdHoeIStLTnqg0UCTistUpwqoPui8TDYxP/vFHKZYmxAA
         5fw9zjexj3dphKsw6KmgdfOGUo2qFAAa073XDPtD6bmSJBhDfu6bTjDyA5kVcaa/Fp8e
         JwpzS36jZlHUVrIJer+F5TxG80b+3qhnenQHP3BndcOe9dJJ2oOlL5X1geb52sUU3v65
         pXezdQhukZAEEVnlr+DPFTvGh4jfBysexmWCPzM89XsWcZ0J2v5S/H1DCOjoc/f7BjdM
         vez5DKKw+JBVPnYnQ6RteJNKhxSZ3DDHpq/jy28TEhRMDQ/6OursPWQMYrytMLlclm7S
         vTjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=vbtWheqae3qRueKopuXn7JaXRxpbjH+GVD7EY2aCYL0=;
        b=GTqmVPn9EV+h24PAb++dod/zpONpf7MVl/hL+WJPOUlpzyU9c9NlmogapCX7qPHw73
         7qtzes2yCcJHWEcq10IwnVNtTYaNAye1fQuowWoF52CpP/f8deez4ksEHutHGiA0LEQk
         tjyQLfEKjukWAK1ukhRGs0nQQUqxDyMQVAaHBg+IGgm29lAWtTnL75ZtYs078thE67PF
         7ylroofVRpJxDnNi/5lBU1rdbcB4bU4RRZOkrMst6DIJXL1BxIka14zgKmcMV7ICgAm1
         irj1+d8X43Tt0vQQh86B1L05YtgJPVN6HawWKPZK6FpZov3FSuHllpa1YiD1si+R4Cda
         RfpQ==
X-Gm-Message-State: AN3rC/5g4+UfyBysvHXIAKg8bHwzqprR/2doH0ANsUmMS0VIB2WjxWgv
        WwpDzcZtfMwWxQ==
X-Received: by 10.99.100.129 with SMTP id y123mr29584439pgb.217.1493695340173;
        Mon, 01 May 2017 20:22:20 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3c5e:d1c1:579c:ef99])
        by smtp.gmail.com with ESMTPSA id q16sm192208pfk.12.2017.05.01.20.22.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 01 May 2017 20:22:19 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 24/25] show_worktree(): plug memory leak
References: <cover.1493237937.git.johannes.schindelin@gmx.de>
        <cover.1493387231.git.johannes.schindelin@gmx.de>
        <61752ef33781402fe90dfa92dee2427e3cd00e5b.1493387231.git.johannes.schindelin@gmx.de>
Date:   Mon, 01 May 2017 20:22:18 -0700
In-Reply-To: <61752ef33781402fe90dfa92dee2427e3cd00e5b.1493387231.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Fri, 28 Apr 2017 16:04:42 +0200
        (CEST)")
Message-ID: <xmqqh914djth.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> The buffer allocated by shorten_unambiguous_ref() needs to be released.

Yes.  Looks good.

>
> Discovered by Coverity.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/worktree.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 1722a9bdc2a..ff5dfd2b102 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -414,9 +414,11 @@ static void show_worktree(struct worktree *wt, int path_maxlen, int abbrev_len)
>  				find_unique_abbrev(wt->head_sha1, DEFAULT_ABBREV));
>  		if (wt->is_detached)
>  			strbuf_addstr(&sb, "(detached HEAD)");
> -		else if (wt->head_ref)
> -			strbuf_addf(&sb, "[%s]", shorten_unambiguous_ref(wt->head_ref, 0));
> -		else
> +		else if (wt->head_ref) {
> +			char *ref = shorten_unambiguous_ref(wt->head_ref, 0);
> +			strbuf_addf(&sb, "[%s]", ref);
> +			free(ref);
> +		} else
>  			strbuf_addstr(&sb, "(error)");
>  	}
>  	printf("%s\n", sb.buf);
