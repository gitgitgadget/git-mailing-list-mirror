Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E2CC433EF
	for <git@archiver.kernel.org>; Sun,  5 Sep 2021 18:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18A0F60524
	for <git@archiver.kernel.org>; Sun,  5 Sep 2021 18:01:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235508AbhIESCV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Sep 2021 14:02:21 -0400
Received: from mail-ed1-f47.google.com ([209.85.208.47]:34710 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234484AbhIESCU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Sep 2021 14:02:20 -0400
Received: by mail-ed1-f47.google.com with SMTP id i6so6161914edu.1
        for <git@vger.kernel.org>; Sun, 05 Sep 2021 11:01:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m8FkBNZSBPA7ea0LzKHs14TLl7rFd+uCrkNttgpIF84=;
        b=KZehwvZD9BuJ+JYdz7FpBt/efU+MD4lohKPmFq1VOHjGtY1t33yAvktaf9sNpdqACY
         p0SsnKn+xeskV8Go0tP5+AKrQWhw0Y7CFnQ4pwfBuVlsWlBhxJgpGLp/5eXtAJ+rrd/3
         Q8wHwvc3e1dQC4HhJf4IX1eA2nCeJg15kA18+f9zXkbtnwjeSj4iv9oJXEnAkfyYET+S
         YEcu7awXTf/MMvhTE1Ph3RnTQoJRS5829Qnr594EfanmRr2T56MGrcLu60dQPK14Mbut
         lv06Q4OBm0/B482ooWC7rfboFkEQIMNoXtPpGccHIHZRwTplan1tquyN9H2rBsX7fyCh
         sR0Q==
X-Gm-Message-State: AOAM533ep0/4mkrv8Z7xHqmbpAeuGgBxuFFxB7QBq+hwsdJITy7BUXZe
        RY7/e4LGLfOZQRPvWCATjqP5mjO1psdPXuD0lBEBE/w3
X-Google-Smtp-Source: ABdhPJz87296e89axjyKe4ESpL2FSvu33qNobIQRfZJ+t7WE+oy6205v845g6/TJD3wVx4AYZvP6Sy5FjUm+/PcN74U=
X-Received: by 2002:a05:6402:318c:: with SMTP id di12mr9679282edb.55.1630864875834;
 Sun, 05 Sep 2021 11:01:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210905120506.635130-1-someguy@effective-light.com>
In-Reply-To: <20210905120506.635130-1-someguy@effective-light.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 5 Sep 2021 14:01:04 -0400
Message-ID: <CAPig+cQ2TDjdWd+xUEQ1OQAH8tBQTv=O73MdMOBf8GZ1LFbzDQ@mail.gmail.com>
Subject: Re: [PATCH] pretty: colorize pattern matches in commit messages
To:     Hamza Mahfooz <someguy@effective-light.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 5, 2021 at 8:05 AM Hamza Mahfooz
<someguy@effective-light.com> wrote:
> [...]
> Teach the pretty-printer code to highlight matches from the
> "--grep=<pattern>", "--author=<pattern>" and "--committer=<pattern>"
> options (to view the last one, you may have to ask for --pretty=fuller).
>
> Signed-off-by: Hamza Mahfooz <someguy@effective-light.com>
> ---
> diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
> @@ -232,6 +232,14 @@ notes.displayRef::
>         or `GIT_NOTES_REF`, to read notes from when showing commit
>         messages with the `log` family of commands.  See
>         linkgit:git-notes[1].
> +
> +color.grep.selected::
> +       Determines the non matching text (background) color of selected lines,
> +       when `--grep`, `--author` or `--committer` are used.
> +
> +color.grep.matchSelected::
> +       Determines the matching text (foreground) color of selected lines, when
> +       `--grep`, `--author` or `--committer` are used.
>  +
>  May be an unabbreviated ref name or a glob and may be specified
>  multiple times.  A warning will be issued for refs that do not exist,

The paragraph which begins "May be an unabbreviated..." belongs to the
`notes.displayRef` item (which is indicated by the line containing
only a `+` just before the paragraph), so this newly-inserted text
incorrectly divorces the item from the rest of its description. The
two new `color.grep.*` items which this patch adds should be placed
after _all_ the paragraphs connected by `+` lines.
