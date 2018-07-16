Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 648AE208E9
	for <e@80x24.org>; Mon, 16 Jul 2018 21:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729612AbeGPW2i (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 18:28:38 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:45755 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728522AbeGPW2i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 18:28:38 -0400
Received: by mail-yb0-f193.google.com with SMTP id h127-v6so16032576ybg.12
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 14:59:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u5UlVdcND0xiGWQ8G9cVo09vofxixQEZArpnUSiFnyc=;
        b=QB4oYQIMxAMW2UFlQX69DzTesOQbrol9IDB7TWuZFUG3CgLAvZVRvg/FHJhKMAqItY
         WfFgHPDrolbNMyOZwva4h8rRyANCRTFUmlzF8v4qaAxhZiv2AhUGqX+Ag0yqYZoylHL2
         JLUac5AAedSErpRfujiEPNPBB4zaOEx3zlnWwAGS+koAi3U8LVnM7YmywcE+QeSCtqaK
         KpyjgZl3F2BtSoRx0z7tsaARsuQhbaDk5oJROny2KmPLydxYNpcDZa/ZkAeSBqzzVsbJ
         xz0vTDwpSeWkogxzsafMvwJMNWELcH9TA7JqjyCIChBKsnNW3Po+g+nD/gTMxz7WFOA6
         09uA==
X-Gm-Message-State: AOUpUlEqZg8cCsBNsSSaAJkd3DWrZd61+4wfBmMbMipjmKjIv1lyQ4wd
        nx+C1P0ICGboIeg20p/Cg+JLC+QhEutEcVgQuvs=
X-Google-Smtp-Source: AAOMgpd1TP8NYUBmMqJxg/rgNh8AxBAnAtgTDo/P/PwHZ+DP6g6Vk4vBIoSKDuVHKX7uYVLTzgbwaL3QKhtnY8z01e0=
X-Received: by 2002:a25:9d81:: with SMTP id v1-v6mr9549695ybp.76.1531778356358;
 Mon, 16 Jul 2018 14:59:16 -0700 (PDT)
MIME-Version: 1.0
References: <pull.10.git.gitgitgadget@gmail.com> <3b0379cf6fb42ca5ee4e10cb20bf42ff333e1456.1531746012.git.gitgitgadget@gmail.com>
 <CAGZ79kbV-ahEYdCPyp6-mo+hVYr1c2+Xf-F5xYD3mCwBX9g16g@mail.gmail.com>
In-Reply-To: <CAGZ79kbV-ahEYdCPyp6-mo+hVYr1c2+Xf-F5xYD3mCwBX9g16g@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 16 Jul 2018 17:59:04 -0400
Message-ID: <CAPig+cQ+pDrhYmsUPe69MzGK8YiH_cGOp_cd592ZEBC4i2Lkhw@mail.gmail.com>
Subject: Re: [PATCH 12/16] test-reach: test reduce_heads
To:     Stefan Beller <sbeller@google.com>
Cc:     gitgitgadget@gmail.com, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 16, 2018 at 5:30 PM Stefan Beller <sbeller@google.com> wrote:
> > +test_expect_success 'reduce_heads' '
> > +       cat >input <<-\EOF &&
> > +               X:commit-1-10
> > +               X:commit-2-8
> > +               X:commit-3-6
> > +               X:commit-4-4
> > +               X:commit-1-7
> > +               X:commit-2-5
> > +               X:commit-3-3
> > +               X:commit-5-1
> > +       EOF
> > +       {
> > +               printf "reduce_heads(X):\n" &&
> > +               git rev-parse commit-5-1 &&
> > +               git rev-parse commit-4-4 &&
> > +               git rev-parse commit-3-6 &&
> > +               git rev-parse commit-2-8 &&
> > +               git rev-parse commit-1-10
> > +      } >expect &&
>
> Please use rev-parse only once.
>
> I am not sure about the usage of { braces } in the test suite,
> +cc Eric who sent a test suite linting series recently.
> Do we need to em-'brace' the statements that describe the
> expected behavior? (Or is it supposed to be easier to read
> for the reviewers? I found these very readable so far... but
> this question just came up)

Grouping the commands for redirection via a "{...}>expect" block is
less noisy than redirecting each command separately, thus more
reviewer-friendly. And, {...} blocks are used regularly in the test
suite, so no issue there.

I do agree that a single git-rev-parse with all 5 arguments makes more
sense (and would be appreciated by Windows folk). Also, the 'printf'
could be replaced by a simple 'echo' if we want to get nit-picky.

Finally, a style nit: We don't normally indent the content of a
here-doc like that. Instead, the content is normally aligned with the
closing EOF, not indented beyond it.
