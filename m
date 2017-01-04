Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F40C020756
	for <e@80x24.org>; Wed,  4 Jan 2017 20:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030656AbdADU2g (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Jan 2017 15:28:36 -0500
Received: from mail-qk0-f173.google.com ([209.85.220.173]:34998 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030590AbdADU2F (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jan 2017 15:28:05 -0500
Received: by mail-qk0-f173.google.com with SMTP id u25so407513945qki.2
        for <git@vger.kernel.org>; Wed, 04 Jan 2017 12:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QUBPfUXnNEqU7r6Z0VsnSOrpzkoaebjhOVAcN+mqqZ8=;
        b=feFTiWmN1+aCTL526D3XNpwbicey+ER3gPAiEyl8pIM2ux0xq44Oj5HPw0Gu9/WSM2
         FbAdFDXBSPG3RODfB8xwO+b/QujzWt/D0Glrz4tbZ+71cWdK2EYz/YzxDssyj7tNF7yq
         V55rm61cWUmZRwUMwpjpbzei5NQullzk6O6E4/9y6ZBdqmAuwrFIfLB5InP3mmeao/Y9
         EzylWvrFlJf3JCuCjHdQCjEMr3fDB1ku9BlpdbdC0bWKImhB+S9jG6VtCM6iinQ6DDOw
         ZKjhE1XCtqFglhdFP+35HJdZFHyQT0s0p0eig12rcnOOrt+SETYNxW/wtGkzCRTti6np
         PDww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QUBPfUXnNEqU7r6Z0VsnSOrpzkoaebjhOVAcN+mqqZ8=;
        b=qqMvmwbcQ1YmCHApsJZiDHJr41fS88e3FtOF16mEb0xAfeJQlhCQnTqk1AVMxkfpGg
         Zeiejr/Rf5Zr72okhHxOM5GQ7g+rGnhz1Fm8xV9Mq2VWkuOH62CmYRpmqSSKi04UNUL4
         cnfzr+WQ2MTTkqIwEM2bsW1rJ44Ien0FoGozN0WOdJH0vJ2xJ0gZjICzExX8zra9GE1+
         wuPOpvY7T329Pc/GGwWF0NeHt6HMxWLjZqmh3jLLowra7ar8eFi0xb/cFqIzAZymsdci
         H5vMor6OEOV/ZEJJAj3QJOPlSYvLce0Q1caS7tfFsp/JE+2/WYSa20TWKz6DxqQ6CPk0
         Y2Qw==
X-Gm-Message-State: AIkVDXIAurZvyl93BiWK1EclA2U8WafBkwzCC3JaeeS5iwIH8LRFOZ8pfTu4wyEvqQB3xIA9qQHyfUAi+028QDMw
X-Received: by 10.55.90.68 with SMTP id o65mr34784498qkb.47.1483561665703;
 Wed, 04 Jan 2017 12:27:45 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.146.7 with HTTP; Wed, 4 Jan 2017 12:27:45 -0800 (PST)
In-Reply-To: <20170104005042.51530-3-hansenr@google.com>
References: <20170104005042.51530-1-hansenr@google.com> <20170104005042.51530-3-hansenr@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 4 Jan 2017 12:27:45 -0800
Message-ID: <CAGZ79kb9UvV6AaRLBP5OzyRtTTXarRZRZDMd_1k5n9CrgbVr5A@mail.gmail.com>
Subject: Re: [PATCH 2/4] t7610: make tests more independent and debuggable
To:     Richard Hansen <hansenr@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        David Aguilar <davvid@gmail.com>, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 3, 2017 at 4:50 PM, Richard Hansen <hansenr@google.com> wrote:
> If a test fails it might leave the repository in a strange state.  Add
> 'git reset --hard' at the beginning of each test to increase the odds
> of passing when an earlier test fails.

So each test is cleaning up the previous test, which *may* confuse
a reader ("how is the reset --hard relevant for this test? Oooh it's
just a cleanup").

We could put it another way by having each test itself make clean
up after itself via

  test_when_finished "git reset --hard" &&
  ..

at the beginning of each test.
This would produce the same order of operations, i.e. a
reset run between each test, but semantically tells the reader
that the reset is part of the current test cleaning up after itself,
as "reset" is operation for this particular test to cleanup.
Does that make sense?


>
> Also use test-specific branches to avoid interfering with later tests
> and to make the tests easier to debug.

That sounds great!
Though in the code I only spot one occurrence for

+       git checkout -b test$test_count branch1 &&

so maybe that could be part of the first patch in the series?

Thanks,
Stefan
