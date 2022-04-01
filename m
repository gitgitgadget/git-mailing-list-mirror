Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C26ADC433F5
	for <git@archiver.kernel.org>; Fri,  1 Apr 2022 03:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244742AbiDADxR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Mar 2022 23:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234794AbiDADxQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Mar 2022 23:53:16 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D26105062
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 20:51:26 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-de3ca1efbaso1439656fac.9
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 20:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Lm1WWcrf6ShX5nI57P17BRyFTwnC8OUIEb1cLSOakWg=;
        b=NtCeDPpBBIqWXdbN6Buwb3F2MMFkfGOBnX8nupV94mhPwiOMfGvuvNh9sTgBNzZvnK
         d2AJpfxW3nEbiwUGaiBfCqFU70LyvXGFSovB+aVk1p3jiW77WECmjLkmjDDLlUlU6ZvX
         SG4uqsleoakcCh+XpPVt8FOp3LF7OhSmb0LETRNbR5FkAqx4sOWqb3wFmCbml/ZJgrMz
         SmXm3lbP4itbzUj/0WVj0sx0eFy8lanf4RKYteRgFp5mWbM6t6ufOzx85CimUXNji5c4
         JaSrFuk+IWQxHnqkvHFJ94Fko8J/Wo+2n0Qh+TYgmp/+XX8KNXCwcTzLl7OUYTeI4hIP
         6B9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Lm1WWcrf6ShX5nI57P17BRyFTwnC8OUIEb1cLSOakWg=;
        b=NHLrNtwoFbQSMKYe47SgOBy1u3hqmrcxEYuGb9Qd3TVXBGA3NEQoioszjPQuODXAXj
         viKfGnDe7I6n0xIeT0eCvdflnwmqdqClTc7v5Iwr/Cj6A49A24wz5F+zrwO2Nku02ik3
         eQozmDqfU/EOfs5oulaixQ+EDaT5rp/mmhpI+p2OLxqNgIWxj6ip7kOIGQ1a10YfcaCQ
         aDoB3yIkwIVxNv/I/5jJAw5sYGl5j3x2bYEb+8rJp6peaWhq+/E8+qkauYFNQMlEPF4M
         pB1ozBa9zzchVIQucwSe8uB1W1BC+1jJfGACrrpTDjwky/WkZsUExUNXLUuU5teJum0N
         U7JA==
X-Gm-Message-State: AOAM531+Lxtz/pBnzISNRbTVN/ylbcRB22MFrIiFQ2lCwZPT+eiA/14X
        DPE++qibHQNBk9su1Kr2CE29qyPxXRYmCwk+h9Q=
X-Google-Smtp-Source: ABdhPJzPTPyIRGrniLplQssX7TRY33MxHYE8IqiVlhtq9Yrud1tfYreoW1dOzpOepZXOFViwl9I4KETU/Wxb7qexnMQ=
X-Received: by 2002:a05:6870:f697:b0:da:b3f:3268 with SMTP id
 el23-20020a056870f69700b000da0b3f3268mr4195620oab.280.1648785086276; Thu, 31
 Mar 2022 20:51:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
 <20220331091755.385961-3-shaoxuan.yuan02@gmail.com> <220331.86mth6qus1.gmgdl@evledraar.gmail.com>
In-Reply-To: <220331.86mth6qus1.gmgdl@evledraar.gmail.com>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Date:   Fri, 1 Apr 2022 11:51:15 +0800
Message-ID: <CAJyCBOThDykT9dn09CutAdaSwWXapVn3St3XnnLYmORfGfq+=w@mail.gmail.com>
Subject: Re: [WIP v1 2/4] mv: add check_dir_in_index() and solve general dir
 check issue
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, vdye@github.com, derrickstolee@github.com,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 31, 2022 at 6:30 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Thu, Mar 31 2022, Shaoxuan Yuan wrote:
>
> > +static int check_dir_in_index(const char *dir)
> > +{
> > +     int ret =3D 0;
> > +     int length =3D sizeof(dir) + 1;
> > +     char *substr =3D malloc(length);
> > +
> > +     for (int i =3D 0; i < the_index.cache_nr; i++) {
>
> See https://lore.kernel.org/git/xmqqy20r3rv7.fsf@gitster.g/ for how
> we're not quite using this syntax yet.
>
> This should also be "unsigned int" to go with the "cache_nr" member.
>
> > +             memcpy(substr, the_index.cache[i]->name, length);
> > +             memset(substr + length - 1, 0, 1);
> > +
> > +             if (strcmp(dir, substr) =3D=3D 0) {
>
> Style: don't compare against =3D=3D 0, or =3D=3D NULL, use !, see CodingG=
uidelines.
>
> > +                     else if (check_dir_in_index(src_w_slash) &&
> > +                     !path_in_sparse_checkout(src_w_slash, &the_index)=
) {
>
> Funny indentation, the ! should be aligned with "(".
>
> > -                             modes[i] =3D WORKING_DIRECTORY;
> > +                             if (!modes[i])
> > +                                     modes[i] =3D WORKING_DIRECTORY;
>
> This works, but assuming things about enum values (even if 0) always
> seems a bit nasty, can this be a comparison to BOTH instead of !? May or
> may not be better...
>
> But then again we do xcalloc() to allocate it, so we assume that
> already, nevermind... :)
>
> (there were also indentation issues below)

Thanks for the styling reminders! I should go back and reread CodingGuideli=
nes
more often... Things just slipped off my mind since I'm still trying to rem=
ember
the guideline...

--=20
Thanks & Regards,
Shaoxuan
