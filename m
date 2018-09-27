Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3673F1F453
	for <e@80x24.org>; Thu, 27 Sep 2018 10:15:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbeI0Qd3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 12:33:29 -0400
Received: from mail-qt1-f173.google.com ([209.85.160.173]:43027 "EHLO
        mail-qt1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbeI0Qd3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 12:33:29 -0400
Received: by mail-qt1-f173.google.com with SMTP id l16-v6so2042961qtq.10
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 03:15:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iujVTMB3r10PNXOIcODf4jjjkidyIYEowDrypMUeS10=;
        b=kvVIjg1Rc5cCuEFCDFNhOJ5eT3Y0W1ABgkrrep1rP3lXyG+hF8CfIPErroaAt1NgQl
         dsISOcoL1VyvBdbsu5+4VxNA92o5apEElFrL8UOcJ0xgSmYgHe6GWTanOSD5aurNAbY/
         zb4pyKu0R28myZ2s3F0jq1Sa4eWsEW++rpejdydV4XqTaO5blwe69kEUN1/zUrDlykWL
         yLzn2qZGit8k2SR2i3JmXcq/VScHV/ooNdydzfO83Y9Z21apWC367z8mZ7BhQlX4kC7f
         H6RexIJANpKG696aDjssltqSenQlKVzspn855Mh8RhefwZeGj7LfwP1TX1EjuTQ8Xsdt
         i3lg==
X-Gm-Message-State: ABuFfojSHIejw3y15x2Lan//kEllmSsBxNVLxWFv/+xj6SAlH33UCTG3
        PLrDCeZbII/A1aqUAzCw/hA9gAlZhyukaPA6JiU=
X-Google-Smtp-Source: ACcGV61QKeEssMC98n0IDZ4C1aOPdcbVbaZicdSirBGMmDGFJytNod5G8vHOAaPBtuzm7En2EoiIDGAL7s3bqVOvydQ=
X-Received: by 2002:a0c:b62c:: with SMTP id f44-v6mr5930342qve.184.1538043355468;
 Thu, 27 Sep 2018 03:15:55 -0700 (PDT)
MIME-Version: 1.0
References: <20180927072043.19130-1-newren@gmail.com>
In-Reply-To: <20180927072043.19130-1-newren@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 27 Sep 2018 06:15:45 -0400
Message-ID: <CAPig+cRW1S78Oiq9RPZjOBC651DO3=8Uzg69sji+x1QpOeH4ig@mail.gmail.com>
Subject: Re: Triggering "BUG: wt-status.c:476: multiple renames on the same
 target? how?"
To:     Elijah Newren <newren@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        andreastacchiotti@gmail.com, eckhard.s.maass@googlemail.com,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 27, 2018 at 3:20 AM Elijah Newren <newren@gmail.com> wrote:
> Subject: [PATCH] commit: fix erroneous BUG, 'multiple renames on the same
>  target? how?'
> [...]
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
> diff --git a/t/t7500-commit.sh b/t/t7500-commit.sh
> @@ -359,4 +359,27 @@ test_expect_success 'new line found before status message in commit template' '
> +test_expect_success 'setup empty commit with unstaged rename and copy' '
> +       test_create_repo unstaged_rename_and_copy &&
> +       (
> +               cd unstaged_rename_and_copy &&
> +
> +               echo content >orig &&
> +               git add orig &&
> +               test_commit orig &&
> +
> +               cp -a orig new_copy &&

Non-portable -a option. Not in POSIX[1].

[1]: http://pubs.opengroup.org/onlinepubs/9699919799/utilities/cp.html

> +               mv orig new_rename &&
> +               git add -N new_copy new_rename
> +       )
> +'
