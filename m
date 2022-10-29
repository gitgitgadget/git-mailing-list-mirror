Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C2B8ECAAA1
	for <git@archiver.kernel.org>; Sat, 29 Oct 2022 20:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiJ2UNw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Oct 2022 16:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiJ2UNv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Oct 2022 16:13:51 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12374DF38
        for <git@vger.kernel.org>; Sat, 29 Oct 2022 13:13:50 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id z3so7135784iof.3
        for <git@vger.kernel.org>; Sat, 29 Oct 2022 13:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+oq5SLp2YRzZMMimu5k2QX6AXZjAlV/uFNfDkwy1avQ=;
        b=VkmHothJoO+Uw1KUv7e1x2UfwHjSINI6P3VHfebik10rFusjsbX+lqHVpyBwp5BiQl
         vUe6rNZup6hnGsYQdHldiTkEqde2xP2ZBZ96VYvsE+tPxfBtAPYcIUvfgx69RWks5r8m
         dx/aQA2EamqGDexn6boQM9/GQkWRkyRHx6R521kHaivPJ+lQrIpXzGTAMz3hLjzHQf3e
         VcrI1Ak08QQxOWujeo1leHniC94nFJ8KZ1PV27AS6aPe5MApEtB1ngZ9LqfnqHuCRJqC
         j3SVASYdJpuKJ2BadVG92uSPJv3PxluJyPbO6lwtBqKO0mwOAnEwfdQGcxGUiVwjm6Sg
         sJqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+oq5SLp2YRzZMMimu5k2QX6AXZjAlV/uFNfDkwy1avQ=;
        b=ZznUf/YIl9MdNUBt5k+H59og/2sD5nRQUH4X4tFYms0+9yPzRGFVeqafgumDMN1lD5
         4xlqY7y6E+2A2L4FjeJuX10gCsh24HkizpXMVe2SOzfX3vr6mwCGmZYEkthyA7GS5+eE
         GiLzH4GM7SfuqJoknMxXn2TIJOykw4Lho+MBUF7VztnG9mZombj3d/3bAYaTbN+ZUkCv
         6W0rkbvQRCW8D8Hy3EXPJW4y+YedGCZMiYK5p9WmfjQLE2RlfRKzq/eZ4zUTE3GAQ1Uq
         44jCrr0D311mE0r0JY/9Ams/IqqB+WWT04ZikzLQB4+sYsSb81HfGr+aAKNighEt1wcd
         Sr2w==
X-Gm-Message-State: ACrzQf2dVxx5FlqVfCcqutdAU7b/pKEEWT8Mogu4K5Be6qJ/QimzRyZY
        lH2ThKHxmUl1FTyTaPU0lMl9yQ==
X-Google-Smtp-Source: AMsMyM5NwWRL3Wgux80C15q1ICXkTEnJFIa4sLROcAKZBQ45QzuUOeqSfZiEd8c6WlBCq/JzZ1HSig==
X-Received: by 2002:a05:6638:3282:b0:33f:6ed0:4c83 with SMTP id f2-20020a056638328200b0033f6ed04c83mr3090052jav.96.1667074430119;
        Sat, 29 Oct 2022 13:13:50 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y98-20020a02956b000000b003639ef62d08sm926395jah.84.2022.10.29.13.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 13:13:49 -0700 (PDT)
Date:   Sat, 29 Oct 2022 16:13:48 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Calvin Wan <calvinwan@google.com>
Subject: Re: [PATCH 2/3] submodule tests: reset "trace.out" between "grep"
 invocations
Message-ID: <Y12JfADN/YRr9IaJ@nand.local>
References: <cover-0.3-00000000000-20221029T025520Z-avarab@gmail.com>
 <patch-2.3-708375e3104-20221029T025520Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-2.3-708375e3104-20221029T025520Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 29, 2022 at 04:59:46AM +0200, Ævar Arnfjörð Bjarmason wrote:
> diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
> index 75da8acf8f4..b9546ef8e5e 100755
> --- a/t/t5526-fetch-submodules.sh
> +++ b/t/t5526-fetch-submodules.sh
> @@ -178,6 +178,7 @@ test_expect_success "submodule.recurse option triggers recursive fetch" '
>  '
>
>  test_expect_success "fetch --recurse-submodules -j2 has the same output behaviour" '
> +	test_when_finished "rm -f trace.out" &&
>  	add_submodule_commits &&
>  	(
>  		cd downstream &&
> @@ -705,15 +706,22 @@ test_expect_success "'fetch.recurseSubmodules=on-demand' works also without .git
>
>  test_expect_success 'fetching submodules respects parallel settings' '
>  	git config fetch.recurseSubmodules true &&
> +	test_when_finished "rm -f downstream/trace.out" &&

These two seem OK to me, but...

>  	(
>  		cd downstream &&
>  		GIT_TRACE=$(pwd)/trace.out git fetch &&
>  		grep "1 tasks" trace.out &&
> +		>trace.out &&
> +

I fail to see why these hunks are necessary. If we specify GIT_TRACE,
and don't have a test_must_fail around the execution, then why should we
feel obligated to clean up the trace.out after every execution?

If we really are concerned about not cleaning up after ourselves, how
about writing to a separate file each time?

Thanks,
Taylor
