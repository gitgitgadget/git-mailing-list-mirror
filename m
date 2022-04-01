Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D41D7C433FE
	for <git@archiver.kernel.org>; Fri,  1 Apr 2022 10:52:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345233AbiDAKyI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Apr 2022 06:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345440AbiDAKx4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Apr 2022 06:53:56 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D0960DA7
        for <git@vger.kernel.org>; Fri,  1 Apr 2022 03:52:07 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id gb19so2103205pjb.1
        for <git@vger.kernel.org>; Fri, 01 Apr 2022 03:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=coup.net.nz; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jC52LNWQ8AVPKNfpPAPkH/GzTpjjTdrh++5uLd18IuA=;
        b=fEWm7Z4QmAWW6qiyENU7K7tGvFQNnU9N4uZduK1ygU2+qVsL8+5qADIt0eiKbEAV7Y
         2coYQ6y1ltlK+CGbN0ev3fRWoBV+gY5Jo79TbZ29xmxLqkN4DjHIAf6jTEFdJCkZUCqM
         8Ol+nPVYTqCXy1bCVZgehu52ObgJsr59YZBSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jC52LNWQ8AVPKNfpPAPkH/GzTpjjTdrh++5uLd18IuA=;
        b=WFiB4ewFQZhvF8bRXjEXKBtwvMXWDvNH9uuqm/iRVTpM9+MtIo+OOiuq8U+M4HF8T9
         fjOroYGQydoSs7ZpmETmKpXYma1QOT9VYXN/53/T3nTCBUWaQ3JP0t/5SoEfUsDGM/f9
         mxldA5hrCF1ti5qlUQqT/jEjs0WlX/+5qAdmVkwg+/hizp/No6qZoE17cg2NMfcWPxdB
         0EN6tq7mxxyQQKbn6RHjOw/m8Xb3DJ8xHuYYohHmvLBxxTq4543x8YGPJZYtXy28Ku1z
         F8oH5e9nPOvcYF/rETRn9VpFuPKDBI8vwgz/e0p9gQ6CtlPrEXo3hKaFpEPT60F58IPo
         DMoA==
X-Gm-Message-State: AOAM533uL3jiz61g7V/cFsF0jnSAnXdhNANvl9Ef56LUVP1sFjZ8shOD
        gP11spSGp1xQ5qI6CKMQvqkZAXOpLSPUOwMwwemiEIuJ/cki3f2zwZ4=
X-Google-Smtp-Source: ABdhPJz9I4N52EATV4kzjTP6voqmuKVaJopPoj4V/Iklpq2WkamQAYB+322h3xrWwvC00F/2G3rI9Og5vg/lQsE7SLM=
X-Received: by 2002:a17:90b:4c09:b0:1c6:f64a:dd0 with SMTP id
 na9-20020a17090b4c0900b001c6f64a0dd0mr11187346pjb.45.1648810327229; Fri, 01
 Apr 2022 03:52:07 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1138.v3.git.1646406274.gitgitgadget@gmail.com>
 <pull.1138.v4.git.1648476131.gitgitgadget@gmail.com> <28c07219fd830196af1171320b86bc2a58ba3d79.1648476132.git.gitgitgadget@gmail.com>
 <220331.86bkxmp25k.gmgdl@evledraar.gmail.com>
In-Reply-To: <220331.86bkxmp25k.gmgdl@evledraar.gmail.com>
From:   Robert Coup <robert@coup.net.nz>
Date:   Fri, 1 Apr 2022 11:51:56 +0100
Message-ID: <CACf-nVeTMx8y+8HzQbaTjHq06Ldon+JV+rp0yzhP_RC=6La2gg@mail.gmail.com>
Subject: Re: [PATCH v4 6/7] fetch: after refetch, encourage auto gc repacking
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Robert Coup via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        John Cai <johncai86@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi =C3=86var,

On Thu, 31 Mar 2022 at 16:33, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avara=
b@gmail.com> wrote:


> > +                     if (git_config_get_int("gc.autopacklimit", &opt_v=
al))
> > +                             opt_val =3D -1;
> > +                     if (opt_val !=3D 0)
>
> nit: don't compare against 0 or null,  just !opt_val

I did this since 0 has a specific meaning ("Setting this to 0
disables"), it's not just false-y in this context. Tomayto, tomahto?

>
> Isn't this whole thing also clearer as:
>
>         int &forget;
>
>         if (git_conf...(..., &forget))
>                 git_config_push_parameter("gc.autoPackLimit=3D1");
>
> Maybe I haven't eyeballed this enough, but aren't you ignoring explicit
> gc.autoPackLimit=3D0 configuration? Whereas what you seem to want is "set
> this config unlress the user has it set", for which we only need to
> check the git_config...(...) return value, no?

What I'm trying to achieve: if the user has not disabled auto-packing
(autoPackLimit=3D0), then pass autoPackLimit=3D1 to the subprocess to
encourage repacking.
Context/why: so we don't 2x the object store size and not even attempt
to repack it now, rather than at some unspecified point in the future.
Maybe.

How the code achieves it:
  load autoPackLimit into opt_val
  if autoPackLimit is not specified in config: set opt_val to -1
  if opt_val is not 0: pass autoPackLimit=3D1 to the subprocess

AFAICT if we just if(git_config_get_int()) then if they haven't set it
at all in config, we wouldn't encourage repacking in the subprocess.
Which isn't what I'm trying to achieve.

> hrm, do we really need to set both of these these days (not saying we
> don't, just surprised). I.e. both gc.* an maintenance.* config.
>
> *skims the code*
>
> Urgh, yes? too_many_packs() seems to check gc.* only, but
> incremental_repack_auto_condition() check this variable... :(

Yes.

>
> > +test_expect_success 'fetch --refetch triggers repacking' '
> > +     GIT_TRACE2_CONFIG_PARAMS=3Dgc.autoPackLimit,maintenance.increment=
al-repack.auto &&
>
> Nit: Can we use GIT_CONFIG_KEY_* et al for this these days, or do we
> still need this trace2 thingy?

I copied a pattern existing tests are using.

Thanks, Rob.
