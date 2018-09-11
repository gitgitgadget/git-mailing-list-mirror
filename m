Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 138751F404
	for <e@80x24.org>; Tue, 11 Sep 2018 21:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbeILCfz (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Sep 2018 22:35:55 -0400
Received: from mail-qt0-f176.google.com ([209.85.216.176]:36238 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727419AbeILCfy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Sep 2018 22:35:54 -0400
Received: by mail-qt0-f176.google.com with SMTP id t5-v6so29947756qtn.3
        for <git@vger.kernel.org>; Tue, 11 Sep 2018 14:34:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0pSZICyaE9yHMN6nbgTpvZ82ioq2DLryvPU0a0R0p4I=;
        b=DGUi7sIcqpK8bYQiXuMcEjS1exEizSlt33NXt4nvzVAPqxwio7uIyc4RaUbYyun7q/
         rIrnIdKa65BOSnrOp8xUlx3uBZSv59qBWld+xmm3RWTgjQIzOlwqQ3DjfjOSA3fwM/cL
         anUDyRwIosaOCV7sDe7fcQQ4yu/29j85931qI7t6JuFjUByAa+gpfJT2tbUXqSMq7j/d
         UVtuxjD59zpEl90Qyj/xqeFFsnDEFKhqVy8TluMtYTG6wKQiKT2zZqZHh0ofYCMg93bE
         x9ucwOCs9kPIszTJBGgu2MNjhBMESLLwdPlLpc/shImLPNQ/NSVjQsXmzzWhLCGtGqtx
         Hdpw==
X-Gm-Message-State: APzg51DxX63JEk7mKfvQ05XggBHyXUaz2cl6DagyJLNaB+VH1S7aKfBo
        AeMM3gyoi1EHPVRRJSJQD1EIME8oq5xZAhf6SzA=
X-Google-Smtp-Source: ANB0VdZVlY+fSY6fcGAPG8ibbMRhK32zjlynKnbfQPLwEaDu9/59ERWgrTH1xyzjZQ8O9MvE2P5IfzHPz7Bs++lSFF0=
X-Received: by 2002:a0c:b88f:: with SMTP id y15-v6mr19887091qvf.203.1536701680980;
 Tue, 11 Sep 2018 14:34:40 -0700 (PDT)
MIME-Version: 1.0
References: <pull.37.git.gitgitgadget@gmail.com> <58347a962438852be0d37c3957686ea5000b2dbd.1536697263.git.gitgitgadget@gmail.com>
In-Reply-To: <58347a962438852be0d37c3957686ea5000b2dbd.1536697263.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 11 Sep 2018 17:34:29 -0400
Message-ID: <CAPig+cQviMsbhdQty8DnBUWQx4hxNvH-FzXkNeHNBKy6mHGz5A@mail.gmail.com>
Subject: Re: [PATCH 1/1] t3206-range-diff.sh: cover single-patch case
To:     gitgitgadget@gmail.com
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 11, 2018 at 4:26 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> The commit 40ce4160 "format-patch: allow --range-diff to apply to
> a lone-patch" added the ability to see a range-diff as commentary
> after the commit message of a single patch series (i.e. [PATCH]
> instead of [PATCH X/N]). However, this functionality was not
> covered by a test case.
>
> Add a simple test case that checks that a range-diff is written as
> commentary to the patch.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
> diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
> @@ -154,4 +154,9 @@ do
> +test_expect_success 'format-patch --range-diff as commentary' '
> +       git format-patch --stdout --range-diff=HEAD~1 HEAD~1 >actual &&
> +       grep -A 1 -e "\-\-\-" actual | grep "Range-diff:"
> +'

Aside from Junio's and Stefan's comments...

Patch 6/14 [1], in addition to checking that a solo patch contains an
interdiff, takes the extra step of checking that individual patches
_don't_ contain an interdiff when --cover-letter is used. I wonder if
the same should be done here, though I don't feel too strongly about
it. If you do go that route, it might make sense to move this test to
t4014 as neighbor to the --interdiff tests. The reason 10/14 [2] added
the "git format-patch --range-diff" test to t3206 instead of t4014 was
so it could do a thorough check of the embedded range-diff by re-using
the specially crafted test repo set up by t3206. Your new test is much
looser, thus could be moved alongside the --interdiff tests. Not a big
deal, though. Either way is fine. Thanks for working on this.

[1]: https://public-inbox.org/git/20180722095717.17912-7-sunshine@sunshineco.com/
[2]: https://public-inbox.org/git/20180722095717.17912-11-sunshine@sunshineco.com/
