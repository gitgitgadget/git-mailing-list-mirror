Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35EE1C433F5
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 18:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352781AbiCXTAA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 15:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352777AbiCXS77 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 14:59:59 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4FE2611C
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 11:58:25 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id r11so3811099ila.1
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 11:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=V2cwCmz1khs865eFiRYUSHw86KsIJFWHcwpMcINUHx4=;
        b=MpN+Tx4Mn+CDjg7h39ar8GOIX6vWw55azpYvfr+DtE0tHFg1pCLgji5q04ti6nlZSO
         /nBTFugNcq41fpIrO9UFTqR79xTbRDOocFG9HfqtgRPDe30pGfyqeVe1pMM+ohZ/fp88
         rLgD5gbzgBzN8nO7d1AN6rGRRH/6FkG5UDcK9wnLaVXnnYt+SGhEZhZ5X4YemN2qUf/i
         8JFF5Np0TTI3PrkpdNA9Ag5fa7Hjy/NsPSU1iJJ3eeTffmdCefnz9WUPUYMD6VjRfkx4
         xEshu+WiQEOMyyWQYbqIyoF6EfTxDPUPlQkV9ahwNUswda7Vjg3+EaF4bscij6yeffso
         RGdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V2cwCmz1khs865eFiRYUSHw86KsIJFWHcwpMcINUHx4=;
        b=OFEcrCjRwmSsg2IMmh3keCBtosqPweH34xWj69ysxZCIRIgrbDIMtBXnAP1iDn7RTa
         oqQLFtiL8BavuPr+RbKeqsr1wxTGSCDms/a8h6aiOroWJ+LIm/cQx8p+QC1pAn0lxPFl
         BHeKmHi522H8sENXOmWq5kj/Tjgn8AvQhHWC1xzwx4quQfi2eOBAHc1GhR9Qx4mbL/nD
         JLkbR1SaVEBLrv1+RLCMlfHjDYiyfFcVA+Difz9tXpaYQ6MmTFkOnSaMoFq0/ya33UvC
         PClRl+8mvwBxtpFtmTC9nA7WO+vS3oNtrZHeXfjAXr8ObBPcKd2+S1yzWzzfk+mWWjM0
         mH/w==
X-Gm-Message-State: AOAM531PKdgk76cFJUAnzXaUufPTcBvLzq1wiwYsGgk8y1SLbiT6Kvad
        CnPDZP0ORXSgcnA5HlQJ+g0XNA==
X-Google-Smtp-Source: ABdhPJwQAG3FD08hKDg8DIL42PQG5hO7uIi4jpeELbnbCGBpcvTaBauxNHTkhJ+wzAmsz17R+E0kUw==
X-Received: by 2002:a05:6e02:164e:b0:2c8:442e:5b49 with SMTP id v14-20020a056e02164e00b002c8442e5b49mr3361082ilu.109.1648148305179;
        Thu, 24 Mar 2022 11:58:25 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i15-20020a056e02152f00b002c7fb986a1dsm1988092ilu.34.2022.03.24.11.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 11:58:24 -0700 (PDT)
Date:   Thu, 24 Mar 2022 14:58:24 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        chakrabortyabhradeep79@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 1/2] t7700: check post-condition in kept-pack test
Message-ID: <Yjy/UIydKw7v+4+7@nand.local>
References: <pull.1185.git.1647894845421.gitgitgadget@gmail.com>
 <pull.1185.v2.git.1648146897.gitgitgadget@gmail.com>
 <f2f8d12929bcbd630b2de3ce770a6763989ffcff.1648146897.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f2f8d12929bcbd630b2de3ce770a6763989ffcff.1648146897.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 24, 2022 at 06:34:56PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <derrickstolee@github.com>
>
> The '--write-midx -b packs non-kept objects' test in t7700-repack.sh
> uses test_subcommand_inexact to check that 'git repack' properly adds
> the '--honor-pack-keep' flag to the 'git pack-objects' subcommand.
> However, the test_subcommand_inexact helper is more flexible than
> initially designed, and this instance is the only one that makes use of
> it: there are additional arguments between 'git pack-objects' and the
> '--honor-pack-keep' flag. In order to make test_subcommand_inexact more
> strict, we need to fix this instance.
>
> This test checks that 'git repack --write-midx -a -b -d' will create a
> new pack-file that does not contain the objects within the kept pack.
> This behavior is possible because of the multi-pack-index bitmap that
> will bitmap objects against multiple packs. Without --write-midx, the
> objects in the kept pack would be duplicated so the resulting pack is
> closed under reachability and bitmaps can be created against it. This is
> discussed in more detail in e4d0c11c0 (repack: respect kept objects with
> '--write-midx -b', 2021-12-20) which also introduced this instance of
> test_subcommand_inexact.
>
> To better verify the intended post-conditions while also removing this
> instance of test_subcommand_inexact, rewrite the test to check the list
> of packed objects in the kept pack and the list of the objects in the
> newly-repacked pack-file _other_ than the kept pack. These lists should
> be disjoint.
>
> Be sure to include a non-kept pack-file and loose objects to be extra
> careful that this is properly behaving with kept packs and not just
> avoiding repacking all pack-files.

Nicely put.

> Co-authored-by: Taylor Blau <me@ttaylorr.com>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>

And to be clear, I am totally OK with this usage of my signed-off-by.

> diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
> index 770d1432046..73452e23896 100755
> --- a/t/t7700-repack.sh
> +++ b/t/t7700-repack.sh
> @@ -369,10 +369,56 @@ test_expect_success '--write-midx with preferred bitmap tips' '
>  	)
>  '
>
> +get_sorted_objects_from_packs () {
> +	git show-index <$(cat) >raw &&

It seems a little odd to me to pass the name of a single file as input
to get_sorted_objects_from_packs over stdin. I probably would have
expected something like `git show-index <"$1" >raw && ...` instead.

We may also want to s/packs/pack, since this function only will handle
one index at a time.

> +	cut -d" " -f2 raw | sort

Having the sort in there is my fault, but after reading this more
carefully it's definitely unnecessary, since show-index will give us
the results in lexical order by object name already.

> +}
> +
>  test_expect_success '--write-midx -b packs non-kept objects' '
> -	GIT_TRACE2_EVENT="$(pwd)/trace.txt" \
> -		git repack --write-midx -a -b &&
> -	test_subcommand_inexact git pack-objects --honor-pack-keep <trace.txt
> +	git init repo &&
> +	test_when_finished "rm -fr repo" &&
> +	(
> +		cd repo &&
> +
> +		# Create a kept pack-file
> +		test_commit base &&
> +		git repack -ad &&
> +		find $objdir/pack -name "*.idx" >before &&

I thought that here it might be easier to say:

    before="$(find $objdir/pack -name "*.idx")"

> +		>$objdir/pack/$(basename $(cat before) .idx).keep &&

...and then replace "$(cat before)" with "$before", along with the
other uses of the before file below. But it gets a little funny when
you want to discover which is the new pack, where it is more natural to
dump the output of comm into a file.

> +		# Get object list from the one non-kept pack-file
> +		comm -13 before after >new-pack &&

You could write "new_pack=$(comm -13 before after)", but debugging this
test would be difficult if the output of comm there contained more than
one line.

> +		get_sorted_objects_from_packs \
> +			<new-pack \

Though we probably want to check that we only get one line anyway here,
since get_sorted_objects_from_packs will barf if we had more than one
line in file new-pack here, too.

Thanks,
Taylor
