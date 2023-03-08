Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76710C64EC4
	for <git@archiver.kernel.org>; Wed,  8 Mar 2023 17:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjCHRmV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 12:42:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjCHRmC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 12:42:02 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B051ACC3
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 09:41:33 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id i10so18374642plr.9
        for <git@vger.kernel.org>; Wed, 08 Mar 2023 09:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678297292;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5au5oAFOSjK32bqi5X+yjwOYy/7phs3b70ykVEm4ByQ=;
        b=lyUmyQ+HKE/gUNxRV1H5nmq1zB2vREOV2chc+cA3/KMdIfsKfpNFY8OwjKk5QwYgj1
         j5SCyyFvjSWFSVk4AX0FAXLAgtnJhFJfjy+rMref1FqzCx/obV4q/zKwWkQf3/wEMivm
         uT7D3BBs5K1tyAre+47v0ssg3sckw78EYuy3hU0b4tMbCqbgowk1H1gjkrUv6qjsdrnZ
         MG9swT89csRz0Tddb8ODFATDCW9mIUPblfLgrBmCwDLCsF/m2OZkldsO0NGVRqYoA4Gl
         2GqvldqM9w9zZV29o86yOXGJugSrAa9X1mjue0vD+s/H1I17OBfG2qPGqJnjDhgADMt5
         tHFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678297292;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5au5oAFOSjK32bqi5X+yjwOYy/7phs3b70ykVEm4ByQ=;
        b=Z/3/2/GkFWfUpVH2LAd1KmTP83hTOs7tMra9hoGgAoIQrHf7OlGJkGz/J9R7M/dNk2
         x+2Wa6Ui9NPDHDo/gu2PRXlvww8iypU7mJ7EF2xRkbOhTmhaaVPdqQnwcnmBdzFWCLrF
         DXG4xnz3ShAhlrCdvlVwFs9anEJbfTSEoitCN8cxVCzDEOqHIUlP1gVdEJ+qo0ETddru
         q5hjI177QEuwzz54hJpAdmRkEZ0pWfsHfiBuiDKYd4lUpYcMI4Ms5u6S3L9T4apsCJZS
         ivmCpFvoT2tIc3+Uo22G7wdnepx7fcHH+arILQNHaGnynqgGc7Diqfv8QW4yhhHqMmlv
         CIgA==
X-Gm-Message-State: AO0yUKVpvkDGgrlVfVb9++JnS1f0BsIgRzS27J+cVvSstpM4GEoD9N98
        vD8a+kh5rt8m+t+D5GPDsS6CISNks0I=
X-Google-Smtp-Source: AK7set+clBilNLFd0RPu521rU2MDor7JB/GfAKTxQkCO3MsqBE+TJMVqNNo55cNe20yqcl8prlCZ1w==
X-Received: by 2002:a17:902:e88b:b0:19a:b869:f2f8 with SMTP id w11-20020a170902e88b00b0019ab869f2f8mr25627898plg.21.1678297291957;
        Wed, 08 Mar 2023 09:41:31 -0800 (PST)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id u7-20020a17090341c700b001992fc0a8eesm1232064ple.174.2023.03.08.09.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 09:41:31 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] fetch: pass --no-write-fetch-head to subprocesses
References: <20230308100438.908471-1-e@80x24.org>
Date:   Wed, 08 Mar 2023 09:41:31 -0800
In-Reply-To: <20230308100438.908471-1-e@80x24.org> (Eric Wong's message of
        "Wed, 8 Mar 2023 10:04:38 +0000")
Message-ID: <xmqqwn3rta2c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> Subject: Re: [PATCH] fetch: pass --no-write-fetch-head to subprocesses

I read the title as saying that "git fetch --recurse-submodules
--no-write-fetch-head" should propagate the latter option down to
fetches done in submodules, but looking at the added test, you are
addressing a different use case, aren't you?  Or are you covering
both "fetch: honor --no-write-fetch-head when fetching from multiple
remotes" and "fetch: pass --no-write-fetch-head down to submodules"?

> It seems a user would expect this option would work regardless
> of whether it's fetching from a single remote or many.

This hints that it is only the latter, but if we are covering both

 (1) the title we have here may be alright.

 (2) the proposed log message should state the change affects both
     (in a good way).

 (3) the other half may want to be tested in new test as well.

Thanks.

> Signed-off-by: Eric Wong <e@80x24.org>
> ---
>  I haven't checked if there's other suitable options which could
>  go into add_options_to_argv(); hopefully someone else can check :>
>
>  builtin/fetch.c           | 2 ++
>  t/t5514-fetch-multiple.sh | 7 +++++++
>  2 files changed, 9 insertions(+)
>
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index a09606b472..78513f1708 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1880,6 +1880,8 @@ static void add_options_to_argv(struct strvec *argv)
>  		strvec_push(argv, "--ipv4");
>  	else if (family == TRANSPORT_FAMILY_IPV6)
>  		strvec_push(argv, "--ipv6");
> +	if (!write_fetch_head)
> +		strvec_push(argv, "--no-write-fetch-head");
>  }
>  
>  /* Fetch multiple remotes in parallel */
> diff --git a/t/t5514-fetch-multiple.sh b/t/t5514-fetch-multiple.sh
> index 54f422ced3..98f034aa77 100755
> --- a/t/t5514-fetch-multiple.sh
> +++ b/t/t5514-fetch-multiple.sh
> @@ -58,6 +58,13 @@ test_expect_success 'git fetch --all' '
>  	 test_cmp expect output)
>  '
>  
> +test_expect_success 'git fetch --all --no-write-fetch-head' '
> +	(cd test &&
> +	rm -f .git/FETCH_HEAD &&
> +	git fetch --all --no-write-fetch-head &&
> +	test_path_is_missing .git/FETCH_HEAD)
> +'
> +
>  test_expect_success 'git fetch --all should continue if a remote has errors' '
>  	(git clone one test2 &&
>  	 cd test2 &&
