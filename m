Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,RDNS_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (unknown [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D175C433C1
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 04:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B90EF619AF
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 04:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbhCUEF4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Mar 2021 00:05:56 -0400
Received: from mail-ej1-f47.google.com ([209.85.218.47]:41576 "EHLO
        mail-ej1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbhCUEFi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Mar 2021 00:05:38 -0400
Received: by mail-ej1-f47.google.com with SMTP id u5so15839535ejn.8
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 21:05:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iJbVGJ4vgd3s/F3+u7D5qQykXgZrPB7hKf3/OaCM5Pg=;
        b=Gxz8FL9j6HneYQIPMgXBPPT9uC3hpUoaWubee30rBp9lbs0NlcNFeaEjw6PEtEldBu
         P68KwndMmrGSSN+pTAUjMPKRzPyn4UvGvAXkkaJqEZdKm6g0ZZBgMScO7h+PA9ttYl7X
         9iYf6x2IAOdzsY6AF3xYgQoTgQX8rt/3jsy7/Z5zetVVL7N+SfAwaO7n9x6vWM24F1lN
         xfmJ6oyzPA9q1zd6qam5y9XaxbuNbIFjUshCER9PXvIz8KU+MB+VvvnfE/HjNmdkBzDG
         e8D3A6zfvnK1MfHuySKsWItv3gFLrmMKHIAcM9/NU7+QFvcGdVJB08BuOgc0YSV42nWE
         BHTw==
X-Gm-Message-State: AOAM533bns5mvpNrk4oOm4TlfhoYOEtCIWC/64QezAbOJyEZKarvVBqL
        VfjluVepprYvdND7t/t3+gJ66F198eMj94sJ2+U=
X-Google-Smtp-Source: ABdhPJzdLAI6c5HlCOR+qmvQyKsMWqtaTEc1nrEhqhqQ43WTeCsQMmcS5rvJe1a8E20lKnsqn89f0N+zzlRkkJ+EGdA=
X-Received: by 2002:a17:906:d8c6:: with SMTP id re6mr12143360ejb.311.1616299537600;
 Sat, 20 Mar 2021 21:05:37 -0700 (PDT)
MIME-Version: 1.0
References: <pull.885.v7.git.1616152884317.gitgitgadget@gmail.com> <pull.885.v8.git.1616252178414.gitgitgadget@gmail.com>
In-Reply-To: <pull.885.v8.git.1616252178414.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 21 Mar 2021 00:05:26 -0400
Message-ID: <CAPig+cQBATCe4XFt1k0_EfYvb61_RVgTO0NGy6Ykg7frNPbtpQ@mail.gmail.com>
Subject: Re: [PATCH v8] format-patch: allow a non-integral version numbers
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 20, 2021 at 10:56 AM ZheNing Hu via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
> @@ -221,6 +221,11 @@ populated with placeholder text.
> +        `<n>` may be a non-integer number.  E.g. `--reroll-count=4.4`
> +       may produce `v4.4-0001-add-makefile.patch` file that has
> +       "Subject: [PATCH v4.4 1/20] Add makefile" in it.
> +       `--reroll-count=4rev2` may produce `v4rev2-0001-add-makefile.patch`
> +       file that has "Subject: [PATCH v4rev2 1/20] Add makefile" in it.

This new example raises the question about what happens if the
argument to --reroll-count contains characters which don't belong in
pathnames. For instance, what happens if `--reroll-count=1/2` is
specified? Most likely, it will fail trying to write the
"v1/2-whatever.patch" file to a nonexistent directory named "v1".

> diff --git a/log-tree.c b/log-tree.c
> @@ -369,8 +369,8 @@ void fmt_output_subject(struct strbuf *filename,
> +       if (info->reroll_count)
> +               strbuf_addf(filename, "v%s-", info->reroll_count);
>         strbuf_addf(filename, "%04d-%s", nr, subject);

To protect against that problem, you may need to call
format_sanitized_subject() manually after formatting "v%s-". (I'm just
looking at this code for the first time, so I could be hopelessly
wrong. There may be a better way to fix it.)
