Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC8AC433EF
	for <git@archiver.kernel.org>; Fri, 26 Nov 2021 18:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242114AbhKZSft (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Nov 2021 13:35:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237480AbhKZSdr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Nov 2021 13:33:47 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB7EC0698D3
        for <git@vger.kernel.org>; Fri, 26 Nov 2021 10:07:09 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id y12so41969191eda.12
        for <git@vger.kernel.org>; Fri, 26 Nov 2021 10:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=U4NoqAI3RoqIJbLeWtqCku2qRfqbEZLsjJMbmxELg9I=;
        b=X9VtXYka9+wHT1wGGczjph9uKmIJmSw88LoZXU2s8Qq1QlQWfuHDNNJ9PFru+Y0nKY
         +NqnH5gRIe8dD7bVmYAWFsOiZ6ks3JFI7KmUjOHwIsJZEHdGrTp0jXfel2GkZTCpf36n
         ZpyWk6NH9kTwEIvxZfanj2xN+uhLca9G+FMDkMa4cxT1ZzQDplU04M8mPi0qMajU5ZfT
         4TEjol+1qS7Sm4TyMmLizZ/5RNPetGAZ74YmvaTfuIoQOoyBM2jzQSmrIl062d9AKE70
         A+49lrPJxIkgkVQNUrQ62xi2kbwQxRkmE7scEyzM5WHJCVveMVk0+RBpryCwP6dRblCX
         uaWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=U4NoqAI3RoqIJbLeWtqCku2qRfqbEZLsjJMbmxELg9I=;
        b=mW3+63u0t3tQ8ZAiIAztfy2bdJspW65HSZhCHmqpwZhrN/bPt8W4L5Zwm+UuuAg/Fc
         lS379SmOYx88XK6Pp8K9hK5g6nsMSzAvXBJr/s4Nbhv2h9Xuw7MQ7oyKWjjjh3HWs2yk
         T/KGa11ZCCSi5upTxonr3mq4CeMLMlLvAK2wgp6/BLxaAgwUBwUF4AzrJL6goAf+pc7V
         eQ0SqUvx12mrMRaBE0r4TzTwwMrJ2nGBNYZs26u5+gUTr+1cFkS2lQ0bhn9UMWq1grk+
         r+fVBNRauGoGhXYiko6pWgEV2MrTeUZRC9+psE9K+XE+ZMsJVE+bUtUlOsoa0Y6L9xZJ
         yI/w==
X-Gm-Message-State: AOAM530j8UvDXjMSMhF9rHGlrpfOHkFv4nNO/vMhuWnDzbQV8CFMb2ad
        tyhUtYuuuFpH9JuJg76LXCp+yOUYpuhTDuHBdX0=
X-Google-Smtp-Source: ABdhPJxKIwGRiWt28mrNlKWqQVbchp3Dr4eSqASd6X7yBZyd9dNJaiZxp5Xgli1OR6OLlJX/VLLvdxVnp4hu7NmemhU=
X-Received: by 2002:a50:c38c:: with SMTP id h12mr48714534edf.72.1637950027729;
 Fri, 26 Nov 2021 10:07:07 -0800 (PST)
MIME-Version: 1.0
References: <pull.1140.git.git.1637455620.gitgitgadget@gmail.com>
 <pull.1140.v2.git.git.1637829556.gitgitgadget@gmail.com> <e74975e83cc7a11b8f0378d59a8c2c4a97d3aa50.1637829556.git.gitgitgadget@gmail.com>
 <211125.867dcwjyeu.gmgdl@evledraar.gmail.com>
In-Reply-To: <211125.867dcwjyeu.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 26 Nov 2021 10:06:55 -0800
Message-ID: <CABPp-BH8iE=78Ni0yNaotmvtQps1LnAXfg8X1veO44Q4cf6yMA@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] unpack-trees: refuse to remove startup_info->original_cwd
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Glen Choo <chooglen@google.com>,
        Philip Oakley <philipoakley@iee.email>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 25, 2021 at 2:57 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Thu, Nov 25 2021, Elijah Newren via GitGitGadget wrote:
>
> > +     /* ERROR_CWD_IN_THE_WAY */
> > +     "Refusing to remove '%s' since it is the current working director=
y.",
> > +
> >       /* ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN */
> >       "Untracked working tree file '%s' would be overwritten by merge."=
,
> >
> > @@ -131,6 +134,9 @@ void setup_unpack_trees_porcelain(struct unpack_tre=
es_options *opts,
> >       msgs[ERROR_NOT_UPTODATE_DIR] =3D
> >               _("Updating the following directories would lose untracke=
d files in them:\n%s");
> >
> > +     msgs[ERROR_CWD_IN_THE_WAY] =3D
> > +             _("Refusing to remove the current working directory:\n%s"=
);
> > +
>
> We end up capitalizing the first letter here, which isn't our usual
> style, but I see we do it for all of unpack_plumbing_errors already, and
> some related things like the error setup.c would emit.
>
> Still, perhaps it's better to not follow that convention for new
> messages?

If someone else wants to submit a patch afterwards to clean up all
these error messages, that'd be fine, but I think being internally
inconsistent is more jarring than not following the global rule.  I'll
leave it as is, and let someone else do the wider cleanup.
