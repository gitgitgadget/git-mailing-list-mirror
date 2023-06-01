Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CCA1C7EE23
	for <git@archiver.kernel.org>; Thu,  1 Jun 2023 08:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbjFAI7W (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jun 2023 04:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232449AbjFAI7L (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2023 04:59:11 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903B312F
        for <git@vger.kernel.org>; Thu,  1 Jun 2023 01:59:07 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5149e65c218so970641a12.2
        for <git@vger.kernel.org>; Thu, 01 Jun 2023 01:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685609946; x=1688201946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KYGUImrTgG+7gTXpyOWy3cKkv+JTFnBnImH5chrlW7s=;
        b=r90BNQwOp6S7cMXPyDAh2x3xlfC3j87bZJE/ncZ1W0faG8WfJ4TyijmQxd8FQGgycd
         ZlyRhKjPbwQqGreEdHWtvCvmauPsvEMRuRk55TJ5J2NDnWXwAXLqdo/h8XJrb55JuuA3
         6nnd5CNgsi3VOOcRxhR0jytAh51Mchfss89+XskdQG4no7BtUv3ELNkqITn5IY8ALmQL
         aztUwcJpW5e10kdbRfb3cBwlBj5smFobOq6oxy3l1xyiOLn8oIhOoutUQpAUUMet0ypJ
         5HAPeVtZFcLltfIFT+fLqI2t8G7EDRMbGZ3ON1HkHezs4P7dQGLsnRFSaIIJrWpSjRZC
         /+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685609946; x=1688201946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KYGUImrTgG+7gTXpyOWy3cKkv+JTFnBnImH5chrlW7s=;
        b=bn64zhJiLKbWzhsabDfzdPzVKlFrZ6wnv7NiWqh+M4UkR4ylMvnD05rNB6Vw5zFcnJ
         SMM5cqQoo4d+rQCY3y4HHjl5nFolSc9P9LYPmmFWRahsx4B82B7QVje7ysFBRxOcQJuT
         78Wq3IK21HFx1R7XOrWdzz/iKTdGHA9P8jVBmaeUhyHxDL39IrosAJunWdzOMeNSFGb2
         IvbLhbarrvn+93kAn3VGsiXGlbMsfoRARaDnsoYk69dW9pl5aI783r45WnnRM/8mFxv2
         5w6Og+V1T9r2nx4k/uLdq7Qry/EqLN5WKw39/9WgIMR/eLmhBIoOhCkbgB0jsecLPAxX
         0Juw==
X-Gm-Message-State: AC+VfDzdTM0b3CrfcRZo7Xf8YSekAuhq9yNilFA+UEwDzs4ZaWtIV3V9
        nNajGpNDBw5iePwCi5VICt69ictYYUveIfue66s1RpGT
X-Google-Smtp-Source: ACHHUZ6Q1DPRBsaG+db14xpVaq7YZUQKCchHDDs04jdP1dOFOOwVngy3oI50NLepbFIEqAwmE0u85VKnjd0yQRai1So=
X-Received: by 2002:a05:6402:1517:b0:510:f462:fc47 with SMTP id
 f23-20020a056402151700b00510f462fc47mr4767138edw.7.1685609945729; Thu, 01 Jun
 2023 01:59:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230529192209.17747-1-five231003@gmail.com> <20230529192209.17747-3-five231003@gmail.com>
In-Reply-To: <20230529192209.17747-3-five231003@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 1 Jun 2023 10:58:53 +0200
Message-ID: <CAP8UFD0zQoc9zgMLdxNavMmPyjk5Orp1PDx5gpDEyuv5sv7h8w@mail.gmail.com>
Subject: Re: [PATCH 2/2] ref-filter: add new "signature" atom
To:     Kousik Sanagavarapu <five231003@gmail.com>
Cc:     git@vger.kernel.org, Hariom Verma <hariom18599@gmail.com>,
        Jaydeep Das <jaydeepjd.8914@gmail.com>,
        Nsengiyumva Wilberforce <nsengiyumvawilberforce@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 29, 2023 at 9:23=E2=80=AFPM Kousik Sanagavarapu
<five231003@gmail.com> wrote:

> +test_expect_success GPG 'setup: signature gpg' '

Maybe something like "setup: sign some commits using gpg" or "setup
for signature atom using gpg" would be a bit clearer.

> +test_expect_success GPGSSH 'setup: signature ssh' '

Here also something like "setup: sign some commits using ssh" or
"setup for signature atom using ssh" would be a bit clearer.

> +       test_config gpg.format ssh &&
> +       test_config user.signingkey "${GPGSSH_KEY_PRIMARY}" &&

I wonder if this test should try to clean up the config a bit after
itself. The previous test used:

`test_when_finished "test_unconfig commit.gpgSign"`

and maybe this one could do something similar.

> +       echo "8" >file &&
> +       test_tick &&
> +       git commit -a -S -m "file: 8" &&
> +       git tag eighth-signed-ssh
> +'
> +
> +test_expect_success GPG2 'bare signature atom' '
> +       git verify-commit first-signed 2>out.raw &&
> +       grep -Ev "checking the trustdb|PGP trust model" out.raw >out &&
> +       head -3 out >expect &&
> +       tail -1 out >>expect &&
> +       echo "" >>expect &&

`echo >>expect` is more common to add a new line.

> +       git for-each-ref refs/tags/first-signed \
> +               --format=3D"%(signature)" >actual &&
> +       test_cmp expect actual
> +'
