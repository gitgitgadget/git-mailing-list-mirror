Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 930411F453
	for <e@80x24.org>; Wed, 24 Oct 2018 20:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbeJYEzj (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 00:55:39 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42180 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbeJYEzi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 00:55:38 -0400
Received: by mail-qt1-f195.google.com with SMTP id j46-v6so7194526qtc.9
        for <git@vger.kernel.org>; Wed, 24 Oct 2018 13:26:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LOBLpxCG5qpEW2eTOuugMT4D4Wd0aegC8YRBv/1bqbQ=;
        b=j4Nb2ZFrMsLsOfY12gsPquKDFtFNeHAS6wnBjjMFEZ5gYZCvX/eiEPO2z5Vxhm/4sR
         vdHdMXCIEIkBfak/9nPcaSc0mOglEW9G29pJOW4qh2UajYTuTvYw6NVmhCkRg9ZdNQQ8
         Eb87PcelffG0llwG4tCketMCZ/AgQZ/mLRUWgEu7zFsdqYsjuDqKkWOXqgQyv6PqfVNA
         1a+fG3twZqF6lAAiHkw9l3R7f+AsbaUMYJ9qo+Pe5hxVhhqeDgK0C9JY3R9Xe0YqPeac
         8K1bfCFAI3KCE/W/FyoHozJqgA2owpSXzHnc5GwcI8ctFi9noADdl/1OFmX1K+VV2wXt
         ywqg==
X-Gm-Message-State: AGRZ1gJX/sQkRPCj20ZG8837dUeD1fFXV/E3RnooDbgDRGnJ6AKcUrhd
        eTUqLyxbWrXpp8WHs4SowagKXyKaQPJDxl5FsUZrdQ==
X-Google-Smtp-Source: AJdET5eXm8FMAzJYctCB6tT8yo4TPFT/bYEDFlI0bkG7B0nFlRpK0Gn1IeJSiRqZaCqal99ClD+PXgertLjryHJrZEM=
X-Received: by 2002:a0c:86c1:: with SMTP id 1mr3833478qvg.6.1540412767070;
 Wed, 24 Oct 2018 13:26:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1540410925.git.slawica92@hotmail.com> <a055296c2034a44f02c253ce3194018b21eb4e1f.1540410925.git.slawica92@hotmail.com>
In-Reply-To: <a055296c2034a44f02c253ce3194018b21eb4e1f.1540410925.git.slawica92@hotmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 24 Oct 2018 16:25:55 -0400
Message-ID: <CAPig+cRGn0Z7F7TpSwF=8cQJpN1LJkQb2VxHMDi6j6wsaqkORg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] [Outreachy] t3903-stash: test without configured
 user name
To:     slavicadj.ip2018@gmail.com
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>, Slavica <slawica92@hotmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 24, 2018 at 4:06 PM Slavica Djukic
<slavicadj.ip2018@gmail.com> wrote:
> This is part of enhancement request that ask for 'git stash' to work
> even if 'user.name' and 'user.email' are not configured.
> Due to an implementation detail, git-stash undesirably requires
> 'user.name' and 'user.email' to be set, but shouldn't.

Thanks for re-rolling. This version looks better. One comment below...

> Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
> ---
> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> @@ -1156,4 +1156,17 @@ test_expect_success 'stash -- <subdir> works with binary files' '
> +test_expect_failure 'stash works when user.name and user.email are not set' '
> +    test_commit 1 &&
> +    test_config user.useconfigonly true &&
> +    test_config stash.usebuiltin true &&
> +    sane_unset GIT_AUTHOR_NAME &&
> +    sane_unset GIT_AUTHOR_EMAIL &&
> +    sane_unset GIT_COMMITTER_NAME &&
> +    sane_unset GIT_COMMITTER_EMAIL &&
> +    test_must_fail git config user.email &&

Instead of simply asserting that 'user.email' is not set here, you
could instead proactively ensure that it is not set. That is, instead
of the test_must_fail(), do this:

    test_unconfig user.email &&
    test_unconfig user.name &&

> +    echo changed >1.t &&
> +    git stash
> +'
> +
>  test_done
> --
> 2.19.1.windows.1
>
