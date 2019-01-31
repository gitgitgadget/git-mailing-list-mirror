Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5992A1F453
	for <e@80x24.org>; Thu, 31 Jan 2019 00:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfAaAuS convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 30 Jan 2019 19:50:18 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34046 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbfAaAuS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 19:50:18 -0500
Received: by mail-qk1-f194.google.com with SMTP id q8so973357qke.1
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 16:50:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=k1SqV97427ny4ppVs6wUjGO9iGCJ3mQWzK1jLizJ+pY=;
        b=f9b+K4TWcNA+H5UzZ441NyKpxFHhCzPoT7ZoqtTbNOtei4M5zfukfO78i2up9pzN8b
         L4IqVwCQ7brIieiyI5jiGWEMQLHVr0c9es4023qTrkV5f+uK5ECjjuB1rHdvbDuHTsZv
         eGSCF9wU3WZRNaOzYXEUs1zoKcsYaoW/5sMEKpMWDZt7mDDUAhZx8sMa2ZwG1H0Cn1Dt
         1UyQYalpXJ4WJaAfgKbmE7EqVQyGNOHKKMVtPtaYP083gc3V02XzGYc0KRcH2tomdtJI
         rmrsiRPmTnUVHolH4FZIuuFMpQbwMSNKWr7pq1FgO0ojDJdKr9ctEf4xHoFYm9ANM7zu
         /WFQ==
X-Gm-Message-State: AJcUukfjqCGl87Ofb+Bs0OX2JSRr5KdGoSNOqO9SEverr1+d6FiKLRF9
        1H3z5EcM6PLmpXVsc17dMcnYfgf17fE0eF1Ee+JzYA==
X-Google-Smtp-Source: ALg8bN6n9uWzl7VDFEr0sjEjuHPT0BMDmUEPjlZTBo0v/xrbEPEw7F8F5eZ3oTqOMtNlB/ldjp1SAN3hEaX7dNQCOf4=
X-Received: by 2002:a37:66c1:: with SMTP id a184mr29664394qkc.314.1548895817176;
 Wed, 30 Jan 2019 16:50:17 -0800 (PST)
MIME-Version: 1.0
References: <20190130094831.10420-1-pclouds@gmail.com> <20190130094831.10420-9-pclouds@gmail.com>
In-Reply-To: <20190130094831.10420-9-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 30 Jan 2019 19:50:05 -0500
Message-ID: <CAPig+cQ3L4NcMojWYV3spazJNzEa6yhBJQ0wwbwcLSzG3Vmzjw@mail.gmail.com>
Subject: Re: [PATCH 08/19] checkout: split part of it to new command switch
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 30, 2019 at 4:49 AM Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
> "git checkout" doing too many things is a source of confusion for many
> users (and it even bites old timers sometimes). To remedy that, the
> command will be split into two new ones: switch and
> something-to-checkout-paths. The good old "git checkout" command is
> still here and will be until all (or most of users) are sick of it.
> [...]
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
> diff --git a/Documentation/git-switch.txt b/Documentation/git-switch.txt
> @@ -0,0 +1,236 @@
> +SYNOPSIS
> +'git switch' [<options>] [--guess] <branch>
> +'git switch' [<options>] --detach [<start_point>>]
> +'git switch' [<options>] [[-c|-C|--orphan] <new_branch>] [<start_point>]

What does the third form mean when all optional arguments (that is,
_all_ arguments) are omitted?

Nit: I realize you inherited this from git-checkout documentation, but
can you use '-' rather than '_', as in <start-point>, <new-branch>, to
be consistent with other documentation, such as git-branch.

> +EXAMPLES
> +To check out commit "HEAD~3" for temporary inspection or experiment
> +without creating a new branch:
> +
> +------------
> +$ git switch --detach HEAD~3
> +HEAD is now at 9fc9555312 Merge branch 'cc/shared-index-permbits'
> +------------
> +
> +If it turns out whatever you have done is worth keeping, you can
> +always create a new name for it (without switching away):
> +
> +------------
> +$ git switch -c good-surprises
> +------------

I had to go re-read git-branch documentation to understand why you
recommended "git switch -c <new-branch>" (or even why this mode
exists) over plain "git branch <new-branch>". I wonder if the
difference between the two deserves a bit more discussion here and
above in the description of the -c/-C options.
