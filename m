Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A34C433EF
	for <git@archiver.kernel.org>; Sun,  5 Sep 2021 08:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A27E60F8F
	for <git@archiver.kernel.org>; Sun,  5 Sep 2021 08:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236317AbhIEIVX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Sep 2021 04:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhIEIVW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Sep 2021 04:21:22 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E7EC061575
        for <git@vger.kernel.org>; Sun,  5 Sep 2021 01:20:19 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id b7so4515553iob.4
        for <git@vger.kernel.org>; Sun, 05 Sep 2021 01:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Hh2/yG+uH9u4p3CiXYdg/XxvQHjKioRcjEiG4vZMu6E=;
        b=ZY2Y8EXX0Z/U5DObzQ4V3rOrcR2MsTdfx61uHOcWx4bkMrr5v6SyhGca512eSudJ1x
         JiKOUdhdS6FBFqVHpfh8jXepPT/KahvHgspJYdQ9LCSAS6L2Dhsy2VNu4DasWu0vXBYz
         2j75cYnM/DRT+/ZlRjDUtt1nteeKnpMBaxkL1q7k0SdBgi8/xvzud4hFmmv/Up2QMAuX
         NmecUa9qn/sadaxEYgZizKMTrIYbaD51ja3hpRUHzWCM0ecPamuqjY1dIEB7iOwH4X5S
         06CMvpTkDi0X/NHW6ePd2rdQhybMaeVBbD6Bbtis0WQoDXLJuR45wzovUlNrs6X/FyN/
         +NHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Hh2/yG+uH9u4p3CiXYdg/XxvQHjKioRcjEiG4vZMu6E=;
        b=W5+wckxaNHGY7hFbzn9km4KsnhO6E4mrHwshAD/nxF33ncfzV0w6SlJjpi4IUIcKSg
         va63OwEFOiLn9T5HaaoesSMM8tVfpzW47pxfQeq4VxiNPkoy1ZCMaj3w20F0N+8yhtnP
         mjSc0DjteWea3WKV5rh0qBC+AJ4J0gLi6ND6tgHAWjADsfT49hZKamdGdsEQIMWBlxoF
         Yns9a2AuK3DMMhowTnZ7nqTqWGKpvExwO6gbwybZOlLGpa+EBW3/Z9uyYR+CjragLNAj
         ZXCLUVy51AI4U4EudHMUPsnYsk643gImcoXVv0DCuFvnbLFxjzesiIkT+8OxRv20U8wY
         QiZw==
X-Gm-Message-State: AOAM5306HuXWI9TttusjRJI1F8bBSPYfLFTRriggUhlMBWf6tvU+WH1u
        coR9RRb59F+vD1piZu/mowY0SZabCwif873sxhc=
X-Google-Smtp-Source: ABdhPJxfNjuxz4xqcwrz2eC1/3F1rCsngju0ggFZ6CrLHadkjYivFG3ReDBOQ8OzvMfdCiz84gythmYgq/LNBeJqzeU=
X-Received: by 2002:a5d:8484:: with SMTP id t4mr5315398iom.126.1630830019263;
 Sun, 05 Sep 2021 01:20:19 -0700 (PDT)
MIME-Version: 1.0
References: <YTNpQ7Od1U/5i0R7@coredump.intra.peff.net> <YTNps0YBOaRNvPzk@coredump.intra.peff.net>
In-Reply-To: <YTNps0YBOaRNvPzk@coredump.intra.peff.net>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sun, 5 Sep 2021 16:20:07 +0800
Message-ID: <CAOLTT8QYe3PBPxSH8CYY+FatSfT7C5m6nccR2xMZ1yxSDFh5OQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] ref-filter: implement "quick" formats
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> =E4=BA=8E2021=E5=B9=B49=E6=9C=884=E6=97=A5=E5=91=
=A8=E5=85=AD =E4=B8=8B=E5=8D=888:42=E5=86=99=E9=81=93=EF=BC=9A
>
> Some commonly-used formats can be output _much_ faster than going
> through the usual atom-formatting code. E.g., "%(objectname) %(refname)"
> can just be a simple printf. This commit detects a few easy cases and
> uses a hard-coded output function instead.
>
> Note two things about the implementation:
>
>  - we could probably go further here. E.g., %(refname:lstrip) should be
>    easy-ish to optimize, too. Likewise, mixed-text like "delete
>    %(refname)" would be nice to have.
>
>  - the code is repetitive and enumerates all the cases, and it feels
>    like we ought to be able to generalize it more. But that's exactly
>    what the current formatting tries to do!
>
> So this whole thing is pretty horrible, and is a hack around the
> slowness of the whole used_atom system. It _should_ be possible to
> refactor that system to have roughly the same cost, but this will serve
> in the meantime.
>
> Here are some numbers ("stream" is Git with the streaming optimization
> from the previous commit, and "quick" is this commit):
>
>   Benchmark #1: ./git.stream for-each-ref --format=3D'%(objectname) %(ref=
name)'
>     Time (mean =C2=B1 =CF=83):     229.2 ms =C2=B1   6.6 ms    [User: 228=
.3 ms, System: 0.9 ms]
>     Range (min =E2=80=A6 max):   220.4 ms =E2=80=A6 242.6 ms    13 runs
>
>   Benchmark #2: ./git.quick for-each-ref --format=3D'%(objectname) %(refn=
ame)'
>     Time (mean =C2=B1 =CF=83):      94.8 ms =C2=B1   2.2 ms    [User: 93.=
5 ms, System: 1.4 ms]
>     Range (min =E2=80=A6 max):    90.8 ms =E2=80=A6  98.2 ms    32 runs
>
>   Summary
>     './git.quick for-each-ref --format=3D'%(objectname) %(refname)'' ran
>       2.42 =C2=B1 0.09 times faster than './git.stream for-each-ref --for=
mat=3D'%(objectname) %(refname)''
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  ref-filter.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  ref-filter.h | 13 +++++++++++
>  2 files changed, 76 insertions(+)
>
> diff --git a/ref-filter.c b/ref-filter.c
> index 17b78b1d30..1efa3aadc8 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -1009,6 +1009,37 @@ static int reject_atom(enum atom_type atom_type)
>         return atom_type =3D=3D ATOM_REST;
>  }
>
> +static void set_up_quick_format(struct ref_format *format)
> +{
> +       /* quick formats don't handle any special quoting */
> +       if (format->quote_style)
> +               return;
> +
> +       /*
> +        * no atoms at all; this should be uncommon in real life, but it =
may be
> +        * interesting for benchmarking
> +        */
> +       if (!used_atom_cnt) {
> +               format->quick =3D REF_FORMAT_QUICK_VERBATIM;
> +               return;
> +       }
> +
> +       /*
> +        * It's tempting to look at used_atom here, but it's wrong to do =
so: we
> +        * need not only to be sure of the needed atoms, but also their o=
rder
> +        * and any verbatim parts of the format. So instead, let's just
> +        * hard-code some specific formats.
> +        */
> +       if (!strcmp(format->format, "%(refname)"))
> +               format->quick =3D REF_FORMAT_QUICK_REFNAME;
> +       else if (!strcmp(format->format, "%(objectname)"))
> +               format->quick =3D REF_FORMAT_QUICK_OBJECTNAME;
> +       else if (!strcmp(format->format, "%(refname) %(objectname)"))
> +               format->quick =3D REF_FORMAT_QUICK_REFNAME_OBJECTNAME;
> +       else if (!strcmp(format->format, "%(objectname) %(refname)"))
> +               format->quick =3D REF_FORMAT_QUICK_OBJECTNAME_REFNAME;
> +}
> +
>  /*
>   * Make sure the format string is well formed, and parse out
>   * the used atoms.
> @@ -1047,6 +1078,9 @@ int verify_ref_format(struct ref_format *format)
>         }
>         if (format->need_color_reset_at_eol && !want_color(format->use_co=
lor))
>                 format->need_color_reset_at_eol =3D 0;
> +
> +       set_up_quick_format(format);
> +
>         return 0;
>  }
>
> @@ -2617,6 +2651,32 @@ static void append_literal(const char *cp, const c=
har *ep, struct ref_formatting
>         }
>  }
>
> +static int quick_ref_format(const struct ref_format *format,
> +                           const char *refname,
> +                           const struct object_id *oid)
> +{
> +       switch(format->quick) {
> +       case REF_FORMAT_QUICK_NONE:
> +               return -1;
> +       case REF_FORMAT_QUICK_VERBATIM:
> +               printf("%s\n", format->format);
> +               return 0;
> +       case REF_FORMAT_QUICK_REFNAME:
> +               printf("%s\n", refname);
> +               return 0;
> +       case REF_FORMAT_QUICK_OBJECTNAME:
> +               printf("%s\n", oid_to_hex(oid));
> +               return 0;
> +       case REF_FORMAT_QUICK_REFNAME_OBJECTNAME:
> +               printf("%s %s\n", refname, oid_to_hex(oid));
> +               return 0;
> +       case REF_FORMAT_QUICK_OBJECTNAME_REFNAME:
> +               printf("%s %s\n", oid_to_hex(oid), refname);
> +               return 0;
> +       }
> +       BUG("unknown ref_format_quick value: %d", format->quick);
> +}
> +

So as a fast path, we actually avoided format_ref_array_item() when we are =
using
%(objectname) and %(refname). But the problem is that it=E2=80=99s not very=
 elegant
(using string compare), and it is no optimization for other atoms that
require in-depth
parsing. I remember the "fast path" used by =C3=86var last time, and it
seems that Junio doesn't
like them. [1][2]

>  int format_ref_array_item(struct ref_array_item *info,
>                           struct ref_format *format,
>                           struct strbuf *final_buf,
> @@ -2670,6 +2730,9 @@ void pretty_print_ref(const char *name, const struc=
t object_id *oid,
>         struct strbuf output =3D STRBUF_INIT;
>         struct strbuf err =3D STRBUF_INIT;
>
> +       if (!quick_ref_format(format, name, oid))
> +               return;
> +
>         ref_item =3D new_ref_array_item(name, oid);
>         ref_item->kind =3D ref_kind_from_refname(name);
>         if (format_ref_array_item(ref_item, format, &output, &err))
> diff --git a/ref-filter.h b/ref-filter.h
> index ecea1837a2..fde5c3a1cb 100644
> --- a/ref-filter.h
> +++ b/ref-filter.h
> @@ -87,6 +87,19 @@ struct ref_format {
>
>         /* Internal state to ref-filter */
>         int need_color_reset_at_eol;
> +
> +       /*
> +        * Set by verify_ref_format(); if not NONE, we can skip the usual
> +        * formatting and use an optimized routine.
> +        */
> +       enum ref_format_quick {
> +               REF_FORMAT_QUICK_NONE =3D 0,
> +               REF_FORMAT_QUICK_VERBATIM,
> +               REF_FORMAT_QUICK_REFNAME,
> +               REF_FORMAT_QUICK_OBJECTNAME,
> +               REF_FORMAT_QUICK_REFNAME_OBJECTNAME,
> +               REF_FORMAT_QUICK_OBJECTNAME_REFNAME,
> +       } quick;
>  };
>
>  #define REF_FORMAT_INIT { .use_color =3D -1 }
> --
> 2.33.0.618.g5b11852304

[1]: https://lore.kernel.org/git/5903d02324f3275b3aa442bb3ca2602564c543dc.1=
626363626.git.gitgitgadget@gmail.com/
[2]: https://lore.kernel.org/git/87eecf8ork.fsf@evledraar.gmail.com/
