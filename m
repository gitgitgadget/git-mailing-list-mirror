Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D2EE1F404
	for <e@80x24.org>; Wed, 18 Apr 2018 04:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753842AbeDREtg (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 00:49:36 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:39530 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751444AbeDREtf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 00:49:35 -0400
Received: by mail-wr0-f193.google.com with SMTP id q6-v6so963840wrd.6
        for <git@vger.kernel.org>; Tue, 17 Apr 2018 21:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=A10gNOD6wxqffkhXd4vGb88cYPn8QJaVa7/oq+bQsVc=;
        b=N5wh7sJ8efCyzWG/b1Kux7glObwAzbSxyBFGDUomeOXjy1t716Ai8ezngcVy8FQ9vG
         A7y9Y/8O8/Zzd5dmyVCVdiliV9ktbL0KV6rxzEnSFKM05X/TrZ799MKAzI4i+lLlEAWG
         dOeRH38IL1xnwiRqHs8akLKPB9etzlZ7pXdAQzdfQtzgrbOKO8aYoa6AYsVo6U0CyvUX
         jX2A5wJfMi5PStqWGU2FPW5wFCcxcS3vZLcYv5g1yVecrAody3U4Ki/reKpmF0vUL5Qk
         KqygWoD9ZzMuQyeiqPhHSDXz0WFNhmMQhUPfiwmJtuQ24SVCP53rC94PmKLeD4e3PPaP
         6GrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=A10gNOD6wxqffkhXd4vGb88cYPn8QJaVa7/oq+bQsVc=;
        b=DfaZPInrTE1o85kTrr7Wh/XoVswqy2KPij5BjPNXSWhpvbst9SCs/C9qeL8xwitTau
         YtbwJug83W+ID1aeIYatNFPhTUxF1O2JMzmgC8AF+SqLuvBSE09ZAVijWURqMAAyX+so
         R7PZg6MbcJkCUgVaoC3w4Fk8HjrozhkLWCuCkeh+h8PUNE/f0oVrcOKZsF71S/Gp/K0O
         tSmx3GUCEuEAFEJKDWswhq0jtwF1vOTERFWe1aeB1godtPHKAWXusrPpECclYg5Ix7MM
         OYpM9Y/SdC1xN6yMWemO2+radbiXAgk2SOdu+sFzECHCTqoXtMQIIFQoxIL7XL1kXBBb
         cFMQ==
X-Gm-Message-State: ALQs6tCthDrjojpr9eS1+/yNok1eOVI4Q2o4fB0dO6BH5INL98f13pHp
        lF5R4UTL4pMVtlp1FFkGwT4=
X-Google-Smtp-Source: AIpwx492uXUuSolUtPgMYeZw4rxDuOFAlvzBl18OGkCUUbqtaDZrN7kkUbh9NqLg5nP0PyBQfrDSfQ==
X-Received: by 2002:adf:e2cd:: with SMTP id d13-v6mr362094wrj.152.1524026973589;
        Tue, 17 Apr 2018 21:49:33 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id e10-v6sm631931wri.23.2018.04.17.21.49.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Apr 2018 21:49:32 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jameson Miller <jamill@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "pclouds\@gmail.com" <pclouds@gmail.com>,
        "jonathantanmy\@google.com" <jonathantanmy@google.com>
Subject: Re: [PATCH v1 0/5] Allocate cache entries from memory pool
References: <20180417163400.3875-1-jamill@microsoft.com>
Date:   Wed, 18 Apr 2018 13:49:32 +0900
In-Reply-To: <20180417163400.3875-1-jamill@microsoft.com> (Jameson Miller's
        message of "Tue, 17 Apr 2018 16:34:39 +0000")
Message-ID: <xmqqwox5i0f7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jameson Miller <jamill@microsoft.com> writes:

> This patch series improves the performance of loading indexes by
> reducing the number of malloc() calls. ...
>
> Jameson Miller (5):
>   read-cache: teach refresh_cache_entry to take istate
>   Add an API creating / discarding cache_entry structs
>   mem-pool: fill out functionality
>   Allocate cache entries from memory pools
>   Add optional memory validations around cache_entry lifecyle
>
>  apply.c                |  26 +++---
>  blame.c                |   5 +-
>  builtin/checkout.c     |   8 +-
>  builtin/difftool.c     |   8 +-
>  builtin/reset.c        |   6 +-
>  builtin/update-index.c |  26 +++---
>  cache.h                |  40 ++++++++-
>  git.c                  |   3 +
>  mem-pool.c             | 136 ++++++++++++++++++++++++++++-
>  mem-pool.h             |  34 ++++++++
>  merge-recursive.c      |   4 +-
>  read-cache.c           | 229 +++++++++++++++++++++++++++++++++++++++----------
>  resolve-undo.c         |   6 +-
>  split-index.c          |  31 +++++--
>  tree.c                 |   4 +-
>  unpack-trees.c         |  27 +++---
>  16 files changed, 476 insertions(+), 117 deletions(-)
>
>
> base-commit: cafaccae98f749ebf33495aec42ea25060de8682

I couldn't quite figure out what these five patches were based on,
even with this line.  Basing on and referring to a commit that is
not part of our published history with "base-commit" is not all that
useful to others.

Offhand without applying these patches and viewing the changes in
wider contexts, one thing that makes me wonder is how the two
allocation schemes can be used with two implementations of free().
Upon add_index_entry() that replaces an index entry for an existing
path, we'd discard an entry that was originally read as part of
read_cache().  If we do that again, the second add_index_entry()
will be discading, in its call to replace_index_entry(), the entry
that was allocated by the caller of the first add_index_entry()
call.  And replace_index_entry() would not have a way to know from
which allocation the entry's memory came from.

Perhaps it is not how you are using the "transient" stuff, and from
the comment in 2/5, it is for "entries that are not meant to go into
the index", but then higher stage index entries in unpack_trees seem
to be allocated via the "transient" stuff, so I am not sure what the
plans are for things like merge_recursive() that uses unpack_trees()
to prepare the index and then later "fix it up" by further futzing
around the index to adjust for renames it finds, etc.

Let me read it fully once we know where these patches are to be
applied, but before that I cannot say much about them X-<.

Thanks.

