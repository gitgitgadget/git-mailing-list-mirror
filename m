Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8138A1F453
	for <e@80x24.org>; Wed, 20 Feb 2019 18:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbfBTSgK convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 20 Feb 2019 13:36:10 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35276 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbfBTSgK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Feb 2019 13:36:10 -0500
Received: by mail-qt1-f195.google.com with SMTP id p48so28410654qtk.2
        for <git@vger.kernel.org>; Wed, 20 Feb 2019 10:36:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=koeB0aJGzfl+Y0Z4Ab8+Bgqz/jNzsHYuTpvxBFrqHXw=;
        b=nLpGASKAGTl648c5hbJ0L2jidN0oAiWuDZFsYVPLmpz9kboPqzUn/5dI9xwKvnpCMP
         jHQL/1/jcRkV7ow//owfGf26sjZiNpbuX6K6q/pu7TWzWaxog0CQFIjmZksVx6wtL7+d
         6EP9AvDj8lJURKMSbLWAM852L3g0+5CN2TvpBaTemKAA3AY3qn6y1EJD2D6lI+opBASC
         r78iOecvohe5Jtv7g4WgwDHzI9AAkM+mRR39iduzz1//N2ejP5jweBlQBMINTmdbnlVi
         kyIJj3Rudd03mBihjaUtqxr66IgyE2u7Ow1/QmzsZAGvhUl7BxYXIRMNnyyjcw6IsGmU
         W0mw==
X-Gm-Message-State: AHQUAuZ3Twkl4BxdUTNq5uQo3klZJYdfrCn5B5nsH/30tPo8GCIdmGwG
        qSXxXaBWPuoGnlwH5NskR5K/cqKzeDRKhBUhj2cR4NyL
X-Google-Smtp-Source: AHgI3IYXQVtTrvuNuAkuImkwT1S2gmQA4nkFFF3dCc9NQecB3HCxXfg6NDgB8+xnxKQYrfI2kgKWaO93DVGlujuBoPo=
X-Received: by 2002:aed:3fd9:: with SMTP id w25mr28062686qth.352.1550687768786;
 Wed, 20 Feb 2019 10:36:08 -0800 (PST)
MIME-Version: 1.0
References: <cover.1550508544.git.msuchanek@suse.de> <37df7fd81c3dee990bd7723f18c94713a0d842b6.1550679076.git.msuchanek@suse.de>
 <CAPig+cQZNOWvaa5H2PKOs149KvRtEYRzrdLvzvFRDo4Qxaecaw@mail.gmail.com> <20190220181605.60bbc28d@kitsune.suse.cz>
In-Reply-To: <20190220181605.60bbc28d@kitsune.suse.cz>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 20 Feb 2019 13:35:57 -0500
Message-ID: <CAPig+cS4vZpyj4Cx=Q89v3xTrCG4WbtX8EhTfOT2RKytjV-HrA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] setup: don't fail if commondir reference is deleted.
To:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc:     Git List <git@vger.kernel.org>,
        Marketa Calabkova <mcalabkova@suse.cz>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 20, 2019 at 12:16 PM Michal Suchánek <msuchanek@suse.de> wrote:
> On Wed, 20 Feb 2019 11:55:46 -0500
> Eric Sunshine <sunshine@sunshineco.com> wrote:
> > On Wed, Feb 20, 2019 at 11:17 AM Michal Suchanek <msuchanek@suse.de> wrote:
> > > Apparently it can happen that stat() claims there is a commondir file but when
> > > trying to open the file it is missing.
> >
> > Under what circumstances?
>
> I would like to know that as well. The only command tested was worktree
> add which should not remove the file. Nonetheless running many woktree
> add commands in parallel can cause the file to go away for some of
> them.

You actually encountered this particular error message, correct? Was
that before or after you fixed the race in builtin/worktree.c itself
via patch 1/2? Did the reported 'errno' indicate that the file did not
exist or was it some other error?

> For many commands git calls itself recursively so there is
> probably much more going on than the single function that creates the
> worktree.

"git worktree add" is careful to invoke other Git commands only after
"commondir" exists, so it's not clear how this circumstance arises if
the file is indeed missing by the time the other Git command is run.

> > > Another even rarer issue is that the file might be zero size because another
> > > process initializing a worktree opened the file but has not written is content
> > > yet.
> >
> > Based upon the explanation thus far, I'm having trouble understanding
> > under what circumstances these race conditions can arise. Are you
> > trying to invoke Git commands in a particular worktree even as the
> > worktree itself is being created?
>
> It's explained in the following paragraph. If you have multiple
> worktrees some *other* worktreee may be uninitialized.

I understand that, but setup.c:get_common_dir_noenv() is concerned
only with _this_ worktree -- the one in which the Git command is being
run -- so it's not clear if or how some other partially-initialized
worktree could have any impact. (And, I'm having trouble fathoming how
it could, which is why I'm asking these questions).

Is it possible that when you saw that error message, it actually arose
from some code other than setup.c:get_common_dir_noenv()?

> > > -       if (file_exists(path.buf)) {
> > > -               if (strbuf_read_file(&data, path.buf, 0) <= 0)
> > > +       ret = strbuf_read_file(&data, path.buf, 0);
> > > +       if (ret <= 0) {
> > > +               /*
> > > +                * if file is missing or zero size (just being written)
> > > +                * assume default, bail otherwise
> > > +                */
> > > +               if (ret && errno != ENOENT && errno != ENOTDIR)
> > >                         die_errno(_("failed to read %s"), path.buf);
> >
> > It's not clear from the explanation given in the commit message if the
> > new behavior is indeed sensible. The original intent of the code, as I
> > understand it, is to validate "commondir", to ensure that it is not
> > somehow corrupt (such as the user editing it and making it empty).
>
> How is it validated in the code below when it is non-zero size?

Checking whether the file has content _is_ a form of validation, even
if not extensive validation.

> There is *no* validation whatsoever. Yet zero size is somehow totally
> unacceptable and requires that git working in *any* worktree aborts if
> commondir file in *any* worktree is zero size.

As noted above, it's not clear from the commit message how this case
can arise given that setup.c:get_common_dir_noenv() is presumably
concerned with and only consults _this_ worktree, so I'm having
trouble understanding how the state of other worktrees could impact
it.

> > Following this change, that particular validation no longer takes
> > place. But, more importantly, what does it mean to fall back to
> > "default" for this particular worktree? I'm having trouble
> > understanding how the new behavior can be correct or desirable. (Am I
> > missing something obvious?)
>
> If the file can be missing altogether and it is not an error how it is
> incorrect or undesirable to ignore zero size file?

Because the _presence_ of that file indicates a linked worktree,
whereas it's absence indicates the main worktree. If the file is
present but empty, then that is an abnormal condition, i.e. some form
of corruption.

The difference is significant, and that's why I'm asking if the new
behavior is correct or desirable. If you start interpreting this
abnormal condition as a non-error, then get_common_dir_noenv() will be
reporting that this is the main worktree when in fact it is (a somehow
corrupted) linked worktree. Such false reporting could trigger
undesirable and outright wrong behavior in callers.
