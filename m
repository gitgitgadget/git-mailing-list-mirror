Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A00C64EC4
	for <git@archiver.kernel.org>; Wed,  8 Mar 2023 12:07:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbjCHMHT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 07:07:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbjCHMHQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 07:07:16 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B735B9538
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 04:07:15 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-536be69eadfso301156227b3.1
        for <git@vger.kernel.org>; Wed, 08 Mar 2023 04:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678277234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NuVAOcOMPWZRjHbpGanxXUqeXwHO2WKoA/bQfEZXRNo=;
        b=DS1sB8E9Dm/Zs8U/AqWcfRn560Nxo/ThisMmIg20ukw2ad2ezawBuNiWlGVNrR4qzN
         /RVhOsthfBZBDIbFG1UQs0OwOV9tWH+bpNC4pmf7/uxTD3G/uaMAIg2x7wkQbOMz4DIb
         pZ00jD8fh2x1F/03A7/jGxnJAZNClfItkSdVqYZR4v7QgDWTU6/CH3yHkKMz/7ONidPX
         Vclv4P7y2QyDR3ZqJrWra4gLd9yQhqhrZVPeGsJLAcBnuGK6VHr/814nId38OWwZAw8j
         GNMtSVV4fe1z0K8txI2dlsl3vvjbEAGMP8Ja/zY42uoMddwLoOGBUYAIugLzX8chUPqC
         USQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678277234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NuVAOcOMPWZRjHbpGanxXUqeXwHO2WKoA/bQfEZXRNo=;
        b=ENfKri38cqqmv1cWx58x2C69+xLDdojKZmRlqFNftYptAjgvt30SN0hsJY7omdTewD
         hmLVS5cpq0vUJVw8q0prJfKnNEJ+bNKlhGmW8rb3EuBzVLZ5Rfvj0/bUBlt3msm0Wn+m
         6Zd4fVFW2DTeSoEJt3dQy1XIuDhiFH1zQs0p/t8ei5qCHUC4FfyR7GAZLkMm9Pjawpav
         8opt/IYpD+/5l50zfC+5cAWONoHMF9JVT2opjk/El+mz2NH4tmXy+/v6lMEHnKKUiphQ
         UN9zNNYe4qgKVcuADRPSBbOlsIBQP8kamVXFUDfGQlOFhL5FFR1cd9JKzcmpF1DQBQN1
         mQYg==
X-Gm-Message-State: AO0yUKX6wlVIzI5cpd8VBgHW5DYPxSBA3UhqVxGOrclo7MopIcBSKxPG
        tjfMeohdyvqX7ZfLgExFjt5hu1n9af25nl+2hms=
X-Google-Smtp-Source: AK7set+RxzLU/0bn4uobsDWwZu4+C8FAZ85tQ0hYvQ71z6JEGB2i6OnmKMJonrjjEef4VUcrvHsQnQWGNM52uDcfNUw=
X-Received: by 2002:a81:ae4e:0:b0:52e:ac97:115f with SMTP id
 g14-20020a81ae4e000000b0052eac97115fmr11651846ywk.5.1678277234375; Wed, 08
 Mar 2023 04:07:14 -0800 (PST)
MIME-Version: 1.0
References: <20230308090536.2562917-1-felipe.contreras@gmail.com>
 <230308.86bkl3zjp3.gmgdl@evledraar.gmail.com> <CAMP44s2NJefUOzpyq=qbWSi+X-GnVTXaEgT8dM4zMPSzm29yag@mail.gmail.com>
 <230308.86ttyvxzjz.gmgdl@evledraar.gmail.com>
In-Reply-To: <230308.86ttyvxzjz.gmgdl@evledraar.gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Wed, 8 Mar 2023 06:07:03 -0600
Message-ID: <CAMP44s2dZmrt8SDFU+vwV7AX1BJNS3jR-nu0WZJsaEKLgTtKDg@mail.gmail.com>
Subject: Re: [PATCH] test: simplify counts aggregation
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Fabian Stelzer <fs@gigacodes.de>,
        Brandon Casey <drafnel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 8, 2023 at 5:17=E2=80=AFAM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmas=
on <avarab@gmail.com> wrote:
>
> On Wed, Mar 08 2023, Felipe Contreras wrote:

> > Or just:
> >
> >     for file in "${TEST_OUTPUT_DIRECTORY-.}"/test-results/t*-*.counts
> >
> > And don't pass anything.
>
> Yeah, I think that would work, but at least on an ad-hoc basis I've
> sometimes saved away the "test-results" directory
> (e.g. "test-results.prev").
>
> I think it would be useful if the script part of our tooling was happy
> to accept any name for such a directory, and then examined its contents.

That's not a problem, just pass the directory as an optional argument.

    default_dir=3D"${TEST_OUTPUT_DIRECTORY-.}/test-results/"
    for file in "${1-$default_dir}"/t*-*.counts

> But I don't feel strongly about it, and I don't use aggregate-results.sh
> in particular (I always use "prove").

Yeah, me neither (I also use prove).

--=20
Felipe Contreras
