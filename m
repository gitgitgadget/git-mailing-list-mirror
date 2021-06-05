Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 430ACC47082
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 19:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 250CA6136D
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 19:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbhFETLQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Jun 2021 15:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbhFETLP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Jun 2021 15:11:15 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71959C061766
        for <git@vger.kernel.org>; Sat,  5 Jun 2021 12:09:14 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id a20so12721287wrc.0
        for <git@vger.kernel.org>; Sat, 05 Jun 2021 12:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=n0GUQgY7y+c/nT9FyFLU/deYmqFwft6bMeaxA2my2zM=;
        b=hrKnIfutw1MoFl3z4Lx+sQ6mY2f5DGUu5G4WrRGv6rkJG+vkGmXPUJnmXCPDCKemoz
         wage5FfnDyuSDpaoqku7pw9xUZxXZG0RnnjjKyM9a2eOhsjLGsXNLWT3YXzapTyKDbld
         WmSZkYMvfO79CtCLMaCfyHTC/lk97nrroGjT+fwCB5jNMp2hhtt0jFt1zKkQXOMMKg7r
         N6SC9BsiTDnCCLMF0UbOyqdCfvto+NG6C2KC7+361FyW5c2AxpaaIVUtkywlPNayJCm8
         y9THwwVhNF4+st/XoLx3rspQA/zbgILkbiPeATOzYPjdlJzun0IuJcYYLmxhfyTZssej
         cb+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=n0GUQgY7y+c/nT9FyFLU/deYmqFwft6bMeaxA2my2zM=;
        b=O6BbD4lA1fIzTEuvy8+x1MZvVlsMlSlirutEhecODxfIAyAB192WXPJGRr5j16u6+u
         RbXjZPtsqz4agEtaIAskt+2hZnX/2PwjXD1DX2KCs96o6g+2sSDHrl/EnEdHeKH1pg3M
         mG8qIplA9C5w/+LlvZo3EhvF+f1QNIy4FIKaVcQ42G/yxY3l/T0O7M9IoLEmuVLefLyg
         /zxdLejFmKDoI2WisbXmrwzv35xugnW0amLsovpi3nJ/UR7W1XV5viQR6x6rBBO3Gmej
         YL6TOV8INcb/sws/WVg8Anh7APQTDt97cDzCDV0CoBfHeGYs4es7wsu/EO1+XJl9VVPQ
         t31g==
X-Gm-Message-State: AOAM533UvbqdFApfILoIL/SZqiA3nmXOwlXiZucXPLwOGxIwSBePseqH
        PInA8R9vO1VkFJZ6uJXPV3Q=
X-Google-Smtp-Source: ABdhPJzUTfl4H0n+JkHqrPX7N0rnDn8AOag7RePP0BpgJJsfy+DWg9VrYnyR0YmRNifBjRa6eP3aug==
X-Received: by 2002:adf:efca:: with SMTP id i10mr9678240wrp.139.1622920153071;
        Sat, 05 Jun 2021 12:09:13 -0700 (PDT)
Received: from szeder.dev (94-21-29-108.pool.digikabel.hu. [94.21.29.108])
        by smtp.gmail.com with ESMTPSA id 62sm11545569wrm.1.2021.06.05.12.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jun 2021 12:09:12 -0700 (PDT)
Date:   Sat, 5 Jun 2021 21:09:10 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] parallel-checkout: avoid dash local bug in tests
Message-ID: <20210605190910.GJ2947267@szeder.dev>
References: <eb4bcd4c-e6d2-cbeb-8951-cf22b9d3d5fe@web.de>
 <472c1411-fcf8-862b-cef9-52c2c994914b@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <472c1411-fcf8-862b-cef9-52c2c994914b@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 05, 2021 at 08:11:24PM +0200, René Scharfe wrote:
> The parallel checkout tests fail when run with /bin/dash on MacOS 11.4,
> reporting the following error:
> 
>    ./t2080-parallel-checkout-basics.sh: 33: local: 0: bad variable name
> 
> That's because wc's output contains leading spaces and this version of
> dash erroneously expands the variable declaration as "local workers= 0",
> i.e. it tries to set the "workers" variable to the empty string and also
> declare a variable named "0", which not a valid name.  This is a known
> dash bug (https://bugs.launchpad.net/ubuntu/+source/dash/+bug/139097).

Perhaps a more accurate wording for this bug would be:

  ... and even fairly recent versions of dash erroneously perform
  field splitting on the expansion of the command substitution before
  assigning it to a local variable.

I think the relevant part of POSIX is section 2.9.1 Simple Commands:

  4. Each variable assignment shall be expanded for tilde expansion,
     parameter expansion, command substitution, arithmetic expansion,
     and quote removal prior to assigning the value.

  https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_09_01

Note that it didn't mention field splitting; though POSIX doesn't
specifies local variables in the first place, so...

Anyway, this bug has been fixed in v0.5.11 (2020-06-01).
This is an old bug, it was already present in v0.5.5 (2009-01-13); I
didn't check earlier versions.

> Work around it by passing the command output directly to test instead of
> storing it in a variable first.  While at it, let grep count the number
> of lines instead of piping its output to wc, which is a bit shorter and
> more efficient.

A more debug-friendly alternative would be to save 'grep's output to a
temporary file and use 'test_line_count = $expected_workers'.

> Helped-by: Matheus Tavares Bernardino <matheus.bernardino@usp.br>
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
> Changes since v1:
> - Explain the root cause.
> - Get rid of the local variable "workers".
> - Adjust title accordingly.
> - Still use grep -c, though.
> - Remove input redirection.
> 
>  t/lib-parallel-checkout.sh | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/t/lib-parallel-checkout.sh b/t/lib-parallel-checkout.sh
> index 21f5759732..66350d5207 100644
> --- a/t/lib-parallel-checkout.sh
> +++ b/t/lib-parallel-checkout.sh
> @@ -27,8 +27,7 @@ test_checkout_workers () {
>  	rm -f "$trace_file" &&
>  	GIT_TRACE2="$(pwd)/$trace_file" "$@" 2>&8 &&
> 
> -	local workers=$(grep "child_start\[..*\] git checkout--worker" "$trace_file" | wc -l) &&
> -	test $workers -eq $expected_workers &&
> +	test $(grep -c "child_start\[..*\] git checkout--worker" "$trace_file") -eq $expected_workers &&
>  	rm "$trace_file"
>  } 8>&2 2>&4
> 
> --
> 2.31.1
> 
