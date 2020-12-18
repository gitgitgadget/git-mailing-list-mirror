Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1388EC2D0E4
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 22:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCD5D23B5D
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 22:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726031AbgLRW3M (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 17:29:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbgLRW3L (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 17:29:11 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3DAC0617B0
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 14:28:31 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id x13so3407554oto.8
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 14:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WLkgNPeXUGA/uQ5Io7jedb2TIfseJMUNDb6VpMyQ+BM=;
        b=C9PiUXLIoxmXBLHGr8yx0/D0WKl9A/bGRYynOwTAkRxB2iQeEQLKBjF3pNXN/wEiTt
         0zrjgm01KcE9wf2u81b08isTNIJks8oseCkILZPCTvrOWi3aR59WHVffkTDa2XmJGWLG
         D0Ox/SWpL1Gr5r8oJ++klT4770EaZ4/u/gnlGPy5jzxJyEOaotAZFYxaZ0lDRfTse0sX
         ey5ZBArwo+qxy7UyTdjAjvb9Ex738x2HiT+y1qUIm/56/0jPeNqK/JWBX6Uf4ZV0o+EE
         9eY5nEnUHi1+jnQd38m4Z59BUfV5nOTdYPZqj+AgQmdMh3sudxfi9WoSh6W+KKSaDGd2
         4nlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WLkgNPeXUGA/uQ5Io7jedb2TIfseJMUNDb6VpMyQ+BM=;
        b=sabraXlddd8wPzXGu+tkBP6oj9JpXZniSLPP5qb65EIAV0JER1jc9WlUMALCoumZe9
         cY2JpLaSFws8mwSsQIk+vcCdglE6ob7hPzZw+W+oHsrZ7rgVYp78lOJqfjoCAA/3pHER
         ayGyXOgMfrbo6U/VbUdcvWCreFPL6B+70nRcV1GNzohzFgUAP3N2ApLUzHXeRZsKI003
         SDA4MMuD7dAlZznZXNZKVh9h75OCtauw3EhtUih+ymcqSmed8pp73i1mpnWTJR7G/SSo
         wzM4ydr61jEyhLVBk2MTo4dEXg9v1gELUPAXzUwgfp4qqhcN/uYGRyxV1pg7skZ+rNn1
         MnwQ==
X-Gm-Message-State: AOAM530eu7GriBdyd2mxqTcv8IbnIYzGbRjK5qiijJB0+RGhXcI1qOAF
        puLXGuvODC/JWsH//Cf1vOfZNiNQwwx2H7/RegM=
X-Google-Smtp-Source: ABdhPJyS+z5mmhCWodHt5wuktOi1qbs9ken+smzen4lsSQWxtd4Vn8qfndEvmdF95q2V2fOX5ApjHt7qjBaHlc1HQbU=
X-Received: by 2002:a05:6830:10:: with SMTP id c16mr4363596otp.162.1608330510791;
 Fri, 18 Dec 2020 14:28:30 -0800 (PST)
MIME-Version: 1.0
References: <20201101193330.24775-1-sorganov@gmail.com> <20201216184929.3924-1-sorganov@gmail.com>
 <20201216184929.3924-30-sorganov@gmail.com> <CABPp-BFRPFxm=SuJFwfG+QYCivMKp2VRpnHGwxNL+extK7UdtA@mail.gmail.com>
 <87lfdvaymn.fsf@osv.gnss.ru> <CABPp-BGAHFLZDWaK5q+ZHOShUOZnRqUQd+T-X6mXxkg5cp7QpQ@mail.gmail.com>
 <87o8iq7oj3.fsf@osv.gnss.ru>
In-Reply-To: <87o8iq7oj3.fsf@osv.gnss.ru>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 18 Dec 2020 14:28:19 -0800
Message-ID: <CABPp-BFFKVBtOSLbxbrSg+seG5zVftfuo=H35V5GKo+3iimLng@mail.gmail.com>
Subject: Re: [PATCH v2 29/33] doc/git-log: describe new --diff-merges options
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 18, 2020 at 2:11 PM Sergey Organov <sorganov@gmail.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > On Fri, Dec 18, 2020 at 8:05 AM Sergey Organov <sorganov@gmail.com> wrote:
> >>
> >> Elijah Newren <newren@gmail.com> writes:
> >>
> >> > On Wed, Dec 16, 2020 at 10:50 AM Sergey Organov <sorganov@gmail.com> wrote:
> >> >>
> >> >> Describe all the new --diff-merges options in the git-log.txt and
> >> >> adopt description of originals accordingly.
> >> >
> >> > You also took care to explain interactions of options with -p that
> >> > were previously undocumented, which is a nice bonus.  That wording
> >> > could still be improved a bit, though, as noted below.
> >> >
> >> >> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> >> >> ---
> >> >>  Documentation/git-log.txt | 85 ++++++++++++++++++++++++---------------
> >> >>  1 file changed, 52 insertions(+), 33 deletions(-)
> >> >>
> >> >> diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
> >> >> index 2b8ac5ff882a..27bc619490c6 100644
> >> >> --- a/Documentation/git-log.txt
> >> >> +++ b/Documentation/git-log.txt
> >> >> @@ -120,45 +120,64 @@ DIFF FORMATTING
> >> >>  By default, `git log` does not generate any diff output. The options
> >> >>  below can be used to show the changes made by each commit.
> >> >>
> >> >> -Note that unless one of `-c`, `--cc`, or `-m` is given, merge commits
> >> >> -will never show a diff, even if a diff format like `--patch` is
> >> >> -selected, nor will they match search options like `-S`. The exception is
> >> >> -when `--first-parent` is in use, in which merges are treated like normal
> >> >> -single-parent commits (this can be overridden by providing a
> >> >> -combined-diff option or with `--no-diff-merges`).
> >> >> +Note that unless one of `--diff-merges` variants (including short
> >> >> +`-m`, `-c`, and `--cc` options) is explicitly given, merge commits
> >> >> +will not show a diff, even if a diff format like `--patch` is
> >> >> +selected, nor will they match search options like `-S`. The exception
> >> >> +is when `--first-parent` is in use, in which case `first-parent` is
> >> >> +the default format.
> >> >
> >> > Thanks for fixing this up.  :-)
> >>
> >> Don't mention it :-)
> >>
> >> >
> >> >>
> >> >> --c::
> >> >> -       With this option, diff output for a merge commit
> >> >> -       shows the differences from each of the parents to the merge result
> >> >> -       simultaneously instead of showing pairwise diff between a parent
> >> >> -       and the result one at a time. Furthermore, it lists only files
> >> >> -       which were modified from all parents.
> >> >> -
> >> >> ---cc::
> >> >> -       This flag implies the `-c` option and further compresses the
> >> >> -       patch output by omitting uninteresting hunks whose contents in
> >> >> -       the parents have only two variants and the merge result picks
> >> >> -       one of them without modification.
> >> >> +--diff-merges=(off|none|first-parent|1|separate|m|combined|c|dense-combined|cc)::
> >> >> +--no-diff-merges::
> >> >> +       Specify diff format to be used for merge commits. Default is
> >> >> +       `off` unless `--first-parent` is in use, in which case
> >> >> +       `first-parent` is the default.
> >> >> ++
> >> >> +--diff-merges=(off|none):::
> >> >> +--no-diff-merges:::
> >> >> +       Disable output of diffs for merge commits. Useful to override
> >> >> +       implied value.
> >> >> ++
> >> >> +--diff-merges=first-parent:::
> >> >> +--diff-merges=1:::
> >> >> +       This option makes merge commits show the full diff with
> >> >> +       respect to the first parent only.
> >> >
> >> > Does it imply -p?
> >>
> >> No, none of --diff-merges options do. This one is not any special. Why
> >> the question?
> >
> > The documentation on -m was vague enough that it made me wonder.
> > Fixing it would probably prevent me from having asked this question.
>
> OK, I see, so let's try to fix the cause, please see below.

Sounds good.

> >
> >> >> ++
> >> >> +--diff-merges=separate:::
> >> >> +--diff-merges=m:::
> >> >> +-m:::
> >> >> +       This makes merge commits show the full diff with respect to
> >> >> +       each of the parents. Separate log entry and diff is generated
> >> >> +       for each parent. `-m` is different in that it doesn't produce
> >> >> +       any output without `-p`.
> >> >
> >> > Different from what?  From --first-parent?  From flags that haven't
> >> > been covered yet?  (-c and --cc show up below)
> >>
> >> Well, from --diff-merges=m and --diff-merges=separate, that, as any
> >> other --diff-merge option, do produce output (for merge commits) even
> >> without -p.
> >
> > That wasn't at all clear to me as the intent of the last sentence.
>
> Well, actually, the right answer to your question is: -m is different
> from *everything* ;-)
>
> Maybe the confusion you got is not caused by the documentation, but
> rather by some of your expectations? In particular, I wonder, how comes
> --first-parent appeared in your question, that is entirely unrelated?

When you said "`-m` is different" it was not clear what you were
contrasting to.  The fact that you were contrasting to the other
values in the set of three being described by this paragraph may seem
obvious to you, and I suspect many other readers may catch on to that,
but that really honestly did not occur to me while reading it.  Maybe
I'm weird.  Maybe some subset of users will be like me and we should
tighten up the wording.  Hard to say.

> I mean I'm still unsure how to make this description more clear, maybe
> this will do:
>
> --diff-merges=separate:::
> --diff-merges=m:::
> -m:::
>        This makes merge commits show the full diff with respect to
>        each of the parents. Separate log entry and diff is generated
>        for each parent. `-m` doesn't produce any output without `-p`.

Works for me.  :-)

> >
> >> >> ++
> >> >> +--diff-merges=combined:::
> >> >> +--diff-merges=c:::
> >> >> +-c:::
> >> >> +       With this option, diff output for a merge commit shows the
> >> >> +       differences from each of the parents to the merge result
> >> >> +       simultaneously instead of showing pairwise diff between a
> >> >> +       parent and the result one at a time. Furthermore, it lists
> >> >> +       only files which were modified from all parents. Historically,
> >> >> +       `-c` enables diff output for non-merge commits as well.
> >> >
> >> > "Historically"?  Does that mean it doesn't anymore?
> >>
> >> Eh, I don't think "historically" means that, but I'm not sure, being
> >> non-native English speaker.
> >
> > Sometimes non-native speakers use the language more accurately.  This
> > might be such a case, but that sentence did make me think you might be
> > attempting to document past behavior as a way of helping people adjust
> > to current/new behavior.
> >
> >> > (Maybe, "The short form, `-c`, also enables diff output for non-merge
> >> > commits as well." or something like that?)
> >>
> >> ... and then try to explain why this otherwise illogical behavior is
> >> there? I thought "historically" would cover that.
> >
> > It doesn't seem like illogical behavior to me.   Perhaps the view of
> > -c as a diff-merges option, reinforced by placing -c right next to
> > --diff-merges in the documentation, is what causes you to think so?
>
> -c, described as selecting specific format of representation of merge
> commits, suddenly enabling diff output of non-merge commits, is logical?
> No. Useful? Maybe. Logical? Not to me. Just saying, see below.

:-)

I didn't say the former documentation was correct, or that the
behavior logically flowed from the documentation's claims.  And you do
bring up good points that the past documentation should have been
updated when -c and --cc were made to imply -p.  I only claimed that
-c and --cc provide logical behaviors (I want diffs for everything,
for merges do it this way...all expressed in a nice compact bundle).

> > If so, maybe we should document -c (and --cc) separately after all the
> > --diff-merges options, using something like the following:
> >
> > -c:::
> >     Implies both --patch and --diff-merges=combined, i.e. turn on
> > patches for normal commits and show a combined diff format for merges.
>
> The problem with this is that it'd then be preferable to describe -m
> separately as well, and that's not that simple.
>
> Overall, I'd rather change that in place, like this:
>
> --diff-merges=combined:::
> --diff-merges=c:::
> -c:::
>        With this option, diff output for a merge commit shows the
>        differences from each of the parents to the merge result
>        simultaneously instead of showing pairwise diff between a
>        parent and the result one at a time. Furthermore, it lists
>        only files which were modified from all parents. `-c` implies
>        `--patch`.

Works for me.  --cc needs a similar change, obviously.
