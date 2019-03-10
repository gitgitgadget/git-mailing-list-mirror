Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57B1320248
	for <e@80x24.org>; Sun, 10 Mar 2019 04:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbfCJD7o convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sat, 9 Mar 2019 22:59:44 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55353 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbfCJD7o (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Mar 2019 22:59:44 -0500
Received: by mail-wm1-f68.google.com with SMTP id q187so1202934wme.5
        for <git@vger.kernel.org>; Sat, 09 Mar 2019 19:59:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ww55lbHfD6gmivWPyxy//IfmqvEJbuORnGt5TLuHbq0=;
        b=J18wCwvXe4n3k52J6V4R/rVNin17QbCeryxUi95yDN4dPq9LRP1SjuJTItqbGAwvUg
         ANTNqmLDV38U66incCT1DSP/EM8p7BV1GHAnuCLcoMJvfT07hGqcugUEoOV43EZy3LVl
         5+H3hWWLdWLo2Y/0pGHiGuzSVwz1Cj3mc/OAAHxr6CsGitMP2qIvX1OsivQtonB8+XGD
         dX5r/MZxBgLNRHTWANips+Q6B2BVctPYjZh4UGWVWAZL09v6mTYlW+qXE8Hop1MYUjbX
         vzvfch3eyhn8j9hIa/Gp+dcL1gMKWFIX8E8x328MWdF2HAZR8ThbEqJrngTSK484ZnSj
         g+jA==
X-Gm-Message-State: APjAAAVw+6MT1e5O5licG9SfN6egy0AMVh1XtEHJQVOmANR/5CoXy2Mf
        ImsUhAsT2Tc6onQlfYWnoh0uGH40LJOnmrRNTeQ=
X-Google-Smtp-Source: APXvYqw1tOH7s4nLY8ymsVi93loHrCIhVBOXlQH7NqTm7WU5SOdop5h0OYe4j6svXkGiGaP/0kvEzYrhtn9m/90hfWM=
X-Received: by 2002:a1c:730d:: with SMTP id d13mr13257312wmb.37.1552190382174;
 Sat, 09 Mar 2019 19:59:42 -0800 (PST)
MIME-Version: 1.0
References: <20190208090401.14793-1-pclouds@gmail.com> <20190308095752.8574-1-pclouds@gmail.com>
 <20190308095752.8574-20-pclouds@gmail.com>
In-Reply-To: <20190308095752.8574-20-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 9 Mar 2019 22:59:32 -0500
Message-ID: <CAPig+cTADoua2G2rqyr_2-dqRPsK0Jzsxtkgvv5Gr-iasDA=VA@mail.gmail.com>
Subject: Re: [PATCH v3 19/21] t: add tests for switch
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 8, 2019 at 4:59 AM Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
> diff --git a/t/t2060-switch.sh b/t/t2060-switch.sh
> @@ -0,0 +1,87 @@
> +test_expect_success 'switch to a commit' '
> +       test_must_fail git switch master^{commit}
> +'

The title of this test was a bit misleading for me; I would have found
it easier to understand what's being tested had it said "switch
without --detach" or something.

> +test_expect_success 'switch and detach' '
> +       test_when_finished git switch master &&
> +       git switch --detach master^{commit} &&
> +       test_must_fail git symbolic-ref HEAD
> +'

In fact, if the two tests were combined, it would have been even
clearer (for me):

    test_expect_success 'switch and detach' '
        test_when_finished git switch master &&
        test_must_fail git switch master^{commit} &&
        git switch --detach master^{commit} &&
        test_must_fail git symbolic-ref HEAD
    '

Not worth a re-roll.

> +test_expect_success 'switch and create branch' '
> +       test_when_finished git switch master &&
> +       git switch -c temp master^ &&
> +       test_cmp_rev master^ refs/heads/temp &&
> +       echo refs/heads/temp >expected-branch &&
> +       git symbolic-ref HEAD >actual-branch &&
> +       test_cmp expected-branch actual-branch
> +'
> +
> +test_expect_success 'force create branch from HEAD' '
> +       test_when_finished git switch master &&
> +       git switch --detach master &&
> +       git switch -C temp &&
> +       test_cmp_rev master refs/heads/temp &&
> +       echo refs/heads/temp >expected-branch &&
> +       git symbolic-ref HEAD >actual-branch &&
> +       test_cmp expected-branch actual-branch
> +'

Maybe also demonstrate that -C is actually needed here by leading in
with a failing -c:

    ...
    git switch --detach master &&
    test_must_fail git switch -c temp &&
    git switch -C temp &&
    ...

Not worth a re-roll.

> +test_expect_success 'guess and create branch ' '
> +       test_when_finished git switch master &&
> +       test_must_fail git switch foo &&
> +       git switch --guess foo &&
> +       echo refs/heads/foo >expected &&
> +       git symbolic-ref HEAD >actual &&
> +       test_cmp expected actual
> +'

The above suggestions about --detach/-C reflect how you did it in this
test, in which you first try "git switch foo" without the --guess
option, expecting it to fail, and then repeat with the option,
expecting it to succeed.
