Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 119151F404
	for <e@80x24.org>; Sat, 21 Apr 2018 20:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753278AbeDUUNq (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Apr 2018 16:13:46 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:37657 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753211AbeDUUNp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Apr 2018 16:13:45 -0400
Received: by mail-vk0-f66.google.com with SMTP id d9so7191981vka.4
        for <git@vger.kernel.org>; Sat, 21 Apr 2018 13:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+Dxmj0cMu4umRxyhmhXgq5DKUZcJb1HR2kXN14EDYso=;
        b=Di4ogwwYnENXS2VO9HJX8Juxqy/BKWPXmtFd9T413PgY5kyDl2AfQbFUTo2DpFQzj2
         aNigO1UiRrYTU5QS8fb5gWqS6p5Q+MTymRDtLBoh1dtOrrKbSpKL4+y/TpLHOpNTTgIz
         HPslqeiROA5iBOrgoZXwF7pxfI+xpiAovQZwRZn5ei/y/GS+wepcL/grjhCAJrv0zOjW
         3DvF5h/ZufibGKKUqptSOnlH2DWWrM9OCICOMmvbH6lPYMlHPChuUk7+WE7K1x83DRWi
         9aFjOc8JgUXzkoXAewGf4sVoTqtFWGyg3HPPJQu2RNQ7G8hSMgqNWVdfpmwiExCgCv+b
         8xqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+Dxmj0cMu4umRxyhmhXgq5DKUZcJb1HR2kXN14EDYso=;
        b=gFkWDOgiDEd27ra48vGd6WplJQqK6IRPeQztgx8wb/l5qORD1ojHZID0t2L1feaHAz
         zzXNce3c/HyF+rpH9YQU7N86fSMVXfuw7aOHKpDhzWLta1dV7uF7e9Qga+dmifhk6O7r
         HpjDL9YVLkUJ1vZ2DCmM1caAfBtSBYcYzlJDo9WYP3gVmqTQyTL0G2PV0l+P3Tjn/sFp
         BUBdWTNecL+AOuL00iV0Myr3n+WboSit8hdCvgT8WOwSxd2p/ZDXX/3ZBdHIieNd/0jS
         cO62WJFqsH8kBhhrtdSB4d9zlmquH9l2mzBuNszgVawPzfdBn9EBxd2lcVZp113nXpPu
         HAxA==
X-Gm-Message-State: ALQs6tBmuzCjRvVItgiTNAvxLlN47EtJpuCH9f0Lpxxj7byL589sf8Dm
        sAkFGCIOfiWY5pZk3Z5+KUm/of5R5MP1LhYFbv4=
X-Google-Smtp-Source: AIpwx48zS+6T7z3vUVzuwaEjJ4vYWopZG/flaQKPaRBFn+zsIphUEw0MPYJux/TnrLJGS7CfhxUs7OwY2JToaVrqlis=
X-Received: by 10.31.85.132 with SMTP id j126mr10167684vkb.184.1524341624080;
 Sat, 21 Apr 2018 13:13:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Sat, 21 Apr 2018 13:13:43 -0700 (PDT)
In-Reply-To: <20180421193736.12722-1-newren@gmail.com>
References: <20180420122355.21416-1-szeder.dev@gmail.com> <20180421193736.12722-1-newren@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 21 Apr 2018 13:13:43 -0700
Message-ID: <CABPp-BEZRd2rrqWVvqc=u5uokmEmNP9mzEbMhqs7p5vJt9_tXQ@mail.gmail.com>
Subject: Re: [RFC PATCH v10 32.5/36] unpack_trees: fix memory corruption with
 split_index when src != dst
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 21, 2018 at 12:37 PM, Elijah Newren <newren@gmail.com> wrote:
> Currently, all callers of unpack_trees() set o->src_index == o->dst_index.
> Since we create a temporary index in o->result, then discard o->dst_index
> and overwrite it with o->result, when o->src_index == o->dst_index it is
> safe to just reuse o->src_index's split_index for o->result.  However,
> o->src_index and o->dst_index are specified separately in order to allow
> callers to have these be different.  In such a case, reusing
> o->src_index's split_index for o->result will cause the split_index to be
> shared.  If either index then has entries replaced or removed, it will
> result in the other index referring to free()'d memory.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---

Also, I probably shouldn't have made this look like part of my series
(by marking it as "RFC PATCH v10 32.5/36").  It doesn't depend on my
series and is an independently valuable bugfix, though to avoid
breaking SZEDER and other split_index users, this patch should
probably go in before my series does.
