Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B654C433F5
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 07:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234764AbiBOHUT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 02:20:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232421AbiBOHUS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 02:20:18 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8773EEBDF9
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 23:20:08 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id hw13so13708972ejc.9
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 23:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=KbrhSiBEU3fDofXW73ZMSRLmBep2x+k5p80tcgTsex4=;
        b=PHgQOGgaMqBIT7DLM0Met9FoMDB14ZJZ/nuYcKcQI2MBu8zImk2KaXF8pMo1Q3hTzu
         ySvpJTYlP3DNgN4L8ckxzUsdJ3c1bapIwmFc/XrhehexAdKhPWWr4KI/tj22i4r3ZHnU
         63z962mIOKg0xquRqmWJHlWyqiHJcs3YOi23jh3MOZjW9Kbssux3SGrlZFQiH2jq0CcV
         uDyjCxE+6d1ZGa/Pspt+vXn1Hw7pEImq+KRWoiljtfMr4Y6uApiz4GnbP156lb5l/S6z
         DbnXK5ynMM8ygDs5zYF3VQ1sEW3rMhEcXgYypwQCsVBdnfZN7vtzctQ9YUVD4wi+kr1O
         o0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=KbrhSiBEU3fDofXW73ZMSRLmBep2x+k5p80tcgTsex4=;
        b=BzSEGAxgZy9vUO2zvh9/EUznhvkFtg1s9BZPLfBGpMW8ewwzwzPMIHEUk3l5GjJwWL
         V3JPqLPIq1xNGmxe04gBJRZkJQT43MT/eZU+JMdBNLuWmNlnWxPzy+pQKEtGw9WM96TK
         cEt9ZCIkF63l2lTSaQbD2zsq9CHZOlCXeRaMi1iI1c37vYUG0HbsSxSHjctQPIGeVTZY
         dX38M0hBhycFAi3n3c4ZEogprqnxU7iO5n5ccgKxRTjLq0NYAPP2KYDlnlxbOks1ZfM0
         ppWPwap9x3Y6ibiMgQbh1rY5fGqvVCDxM4Z805zjoCBmUaXGwtbqNyyE30utTZhex2hM
         mOEw==
X-Gm-Message-State: AOAM533aIYWhQ0DDzAge0tSYur9ZM7jvpqO5kWOIeUDSxAgdTwcysrNs
        xmbXfAiLa4zae7w2BORRDgQ=
X-Google-Smtp-Source: ABdhPJysjGR+PGxqcy7X+FXLBE3l4cuaQ9N6ZBkKhizq/0OfYKSes5mOIK9xD8IKJEYhdcAi0H+RzQ==
X-Received: by 2002:a17:907:86a1:: with SMTP id qa33mr1880095ejc.516.1644909606456;
        Mon, 14 Feb 2022 23:20:06 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id p21sm10696073edu.107.2022.02.14.23.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 23:20:05 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nJs85-002AUY-Fi;
        Tue, 15 Feb 2022 08:20:05 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] name-rev: test showing failure with non-monotonic
 commit dates
Date:   Tue, 15 Feb 2022 08:15:58 +0100
References: <20220214210136.1532574-1-jacob.e.keller@intel.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <20220214210136.1532574-1-jacob.e.keller@intel.com>
Message-ID: <220215.868rucy4t6.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 14 2022, Jacob Keller wrote:

> From: Jacob Keller <jacob.keller@gmail.com>
>
> If a commit in a sequence of linear history has a non-monotonically
> increasing commit timestamp, git name-rev will not properly name the
> commit.
>
> However, if you use --annotate-stdin then the commit does actually get
> picked up and named properly.
>
> Analyzing the source, it appears to be caused by the cutoff logic which
> is some sort of heuristic which relies on monotonically increasing
> commit dates.
>
> This seems like the cutoff using commit date is some sort of heuristic
> which reduces the cost of describing something.. but --annotate-stdin
> and --all don't use it.
>
> In the example setup I could do:
>
> echo "<commit id>" | git name-rev --annotate-stdin
>
> and get the expected result without the cutoff logic, and it seems at
> least on small repositories to be as fast as the normal attempt, except
> it produces accurate results.
>
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---
>  t/t6120-describe.sh | 62 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
>
> diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
> index 9781b92aeddf..e9f897e42591 100755
> --- a/t/t6120-describe.sh
> +++ b/t/t6120-describe.sh
> @@ -488,6 +488,68 @@ test_expect_success 'name-rev covers all conditions while looking at parents' '
>  	)
>  '
>  
> +# A-B-C-D-E-main
> +#
> +# Where C has a non-monotonically increasing commit timestamp w.r.t. other
> +# commits
> +test_expect_success 'non-monotonic commit dates setup' '
> +	git init non-monotonic &&
> +	(
> +		cd non-monotonic &&
> +
> +		echo A >file &&
> +		git add file &&
> +		GIT_COMMITTER_DATE="2020-01-01 18:00" git commit -m A &&
> +
> +		echo B >file &&
> +		git add file &&
> +		GIT_COMMITTER_DATE="2020-01-02 18:00" git commit -m B &&
> +
> +		echo C >file &&
> +		git add file &&
> +		GIT_COMMITTER_DATE="2005-01-01 18:00" git commit -m C &&
> +
> +		echo D >file &&
> +		git add file &&
> +		GIT_COMMITTER_DATE="2020-01-04 18:00" git commit -m D &&
> +
> +		echo E >file &&
> +		git add file &&
> +		GIT_COMMITTER_DATE="2020-01-05 18:00" git commit -m E
> +	)

Shorter & avoids the needless subshell as:

    git init repo &&
    test_commit -C repo --date="2020-01-01 18:00" A &&
    test_commit -C repo --date="2020-01-02 18:00" B &&
    [...]


> +test_expect_failure 'name-rev commit timestamp prevents naming commits' '
> +	(
> +		cd non-monotonic &&
> +
> +		B=$(git rev-parse main~3) &&
> +
> +		echo "$B main~3" >expect &&
> +		git name-rev $B >actual &&
> +
> +		test_cmp expect actual
> +	)
> +'

I haven't checked, but is the explicit peeling to $B really needed here,
are the results different with a main~3 or main~3^{commit}?

I.e. the first column of the output will of course be, but will the
result on the second column? I suspect not, but haven't run this. In any
case I tihnk teh test/commit message could do with an explanation.

> +test_expect_success 'name-rev --all works with non-monotonic' '
> +	(
> +		cd non-monotonic &&
> +
> +		cat >expect <<EOF &&

You can use "<<-\EOF" here so you can indent these:

> +main
> +main~1
> +main~2
> +main~3
> +main~4
> +EOF
> +
> +		git log --pretty=%H | git name-rev --annotate-stdin --name-only >actual &&

Don't use "git" on the LHS of a pipe, in case it segfaults, so:

    git log [...] >revs &&
    git name-rev [...] <revs >actual

> +
> +		test_cmp expect actual
> +	)
> +'
> +
>  #               B
>  #               o
>  #                \

