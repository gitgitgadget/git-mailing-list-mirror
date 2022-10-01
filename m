Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9545BC433FE
	for <git@archiver.kernel.org>; Sat,  1 Oct 2022 18:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiJASpu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Oct 2022 14:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiJASps (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Oct 2022 14:45:48 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C49C22B25
        for <git@vger.kernel.org>; Sat,  1 Oct 2022 11:45:44 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id b5so6663687pgb.6
        for <git@vger.kernel.org>; Sat, 01 Oct 2022 11:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date;
        bh=s/WpkHwyZsq4x+J8f6rUN6UZASOaHqlAFopDtjql0YQ=;
        b=Bapkd/PEboKZ3mrE4g9VKD92yWy0bCK271AAElnoUQiQdRoCuQ4gvQHoedewWb68iP
         G1QovHp1DOu2tqrsTwJ3Kw02j8sqFyW/yNsebWlhqWYhu3mFHh9vEFIYfczSsox1eCxO
         wyRQYlsIGX70yZcU5fmUdhBHWQnAGvu5bUPC9qJpj8rS5sSimeyyTqNhAJZPW/GaU0+E
         4B3nECE5zrst2A0p1vOwh4J2G5HEGzCtT1AXH0kflnHqn9rr9wq6fl5dJ9x/nSxIYdM9
         zotfNhrFlQD/GrpEme0OCxVMpflJfLYxb199iOxesJXRWz8m2GZUyxOF585B9eJYZOL+
         rQ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date;
        bh=s/WpkHwyZsq4x+J8f6rUN6UZASOaHqlAFopDtjql0YQ=;
        b=BvJ4EBVcVk4TRa7C71Kz8+vsoNzlTVLesqRVZOVELXdQsuLcOX0pPKAfxaNnROyatS
         7fBgMBQpUMBUqrxlULQr5Qd6VVB/MDz1R/PWHmHvJlgnS33xPcMRCJtgB74hZgt9nyFy
         W6FTmX9Nj92bV9dmSvwSyO+BFQOah41QRsfphvpT4TqgpWLBlpr+5ExnB4dYAOq3W++z
         Qe+tlzFEt2EVGg1WEdiLJ2j9YSfY35cgJPW7NI+eL4DUwxcZMUoVBNLe50AU0RGZHwdc
         VDzvCsMcW96GVR/wFe/+NcrWhKrKB5FuaCM6IL13G2Nju6D5jGsbvNYPWn6GVKeM5yIA
         VKmw==
X-Gm-Message-State: ACrzQf2rKSiWTvK7ev1Cn5y7fnQ3hv9TwR+0JN+baAi0ZOENvV+wIOjm
        bafl8U+nV+z7dtGI9+c+TJ0=
X-Google-Smtp-Source: AMsMyM7glzYOoBO1H+82zKiwxq6sSWg3dWBOZPqsFebyuuAmUnwv2LUPjS0odH1o62U9vUjy815nIQ==
X-Received: by 2002:a63:6a03:0:b0:43a:18ce:7473 with SMTP id f3-20020a636a03000000b0043a18ce7473mr12934154pgc.616.1664649944015;
        Sat, 01 Oct 2022 11:45:44 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id w129-20020a626287000000b0053e607a6bf0sm1636299pfb.43.2022.10.01.11.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 11:45:43 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 22/36] doc txt & -h consistency: make "rerere"
 consistent
References: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
        <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
        <patch-v3-22.36-702eb747c0f-20220930T180415Z-avarab@gmail.com>
Date:   Sat, 01 Oct 2022 11:45:43 -0700
In-Reply-To: <patch-v3-22.36-702eb747c0f-20220930T180415Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 30 Sep
 2022 20:07:45
        +0200")
Message-ID: <xmqqmtaf2xig.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> For "rerere" say "pathspec" consistently, and list the subcommands in
> the order that they're discussed in the "COMMANDS" section of the
> documentation.

pathspec refers to the entire set of patterns, which consists of one
or more "pathspec element"s, so there is no need for "..." there.

Listing the commands in the order they are described does make
sense.

> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  Documentation/git-rerere.txt | 2 +-
>  builtin/rerere.c             | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-rerere.txt b/Documentation/git-rerere.txt
> index 9d0e6f53e7e..992b469270c 100644
> --- a/Documentation/git-rerere.txt
> +++ b/Documentation/git-rerere.txt
> @@ -8,7 +8,7 @@ git-rerere - Reuse recorded resolution of conflicted merges
>  SYNOPSIS
>  --------
>  [verse]
> -'git rerere' [clear | forget <pathspec> | diff | remaining | status | gc]
> +'git rerere' [clear | forget <pathspec>... | diff | status | remaining | gc]
>  
>  DESCRIPTION
>  -----------
> diff --git a/builtin/rerere.c b/builtin/rerere.c
> index 12570537d37..8b7392d5b44 100644
> --- a/builtin/rerere.c
> +++ b/builtin/rerere.c
> @@ -10,7 +10,7 @@
>  #include "pathspec.h"
>  
>  static const char * const rerere_usage[] = {
> -	N_("git rerere [clear | forget <pathspec>... | status | remaining | diff | gc]"),
> +	N_("git rerere [clear | forget <pathspec>... | diff | status | remaining | gc]"),
>  	NULL,
>  };
