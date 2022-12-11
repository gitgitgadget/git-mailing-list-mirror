Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286BBC4332F
	for <git@archiver.kernel.org>; Sun, 11 Dec 2022 03:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiLKDcm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Dec 2022 22:32:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiLKDcl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Dec 2022 22:32:41 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC19B33
        for <git@vger.kernel.org>; Sat, 10 Dec 2022 19:32:39 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id c7so6338934pfc.12
        for <git@vger.kernel.org>; Sat, 10 Dec 2022 19:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v274VcAmwwGKAFG+UrByCym4F3Ow4akdjuyh+mNOhyU=;
        b=JT3qVqjpDIm3SgCyzL42/i9sk9NaK1n0xqPzy5SOjLbdC5vfW4AXX0Rfwb+WBW2xni
         nsLLsTCFgCnvy18mr0GrYZodwRf4LuRRLqSFJDZV7y8PpKRbZzZwrherPf9ILXt9axXk
         //LRyG7o8zfjiUA/BACpuSYxfLuI1z492qkOC/aVTIeAEF9wAw54+UcAySvriRGVxRtn
         SerofpC0eby/gamqbSOz+55j1bo5MbAGY/UmOlcN0Kmtjz70kE/di9InbJ+DDlU9FYFg
         wxYADk+NHvFt0bm44nU9iRyq1FB/fqNxg2YJzzWjgLzcAQ+cwVAeC1toXVC5EN7v7DMA
         XF8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=v274VcAmwwGKAFG+UrByCym4F3Ow4akdjuyh+mNOhyU=;
        b=gdu/bmRVTrkouXtzbA0DWLa9j/jUCZmuiy6P6TVK1FS+sjjgg1Jv1Lg4hl9rLpHsxS
         tqEKtq0TgPyXKQqEO3NUKnZ9EQSdEWcAhNGrxf7JUvP28JLUH99BVdY61AOicJiqhjwH
         1uGkF6i58g/U5HD8eKwBrvEu2NpLQbS/44XfWRo1cVf+w13kKjCKAA059Wlm8+lLfQZ7
         s9SGrhPhOfySIaB+sRuD3lQXXOp5EDRLZqKAOwraDZaRDeTnbo99N8/cGzKH0XPu6YeF
         KZskQ2AGWA3YTwiGCF2z3YNFEttAy4OnRLSOLblgdEeY8rcdfcl1xdHflhJdMph26D0H
         YagQ==
X-Gm-Message-State: ANoB5plzgETPNTRAoTODx2/i3m/P3zmvC+1whdZumPtA7+CpXbY1jm1S
        Kao2ZA1uUDb5armBMGYw+Mw=
X-Google-Smtp-Source: AA0mqf45ML7iD+KRKdkKiEDf47QExIz+oyAQ2fojaqgDWWtSfCGEP5CPlhz1M09jXuWtOkI4go+ybQ==
X-Received: by 2002:aa7:81cb:0:b0:56b:af71:cfd with SMTP id c11-20020aa781cb000000b0056baf710cfdmr11080211pfn.23.1670729559111;
        Sat, 10 Dec 2022 19:32:39 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id f24-20020aa79698000000b00575b6f8b84esm3363037pfk.26.2022.12.10.19.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Dec 2022 19:32:38 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Kellogg-Stedman <lars@oddbit.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3] line-range: Fix infinite loop bug with degenerate
 '$' regex
References: <20221205193625.2424202-1-lars@oddbit.com>
        <20221211015340.2181837-1-lars@oddbit.com>
Date:   Sun, 11 Dec 2022 12:32:38 +0900
In-Reply-To: <20221211015340.2181837-1-lars@oddbit.com> (Lars
        Kellogg-Stedman's message of "Sat, 10 Dec 2022 20:53:40 -0500")
Message-ID: <xmqq5yeiwr6x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Kellogg-Stedman <lars@oddbit.com> writes:

> When the -L argument to "git log" is passed the degenerate regular
> expression "$" (as in "-L :$:line-range.c"), this results in an
> infinite loop in find_funcname_matching_regexp().

Is "matching an empty line" the only way a regular expression can be
a "degenerate" one?  If not, perhaps being a bit more explicit would
help the readers, e.g.

    ... a regular expression that matches any line, even an empty
    one, such as "-L :$:line-range.c", this results in ...

> The primary change is that we pre-decrement the beginning-of-line
> marker ('bol') before comparing it to '\n'. In the case of '$', where
> we start with bol == eol, this ensures that bol will find the
> beginning of the line on which the match occurred.

This clear explanation probably deserves to be in the commit log
message proper.

> @@ -148,8 +148,7 @@ static const char *find_funcname_matching_regexp(xdemitconf_t *xecfg, const char
>  		/* determine extent of line matched */
>  		bol = start+match[0].rm_so;
>  		eol = start+match[0].rm_eo;
> -		while (bol > start && *bol != '\n')
> -			bol--;
> +		while (bol > start && *--bol != '\n');

Please write it on two lines, and highlight an empty body of the
loop, like so

		while (condition)
			; /* nothing */

I think the intention of the above loop is to decrement bol
sufficiently and make it point at the terminating LF at the end
of the previous line, and then the next increment here

>  		if (*bol == '\n')
>  			bol++;

compensates to bring bol back to point at the beginning of line.

In the iteration of the loop when bol == start + 1, we inspect
*--bol (i.e.  *start).  If it is LF, we exit the loop, so bol ==
start and *bol == '\n'.  If it is not LF, we iterate one more time,
notice bol == start and exit the loop, so bol == start and *bol !=
'\n'.  bol will never go below start, so dereference *bol to see it
value where should be safe without OOB read.

> @@ -161,6 +160,7 @@ static const char *find_funcname_matching_regexp(xdemitconf_t *xecfg, const char
>  			return bol;
>  		start = eol;
>  	}
> +	return NULL;
>  }

What is this change about?  Isn't the above an endless loop without
break, from which the only way for the control to leave it is by
returning?

> diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
> index ac9e4d0928..19db07a8df 100755
> --- a/t/t4211-line-log.sh
> +++ b/t/t4211-line-log.sh
> @@ -315,4 +315,26 @@ test_expect_success 'line-log with --before' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'setup tests for zero-width regular expressions' '
> +	cat > expect <<-EOF

Style: lose the SP after "cat >".

> +	Modify func1() in file.c
> +	Add func1() and func2() in file.c
> +	EOF
> +'
> +
> +test_expect_success 'zero-width regex $ matches any function name' '
> +	git log --format="%s" --no-patch "-L:$:file.c" >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'zero-width regex ^ matches any function name' '
> +	git log --format="%s" --no-patch "-L:^:file.c" >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'zero-width regex . matches any function name' '

"." is one character wide, not zero-width.  Did you mean ".*"?

> +	git log --format="%s" --no-patch "-L:.:file.c" >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_done
