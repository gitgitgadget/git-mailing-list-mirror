Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F05C433EF
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 07:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235670AbiCGHI6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 02:08:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232511AbiCGHI5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 02:08:57 -0500
Received: from bsmtp2.bon.at (bsmtp2.bon.at [213.33.87.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94632657B
        for <git@vger.kernel.org>; Sun,  6 Mar 2022 23:08:03 -0800 (PST)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 4KBqKq23pkz5tlF;
        Mon,  7 Mar 2022 08:07:59 +0100 (CET)
Message-ID: <8799cd42-bb05-a827-187d-33fb03565f21@kdbg.org>
Date:   Mon, 7 Mar 2022 08:07:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v5] userdiff: add builtin diff driver for kotlin language.
Content-Language: en-US
To:     Jaydeep P Das <jaydeepjd.8914@gmail.com>
References: <20220301070226.2477769-1-jaydeepjd.8914@gmail.com>
 <20220306111539.336475-1-jaydeepjd.8914@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org
In-Reply-To: <20220306111539.336475-1-jaydeepjd.8914@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 06.03.22 um 12:15 schrieb Jaydeep P Das:
> diff --git a/userdiff.c b/userdiff.c
> index 8578cb0d12..cd2155bbfe 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -168,6 +168,18 @@ PATTERNS("java",
>  	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
>  	 "|[-+*/<>%&^|=!]="
>  	 "|--|\\+\\+|<<=?|>>>?=?|&&|\\|\\|"),
> +PATTERNS("kotlin",
> +	 "^[ \t]*(([a-z]+[ \t]+)*(fun|class|interface)[ \t]+.*)$",
> +	 /* -- */
> +	 "[a-zA-Z_][a-zA-Z0-9_]*"
> +	 /* hexadecimal and binary numbers */
> +	 "|0[xXbB][0-9a-fA-F_]+[lLuU]*"
> +	 /* integers and floats */
> +	 "|[0-9][.]?[0-9_]+([Ee][-+]?[0-9]+)?[fFlL]*"
> +	 /* floating point numbers beginning with decimal point */
> +	 "|[.][0-9][0-9]*([Ee][-+]?[0-9]+)?[fFlLuU]?"

I guess that the suffix u is intended to mark unsigned integers. So, I
would say that the alternatives [fFlL] and [fFlLuU] should be swapped.

Furthermore, is it intentional that you do not recognize the '_' digit
separator in floating point numbers that begin with a decimal point?

> +	 /* unary and binary operators */
> +	 "|[-+*/<>%&^|=!]?==?|--|\\+\\+|<<?=?|>>?=?|&&|\\|[|]?|->|\\.\\*|!!|::|[?:.][.:]"),

What is the justification that there is still "|&&|\\|[|]?|" instead of
"|&&|\\|\\||" that I suggested (and I think I stressed that the point is
that single-character operators are matched elsewhere) and to which you
said "yes, right"?

Also, the part "|<<?=?|>>?=?|" can match <, >, <=, and >=, all of which
are matched by other expressions, so you could reduce it to "|<<=|>>=|",
because that are the only tokens that they must match.

-- Hannes
