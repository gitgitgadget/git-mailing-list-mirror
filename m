Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC555C433F5
	for <git@archiver.kernel.org>; Thu, 23 Dec 2021 11:34:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243287AbhLWLeb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Dec 2021 06:34:31 -0500
Received: from mail-io1-f41.google.com ([209.85.166.41]:36585 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbhLWLe3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Dec 2021 06:34:29 -0500
Received: by mail-io1-f41.google.com with SMTP id p65so6681790iof.3
        for <git@vger.kernel.org>; Thu, 23 Dec 2021 03:34:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NTNtDsqEbkSMt6RmdmWyKIvT2i98bwGUm2Gx5KlykPw=;
        b=6k6xblHFYieEwkQrcvX/ZytViy6NnzvIFwxCXcwZh5VJtWj2IR0WzNdksWyBu0Vlox
         Qvr0114HxCz8Vd1uMfTzT1/4jGJ1EfjUL0xG+TiApZ1cGFq9PKod8xAAwmQ6xO2czWdH
         FXeN0E4uuwwIKWYNaWuimYSCxnGXBGHyLwcW5alyKQYgc0iN4PvRcaYiyXycTZip1Prq
         q5VW0FlUW/1jXr2ZV0gBn8LeL4JXwZqKZXsS3koUX5t4vRzb8GXRVh834Vulm64x0QXj
         8MXlGTJBgY2l7gR0LS4QVABLcj/0o//VAsnHq87OrrU95uBdtKEyOdmN0jLKCQBSaqn0
         iXQg==
X-Gm-Message-State: AOAM53060xV1z1mr+lL3TpRalV7SlOOn4A+KPE0YzqG+VG5T+KnbeVM4
        Cc4Kovfjb9eDt8GZX7lWu//+lHU0Gjxt06bdoBg=
X-Google-Smtp-Source: ABdhPJx5+7LAfA3sVG5t3D8iFpY/XHMbxs79di5V8zvS7CYq54wUHQ4Q3hmjHkBf5SNi+qVGWf0SK4npnH8PnrdpCkM=
X-Received: by 2002:a05:6602:2acc:: with SMTP id m12mr869268iov.107.1640259269318;
 Thu, 23 Dec 2021 03:34:29 -0800 (PST)
MIME-Version: 1.0
References: <CABceR4ZW4rRWZnH0ZBkWty_H84Z4CmXque_LO+1edETEWrO8PQ@mail.gmail.com>
 <211220.86k0fzwmq2.gmgdl@evledraar.gmail.com> <CA+JQ7M8oxzUAkw-Nv4X+3bJt7cBhsUaqFKd67Y=LNLnv2kgM+Q@mail.gmail.com>
 <YcEJtOknDjSgxK5j@camp.crustytoothpaste.net> <xmqqa6guub9n.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2112221717440.347@tvgsbejvaqbjf.bet> <xmqqczloju0q.fsf@gitster.g>
 <CA+JQ7M-8LydHMCgMYGP9LNMJMWk_-7LLYa5WEMMb_QMpeF-+Ag@mail.gmail.com> <xmqq35mkdvsu.fsf@gitster.g>
In-Reply-To: <xmqq35mkdvsu.fsf@gitster.g>
From:   Erik Cervin Edin <erik@cervined.in>
Date:   Thu, 23 Dec 2021 12:33:53 +0100
Message-ID: <CA+JQ7M826Wj3Lq8XEr1w9quj9vM6EWH9ivSfvaXYrkh1dA2vfg@mail.gmail.com>
Subject: Re: Custom subcommand help handlers
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Sean Allred <allred.sean@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I do not know what your 'w' is.

Sorry, I was unclear.
With exit code 0

I was experimenting to see if you could use
an external alias to force --help to be passed to cmd.

But you can't because
    if (!exclude_guides || alias[0] == '!') {
        printf_ln(_("'%s' is aliased to '%s'"), cmd, alias);
        free(alias);
        exit(0);
    }

Which is probably reasonable


On Thu, Dec 23, 2021 at 1:11 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Erik Cervin Edin <erik@cervined.in> writes:
>
> > Another observation.
> >
> > This also applies to external aliases
> >   git -c alias.fr='!git-filter-repo' fr --help
> > returns
> >   'fr' is aliased to '!git-filter-repo'
> >  w exit code 0
>
> I do not know what your 'w' is.  To me I get
>
>     $ git -c alias.fr='!git-filter-repo' fr --help
>     'fr' is aliased to '!git-filter-repo'
>
> which is consistent with what I get for other aliases, e.g.
>
>     $ git -c alias.lg='log --oneline' lg --help
>     'lg' is aliased to 'log --oneline'
>
> folowed by whatever "log --help" would give us.
>
> So hopefully when your 'w' learns to show the documentation for
> 'git-filter-repo' command, such an alias would also work as
> expected, no?
>
> Anyway, unlike "man" and "info" where there is a standard way to
> tell the command that "I have documentation pages in these places"
> so that additional documentation can be installed to locations the
> user chooses (and has access to), the "web" format viewers are
> invoked without such customizability, i.e. in builtin/help.c, we see
> this code snippet:
>
> static void get_html_page_path(struct strbuf *page_path, const char *page)
> {
>         struct stat st;
>         char *to_free = NULL;
>
>         if (!html_path)
>                 html_path = to_free = system_path(GIT_HTML_PATH);
>
>         /*
>          * Check that the page we're looking for exists.
>          */
>         if (!strstr(html_path, "://")) {
>                 if (stat(mkpath("%s/%s.html", html_path, page), &st)
>                     || !S_ISREG(st.st_mode))
>                         die("'%s/%s.html': documentation file not found.",
>                                 html_path, page);
>         }
>
>         strbuf_init(page_path, 0);
>         strbuf_addf(page_path, "%s/%s.html", html_path, page);
>         free(to_free);
> }
>
> It may not be a bad idea to extand the function to understand a new
> GIT_HTML_PATH environment variable, which can be a colon-separated
> list of directories just like MANPATH and INFOPATH are.  It would be
> rather trivial to update the block with a call to stat() above to a
> loop over these directories.
>
>
>
