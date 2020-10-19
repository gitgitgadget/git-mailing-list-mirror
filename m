Return-Path: <SRS0=jQhj=D2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6568CC433DF
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 21:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07FD32236F
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 21:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="yF3HduZs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387408AbgJSVnn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Oct 2020 17:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387405AbgJSVnm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Oct 2020 17:43:42 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EAFC0613CE
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 14:43:42 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id w17so1931125ilg.8
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 14:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Lpn/Cx0ldnc/yQE8aQQXilzVkzgTp/x13xBqiLOJZUg=;
        b=yF3HduZseIpxOt1HtBTO+m7CHpubS4ZYxsLBh0OvP2+6ON1gDdBN5Kolyu/gVwd/6i
         zS9JJXysHyqeyUBMXcIE/ukYLzCMVO2B7Kk7qop9r/uF5hyCUBgWuG28RlulBOFMGNGa
         yBBROPRb4kYo7QX9eAURctUIPsOP7k4j0kTZQ3zsoN2EIS+y93H4nfZsap5PcsAQ0jhE
         hE2QHvkXNPsvn9cSxlaotnsjE7WzETODUikm6DdiA1AM+jPyrYIiH8rwjtaMDDbRECBK
         GqcsjLbAHE7jjBUqrANQEaSRWtP50UhrQY4Qa8Mjuq9/mDWk51UeWmgeggs694Knudql
         FFZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Lpn/Cx0ldnc/yQE8aQQXilzVkzgTp/x13xBqiLOJZUg=;
        b=DScb/S3IT85RGYOMvNC6uDLIEUEHBP4Zlu5v7ELuve6sEXmRs0SsZ+0KmB2lVMn+kk
         TL2QlW7DwF4zTmMVK4Wd1zPaJuygmeJjxB7hv49J597DeklPqNOiFTqNUFjyHhbuak53
         Ufi5MFQHdMi5556Vc5HQp44otplgTluFiPkHhMYUmMqGtgWugJopYIuWiXMZy82aEYMP
         ytZVnEpg9s/uBamsfPFLGP8AyiDR+8Y3i7WlbTfzdeIKZVGgWZ9gmIo1s1Tjo1EecG3R
         b93d/rHZwMboiKEMBZS2pfmHkD4VaZ/+77Jz747K3ED+uVcS2LsqUVJpHxtaz+CQKAet
         3Dnw==
X-Gm-Message-State: AOAM532KZYuLAnJAmmt+Rs2FEyAHRLtTH99tHWo+s9sIsjKFldQ9fnBp
        wuTUm5DNIi2cJBK2yJ2Qkf61Aw==
X-Google-Smtp-Source: ABdhPJx2VQYeQZD+ikowQ6dvHm5So1Alt0d+DP1qdys7R5CDR1kf66LloQbxSJzJu5Nz1FdOx+4QUA==
X-Received: by 2002:a92:dc8f:: with SMTP id c15mr1768614iln.293.1603143822038;
        Mon, 19 Oct 2020 14:43:42 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:943f:d0f4:e8b9:b8f9])
        by smtp.gmail.com with ESMTPSA id c9sm1000799iob.14.2020.10.19.14.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 14:43:41 -0700 (PDT)
Date:   Mon, 19 Oct 2020 17:43:39 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Nipunn Koorapati via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Utsav Shah <utsav@dropbox.com>,
        Nipunn Koorapati <nipunn1313@gmail.com>,
        Nipunn Koorapati <nipunn@dropbox.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 4/4] t/perf: add fsmonitor perf test for git diff
Message-ID: <20201019214314.GA47659@nand.local>
References: <pull.756.git.1602968677.gitgitgadget@gmail.com>
 <pull.756.v2.git.1603143316.gitgitgadget@gmail.com>
 <f572e226bb5e4b67cc57f8d9d4732086f01190a2.1603143316.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f572e226bb5e4b67cc57f8d9d4732086f01190a2.1603143316.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 19, 2020 at 09:35:15PM +0000, Nipunn Koorapati via GitGitGadget wrote:
> diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
> index 9313d4a51d..2b4803707f 100755
> --- a/t/perf/p7519-fsmonitor.sh
> +++ b/t/perf/p7519-fsmonitor.sh
> @@ -115,6 +115,13 @@ test_expect_success "setup for fsmonitor" '
>
>  	git config core.fsmonitor "$INTEGRATION_SCRIPT" &&
>  	git update-index --fsmonitor &&
> +	mkdir 1_file 10_files 100_files 1000_files 10000_files &&
> +	for i in `seq 1 10`; do touch 10_files/$i; done &&
> +	for i in `seq 1 100`; do touch 100_files/$i; done &&
> +	for i in `seq 1 1000`; do touch 1000_files/$i; done &&
> +	for i in `seq 1 10000`; do touch 10000_files/$i; done &&

I just happened to notice these while reading your range diff; git
discourages the use of seq in test, instead preferring our own
works-everywhere 'test_seq()'.

I was wondering how this slipped through since it should be checked
automatically by t/check-non-portable-shell.pl, but that is only run
from t/Makefile, not t/perf/Makefile. That probably explains how a few
raw `seq`'s made it into t/perf.

In either case, test_seq() is preferred here.

Thanks,
Taylor
