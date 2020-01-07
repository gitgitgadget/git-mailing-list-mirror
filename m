Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28CBCC32771
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 03:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5444206F0
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 03:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=atlassian-com.20150623.gappssmtp.com header.i=@atlassian-com.20150623.gappssmtp.com header.b="aEvl8ixS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbgAGDk0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jan 2020 22:40:26 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:33201 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbgAGDkZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jan 2020 22:40:25 -0500
Received: by mail-io1-f67.google.com with SMTP id z8so51133025ioh.0
        for <git@vger.kernel.org>; Mon, 06 Jan 2020 19:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3ilAyK8BsWDr4MEpgK2Id/WshYqtCs8eEpdXn9D5W6I=;
        b=aEvl8ixSEGAGAhAkKoAFaeMlp3SGNCtcYRZg78RoRcN89MgxZ03Ar2jaVz/CfAcPze
         R6kC9Zs1U9akiEE6zyMYbAKAO89YugKknxwHtZACHG6KkiJ7mlzH3NfxmTRGMuZRQMA9
         YGXlAH2x95vUifZuN6GhsZwvainqMEuw7MHIa4EcgCdacdLnSc8Bxm9YiiLbvopZZvPU
         BXWROQz4L9EH9iPpFjliAP2RFThe1rVcV0coCpFP3oLz901zgHPtHoCXSK/FDQbHJ/h1
         bM4uAR4QTBTvQ15i3zTvRjNFAVxWA4Oj4VB7O6llYP9mcvSBFLNhCefY8CjUYzXRy7hg
         anYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3ilAyK8BsWDr4MEpgK2Id/WshYqtCs8eEpdXn9D5W6I=;
        b=onOA0YZVhucH/Ft/p2me0do472QjybDsdH839wtIen5PHojR5Zj/IWz89MTNVjKJ09
         1iiYdAC+SZtnnQbs0SLoJt4m+4WkjGFmmFxe0KcRtuo5QBVwg/0aDUX03WdLAVXiL2eO
         wRqjPmbNg5TBEWeGvpJNs/A/0B6JjpSfEPLxjHF81VJtxV09bQDGB/ikvx7qsxjPxgzO
         0vV3xt3oZBYbRggzDK9y4oQCeOiPAZtyx56hwZS0heIjY73cKq1GanOIolwRqc85t8sZ
         zr2e2Ei0mhf6Xuzx+P82/JAT94Vct5Z5C9DlG/PjsgXlYB5uKRg17JK5FZU/i54YALiz
         yclw==
X-Gm-Message-State: APjAAAVXXh4BFSWoxdLySib76MpE1k51XesbGhGR56FENNAPfUPkkm6b
        REXgii5TK/wwwzLYcqMajGtytLuyM0FSv0czzE7Cqw==
X-Google-Smtp-Source: APXvYqzNLxnQW1wCC1kBa2G7oMEuPSqV/02xX+amN2wfBTgCJ3nUVxIvFtDN5b64U42xSsNLpXqOxjbA1OEi1YRLn7I=
X-Received: by 2002:a6b:8e47:: with SMTP id q68mr68364500iod.274.1578368424686;
 Mon, 06 Jan 2020 19:40:24 -0800 (PST)
MIME-Version: 1.0
References: <20200107013640.1821227-1-sandals@crustytoothpaste.net> <20200107020425.GG92456@google.com>
In-Reply-To: <20200107020425.GG92456@google.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Mon, 6 Jan 2020 19:40:13 -0800
Message-ID: <CAGyf7-GpCSaBauuKunDxBcZbcHU2sYkrt3+BpdF20dN8ZuPZgw@mail.gmail.com>
Subject: Re: [PATCH] run-command: avoid undefined behavior in exists_in_PATH
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Users <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        "Miriam R." <mirucam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 6, 2020 at 6:04 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> brian m. carlson wrote:
>
> > In this function, we free the pointer we get from locate_in_PATH and
> > then check whether it's NULL.  However, this is undefined behavior if
> > the pointer is non-NULL, since the C standard no longer permits us to
> > use a valid pointer after freeing it.
> [...]
> > Noticed-by: Miriam R. <mirucam@gmail.com>
> > Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> > ---
> >  run-command.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>
> This API that forces the caller to deal with the allocated result when
> they never asked for it seems a bit inconvenient.  Should we clean it up
> a little?  Something like this (on top):
>
> -- >8 --
> Subject: run-command: let caller pass in buffer to locate_in_PATH
>
> Instead of returning a buffer that the caller is responsible for
> freeing, use a strbuf output parameter to record the path to the
> searched-for program.
>
> This makes ownership a little easier to reason about, since the owning
> code declares the buffer.  It's a good habit to follow because it
> allows buffer reuse when calling such a function in a loop.
>
> It also allows the caller exists_in_PATH that does not care about the
> path to the command to be slightly simplified, by allowing a NULL
> output parameter that means that locate_in_PATH should take care of
> allocating and freeing its temporary buffer.
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
>  run-command.c | 51 +++++++++++++++++++++++++++++----------------------
>  1 file changed, 29 insertions(+), 22 deletions(-)
>
> diff --git i/run-command.c w/run-command.c
> index f5e1149f9b..a6dc38396a 100644
> --- i/run-command.c
> +++ w/run-command.c
> @@ -170,52 +170,57 @@ int is_executable(const char *name)
>   * The caller should ensure that file contains no directory
>   * separators.
>   *
> - * Returns the path to the command, as found in $PATH or NULL if the
> - * command could not be found.  The caller inherits ownership of the memory
> - * used to store the resultant path.
> + * Returns a boolean indicating whether the command was found in $PATH.
> + * The path to the command is recorded in the strbuf 'out', if supplied.
>   *
>   * This should not be used on Windows, where the $PATH search rules
>   * are more complicated (e.g., a search for "foo" should find
>   * "foo.exe").
>   */
> -static char *locate_in_PATH(const char *file)
> +static int locate_in_PATH(const char *file, struct strbuf *out)
>  {
>         const char *p = getenv("PATH");
>         struct strbuf buf = STRBUF_INIT;
>
> -       if (!p || !*p)
> -               return NULL;
> +       if (!out)
> +               out = &buf;
> +
> +       if (!p || !*p) {
> +               strbuf_reset(out);

Since the while loop and this block both call strbuf_reset(out);, is
there a reason not to do:
if (out)
        strbuf_reset(out);
} else {
        out = &buf;
}
above? The loop below would still need its own reset, but it could do
that when it decides to loop.

> +               strbuf_release(&buf);
> +               return 0;
> +       }
>
>         while (1) {
>                 const char *end = strchrnul(p, ':');
>
> -               strbuf_reset(&buf);
> +               strbuf_reset(out);

This reset would be removed

>
>                 /* POSIX specifies an empty entry as the current directory. */
>                 if (end != p) {
> -                       strbuf_add(&buf, p, end - p);
> -                       strbuf_addch(&buf, '/');
> +                       strbuf_add(out, p, end - p);
> +                       strbuf_addch(out, '/');
>                 }
> -               strbuf_addstr(&buf, file);
> +               strbuf_addstr(out, file);
>
> -               if (is_executable(buf.buf))
> -                       return strbuf_detach(&buf, NULL);
> +               if (is_executable(out->buf)) {
> +                       strbuf_release(&buf);
> +                       return 1;
> +               }
>

We'd call strbuf_reset(out); here instead, before we break or loop.

>                 if (!*end)
>                         break;
>                 p = end + 1
>         }
>
> +       strbuf_reset(out);

And we could leave this one out; if we make it here, we'd know the
buffer was already reset.

>         strbuf_release(&buf);
> -       return NULL;
> +       return 0;
>  }
>
>  static int exists_in_PATH(const char *file)
>  {
> -       char *r = locate_in_PATH(file);
> -       int found = r != NULL;
> -       free(r);
> -       return found;
> +       return locate_in_PATH(file, NULL);
>  }
>
>  int sane_execvp(const char *file, char * const argv[])
> @@ -427,15 +432,17 @@ static int prepare_cmd(struct argv_array *out, const struct child_process *cmd)
>          * directly.
>          */
>         if (!strchr(out->argv[1], '/')) {
> -               char *program = locate_in_PATH(out->argv[1]);
> -               if (program) {
> -                       free((char *)out->argv[1]);
> -                       out->argv[1] = program;
> -               } else {
> +               struct strbuf program = STRBUF_INIT;
> +
> +               if (!locate_in_PATH(out->argv[1], &program)) {
>                         argv_array_clear(out);
> +                       strbuf_release(&program);
>                         errno = ENOENT;
>                         return -1;
>                 }
> +
> +               free((char *)out->argv[1]);
> +               out->argv[1] = strbuf_detach(&program, NULL);
>         }
>
>         return 0;

Just a thought. (Pardon the noise from the peanut gallery!)

Best regards,
Bryan Turner
