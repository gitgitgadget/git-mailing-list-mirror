Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB775C433E0
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 08:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86C0723447
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 08:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbhANI24 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 03:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbhANI24 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 03:28:56 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0452BC061794
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 00:28:10 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id 15so5120376oix.8
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 00:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vy3ZdRxMaTsNKR3tEZ+0uUZQEo/YbpzdZUeiVmvrqoQ=;
        b=d+vVvrLXecBHVsNZleQoilJXYqdFE+lvot+kOHM2cQiMQBOxecycCkGYyAwIIFf19L
         rozTXxHIBZaCpxIsgYZy0Q9pvjGTmG6GOCaXcncXAOFHhUWcEjCLotDCj7ft//GonV2U
         GvT3ybGIh/KDkYWvDkNsbmODAJckMcMySGjZ5Su68L+sXFgrnna6yjfkrSS20DojHJg1
         69xUBhQh6xHLzhXFsYq7kYHOd2GpPji4UwKYd8kGi7tOvA6RkWF7RadayztQ4xRK38TZ
         KqBhxMIJBB8M5k/7ytM40+qBqpqku2GlEu+Xd+s/aZrv3pcoQbQydxn/fT5BreIH8trD
         mX7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vy3ZdRxMaTsNKR3tEZ+0uUZQEo/YbpzdZUeiVmvrqoQ=;
        b=k86zNALBcCWOr6b+JMlfICz5R/uYXGfOS9N2doQlEwgG+KCKRom3f5I/BKXKWXRQGD
         wN1aYnom/3Sv44SmMa6BZetm1nQ0C6s24H5KZxN3AWANqLnLX/0ZGuTIbd4ZlUD0r1KA
         qvxssdW+Zt5o9vVlj41JfDKz2xJJxp4hvrFqQPAGXJn6gt4M2IRI6ibEbk+BOWIXhhDO
         i6SdfTSKc8RGxaREaXX7sJXAczQFuPCTeL1LlY25Frp9V2/Wb3Ft/Pa6Sxot9PA3Kjsh
         Fjdf7KSS3warlMRnuEYJfvRZ4JjghBXpLjZyw+StYO48lxItZ9IYyUOkLtTlAoU1jgYb
         bumw==
X-Gm-Message-State: AOAM533I+da6VQ1e3WoVYeBj7Tkb9om77WKMcl1Yvv6kUzDYOf3HlW/E
        AQCSLX6lDP6lg2HZu0gPCpbkn31K43HI/A/lqxA=
X-Google-Smtp-Source: ABdhPJyraR08j/M/qnqByxQ2fHn6TnlEVDgKAV2O8V/uonL3JC5Hsk/yWFWyg1rz80zvnDpVf5ckY49faHtkE9u4RTQ=
X-Received: by 2002:aca:5253:: with SMTP id g80mr1929681oib.98.1610612888175;
 Thu, 14 Jan 2021 00:28:08 -0800 (PST)
MIME-Version: 1.0
References: <20210108092345.2178-1-charvi077@gmail.com> <20210108092345.2178-4-charvi077@gmail.com>
 <X/9DdGnYo7RQz5CE@nand.local>
In-Reply-To: <X/9DdGnYo7RQz5CE@nand.local>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Thu, 14 Jan 2021 13:57:57 +0530
Message-ID: <CAPSFM5fuT0QAK9wJ_HuH3t=qThPx7Opwy0GrYieVntJ8A4ARMA@mail.gmail.com>
Subject: Re: [RFC PATCH 3/9] rebase -i: comment out squash!/fixup! subjects
 from squash message
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes.Schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 14 Jan 2021 at 00:31, Taylor Blau <me@ttaylorr.com> wrote:
>
> On Fri, Jan 08, 2021 at 02:53:41PM +0530, Charvi Mendiratta wrote:
> > From: Phillip Wood <phillip.wood@dunelm.org.uk>
> >
> > When squashing commit messages the squash!/fixup! subjects are not of
> > interest so comment them out to stop them becoming part of the final
> > message.
> >
> > This change breaks a bunch of --autosquash tests which rely on the
> > "squash! <subject>" line appearing in the final commit message. This is
> > addressed by adding a second line to the commit message of the "squash!
> > ..." commits and testing for that.
> >
> > Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> > Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
> > ---
> >  sequencer.c                  | 25 ++++++++++++++++++++++++-
> >  t/t3415-rebase-autosquash.sh | 27 +++++++++++++--------------
> >  t/t3900-i18n-commit.sh       |  4 ----
> >  3 files changed, 37 insertions(+), 19 deletions(-)
> >
> > diff --git a/sequencer.c b/sequencer.c
> > index 5062976d10..b050a9a212 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -1718,15 +1718,38 @@ static int is_pick_or_similar(enum todo_command command)
> >       }
> >  }
> >
> > +static size_t subject_length(const char *body)
> > +{
> > +     size_t i, len = 0;
> > +     char c;
> > +     int blank_line = 1;
> > +     for (i = 0, c = body[i]; c; c = body[++i]) {
> > +             if (c == '\n') {
> > +                     if (blank_line)
> > +                             return len;
> > +                     len = i + 1;
> > +                     blank_line = 1;
> > +             } else if (!isspace(c)) {
> > +                     blank_line = 0;
> > +             }
> > +     }
> > +     return blank_line ? len : i;
> > +}
> > +
>
> OK, so this gets the length of the subject in "body", which is defined
> as the run of characters before a newline and then a space character. So
> "foo bar\n\nbaz" would return 7, but "foo bar\nbaz" would return 11.
>
> Makes sense. (Apologies for stating the obvious here, I just had to read
> this function to myself a couple of times to make sure that I understood
> what it was doing.)
>

Earlier while testing patch, I also went through in the same way and
now got confirmed as you described here.

> >  static void append_squash_message(struct strbuf *buf, const char *body,
> >                                 struct replay_opts *opts)
> >  {
> > +     size_t commented_len = 0;
> > +
> >       unlink(rebase_path_fixup_msg());
> > +     if (starts_with(body, "squash!") || starts_with(body, "fixup!"))
> > +             commented_len = subject_length(body);
> >       strbuf_addf(buf, "\n%c ", comment_line_char);
> >       strbuf_addf(buf, _("This is the commit message #%d:"),
> >                   ++opts->current_fixup_count + 1);
> >       strbuf_addstr(buf, "\n\n");
> > -     strbuf_addstr(buf, body);
> > +     strbuf_add_commented_lines(buf, body, commented_len);
> > +     strbuf_addstr(buf, body + commented_len);
>
> Very nice; the subject gets commented when it starts with "squash!" or
> "fixup!", but the body remains uncommented. Makes sense to me.
>

I agree and Thanks to Phillip, for the patch.

> > @@ -224,7 +223,7 @@ test_expect_success 'auto squash that matches longer sha1' '
> >       git cat-file blob HEAD^:file1 >actual &&
> >       test_cmp expect actual &&
> >       git cat-file commit HEAD^ >commit &&
> > -     grep squash commit >actual &&
> > +     grep "extra para" commit >actual &&
> >       test_line_count = 1 actual
> >  '
>
> Worth checking that "squash" doesn't appear in an uncommented part of
> actual? Or better yet, checking that "# squash ..." _does_ appear.
>
> I.e., that we would leave this as:
>
>     -   grep squash commit >actual &&
>     +   grep "^# squash" commit >actual &&
>     +   grep "extra para" commit >actual &&
>
> > @@ -342,8 +341,8 @@ test_expect_success C_LOCALE_OUTPUT 'autosquash with custom inst format' '
> >       git cat-file blob HEAD^:file1 >actual &&
> >       test_cmp expect actual &&
> >       git cat-file commit HEAD^ >commit &&
> > -     grep squash commit >actual &&
> > -     test_line_count = 2 actual
> > +     grep first commit >actual &&
> > +     test_line_count = 3 actual
> >  '
>
> Ditto.

Okay, I will add it .

Thanks and Regards,
Charvi

>
> Thanks,
> Taylor
