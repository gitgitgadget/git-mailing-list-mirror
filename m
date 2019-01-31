Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 107991F453
	for <e@80x24.org>; Thu, 31 Jan 2019 07:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbfAaHDp convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 31 Jan 2019 02:03:45 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40316 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfAaHDp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Jan 2019 02:03:45 -0500
Received: by mail-qt1-f195.google.com with SMTP id k12so2402298qtf.7
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 23:03:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WZx8X8lzjuKh3eHRlxf1U1VHNrwpFM2WwUYa1hesQ8Q=;
        b=qPxlfMZf+TQpgvtSnW3hh8YqMQM/kcDqr85cd7pFYDyJ0uuNo3n+Hm2u939Slsd5CM
         +eRz/N8+jYxywU+fyuB4vHs+6jPUI6rCVaAzWWTWWzJtp1+Rh1wyDFDLRYLGghIH/6hy
         u9I/YOtoogGx/9i8/Z8M7GaKhq5Vqzba/MIHiLyNPF9ewxIjMhLDqEwP8T4TZfS9JiX4
         ltbHCASRRNRO5gJkysQyHUwlRqSF+lipJGTjhyEynv/bVl5ggDyiXk86jipbfUpmTaiu
         Z2DDc+pPFF8xf3LmXdeTY2dTJ0mN0XsSuefvwmFoYL0IRVIG/zg42GTlARswFBZWqN+v
         AXoA==
X-Gm-Message-State: AJcUukdTdog3WmEvdUTFdSQopSZzcO7BHL0Ra/jKXJIJ9I6p+I6RXjmC
        yXSVMT6QNA08QHOyr7p/FceRr3Mqo+8gLMLd6TQ=
X-Google-Smtp-Source: ALg8bN6jy0TMo0k26cv/LpBjAEn5IxNy7UUHahQ+M31jXfYdnleHEJBLCdsOqm6Wv9qKx68lBWQylTfYPe5iCxvyEMw=
X-Received: by 2002:ac8:27c8:: with SMTP id x8mr32373481qtx.352.1548918224566;
 Wed, 30 Jan 2019 23:03:44 -0800 (PST)
MIME-Version: 1.0
References: <20190130094831.10420-1-pclouds@gmail.com> <20190130094831.10420-10-pclouds@gmail.com>
In-Reply-To: <20190130094831.10420-10-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 31 Jan 2019 02:03:32 -0500
Message-ID: <CAPig+cQODhU4ep21UQ0gf+qOLWTmkj5k69ww1W3sENOFEYk7iw@mail.gmail.com>
Subject: Re: [PATCH 09/19] switch: better names for -b and -B
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
> The shortcut of these options do not make much sense when used with
> switch. And their descriptions are also tied to checkout
> out. Move -b/-B to cmd_checkout() and new -c/-C with the same
> functionality in cmd_switch_branch()
>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> @@ -1353,14 +1353,10 @@ static struct option *add_common_options(struct checkout_opts *opts,
> @@ -1556,15 +1552,22 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
>  int cmd_checkout(int argc, const char **argv, const char *prefix)
>  {
> +       struct option checkout_options[] = {
> +               OPT_STRING('b', NULL, &opts.new_branch, N_("branch"),
> +                          N_("create and checkout a new branch")),
> +               OPT_STRING('B', NULL, &opts.new_branch_force, N_("branch"),
> +                          N_("create/reset and checkout a branch")),

Note wording for -B and compare with...

> @@ -1577,14 +1580,21 @@ int cmd_switch(int argc, const char **argv, const char *prefix)
> +       struct option switch_options[] = {
> +               OPT_STRING('c', "create", &opts.new_branch, N_("branch"),
> +                          N_("create and switch to a new branch")),
> +               OPT_STRING('C', "force-create", &opts.new_branch_force, N_("branch"),
> +                          N_("create/reset and switch to a new branch")),

wording for -C which talks about "new branch" rather than just
"branch" of -B. (Dropping "new" from the latter makes it read a bit
better, in my opinion, and would make it consistent with -B wording.)

> +               OPT_END()
> +       };
