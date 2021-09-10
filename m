Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B67FC433EF
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 14:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E064611C7
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 14:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234132AbhIJO5k (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 10:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbhIJO5j (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 10:57:39 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877F4C061574
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 07:56:28 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 9so2855707edx.11
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 07:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=EjITJ7ICJDvr5jXL3/qYca+y5NWSZsiT4DBRLc+u0ZE=;
        b=f3f+0dOzpJ2zLluTDsPQgAhk2EQdtH5vqvRQQa0xJdmlbHoec/7WzP8EahMo1BhzFW
         KpRg5FKBYeAC8PCt46W5dA9O44kmhe+h0vwpSH3MP4W1GvvyG/JKoo2GXV1Htpq8A38+
         vWzIBxOaW+iUktpokxfcru9SmpqdOaCWwXPZ9tMYThwTsvxSairmqVIjq9N+KONtjiEe
         O80jGk+fsvTu+vyeJe/IgwA5P+bHQ5G4WrUmnuBJ7Y4n+jQ9ut6FN0prhBywINp9jE0e
         FtakN/w2A95hC3Vw1HP1vfD7OLM6peXY4kQQXXcM15UwPcXSaxRxoPzr4jjKv1/D/1wQ
         OOZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=EjITJ7ICJDvr5jXL3/qYca+y5NWSZsiT4DBRLc+u0ZE=;
        b=HevEsMnzYTR0GYm1NZTJKiv9NOPc1H25BhWSj06oHth0XzrFFwwkoxhACP16VsCihZ
         6dTgI97AMU58H8Whjdl4kTGUzqdDjf5YTU+ZbuMkxXB5sTgAu8FB4cQ76tumwCbABh+U
         VtGhODzDoT4u1TYVnIr7N84QCXFYVj5WzLA9pyCWUO2b/WAYkYX4gDkG5gW1vQSwOX5z
         uqopumLpaafp35UERt+0gkk32EFcUeXECQUDJk46VlY9o+tp4/x36HgpgVRnvW/ZZmXr
         jSv3r8gYg4rxkH8zQJtLBYk+tjmUDfMe0OpNKQ5+sFZe+lzpcLDi/7cJAawHDYV0xTlr
         AI+A==
X-Gm-Message-State: AOAM531L7BaCMLu/hKNZxM0YdHB44gzqdyMb4IlUiH0eabrVvdsAbv5Z
        62gRtvi8+kkgQmH2GvDOTTkK9mBvyxZJHA==
X-Google-Smtp-Source: ABdhPJx+ow45Ba//1CYjRAJPIr1H+F+EwjlDXA7jHuFlusEReBHuVv1i0Q/ZZad4adg9xYjt2STjyA==
X-Received: by 2002:a05:6402:3454:: with SMTP id l20mr1360350edc.83.1631285786904;
        Fri, 10 Sep 2021 07:56:26 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id a18sm2925608edj.52.2021.09.10.07.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 07:56:26 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Wong <e@80x24.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Alban Gruin <alban.gruin@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 05/11] rebase: drop support for `--preserve-merges`
Date:   Fri, 10 Sep 2021 16:53:42 +0200
References: <pull.195.v2.git.1630497435.gitgitgadget@gmail.com>
 <pull.195.v3.git.1631048712.gitgitgadget@gmail.com>
 <2d7a4a2c564aaafbf8da97cf017766163c77b70b.1631048713.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <2d7a4a2c564aaafbf8da97cf017766163c77b70b.1631048713.git.gitgitgadget@gmail.com>
Message-ID: <87pmtgcwdi.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Sep 07 2021, Johannes Schindelin via GitGitGadget wrote:

> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 33e09619005..5f8d9f89ba4 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -48,8 +48,7 @@ static GIT_PATH_FUNC(merge_dir, "rebase-merge")
>  enum rebase_type {
>  	REBASE_UNSPECIFIED = -1,
>  	REBASE_APPLY,
> -	REBASE_MERGE,
> -	REBASE_PRESERVE_MERGES
> +	REBASE_MERGE
>  };

This definitely doesn't require a re-roll, but just in case you didn't
know, from CodingGuidelines:

   . since early 2012 with e1327023ea, we have been using an enum
     definition whose last element is followed by a comma.  This, like
     an array initializer that ends with a trailing comma, can be used
     to reduce the patch noise when adding a new identifier at the end.

(That was added in cc0c42975a2 (CodingGuidelines: spell out post-C89
rules, 2019-07-16))

I.e. in case you're slavisly following this particular bit of C syntax
for C89 compatibility it's not needed anymore, which helps to make diffs
smaller, and writing code generation loops less annoying.
