Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 941D2C636D3
	for <git@archiver.kernel.org>; Wed,  8 Feb 2023 22:55:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbjBHWzJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 17:55:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232163AbjBHWzI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 17:55:08 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09AD029161
        for <git@vger.kernel.org>; Wed,  8 Feb 2023 14:55:07 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-52be9c49c07so2545967b3.3
        for <git@vger.kernel.org>; Wed, 08 Feb 2023 14:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z8ZM1QN7vpeZB9xei/KGyUofTwl1FwhuuZGC6Yc8JjE=;
        b=IV/biPoV9gEtHXy1P7oDxH9ka+aJvry2YwcQg5hmle3hPIt7XlU2CiJLJss5RCrp2V
         1DNtjpNMSYP3YLy0ACYOOvIF0iiRQFiYSbw8YdRFTo+rafWFJ2olvp5uVSCET1Eh4NU9
         rAkOe66UiU11MOvPDKWKgcenF3c3zAmYxSTc/HSQe26252UTFmvxobSPUkhY+LUhldLG
         zwMnhZ1BN8MiYBY+owXJru/+h1TC/dGza7iEEwoBC22DT4kuLmCPeIs6/5THaz4qly2V
         cfLdFQBAh1E3ZtStIlCqytSUJPzVkGzuycNxgyp5fwBlheaX8jf4wh15HdJpln9HlNjU
         O2uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z8ZM1QN7vpeZB9xei/KGyUofTwl1FwhuuZGC6Yc8JjE=;
        b=otytxT7US8i8WQoo4jufTLhZNCHdJcrhf7DvHUWnuDRDHhIFrqXFMEd+eQjry8yfVz
         yEMyL54X5tOprEzGMZBOpJO97QUHjS+LK4yidx7rAlLskJj0PaVHG5OGZfVONg8gDYFU
         Bbgn2fN8JbtBNfOM6rKE0iz/meG148Wqb+w14IQz7OfeCaN48yLEcW91TwhENyvf/oGm
         p9D32+tXnAuMrePrXgOj/ms8OfXuPagcwoIHEQ0BmqpmqvkApBQwqq46Uv2XTtXCfMvI
         kYWMg7duA71czYPIQQEyWixP/hHs/5kDAb5U/cZtFAzbvaFEu0Pqd4yLe8tRFAAzNtiL
         1zjw==
X-Gm-Message-State: AO0yUKU6FeVmjx1mmNJ5yi3F7WX3xQJs8ahxXOksENEZN8PJAA5wzOza
        uMxKXiresnWP8XbYjUGrqspgCIOVcfbwbCGj1nYonvdFabhplDhocgw=
X-Google-Smtp-Source: AK7set9Au9xDotVacLJTKJIas7ydNwBdHbZWxcbIlpbqmk00CYlVlCa1Pd9Tzt0dq1n1bY30kKXkUk7iBTrLi6zXwns=
X-Received: by 2002:a81:5e43:0:b0:4e3:f87:8c24 with SMTP id
 s64-20020a815e43000000b004e30f878c24mr1047941ywb.248.1675896906055; Wed, 08
 Feb 2023 14:55:06 -0800 (PST)
MIME-Version: 1.0
References: <20230117193041.708692-1-calvinwan@google.com> <20230207181706.363453-2-calvinwan@google.com>
 <cd528776-caa8-6372-0ca5-db0545947fba@dunelm.org.uk>
In-Reply-To: <cd528776-caa8-6372-0ca5-db0545947fba@dunelm.org.uk>
From:   Calvin Wan <calvinwan@google.com>
Date:   Wed, 8 Feb 2023 14:54:55 -0800
Message-ID: <CAFySSZDeC-zc7wS7WXE+bAijVQkuin5GwLRnJ2ok7C9PRaH3+g@mail.gmail.com>
Subject: Re: [PATCH v7 1/7] run-command: add duplicate_output_fn to run_processes_parallel_opts
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, avarab@gmail.com, chooglen@google.com,
        newren@gmail.com, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > +                     } else {
> > +                             if (opts->duplicate_output)
> > +                                     opts->duplicate_output(&pp->children[i].err,
> > +                                            strlen(pp->children[i].err.buf) - n,
>
> Looking at how this is used in patch 7 I think it would be better to
> pass a const char*, length pair rather than a struct strbuf*, offset pair.
> i.e.
>         opts->duplicate_output(pp->children[i].err.buf +
> pp->children[i].err.len - n, n, ...)
>
> That would make it clear that we do not expect duplicate_output() to
> alter the buffer and would avoid the duplicate_output() having to add
> the offset to the start of the buffer to find the new data.

I don't think that would work since
pp->children[i].err.buf + pp->children[i].err.len - n
wouldn't end up as a const char* unless I'm missing something?
