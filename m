Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B7E31F516
	for <e@80x24.org>; Tue,  3 Jul 2018 07:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932896AbeGCHdV (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 03:33:21 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:36018 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932120AbeGCHdU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 03:33:20 -0400
Received: by mail-yb0-f196.google.com with SMTP id s1-v6so358377ybk.3
        for <git@vger.kernel.org>; Tue, 03 Jul 2018 00:33:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kxSZ8uMIYo464xxRdCH7/AAjOoOc1laBht7VDN42opo=;
        b=pdtiz2G8TegxIQWjCWoRIZBtKuK8EgxPW8PvBAxl9D10pOHpYhHffbKsDzugq0na/P
         fJHtHshdDdOlNe3WVNGy9Hj/vV6lUaCQbcDvTew42ugn6EczzJ/gRnQ/nBGizTyVhD7H
         LirMeFKrhcFN/zvAGqqO8rAVIC9EoZd1BBL9MLBt3ZaLIiSo2ypFCWJLGY2IV/oFU4qd
         GD5l37cSLrkSCjN0pcQ5FreStnrH00POS5QATZ5FsgnIfk9FMo/4ZAI0Nl95dZWc7nSH
         kQEI89lr7Gb5nefcydwy4lT8C8iguNoPNqbMEaz4UyVWAWK6by9bS6wjKDmS8fcitudm
         o17Q==
X-Gm-Message-State: APt69E3hkJP1O5LREOTK/HG3K5fQioLwlPe9KEKJSwX5mT2ClwDzJSyT
        J+J16CXZU6dmLZh3JIVCLq/Qci6LPXq1hq/QV/4=
X-Google-Smtp-Source: AAOMgpeHiVGUUv/7ctNxgsohG07hU+IRdHf8olZsoALJi/8Trdk+eid/40IEXAWaqBbDgZl9hqasyZJvY+SwhyjkaCc=
X-Received: by 2002:a25:d38f:: with SMTP id e137-v6mr5404258ybf.287.1530603199388;
 Tue, 03 Jul 2018 00:33:19 -0700 (PDT)
MIME-Version: 1.0
References: <20180703035802.24060-1-jyn514@gmail.com> <20180703035802.24060-3-jyn514@gmail.com>
In-Reply-To: <20180703035802.24060-3-jyn514@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 3 Jul 2018 03:33:08 -0400
Message-ID: <CAPig+cSZbGSsUvXmM1+q7ZhHmRg75tuM+=KyuzG5NFuzOdbYVA@mail.gmail.com>
Subject: Re: [PATCH 3/3] ls-tree: add unit tests for arguments
To:     jyn514@gmail.com
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 2, 2018 at 11:58 PM Joshua Nelson <jyn514@gmail.com> wrote:
> Signed-off-by: Joshua Nelson <jyn514@gmail.com>
> ---
> diff --git t/t3104-ls-tree-optional-args.sh t/t3104-ls-tree-optional-args.sh
> @@ -0,0 +1,43 @@
> +test_expect_success 'initial setup' '
> +echo hi > test && cp test test2 && git add test test2 && git commit -m initial'

As this is a new test script, please use modern formatting style:
indent test body with tabs, closing single-quote goes on its own line,
break lines at &&, and no whitespace between > and the filename. Also,
it's customary to simply to call the test "setup".

test_expect_success 'setup' '
    echo hi >test &&
    cp test test2 &&
    git add test test2 &&
    git commit -m initial
'

> +# cat appends newlines after every file

Why is this talking about a "cat"? Doesn't seem relevant.

> +test_expect_success 'succeed when given no args' 'git ls-tree'

This test seems too minimal. As the intention of this patch series is
to make git-ls-tree default to HEAD when no treeish is given, I would
expect the test with no arguments to verify that it did indeed list
the tree associated with HEAD. As implemented, this test tells us
nothing other than that it didn't error out or crash.

> +test_expect_success 'succeed when given only --' 'git ls-tree'

Um, what's this supposed to be testing? Presently, it seems to
duplicate the previous test. I'm guessing it should be running "git
ls-tree --" instead.

> +test_expect_success 'add second commit' '
> +echo hi > test3 && git add test3 && git commit -m "commit 2"'
> +
> +test_expect_success 'succeed when given revision' '
> +git ls-tree HEAD~1'

Given how patch 1/3 makes some fundamental changes to how git-ls-tree
processes its arguments, I would again expect this test to verify that
it indeed lists the correct tree. As the test is currently
implemented, we have no way of knowing what tree (if any) it listed.

> +test_expect_success 'succeed when given revision and --' '
> +git ls-tree HEAD~1 --'
> +
> +test_expect_success 'succeed when given -- and file' '
> +git ls-tree -- test3'

As above, given the fundamental changes to argument processing, I'd
expect this to verify that the output of this command is indeed what
is expected.

> +test_expect_success 'do nothing when given bad files' '
> +git ls-tree -- bad_files'

I wonder about this. Is it just an accident of implementation that
git-ls-tree doesn't error out in this case, or is it intended behavior
that it should return 0 even when the file is not in the tree? If the
0 exit code is just an accident of implementation, then we shouldn't
be enforcing this by a test (instead, someone perhaps ought to fix
git-ls-tree).

> +test_expect_success 'succeed when given file from past revision' '
> +git ls-tree HEAD~1 test'

Same comment as above about verifying gave expected output.

> +test_expect_success 'succeed when given only file' 'git ls-tree test'
> +
> +test_expect_success 'raise error when given bad args' '
> +test_must_fail  git ls-tree HEAD HEAD --'
> +
> +test_expect_success 'raise error when given bad revision' '
> +test_must_fail git ls-tree bad_revision --'
