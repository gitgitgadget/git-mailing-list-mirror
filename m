Return-Path: <SRS0=BdMw=27=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB054C282DD
	for <git@archiver.kernel.org>; Fri, 10 Jan 2020 17:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 857AA206ED
	for <git@archiver.kernel.org>; Fri, 10 Jan 2020 17:43:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgAJRnq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jan 2020 12:43:46 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:38217 "EHLO bsmtp2.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727658AbgAJRnq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jan 2020 12:43:46 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 47vVhb2YXDz5tlC;
        Fri, 10 Jan 2020 18:43:43 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 41814239;
        Fri, 10 Jan 2020 18:43:42 +0100 (CET)
Subject: Re: [PATCH] userdiff: add Julia to supported userdiff languages
To:     Ryan Zoeller via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Ryan Zoeller <rtzoeller@rtzoeller.com>
References: <pull.521.git.1578625810098.gitgitgadget@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <49decf8e-87a9-120f-4c2b-cafc5aa1d466@kdbg.org>
Date:   Fri, 10 Jan 2020 18:43:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <pull.521.git.1578625810098.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.01.20 um 04:10 schrieb Ryan Zoeller via GitGitGadget:
> Add xfuncname and word_regex patterns for Julia[1],
> which is a language used in numerical analysis and
> computational science.
> 
> The default behavior for xfuncname did not allow
> functions to be indented, nor functions to have a
> macro applied, such as @inline or @generated.
> 
> [1]: https://julialang.org
> 
> Signed-off-by: Ryan Zoeller <rtzoeller@rtzoeller.com>
> ---
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-521%2Frtzoeller%2Fjulia_userdiff-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-521/rtzoeller/julia_userdiff-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/521
> 
>  Documentation/gitattributes.txt |  2 ++
>  t/t4018-diff-funcname.sh        |  1 +
>  t/t4018/julia-function          |  5 +++++
>  t/t4018/julia-indented-function |  8 ++++++++
>  t/t4018/julia-inline-function   |  5 +++++
>  t/t4018/julia-macro             |  5 +++++
>  t/t4018/julia-mutable-struct    |  5 +++++
>  t/t4018/julia-struct            |  5 +++++
>  userdiff.c                      | 15 +++++++++++++++
>  9 files changed, 51 insertions(+)
>  create mode 100644 t/t4018/julia-function
>  create mode 100644 t/t4018/julia-indented-function
>  create mode 100644 t/t4018/julia-inline-function
>  create mode 100644 t/t4018/julia-macro
>  create mode 100644 t/t4018/julia-mutable-struct
>  create mode 100644 t/t4018/julia-struct

The tests all look good.

> diff --git a/userdiff.c b/userdiff.c
> index efbe05e5a5..b5e938b1c2 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -79,6 +79,21 @@ PATTERNS("java",
>  	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
>  	 "|[-+*/<>%&^|=!]="
>  	 "|--|\\+\\+|<<=?|>>>?=?|&&|\\|\\|"),
> +PATTERNS("julia",
> +	 "^[ \t]*(((mutable[ \t]+)?struct|(@.+[ \t])?function|macro)[ \t].*)$",

Looks good to me.

> +	 /* -- */
> +	 /* Binary literals */
> +	 "[-+]?0b[01]+"
> +	 /* Hexadecimal literals */
> +	 "|[-+]?0x[0-9a-fA-F]+"

These two could be merged into

	/* Binary and hexadecimal literals */
	"|0[bx][0-9a-fA-F]+"

Note that I did not insert [-+]? at the front. Even though most if not
all patterns allow a sign, they are usually wrong to do so, because they
misclassify a change from 'a+1' to 'a+2' as 'a[-+1-]{++2+}' instead of
the correct 'a+[-1-]{+2+}'.

> +	 /* Real and complex literals */
> +	 "|[-+0-9.e_(im)]+"

I am curious: is '(1+2i)' a single literal -- including the parentheses?
The expression would also mistake the character sequence '-1)+(2+' as a
single word; is it intended?

> +	 /* Should theoretically allow Unicode characters as part of
> +	  * a word, such as U+2211. However, Julia reserves most of the
> +	  * U+2200-U+22FF range (as well as others) as user-defined operators,
> +	  * therefore they are not handled in this regex. */
> +	 "|[a-zA-Z_][a-zA-Z0-9_!]*"
> +	 "|--|\\+\\+|<<=?|>>>=?|>>=?|\\\\\\\\=?|//=?|&&|\\|\\||::|->|[-+*/<>%^&|=!$]=?"),

The last sub-expression permits single-character operators in addition
to their forms with a '=' appended (computing assignment, I presume).
You could remove the trailing ? because single non-whitespace characters
are always a word of their own, even if they are not caught by the word
regexp.

>  PATTERNS("matlab",
>  	 /*
>  	  * Octave pattern is mostly the same as matlab, except that '%%%' and
> 
> base-commit: 042ed3e048af08014487d19196984347e3be7d1c
> 

-- Hannes
