Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C535CD80C1
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 12:48:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbjJJMsq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Oct 2023 08:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbjJJMsp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2023 08:48:45 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A74B9
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 05:48:43 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-991c786369cso936081066b.1
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 05:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696942122; x=1697546922; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xLp6DC4JtrfC65VIJv+zF3VuqJPBUS+HAjep06/FYZ8=;
        b=UvZXfWrNZrUZxqYK4vhV0ZsDDOPJgJGz15QoKWr1ROFiL0m+Zhn0tvF3FCo2FDXHep
         WBikOgRgqD9HiQrzxtHrIMCDjIMHQLLsc4fGd1C1GuxsOz5RgDftr/glbKOSQhqU3BcF
         kbRAVAUZBvf2ZMA/uPXIlCZHZxi29iKH2ND0TU1BRnqfSiMdH895voUd9S6uZrsK1/DV
         RlpA7XGzZ5mXj8ro+ZzbO7DQuETI9oCEwqYfc8rMv6V8r3f8JVeDv15OPGT+GUhA8C5d
         eh6hXiyKj7ZEhbb/ZePkJ4TriEGccJx2C+P80S24LsDJiIeJdcogJXwZV36BvXMnK4s5
         ul+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696942122; x=1697546922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xLp6DC4JtrfC65VIJv+zF3VuqJPBUS+HAjep06/FYZ8=;
        b=Ch6Ia4hwsTYQLlvNKiE0bMmtnuhKQnU2f7N8G4YzmC9OfLu+7cxEmCHSIZkWV0L7V7
         KdqHa55VXtSwH5VCuXh8N+NffdlUnRYbsogPlCw3hMcw7R1fA9lg/Wbk5iCdzbO+GILu
         pXOTFxOYL3TwOqIOi01dvvENBn/rpnjXBATngfolMnqkU3OYW7tP2yAJ+2D3pXlrUbts
         27xkVsuRsUJCAyhsF5UGI6G46gZg4GjZ1MIXu+jaTSSIIqzYuC2oIU90U+ysrRo4PqG/
         5tv6SI+i2YLwb1GIscT74if6OT4nX+NrsnnxLim4y8rQS/bgSOGSVWM/DQ7FmSONGdjc
         pnLQ==
X-Gm-Message-State: AOJu0YzXB5iM7GY6R1r1Wh1U0343emM63sUWtiQV2f8L3k6hvb11EmJG
        y7+M+75BsANyV/ETxg9gzf/Kl4Kf9zCk+3knjYU=
X-Google-Smtp-Source: AGHT+IEtWKxrZ1A/Uv98ubtDVTGEfHZHZb6ZYEs/6lopTiwY2VcugDgZeFMp4TyN3pXbrVpEr3SOZIO941feAvgp658=
X-Received: by 2002:a17:906:109e:b0:9b2:f38d:c44a with SMTP id
 u30-20020a170906109e00b009b2f38dc44amr14253520eju.73.1696942122299; Tue, 10
 Oct 2023 05:48:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230602102533.876905-1-christian.couder@gmail.com>
 <20230907092521.733746-1-christian.couder@gmail.com> <20230907092521.733746-12-christian.couder@gmail.com>
 <owlyo7icl1g3.fsf@fine.c.googlers.com> <owlyledelnnd.fsf@fine.c.googlers.com>
In-Reply-To: <owlyledelnnd.fsf@fine.c.googlers.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 10 Oct 2023 14:48:30 +0200
Message-ID: <CAP8UFD02xcDFeiR3GOqUovcHB6fXPmvrLQ=9QX8ZwNNJUwP6Dw@mail.gmail.com>
Subject: Re: [PATCH v4 11/15] replay: use standard revision ranges
To:     Linus Arver <linusa@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Calvin Wan <calvinwan@google.com>, Toon Claes <toon@iotcl.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 10, 2023 at 5:20=E2=80=AFAM Linus Arver <linusa@google.com> wro=
te:
>
> Linus Arver <linusa@google.com> writes:
>
> >> +update refs/heads/branch1 ${NEW_branch1_HASH} ${OLD_branch1_HASH}
> >> +update refs/heads/branch2 ${NEW_branch2_HASH} ${OLD_branch2_HASH}
> >> +update refs/heads/branch3 ${NEW_branch3_HASH} ${OLD_branch3_HASH}
> >> +------------
> >> +
> >> +This will simultaneously rebase branch1, branch2, and branch3 -- all
> >> +commits they have since base, playing them on top of origin/main.
> >
> > How about
> >
> >     This will rebase the commits in `branch1`, `branch2`, and `branch3`
> >     (excluding those in `base`), preplaying them on top of `origin/main=
`.
>
> Oops, I meant "replaying" not "preplaying". But also, perhaps the
> following is simpler?
>
>     This will replay the commits in `branch1`, `branch2`, and `branch3`
>     (excluding those in `base`), on top of `origin/main`.

Here also I prefer to keep "rebase".
