Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0541220248
	for <e@80x24.org>; Mon, 11 Mar 2019 17:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbfCKRA6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 13:00:58 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39719 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbfCKRA5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 13:00:57 -0400
Received: by mail-wm1-f67.google.com with SMTP id t124so568851wma.4
        for <git@vger.kernel.org>; Mon, 11 Mar 2019 10:00:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gUrK1+W3deJzkrlLA4Fq2IBGoSGzf1jxA74AL8og/RA=;
        b=cwUmoZVAe7XaD4Lv6kke0wHaDeP6sZpbsxDopJMhFBhVMY7u2sg+r9ZUCfKB5sjOmf
         xO2Jc9fZqhuLFMOkaCwc+0sVkqE1gfnGasR/3yKHC3K7ezQ+UgyiYtW8WGOYapJsBklr
         NsiD74a1hU0U2QOXuIZnFjOqkNcmDjA3dvQbFNwMXPaq1gNYcKxMNAxlY36WCR9D5jm9
         HJpNSL+TBH1jo7wy6YDC3WF5e/GSkfSlEGLS4Mn9Z+bJYDSY+s6LKZwXBUj7EHPyn1HJ
         EAB3gMRbkScXdyvthAYPh5ulokxj2FtuylRlNsHv9/9hXCMLqLnvnY4ydVGuyvY0xvpl
         0N3Q==
X-Gm-Message-State: APjAAAVGRia/aeP80EvnxJvBZMV/bCXUbRvyRcEZrUBFhSwkUgVMk7hg
        pDtaT0s/ocVd4xV495wC1Bd7XCiwqsKYhUgTggg=
X-Google-Smtp-Source: APXvYqw6V5HzsPDP+KoDqmcp1KHz/tb9iEVFhE2QgEbv3Va/G6J74OSsz56ccpF/Aic8/1dqG48cepT18CMlY7IYgkg=
X-Received: by 2002:a1c:c010:: with SMTP id q16mr31257wmf.134.1552323656006;
 Mon, 11 Mar 2019 10:00:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1548219737.git.liu.denton@gmail.com> <cover.1552275703.git.liu.denton@gmail.com>
 <b2b82954e7060a3f5d47f77e4743493ff4256bd6.1552275703.git.liu.denton@gmail.com>
 <CAPig+cS5YsjxuLGNAtfFguQvy2p2bJECSsHksx356+WsO1ct5w@mail.gmail.com> <2e10d78a-d92c-76c1-abc3-49ad1be55779@gmail.com>
In-Reply-To: <2e10d78a-d92c-76c1-abc3-49ad1be55779@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 11 Mar 2019 13:00:44 -0400
Message-ID: <CAPig+cQB2g-ZnbZc5ipPKQo0nGFK_2okOP+hq0cdW8Eq5tddaQ@mail.gmail.com>
Subject: Re: [PATCH v7 5/8] merge: cleanup messages like commit
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 11, 2019 at 6:14 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
> On 11/03/2019 05:49, Eric Sunshine wrote:
> > On Sun, Mar 10, 2019 at 11:42 PM Denton Liu <liu.denton@gmail.com> wrote:
> >> +       git cat-file -p HEAD |sed -e "1,/^\$/d" >actual &&
> >
> > An earlier patch in this series "fixed" a test with a Git command
> > upstream of a pipe. Yet, this test adds such an instance.
>
> Is it worth worrying about? We're not trying to test cat-file here and
> if it does fail the test will fail as actual will be empty.

git-cat-file could crash _after_ producing the expected output, in
which case we wouldn't learn about the crash at all since the pipe
would swallow it. While it's true that we're not specifically testing
git-cat-file here, with all the recent effort toward moving away from
having Git command upstream of a pipe, I don't think it makes sense to
add new cases. And it doesn't hurt to play it safe here: we might
actually catch a crash in git-cat-file which isn't caught by other
scripts which are genuinely testing that command.
