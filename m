Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52916C77B73
	for <git@archiver.kernel.org>; Mon,  5 Jun 2023 07:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjFEHMz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jun 2023 03:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbjFEHMh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2023 03:12:37 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A6218E
        for <git@vger.kernel.org>; Mon,  5 Jun 2023 00:12:01 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-51478f6106cso6823837a12.1
        for <git@vger.kernel.org>; Mon, 05 Jun 2023 00:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685949114; x=1688541114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bP5fseiymYubw+O/bOjnp4qyavw1rImwycgfbtSZZXo=;
        b=gBIVMmXgjP3b0Vuy6JradgK+F/rlRUX06hdS5Okf5NgAthIOdB25eAzKhLLAqZhVsq
         A8VewsiS3RJz6nVO9SlArRzBiShnSfi0j/zf5IglYG2me0tYOA/w+3JYaMTmtsdpS3wj
         iUXSY0B8yMoBQPyJCugcTd0WVRe6LStig2q5lk3IXqqinWKoNDeaEDYSzw+3/0pkt0eG
         ukJeCaXkA7FPw8MYmSsBEAcINOZzpxmcFm9UtJ0gXxThrqKrzb2BT6sS2h+nvA1S9bV2
         oZfauchfwJDrMVz2OA7M3uguXs9dKLiIsNwFnArXsIvNWiLBnFx3K1f18TI5wbnyZupi
         FDxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685949114; x=1688541114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bP5fseiymYubw+O/bOjnp4qyavw1rImwycgfbtSZZXo=;
        b=F+Wwl5Z+TqwxKX9CRdtUjPTlRJxIaq6CRovy69xdKmUOnLRSmRDWmrwphkXQYrEqK3
         R5/eNF/OY0OQLijrlKMNRcQqG2H6HNNep6U4xEj1xTHvQlEeyVE6WHkWj2rh+eR7MqrF
         R8Pt3ECOxxAzFBwscUgOgWYsObqni5M6rWUNTgXnXgG6o/TPRMic55lEApO6bUt69hni
         iYfZiOnCgjAO0xg3EXvPKxwqMZ88EIOj4a3m/wZg/3wtmu2BT8SvHB9fkKBiwqzmtoXD
         zFibIL/bq3basGK+M6gtJAHopPPdfkUwn5bcLGDIIxkqAoTpt01euPc09d8Dxm+3SC3I
         thjA==
X-Gm-Message-State: AC+VfDx7Z4n3vIzdUw8JHoQQx9rwb1z2Ly8rN1TMFxSufI1C0+zM48tj
        QNrvozw5cV19nHIfNM0zqg47srjkkl99Mt2miGc=
X-Google-Smtp-Source: ACHHUZ6xpWKszqKbXGqStG1k1OEIKd7NQjZ6NH3L5sPh5SEx1fPPp2Cflbc4wdmNQiNqwV1pl8i06xnhziYoiJFA558=
X-Received: by 2002:aa7:d155:0:b0:514:9c51:d57f with SMTP id
 r21-20020aa7d155000000b005149c51d57fmr6482710edo.38.1685949114496; Mon, 05
 Jun 2023 00:11:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230509175347.1714141-1-christian.couder@gmail.com>
 <20230602102533.876905-1-christian.couder@gmail.com> <xmqqr0qt724c.fsf@gitster.g>
In-Reply-To: <xmqqr0qt724c.fsf@gitster.g>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 5 Jun 2023 09:11:42 +0200
Message-ID: <CAP8UFD3ATWf5x-xn5F+oFqqj_WHOcqQ_kxjtUDWnfg2U9OT+Hg@mail.gmail.com>
Subject: Re: [PATCH v3 00/15] Introduce new `git replay` command
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 3, 2023 at 3:42=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > # Changes between v2 and v3
> >
> > Thanks to Elijah and Junio for their suggestions on the previous
> > version! The very few and minor changes compared to v2 are:
> >
> > * The patch series was rebased onto master at v2.41.0.
>
> It is good to say this than not to say it, but without "in order to
> ..." it does not help very much.  I was hoping "by rebasing, we can
> avoid unnecessary conflicts with what happened in the upstream in
> the meantime, namely, modify-remove conflict of X is now gone" or
> something like that.

The reason was because v2 had conflicts with a patch series from
Elijah that changed "#include ...". You asked me to squash a small
patch that fixed it, and I did squash it into v3, but I thought it was
safer to also rebase.
