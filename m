Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57033C433EF
	for <git@archiver.kernel.org>; Fri,  1 Apr 2022 04:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbiDAEC2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Apr 2022 00:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbiDAEC1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Apr 2022 00:02:27 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E517A261305
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 21:00:35 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id i7so1635948oie.7
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 21:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cPSRPu0sjnX3qeQdbyboezv5tGY8/wCOMJpHam/l/NA=;
        b=pNaHYdvUNPh2d5TsUMxFHddUGqI9NBZ7sKNCJlPT+6cB1qnp0idRcEjd0LdHfB6d2l
         DISVpnhoXcaWawgPPgxy65y4w6bQatzbXL3aDFiqmyyrYPHVy0gRgRMsLdOZV1DJPx5p
         13J1Q7VEZpZn8VmWKEJtWJQgOeVcs7/5dv41LVMLtqYrUoR2MerHtMVAkhBpID2c13Td
         RdYFdsFVBRuOzCGobq4sfjamoqyUvdebCzWvPdBuwuJWYvPu2bn/6bflnfas/D4x9uuB
         uIo0ORa7bd3WAQGQnd4+LF4oL3TGxlgXEn9GDwujs1q+vS1D29bvymj5sDoWTHirDrIw
         vC4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cPSRPu0sjnX3qeQdbyboezv5tGY8/wCOMJpHam/l/NA=;
        b=z+ksTGx4s8Us/CuqbgMwnTCXRuouZagOf/Uc1WRWy5gREFIJp9Q27sPyfQ7TyVxrsa
         ZBjeS8IP+BqxqfxcEXMbZwLDJt6sTrIz93TctjNUtQUsmigSy+60jBYfbWycKYZpxVEm
         S7bF1BPecGWziJPlem+Qd//IPNZWI1jQaa6awygeZMINymY+XXP5esUnT6FpTMTuFhrr
         N0uq5bDYfhGVNiqS1ADnVYjh5um1H9dNEUSzwaVpM+8q0trdXi772YH4vk6wIhhS5k4Y
         x/6jsq9AwRfy7er5uIMUXECbye1qp40cHBfZyOsSBOSMBl8u75vKgqT8Xr34bsx4HI6p
         vUNA==
X-Gm-Message-State: AOAM5315UnPMcILeeUc1bPihJODkX/hBKVTpReVODH6XhNlXgYOmm5Wy
        0JTFojPrkAJMb8RfFEVnw3A+AKkFkPjou5CjuiA=
X-Google-Smtp-Source: ABdhPJylcOI15ukGgV4iJTjhIWR7P4r4abPxvQYOkumZahfSwmUQcO8xza9qsd+GAyTmYOpbzIYFa8ryjxF0HWnZsps=
X-Received: by 2002:a54:410b:0:b0:2d9:ddf4:2ea with SMTP id
 l11-20020a54410b000000b002d9ddf402eamr4009289oic.280.1648785635258; Thu, 31
 Mar 2022 21:00:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
 <20220331091755.385961-4-shaoxuan.yuan02@gmail.com> <220331.86ilruqup6.gmgdl@evledraar.gmail.com>
In-Reply-To: <220331.86ilruqup6.gmgdl@evledraar.gmail.com>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Date:   Fri, 1 Apr 2022 12:00:24 +0800
Message-ID: <CAJyCBORNQEN4WNfuYbO264qz0W6d-rbT6z=T_-AZF5jY36c1yQ@mail.gmail.com>
Subject: Re: [WIP v1 3/4] mv: add advise_to_reapply hint for moving file into cone
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, vdye@github.com, derrickstolee@github.com,
        gitster@pobox.com, Tao Klerks <tao@klerks.biz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 31, 2022 at 6:31 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> More odd indentation, and the braces aren't needed.

Got me again :-( Will make a change.

> >       }
> >
> >       if (gitmodules_modified)
> > @@ -392,6 +398,9 @@ int cmd_mv(int argc, const char **argv, const char =
*prefix)
> >                              COMMIT_LOCK | SKIP_IF_UNCHANGED))
> >               die(_("Unable to write new index file"));
> >
> > +     if (advise_to_reapply)
> > +             printf(_("Please use \"git sparse-checkout reapply\" to r=
eapply the sparsity.\n"));
> > +
>
> Please see 93026558512 (tracking branches: add advice to ambiguous
> refspec error, 2022-03-28) (the OID may change after I send this, as
> it's in "seen") for how to add new advise, i.e. we use advise(), add an
> enum field, config var etc.

I actually did use advise(), but I noticed that it prints to stderr
and ... nevermind,
I realized that printing to stderr is OK. But can I print to stdout
since I think users should
be "reminded" instead of "warned"?

Anyway, I think using advice() is probably better.

--=20
Thanks & Regards,
Shaoxuan
