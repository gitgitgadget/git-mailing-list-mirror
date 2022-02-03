Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264FDC433FE
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 09:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234903AbiBCJM2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 04:12:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231503AbiBCJM2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 04:12:28 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E48DC061714
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 01:12:27 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id k25so6499635ejp.5
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 01:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CbpmpqpvaquQhW6ZeO66HEvGxtaanpogZFnc6Qsb/hA=;
        b=oB+VX/W5K6m/oyb/lwbhEPCPbE6+fTuFAGRO8K7gCDdKQSV0PxMxZIVuHGzyJOoIIl
         I62Ji3p9/0GJGIJbweljlZxG/r48OoM7DidlO/YNb66ujZ6Ktdt9OWUbrYXLf/inR7N2
         yj7U3ijBazC+9H6yjmbN4KCwY69XTIWseFgKQpNhE1j+2IDImefYXdSD38NycT00sWQr
         M5JW0IVfbrBYYD8be4Q2HDl37cea7HbbMN5PU5yQBdOwptK/y8udgGCM0EbyzMkgohwv
         4tnUNdSIJvvs5Su2vcFGSu/H4Xhr8l2AVk7IX08DtK1gjsOaeQGYYd4hYsVsKuARKXXU
         OVLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CbpmpqpvaquQhW6ZeO66HEvGxtaanpogZFnc6Qsb/hA=;
        b=ZHXrqpZn/qrGacedyYGdTuMOtggVgUqtgIcm8Ut9nE3N0HERboTMXx8Jqf/CroK6XJ
         PoyfUchx7fjH+BCrcru8ec0kx/sU2b76PXV7dlPQSyWV0t3hqY1iQOM4u2N76C4a3uOQ
         FfbUc7ZFBSUYf/Jzui6AYAvj8W87yCUIi6sft7VTnAXAY1ToXMPZLWbMNI+eQKxA0JJ9
         rbxp1C2Rd0fViCESMLDMBZPJis8Vi1ANPRoFtrVf6jTmkO7fHMceEU2+a/5TzrYo+G2C
         T42J7ZA0VxJMGdm3W0oBJDYV0D2ZpdlVX8N5Z44SkofVidYAZcyOEXe4/chCQDlFNOSA
         tnLw==
X-Gm-Message-State: AOAM5328mDkYPXnY5GgkWihoVgLFD2oUf95X7gVKMKWKs231mIHU9tAN
        +xaS9a765NB8gRj1XQH1bzS+aQpt2MHKi5qefG8=
X-Google-Smtp-Source: ABdhPJxUEpncdktVmlF7T3wf9lu8Jq9A93p4SnoC+s4JEREsvJQvlmsDTeIdJI9CBD8XY+g0YfkEMo+sxZSz7Euy7kM=
X-Received: by 2002:a17:906:4793:: with SMTP id cw19mr22614715ejc.100.1643879545840;
 Thu, 03 Feb 2022 01:12:25 -0800 (PST)
MIME-Version: 1.0
References: <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
 <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com> <04c3bdc44d2c76ffc82a95db3ca4fd07270f94cf.1643787281.git.gitgitgadget@gmail.com>
 <220203.86ee4k7lo8.gmgdl@evledraar.gmail.com>
In-Reply-To: <220203.86ee4k7lo8.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 3 Feb 2022 01:12:14 -0800
Message-ID: <CABPp-BHye_Zyw=x8B+QoSxWA1b0xyVL9==7kA4CD0q3eTrk8cQ@mail.gmail.com>
Subject: Re: [PATCH v3 08/15] merge-ort: allow update messages to be written
 to different file stream
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 2, 2022 at 6:01 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
> On Wed, Feb 02 2022, Elijah Newren via GitGitGadget wrote:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > This modifies the new display_update_messages() function to allow
> > printing to somewhere other than stdout.  It also consolidates the
> > location of the diff_warn_rename_limit() message with the rest of the
> > CONFLICT and other update messages to all go to the same stream.
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  merge-ort.c | 9 +++++----
> >  merge-ort.h | 3 ++-
> >  2 files changed, 7 insertions(+), 5 deletions(-)
> >
> > diff --git a/merge-ort.c b/merge-ort.c
> > index 82d2faf5bf9..d28d1721d14 100644
> > --- a/merge-ort.c
> > +++ b/merge-ort.c
> > @@ -4236,7 +4236,8 @@ static int record_conflicted_index_entries(struct=
 merge_options *opt)
> >  }
> >
> >  void merge_display_update_messages(struct merge_options *opt,
> > -                                struct merge_result *result)
> > +                                struct merge_result *result,
> > +                                FILE *stream)
> >  {
> >       struct merge_options_internal *opti =3D result->priv;
> >       struct hashmap_iter iter;
> > @@ -4263,13 +4264,13 @@ void merge_display_update_messages(struct merge=
_options *opt,
> >       for (i =3D 0; i < olist.nr; ++i) {
> >               struct strbuf *sb =3D olist.items[i].util;
> >
> > -             printf("%s", sb->buf);
> > +             strbuf_write(sb, stream);
> >       }
> >       string_list_clear(&olist, 0);
> >
> >       /* Also include needed rename limit adjustment now */
> >       diff_warn_rename_limit("merge.renamelimit",
> > -                            opti->renames.needed_limit, 0, stderr);
> > +                            opti->renames.needed_limit, 0, stream);
>
> At the tip of this series I tried to s/stream/stderr/g this, and
> t4301-merge-tree-write-tree.sh passes, doesn't this warning_fp() special
> behavior need a test somewhere?

That's a fair point, but...this gets back to my cover letter comments
about patches 5, 6, and 8.  They implement a code feature that seems
useful in general...but which Dscho and Christian didn't like using in
this particular command; they just wanted all output on stdout.

So, it's hard to add a test, because there's no code anywhere that
exercises it in this series anymore.  I originally wanted this feature
in my remerge-diff series, but the idea of conflict headers made me
punt it to this series.  I wanted it for this series, but Dscho and
Christian didn't.  I could have punted again, but decided the
underlying want kept coming up and decided to not excise it --
especially since Dscho was helping improve it.  And Junio commented
that he liked the idea[1].

[1] https://lore.kernel.org/git/xmqqh79hx8g1.fsf@gitster.g/

But yeah, it does leave it feeling slightly odd that we implemented a
feature that nothing is currently using.  Maybe these 3 should be
split off into their own series?  Still wouldn't have a test yet,
though.

> I assumed that warning_fp() would be using vreportf() in usage.c, but
> it's not, it's just falling back to the equivalent of fprintf(out, ...),
> no? I don't really see why 05/15 and parts of 06/15 & this are needed
> over a much simpler simple helper macro like the below. applied on top
> of this series.

That macro is simple?  I thought I basically understood Dscho's code,
but looking at what you did with diff_warn_rename_limit(), I think I'm
lost.

> I would get it if the point was to actually use the full usage.c
> machinery, but we're just either calling warning(), or printing a
> formatted string to a file FILE *. There's no need to go through usage.c
> for that, and adding an API to it that behaves like this new
> warning_fp() is really confusing.

Because the formatted string being printed to the file won't have the
same "warning: " prefix that is normally added to stuff in usage?

That's a fair point; that does have a bit of a consistency problem.
And I'd rather the messages were consistent regardless of where they
are printed.

> I.e. an API in usage.c that allowed warning to a given FD would be
> trying to replace the "2" in the write_in_full() call in vreportf(), I
> would think.

Hmm, makes sense.

> diff --git a/diff.c b/diff.c
> index 28368110147..4cf67e93dea 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -6377,14 +6377,21 @@ static const char rename_limit_advice[] =3D
>  N_("you may want to set your %s variable to at least "
>     "%d and retry the command.");
>
> +#define warning_fp(out, fmt, ...) do { \
> +       if (out =3D=3D stderr) \
> +               warning(fmt, __VA_ARGS__); \
> +       else \
> +               fprintf(out, fmt, __VA_ARGS__); \
> +} while (0)
> +
>  void diff_warn_rename_limit(const char *varname, int needed, int degrade=
d_cc,
>                             FILE *out)
>  {
>         fflush(stdout);
>         if (degraded_cc)
> -               warning_fp(out, _(degrade_cc_to_c_warning));
> +               warning_fp(out, _(degrade_cc_to_c_warning), NULL);
>         else if (needed)
> -               warning_fp(out, _(rename_limit_warning));
> +               warning_fp(out, _(rename_limit_warning), NULL);

Why do the only callers have a NULL parameter here?  Is this one of
those va_list/va_args things I never bothered to properly learn?

>         else
>                 return;
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 64ba60e5c71..d70ce142861 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -475,7 +475,6 @@ int error(const char *err, ...) __attribute__((format=
 (printf, 1, 2)));
>  int error_errno(const char *err, ...) __attribute__((format (printf, 1, =
2)));
>  void warning(const char *err, ...) __attribute__((format (printf, 1, 2))=
);
>  void warning_errno(const char *err, ...) __attribute__((format (printf, =
1, 2)));
> -void warning_fp(FILE *out, const char *warn, ...) __attribute__((format =
(printf, 2, 3)));
>
>  #ifndef NO_OPENSSL
>  #ifdef APPLE_COMMON_CRYPTO
> diff --git a/usage.c b/usage.c
> index 0bfd2c603c0..c7d233b0de9 100644
> --- a/usage.c
> +++ b/usage.c
> @@ -253,20 +253,6 @@ void warning(const char *warn, ...)
>         va_end(params);
>  }
>
> -void warning_fp(FILE *out, const char *warn, ...)
> -{
> -       va_list params;
> -
> -       va_start(params, warn);
> -       if (out =3D=3D stderr)
> -               warn_routine(warn, params);
> -       else {
> -               vfprintf(out, warn, params);
> -               fputc('\n', out);
> -       }
> -       va_end(params);
> -}
> -
>  /* Only set this, ever, from t/helper/, when verifying that bugs are cau=
ght. */
>  int BUG_exit_code;
