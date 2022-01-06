Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A972C433F5
	for <git@archiver.kernel.org>; Thu,  6 Jan 2022 19:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243375AbiAFTgJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jan 2022 14:36:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbiAFTgI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jan 2022 14:36:08 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CAEC061245
        for <git@vger.kernel.org>; Thu,  6 Jan 2022 11:36:08 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id p19so3299741qtw.12
        for <git@vger.kernel.org>; Thu, 06 Jan 2022 11:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mngAqYxj8YvKh5/uNhfupuE51KrBMESalQ1RGJZ/aAQ=;
        b=jSyqkgJHl5DEdFshoUtf2IA+HqCE3EB/Vud8iZbi5kku7avPGfGstLzOclDT1r4JjZ
         ZA/ZfDNGObM1t6r2fzdiQZjk4eJ4vWPPWBEyj5J6aqH6zjiFTwM/o/4NJC44zboCDGD3
         dfYHsDjjPaXVuqaGSjbqCuvltbLtFFYJdjXvbyViYqh/aE59qbGFXyFc4ilKRPi22A8U
         e8hiE2+u3+L5RnRxF4PZQL+kWrcvjLhm+Yh5bRI9DfrSZFLQlm8bk20MDNVqlAidFOMt
         pmf35Wbn15/qaC8PXC+kyuYX07IYgD7vvAxUJQAb4xkuAMXZlMlfh8lPeFaq1fjn2Pr3
         oMxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mngAqYxj8YvKh5/uNhfupuE51KrBMESalQ1RGJZ/aAQ=;
        b=20Ivbrii8ylZGxs5Iy8+fyUMgRfKpqFBRj7frTq5ENuhmivOhWthKG3+AujuxC4jHM
         3dSQ0ng5MM0klGOgcZhYXR8ZfLhYQ0VryApt/79Nx3iJ9ApHAHkxS8JcrR9B5dAnWcEO
         a6qu5/fjzlejY7JbOwG/cnBfWS1ATIfNhv+6kLXmwfLvYnp2szBHsG/FNEG7Lyypg7dB
         oP9uGUzgWA+zDcTnyaWx6W+lXr245q+vEcN7f1DjGMb4NIW7YuIkwEQ+RwGaLsfHBNGQ
         l3GHjBN+v9xiHsUKvjg95Zpopli3AmxgvBnq4UfImBOmiQXbRv+qswt7xylCOTXqDVog
         /SiA==
X-Gm-Message-State: AOAM533zxKAEyu6aUy5/aDq5cfQPmHycLFW6iGlJzifSKXWave2anocX
        Cu/uWEqHgtAWQ8P1FSJkFUK+Pw==
X-Google-Smtp-Source: ABdhPJzcNnCC46UjAUb9+9KWbSZsPNQAxmW+0302iKSi4cVxN7lDq6NLSvmSrj84oa0hlP5d+UKjJg==
X-Received: by 2002:ac8:5e4e:: with SMTP id i14mr53054387qtx.646.1641497767471;
        Thu, 06 Jan 2022 11:36:07 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m4sm2402512qtw.27.2022.01.06.11.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 11:36:06 -0800 (PST)
Date:   Thu, 6 Jan 2022 14:36:05 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, John Cai <johncai86@gmail.com>,
        git@vger.kernel.org, levraiphilippeblain@gmail.com,
        phillip.wood123@gmail.com, Tilman Vogel <tilman.vogel@web.de>
Subject: Re: [PATCH v3] builtin/pull.c: teach run_merge() to honor
 rebase.autostash config
Message-ID: <YddEpUEA9Hnxqam+@nand.local>
References: <20220106150226.77458-1-johncai86@gmail.com>
 <YdcjCKTrK+W/FCw1@nand.local>
 <xmqqee5kemxj.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqee5kemxj.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 06, 2022 at 10:31:04AM -0800, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> >> +	git clone src dst &&
> >> +	test_commit -C src --printf "more_content" file "more content\ncontent\n" &&
> >
> > Same note here, but I think the `--printf` is unnecessary. Running
> > `echo` with "\n" characters in its argument is fine, so this could be
> > shortened to:
> >
> >     test_commit -C src blah file "more\ncontent"
>
> Is that true for everybody's shell, or just dash?
>
> $ bash -c 'echo "a\nb\nc"'
> a\nb\nc
> $ dash -c 'echo "a\nb\nc"'
> a
> b
> c

Ah, of course: thanks for the reminder. Do ignore my comment about
`--printf` being unnecessary, since it is quite necessary depending on
your shell.

In either case, I still think the quoting around "more_content" is
unnecessary (but the same is not true for the string containing
newlines).

Thanks,
Taylor
