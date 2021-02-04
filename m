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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71163C433E0
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 00:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3618664F58
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 00:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234406AbhBDApi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 19:45:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234553AbhBDApZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 19:45:25 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62955C0613D6
        for <git@vger.kernel.org>; Wed,  3 Feb 2021 16:44:16 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id i8so2167240ejc.7
        for <git@vger.kernel.org>; Wed, 03 Feb 2021 16:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KwlIPSx09ur4ZIbMCgu6yNM89H+2Q2lfHzlcfvKqrY0=;
        b=eoCwTm+TWxvvq0cOr4AFzJbYcY0re46smNVlP524qxLnZK13O3oVlA37h2tAYEXzs+
         cKS7Sp0l9wPa5ZCHzO6UALYk1Cv3Eu+MhKWZPEdjiSGEeHmNEsaNenalN55h3mhyB7M3
         TQ+PMJ9QDft2Ygn86wqG5YwRDkEZ97KVsQF0USdF2uDbRTsomunlZezlBed5j+2P0zzN
         CPtN73MFyKEDrwRAHhLUSKPthWCNGK9SGlvmAS4jn1oFNihRZl9mMaGx3JPIsucKgTOb
         jmSo/NqzvNyzOUwMOxguptaUxGGOdz5DIPBkJqvlkj+bUl7WKvbVdCYNgOjAxs3tefzD
         YC3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KwlIPSx09ur4ZIbMCgu6yNM89H+2Q2lfHzlcfvKqrY0=;
        b=YYfGSYwMHPwmq19UmNgIHFxPp9ELP1m2DExR7KCo1MxxStVZnaDTxDGzHwP966cetb
         YLOZMaxu251ZzBmYe4GGKXJAXwpQ29sIz2+yvoZj5745+XVvIjgUwErl3SoTd59jlC/q
         4UfIlrFNJRMpd6/fXD2YvcEoX0oq0a4UFshyz01JQKN0KY5/ZC+um/aE7qrjtTcRpxg1
         eaqgqgaOLTjSlx8T2Y9anC13pXLbule73LE6Fjjti/2ertVi7U5/Yu1Hk9XONSzxeiHT
         4WLOytFdRJrl74nwwPXhCTDGP55A8Oefc/OuL82UsMuixZSnRE2TedGmzk6VzPJwSFYS
         KuRg==
X-Gm-Message-State: AOAM533qqAH/pBvHFzCCEHMm7d2pw/JKUbrSBjH/awHV8iAZB8RPNt/t
        GSImCYouKXQfJUPJzdBGCmYOhTAeOBkc0AEq5QyxaMaMV0bCWw==
X-Google-Smtp-Source: ABdhPJy233KOqHHO1Y1wbIUNAzHOXgUXzep7QjfUG/p3PbvSTDG+ewufyX4Lq9ej1+3t4EICSAL0G57h1dFYA5JseZ0=
X-Received: by 2002:a17:906:1b0d:: with SMTP id o13mr5875000ejg.232.1612399455103;
 Wed, 03 Feb 2021 16:44:15 -0800 (PST)
MIME-Version: 1.0
References: <pull.954.git.git.1612388043875.gitgitgadget@gmail.com> <xmqqa6skbw9u.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqa6skbw9u.fsf@gitster.c.googlers.com>
From:   Lance Ward <ljward10@gmail.com>
Date:   Wed, 3 Feb 2021 18:44:03 -0600
Message-ID: <CACPHW2WxXKaDjMY3KdxAQAi82V3_crN763bGQa4aWcJttZ+_cQ@mail.gmail.com>
Subject: Re: [PATCH] status: fix verbose status coloring inconsistency
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lance Ward via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 3, 2021 at 4:51 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Lance Ward via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Lance Ward <ljward10@gmail.com>
> >
> > Currently setting color.status=always results in a colored diff when
>
> Our log message begins with the description of the current status,
> so "Currently" is not something you need to say.
>
> What command with what options?  "git status" does not even show
> "diff" at least by default.
>
>     ... goes, experiments, and guesses what the poster means ...

I'm disappointed by your tone...

I'll go ahead and close my pull requests, if someone else wants
to pick them up that's fine with me.

>
> Perhaps you meant something like this:
>
>     status: honor color.status=always when sending diff output to non tty
>
>     "git status --verbose" shows the patch in color by default (in
>     addition to the list of added, modified, and/or deleted paths)
>     when the output goes to a tty.  With color.status configuration
>     set to 'always' and sending the output to a non-tty, the list of
>     paths are colored as expected, but the patch output loses colors.
>
> And then after the description of the current status, you give
> orders to a patch monkey to fix the code "to be like so".
>
>     This is because the code did not pass the settings read from the
>     configuration and the command line to the underlying machinery
>     that generates the patch output.  Fix it to do so.
>
> > going stdout, but an uncolored diff when going to other files or piping
> > to other commands such as less or more.  This patch fixes this and now
> > color.status=always implies color.diff=always regardless of the output
> > location.
> >
> > Signed-off-by: Lance Ward <ljward10@gmail.com>
> > ---
>
> Eric may deserve Helped-by: mention.
>
> >  t/t7527-status-color-pipe.sh | 55 ++++++++++++++++++++++++++++++++++++
>
> Don't we already have test that checks "status" output including its
> coloring already? I'd rather see us adding to existing test script,
> than allocating a new number for a small subset of features being
> tested for a command.  After all, test numbers are limited resource.
>
> > +test_expect_success setup '
> > +     echo 1 >original &&
> > +     git add .
> > +'
> > +
> > +# Normal git status does not pipe colors
>
> What does "pipe colors" mean?  "color its output on a non-tty", you mean?
>
> > +test_expect_success 'git status' '
> > +     git status >raw &&
> > +     test_decode_color <raw >out &&
> > +     grep "original$" out
> > +'
>
> Not "new file: *original$" or something less false-positive prone?
>
> > +# Test color.status=never (expect same as above)
> > +test_expect_success 'git -c color.status=never status' '
> > +     git -c color.status=never status >raw &&
> > +     test_decode_color <raw >out &&
> > +     grep "original$" out
> > +'
> > +
>
> Would it make sense to have tests for color.status=true, I wonder.
> It requires tty to actually "see" the colors output but sending
> the output to tty is the normal use case, so we should care...
>
> > +# Test color.status=always
> > +test_expect_success 'git -c color.status=always status' '
> > +     git -c color.status=always status >raw &&
> > +     test_decode_color <raw >out &&
> > +     grep "original<RESET>$" out
> > +'
>
> OK.  I understand that this passes without the patch below.
>
> > +# Test verbose (default)
> > +test_expect_success 'git status -v' '
> > +     git status -v >raw &&
> > +     test_decode_color <raw >out &&
> > +     grep "+1" out
> > +'
>
> I think you meant to catch the new contents "1" stored in the file
> whose name is "original", but this will hit the hunk header, no?
>
>     @@ -0,0 +1 @@
>     +1
>
> IOW, the grep patterns throughout this patch may be a bit too loose
> and prone to false hits.
>
> > +# Test verbose color.status=never
> > +test_expect_success 'git -c color.status=never status -v' '
> > +     git -c color.status=never status -v >raw &&
> > +     test_decode_color <raw >out &&
> > +     grep "+1" out
> > +'
> > +
> > +# Test verbose color.status=always
> > +test_expect_success 'git -c color.status=always status -v' '
> > +     git -c color.status=always status -v >raw &&
> > +     test_decode_color <raw >out &&
> > +     grep "<CYAN>@@ -0,0 +1 @@<RESET>" out &&
> > +     grep "GREEN>+<RESET><GREEN>1<RESET>" out
> > +'
>
> Is the missing open bra "<" before GREEN intended?
>
> Are we forcing the standard palette?
>
> > +test_done
> > diff --git a/wt-status.c b/wt-status.c
> > index 0c8287a023e..1e9c899a7b2 100644
> > --- a/wt-status.c
> > +++ b/wt-status.c
> > @@ -1064,6 +1064,8 @@ static void wt_longstatus_print_verbose(struct wt_status *s)
> >       if (s->fp != stdout) {
> >               rev.diffopt.use_color = 0;
> >               wt_status_add_cut_line(s->fp);
> > +     } else {
> > +             rev.diffopt.use_color = s->use_color;
> >       }
> >       if (s->verbose > 1 && s->committable) {
> >               /* print_updated() printed a header, so do we */
> >
> > base-commit: e6362826a0409539642a5738db61827e5978e2e4
>
> Thanks.
