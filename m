Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A466BC64E69
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 16:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61FE32225B
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 16:24:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729409AbgKTQYQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Nov 2020 11:24:16 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33094 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728980AbgKTQYP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Nov 2020 11:24:15 -0500
Received: by mail-ed1-f65.google.com with SMTP id k4so10147201edl.0
        for <git@vger.kernel.org>; Fri, 20 Nov 2020 08:24:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nAjsaigg1DFBrqXaFdXADFkwGdJXfMDS/1hbUy/+NYo=;
        b=iu7Et3WXmFCIMSSDeizKg/ixrdSQzmPjYEdcCtK5Kx67bnDvFGWAeI1g+6fd22XRNZ
         4xYdNOOpL0qHgFdVxC9gi9Tmit/I1VK4mN8yhRzBZx6Uok2y/5YSoZZact2RVJx67T3r
         QpoQLaSnFIwM74HP1az2zrnD05dtTfE8eoeGtl07Pg+UdfBpxLjwzjM3zP9k3fS/kxOS
         4dTeWvYSfHTLijJwQQwWG74kgpYcPDs3NbPgh+R8KZdgc0q+0yE1s5g+ZKr50J3p5Lm9
         W2DklfMQqEyeT6o44NjQPdxkUYiLSgYG17WDBl4zlXyULr3Q5CBknuJ4xZel4SXSw02u
         KfQQ==
X-Gm-Message-State: AOAM5325EpKm4xUBh8xGLtnCJ+8/MtdMI5xeb/m+acIMizPW5oNrFBVI
        acQXmBhA4q11awpslGKWXhWG18c4ND9wPMBA8d8=
X-Google-Smtp-Source: ABdhPJz5Dwm05yjxNoQ49eo+Ul5Cz/Pj2BCcGlBmMm2j7h0S4qkdt7zmFgI0dMyCJsLIdjhdcNVMPZJGUrRomtTp2fo=
X-Received: by 2002:aa7:cc0e:: with SMTP id q14mr36345246edt.181.1605889454196;
 Fri, 20 Nov 2020 08:24:14 -0800 (PST)
MIME-Version: 1.0
References: <1d740e0d4fc08a9f420373c6cd0a554b3b4b1f40.1605883395.git.matheus.bernardino@usp.br>
In-Reply-To: <1d740e0d4fc08a9f420373c6cd0a554b3b4b1f40.1605883395.git.matheus.bernardino@usp.br>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 20 Nov 2020 11:24:03 -0500
Message-ID: <CAPig+cS7SEARwoBn25SsxhkvdJfDe56FyVjDGk+sJq2kXfDbjQ@mail.gmail.com>
Subject: Re: [PATCH] worktree: fix order of arguments in error message
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 20, 2020 at 10:09 AM Matheus Tavares
<matheus.bernardino@usp.br> wrote:
> `git worktree add` (without --force) errors out when given a path
> that is already registered as a worktree and the path is missing on
> disk. But the `cmd` and `path` strings are switched on the error
> message. Let's fix that.

Thanks. This problem was introduced quite recently by d179af679b
(worktree: generalize candidate worktree path validation, 2020-06-10).

> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> ---
> -               die(_("'%s' is a missing but locked worktree;\nuse '%s -f -f' to override, or 'unlock' and 'prune' or 'remove' to clear"), cmd, path);
> +               die(_("'%s' is a missing but locked worktree;\nuse '%s -f -f' to override, or 'unlock' and 'prune' or 'remove' to clear"), path, cmd);

The fix is obviously correct. For what it's worth, this patch is:

Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>
