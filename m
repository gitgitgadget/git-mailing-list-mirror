Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F8DC433EF
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 17:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbiA0Rab (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 12:30:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiA0Ra3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 12:30:29 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD69C061714
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 09:30:28 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id j2so7437381ejk.6
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 09:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YUMUpEPnYhp37wu+Y/5GHt95ESf0VPUF9qBzGurOlhw=;
        b=UtpZNO4tcLLGWnA2MnHjf1krjoGhFSeXS/a3jffz2g7Tb7xJldzYn3JnaPb8yiktZK
         jt59Sw4dLQMlHbEb8OrRzjSNhzztDoYO9KXQWmAtbB5Y7Mljen7rH74MI+gHsH+9LyCS
         fTTMmcPVQi8z2VFCYo2JMGRRqBRvdtYM5pCKsYYz4zjlWn3r2V5houDT6JV5a/aDzy+H
         25LGGanzlHNAP9tXoI5lwooRilhBeMboc4VG0k0BNGWDcfkFQkae+d7+tabesgpyK4xd
         iisxaKS85HT7sr95YZlWzoHSatGg4BlgpgVfkz7uzmshJZ/xvFrLHyhc3zbeH+dThxrA
         cn+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YUMUpEPnYhp37wu+Y/5GHt95ESf0VPUF9qBzGurOlhw=;
        b=rP01wgS3cfEEgGBJ/0+j9Iy5qchUg3FkukI2WnxqfGpLBMpJrnr+Yb43proK7eChO/
         yIcx1FT4+/5ubG3QWGQOSgLxrNpvYxBD0JAFVuJwWvjUaMDadaVwapfMBw/PdOhyemOU
         XfeyDVdeW/CyCynmVjB9l/JHzmIsbaORcSVWemgg65rRZovCNU2QNCPckGkt1j5Yg/gc
         6Wu1Iw6mweGIwyKb9LIyc6qql1rqWhxMeLqMHwHoIDlOIglnvLPpN8jqTNyEIq1IjEka
         +znF3JHAmd+vJMBDKV4xJgFUq9dDCZjI4KYMUr2kKnZhx8bsqVNwVPCDhBgyMzlSZeuV
         SoDQ==
X-Gm-Message-State: AOAM5315a3ZmLeJxwrE5joWMdiQZ/J53pXoQg++Lkqn2MZmccgP5j4KZ
        MEsrTJtmXoLqyGEW+tPB1+/qWa2cl9TPFb2Dce7mEN8cbGI=
X-Google-Smtp-Source: ABdhPJyDDMj+aFnj0nnxK/C1jsx1UnAtznaX0q9V8Kh7QOrMfBEaWA+8PKrriFwMSXyAgh+iy3/jY+tSk4f/bL41eo0=
X-Received: by 2002:a17:907:7f8a:: with SMTP id qk10mr3765955ejc.100.1643304626994;
 Thu, 27 Jan 2022 09:30:26 -0800 (PST)
MIME-Version: 1.0
References: <29f0410e-6dfa-2e86-394d-b1fb735e7608@gmail.com>
 <xmqqsfu1g64s.fsf@gitster.g> <CABPp-BH5woi6KY7OBpnsS-M2EmgLHii9zs8rSwrgcPFkOAvn_A@mail.gmail.com>
 <e1934710-e228-adc4-d37c-f706883bd27c@gmail.com>
In-Reply-To: <e1934710-e228-adc4-d37c-f706883bd27c@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 27 Jan 2022 09:30:15 -0800
Message-ID: <CABPp-BEr4=AgGzV_+voJZO8EHkMkpXRHM-LJuzVciKoNE1Dc5w@mail.gmail.com>
Subject: Re: Bug report - sparse-checkout ignores prefix when run in subdirectories
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 27, 2022 at 8:43 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 1/5/2022 6:19 PM, Elijah Newren wrote:
> > On Wed, Jan 5, 2022 at 2:38 PM Junio C Hamano <gitster@pobox.com> wrote:
> >>
> >> Lessley Dennington <lessleydennington@gmail.com> writes:
> >>
> >>> Hello everyone! See the following bug report pertaining to sparse-checkout
> >>> when run outside top-level directories.
> >>
> >> In a bug report it is fine, but "outside top-level" usually means
> >> above the top-level of the working tree.  Here, I think you meant
> >> running in a subdirectory of the top-level.
> >>
> >> Perhaps something along this line?
> >>
> >>  builtin/sparse-checkout.c | 10 ++++++++++
> >>  1 file changed, 10 insertions(+)
> >>
> >> diff --git c/builtin/sparse-checkout.c w/builtin/sparse-checkout.c
> >> index 45e838d8f8..4e5efbb85e 100644
> >> --- c/builtin/sparse-checkout.c
> >> +++ w/builtin/sparse-checkout.c
> >> @@ -753,6 +753,16 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
> >>         if (!core_sparse_checkout_cone && argc == 0) {
> >>                 argv = default_patterns;
> >>                 argc = default_patterns_nr;
> >> +       } else if (argc && prefix && *prefix) {
> >> +               /*
> >> +                * The args are not pathspecs, so unfortunately we
> >> +                * cannot imitate how cmd_add() uses parse_pathspec().
> >> +                */
> >> +               int i;
> >> +               int prefix_len = strlen(prefix);
> >> +
> >> +               for (i = 0; i < argc; i++)
> >> +                       argv[i] = prefix_path(prefix, prefix_len, argv[i]);
> >>         }
> >
> > This looks good (sparse_checkout_add() needs a similar fix), at least
> > for cone mode.  There might be a small pickle here that I didn't think
> > about before.  --cone mode always uses directories, so we expect
> > people to provide directory names.  Because of that, I think it's fair
> > to expect the arguments passed to `set` or `add` to be paths relative
> > to the current working directory.  In contrast, for non-cone mode we
> > do not expect pathnames but gitignore-style globs.  And when we get
> > gitignore-style globs, we don't know if they were intended relative to
> > the current working directory or the toplevel, because we only have
> > one $GIT_DIR/info/sparse-checkout file versus many .gitignore files.
> > So, should "**.py" go directly into the sparse-checkout file as-is, or
> > be translated to "my/current/subdir/**.py" first?
> >
> > Maybe translating is always fine, or maybe we want to throw an error
> > when: (not using cone mode and prefix is non-empty and any patterns
> > are provided).
> >
> > Thoughts?
>
> You seem to have worked it out in the other threads, but I came here
> to agree: we should not do this transformation unless we are in
> cone mode. We should also do this when "--cone" is supplied.

Actually, I didn't figure it out.  See also the last four paragraphs
of https://lore.kernel.org/git/CABPp-BEwMAPHGt5xD9jDU58grbrAqCdqNY9Nh8UJGLKuLbArXQ@mail.gmail.com/
for related confounding factors.

Anyway, Junio's insistence elsewhere (earlier in the above linked
thread) that bash-completion include both files and directories in
non-cone mode seemed to only make sense if we did this transformation
in non-cone mode.  So, I implemented the transformation for both
modes, though I called out how it causes some possibly nasty surprises
in non-cone mode.  It's not yet submitted (wanted other series to
merge to next first), but you can see it at
https://github.com/gitgitgadget/git/pull/1118; it's the commit
entitled, "Pay attention to prefix for {set, add}".  The final patch
in that series also adds a "NON-CONE PROBLEMS" section to the manual
detailing six different problems with non-cone mode (all of which are
fundamental and unfixable), one of which is this one.  The fourth
patch also possibly mixes in with this topic.

Anyway, whether or not there is a clean answer here, that other series
at least carefully points out how non-cone mode is fundamentally
problematic and deprecates it.

> The prefix_path() collapses "../" entries, right? Just making sure
> that we test that scenario when writing a full fix here.
>
> For example, if we added a case to t1092, we should be able to
> do the following within any of the example repos:
>
>         git sparse-checkout disable &&
>         cd folder1 &&
>         git sparse-checkout set --cone . ../folder2
>         git sparse-checkout list >actual &&
>         cat >expect <<-EOF &&
>         folder1
>         folder2
>         EOF
>         test_cmp expect actual

Yes, "../" is handled; I added testcases to t1091 to verify that; they
look pretty much exactly like what you suggest here, so we seem to be
on the same wavelength.
