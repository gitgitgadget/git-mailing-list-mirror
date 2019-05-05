Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 596BC1F45F
	for <e@80x24.org>; Sun,  5 May 2019 06:32:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfEEGca (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 May 2019 02:32:30 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41313 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbfEEGca (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 May 2019 02:32:30 -0400
Received: by mail-wr1-f66.google.com with SMTP id c12so12999766wrt.8
        for <git@vger.kernel.org>; Sat, 04 May 2019 23:32:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lAfVdchJ9bK4MOubYQj5jD9wR4/BUbUAITD1CtvXR18=;
        b=fTfX6Gz+bo28H70BZP0iVKamNSY6cCFSWgyGC6BA6HrEo92dTPZs6rswnyFBg6FkV3
         gqhMMGmr7NNZnIbaUHdQCV5L+Sg67U7xGyNtlYsz4jJZFnhKDJ0J2tz7aLqgSm1Hl2CQ
         gkC8jIjmTzLDh1Zr3ftweoWaZoleOfbX99odK2mlS8dp/kHCqUxYc+iB1MQSBH770GMR
         PQYeusKDgmBhBSpRA/I46GssfRxvsWC/oP9m2lI7Lf6kjHdnOzmTVX/pqsHcIgec69Or
         kaHH55stCPIoyPxEsDZYR3eyzqrt4LbgXVMZ8Z1+prwVCNwOkSpRzItJiFdCFvDYpQqK
         PDOQ==
X-Gm-Message-State: APjAAAUHu34L0kIG4G/I+lOX3Ks7FYlRzeYelK+Fo1en1CzrFbMrbqHY
        4Vm0pHtHhCl/MlOld+SfJ1NnLuK4lnbu333/MzY=
X-Google-Smtp-Source: APXvYqxHIqUm51+SrW5U/qQt3PEjZgQM4j6O+5O2lF7onsd2s0c9Yy63anZkA0BIDFE0/zPCni2P9GEO7N9aZWwsVDI=
X-Received: by 2002:adf:f68c:: with SMTP id v12mr13767670wrp.40.1557037948597;
 Sat, 04 May 2019 23:32:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190505023852.33986-1-liboxuan@connect.hku.hk>
In-Reply-To: <20190505023852.33986-1-liboxuan@connect.hku.hk>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 5 May 2019 02:32:19 -0400
Message-ID: <CAPig+cRuiXh2NgTt1_-en=AzYEsu1P1HgDLo=PFgzZiVxSRDqg@mail.gmail.com>
Subject: Re: [PATCH] t4253-am-keep-cr-dos: avoid using pipes
To:     Boxuan Li <liboxuan@connect.hku.hk>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 4, 2019 at 10:39 PM Boxuan Li <liboxuan@connect.hku.hk> wrote:
> The exit code of the upstream in a pipe is ignored thus we should avoid
> using it. By writing out the output of the git command to a file, we can
> test the exit codes of both the commands.
>
> Signed-off-by: Boxuan Li <liboxuan@connect.hku.hk>
> ---
> diff --git a/t/t4253-am-keep-cr-dos.sh b/t/t4253-am-keep-cr-dos.sh
> @@ -51,14 +51,16 @@ test_expect_success 'am with dos files without --keep-cr' '
>  test_expect_success 'am with dos files with --keep-cr' '
>         git checkout -b dosfiles-keep-cr initial &&
> -       git format-patch -k --stdout initial..master | git am --keep-cr -k -3 &&
> +       git format-patch -k --stdout initial..master > actual &&
> +       git am --keep-cr -k -3 actual &&

Style nit: In this codebase, the space is omitted after the
redirection operator (i.e. >actual).

Nit: Given that the name "actual" is typically used in conjunction
with an "expect" (or "expected") file, its use here is somewhat
unexpected. Other possible names which might be more meaningful
include "patches" and "output".

>         git diff --exit-code master
>  '
