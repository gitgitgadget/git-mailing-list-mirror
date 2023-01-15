Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886A8C46467
	for <git@archiver.kernel.org>; Sun, 15 Jan 2023 22:04:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbjAOWEs convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 15 Jan 2023 17:04:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbjAOWEr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Jan 2023 17:04:47 -0500
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA341817E
        for <git@vger.kernel.org>; Sun, 15 Jan 2023 14:04:45 -0800 (PST)
Received: by mail-pj1-f54.google.com with SMTP id v13-20020a17090a6b0d00b00219c3be9830so29348419pjj.4
        for <git@vger.kernel.org>; Sun, 15 Jan 2023 14:04:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tubpHIjzORXfI6VI0GYaSN9+t855E4qrEPcOEHD5R+U=;
        b=RY/OkGKQkXJgh0RMtE4Ajufyh/9c1fZtGSkBc0Xpbqh1K4Or7pDLXmtu91lZdaLgRO
         MoxKiFpsJi7LF9T0buDrFo0f8sVhyixSCT8sKBWNyGuMRz5w4aqPH1BSIdYHOqB037K3
         aVKibc8UwQtVMzvOpJOaDaDbytoUSlrHNrPM2Qp2BNxNHn7P4Zq5gmuSJHzW/4GOlMBl
         k7jzkTjuLwhPi73UjTmjQ3+1ekOPbwbhB7JCpG444bfr3i14CiUXfwanbAhLmjA1oEvf
         iZ8Zx7EUhfPJZH/HkLLc+F/Zh+ihkV4JYiCmgGP/M8H+9lDh9LXOKAS5pZx9ieWVeAWR
         V4jA==
X-Gm-Message-State: AFqh2kps2wUpkK4qLNXcQY+WHVX7OIeFYDlf0XN80JHHOgaMMi3WRWxq
        yHhDYF0w8aGEblVfK4kRmafxQxuu16O26owU3v0=
X-Google-Smtp-Source: AMrXdXst1y4gEWXyL64dr9gLU5t2L7HgNW8VapFLqUPOGfe+VKE/cjpwioLAZhf/extMhl6mBHkZTPnD9qCaIChbOSU=
X-Received: by 2002:a17:90a:408b:b0:229:3505:d48e with SMTP id
 l11-20020a17090a408b00b002293505d48emr639633pjg.22.1673820284532; Sun, 15 Jan
 2023 14:04:44 -0800 (PST)
MIME-Version: 1.0
References: <cover.1673490953.git.dyroneteng@gmail.com> <f7edbd0e508243ab55c13721a21b78bf50278a21.1673490953.git.dyroneteng@gmail.com>
 <230112.86y1q812y4.gmgdl@evledraar.gmail.com>
In-Reply-To: <230112.86y1q812y4.gmgdl@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 15 Jan 2023 17:04:32 -0500
Message-ID: <CAPig+cSF7Fp3oM4TRU1QbiSzTeKNd1qGtqU7goPc1r-p4g8mkg@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] notes.c: introduce "--separator" option
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Teng Long <dyroneteng@gmail.com>, git@vger.kernel.org,
        tenglong.tl@alibaba-inc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 12, 2023 at 5:07 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> On Thu, Jan 12 2023, Teng Long wrote:
> > When appending to a given notes object and the appended note is not
> > empty too, we will insert a blank line at first which separates the
> > existing note and the appended one, which as the separator.
> > [...]
> > Signed-off-by: Teng Long <dyroneteng@gmail.com>
> > ---
> > diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
> > @@ -159,6 +163,16 @@ OPTIONS
> > +--separator <text>::
> > +     Specify the <text> to be inserted between existing note and appended
> > +     message, the <text> acts as a separator.
>
> Maybe let's use '<string>' or '<separator>' here instead? e.g.:
>         Specifies the <string> ...
> Maybe "<text>" just looks odd to me.
>
> More generally, let's say something like:
>         When invoking "git notes append", specify the...
> I.e. this is only for "append", but nothing here says so.

Agreed on these points.

> > +     If <text> is empty (`--separator=''`), will append the message to
> > +     existing note directly without insert any separator.
> > +     If <text> is nonempty, will use as-is. One thing to notice is if
> > +     the <text> lacks newline charactor, will add the newline automatically.
> > +     If not specify this option, a blank line will be inserted as the
> > +     separator.
>
> We're spending a lot of text here on a pretty simple concept if I
> understand it correctly, I.e. just (pseudocode):
>
>         int sep_extra_nl = 0;
>         const char *sep = opt_sep ? opt_sep : "\n";
>         if (!strstr(sep, '\n'))
>                 sep_extra_nl = 1;
>         [...]
>
> Except that was written after I read your explanation, but looking at
> the code it's incorrect, it's whether the "*last*" character contains a
> newline or not.
>
> So all in all, I think we should just say:
>
>         --separator <separator>:
>                 The '<separator>' inserted between the note and message
>                 by 'append', "\n" by default. A custom separator can be
>                 provided, if it doesn't end in a "\n" one will be added
>                 implicitly .

Unfortunately, this misses the point. The original reason Teng Long
started on this patch series was to be able to _suppress_ the blank
line added unconditionally between notes. In the original submission,
this was done via a --no-blankline option, but that met with
resistance from some reviewers as being potentially confusing and too
specialized. (The commit message of this patch should probably do a
better job of explaining that one purpose of this change is to support
the case of no-separator.)

A generalized --separator= option was suggested[1] as a possibly more
palatable alternative, with which an empty string (meaning "no
separator") would cover the case for which the original --no-blankline
was meant to handle. So, at the very least, the documentation needs to
call out the empty string as being a special case for which automatic
appending of "\n" does not occur.

> > diff --git a/builtin/notes.c b/builtin/notes.c
> > +static void insert_separator(struct strbuf *message)
> > +{
> > +     const char *insert;
> > +
> > +     if (!separator)
> > +             separator = "\n";
> > +     if (*separator == '\0')
>
> Style: Don't compare to 0, NULL, '\0' etc. Just use !*separator.

My fault[2]. Your suggestion is indeed more appropriate in this codebase.

> > +             /* separator is empty; use as-is (no blank line) */
> > +             return;
> > +     else if (separator[strlen(separator) - 1] == '\n')
> > +             /* user supplied newline; use as-is */
> > +             insert = separator;
> > +     else
> > +             /* separator lacks newline; add it ourselves */
> > +             insert = xstrfmt("%s%s", separator,"\n");
>
> We're leaking memor here, and making it hard to fix that by conflating a
> const "insert" with this allocated version.
>
> I haven't read the whole context, but this seems really complex per the
> doc feedback above. Why can't we just keep track of if we're using the
> default value or not? I.e. just have the "--separator" option default to
> NULL, if it's not set y ou don't need to do this "\n" check, and just
> use the default, otherwise append etc.

That wouldn't work for the reason given above. The idea outlined in
[2] is that an empty separator is treated specially as meaning
"nothing-between-notes, not even a blank line".

> > +     strbuf_insertstr(message, 0, insert);
>
> Maybe you were trying to get around using a more complex strbuf_splice()
> here, but let's just avoid teh xstrfmt() and splice() that "\n" in, if
> needed?

The code example I gave in [2] was meant to illustrate the suggested
behavior as clearly as possible, not necessarily to be copied
verbatim. Being able to do this without leaking memory should
certainly be possible.

> Do we mean to strbuf_stripspace() here over the whole buffer, or just
> what we're appending?

That's a very good question. The note being appended might indeed have
leading whitespace gunk which ought to be removed before the append
operation. (Plus, it's a reasonable assumption that the existing note
text has already been "stripspaced".)

[1]: https://lore.kernel.org/git/CAPig+cRcezSp4Rqt1Y9bD-FT6+7b0g9qHfbGRx65AOnw2FQXKg@mail.gmail.com/
[2]: https://lore.kernel.org/git/CAPig+cTFBVAL2gd3LqQEzS--cXqJXR+1OVerii-D6JqFvJwXqQ@mail.gmail.com/
