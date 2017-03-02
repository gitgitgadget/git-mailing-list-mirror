Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5DD120133
	for <e@80x24.org>; Thu,  2 Mar 2017 08:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754223AbdCBI5G (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 03:57:06 -0500
Received: from mail-lf0-f44.google.com ([209.85.215.44]:35954 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754038AbdCBI4m (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 03:56:42 -0500
Received: by mail-lf0-f44.google.com with SMTP id y193so30436367lfd.3
        for <git@vger.kernel.org>; Thu, 02 Mar 2017 00:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VmFKtjyjk9w41HABtoI8CL9Pu2ETo9QaXFE04V2BUDw=;
        b=C9saeRGc1a4wzlQZw3al5J8ZSxhvh5hBNxfg1GE1FOCwct6bFeNyx9O3t56MXo4i63
         jj0KoIJ37Q+tPjq//iZgxXoydkFdikRPc5FgX0gjohnqmh8tAe8qti4L2yX++vE3TfiD
         5umVtUWhN8oL69F4dXiN5dsZ2lA+Lh32LFxjM+lw1SgXAhxi9jUkdlR6fsQk92wOyP4g
         6AZc8POT3RCJ9w7pim1U/xeGT0AfxvxdyO2Rr9Tf6c9G4dj9u95CeEtDozHTeO7Ky2XL
         +wh5/ECvMrpP1c0Tbz7oNjJM4n+wY3LZNxpRoTMykb7jj0kTefL4iZAhJQJvuHQZGkbR
         vhIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VmFKtjyjk9w41HABtoI8CL9Pu2ETo9QaXFE04V2BUDw=;
        b=uKnH2G2HqNw4lFUkIHtCuasxD+ndmTa1jKNkFsCQi4d8S8x/0feuf/iOmhUAcLxjhZ
         lxBojE/oQ/7DpmuE+9u7bU/aDJD6f9IOD/VCApJaRJQpsW+L1mIAffioKjNK7heFQthj
         0lafILC7Cx0hx4eGjZFmdC0ZoyIuemlVIoK3sRN9RpvtZCgeySYTqNJNQ8VoKgd6jrq1
         DcJQWZzFH5xphFY4mqvrJDYOsA5WsYSKx40PtWlphDV74ul5L7n2KHnQMWbUXcxo95PZ
         W6+RItzRXyW72da4t1HZwRy/l/lOWQ2V+YoLcdoujv3m0BY99T4rL5WYJ73nJ/Fwg3Bv
         +hAA==
X-Gm-Message-State: AMke39mucAGARGo6JOjmDjWXCrjwNMmA2AWi76/m2p6L8iFd9zF5RTzJH+R7eXwYrvO+lh3jKHtJsgrqFw5G6A==
X-Received: by 10.46.15.9 with SMTP id 9mr4526790ljp.108.1488444440969; Thu,
 02 Mar 2017 00:47:20 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.30 with HTTP; Thu, 2 Mar 2017 00:47:00 -0800 (PST)
In-Reply-To: <20170302082100.edaretznmlralswa@sigill.intra.peff.net>
References: <20170302082100.edaretznmlralswa@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 2 Mar 2017 00:47:00 -0800
Message-ID: <CA+P7+xq+kJ4nq2LQq+KijK5Vj_+_RXfRt5LDecoEywsUdt0YXA@mail.gmail.com>
Subject: Re: [PATCH v2] fixing corner-cases with interpret_branch_name()
To:     Jeff King <peff@peff.net>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 2, 2017 at 12:21 AM, Jeff King <peff@peff.net> wrote:
> This is a re-roll of the series from:
>
>   http://public-inbox.org/git/20170228120633.zkwfqms57fk7dkl5@sigill.intra.peff.net/
>
> Thanks Junio and Jake for reviewing the original. This is mostly the
> same, but:
>
>   - it fixes the case where "branch -r @{-1}" mistakes a local branch
>     for a remote (and adds a test)
>
>   - as a result of the above fix, the series needs to be applied on top
>     of jk/auto-namelen-in-interpret-branch-name.
>
>   - I clarified the history in the commit message of patch 4
>
>   - the commit message for patch 4 now explicitly mentions which
>     callers can be left alone (so anybody blaming the history won't
>     think they were simply forgotten).
>
> With the exception of patch 6 flipping the failure/success bit on the
> new test, the rest of the patches should be identical.
>

I didn't find any comments, it was quite pleasant and well explained.

Thanks,
Jake

>   [1/8]: interpret_branch_name: move docstring to header file
>   [2/8]: strbuf_branchname: drop return value
>   [3/8]: strbuf_branchname: add docstring
>   [4/8]: interpret_branch_name: allow callers to restrict expansions
>   [5/8]: t3204: test git-branch @-expansion corner cases
>   [6/8]: branch: restrict @-expansions when deleting
>   [7/8]: strbuf_check_ref_format(): expand only local branches
>   [8/8]: checkout: restrict @-expansions when finding branch
>
>  builtin/branch.c                      |   5 +-
>  builtin/checkout.c                    |   2 +-
>  builtin/merge.c                       |   2 +-
>  cache.h                               |  32 +++++++-
>  refs.c                                |   2 +-
>  revision.c                            |   2 +-
>  sha1_name.c                           |  92 ++++++++++++-----------
>  strbuf.h                              |  21 +++++-
>  t/t3204-branch-name-interpretation.sh | 133 ++++++++++++++++++++++++++++++++++
>  9 files changed, 240 insertions(+), 51 deletions(-)
>  create mode 100755 t/t3204-branch-name-interpretation.sh
>
> -Peff
