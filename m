Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E9DC433F5
	for <git@archiver.kernel.org>; Wed, 25 May 2022 03:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243476AbiEYDwG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 23:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235282AbiEYDwF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 23:52:05 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6DF56FB5
        for <git@vger.kernel.org>; Tue, 24 May 2022 20:52:03 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id h11so24269313eda.8
        for <git@vger.kernel.org>; Tue, 24 May 2022 20:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DEjFS9tpNtUdGo5H++VfHaRH5E+5HARJPBUbCTygELw=;
        b=ne8B1gmrt3dtuk0r0GNLAtxxUhzbGXdzxbCLTdmuZT0cAq1tlpaBKmUwuqmDfAKWu6
         vtkoQPf0RNOpHXSegtM2GxNpHg2qxtjt/BoPB8fpA7b4IBS/xkLG6qSxrQrsrtAPdk2U
         LlEg3ZhEe4UAQT5nL7+l5p19CJyVD81lP1ESa+l5+tbCIxxDDuDiMBftSrMPTzYkdU86
         BPk0I6YbIH55dpgkxiilejE0wXLo8bhUY5UpUkxgOZYTL4zJTbvkva3SPhdEcmOjh85U
         ImI0mhEdEwYg/sMOziF10ooLvmpe610gAGqypdZgPFJGTPqAJZr9Rci2EETdgeKXyCWG
         lkQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DEjFS9tpNtUdGo5H++VfHaRH5E+5HARJPBUbCTygELw=;
        b=2IGtUNkNbkgnxr7l3y3j0/Np/oLSsuGmO5I3fuBd5bqFicglaISW6Csjfdr9nuuGXp
         DVaR+7VmR03M6CbMdjcen7bFRni5CdN3GJ3vsuGVo8WH7dxXKQxM9QfWyeVcGF6DcNVC
         hNf2EHwL4RronDHzlDHPjF/Gee166BjEIN1Z859YoHLhCp2lPIdSMopHCQMEflpxsQ4C
         zoeMWK+Inqvru3Ta2a4zBRz1QsCXHRqXMnBUTljH4YPX5y3gd84kWUBpaI+z+ilRhdPD
         OBnMQ/GR0iMZwBW9+kA6fplWf3P0f5CVsW6pI/r848oMv/CiT9p7VjtY7Duku+Fh9gXj
         TDbg==
X-Gm-Message-State: AOAM533vHcMxb+nrdz6BXP9H/20D+wnlEm0j9giJRuCzf0iZZno7MENb
        jtPCXzJ/VEWJg5eBbDHRK2IdB2HUS6+vsVpYY0M=
X-Google-Smtp-Source: ABdhPJxltcS+IWHmLCA9Z8B956o+ZlOusMPCwLKcDiLi+LMiXiAGskHdlKL9WzgHaQjOvE0xfynN2hNQF8a84C51r6g=
X-Received: by 2002:a05:6402:a42:b0:42b:c5e9:1495 with SMTP id
 bt2-20020a0564020a4200b0042bc5e91495mr1969160edb.323.1653450722148; Tue, 24
 May 2022 20:52:02 -0700 (PDT)
MIME-Version: 1.0
References: <68c66aef7ca4dba53faec9e6d2f3b70fe58ac33e.1653403877.git.kevin@kevinlocke.name>
 <8b20840014d214023c50ee62439147f798e6f9cc.1653419993.git.kevin@kevinlocke.name>
 <xmqqk0aafwsd.fsf@gitster.g>
In-Reply-To: <xmqqk0aafwsd.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 24 May 2022 20:51:50 -0700
Message-ID: <CABPp-BHZQXt-=XtTk7Ez463rhbcQQBNGUVkbbWiavZT+Rsjn_A@mail.gmail.com>
Subject: Re: [PATCH v4] setup: don't die if realpath(3) fails on getcwd(3)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kevin Locke <kevin@kevinlocke.name>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 24, 2022 at 2:25 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Kevin Locke <kevin@kevinlocke.name> writes:
>
> >       /* Normalize the directory */
> > -     strbuf_realpath(&tmp, tmp_original_cwd, 1);
> > +     if (!strbuf_realpath(&tmp, tmp_original_cwd, 0)) {
> > +             trace2_data_string("setup", the_repository,
> > +                                "realpath-path", tmp_original_cwd);
> > +             trace2_data_string("setup", the_repository,
> > +                                "realpath-failure", strerror(errno));
> > +             free((char*)tmp_original_cwd);
> > +             tmp_original_cwd = NULL;
> > +             return;
> > +     }
> > +
> >       free((char*)tmp_original_cwd);
> >       tmp_original_cwd = NULL;
> >       startup_info->original_cwd = strbuf_detach(&tmp, NULL);
>
> It is somewhat sad that we cannot readily use FREE_AND_NULL() here.
> If it casted away the constness (see the attached at the end), we
> could have saved two lines from the above snippet.
>
> The startup_info->original_cwd member is initialized to NULL, and
> I think it is a safe assumption that it still is so when the control
> reaches here.  Otherwise, the assignment of strbuf_detach() to it
> without first freeing the current value we see in the post context
> is leaking already.
>
> So, overall this looks good to me.  Anybody else who have already
> spent cycles to review this want to add Reviewed-by: to it?

Well, I added my Reviewed-by to v3 and apparently missed a few things
which were fixed up in v4.  So, my review apparently wasn't careful
enough.  But I am happy with this version, so here it is again:

Reviewed-by: Elijah Newren <newren@gmail.com>

(Now someone is free to spot more problems and embarrass me even more...)

>
> Thanks.
>
> diff --git i/git-compat-util.h w/git-compat-util.h
> index 58fd813bd0..56c6c48461 100644
> --- i/git-compat-util.h
> +++ w/git-compat-util.h
> @@ -976,7 +976,7 @@ int xstrncmpz(const char *s, const char *t, size_t len);
>   * FREE_AND_NULL(ptr) is like free(ptr) followed by ptr = NULL. Note
>   * that ptr is used twice, so don't pass e.g. ptr++.
>   */
> -#define FREE_AND_NULL(p) do { free(p); (p) = NULL; } while (0)
> +#define FREE_AND_NULL(p) do { free((void*)p); (p) = NULL; } while (0)
>
>  #define ALLOC_ARRAY(x, alloc) (x) = xmalloc(st_mult(sizeof(*(x)), (alloc)))
>  #define CALLOC_ARRAY(x, alloc) (x) = xcalloc((alloc), sizeof(*(x)))

I also like this change, even if it feels like it should be part of a
separate patch.
