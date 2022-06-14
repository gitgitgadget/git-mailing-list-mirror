Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07CCC43334
	for <git@archiver.kernel.org>; Tue, 14 Jun 2022 23:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240957AbiFNXjD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jun 2022 19:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbiFNXjB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jun 2022 19:39:01 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC7A4ECC0
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 16:39:00 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id x18so7273199qtj.3
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 16:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9V1CaPNigdEIudDCEOi5xwqGQY4EqgdTOsLo7ROH9zk=;
        b=kM2biaJAwF91V4yNwk987e8H6mY8ynUMYk6OuHX4irDiIfgM1Zmab8GVPPXWVY682V
         E3nVNQTp01Je+CAwt8BPWTAjbQH+aTIOhUpGRdaiE8nSeRUer3kngtfxwgDpgFOXs3ZJ
         o/mxTUNIXh81RYkExGVCmAbamG9rLvvbrQbS6Pw42yhN4EDLtOI9kUkCHinE+ZiOzgQh
         dxtZu6zG8HfnGS+upEUkq4vDZB6B9fDfA965k48INsKZOcKu1pzXoAtczFEbG++wXV0G
         F8Rs8hhpkcNDtP0DOXkyl9oB78rC9sEoIApLcLPMk4S39HWnGKv9UnfEDU6ZRpXlxh6p
         6/Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9V1CaPNigdEIudDCEOi5xwqGQY4EqgdTOsLo7ROH9zk=;
        b=A36PW6kucSl/ZM1AI3eahRbFisl8vZUwJwSLU7ACNkNCxPBfVdKPJg7LGStGZtOnQ3
         9ga1Ev/BQKV2hIKex4SPs3xpd8HCNBc7kQjxA7CRq1SLWbfhGgCukX5H8HS86zJ8yNnh
         xY5VGeoSrP426qK3HyydTZjyxt7Yrh4isnsDJqy+6wIz695wQpGiDMA8P8q8WBFn74Hi
         H2DPEqJoQB1Y1CJnJHfI7sitHa8pKQUwhAsCx4ptd3Jb4PwFMe17wrAHTF1ygVkMf3q0
         9YXcfwT2+IXfVb90TYpuw4a83SAT3oDPmArYLCAkHqA9ywqUjt57V6w+7QfldylEJfZi
         X5Eg==
X-Gm-Message-State: AOAM533Tm4DZykdudqQ2vKvoGWR5SQYDuqbBPGVncYA6q2pFlCWRafaK
        cwICA2f1snIPur05ZnxuGiDATw==
X-Google-Smtp-Source: ABdhPJxtouJgOsNIht3FzYf8NF7sjDLiDJ6pCmNZbaUzWm+guQc1dnNemNYda508bzppn0QZRTkbXA==
X-Received: by 2002:ac8:5ac5:0:b0:304:fa16:1227 with SMTP id d5-20020ac85ac5000000b00304fa161227mr6370638qtd.37.1655249939687;
        Tue, 14 Jun 2022 16:38:59 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z3-20020ac86b83000000b00304f3e320f2sm7892734qts.4.2022.06.14.16.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 16:38:59 -0700 (PDT)
Date:   Tue, 14 Jun 2022 19:38:58 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 2/4] t5329: test 'git gc --cruft' without '--prune=now'
Message-ID: <YqkcEhQX4qm7fSer@nand.local>
References: <pull.1261.git.1655242070.gitgitgadget@gmail.com>
 <f59a0c326a01ab5f4e415a7ed03ff046b84b337b.1655242070.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f59a0c326a01ab5f4e415a7ed03ff046b84b337b.1655242070.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 14, 2022 at 09:27:48PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <derrickstolee@github.com>
>
> Replace a 'git repack --cruft -d' with the wrapper 'git gc --cruft' to
> exercise some logic in builtin/gc.c that adds the '--cruft' option to
> the underlying 'git repack' command.
>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  t/t5329-pack-objects-cruft.sh | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/t/t5329-pack-objects-cruft.sh b/t/t5329-pack-objects-cruft.sh
> index b481224b93d..55bb9c0e7b5 100755
> --- a/t/t5329-pack-objects-cruft.sh
> +++ b/t/t5329-pack-objects-cruft.sh
> @@ -451,11 +451,13 @@ test_expect_success 'expiring cruft objects with git gc' '
>  		sort <reachable.raw >reachable &&
>  		comm -13 reachable objects >unreachable &&
>
> -		git repack --cruft -d &&
> +		# Write a cruft pack instead of deleting files.
> +		git gc --cruft &&

These ("git repack --cruft -d" and "git gc --cruft") do the same thing,
so this transformation makes sense.

It may be slightly clearer to refer to "objects" instead of "files",
perhaps like:

    # Write a cruft pack containing all unreachable objects

and then replace:

> +		# Ignore the cruft pack and delete every unreachable object.
>  		git gc --cruft --prune=now &&

with:

    # Prune all unreachable objects from the cruft pack

But I don't think the current wording is a problem, either, so feel free
to take or leave these suggestions.

Quoting from your original coverage report, this should take care of:

Taylor Blau     5b92477f builtin/gc.c: conditionally avoid pruning objects via loose
builtin/gc.c
5b92477f 337) strvec_push(&repack, "--cruft");
5b92477f 338) if (prune_expire)
5b92477f 339) strvec_pushf(&repack, "--cruft-expiration=%s", prune_expire);

so this patch looks good to me.

Thanks,
Taylor
