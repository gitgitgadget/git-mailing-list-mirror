Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D6971F4BD
	for <e@80x24.org>; Tue,  1 Oct 2019 06:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729228AbfJAG45 (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Oct 2019 02:56:57 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:47077 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbfJAG45 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Oct 2019 02:56:57 -0400
Received: by mail-vk1-f196.google.com with SMTP id o137so675510vka.13
        for <git@vger.kernel.org>; Mon, 30 Sep 2019 23:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YZows5skMeuAi4tGZ0GZ7pG33htJ6cAk5mWq2JSLFBU=;
        b=tT6Sl0zIQ+SGDbvgCZv9VTP52OSP+aGqDMd1UrzE/b+z1eMvcgsFXIbbjRHvjDqLNS
         EVYAIiHabTZp3btfDb2HXpiFV5iFX9NjnPTeJkITxjrNVbokElFbmTD48ifA4NqLDoud
         1b8TtFbID3acwIbMrGNbCKZWwq5ANtSJIMZJ2fZ4GErmikb70vfTlQNAXtpG0LTjFQv3
         iGB7A+9csde8eSnw7O4L6DRQq/1yiAcROHFGx1ac7pQFT4GHXcUAUsnNrSU/SUDC99i/
         //2OU4qTauBvl2z5yZTMXFM2lHrhqpBOCsQYsAn/trgNDPWFtWTBi+ZN7/FGWtIr9HtF
         0yFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YZows5skMeuAi4tGZ0GZ7pG33htJ6cAk5mWq2JSLFBU=;
        b=DpFnxObiA+FeLJYmiJBS9A1oyky6R1A7mbjOWCrRRip0hSpQP8l3LoQQywx+sGfidw
         pj8+GBCmnJR3a+iT2NdU7cI1++TcT7cOZ4fkfE+lKOm4eATVzNJC8US+i7x6V0OZOTni
         4xbBFwUKQwP5AkZxUwY5uD+/mI/WyVO1nxO5a+YQBlKXK+CeMI/lszy/43JaQEcDFf7r
         c0ApOlbgfGVJJCXFCluy7x9JW1kDcOpYHa413ar37IGxkJg1AwrkAXO905cGzLqt1+yi
         Bj7sbqa9O7V7cY6G807KoeNW+X4WrHuRxo+LUVUYhIYgqU4bqeIk/7nnn8NTzM6haJzW
         kEbA==
X-Gm-Message-State: APjAAAWNplBHc1XVduY5cmBbv+7VijwTvMkkxZmO2WsunalaaAQBiExQ
        0MVL1sy5XsTIv24fWg3NnOaw3hF1phqwsESlPMDr3Pa1
X-Google-Smtp-Source: APXvYqwbdJziUhEgZnrIWdVgIEeQXxOl1zetppO66+jlFS6Q4BAG6K92oQgeO/bL9ixgpY1q6f9PXSv5k8QY4zKMdgs=
X-Received: by 2002:a1f:b987:: with SMTP id j129mr7253684vkf.27.1569913014318;
 Mon, 30 Sep 2019 23:56:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190930211437.GA28110@sigill.intra.peff.net> <20190930225455.6208-1-newren@gmail.com>
In-Reply-To: <20190930225455.6208-1-newren@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 30 Sep 2019 23:56:43 -0700
Message-ID: <CABPp-BGreoki4M8waiiSsF2NVf+2B_NFs3qFzsg2WQ6zQpNe7g@mail.gmail.com>
Subject: Re: [PATCH] merge-recursive: fix the diff3 common ancestor label for
 virtual commits
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 30, 2019 at 3:55 PM Elijah Newren <newren@gmail.com> wrote:
>
> In commit 743474cbfa8b ("merge-recursive: provide a better label for
> diff3 common ancestor", 2019-08-17), the label for the common ancestor
> was changed from always being
>
>          "merged common ancestors"
>
> to instead be based on the number of merge bases:
>
>     >=2: "merged common ancestors"
>       1: <abbreviated commit hash>
>       0: "<empty tree>"
>
> Unfortunately, this did not take into account that when we have a single
> merge base, that merge base could be fake or constructed.  In such
> cases, this resulted in a label of "00000000".  Of course, the previous
> label of "merged common ancestors" was also misleading for these cases.
> Since we have an API that is explicitly about creating fake commits in
> merge_recursive_generic(), we should provide a better label when using
> that API.  So, when merge_recursive_generic() is called, set the label
> to:
>
>          "constructed merge base"
>
> Note that users of merge_recursive_generic include the builtin commands
> git-am (in combination with git apply --build-fake-ancestor),
> git-merge-recursive, and git-stash.
>
> Reported-by: Jeff King <peff@peff.net>
...
> @@ -3741,6 +3744,7 @@ int merge_recursive_generic(struct merge_options *opt,
>                                            oid_to_hex(merge_bases[i]));
>                         commit_list_insert(base, &ca);
>                 }
> +               opt->ancestor = "constructed merge base";

This should have a 'if (num_merge_bases == 1)' check before it; I'll
be sending a v2 shortly and update the commit message slightly.
