Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88BEC27C76
	for <git@archiver.kernel.org>; Sun, 22 Jan 2023 00:08:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjAVAIs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Jan 2023 19:08:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjAVAIs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jan 2023 19:08:48 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B1BE14E93
        for <git@vger.kernel.org>; Sat, 21 Jan 2023 16:08:47 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id u1-20020a17090a450100b0022936a63a21so12346029pjg.4
        for <git@vger.kernel.org>; Sat, 21 Jan 2023 16:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ihuEC8yfU2808c/FxDqxRGTskHbLoTrdf/MSjGemxE=;
        b=pNULFZviqo+E/tDjWfm4z165on9pGDNC58JsHux4pbsJne08CgOJ0w9xhK7U5nuzXf
         Tq5q/JEVhbqpuz0QfrbZBb9/lq0ORJoND0IFEtTLcst4TtbLgcrg05dnWdRxykyUAki+
         kzVtjWst7rXk/5W26Q3lcUcRRSiAQBN8p7cXLz2qCVZymmtSrozPQugSodxwc42wi96Z
         qrMfxT6OTim/sKeKZhJDvIHtPzHZ/Ae+rcZ7uwoqeYIN4b2JYSZLFkZu0DS0A7ysrsFd
         4TZszPtFZJROaVqlr4HfmztH8F4atmeKXXyaDc4yWC57t55r5MA5duAm3WynCNeZtZm8
         20QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0ihuEC8yfU2808c/FxDqxRGTskHbLoTrdf/MSjGemxE=;
        b=AuZ1gt4P1W8oGp8S0gEajfH/Y1+4lyJrCub3xtAWQTW9ZG6OtwVJ3wTG8ni0cev3zC
         w2zxI4cvlehpa1248uQRwzTEmRDDzK/rYeGQkDagCIE4ijFR/mwppac1Sc3mUxUASd05
         3ucnaRWOTj4A5nJ9hMzvjgU/dN4zCtblRK9y6WHx1ajQ1fEgF+l2PUhetTM/Z1ISp6ek
         owXAlaHDoEKM/LjX0igegjwXHLKvcU6b/Xqc1GHxwTl3WkYiSVAdcxSP+F8TWqX03Nat
         2bpIQtGBHwPG0s8G5OrV7kPotO+xFmjBwQC9o2QjmYHL/buveJdrKVZWWeY910I3WsGK
         U2sw==
X-Gm-Message-State: AFqh2koS80jgYyqTW+nOwX7ecTxUQ/1cUkG8ZseoJM55Ttr4Qk6AjCQM
        w4MLlxwMSfYf5aV9d7aKmW4=
X-Google-Smtp-Source: AMrXdXsZaUxoBnfLQCVuP1TnTlxUIwE33Rhl9cv0977qFneUIewiNpdKbv7yDytsIy9btAHrHO9ykQ==
X-Received: by 2002:a17:902:cec4:b0:195:f500:c6fe with SMTP id d4-20020a170902cec400b00195f500c6femr5096130plg.9.1674346126476;
        Sat, 21 Jan 2023 16:08:46 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id q10-20020a170902daca00b00192d3e7eb8fsm29205395plx.252.2023.01.21.16.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 16:08:46 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     tboegi@web.de
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v1 1/1] t0003: Call dd with portable blocksize
References: <20230121110505.21362-1-tboegi@web.de>
Date:   Sat, 21 Jan 2023 16:08:45 -0800
In-Reply-To: <20230121110505.21362-1-tboegi@web.de> (tboegi@web.de's message
        of "Sat, 21 Jan 2023 12:05:05 +0100")
Message-ID: <xmqq8rhvwhv6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

tboegi@web.de writes:

> From: Torsten Bögershausen <tboegi@web.de>
>
> The command `dd -bs=101M count=1` is not portable.

No need for '-'; the UI of dd was meant as a joke and deliberately
deviates from UNIX norm to use '-' as an option introducer.

> Use `bs=1048576 count=101`, which does the same, instead.

Thanks for catching this.  It always is hard to catch these mistakes
made in code that was cooked behind embargo, as there aren't many
eyeballs on the changes.

Strictly speaking, "bs=1048576 count=101" does not do the same thing
(unlike the original that does a single write(2)system call of a
huge buffer, it issues 101 smaller write(2)).

It definitely is an improvement, independently from the portability
issues, to rewrite it like you did.  Unnecessarily large an I/O
should be avoided.

Will queue.  Thanks.

> Signed-off-by: Torsten Bögershausen <tboegi@web.de>
> ---
>  t/t0003-attributes.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
> index d0284fe2d7..394a08e6d6 100755
> --- a/t/t0003-attributes.sh
> +++ b/t/t0003-attributes.sh
> @@ -400,7 +400,7 @@ test_expect_success 'large attributes line ignores trailing content in tree' '
>
>  test_expect_success EXPENSIVE 'large attributes file ignored in tree' '
>  	test_when_finished "rm .gitattributes" &&
> -	dd if=/dev/zero of=.gitattributes bs=101M count=1 2>/dev/null &&
> +	dd if=/dev/zero of=.gitattributes bs=1048576 count=101 2>/dev/null &&
>  	git check-attr --all path >/dev/null 2>err &&
>  	echo "warning: ignoring overly large gitattributes file ${SQ}.gitattributes${SQ}" >expect &&
>  	test_cmp expect err
> @@ -428,7 +428,7 @@ test_expect_success 'large attributes line ignores trailing content in index' '
>
>  test_expect_success EXPENSIVE 'large attributes file ignored in index' '
>  	test_when_finished "git update-index --remove .gitattributes" &&
> -	blob=$(dd if=/dev/zero bs=101M count=1 2>/dev/null | git hash-object -w --stdin) &&
> +	blob=$(dd if=/dev/zero bs=1048576 count=101 2>/dev/null | git hash-object -w --stdin) &&
>  	git update-index --add --cacheinfo 100644,$blob,.gitattributes &&
>  	git check-attr --cached --all path >/dev/null 2>err &&
>  	echo "warning: ignoring overly large gitattributes blob ${SQ}.gitattributes${SQ}" >expect &&
> --
> 2.39.1.254.g904d404274
