Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCE5C433FE
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 17:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237019AbiAMRPD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 12:15:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234624AbiAMRPA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 12:15:00 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52AC2C061574
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 09:15:00 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id u25so25662695edf.1
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 09:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=PZT4rHQ+crInA3lOkjXEXqYpuO5zcmOYVJZ14dZ9vyk=;
        b=fBQXxWlLTwyCT6d173TcAMMvF1wIv5R22P7nZDvfsjxETEatLEaJmgDYQ3P7VGw4aO
         ekwxTfNY0fUolsg1vXSE49BXllhxf4qpvU7SToUtGHIA9/fSydMOwWBQoVV6ZaA5pIKn
         T/bdZWD/wlUZNEHSOYyb1pGX9BPkeTjnYzRs8wGLZcehQeZTe3fZGVeRlPUd/H5JOhAX
         seeDUDiVMICJLM/lfV5S3gavZxTK1KRQ/EbEO+lqsyDUAR8vqe+5nNUgencm6atkKipd
         gbSbuK0LRwcFx0O/Ev6e+aaHpiA7Wmu4Xotl2L69uyQNp4QFBi6mTWTbXvYDY40QILRJ
         DMlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=PZT4rHQ+crInA3lOkjXEXqYpuO5zcmOYVJZ14dZ9vyk=;
        b=EIm6dwOSE+5z0wx0+e4zh1fRdv2kd0mOY2GekZnUYDW7n6uEBxLEEaVNpLNoBnRH35
         z6Ev+x1aUPymxWJWpC7JnWd4RmcoVAVwhVW00cBZNv9T5rLaeCfw8jWrLPqa1KiC3Azk
         r+jhPIR2JrVvVZwVKMPEYB/+vYustzgedlAj+EttVyAYOu8FfpKAiEbPsmTB1NTJAFIN
         BQRZn/ZGGYsOCJv3mHf6rr04yNpf2vJ18qzkE3DXmPkzpyl1X+D4qqmBI4vhhOXiAM7s
         +KELy+M3vQARn5fjf7yTcyoE9Ohhas3tjQkl3JzjuK6cegVmHAnKyn4bicE08d0P4Rud
         eFmw==
X-Gm-Message-State: AOAM5303kaTUkqPoCHoFOWg8j9AIti4OQkB06RuPnkpme8LBehEVsze4
        2Wt6DXTO1SuhqyM6iKBCDTmmJK8XFE1l5w==
X-Google-Smtp-Source: ABdhPJwgUUa7hZsp/VR37aQrzaP80isBCdbpcIuBKZE4aB7LSfUFPwLyP9v8GaNtbzlH6svVZ65ZhQ==
X-Received: by 2002:a17:906:7942:: with SMTP id l2mr4491323ejo.730.1642094098144;
        Thu, 13 Jan 2022 09:14:58 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id ay23sm643251ejb.208.2022.01.13.09.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 09:14:57 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n83gf-0011oJ-1i;
        Thu, 13 Jan 2022 18:14:57 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH] reftable: avoid initializing structs from structs
Date:   Thu, 13 Jan 2022 18:13:14 +0100
References: <pull.1188.git.git.1642092934523.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <pull.1188.git.git.1642092934523.gitgitgadget@gmail.com>
Message-ID: <220113.86r19btv5a.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jan 13 2022, Han-Wen Nienhuys via GitGitGadget wrote:

> From: Han-Wen Nienhuys <hanwen@google.com>

Ah, nevermind <220113.86v8yntxfb.gmgdl@evledraar.gmail.com>, so you
meant *want[] :)

I can confirm that this works on the xlc version that errored on this
before, the reftable tests even pass!

> Apparently, the IBM xlc compiler doesn't like this.

Would make sense to steal the compiler version etc. details from my
<patch-1.1-7425b64c0a0-20220113T113821Z-avarab@gmail.com>. I.e. eventually
we'll be able to change this & other code back, as nobody will care
about that older compiler version. It worked before in the pre-image on
a more recent xlc.

> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>     reftable: avoid initializing structs from structs
>     
>     Apparently, the IBM xlc compiler doesn't like this.
>     
>     Signed-off-by: Han-Wen Nienhuys hanwen@google.com
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1188%2Fhanwen%2Freftable-xlc-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1188/hanwen/reftable-xlc-v1
> Pull-Request: https://github.com/git/git/pull/1188
>
>  reftable/merged_test.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/reftable/merged_test.c b/reftable/merged_test.c
> index 24461e8a802..abd34849fca 100644
> --- a/reftable/merged_test.c
> +++ b/reftable/merged_test.c
> @@ -207,11 +207,11 @@ static void test_merged(void)
>  		},
>  	};
>  
> -	struct reftable_ref_record want[] = {
> -		r2[0],
> -		r1[1],
> -		r3[0],
> -		r3[1],
> +	struct reftable_ref_record *want[] = {
> +		&r2[0],
> +		&r1[1],
> +		&r3[0],
> +		&r3[1],
>  	};
>  
>  	struct reftable_ref_record *refs[] = { r1, r2, r3 };
> @@ -250,7 +250,7 @@ static void test_merged(void)
>  
>  	EXPECT(ARRAY_SIZE(want) == len);
>  	for (i = 0; i < len; i++) {
> -		EXPECT(reftable_ref_record_equal(&want[i], &out[i],
> +		EXPECT(reftable_ref_record_equal(want[i], &out[i],
>  						 GIT_SHA1_RAWSZ));
>  	}
>  	for (i = 0; i < len; i++) {
> @@ -345,10 +345,10 @@ static void test_merged_logs(void)
>  			.value_type = REFTABLE_LOG_DELETION,
>  		},
>  	};
> -	struct reftable_log_record want[] = {
> -		r2[0],
> -		r3[0],
> -		r1[1],
> +	struct reftable_log_record *want[] = {
> +		&r2[0],
> +		&r3[0],
> +		&r1[1],
>  	};
>  
>  	struct reftable_log_record *logs[] = { r1, r2, r3 };
> @@ -387,7 +387,7 @@ static void test_merged_logs(void)
>  
>  	EXPECT(ARRAY_SIZE(want) == len);
>  	for (i = 0; i < len; i++) {
> -		EXPECT(reftable_log_record_equal(&want[i], &out[i],
> +		EXPECT(reftable_log_record_equal(want[i], &out[i],
>  						 GIT_SHA1_RAWSZ));
>  	}
>  
>
> base-commit: 1ffcbaa1a5f10c9f706314d77f88de20a4a498c2

