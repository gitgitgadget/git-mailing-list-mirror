Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76A1B1F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 23:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438340AbfJQX0o (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 19:26:44 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43513 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389107AbfJQX0o (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 19:26:44 -0400
Received: by mail-wr1-f66.google.com with SMTP id j18so4174526wrq.10
        for <git@vger.kernel.org>; Thu, 17 Oct 2019 16:26:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BP2LHdPSzOMmZVKjw5gu+FrZAdeGcGB3Mu7GXceGxVE=;
        b=ELqOA7CGNhnr/4NSltQOYQdxNFqSGdBulGYvjylL7/80VPZLvJ2egWeQlrbJhe/IPE
         RGJdA4cC9aBaut7diPAl3tU0myZUMBk8JKxCc3hfDhqniaUyM3niK9OAyysXtqXLmvC6
         Q8THbuUQ9l2lLieiuaQvzLkp0hF+8MjZgfZ3j1nst+gnN0NcpWIVRoaWuYKEPtbhU8OJ
         667bp1gvRc5V3M7VuxNW1UswqHVHA3Q2qRPq4wTpLJp1utgIzJutPrmtv9HQQXV1+t/q
         maYxSrV3KfA8bVDynr+JWGI47wfAcx9UHLMmGCPuItG8Dw20QZ6m9TUVn0XflTLul341
         Xqog==
X-Gm-Message-State: APjAAAXZKJ+jVAvXuTJPI++3fF3Mq0qWCktcCLah/ip6EzjM17p0htRF
        6ZExq1s7ggO8FzrowMhEnbv+qGZgkwQ3pq5hzu8/X//V
X-Google-Smtp-Source: APXvYqzeadHksRxYoV4aSsyOEpmlYqmX3ACCjOxRUOIAbDXUOOq/CEi1UavzN/dS6J/x1UxfC/PIIrYor8ruSWdpD0M=
X-Received: by 2002:adf:e8c6:: with SMTP id k6mr5123040wrn.78.1571354801763;
 Thu, 17 Oct 2019 16:26:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1571354136.git.liu.denton@gmail.com> <f3cb583110f508b4a421326ea6667280e848930d.1571354136.git.liu.denton@gmail.com>
In-Reply-To: <f3cb583110f508b4a421326ea6667280e848930d.1571354136.git.liu.denton@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 17 Oct 2019 19:26:30 -0400
Message-ID: <CAPig+cRBA-guwHN-bhRvgbzc52YU-e_ipSQ7BYqDV6yNnvXmTA@mail.gmail.com>
Subject: Re: [PATCH 04/12] t5520: replace test -f with test_path_is_file
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 17, 2019 at 7:17 PM Denton Liu <liu.denton@gmail.com> wrote:
> Although `test -f` has the same functionality as test_path_is_file(), in
> the case where test_path_is_file() fails, we get much better debugging
> information. Replace `test -f` with test_path_is_file so that future
> developers will have a better experience debugging these test cases.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> @@ -99,7 +99,7 @@ test_expect_success 'pulling into void must not create an octopus' '
>         (
>                 cd cloned-octopus &&
>                 test_must_fail git pull .. master master &&
> -               ! test -f file
> +               test_must_fail test_path_is_file file
>         )

According to t/README, this is not a valid use of test_must_fail(),
which is reserved for detecting failure of Git commands. Either use
'!' as the original code did, or perhaps use test_path_is_missing().
