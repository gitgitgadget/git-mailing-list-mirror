Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0BFC1F597
	for <e@80x24.org>; Tue, 17 Jul 2018 10:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730736AbeGQLV0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 07:21:26 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:44474 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730246AbeGQLV0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 07:21:26 -0400
Received: by mail-yw0-f195.google.com with SMTP id k18-v6so205926ywm.11
        for <git@vger.kernel.org>; Tue, 17 Jul 2018 03:49:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tMgS30A+WuqvzDKvgm+0Wxacb4h0/KR8KpqjXx5YpLA=;
        b=LwXSvj06m0DAhexDtZsj7777CCMN+bO3+QlIcuQb9+AfD7q5KqKM5TUpphIktUz+D1
         AT9fnccHX3Ph2vBorBBLKUUu5kJKAGlfaGBBaMwYgr0xFlPLQ+19pD2JnaXM81a9fQR8
         lA9ZppcvcE8eQBzIlzsTg46cqhsYoZp9zdD3lNs6fQzAUmiFwczqiQfbaXPqR+dlCCQd
         ybzwiLJgBJEGUHh2yCtlVH+GgccHvoxrQ3I6QnylkjG26NV+N0Td2uw1OAbakPjcAGBP
         LYNbLUWZGvUNOh2hyBk0RdqylLhKKT+Zq2wGB2spzu3HyXwvD5o3jN/Te01C59UZmpqM
         4Www==
X-Gm-Message-State: AOUpUlHf7tgtaw/QjeHkmMCPQFZnpGIsEB4y0tlrgWQJiSE+KZAfwlWC
        kV9syGnCqaF6vpY4rZVCGhQPPLG3+lx9kehOA60=
X-Google-Smtp-Source: AAOMgpdejEY2THeVqJJ7igmGTQ0d4hF4Gf3gdna/ZMZHwd4XN5Ksc62AmeNGoBx0fFeN/GHrqhK4PqwdSW/3L0yFoYQ=
X-Received: by 2002:a81:110e:: with SMTP id 14-v6mr469899ywr.16.1531824564540;
 Tue, 17 Jul 2018 03:49:24 -0700 (PDT)
MIME-Version: 1.0
References: <20180530080325.37520-1-sunshine@sunshineco.com>
 <20180530080325.37520-3-sunshine@sunshineco.com> <nycvar.QRO.7.76.6.1807171219480.71@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1807171219480.71@tvgsbejvaqbjf.bet>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 17 Jul 2018 06:49:13 -0400
Message-ID: <CAPig+cTKGd8N78XvW-rmBEZC7ykcJsE+na1V_vCVXTUhGrFe4Q@mail.gmail.com>
Subject: Re: [RFC PATCH 2/5] format-patch: add --range-diff option to embed
 diff in cover letter
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the review comments. In the new version of the series
(almost complete), almost the entire implementation has changed,
including most of the stuff on which you commented. Anyhow, see my
responses to your comments below...

On Tue, Jul 17, 2018 at 6:31 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Wed, 30 May 2018, Eric Sunshine wrote:
> > +static int get_range_diff(struct strbuf *sb,
>
> If you rename `sb` to `out`, it makes it more obvious to the casual reader
> that this strbuf will receive the output.

This is gone in the re-roll.

> > +     cp.git_cmd = 1;
> > +     argv_array_pushl(&cp.args, "branch-diff", "--no-color", NULL);
>
> Obviously, this needs to be "range-diff" now.

The re-roll takes advantage of the libified range-diff rather than
invoking it as a command.

> > +     argv_array_pushv(&cp.args, ranges->argv);
>
> As there must be exactly two ranges, it would make more sense to pass them
> explicitly. And then you can use one single call to `argv_array_pushl()`
> instead.

Gone in the re-roll.

> > +     struct strbuf diff = STRBUF_INIT;
>
> I guess you want to call it `diff` instead of `range_diff` because a
> future change will reuse this for the interdiff instead? And then also to
> avoid a naming conflict with the parameter.
>
> Dunno. I would still call it `range_diff` until the day comes (if ever)
> when `--interdiff` is implemented. And I would call the `range_diff`
> parameter `range_diff_opt` instead, or some such.

Sharing the variable between interdiff and range-diff was the idea
initially, however, I later decided that the --range-diff and
--interdiff options didn't need to be mutually-exclusive, so, in the
re-roll, all variables now have distinct names (no commonality between
them).

> > +     if (range_diff) {
> > +             struct argv_array ranges = ARGV_ARRAY_INIT;
> > +             infer_diff_ranges(&ranges, range_diff, head);
> > +             if (get_range_diff(&diff, &ranges))
> > +                     die(_("failed to generate range-diff"));
>
> BTW I like to have an extra space in front of all the range-diff lines, to
> make it easier to discern them from the rest.

I'm not sure what you mean. Perhaps I'm misreading your comment.

> >       if (!use_stdout &&
> >           open_next_file(NULL, rev->numbered_files ? NULL : "cover-letter", rev, quiet))
> > -             return;
> > +             goto done;
>
> Hmm. If you think you will add more `goto done`s in the future, I guess
> this is okay. Otherwise, it would probably make sense to go ahead and
> simply `strbuf_release(&diff)` before `return`ing.

In the re-roll, there are several more things which need to be cleaned
up, so the 'goto' makes life easier.

> > @@ -1438,6 +1480,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
> > +     const char *range_diff = NULL;
>
> Maybe `range_diff_opt`? It's not exactly the range diff that is contained
> in this variable.

I could, though I was trying to keep it shorter rather than longer.
This is still the same in the re-roll, but I can rename it if you
insist.

> > +     if (range_diff && !cover_letter)
> > +             die(_("--range-diff requires --cover-letter"));
>
> I guess this will be changed in a future patch, allowing a single patch to
> ship with a range diff, too?

Yes, that's already the case in the re-roll.

> > +format_patch () {
> > +     title=$1 &&
> > +     range=$2 &&
> > +     test_expect_success "format-patch --range-diff ($title)" '
> > +             git format-patch --stdout --cover-letter --range-diff=$range \
> > +                     master..unmodified >actual &&
> > +             grep "= 1: .* s/5/A" actual &&
> > +             grep "= 2: .* s/4/A" actual &&
> > +             grep "= 3: .* s/11/B" actual &&
> > +             grep "= 4: .* s/12/B" actual
>
> I guess this might make sense if `format_patch` was not a function, but it
> is specifically marked as a function... so... shouldn't these `grep`s also
> be using function parameters?

A later patch adds a second test which specifies the same ranges but
in a different way, so the result will be the same, hence the
hard-coded grep'ing. The function avoids repetition across the two
tests. I suppose I could do this a bit differently, though, to avoid
pretending it's a general-purpose function.
