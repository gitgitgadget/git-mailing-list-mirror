Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F33DC433E1
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 22:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D821206DA
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 22:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ncZu4JPo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729776AbgHQWhN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 18:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729191AbgHQWhM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 18:37:12 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D16C061389
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 15:37:12 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id a127so2365592vsd.1
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 15:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XhMfh7gTtlisdYRIW+U0t+Ybz5uz5Ha4eo5eAqpIVqE=;
        b=ncZu4JPo5X9jeQ9XppUHM80k7jPxUBFroDjlW/Th5UNL5buUPLDyhl0VDzeDcEl6w3
         X4DNzWSytKw2mZnlV0xPckrnypDlPPqFXmLrtvTxGSndJgtwWKvM8ja2idsyq4nI1ab2
         DtIiHo5QRW02wM3iK/t/T/2NbxuVeXIhIT6DehK89inqj7xYQ6jnYBXdbWXjaiyZ5LmY
         zh4Eq37T6kqlnj8TbhVDU5kNB3MBfn2w1/K3q2YOXEkHgf+Tg9vRxy3yZ+vZI0RLqlKp
         DdNUpi92XyTlLE+qiCkjjXEL54A5VH74eHKyrfJVzSVwjQA3g2I7M9NAVzBBlOR0dIh5
         Z8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XhMfh7gTtlisdYRIW+U0t+Ybz5uz5Ha4eo5eAqpIVqE=;
        b=VTsSKmbMHVXM1sXi/RbfklA26CeSjbmMR9TqtuWBLegfXZNEmQ8rjyofQfsOI80cC2
         MR5fyMKlzbIpSxN+Xv1MkGWufsrVpU8rCMWjVaLnYXZZYLVE1Iv1p9Mc0xP/Wmpu+Ufc
         pZQojC0joWUjMH7YZ1US7XIJoX+qyPouSETHRiamEvquRDAb1puVU1CwCjcGEE0oGz2K
         1VfJEA01IPtt9IvP7W026HM9Fbx7PBtAtXQh+2CS70p0jDa0QWUHtZh3kpJgo8AMaFKj
         T60a9gj/qjFjQlL4zYg4YCC8aN8ynTfHHyO3AwnxrVxMNhwDEv0Vhe9l0G5IsqlrZR1K
         Yvug==
X-Gm-Message-State: AOAM531vLpxVMUfPYsYvQP5q9fYGDBCLOOMGbQWuNiTRjHimN0tXhiLt
        fENBJ5YMZ1C/HnWIvQ2Psf6Hwhe3OyRcD6Ny6Pc5sSd7
X-Google-Smtp-Source: ABdhPJzpMrIbt4X357lC/PbQiFEDiLWibenXWa3342ibE11Sxrya6SgCiQtD4AQwes7z8PSriLVAUveB0+xMPD70dzE=
X-Received: by 2002:a05:6102:538:: with SMTP id m24mr9555415vsa.40.1597703831356;
 Mon, 17 Aug 2020 15:37:11 -0700 (PDT)
MIME-Version: 1.0
References: <pull.689.git.1596324796918.gitgitgadget@gmail.com>
 <pull.689.v2.git.1597445151824.gitgitgadget@gmail.com> <xmqqpn7pymsb.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqpn7pymsb.fsf@gitster.c.googlers.com>
From:   Matt Rogers <mattr94@gmail.com>
Date:   Mon, 17 Aug 2020 18:37:02 -0400
Message-ID: <CAOjrSZt7BZy=wnKhFfj+07-2GT+hOf+70HEJL6Hr04NaabK=eg@mail.gmail.com>
Subject: Re: [PATCH v2] diff: teach --stat to ignore uninteresting modifications
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Matthew Rogers via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 17, 2020 at 5:39 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Matthew Rogers <mattr94@gmail.com>
> >
> > Sometimes when diffing, files may show as being momdified even when
>
> momdified? mummified? ah, modified.
>
> > there are no interesting diffs to show.  This happens naturally when
> > using options such as --ignore-space-change.
>
> Read the next paragraph and notice that it explains the cases where
> the patch does not want not to show, and then read the above again
> to realize that the above does not say anything about what it wants
> to do to cases the next paragraph does not cover.  It only says such
> a case often happens when --ignore-space-change is used.
>
>         When options like --ignore-space-change is in use, files
>         with modification can have no interesting textual changes
>         worth showing.  In such cases, "git diff --stat" shows 0
>         lines of additions and deletions.  Teach "git diff --stat"
>         not to show such a path in its output, which would be more
>         natural.
>
> perhaps?
>
> > We don't want to prevent
> > the display  of all files that have 0 effective diffs since they could
> > be the result of a rename, permission change, or other similar operation
> > that may still be of interest so we special case additions and deletions
> > as they are always interesting.
>
> Yup.  That makes sense.

I'll send a reroll with the message improved as you suggested, as well
as updating

>
> It would be nice if this does not have to be implemented as a list
> of exceptions, though.  Rather, a more targetted "omit output only
> in this narrow case" would be nicer, but the check with the mode
> bits should do at lesat for now.
>
> > diff --git a/diff.c b/diff.c
> > index f9709de7b4..131903fa3a 100644
> > --- a/diff.c
> > +++ b/diff.c
> > @@ -3153,16 +3153,19 @@ static void show_dirstat_by_line(struct diffstat_t *data, struct diff_options *o
> >       gather_dirstat(options, &dir, changed, "", 0);
> >  }
> >
> > +static void free_diffstat_file(struct diffstat_file *f)
> > +{
> > +     free(f->print_name);
> > +     free(f->name);
> > +     free(f->from_name);
> > +     free(f);
> > +}
> > +
> >  void free_diffstat_info(struct diffstat_t *diffstat)
> >  {
> >       int i;
> > -     for (i = 0; i < diffstat->nr; i++) {
> > -             struct diffstat_file *f = diffstat->files[i];
> > -             free(f->print_name);
> > -             free(f->name);
> > -             free(f->from_name);
> > -             free(f);
> > -     }
> > +     for (i = 0; i < diffstat->nr; i++)
> > +             free_diffstat_file(diffstat->files[i]);
> >       free(diffstat->files);
> >  }
> >
> > @@ -3718,6 +3721,26 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
> >               if (xdi_diff_outf(&mf1, &mf2, discard_hunk_line,
> >                                 diffstat_consume, diffstat, &xpp, &xecfg))
> >                       die("unable to generate diffstat for %s", one->path);
> > +
> > +             if (DIFF_FILE_VALID(one) && DIFF_FILE_VALID(two)) {
> > +                     struct diffstat_file *file =
> > +                             diffstat->files[diffstat->nr - 1];
> > +                     /*
> > +                      * Omit diffstats of modified files where nothing changed.
> > +                      * Even if !same_contents, this might be the case due to
> > +                      * ignoring whitespace changes, etc.
> > +                      *
> > +                      * But note that we special-case additions and deletions,
>
>                          * renames and mode changes without any content changes,
>
> > +                      * as adding an empty file, for example is still of interest.
> > +                      */
> > +                     if ((p->status == DIFF_STATUS_MODIFIED)
> > +                             && !file->added
> > +                             && !file->deleted
> > +                             && one->mode == two->mode) {
> > +                             free_diffstat_file(file);
> > +                             diffstat->nr--;
> > +                     }
> > +             }
> >       }
> >
> >       diff_free_filespec_data(one);
> > diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
> > index 88d3026894..8bdaa0a693 100755
> > --- a/t/t4015-diff-whitespace.sh
> > +++ b/t/t4015-diff-whitespace.sh
> > @@ -789,7 +789,7 @@ test_expect_success 'checkdiff allows new blank lines' '
> >       git diff --check
> >  '
> >
> > -test_expect_success 'whitespace-only changes not reported' '
> > +test_expect_success 'whitespace-only changes not reported (diff)' '
> >       git reset --hard &&
> >       echo >x "hello world" &&
> >       git add x &&
> > @@ -799,10 +799,44 @@ test_expect_success 'whitespace-only changes not reported' '
> >       test_must_be_empty actual
> >  '
> >
> > -test_expect_success 'whitespace-only changes reported across renames' '
> > +test_expect_success 'whitespace-only changes not reported (diffstat)' '
> > +     # reuse state from previous test
> > +     git diff --stat -b >actual &&
> > +     test_must_be_empty actual
> > +'
> > +
> > +test_expect_success 'whitespace changes with modification reported (diffstat)' '
> > +     git reset --hard &&
> > +     echo >x "hello  world" &&
> > +     git update-index --chmod=+x x &&
> > +     git diff --stat --cached -b >actual &&
> > +     cat <<-EOF >expect &&
> > +      x | 0
> > +      1 file changed, 0 insertions(+), 0 deletions(-)
> > +     EOF
> > +     test_cmp expect actual
> > +'
> > +
> > +test_expect_success 'whitespace-only changes reported across renames (diffstat)' '
> >       git reset --hard &&
> >       for i in 1 2 3 4 5 6 7 8 9; do echo "$i$i$i$i$i$i"; done >x &&
> >       git add x &&
> > +     git commit -m "base" &&
> > +     sed -e "5s/^/ /" x >z &&
> > +     git rm x &&
> > +     git add z &&
> > +     git diff -w -M --cached --stat >actual &&
> > +     cat <<-EOF >expect &&
> > +      x => z | 0
> > +      1 file changed, 0 insertions(+), 0 deletions(-)
> > +     EOF
> > +     test_cmp expect actual
> > +'
> > +
> > +test_expect_success 'whitespace-only changes reported across renames' '
> > +     git reset --hard HEAD~1 &&
> > +     for i in 1 2 3 4 5 6 7 8 9; do echo "$i$i$i$i$i$i"; done >x &&
> > +     git add x &&
> >       hash_x=$(git hash-object x) &&
> >       before=$(git rev-parse --short "$hash_x") &&
> >       git commit -m "base" &&
> >
> > base-commit: 878e727637ec5815ccb3301eb994a54df95b21b8



-- 
Matthew Rogers
