Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2F591F87F
	for <e@80x24.org>; Fri, 16 Nov 2018 20:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbeKQGym (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Nov 2018 01:54:42 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39092 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbeKQGym (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Nov 2018 01:54:42 -0500
Received: by mail-ed1-f68.google.com with SMTP id b14so18174102edt.6
        for <git@vger.kernel.org>; Fri, 16 Nov 2018 12:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bHF/tYEC70/a68+RZXbMZWa+PaR15nPQ6p6KQbny34Q=;
        b=POxbu+4VAmFz8DJ5xulv+dH9saZVB8cbgw7pZRbYqxoSVP1XaWO+ZwTA28nvfmA6L5
         rnV3lG1xPIaezN3Qj2DAUXZpbYkxWYxiK1XM1HzNI23g+N5wEbV08FTKAnSJ1u5y95NU
         bdEFMg6/hi8H8WF1y0TuStLzGPUlRvrRoxKBkbEdgpgBuAjR/Y9F+jfrOzD70/PDbAcP
         XGRm8/aPKAOyTXolmtB4YQhVYdeHzBagNxWXhjTY8n6zkJRWHmowcroV2mx/o8K/aLOa
         IWVNE8wewe+3tnXJG7ONC3pFmjdehHySesHWMtwslUW6iYXesoJ7m0bnCQeZ1QeiUWzI
         3VIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bHF/tYEC70/a68+RZXbMZWa+PaR15nPQ6p6KQbny34Q=;
        b=OIjkT5hZEDOnVKMBPYT4nibOBVtRsz846YxsxLQP2ywPHcev0aec1CF1aUqlnkyUN4
         pYgRvezQLQHUOcWNFOrUedNsplr1zqPWf7yvf7TYN1HfzN2HG/FKzFP6oQ2u7w6w59jR
         hinr/AcCPVyz4BfkbgHsioI1E5dirLBW3voZTuaq/A7uNqtBJErR7hTha4p6fOyDfSl4
         aBXLcWLJZr1um9mC9YHWgQsws2dFOnHSbVvdFJ4tIExPESjbvQwrOXTolPytnD9GdEs2
         cCa5upSxUjm+7qQgwMfAk16AJVCH3OjhTiycr0KuC/x1ZeeG3/CWl07OMSTqK4yKZlJV
         uRfA==
X-Gm-Message-State: AGRZ1gJC1bAscrogJ3jdLzfHe7Jjs7DILlr8hUB+YJ8SPniVz+ETuqmo
        rBkJFbKIIeFvX/0c7bZop7ZIcHUZh0R4F7K/8sx6zg==
X-Google-Smtp-Source: AJdET5eBiUYhEJPYd1BYmgnC7eOKer6wcnqA5UKHh5Zjn1Cm+MHspepnWT1vmK+EdUUJrwdA4rQMz+1dkN2xvhBzYgE=
X-Received: by 2002:a50:bc12:: with SMTP id j18-v6mr11196006edh.154.1542400845178;
 Fri, 16 Nov 2018 12:40:45 -0800 (PST)
MIME-Version: 1.0
References: <20180924100604.32208-1-phillip.wood@talktalk.net>
 <20181116110356.12311-1-phillip.wood@talktalk.net> <20181116110356.12311-8-phillip.wood@talktalk.net>
In-Reply-To: <20181116110356.12311-8-phillip.wood@talktalk.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 16 Nov 2018 12:40:34 -0800
Message-ID: <CAGZ79ka4mHxtcwjfu3taipakUHtDXg6DjQu=nJun8Nm+snyo0g@mail.gmail.com>
Subject: Re: [PATCH v1 7/9] diff --color-moved-ws: optimize allow-indentation-change
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 16, 2018 at 3:04 AM Phillip Wood <phillip.wood@talktalk.net> wrote:
>
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> When running
>
>   git diff --color-moved-ws=allow-indentation-change v2.18.0 v2.19.0
>
> cmp_in_block_with_wsd() is called 694908327 times. Of those 42.7%
> return after comparing a and b. By comparing the lengths first we can
> return early in all but 0.03% of those cases without dereferencing the
> string pointers. The comparison between a and c fails in 6.8% of
> calls, by comparing the lengths first we reject all the failing calls
> without dereferencing the string pointers.
>
> This reduces the time to run the command above by by 42% from 14.6s to
> 8.5s. This is still much slower than the normal --color-moved which
> takes ~0.6-0.7s to run but is a significant improvement.
>
> The next commits will replace the current implementation with one that
> works with mixed tabs and spaces in the indentation. I think it is
> worth optimizing the current implementation first to enable a fair
> comparison between the two implementations.

Up to here the series looks good and I think we could take it
as a preparatory self-standing series.

I'll read on.
Thanks,
Stefan
