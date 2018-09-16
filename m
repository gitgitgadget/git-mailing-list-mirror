Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2ACBD1F404
	for <e@80x24.org>; Sun, 16 Sep 2018 07:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbeIPMjk (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Sep 2018 08:39:40 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:36730 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbeIPMjj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Sep 2018 08:39:39 -0400
Received: by mail-qt0-f193.google.com with SMTP id t5-v6so12599562qtn.3
        for <git@vger.kernel.org>; Sun, 16 Sep 2018 00:17:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lNddHphR91ClH/E0a5oSXgHzhFDpgroVgolV07zaUgg=;
        b=BQmWkuEt0Kk2IIh6w7gvvGxQRV5Q/XeUa9tCltG2OW7WY215xUdBws3SGJfi5J7bG2
         Kmk3VRPzvKTXrs3MYulYzI6xU5ejIFX67VyMvkjnfWTv6iMdVJ2pnibJKGI8MODfEhMs
         /XMarKbUPF+jIq/tp9aATlEWqcrwVQoXZkXRzK5P7E8N2lvB3wt5craODZhM/jS9bSwM
         xYMvwGjJUxhT8Y3ltEbulnVacEWluOdy+UDqEa7gY9B5CF2sDFevO38pJX5Yd8uQswpA
         1psSIm2kChQtrXfL9BzQT1H7+gzD+BMy9I++XD4Dnh8KrhhwULLCsWOKZOcZC+TGX7d0
         z34w==
X-Gm-Message-State: APzg51BP7A9losPPdXazGiB+oMZq0gtiVv56VAe8v4sq/2g3Y5kcKMlC
        kuGFkdv3n/HiiLK+iXzba4cddOjpEdbYk5Y5I6m/WQ==
X-Google-Smtp-Source: ANB0VdZwFwCmb4W2HjckeLFBMpkN3tpv50BdSf3BFq8Ife1lN1BqGBbej+bI+gVVG2eHtXlYaxxQkite6Gko3rxyUnE=
X-Received: by 2002:aed:2aa1:: with SMTP id t30-v6mr14192507qtd.101.1537082260986;
 Sun, 16 Sep 2018 00:17:40 -0700 (PDT)
MIME-Version: 1.0
References: <c92b2f25-315d-141b-8974-dd05d7fd2b9e@ramsayjones.plus.com>
In-Reply-To: <c92b2f25-315d-141b-8974-dd05d7fd2b9e@ramsayjones.plus.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 16 Sep 2018 03:17:29 -0400
Message-ID: <CAPig+cSm52i=ypGoPGGumhP+_waq=OU2QZ=p3oVzTTzLsNpfNA@mail.gmail.com>
Subject: Re: [PATCH] read-cache.c: fix a sparse warning
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Ben Peart <benpeart@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 14, 2018 at 7:29 PM Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
> At one time, the POSIX standard required the type used to represent
> a thread handle (pthread_t) be an arithmetic type. This is no longer
> the case, probably because different platforms used to regularly
> ignore that requirement.  For example, on cygwin a pthread_t is a
> pointer to a structure (a quite common choice), whereas on Linux it
> is defined as an 'unsigned long int'.
>
> On cygwin, but not on Linux, 'sparse' currently complains about an
> initialiser used on a 'struct load_index_extensions' variable, whose
> first field may be a pthread handle (if not compiled with NO_PTHREADS
> set).
>
> In order to fix the warning, move the (conditional) pthread field to
> the end of the struct and change the initialiser to use a NULL, since
> the new (unconditional) first field is a pointer type.
>
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
> If you need to re-roll your 'bp/read-cache-parallel' branch, could you
> please squash this into the relevant patch (commit a090af334,
> "read-cache: load cache extensions on a worker thread", 2018-09-12).

The information contained in this commit message is so useful that it
might make sense to plop this patch at the end of the series rather
than merely squashing it in. (Or, if it is squashed, include the above
explanation in the commit message of the appropriate patch.)
