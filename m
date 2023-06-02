Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89DCFC7EE24
	for <git@archiver.kernel.org>; Fri,  2 Jun 2023 07:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233850AbjFBHvP convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 2 Jun 2023 03:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbjFBHvO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 03:51:14 -0400
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB6F13E
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 00:51:13 -0700 (PDT)
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6261367d2f1so16315776d6.3
        for <git@vger.kernel.org>; Fri, 02 Jun 2023 00:51:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685692272; x=1688284272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=htRBUfphaXNcGGFcdXGvYIDfnL8lrIdSW3CImSqzmGA=;
        b=AptUmZqWH2Es87j86wKI4Y0jCdRAI3GX0yyGS13+TmfxVugzYGuvWgywJBKXBfPvXS
         8aCoBccxHPz9fEzjlxGJUVtfozcmevSkPPo1C2fE1Magli8D9KgjgWLKpm6qAeMV+R8r
         8BHNcmbm98YWZ8nJyIfhDcfvcTk72rrU9DM2GPnwuTcYC9JRDLdvdRJ0awCdebVjAX0P
         7ZkYpylmvHHad+7+ClTLND+rXMmMv3YoxmT8pJ3oZlWQI+H8w2aVIheODQmy7D0WNPjz
         ZP6YVGmxKaFXsdHSSinfjcDy2Tj6F51nvVFNY1KkwG6xsqcV6iC2lKowfC12bwRRi6YN
         ugXg==
X-Gm-Message-State: AC+VfDxL0jX2WhxMFLaAoqak0+jyMa+c4KyKLiOGDakXSDr/xsHHOZKc
        KjIqyZm3R+4Tsuq28pLar3fesbQqunhwXQ9rvhlA1bnVXek=
X-Google-Smtp-Source: ACHHUZ6HvD/d8SNUHhEBZJ4x4sPHXY/+FlVwvTKWYLqTs3WJyS4IcbA+h5AIf/QFPeQ2M/XQdAO8jGnIOk3Sqy8NbAM=
X-Received: by 2002:a05:6214:f0c:b0:625:aa48:fb72 with SMTP id
 gw12-20020a0562140f0c00b00625aa48fb72mr13879225qvb.60.1685692272412; Fri, 02
 Jun 2023 00:51:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230529192209.17747-1-five231003@gmail.com> <20230602023105.17979-1-five231003@gmail.com>
 <xmqqzg5i8gpt.fsf@gitster.g>
In-Reply-To: <xmqqzg5i8gpt.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 2 Jun 2023 03:51:01 -0400
Message-ID: <CAPig+cRmY3oDJLVKsBgKVZc-bJ7hArzk2eib9Ra5timC=Xz_kA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Add new "signature" atom
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kousik Sanagavarapu <five231003@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 2, 2023 at 3:33 AM Junio C Hamano <gitster@pobox.com> wrote:
> Kousik Sanagavarapu <five231003@gmail.com> writes:
> > I have also rebased this to be on top of v2.41.0, the previous version
> > was on top of v2.41.0-rc0.
>
> I am still feverish and feeling weak so no real review from me yet,
> but there is one thing that immediately jumped at me.
>
> > 1:  5c97d11b79 ! 1:  87465ef1a8 t/lib-gpg: introduce new prereq GPG2
> >     @@ t/lib-gpg.sh: test_lazy_prereq GPG '
> >      +  test $? != 127 || exit 1
> >      +
> >      +  case "$gpg_version" in
> >     -+  !"gpg (GnuPG) 2."*)
> >     ++  "gpg (GnuPG) 0."* | "gpg (GnuPG) 1.*")
>
> The last '*' being inside double-quote would not be what you
> intended, I suspect?

I noticed that, as well, when running my eye over the range-diff.
Moreover, I wondered if using `[01]` to avoid the repetition would be
worthwhile:

    case "$gpg_version" in
    "gpg (GnuPG) "[01].*)

though, of course, it's subjective whether that is clearer.
