Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC6F1C77B61
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 18:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244586AbjD0Sio (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 14:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244587AbjD0Sim (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 14:38:42 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC3E49D8
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 11:38:41 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-3ef34c49cb9so796501cf.1
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 11:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682620720; x=1685212720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v1IOghCIl6aWsN5ExgxK6j1RDxS3VtprDtaNb6EMWJM=;
        b=q4HaPtGReesjtZlDsb7TJPnbX1Qb6HlA3u8Bt4RmoxEImz8I7Ozf7lolmObzU0NoWD
         ceb6u/9wHVrwq2dwTOQyLvOh6G2uKdQWrwiVNf2sCdgUvo+7S0Spe0u7QOsLOKR1xV4y
         VZ0fc/m+45P6tf4as85ie21DDjxeOdNZgVk4zellEAn1YfgzvZDTfdzkPBE+CMoHtocv
         ie04kXFtUoHEk38+U0WNq6ue3vkY3YpHILqYNWJiq27Hs40F6mMNww3XdHhOwYzicexp
         uAXD//C44J1TWUYE/Ar55HHQvwPD0ExVKSf9pBbO+M07hQgoqXUr4sKLbIAt9VWew49X
         lmtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682620720; x=1685212720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v1IOghCIl6aWsN5ExgxK6j1RDxS3VtprDtaNb6EMWJM=;
        b=SuUN/+hFNqkxRIe753PcbmXE12sAhZk+mG7bbYdawPW9IfmRPD0rDz879NduYU/gnZ
         7SndlR29Mua4TboYFll2Qx7zLztqWzXhQ1tNpOFmZKRTsl6PywrpR6SpMBd5X/lsMKiu
         1UVgV16inTVUVuZcLrL6qYiuBRx9Ogji97r73XBUjWX42lHxywYhe+owvW8W7esRw6LV
         YoBtdueHuigmokRd93cWxDiQu4eJtPOn0PWwpfNnbRjSexj+YfARXktMkZ2o6nlZLx4M
         9DqYQfcEm1SKmWOTBFmyxXPYY5R1u/8r7uAf9ESEouFjR2GF12n2R3Y23FZufjN1OUl5
         SqhA==
X-Gm-Message-State: AC+VfDyz6lFotya+NFPk8UeNPyp/w66+Swta4PYvsOnJZtg/+kwHO1EN
        QZK//Fa48lK7Pq4q/z9NW9fP4rx0EdrfVEgLt9GVnKpQ05jtD5mSVtQ=
X-Google-Smtp-Source: ACHHUZ77ggwZy0ODnHW4d3rM+p75IL/zboFAXVWzQUyWa2MWgCnXDyHNoZT2etfkuZzSXsfYIx8YGv1gcHS2fL+DBBs=
X-Received: by 2002:ac8:5ac3:0:b0:3bf:e4e0:26a0 with SMTP id
 d3-20020ac85ac3000000b003bfe4e026a0mr31837qtd.14.1682620720068; Thu, 27 Apr
 2023 11:38:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230427175007.902278-1-calvinwan@google.com> <20230427175007.902278-2-calvinwan@google.com>
 <20230427182918.GC3271@szeder.dev>
In-Reply-To: <20230427182918.GC3271@szeder.dev>
From:   Calvin Wan <calvinwan@google.com>
Date:   Thu, 27 Apr 2023 11:38:29 -0700
Message-ID: <CAFySSZDSn1dETchvDjtFGaWZ7MrZeu_2iQZ9eR4Gd0+6SF-vUw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] Add C TAP harness
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As an RFC, I didn't intend for this patch series to be taken as is.
The commits are intended as proof of concept to help readers visualize
what I am describing in the cover letter. If the general idea of
having a testing library for unit tests is acceptable, then I plan on
rerolling it as an actual series.

On Thu, Apr 27, 2023 at 11:29=E2=80=AFAM SZEDER G=C3=A1bor <szeder.dev@gmai=
l.com> wrote:
>
> On Thu, Apr 27, 2023 at 05:50:06PM +0000, Calvin Wan wrote:
> > Introduces the C TAP harness from https://github.com/rra/c-tap-harness/
> >
> > There is also more complete documentation at
> > https://www.eyrie.org/~eagle/software/c-tap-harness/
> >
> > Signed-off-by: Calvin Wan <calvinwan@google.com>
>
> Why?
>
> Please remember that the justification of a change belongs to the
> commit message and that the contents of the cover letter will not be
> included in the history.
>
