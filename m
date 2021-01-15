Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771E3C433DB
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 08:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39EC922C7D
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 08:36:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730431AbhAOIgk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jan 2021 03:36:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728497AbhAOIgk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jan 2021 03:36:40 -0500
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7469C061757
        for <git@vger.kernel.org>; Fri, 15 Jan 2021 00:35:59 -0800 (PST)
Received: by mail-oo1-xc36.google.com with SMTP id s19so2023737oos.2
        for <git@vger.kernel.org>; Fri, 15 Jan 2021 00:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2OkCSqNC83wWeHA6SNZxM78qgFRQzTPmcBNgEtpgOnc=;
        b=vZVcaFVDx8FMX5hfAT5invokZMO5SfN95XSvSCJe47OSQudpdRzT3yQSw62wc/owiR
         lyuNLgF+h6m7C0m/NFT5bVgp8yd1KCkn+jRXTAhIhWEyFnYDuYKQ8vrpqRCmBP17vzcm
         I9OR6nbwqyHeYydNC3foSp2m12Hnf1LDHWMN+qxXMLJ0XbsQdPN9gS91VEHbwmNSeDwk
         7qhhyEXR1ZMMsb/KWQqUt3WQtcq6E/eqguxOdkiMr2uppiQnMtjoSCcL/oCsFaaM6D3H
         iSL4w4xMZDGZDVRYdUO4DYrIcZ63mPMYgkrJLzOLLN3gUotIatI26SajKlJTcXlSAwDg
         Nemw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2OkCSqNC83wWeHA6SNZxM78qgFRQzTPmcBNgEtpgOnc=;
        b=dzkgWD5FDINzqKt5dGqRZSIBqz47nGSAewCe5whuW5aMQWp4wvUon3uv7zGN+Wa0sw
         /98iSKz2GF4FsOqOP6N0w0U/4hz0hfLGEFVZcHGjW6oITOLJ2hRhczMWjc+4M4oBDXu+
         GAEaj5hWgwoJuzrl3zhca0fdwBu/xDZ3qycEs01nGAaKt6BRFu8/9CdlTNNr1XddAP65
         MQbRABAUZ6q3TBS+U8UPq9BGFA7jMvottByzJDdq4xGSjsOIGpCQdRe/h48coPY+HS/e
         Cg/LBOonPr0ZVmiY5YMmckCZdaO+MMQOTp65Xjr2EkDJmM7Vc3UdjqnFnT0Nas3pB23r
         WR6w==
X-Gm-Message-State: AOAM5300UtZYYaUNareouQ1t0w5yXwQzQhQYRg7+8jUr+xtEiI3GSBw6
        RUL4NeuKjn5rIILtbSix26RKtDjmbxxqsFPO5Q4=
X-Google-Smtp-Source: ABdhPJyEaPCpsu2VzT/dYeNPXtQ90MHa4HBHGEpM2AGtKWiCd8QcGhAwdy3ulR0AcJxH/acjqinquPnTHz82J7h+Twc=
X-Received: by 2002:a4a:6c45:: with SMTP id u5mr7461545oof.61.1610699759092;
 Fri, 15 Jan 2021 00:35:59 -0800 (PST)
MIME-Version: 1.0
References: <20210108092345.2178-1-charvi077@gmail.com> <20210108092345.2178-4-charvi077@gmail.com>
 <X/9DdGnYo7RQz5CE@nand.local> <CAPSFM5fuT0QAK9wJ_HuH3t=qThPx7Opwy0GrYieVntJ8A4ARMA@mail.gmail.com>
 <abc9334d-a9ec-a041-aa04-16cb4f01372a@gmail.com>
In-Reply-To: <abc9334d-a9ec-a041-aa04-16cb4f01372a@gmail.com>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Fri, 15 Jan 2021 14:05:48 +0530
Message-ID: <CAPSFM5co06fdo=vqTMeHLtYyP37qucGVRtOiFsZBwiR1UOsm8Q@mail.gmail.com>
Subject: Re: [RFC PATCH 3/9] rebase -i: comment out squash!/fixup! subjects
 from squash message
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Thu, 14 Jan 2021 at 15:59, Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> Hi Charvi and Taylor
>
> On 14/01/2021 08:27, Charvi Mendiratta wrote:
> > On Thu, 14 Jan 2021 at 00:31, Taylor Blau <me@ttaylorr.com> wrote:
> >>
> >> On Fri, Jan 08, 2021 at 02:53:41PM +0530, Charvi Mendiratta wrote:
> >>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> >>>
> >>> When squashing commit messages the squash!/fixup! subjects are not of
> >>> interest so comment them out to stop them becoming part of the final
> >>> message.
> >>>
> >>> This change breaks a bunch of --autosquash tests which rely on the
> >>> "squash! <subject>" line appearing in the final commit message. This is
> >>> addressed by adding a second line to the commit message of the "squash!
> >>> ..." commits and testing for that.
> >>>
> >>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> >>> Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
> >>> ---
> >>>   sequencer.c                  | 25 ++++++++++++++++++++++++-
> >>>   t/t3415-rebase-autosquash.sh | 27 +++++++++++++--------------
> >>>   t/t3900-i18n-commit.sh       |  4 ----
> >>>   3 files changed, 37 insertions(+), 19 deletions(-)
> >>>
> >>> diff --git a/sequencer.c b/sequencer.c
> >>> index 5062976d10..b050a9a212 100644
> >>> --- a/sequencer.c
> >>> +++ b/sequencer.c
> >>> @@ -1718,15 +1718,38 @@ static int is_pick_or_similar(enum todo_command command)
> >>>        }
> >>>   }
> >>>
> >>> +static size_t subject_length(const char *body)
> >>> +{
> >>> +     size_t i, len = 0;
> >>> +     char c;
> >>> +     int blank_line = 1;
> >>> +     for (i = 0, c = body[i]; c; c = body[++i]) {
> >>> +             if (c == '\n') {
> >>> +                     if (blank_line)
> >>> +                             return len;
> >>> +                     len = i + 1;
> >>> +                     blank_line = 1;
> >>> +             } else if (!isspace(c)) {
> >>> +                     blank_line = 0;
> >>> +             }
> >>> +     }
> >>> +     return blank_line ? len : i;
> >>> +}
> >>> +
> >>
> >> OK, so this gets the length of the subject in "body", which is defined
> >> as the run of characters before a newline and then a space character.
>
> The length of the subject is the run of characters before a line
> containing only whitespace, "hello\n there" would return 13 "hello\n
> \nthere" would return 5. Looking again at my code there must be a way of
> writing that function that is easier to follow.
>

Okay. I will look into it once, thanks for explaining.

> >> So
> >> "foo bar\n\nbaz" would return 7, but "foo bar\nbaz" would return 11.
> >>
> >> Makes sense. (Apologies for stating the obvious here, I just had to read
> >> this function to myself a couple of times to make sure that I understood
> >> what it was doing.)
> >>
> >
> > Earlier while testing patch, I also went through in the same way and
> > now got confirmed as you described here.
> >
> >>>   static void append_squash_message(struct strbuf *buf, const char *body,
> >>>                                  struct replay_opts *opts)
> >>>   {
> >>> +     size_t commented_len = 0;
> >>> +
> >>>        unlink(rebase_path_fixup_msg());
> >>> +     if (starts_with(body, "squash!") || starts_with(body, "fixup!"))
> >>> +             commented_len = subject_length(body);
> >>>        strbuf_addf(buf, "\n%c ", comment_line_char);
> >>>        strbuf_addf(buf, _("This is the commit message #%d:"),
> >>>                    ++opts->current_fixup_count + 1);
> >>>        strbuf_addstr(buf, "\n\n");
> >>> -     strbuf_addstr(buf, body);
> >>> +     strbuf_add_commented_lines(buf, body, commented_len);
> >>> +     strbuf_addstr(buf, body + commented_len);
> >>
> >> Very nice; the subject gets commented when it starts with "squash!" or
> >> "fixup!", but the body remains uncommented. Makes sense to me.
> >>
> >
> > I agree and Thanks to Phillip, for the patch.
> >
> >>> @@ -224,7 +223,7 @@ test_expect_success 'auto squash that matches longer sha1' '
> >>>        git cat-file blob HEAD^:file1 >actual &&
> >>>        test_cmp expect actual &&
> >>>        git cat-file commit HEAD^ >commit &&
> >>> -     grep squash commit >actual &&
> >>> +     grep "extra para" commit >actual &&
> >>>        test_line_count = 1 actual
> >>>   '
> >>
> >> Worth checking that "squash" doesn't appear in an uncommented part of
> >> actual? Or better yet, checking that "# squash ..." _does_ appear.
> >>
> >> I.e., that we would leave this as:
> >>
> >>      -   grep squash commit >actual &&
> >>      +   grep "^# squash" commit >actual &&
> >>      +   grep "extra para" commit >actual &&
>
> This test is checking the message that gets committed, not the contents
> of the file passed to the editor. I like the idea of checking that the
> squash! line is indeed commented out, but we'd need to test it with
>
> grep -v squash
>
> Looking at the changes to the tests in this commit it highlights the
> fact that I don't think we ever check exactly what the user sees in
> their editor. We do add such a test for the new `fixup -C` functionality
> in a later patch but perhaps we should improve the test coverage of the
> squash message presented to the user before then.
>

Okay and for checking "squash" I will add it in the above way.

Thanks and Regards,
Charvi


> Best Wishes
>
> Phillip
>
> >>> @@ -342,8 +341,8 @@ test_expect_success C_LOCALE_OUTPUT 'autosquash with custom inst format' '
> >>>        git cat-file blob HEAD^:file1 >actual &&
> >>>        test_cmp expect actual &&
> >>>        git cat-file commit HEAD^ >commit &&
> >>> -     grep squash commit >actual &&
> >>> -     test_line_count = 2 actual
> >>> +     grep first commit >actual &&
> >>> +     test_line_count = 3 actual
> >>>   '
> >>
> >> Ditto.
> >
> > Okay, I will add it .
> >
> > Thanks and Regards,
> > Charvi
> >
> >>
> >> Thanks,
> >> Taylor
>
