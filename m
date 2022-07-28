Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F76C04A68
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 14:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbiG1Oz5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 10:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232137AbiG1Ozi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 10:55:38 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEEF167C86
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 07:54:16 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id 125so1547651iou.6
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 07:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZSo9hOnK1zOExx78zMMFfKCfIFb9mRlEh8uPhUA7jPI=;
        b=UgmhKTaBkMHJzm8ytDlW568PfmupsOQDrtUHiecUR7gpo4KrKwgV6b9ENnr+nIJMmu
         Kv8SU97X1VjxWqLwFWZt80j2pBpibAouaXYb1DzpUKmALOX03CJYWdYpLtokB2EZH1DN
         NLUVe7a5D4lvItDcs3GYykLobDdq1hKtXyEhOTdwgEhYnrSsYmd1AXstBeciTB8M68Ip
         91tyef40y48/cc+Y3kHDCWmjuWCA5BXbCpRmUogNGJGb6ArVyScsahupqWDxZjVQSfX3
         OifClKlLVQm5mbEsbb4inZXq+FGanjj8LPtec13ml86Amy2ZCMf44g00DVOZTc9Bqz1b
         cgAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZSo9hOnK1zOExx78zMMFfKCfIFb9mRlEh8uPhUA7jPI=;
        b=6sXHQFF1lnLGIC2pHacoc08QBBUYs/UMCK0yEykPqJRSc7Uo2oGvdOs8hdu2i9IamM
         cGS2LSPMHozxcFPQQjpwHeiERD6FBsSUxa8Y8S4AiUEvOEbMpq9EJ8qrc6yXQ8WhuFiX
         kpFcGDP9TZcRnTtsBg8t8RVQoEvkrvZBSZ5h6MJ3eoJwQx/6LjBQILs0FD2bgnEAC7vs
         TYceiW/CD/0TXS0AD83kl3gSjKLUsJYA/hPDtcDiv/gO48talu+jz02bwEln/d2Qfgu/
         5hgVLUCFHSdcWLoVGk2+wIUS5MwrZzRG6fG4P1FjQiqHXMtIdwe4QdMpLlld1Sj/eKca
         4bQQ==
X-Gm-Message-State: AJIora+wjXxrbtMVcyX3wGmKa7m4palnqo3TbO5rHRQzEl3JxmbIZxyL
        a0w+BWRoz0PvcmOV3gVExO8aeVukHJKB/BZHa5w=
X-Google-Smtp-Source: AGRyM1uiyJdi2mYQQpWleVOLaMeFj/n/ZlY6cLC6/Dh4tz5ZhsdXfFKcz4S5ZEPYDtn+j7nY56YQ8q5l/7tf6ssBps0=
X-Received: by 2002:a05:6638:12d4:b0:33f:aaab:8d84 with SMTP id
 v20-20020a05663812d400b0033faaab8d84mr11135698jas.67.1659020055891; Thu, 28
 Jul 2022 07:54:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8QusNzdO1mHqQFPz84pznYSpFWJunroRGXQ7qk6sJjeYg@mail.gmail.com>
 <220727.86mtculxnz.gmgdl@evledraar.gmail.com>
In-Reply-To: <220727.86mtculxnz.gmgdl@evledraar.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 28 Jul 2022 22:54:04 +0800
Message-ID: <CAOLTT8QpYzoKDq6Pf8+YegCWngogy=3hUf-SyV180kntgucMpQ@mail.gmail.com>
Subject: Re: Question: What's the best way to implement directory permission
 control in git?
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> =E4=BA=8E2022=E5=
=B9=B47=E6=9C=8827=E6=97=A5=E5=91=A8=E4=B8=89 17:20=E5=86=99=E9=81=93=EF=BC=
=9A
>
>
> On Wed, Jul 27 2022, ZheNing Hu wrote:
>
> > if there is a monorepo such as
> > git@github.com:derrickstolee/sparse-checkout-example.git
> >
> > There are many files and directories:
> >
> > client/
> >     android/
> >     electron/
> >     iOS/
> > service/
> >     common/
> >     identity/
> >     list/
> >     photos/
> > web/
> >     browser/
> >     editor/
> >     friends/
> > boostrap.sh
> > LICENSE.md
> > README.md
> >
> > Now we can use partial-clone + sparse-checkout to reduce
> > the network overhead, and reduce disk storage space size, that's good.
> >
> > But I also need a ACL to control what directory or file people can fetc=
h/push.
> > e.g. I don't want a client fetch the code in "service" or "web".
> >
> > Now if the user client use "git log -p" or "git sparse-checkout add ser=
vice"...
> > or other git command, git which will  download them by
> > "git fetch --filter=3Dblob:none --stdin <oid>" automatically.
> >
> > This means that the git client and server interact with git objects
> > (and don't care about path) we cannot simply ban someone download
> > a "path" on the server side.
> >
> > What should I do? You may recommend me to use submodule,
> > but due to its complexity, I don't really want to use it :-(
>
> There isn't a way to do this in git.
>
> It's theoretically possible, i.e. a client could be told that the SHA-1
> of a directory is XYZ, and construct a commit object with a reference to
> it.
>

I guess you mean use a special reference to hold the restricted path which
the client can access, and pre-receive-hook can ban the client from downloa=
ding
other references. But this method is a little weird... How can this referen=
ce
sync with main branches? If we have changed client permission to access
server directory, how to get the "history" of the server directory?

I believe this approach is not very appropriate and is not maintainable.

> But currently a *lot* of things in the client code assume that these
> things will be available in one way or another.
>
> The state-of-the-art in the "sparse" code may differ from the above, I
> don't know.
>
> Also note that there's a well-known edge case in the git protocol where
> it's really incompatible with the notion of "secret" data, i.e. even if
> you hide a ref you'll be able to "guess" it by seeing what delta(s) the
> server will produce or accept etc.

Yeah, there are data security issues... Unless we need to isolate objects
between directories. Or in this case we disable the delta object.....
Okay, this seems a little strange.

Anyway, thanks for the answer!

ZheNing Hu
