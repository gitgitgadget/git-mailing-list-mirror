Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71845C433EF
	for <git@archiver.kernel.org>; Sat, 29 Jan 2022 04:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344512AbiA2Edh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 23:33:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiA2Ede (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 23:33:34 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5176DC061714
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 20:33:33 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id o12so22794373eju.13
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 20:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kGqVImmY8OFpjMEoUcz0L9cPV4A6GgD6Anf3jF/9uik=;
        b=Xdp/QDoDmEcQTjWUTtT0KC5DfbMAspkYLTaH/sScO/220dtaxKmu8e7FAeuADiv5ux
         AtnUPL6Y7+qkJiRhAB7Fmt+RO3xqdTk0I6AYUgBFxWMIR5YGxu1W6wbWbuxIMjn33yW8
         shTmhfJKN2cgI9zadXDrl/6lorrw/sArur4XiuE67AhmHqkh0pKU22K1qoVIQa3g7YZV
         aFK1Zaa2ZTvdjip2A6hsQx9F7I8y8390PFJc4H6j+bv9Eq5SGnr961+3zBedXB+lcZHS
         UXGkC5mq/osJ+kj989F5x1hl0naLiN2ZRRFWISvQelcw4yPrAxAdJjm+iDBHHI8n53Sb
         gfrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kGqVImmY8OFpjMEoUcz0L9cPV4A6GgD6Anf3jF/9uik=;
        b=5iEWDlmbBh0kjTGzblUjvDuW0FITHqzyXEM+V1YRqwzioQQ2oc6tOlp3108yNa0EOE
         qhjOS1vkPOsb2INh/j4OWSSiDPWpSwD/iRC2JWdpe4vcNXRK19XlL+XphgZtBUXJIWYu
         V5iTpHa0afomG+7GCo2XI170ime/QHx75hbLlpezV3wcjyqm2o5/wobx57aTbXjzpRA8
         uALodoPPkh9dcC7ZF4su7w6kItmvb30JH7Ykt3uK/lx4OKzOUXk8alJ/oV5s9c4SQLMi
         52LMVYcXkfKuZebtNRVViE9AoumZrTG3UTzERMJ4ixvTwM9mHjxyyRRUs/eXG9Lcn+Yu
         /AZg==
X-Gm-Message-State: AOAM5309prjTx22agSSBdxVayWeu7njXGVOSm11Fu1Z7BI0VzRwdea2f
        WO5nzq9aDBrK587l0cuEW4kVT9p8wYRGzwJG2i2EJC7x
X-Google-Smtp-Source: ABdhPJyKqPeqNnyfJE2F/kFFshNqvmix0HGFqbEHwXxs23axYUWU++ddl3k+27rymTmYxI3/JCfCshqkZq226hiHKtE=
X-Received: by 2002:a17:907:7da8:: with SMTP id oz40mr3258453ejc.328.1643430811831;
 Fri, 28 Jan 2022 20:33:31 -0800 (PST)
MIME-Version: 1.0
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
 <e3ef17eb46fdfd759030761ab6d7c35fbf24ee0f.1642888562.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2201281716420.347@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2201281716420.347@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 28 Jan 2022 20:33:20 -0800
Message-ID: <CABPp-BGHf864FMaS0YkBUF=Rr9gmrQYVav96nwMmYWFVs3XuFA@mail.gmail.com>
Subject: Re: [PATCH 06/12] merge-ort: allow update messages to be written to
 different file stream
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 28, 2022 at 8:31 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Elijah,
>
> On Sat, 22 Jan 2022, Elijah Newren via GitGitGadget wrote:
>
> > diff --git a/merge-ort.c b/merge-ort.c
> > index f9e35b0f96b..b78dde55ad9 100644
> > --- a/merge-ort.c
> > +++ b/merge-ort.c
> > @@ -4236,7 +4236,8 @@ static int record_conflicted_index_entries(struct merge_options *opt)
> >  }
> >
> >  void merge_display_update_messages(struct merge_options *opt,
> > -                                struct merge_result *result)
> > +                                struct merge_result *result,
> > +                                FILE *stream)
> >  {
> >       struct merge_options_internal *opti = result->priv;
> >       struct hashmap_iter iter;
> > @@ -4263,7 +4264,7 @@ void merge_display_update_messages(struct merge_options *opt,
> >       for (i = 0; i < olist.nr; ++i) {
> >               struct strbuf *sb = olist.items[i].util;
> >
> > -             printf("%s", sb->buf);
> > +             fprintf(stream, "%s", sb->buf);
>
> Maybe `strbuf_write(sb, stream);` instead? Whenever I see a `"%s"`, I feel
> like it's unnecessary churn...

Makes sense.

> >       }
> >       string_list_clear(&olist, 0);
> >
>
> Missing from this hunk:
>
>         /* Also include needed rename limit adjustment now */
>         diff_warn_rename_limit("merge.renamelimit",
>                                opti->renames.needed_limit, 0);
>
> This function explicitly writes to `stdout`, and will need to be adjusted,
> I think, before we can include an adjustment to this call in this patch.

Oh, good point.

> Unless we override `warn_routine()` (which is used inside that function),
> that is. Which is hacky, and we would not have addressed the
> `fflush(stdout)` in `diff_warn_rename_limit()`. So I would much prefer
> something like this:
>
> -- snip --
> diff --git a/diff.c b/diff.c
> index 861282db1c3..87966602cbd 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -6312,17 +6312,25 @@ static const char rename_limit_advice[] =
>  N_("you may want to set your %s variable to at least "
>     "%d and retry the command.");
>
> -void diff_warn_rename_limit(const char *varname, int needed, int degraded_cc)
> +void diff_warn_rename_limit(const char *varname, int needed, int degraded_cc,
> +                           FILE *out)
>  {
> -       fflush(stdout);
> +       const char *fmt = NULL;
> +
>         if (degraded_cc)
> -               warning(_(degrade_cc_to_c_warning));
> +               fmt = _(degrade_cc_to_c_warning);
>         else if (needed)
> -               warning(_(rename_limit_warning));
> +               fmt = _(rename_limit_warning);
>         else
>                 return;
>         if (0 < needed)
> -               warning(_(rename_limit_advice), varname, needed);
> +               fmt = _(rename_limit_advice);
> +
> +       fflush(out);
> +       if (out == stdout)
> +               warning(fmt, varname, needed);
> +       else
> +               fprintf(out, fmt, varname, needed);
>  }
>
>  static void diff_flush_patch_all_file_pairs(struct diff_options *o)
> @@ -6754,7 +6762,7 @@ int diff_result_code(struct diff_options *opt, int status)
>
>         diff_warn_rename_limit("diff.renameLimit",
>                                opt->needed_rename_limit,
> -                              opt->degraded_cc_to_c);
> +                              opt->degraded_cc_to_c, stdout);
>         if (!opt->flags.exit_with_status &&
>             !(opt->output_format & DIFF_FORMAT_CHECKDIFF))
>                 return status;
> diff --git a/diff.h b/diff.h
> index 8ba85c5e605..be4ee68c0a2 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -596,7 +596,8 @@ void diffcore_fix_diff_index(void);
>  int diff_queue_is_empty(void);
>  void diff_flush(struct diff_options*);
>  void diff_free(struct diff_options*);
> -void diff_warn_rename_limit(const char *varname, int needed, int degraded_cc);
> +void diff_warn_rename_limit(const char *varname, int needed, int degraded_cc,
> +                           FILE *out);
>
>  /* diff-raw status letters */
>  #define DIFF_STATUS_ADDED              'A'
> diff --git a/merge-ort.c b/merge-ort.c
> index 0342f104836..e6b5a0e7c64 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -4264,7 +4264,7 @@ void merge_switch_to_result(struct merge_options *opt,
>
>                 /* Also include needed rename limit adjustment now */
>                 diff_warn_rename_limit("merge.renamelimit",
> -                                      opti->renames.needed_limit, 0);
> +                                      opti->renames.needed_limit, 0, stdout);
>
>                 trace2_region_leave("merge", "display messages", opt->repo);
>         }
> diff --git a/merge-recursive.c b/merge-recursive.c
> index d9457797dbb..10b2948678c 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -3731,7 +3731,8 @@ static void merge_finalize(struct merge_options *opt)
>                 strbuf_release(&opt->obuf);
>         if (show(opt, 2))
>                 diff_warn_rename_limit("merge.renamelimit",
> -                                      opt->priv->needed_rename_limit, 0);
> +                                      opt->priv->needed_rename_limit, 0,
> +                                      stdout);
>         FREE_AND_NULL(opt->priv);
>  }
>
> -- snap --

I like this, but believe it makes more sense as a preparatory patch.
So I created one and made you the author, and included your
signed-off-by.  That okay with you?

>
> The rest of the patch looks good to me.

Thanks!
