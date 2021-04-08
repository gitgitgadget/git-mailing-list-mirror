Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA50C433B4
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 15:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EF55610F9
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 15:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbhDHPMs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 11:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbhDHPMs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 11:12:48 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8271FC061760
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 08:12:33 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id v26so2581843iox.11
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 08:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZKj91p8mL+a04tZyOTr+16kUPr0w6bbBDb6/MWSqMF4=;
        b=ip+IdZ+15kx4OENSo3sBBSe1QCb6U4AgKUJH/3aB7UR3yv10Gs10kNG6PCLSW3kyiC
         IdJEUrgXL93BQvTBzxdcaKdx0H/o1HWrJIBL7sWELYQ5wNjNwLoqBVrY8D2nfToJ1wKX
         QO2EgrcJEVQ5ra6dc99fiq7g0xT3R28dL3ct5Hq7SOuI6QI9jtLHXtqxIoO2aGgjsJY2
         sFLItyh5bpfO5FgXZizLSnIURZySzuKlBrnMv+Th8Brk6uzmqp/6P0CteA/mKNqMobMY
         +avNgjkEc2iMVZfoMt1GV0/7TR94JanhFCqTRkH7zUVKTTj/eFt2BdMQBsoInVjy5KZL
         3A9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZKj91p8mL+a04tZyOTr+16kUPr0w6bbBDb6/MWSqMF4=;
        b=V/x0FwTZnpbFOS0q6glPfZQcRSkjNc3jjLrVveSSLpaFwmwqhXNBqHoOxTmIqb4A2I
         ZjCL7A0w3IyfQTmphFRnn25qlY43YaI05JFfW6zY2CvlbIwt8qzbgfJ93l5CtWOTBz1D
         pSoSi7GUjzcvsXDCx8f6FPis7mjQs5bu7i7btDENX+x+rUY7p6Qaz+ec/lSy0cTabLQ1
         WucHhL1FMbYcCv+jbPwZCRJaGnMmKE30U2Q6gLMLwyUQnOZC7cUE16+i6z3t2mhHPSgk
         2K/ZjKpdMLhKiIqqoOLfOaIUPvxgFD0QlPImUTiZWiASch3tEvMuuaCW1b5LR347uJua
         2HqQ==
X-Gm-Message-State: AOAM530riTD22ch1Dh7W5mfBtZiWMtQqJWHoR0EPXCi42nrqpeBkxYu/
        pGL8eOBIQH5+LgVxVG6hrNStYNOQ9ay+1jIwbqI=
X-Google-Smtp-Source: ABdhPJwAUDlAbAMT2Ztgd2Prhf+uCNsPBMgm3Wk3qrzS2JrQPVa8nqc4rOsfqffNq0+EGnisQvOVMP4eBtekKfI0WXI=
X-Received: by 2002:a05:6638:dc3:: with SMTP id m3mr9440712jaj.130.1617894752700;
 Thu, 08 Apr 2021 08:12:32 -0700 (PDT)
MIME-Version: 1.0
References: <pull.927.git.1617631280402.gitgitgadget@gmail.com>
 <pull.927.v2.git.1617809209164.gitgitgadget@gmail.com> <YG4jxKQ3z1R+8Jfz@coredump.intra.peff.net>
 <CAOLTT8QvdLeWz=cDOoVFV8Lrk2QL2wf_jwDc6oK5j+6gup+Png@mail.gmail.com>
 <YG8UD7c4lChOQM5a@coredump.intra.peff.net> <CAOLTT8STy3Y_pLf0PDs-Uj1dXJYSjPD3FbKrUiSM4Uz-F7etSA@mail.gmail.com>
 <YG8Ya3Z0FGBm1vwf@coredump.intra.peff.net>
In-Reply-To: <YG8Ya3Z0FGBm1vwf@coredump.intra.peff.net>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 8 Apr 2021 23:12:21 +0800
Message-ID: <CAOLTT8RBc0MLWZpRctxxMSnd5n6Fj6b6teZWz8kR_WebHxkvzQ@mail.gmail.com>
Subject: Re: [PATCH v2] [GSOC] ref-filter: use single strbuf for all output
To:     Jeff King <peff@peff.net>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Hariom Verma <hariom18599@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> =E4=BA=8E2021=E5=B9=B44=E6=9C=888=E6=97=A5=E5=91=
=A8=E5=9B=9B =E4=B8=8B=E5=8D=8810:51=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Apr 08, 2021 at 10:43:54PM +0800, ZheNing Hu wrote:
>
> > > What I meant was that we should get rid of show_ref_array_items(), as
> > > well, and just use format_ref_array_item() everywhere. This whole
> > > wrapper is only saving us a few lines, and it makes it harder to see
> > > what the function is doing. Likewise for pretty-print ref. But I dunn=
o.
> > > Maybe that is all going too far.
> > >
> >
> > Ok... so you mean we just use a loop like in branch.c, and get rid of
> > show_ref_array_items() and show_ref_array_item().
> > (We can still use the optimization of reuse bufs)
>
> Yes, something like this:
>
> diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
> index cb9c81a046..55297fe297 100644
> --- a/builtin/for-each-ref.c
> +++ b/builtin/for-each-ref.c
> @@ -22,6 +22,8 @@ int cmd_for_each_ref(int argc, const char **argv, const=
 char *prefix)
>         struct ref_array array;
>         struct ref_filter filter;
>         struct ref_format format =3D REF_FORMAT_INIT;
> +       struct strbuf output =3D STRBUF_INIT;
> +       struct strbuf err =3D STRBUF_INIT;
>
>         struct option opts[] =3D {
>                 OPT_BIT('s', "shell", &format.quote_style,
> @@ -80,8 +82,16 @@ int cmd_for_each_ref(int argc, const char **argv, cons=
t char *prefix)
>
>         if (!maxcount || array.nr < maxcount)
>                 maxcount =3D array.nr;
> -       for (i =3D 0; i < maxcount; i++)
> -               show_ref_array_item(array.items[i], &format);
> +
> +       for (i =3D 0; i < maxcount; i++) {
> +               strbuf_reset(&output);
> +               if (format_ref_array_item(array.items[i], &format, &outpu=
t, &err))
> +                       die("%s", err.buf);
> +               fwrite(output.buf, 1, output.len, stdout);
> +               putchar('\n');
> +       }
> +
> +       strbuf_release(&output);
>         ref_array_clear(&array);
>         return 0;
>  }
>
> It is dropping a few lines by assuming that the error buf is only
> touched when we return an error (which IMHO is a reasonable assumption
> to make).
>

I agree, err buffer does not need to be reused.

> -Peff

Thanks.
--
ZheNing Hu
