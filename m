Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2548920401
	for <e@80x24.org>; Wed, 21 Jun 2017 21:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752172AbdFUVcT (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 17:32:19 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36787 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751133AbdFUVcS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 17:32:18 -0400
Received: by mail-pg0-f66.google.com with SMTP id e187so21323212pgc.3
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 14:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=l8ZG8P5q/jGUUqN38g+EH13u2h/oqcItvWeETtithp8=;
        b=d4uWi1poCasElR1o21MWtHp9RVD+8cZJw5S7bNqWZN4M57g6eEjTJc9pFxUKO1Ns2w
         KM37798cJxmFdmXWYQMAp33iuLOi7MBOMnC7IrgV0Z8ll2u3w5vfklOLwftTWUHAtuxq
         kxmJleD0vq8LjhyNZA7dy9ew2gZgjT0942u5h0dis4FTS8ftTCExbo+Pg//7mBWw98KH
         WeXlzGkAa8GC1VLDKZAQxPfBK7XNgWS1n4401u+nci3+KOkSVG6dHo9E5jDKvzEYkXWA
         z2r/4dmPTTEV8rS3B5PFv+z0U9JUYYZScPQGGXfL3yQEDR5+7g6QQOUYrm7gA3BKaVpX
         7K9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=l8ZG8P5q/jGUUqN38g+EH13u2h/oqcItvWeETtithp8=;
        b=IrcTSsg3cDvzJwDxYSe2r8OY3iaqJ50umy7R8iWNZff5W181YgBL9V7LnCw66MuutB
         iq3eIlibfYeucZ7ZpucV5dfzgDPRF9dWrfinbmG0QAr281vBbpdLB3kWCfYC+lTDch3y
         7i9H7ALMUf6uujYmv5hYw4T5CrRfGQLO72DG5Dt+WhxXbjFdZNbPz/d3/wJM34TDPjEq
         he86Vf0aTI6FHkdM3bRey9z5MS6y7qNhTG0laNK8uXbbOupRojiNg4lBOkg6w5fP93vr
         oekBZrJUUdsDdbOD+jlUmrB1dAkGm1rcrKiflFQcxk3zMLOfZ3gLe9F+BaJ4PNRe+clt
         Kw6Q==
X-Gm-Message-State: AKS2vOyZSE91eDzGzKe7shsqulayLoGk/VUG1tF0kSqsHPLIN9dAPDWH
        Mx43lHLLruOhf3uBlpQ=
X-Received: by 10.84.132.40 with SMTP id 37mr17561734ple.141.1498080737505;
        Wed, 21 Jun 2017 14:32:17 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b0bd:d7d3:4f2e:5016])
        by smtp.gmail.com with ESMTPSA id u9sm989748pfg.127.2017.06.21.14.32.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 21 Jun 2017 14:32:16 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>,
        Simon Ruderich <simon@ruderich.org>
Subject: Re: [PATCH v2] die(): stop hiding errors due to overzealous recursion guard
References: <87podz8v6v.fsf@gmail.com>
        <20170621204742.15722-1-avarab@gmail.com>
Date:   Wed, 21 Jun 2017 14:32:16 -0700
In-Reply-To: <20170621204742.15722-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 21 Jun 2017 20:47:42 +0000")
Message-ID: <xmqq1sqdni1r.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> So let's just set the recursion limit to a number higher than the
> number of threads we're ever likely to spawn. Now we won't lose
> errors, and if we have a recursing die handler we'll still die within
> microseconds.
>
> There are race conditions in this code itself, in particular the
> "dying" variable is not thread mutexed, so we e.g. won't be dying at
> exactly 1024, or for that matter even be able to accurately test
> "dying == 2", see the cases where we print out more than one "W"
> above.

One case I'd be worried about would be that the race is so bad that
die-is-recursing-builtin never returns 0 even once.  Everybody will
just say "recursing" and die, without giving any useful information.

Will queue, as it is nevertheless an improvement over the current
code.

Thanks.

>  usage.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/usage.c b/usage.c
> index 2f87ca69a8..1ea7df9a20 100644
> --- a/usage.c
> +++ b/usage.c
> @@ -44,7 +44,23 @@ static void warn_builtin(const char *warn, va_list params)
>  static int die_is_recursing_builtin(void)
>  {
>  	static int dying;
> -	return dying++;
> +	/*
> +	 * Just an arbitrary number X where "a < x < b" where "a" is
> +	 * "maximum number of pthreads we'll ever plausibly spawn" and
> +	 * "b" is "something less than Inf", since the point is to
> +	 * prevent infinite recursion.
> +	 */
> +	static const int recursion_limit = 1024;
> +
> +	dying++;
> +	if (dying > recursion_limit) {
> +		return 1;
> +	} else if (dying == 2) {
> +		warning("die() called many times. Recursion error or racy threaded death!");
> +		return 0;
> +	} else {
> +		return 0;
> +	}
>  }
>  
>  /* If we are in a dlopen()ed .so write to a global variable would segfault
