Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED551C77B73
	for <git@archiver.kernel.org>; Mon,  1 May 2023 15:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbjEAPXV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 May 2023 11:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbjEAPXU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2023 11:23:20 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE90A8
        for <git@vger.kernel.org>; Mon,  1 May 2023 08:23:19 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-24b725d6898so1635244a91.2
        for <git@vger.kernel.org>; Mon, 01 May 2023 08:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682954598; x=1685546598;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mE6hMAAPqGRFABH/dMzGt1v6Z8wN6hiQWNEqZtj30yU=;
        b=ED8tqYvHIbjZVQHopTGAASmwFrzzkNirH/msJQKCB8rskyaRlu1Qy+1It66stxcQ2w
         Qm7e7es+fYuD/TRsl8IBJX37qKl0tL1P0JnVFVBfUGGj9sZTkVqijiKi+Oe261XR20W+
         uX2av43oCFCic7Wa/B0f3jlnl8maIVcKX6UDVdbYnKJResjS8QHpkcWR+OgUn4F8lklh
         7Irz7opZAmYmV1C/jXVxCkxBS75/gBcwkub5jejfcjXvFFIXh66l9Gu1m2rZsxPuJyEE
         6C8cnZmtp//GP0mJcJmoyL5ezBEfBuTobxFk9i84ObO+o0p1XNyUOv7AJ9IP8r7gw5b8
         pvow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682954598; x=1685546598;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mE6hMAAPqGRFABH/dMzGt1v6Z8wN6hiQWNEqZtj30yU=;
        b=gzQrq2cX9uKJYtZ7qNZcYlG/bMzpSo1bvfcwdFpXptp2vYytIRs7JmTryNb6jCtdPE
         KYBFdglUemLUduAjbuMh0+l+d7vnfssxjMgs7r7WFStkz9oWiv6EtsUJH+JjIbH3503A
         zrYEEyj6fd23TGPrF00uiSAIMcS5tQyxBWLiYu7OcTYlROPdua/32pEIymfvguDFUSyf
         dhMBrzlJY3hysvpAHQC30R5Sk0trU/SlALda4p3NhHjgDu6oHuO3r2bPMC7ViWRN4WIk
         3k3sxtViZfns8J0FPokK6atjn+pXSRnjw1B5FNxGJe5hDmbyImm1n5sfxBeyzzh7TDYZ
         toSQ==
X-Gm-Message-State: AC+VfDyllQOp3xV5VqTfPRHLrkxx03LyM+UNZErSDut1DWfpo+uG9GWp
        8isAIweOOzV2iHihU9EP5R8lf3lhqpQ=
X-Google-Smtp-Source: ACHHUZ4VBq6TLAGqqEe6FV8UCYGvu4BDvD5e5Vb76EPBT4oSrU2tHXUXxkCX4XUXVlc6UAMZNzYiEw==
X-Received: by 2002:a17:90a:ec0a:b0:247:bdeb:594f with SMTP id l10-20020a17090aec0a00b00247bdeb594fmr15536255pjy.15.1682954598589;
        Mon, 01 May 2023 08:23:18 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id n4-20020a17090a928400b0024c1ac09394sm6159402pjo.19.2023.05.01.08.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 08:23:18 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH] test-ctype: check EOF
References: <cbc7feb9-7e15-77e2-b3e9-1fa194b4d4fb@web.de>
Date:   Mon, 01 May 2023 08:23:17 -0700
In-Reply-To: <cbc7feb9-7e15-77e2-b3e9-1fa194b4d4fb@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sun, 30 Apr 2023 12:00:01 +0200")
Message-ID: <xmqqedo0849m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> The character classifiers are supposed to handle EOF, a negative integer
> value.  It isn't part of any character class.  Extend the ctype tests to
> cover it.

The goal makes sense.

> -static void report_error(const char *class, int ch)
> +static void test(int ch, const char *class, int expect, int actual)
>  {
> +	if (actual == expect)
> +		return;
>  	printf("%s classifies char %d (0x%02x) wrongly\n", class, ch, ch);
>  	rc = 1;
>  }
> @@ -24,9 +26,9 @@ static int is_in(const char *s, int ch)
>  #define TEST_CLASS(t,s) {			\
>  	int i;					\
>  	for (i = 0; i < 256; i++) {		\
> -		if (is_in(s, i) != t(i))	\
> -			report_error(#t, i);	\
> +		test(i, #t, is_in(s, i), t(i));	\
>  	}					\
> +	test(EOF, #t, 0, t(EOF));		\
>  }
>
>  #define DIGIT "0123456789"
> --
> 2.40.1

I am a bit torn on the conversion from report_error() to test(), as
the only "test"-y thing the updated function does is to compare two
of its parameters.  It still is mostly about reporting an error when
something goes wrong.  In other words, the added change could have
been just

	if (t(EOF) != 0)
		report_error(#t, EOF);

after the loop, I think.

The only thing that I am not entirely happy with the end result is
the name of the function, and not how the caller and the callee
divides their work, so it is so miniscule a thing that it won't be
worth our collective time to bikeshed it further.

Let's take it as-is.  Thanks.
