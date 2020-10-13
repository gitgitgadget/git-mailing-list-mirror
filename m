Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5611BC433DF
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 15:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04C82251E7
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 15:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="Fqrgqahv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730958AbgJMPjF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Oct 2020 11:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730535AbgJMPjF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Oct 2020 11:39:05 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6168EC0613D0
        for <git@vger.kernel.org>; Tue, 13 Oct 2020 08:39:05 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id k25so23187037ioh.7
        for <git@vger.kernel.org>; Tue, 13 Oct 2020 08:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ohk8nafRNnMvvlCBAXFv81tB5v5cbJVJ24hvktyVU4g=;
        b=FqrgqahvMG2/GPVU6+0zGoNvnYmkW9kR42z667EoLM+YFFl9FX9/KiiJbrsongw5Q8
         hkEItexthKWRXEVdHReaN1ammYHhv07VMxEKk5OPG2Wst9g5U1x5Jp0izIX2Mwqp86fA
         SBM78+LZF+O/v5zJO82w1p7F2338OxaozPfDQ+PwnnFYVFPtBE09im3UEAQPPMYVEzfN
         CXshVX2QuU594FzT0l97le5H+D4wXcr4xOUIpk9/+huA256RZfk0JR3TEabNWNj+g4cU
         ofhCcmQKxHa1KLY9uYmmrzW0Hcjt5cZYTm+8L5DuNPjRPDQYkKd8yV5TdgVK0aQDY4iC
         5aHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ohk8nafRNnMvvlCBAXFv81tB5v5cbJVJ24hvktyVU4g=;
        b=c3v8ZfByaSyk4N3Dh5lE7waThFF/vQUzxCP68TGp02QEhHr9iToE2DvTeJ1pXgGjXv
         h9pXxMhNxU46grnPzQafCwASjPn0GuaQicmSZ1TccLHaq5w17Xy/LRtwdabsKykDf3ir
         TgrNwoj8S9xGe7ZFwp6J09kRo3C6axed6UpJYSgB3Yi0NZOfwxFkMPXCHQA5GNj45NjE
         29QbqdFGK/YkY3fTFvVhbLpuNu+xI/ZWyfi4J6NX54h7rYZOfPHHeqYZpg2fZf6Osrz4
         LkBAkDHH8Jp9gVhdtoUt5C23a3naP3Wvr49GMbfMl8Vo/JNbLIhXN4AgveamgPMag+MB
         hwhQ==
X-Gm-Message-State: AOAM532Kh0EPXGy+ocZVg+8rFcMdxKb8HNg25AAih1FUTnBOT/lKqMF/
        q8ynSK4P7aEF5ZKMrWtnsz+vk6v+9h80znln
X-Google-Smtp-Source: ABdhPJwaby+VyufcAkVLEiZg3WxHEhcviHH9UZFFnYEMDWh3vpn13UmpNyJ/aVHjfXpxjRdasXH5sQ==
X-Received: by 2002:a6b:fd08:: with SMTP id c8mr25185ioi.16.1602603544497;
        Tue, 13 Oct 2020 08:39:04 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:a4a8:cfa:3aeb:51fa])
        by smtp.gmail.com with ESMTPSA id v84sm149592ila.85.2020.10.13.08.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 08:39:03 -0700 (PDT)
Date:   Tue, 13 Oct 2020 11:39:01 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/3] test-lib: allow selecting tests by substring/regex
 with --run
Message-ID: <20201013153901.GA1913367@nand.local>
References: <pull.878.git.git.1602545164.gitgitgadget@gmail.com>
 <46fce3a844c90b4078578f5aa2058bd6825af1d6.1602545164.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <46fce3a844c90b4078578f5aa2058bd6825af1d6.1602545164.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 12, 2020 at 11:26:02PM +0000, Elijah Newren via GitGitGadget wrote:
> diff --git a/t/README b/t/README
> index 2adaf7c2d2..23639c5bcf 100644
> --- a/t/README
> +++ b/t/README
> @@ -258,13 +258,13 @@ For an individual test suite --run could be used to specify that
>  only some tests should be run or that some tests should be
>  excluded from a run.
>
> -The argument for --run is a list of individual test numbers or
> -ranges with an optional negation prefix that define what tests in
> -a test suite to include in the run.  A range is two numbers
> -separated with a dash and matches a range of tests with both ends
> -been included.  You may omit the first or the second number to
> -mean "from the first test" or "up to the very last test"
> -respectively.
> +The argument for --run, <test-selector>, is a list of description
> +substrings or regexes or individual test numbers or ranges with an
> +optional negation prefix that define what tests in a test suite to
> +include in the run.  A range is two numbers separated with a dash and
> +matches a range of tests with both ends been included.  You may omit
> +the first or the second number to mean "from the first test" or "up to
> +the very last test" respectively.
>
>  Optional prefix of '!' means that the test or a range of tests
>  should be excluded from the run.

This piece of documentation looks to be now out of date; it mentions a
"test or range of tests", but that only covers a two of the now four
ways to describe a test.

The rest of the patch looks great to me; and I, too, am very excited
about it.

Thanks,
Taylor
