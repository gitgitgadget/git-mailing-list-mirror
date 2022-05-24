Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 985F3C433FE
	for <git@archiver.kernel.org>; Tue, 24 May 2022 15:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238801AbiEXPUZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 11:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235596AbiEXPUW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 11:20:22 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C52A19F87
        for <git@vger.kernel.org>; Tue, 24 May 2022 08:20:21 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id h11so22349781eda.8
        for <git@vger.kernel.org>; Tue, 24 May 2022 08:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=iW+YS1xNAXyKsbVrIlJ8/Gc8EeqSjeUSozWiC2ydJrQ=;
        b=FD/bmYXmQ3agGXS1IfbcDh2sAJ/Us7P6enjTaPJ5KmN4ZgGAn+2pFJguIugJENo6t2
         r7DYLcOoI4ndXrZ8RMtFWYigl8LH7JcbEu2BeWYlxGpC2GbO2SnMVcuIK9ZHhGdI6ONN
         XivYpQ4vVCjSml8jlUPIBJAHrao5fyujNB6Z/hYPxMQtybEqaJVeDf4O1Hf3tJEBFBwu
         dTT4fXOtbzMrXkFNGeX4wBXWE3+8W72jpVDHypNVTe3O6b8dI0W5aFz0zkbaBzH60TVD
         Vw0c5xfcN44cS2fr8hIM77lAmjxZvgJFZGTCCibngI+cgEz/+aa1KX99Kk97xBLaZ7hf
         FekQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=iW+YS1xNAXyKsbVrIlJ8/Gc8EeqSjeUSozWiC2ydJrQ=;
        b=m0yBxtXGpWPsBJoaewreRMQPOj//1E2vSLZGW2HhVDx6YhX8dr+Iov6DSH1Omutmfu
         kSgSejFcuFkhbHPrGWNgtAqhI35DGqEtrTGKAIoo1SCC5OW9FhFafQez57renUDATFcr
         E3UmbUUiBRk8HlFcrbxTUOrshkY+l0sj+vUVRn+JX/vZ9NiwCa9f7V5YuEf2CKDaL81j
         C9iv0C6TiMjf1vvsOnm4AM99GmLpPN3TpQUee0/Dy6+SmUIYMTdEJ3u5bySSEvuTny1z
         /Dw682hGDUhd1d7nquWMK/+EgznlydxyvlXeVIUq5eFJJvCSBkBOBtam99QkXqU1arXv
         Xiog==
X-Gm-Message-State: AOAM533i+p2wC1Wdukf3TZir1vISsV8kx7JwsPaOuNLmDo6uAvpq50T2
        ISo46N9XqOAdcLbChUGWRzV3vQV0s2aLtuXQFSI=
X-Google-Smtp-Source: ABdhPJw5NJOZeyw+cVP8mnG45OO+I+h5A+/fUzQYQHg8VxlyPjkDWfS4uYQxd6JOyXI0ANcHJTDT/17n6DkOFdrvYo4=
X-Received: by 2002:a05:6402:2d6:b0:42a:bb5f:a7d2 with SMTP id
 b22-20020a05640202d600b0042abb5fa7d2mr28943201edx.96.1653405620083; Tue, 24
 May 2022 08:20:20 -0700 (PDT)
MIME-Version: 1.0
References: <80eeba2b2a58af2a5497f398beb5c03447c41f61.1653003552.git.kevin@kevinlocke.name>
 <7c064f43ed426c9e3b54e1ae5313d6b9332a47cb.1653141169.git.kevin@kevinlocke.name>
 <1580ad10-43f6-bc73-901a-b65b1aea73ff@github.com> <YozlZ9DPrRLPBTBP@kevinlocke.name>
In-Reply-To: <YozlZ9DPrRLPBTBP@kevinlocke.name>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 24 May 2022 08:20:08 -0700
Message-ID: <CABPp-BGZTDKorz+CFScfTfx47c+TuJaAD_Zyyo1Jj_tymYkVXQ@mail.gmail.com>
Subject: Re: [PATCH v2] setup: don't die if realpath(3) fails on getcwd(3)
To:     Kevin Locke <kevin@kevinlocke.name>,
        Derrick Stolee <derrickstolee@github.com>,
        Git Mailing List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 24, 2022 at 7:02 AM Kevin Locke <kevin@kevinlocke.name> wrote:
>
> On Mon, 2022-05-23 at 14:57 -0400, Derrick Stolee wrote:
> > On 5/21/22 9:53 AM, Kevin Locke wrote:
> > > +           free((char*)tmp_original_cwd);
> >
> > Hm. I'm never a fan of this casting, but it existed before. It's
> > because tmp_original_cwd is exposed globally in cache.h, which
> > is _really widely_. However, there are only two uses: setup.c,
> > which defines it, and common-main.c, which initializes it during
> > process startup.
> >
> > The following diff could apply before your commit, removing this
> > use of "const char *", but maybe it doesn't fit normal Git
> > coding guidelines (putting the extern directly in a *.c file):
> >
> > --- >8 ---
> >
> > diff --git a/cache.h b/cache.h
> > index aaf334e2aa4..ce9cd6fa3f0 100644
> > --- a/cache.h
> > +++ b/cache.h
> > @@ -1797,7 +1797,6 @@ struct startup_info {
> >       const char *original_cwd;
> >  };
> >  extern struct startup_info *startup_info;
> > -extern const char *tmp_original_cwd;
> >
> >  /* merge.c */
> >  struct commit_list;
> > diff --git a/common-main.c b/common-main.c
> > index 29fb7452f8a..e472258b83b 100644
> > --- a/common-main.c
> > +++ b/common-main.c
> > @@ -23,6 +23,8 @@ static void restore_sigpipe_to_default(void)
> >       signal(SIGPIPE, SIG_DFL);
> >  }
> >
> > +extern char *tmp_original_cwd;
> > +
> >  int main(int argc, const char **argv)
> >  {
> >       int result;
> > diff --git a/setup.c b/setup.c
> > index 04ce33cdcd4..86986317490 100644
> > --- a/setup.c
> > +++ b/setup.c
> > @@ -12,7 +12,7 @@ static int work_tree_config_is_bogus;
> >
> >  static struct startup_info the_startup_info;
> >  struct startup_info *startup_info = &the_startup_info;
> > -const char *tmp_original_cwd;
> > +char *tmp_original_cwd;
> >
> >  /*
> >   * The input parameter must contain an absolute path, and it must already be
> > @@ -459,7 +459,7 @@ static void setup_original_cwd(void)
> >
> >       /* Normalize the directory */
> >       strbuf_realpath(&tmp, tmp_original_cwd, 1);
> > -     free((char*)tmp_original_cwd);
> > +     free(tmp_original_cwd);
> >       tmp_original_cwd = NULL;
> >       startup_info->original_cwd = strbuf_detach(&tmp, NULL);
> >
> > --- >8 ---
>
> This approach seems reasonable to me, as does casting to free().  It's
> not clear to me which is preferable in this case.  How to balance the
> trade-offs between exposing const interfaces, limiting (internal)
> interfaces to headers, and avoiding casts might be worth discussing
> and documenting a matter of project coding style.  `grep -rF 'free(('`
> lists about 100 casts to free, suggesting the discussion may be
> worthwhile.  Introducing a free_const() macro could be another option
> to consider.

I'd prefer either a free_const() as you suggest (though as a separate
patch from what you are submitting here), or leaving the code as-is.
free() could have been written to take a const void* instead of just
void*, since it's not going to modify what the pointer points at.  The
reason we call free() is because the variable isn't needed anymore,
and using a non-const value after freeing is just as wrong as using a
const one after freeing, so casting away the constness cannot really
cause any new problems.  So, I think the signature of free() is just
wrong: it should have taken a const void* all along.  Unfortunately,
the wrong type signature sadly makes people feel like they have to
choose between (a) dropping the added safety of const that the
compiler can enforce for you during the lifetime of the variable, or
(b) leaking memory you no longer need.  I think it's a bad choice and
you should just typecast when free'ing, but clearly others just don't
want to see any typecasts and are willing to dispense with const on
constant variables.
