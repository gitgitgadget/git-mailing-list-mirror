Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B01C433ED
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 17:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 613F86135D
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 17:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238661AbhDERcA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Apr 2021 13:32:00 -0400
Received: from mail-ed1-f53.google.com ([209.85.208.53]:34528 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237872AbhDERcA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Apr 2021 13:32:00 -0400
Received: by mail-ed1-f53.google.com with SMTP id ba6so5846135edb.1
        for <git@vger.kernel.org>; Mon, 05 Apr 2021 10:31:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FsnpRqpF3MYARRSF94pQmt0r63WuT1zUDsgQB6TYous=;
        b=oa8P2VYNo+YPFObVRiShWNOJ7U3+Y8UcWpFTwPcN2L5Pnes37sSk/2TNQllDf8tIZs
         uCxtndwQvrZifCYkr+MLFk0T/igRB9/OHuQ5a4xV2E3UzBv8s/+M2/l9DbMtb5xu2JPk
         4/CSS2DcnceUtwyFQBsccxtxmSU+WtyNkyD90iyCDmvor2iFng5WzcbvrRvwCgiCcsDc
         b6R7qkvggSdWQDj6SvyNEL3sd0Gcc5a9CDUIdDrIZ5IXxlS3DZcIt19b8IdUnFAKRVQM
         uDNbCOh6Ix8tv5Qe0EPWh6dT9P4nc/nu7R1VYSr7YLzwBIwxNT7XwS4b8Xuqzfi/3buP
         HZ0Q==
X-Gm-Message-State: AOAM532P5xt/jSPwRykV1fzoFYvTagxmnCSNXp5qrdWbsSDyFg+VAWWL
        Vw1kDAlXMAmwrrvGOc1UYDVVmr4VsR7YpAoNozU=
X-Google-Smtp-Source: ABdhPJzpOxVdEHHQov9xteqSkCgdaDWadIf9gBjOhQAFmTMPXS0OWuLMYYd4Lv2jsHPOq9NyH0gXbrAF4NKDMz6OdRc=
X-Received: by 2002:aa7:c551:: with SMTP id s17mr33025562edr.291.1617643912868;
 Mon, 05 Apr 2021 10:31:52 -0700 (PDT)
MIME-Version: 1.0
References: <pull.924.git.1617627856.gitgitgadget@gmail.com> <2b74889c2a323f03be477ffdf9ff388405779c3b.1617627856.git.gitgitgadget@gmail.com>
In-Reply-To: <2b74889c2a323f03be477ffdf9ff388405779c3b.1617627856.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 5 Apr 2021 13:31:42 -0400
Message-ID: <CAPig+cRaysm=-UcqY4zY5cV0KzAwd+RwzxXN-ZMV0nz=L4_+DA@mail.gmail.com>
Subject: Re: [PATCH 2/5] test-lib: use exact match for test_subcommand
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Tom Saeger <tom.saeger@oracle.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 5, 2021 at 9:04 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> The use of 'grep' inside test_subcommand uses general patterns, leading
> to sometimes needing escape characters to avoid incorrect matches.
> Further, some platforms interpret different glob characters differently.

These are regular expression metacharacters, not glob characters. A
more general way to say this might be:

    Furthermore, it can be difficult to know which characters need
    escaping since the actual regular expression language implemented
    by various `grep`s differs between platforms; for instance, some
    may employ pure BRE, whereas others a mix of BRE & ERE.

    Sidestep this difficulty by using `grep -F`...

> Use 'grep -F' to use an exact match. This requires removing escape
> characters from existing callers. Luckily, this is only one test that
> expects refspecs as part of the subcommand.
>
> Reported-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>

The Reported-by: feels a bit unusual in this context. Perhaps
Helped-by: would be more appropriate.

> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> @@ -142,8 +142,8 @@ test_expect_success 'prefetch multiple remotes' '
> -       test_subcommand git fetch remote1 $fetchargs +refs/heads/\\*:refs/prefetch/remote1/\\* <run-prefetch.txt &&
> -       test_subcommand git fetch remote2 $fetchargs +refs/heads/\\*:refs/prefetch/remote2/\\* <run-prefetch.txt &&
> +       test_subcommand git fetch remote1 $fetchargs +refs/heads/*:refs/prefetch/remote1/* <run-prefetch.txt &&
> +       test_subcommand git fetch remote2 $fetchargs +refs/heads/*:refs/prefetch/remote2/* <run-prefetch.txt &&

To be really robust and avoid accidental glob expansion (as unlikely
as it is), you should quote any arguments which contain glob
metacharacters such as "*" rather than supplying them bare like this.
