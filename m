Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8C1B1F453
	for <e@80x24.org>; Thu, 31 Jan 2019 07:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbfAaHSe convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 31 Jan 2019 02:18:34 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38193 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbfAaHSe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Jan 2019 02:18:34 -0500
Received: by mail-qt1-f196.google.com with SMTP id p17so2448994qtl.5
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 23:18:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SQnjjBakoVD/qgUP0XNhvQsAgHS3gbE1cZtpLRqyKhg=;
        b=g4iIFtjznaarXVWH/CClscRgk7fKHHXQg0qYqATGCRZjvA3Z8kDspx1VcyzT4U5BUq
         wi4BEaPNMf3b5cXL1mzkDBwtP+xG96o4MD0VOOpx7GOzecdfrI4vxzbkbi1tCyHgfTeH
         +ssyBiYIQXZmk3obWiG77Iv2rKPlaUyz8Jh7aDbWqZRQf3oH5tXIB8qxLxZEJRNQR+ia
         hRqj/mMYlPHFjwbh57a3Z/Fnqp/pQ6F1dMfJ7886by3szIyeYQHKaVJ/kL7hpoPJvSJa
         gSw3z7yGQOOFvpMA1h4Sss3VMsQAj50gW24jkwwP5afK/0myqgbZ8XWTsydswfFocOUd
         1z4g==
X-Gm-Message-State: AJcUukemg2rQCLDfLYomdivpv0iiD6ENUhXcA+y+okJ6VPQbMSNKbWOW
        cJu6eY/8hZwbEA/XHgfT9gw+MJmMXwu3CRF0ydCtjQ==
X-Google-Smtp-Source: ALg8bN4fo9Y9qItT65lYdxgnO7gjo5a8a3OeK39TW7wl1cBSBILJE1TkGcX09lwidlVYUwQVdFKyjKk+3c2UEPaZ2PY=
X-Received: by 2002:a0c:981b:: with SMTP id c27mr32479435qvd.184.1548919113726;
 Wed, 30 Jan 2019 23:18:33 -0800 (PST)
MIME-Version: 1.0
References: <20190130094831.10420-1-pclouds@gmail.com> <20190130094831.10420-18-pclouds@gmail.com>
In-Reply-To: <20190130094831.10420-18-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 31 Jan 2019 02:18:21 -0500
Message-ID: <CAPig+cQfzv+zocqRZVC6hYywmPMR=p496weocdxBd6ng_7Cuug@mail.gmail.com>
Subject: Re: [PATCH 17/19] t: add tests for switch
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 30, 2019 at 4:50 AM Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
> diff --git a/t/t2060-switch.sh b/t/t2060-switch.sh
> @@ -0,0 +1,91 @@
> +test_expect_success 'switch and create branch' '
> +       test_when_finished git switch master &&
> +       git switch -c temp master^ &&
> +       git rev-parse master^ >expected &&
> +       git rev-parse refs/heads/temp >actual &&
> +       test_cmp expected actual &&

The above three lines could be replaced with test_cmp_rev()?

> +       echo refs/heads/temp >expected-branch &&
> +       git symbolic-ref HEAD >actual-branch &&
> +       test_cmp expected-branch actual-branch
> +'
> +
> +test_expect_success 'force create branch from HEAD' '
> +       test_when_finished git switch master &&
> +       git switch --detach master &&
> +       git switch -C temp &&
> +       git rev-parse master >expected &&
> +       git rev-parse refs/heads/temp >actual &&
> +       test_cmp expected actual &&

Ditto: test_cmp_rev()

> +       echo refs/heads/temp >expected-branch &&
> +       git symbolic-ref HEAD >actual-branch &&
> +       test_cmp expected-branch actual-branch
> +'
