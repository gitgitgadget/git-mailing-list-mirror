Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7967DC433F5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 01:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EEF261B2B
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 01:33:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353344AbhKPBga (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 20:36:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242114AbhKOSeV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 13:34:21 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C226CC04A198
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 09:46:30 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id m20so29686890edc.5
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 09:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=fNJRcubWHl89S7w5oFJ/9D5Xy/Z7lZV7IRHL7S3IrA4=;
        b=l/QorR1jBqfdGomEUZ8R8xUA18aat+VatvJ1epYTRQZn4Crhr4hxyDjE+mQGjW0cmE
         y7OPgO8mISVwj/2VVJt3UHOt7QyJq7V23tJniTxaNUkvggMkj4b864pQu2LZAilC6MOe
         EnHLoqbbxiMSWZvxagEs2T0n+7gvXcAj91KYwaKc/D10UvQSuhpyD8mr8E1bTm+7ySXA
         I4SP4xa8Cw4AteF7wx5WN4S18o88Q98bp6gfWalL+AZv0AGVJcyjGq74M53dwMjjGhCN
         TdP+aBqy5CXEYIfAhW3/MEMTvqRWFnLYs4nZQDtkwm9TThk86Eh6pwi/fa/SK3KrsZsT
         5jyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=fNJRcubWHl89S7w5oFJ/9D5Xy/Z7lZV7IRHL7S3IrA4=;
        b=d/zazCiIe2fAg33yvTQQA7Y6NWSmcVKXkDlpAZfW4vBc4l9QBu79hoevqvfgDoBvmV
         wxMDjZQc+v5zTyo0IGxiLPCax7JYaGoV2wBhpkObvjSU2+LR8KZuYkRqXa2uG3a9g7mU
         umTbisCKfavOP0uB20vQ8yWa9IpR7s1oZ/oUF2dg/j6Q81xqsCakpOyTTbdyA/EHCeSS
         Gb+V0s4EmDhdLD3QomWpi+bh+kAbmPaFviv/XiR37MbzfULod2zZx+7HsBiIy4Lh86wr
         K5qW/0wpq8tdjPI0Gv6KJUkMmHlS0cPIGBWIpJGFnCuUKuBtHKqEQXzCEBrd/gCl/4k5
         8k6A==
X-Gm-Message-State: AOAM530XhEVlBlR8bUyClwPZHI3aNp6L9bmd1A5K0eBsKuQcLXCFjATI
        GHzNVutRTP7P1Dw6QZA8jYs=
X-Google-Smtp-Source: ABdhPJztthLUJZVk8RAwAyk+luNAX+yyGISMDEjmYd0OIEU2BP8oUOHEDEjPbS6vIC0vvsyC9oyerQ==
X-Received: by 2002:a17:907:2bd0:: with SMTP id gv16mr900841ejc.121.1636998389313;
        Mon, 15 Nov 2021 09:46:29 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id de15sm6894235ejc.70.2021.11.15.09.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 09:46:28 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mmg3n-001ABA-Ky;
        Mon, 15 Nov 2021 18:46:27 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Adam Dinwoodie <adam@dinwoodie.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] test-lib: show missing prereq summary
Date:   Mon, 15 Nov 2021 18:44:14 +0100
References: <20211115160750.1208940-1-fs@gigacodes.de>
 <20211115160750.1208940-2-fs@gigacodes.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <20211115160750.1208940-2-fs@gigacodes.de>
Message-ID: <211115.865ysts45o.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 15 2021, Fabian Stelzer wrote:

> When running the full test suite many tests can be skipped because of
> missing prerequisites. It not easy right now to get an overview of which
> ones are missing.
> When switching to a new machine or environment some libraries and tools
> might be missing or maybe a dependency broke completely. In this case
> the tests would indicate nothing since all dependant tests are simply
> skipped. This could hide broken behaviour or missing features in the
> build. Therefore this patch summarizes the missing prereqs at the end of
> the test run making it easier to spot such cases.
>
>  - Add failed prereqs to the test results.
>  - Aggregate and then show them with the totals.
>
> Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
> ---
>  t/aggregate-results.sh | 17 +++++++++++++++++
>  t/test-lib.sh          | 11 +++++++++++
>  2 files changed, 28 insertions(+)
>
> diff --git a/t/aggregate-results.sh b/t/aggregate-results.sh
> index 7913e206ed..87c16fcee1 100755
> --- a/t/aggregate-results.sh
> +++ b/t/aggregate-results.sh
> @@ -6,6 +6,7 @@ success=0
>  failed=0
>  broken=0
>  total=0
> +missing_prereq=
>  
>  while read file
>  do
> @@ -30,10 +31,26 @@ do
>  			broken=$(($broken + $value)) ;;
>  		total)
>  			total=$(($total + $value)) ;;
> +		missing_prereq)
> +			missing_prereq="$missing_prereq,$value" ;;
>  		esac
>  	done <"$file"
>  done
>  
> +if test -n "$missing_prereq"
> +then
> +	unique_missing_prereq=$(
> +		echo $missing_prereq |
> +		tr -s "," "\n" |
> +		grep -v '^$' |
> +		sort -u |
> +		paste -s -d ',')

What is paste? Some out-of-tree debugging utility?

I think you might find a better way to do this shown in my
"ab/generate-command-list" topic, currently in seen. It removed most of
the same sort of tr|grep|sort etc. chain in generate-cmdlist.sh.
