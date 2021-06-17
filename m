Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD3AC2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2CD16109D
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbhFQKE7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 06:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbhFQKE6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 06:04:58 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBD7C061574
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:02:51 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id k5so2439359iow.12
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uyE6QZdr9E2hZKDOSIhOSm9f+mR5+ZgPEd8WWlhhUY4=;
        b=CIy4jL/BOrGuy41G/uLx/LMLet790aCmEDdgubdbZ1li6/e83M8lByqUjeXENYlO/E
         jFu+rGRAt1C1Ugx3B5OSRbbfspULO0y5Cl/bMAsgU21aUFpBanciT2sXZf6b7HgNIq+E
         zWkoJIwBVDz7Km6iKw7MFiE0dtEZGQkhd83wfISbfPKc9yf0ixLbO/tffebGoLvM0hix
         FbY5lUMabkwNo8BDKtRe5pyD6JyaRcm4lxq9tpCg6FCNeT1l69DXsC6AW+AmRSWZwAhc
         astGkEDFiv1M12dqtOgklshfC1t6OXaOZE5Zk0Z+KGxTNkehGfEfxyfigAvWj4bSSwNR
         XPjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uyE6QZdr9E2hZKDOSIhOSm9f+mR5+ZgPEd8WWlhhUY4=;
        b=p3QD1imLmBNjNqppR0TPVzI0bF/0zwt/GK7Rqdj+/O66aaS7jUXp/Xyl69Rf7qukPE
         q+kNcIAHrRcZw6GQ5FFRauoozS8lWJw1SoYswCpX/tfpF1oc+AyPyDXsDQdXtBLKrWO/
         iY3OGRXQ3czdBg36LsZjRe9iZxrOpMr6rhN3abbMBr0pPhHlCmTBJfxdGpkw0cZa3KwM
         K7WxTJcVDR/Ms+gERngTD1Xq9fEet2ztEq3E/wy8vWk6d66xOMXZosNEGwNuQS3kM25L
         uaxIVXuVcVAKLnxujTt1m68WKfKmMJ3HXGFwIRjshRnQpO6LIFstoBP96kdVfWH5dfwu
         vNtw==
X-Gm-Message-State: AOAM533OAZ5/iUNAxWTvLOcfPvCEpSisxeSzKS0l25N1tC3kecCYuWsL
        9Ban0zXFF7lcwGUepFj3O0zVHSK8QvBVWBsmNz0=
X-Google-Smtp-Source: ABdhPJwb7+EJxuSP39f8bef+SzgMmhWMq1Kb1+ZnavODbBlOT9W3oQYIzYDO8zp7/k97qs3JsEf7K927TreQ7HM/d4I=
X-Received: by 2002:a05:6638:144a:: with SMTP id l10mr3879328jad.50.1623924170988;
 Thu, 17 Jun 2021 03:02:50 -0700 (PDT)
MIME-Version: 1.0
References: <pull.980.git.1623496458.gitgitgadget@gmail.com>
 <pull.980.v2.git.1623763746.gitgitgadget@gmail.com> <87tulxvtm4.fsf@evledraar.gmail.com>
In-Reply-To: <87tulxvtm4.fsf@evledraar.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 17 Jun 2021 18:02:39 +0800
Message-ID: <CAOLTT8Rm0PonXyn_wFqC1ommUpAd_MwO30gGrxsuEBR179qyEw@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] [GSOC][RFC] cat-file: reuse ref-filter logic
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> =E4=BA=8E2021=E5=
=B9=B46=E6=9C=8817=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=883:27=E5=86=
=99=E9=81=93=EF=BC=9A
>
>
> On Tue, Jun 15 2021, ZheNing Hu via GitGitGadget wrote:
>
> > This patch series make cat-file reuse ref-filter logic, which based on
> > 5a5b5f78 ([GSOC] ref-filter: add %(rest) atom)
> >
> > Change from last version:
> >
> >  1. Use free_array_item_internal() to solve the memory leak problem.
> >  2. Change commit message of ([GSOC] ref-filter: teach get_object() ret=
urn
> >     useful value).
>
> I left some comments, but saw after the fact that I'd replied to the v1
> E-Mails by accident, but anyway, the comments were all on things that
> are also in v2, so it worked out in the end. Sorry about the confusion.

It's okay. Your comments are very useful.

Thanks.
--
ZheNing Hu
