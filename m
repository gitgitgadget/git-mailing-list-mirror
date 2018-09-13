Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE15C1F404
	for <e@80x24.org>; Thu, 13 Sep 2018 17:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbeIMXFW (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Sep 2018 19:05:22 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37151 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727992AbeIMXFV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Sep 2018 19:05:21 -0400
Received: by mail-qk1-f196.google.com with SMTP id f17-v6so3689623qkh.4
        for <git@vger.kernel.org>; Thu, 13 Sep 2018 10:54:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2II2iGyRyDevobmU2pTIeqv0p3G9OmJL8/EMDGwarCQ=;
        b=deZyR1wiJV26Ckav29HCDmFf81uWRCQFshmXFQGyOudHZC8z0U0khhOlfVjFj+d85E
         dPXoJTRbLVFwdcRf3PF9A8XKmPWpIslinwYiUcEHyLrm2mmN6iFdgnpAvIps73BxWYLf
         Q6yOgburITqK8UfPR70fOod58E7G19n8vlEmiR9+m1AztyQlk+tK9yeKl4FyOytVKQ20
         0UximhvZPXgCWT8jkWKfkOdpSPmj3dEZQjtvN+lil6V4oZHyB2jO5hrB3ZVgueBZWDho
         wyzNsQ29OWvikTo8/qe2lRdg67XI7HHOJb5MkZQ71sU2hWsu/1sUqpd7TnBt004S5KTD
         qjlw==
X-Gm-Message-State: APzg51CtdBNsTh3VB2mcEpjYmF78tXUA1sgenpyZOnFIzwwV03RkQMEp
        Bn0DqwvlhPuOxipoJF7dZHRS41Vh7+ahgwp1hTU=
X-Google-Smtp-Source: ANB0VdZjLZwUZsCQbgmtEpSMb1PM37JiQx69mfeB+c8xA8WXw5twOli5Y1JDwiG+pAs2+6dWoVLNydc/bggsebj2yoo=
X-Received: by 2002:a37:4653:: with SMTP id t80-v6mr5757996qka.314.1536861288686;
 Thu, 13 Sep 2018 10:54:48 -0700 (PDT)
MIME-Version: 1.0
References: <pull.40.git.gitgitgadget@gmail.com> <pull.40.v2.git.gitgitgadget@gmail.com>
 <7714b0659e3210e34d0904b3347473427546d15c.1536850601.git.gitgitgadget@gmail.com>
In-Reply-To: <7714b0659e3210e34d0904b3347473427546d15c.1536850601.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 13 Sep 2018 13:54:37 -0400
Message-ID: <CAPig+cQeA9UhVEAz-4TgMD4K6FsFk5tL0AH_uSjXApt888q25g@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] contrib: add coverage-diff script
To:     gitgitgadget@gmail.com
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 13, 2018 at 10:56 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> There have been a few bugs in recent patches what would have been caught
> if the test suite covered those blocks (including a few of mine). I want
> to work towards a "sensible" amount of coverage on new topics. In my opinion,
> this means that any logic should be covered, but the 'die()' blocks in error
> cases do not need to be covered.

The bit about die() blocks is perhaps a bit too general. While it's
true that some die()'s signal very unlikely (or near-impossible)
conditions, others are merely reporting invalid user or other input to
the program. The latter category is often very much worth testing, as
the number of test_must_fail() invocations in the test suite shows.
68a6b3a1bd (worktree: teach 'move' to override lock when --force given
twice, 2018-08-28), which was highlighted in your cover letter,
provides a good example of legitimately testing that a die() is
covered. So, perhaps the above can be toned-down a bit by saying
something like:

    ...but die() blocks covering very unlikely (or near-impossible)
    situations may not warrant coverage.

> It is important to not measure the coverage of the codebase by what old code
> is not covered.
