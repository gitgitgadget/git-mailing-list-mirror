Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1322C7EE30
	for <git@archiver.kernel.org>; Wed,  1 Mar 2023 23:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjCAXYE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Mar 2023 18:24:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjCAXYE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2023 18:24:04 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730B948E25
        for <git@vger.kernel.org>; Wed,  1 Mar 2023 15:23:57 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id p5-20020a056a0026c500b005cbeecd5c0dso7605110pfw.3
        for <git@vger.kernel.org>; Wed, 01 Mar 2023 15:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677713037;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QgrrVjiDItwy7mxxCLpikmM3hf9tCnqmVsCkNn9uCmg=;
        b=p2ERobv71ZdJbVCLOHgu+XoMwUpY3uxAZxessYi3/x46c0J46n2d5mjLsT7n9e6AYR
         inkyZDoOJwnNgmrhB1ENPAlntRdp7E+fPX1qc/ZijsF3NQt5UuaAIkcAgsZ89baalOLO
         k59ZPML3Q9ehNMhRfCizMm32rJFazmTw62BibP+DN3SBRBfDKxU7WyAVNZH3ZVXVGKwN
         9x7RsSbu4Rabo2mPuaHlYE7z72/pHYxqiff6lfz5odo+DiApgIV0+a0fzkkXDnsJ3E6p
         3cro4lbZ3DXK1WP+YkWxl/cvhR0/Vk+uGLdS+ZcpCt98D7JmmUmk20ARAhKFKHHLK+tx
         pwuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677713037;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QgrrVjiDItwy7mxxCLpikmM3hf9tCnqmVsCkNn9uCmg=;
        b=zVhCId756/fQ5ASn3KvECSu9X+u7K9WN2PrL4kOAGoj7CEE+FmfN8cgP3qbsz20EQn
         Bo8x1MQQerle7Jj4b0LWqowQ4STXyuJqIb3rqMYvN4vURSnqI8KBIwN7kiObUZmoZE4u
         0kPYuJhJaOqkjjkM40eCOKBDCvIwuDxJShDO232clJ3hF1QBWsfi5wNu6MV917bQlpca
         7ZM9mxQqqXOQK4W4ykjv7bl9x4cDE78ITlSDfiLSWCMNLKD3rRXhlj6U9VNwGlhXPHN+
         huq5bCJ3f6OTRS+v8IJkZljFY6vnDprEADxC1JQbq86nTeMS52NkSQ8hn/Sw/zNjUQy2
         rvdw==
X-Gm-Message-State: AO0yUKVJzNQPUcKlPsim/XCGfhM7/pU5oy38OnTtexmqGYKVAMvfEzBD
        b5sPjGQ5jZmgno4tSUQR4dduvTdmA6eSog==
X-Google-Smtp-Source: AK7set9r3O0c00DQiesvXnaoPP6KhH61uTUqDbijN47eHZrJmdtDaY/Efy2txhrZlQ0ayBfhIUP7kQcF7+Xueg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:d59:b0:606:a4bd:8dde with SMTP
 id n25-20020a056a000d5900b00606a4bd8ddemr1821692pfv.4.1677713036837; Wed, 01
 Mar 2023 15:23:56 -0800 (PST)
Date:   Wed, 01 Mar 2023 15:23:55 -0800
In-Reply-To: <20230225180325.796624-2-alexhenrie24@gmail.com>
Mime-Version: 1.0
References: <20230223053410.644503-1-alexhenrie24@gmail.com>
 <20230225180325.796624-1-alexhenrie24@gmail.com> <20230225180325.796624-2-alexhenrie24@gmail.com>
Message-ID: <kl6lttz43vjo.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v5 1/3] rebase: add documentation and test for --no-rebase-merges
From:   Glen Choo <chooglen@google.com>
To:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        tao@klerks.biz, gitster@pobox.com, newren@gmail.com,
        phillip.wood123@gmail.com, Johannes.Schindelin@gmx.de,
        sorganov@gmail.com
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>

I inferred from the 'subject line' that this "always" worked and was
undocumented, and that we'd want to document this not for its own sake,
but because we'll introduce a config option. I would personally prefer
to get that explicitly in writing, but it's definitely not worth a
reroll.

>  -r::
>  --rebase-merges[=(rebase-cousins|no-rebase-cousins)]::
> +--no-rebase-merges::
>  	By default, a rebase will simply drop merge commits from the todo
>  	list, and put the rebased commits into a single, linear branch.
>  	With `--rebase-merges`, the rebase will instead try to preserve
>  	the branching structure within the commits that are to be rebased,
>  	by recreating the merge commits. Any resolved merge conflicts or
>  	manual amendments in these merge commits will have to be
> -	resolved/re-applied manually.
> +	resolved/re-applied manually. `--no-rebase-merges` can be used to
> +	countermand a previous `--rebase-merges`.
>  +
>  By default, or when `no-rebase-cousins` was specified, commits which do not
>  have `<upstream>` as direct ancestor will keep their original branch point,
> diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh

This isn't the fault of this patch, but I find this description a little
confusing. First we say

  By default (*when no option is given*), a rebase will simply drop
  merge commits from the todo list...

and then later we also say

  By default (*when --rebase-merges is provided without a value), or
  when `no-rebase-cousins`...

So although you didn't create this problem, given the changes we're
making in the later patches, I think we have the chance to make this
description more sensible; I'll elaborate in my response to those
patches.
