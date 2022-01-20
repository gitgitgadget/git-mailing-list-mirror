Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FABAC433EF
	for <git@archiver.kernel.org>; Thu, 20 Jan 2022 02:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358215AbiATCdv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jan 2022 21:33:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbiATCdr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jan 2022 21:33:47 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F21DC061574
        for <git@vger.kernel.org>; Wed, 19 Jan 2022 18:33:47 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id c24so19911621edy.4
        for <git@vger.kernel.org>; Wed, 19 Jan 2022 18:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+0DFERDe5riyjIXa8yV1u+eVb/K6+jemV7Q87FRz4zo=;
        b=ggb7QOQEwoZfwGVEXpxWm6yjjh/X2hck3sUN22b2LPZLrTLhZcoA2oOARKEsJhObAC
         2jaZwvjlx9FI50YbwrlrSUQFxO5EIemAuiOEuz/rON1WSPwQ0RHj+7hY4kHazsIYUQLm
         0eLLXIL2pnjzD+Vky2gIsy/WTnPgxxfXwGHZZ5Uc4mOw04ZvweP9Leh7etj9cU/bErqM
         jvtUPhX7aYsjWDY/vp47x1UIGSWdkmgyEo7rQsIOUtV1b4wtY5Wvt6x3wL3zFhbyDht5
         undHgs/m/3tWYEhhzbf+i16bAfeRZkoGRGTYh3FORPBntVrASlt0bnvHE7TDPAha1uH3
         zmZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+0DFERDe5riyjIXa8yV1u+eVb/K6+jemV7Q87FRz4zo=;
        b=Sgyt+BxfS0A42bSq7N4rIkHEDuJD2+D4DwyVpz0Q/1OGKjezc+7vXwH9arZ9JtjjKS
         3+nzhEq8MdJ0HHdblglMvYfluXVD0vC1RA5enEXY9VbZGSNeSUYBSBscK6DclosjnCx9
         FwJxIIQuRTSFhFABnpvnmuQUWOfRPrI1OS1oZM71feVwf21Y3uZ4W+Qez7PwsHPfGFgA
         kOj6Pny9HWuQzpRkiy8FAnWf7cxjoI9VvLqbMS5uoeLYsVCI5w4kn54KBhvMD4DaMyM3
         azL4qoSGMpEpq45Fi48QX1yfKoXsE4JfXxzJpwkR3Ddqb0SrFHrm4rG0sCocWgXkRfSL
         by/Q==
X-Gm-Message-State: AOAM532IOB87VlioXe0scQP/Q1RBZraqN+PlMgmWEUkMGx9uCOGs9dLn
        RfJmRCskk2CVOZKfJ69LVTX2WbfBzjlIMlXI0YPGZ7c6
X-Google-Smtp-Source: ABdhPJzVYffPn6Em/7i4MxFKppaxSpyUI1sAz15d30WVW5FRLPz4+hHtZ1h+CSg8NHoLTE2SdFGrAuZZPNJ46xWLk4Y=
X-Received: by 2002:a17:907:2d10:: with SMTP id gs16mr26675253ejc.100.1642646026024;
 Wed, 19 Jan 2022 18:33:46 -0800 (PST)
MIME-Version: 1.0
References: <pull.1103.v2.git.1640419159.gitgitgadget@gmail.com>
 <pull.1103.v3.git.1640907369.gitgitgadget@gmail.com> <d57ae218cf9eaee0b66db299ee1bba9b488b69b1.1640907369.git.gitgitgadget@gmail.com>
 <220119.86lezbn21b.gmgdl@evledraar.gmail.com>
In-Reply-To: <220119.86lezbn21b.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 19 Jan 2022 18:33:34 -0800
Message-ID: <CABPp-BH9+RWE1SQfQiAYFtGZze3eQpeNDYNr2v9dmT77Pns0nA@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] show, log: provide a --remerge-diff capability
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Neeraj Singh <nksingh85@gmail.com>,
        Johannes Altmanninger <aclopte@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 19, 2022 at 8:06 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Thu, Dec 30 2021, Elijah Newren via GitGitGadget wrote:
>
> > From: Elijah Newren <newren@gmail.com>
> > +     struct tmp_objdir *remerge_objdir =3D NULL;
> > +
> > +     if (rev->remerge_diff) {
> > +             remerge_objdir =3D tmp_objdir_create("remerge-diff");
> > +             if (!remerge_objdir)
> > +                     die_errno(_("unable to create temporary object di=
rectory"));
> > +             tmp_objdir_replace_primary_odb(remerge_objdir, 1);
> > +     }
>
> Re the errno feedback on v1
> https://lore.kernel.org/git/211221.864k71r6kz.gmgdl@evledraar.gmail.com/
> the API might lose the "errno" due to e.g. the remove_dir_recurse()
> codepath. This seems like it would take care of that:
>
> diff --git a/builtin/log.c b/builtin/log.c
> index 944d9c0d9b5..d4b8b1aa4b6 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -424,9 +424,9 @@ static int cmd_log_walk(struct rev_info *rev)
>         int saved_dcctc =3D 0;
>
>         if (rev->remerge_diff) {
> -               rev->remerge_objdir =3D tmp_objdir_create("remerge-diff")=
;
> +               rev->remerge_objdir =3D tmp_objdir_create_gently("remerge=
-diff", 0);
>                 if (!rev->remerge_objdir)
> -                       die_errno(_("unable to create temporary object di=
rectory"));
> +                       exit(128);
>                 tmp_objdir_replace_primary_odb(rev->remerge_objdir, 1);
>         }
>
> diff --git a/tmp-objdir.c b/tmp-objdir.c
> index adf6033549e..3c656120003 100644
> --- a/tmp-objdir.c
> +++ b/tmp-objdir.c
> @@ -121,19 +121,21 @@ static void env_replace(struct strvec *env, const c=
har *key, const char *val)
>         strvec_pushf(env, "%s=3D%s", key, val);
>  }
>
> -static int setup_tmp_objdir(const char *root)
> +static int setup_tmp_objdir(const char *root, int quiet)
>  {
>         char *path;
>         int ret =3D 0;
>
>         path =3D xstrfmt("%s/pack", root);
>         ret =3D mkdir(path, 0777);
> +       if (!quiet && ret < 0)
> +               die_errno(_("unable to create temporary object directory =
'%s'"), path);
>         free(path);
>
>         return ret;
>  }
>
> -struct tmp_objdir *tmp_objdir_create(const char *prefix)
> +struct tmp_objdir *tmp_objdir_create_gently(const char *prefix, int quie=
t)
>  {
>         static int installed_handlers;
>         struct tmp_objdir *t;
> @@ -161,6 +163,8 @@ struct tmp_objdir *tmp_objdir_create(const char *pref=
ix)
>         strbuf_grow(&t->path, 1024);
>
>         if (!mkdtemp(t->path.buf)) {
> +               if (!quiet)
> +                       error_errno(_("unable to create temporary directo=
ry '%s'"), t->path.buf);
>                 /* free, not destroy, as we never touched the filesystem =
*/
>                 tmp_objdir_free(t);
>                 return NULL;
> @@ -173,7 +177,7 @@ struct tmp_objdir *tmp_objdir_create(const char *pref=
ix)
>                 installed_handlers++;
>         }
>
> -       if (setup_tmp_objdir(t->path.buf)) {
> +       if (setup_tmp_objdir(t->path.buf, quiet)) {
>                 tmp_objdir_destroy(t);
>                 return NULL;
>         }
> diff --git a/tmp-objdir.h b/tmp-objdir.h
> index 76efc7edee5..5072fb860d9 100644
> --- a/tmp-objdir.h
> +++ b/tmp-objdir.h
> @@ -24,8 +24,15 @@ struct tmp_objdir;
>  /*
>   * Create a new temporary object directory with the specified prefix;
>   * returns NULL on failure.
> + *
> + * The tmp_objdir_create() is an a wrapper for
> + * tmp_objdir_create_gently(..., 1).
>   */
> -struct tmp_objdir *tmp_objdir_create(const char *prefix);
> +struct tmp_objdir *tmp_objdir_create_gently(const char *prefix, int quie=
t);
> +static inline struct tmp_objdir *tmp_objdir_create(const char *prefix)
> +{
> +       return tmp_objdir_create_gently(prefix, 1);
> +}
>
>  /*
>   * Return a list of environment strings, suitable for use with

Yeah, I think this suggests that switching from die() to die_errno()
was a mistake.  Your patch looks right (though most of it belongs as
part of ns/tmp-objdir rather than this series), but I think it makes
the code uglier and I don't see why this theoretical error path is
worth all this trouble.  A die() is totally sufficient here.
