Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5CFC433EF
	for <git@archiver.kernel.org>; Tue,  5 Apr 2022 08:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbiDEIEW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Apr 2022 04:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235612AbiDEH7x (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Apr 2022 03:59:53 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA1D17E07
        for <git@vger.kernel.org>; Tue,  5 Apr 2022 00:56:10 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id 125so14194713iov.10
        for <git@vger.kernel.org>; Tue, 05 Apr 2022 00:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vJiC7IPqCwBwsedFMGXM0mPvNc/k6Qq2qX/yNlQBW84=;
        b=DGblxN2C+MbTD3LXGlbJl3eJJnHzDw2jNJtoSWTXOZGSjJjEMW5NEtv64EfRlDQN7+
         dNOy/k6QHS6ALmw329W+Tgvs8R6eFpo2800Cl4lgp+mCsJb2rVw8Kl/qI6kOTSq1zGXi
         03Gvd2+lehSfc74hb9gma/5Kfom1JVmcZrckDFY4qjEPQpXeWTlmisRnVwor56Y0l6/O
         mKCP86O3SX6UNUsAPDmA2mqJhrNOlo+O82oRC4loX6z6kaMDgOwwr/5lB6I0HOFlwko9
         GEz6iTuNhvqEnHh+9EfHSO3W/pimBWi/0NEtOjL8D+r/9EnaY0rqtCWsAW8ywwOC88Zq
         Pqew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vJiC7IPqCwBwsedFMGXM0mPvNc/k6Qq2qX/yNlQBW84=;
        b=bfwwOKfIVyWWjcF6H8UB9j9BTXyzpsLMtLBP0POX1ysop9XZljLK8wKx+fx+YWaEm6
         eJBmmF2tkxHsAsmOyUsGaGhM2Kuh1nLr9asD+m3EMKdKts0mNVpuVZY0lxz/qRli6c8h
         bmRQ28fZ2GQMmesbaFgwU2T6rK4j0TGKzB4eCQ3O41cLL6yvfZEv7Jv0lj2oxf3CxN4j
         C5oFtC6frx7Mf4EF6nr7+RlIK+MrYxYg71qCIwk2Hr8e/npMiFHNLdvf43q/MgEwdWnN
         S0SZBCyA+CAm1kydrrVIQ+RUcT/EBLgA/GakW/+Fv5K0eftAgLxqdexUvgSBVOE29nMJ
         ff5g==
X-Gm-Message-State: AOAM530qC7aRApgywjgxC1jYm3zlwrmbNSWx62ht90cQGsL6nPRK3dFn
        xuDJ61jt8lYjvyx+xFllc1+uCyJNJSmgrLveGnW8Vapsfq8=
X-Google-Smtp-Source: ABdhPJzfaaHqyXU1WpWfDbbvV/+OCcpMVnOnTT363noWDn9qWSu9v+f9HxIrT4MAb60ttG0eLx/VxYCGVjts5LbW514=
X-Received: by 2002:a05:6638:1384:b0:323:a81f:666a with SMTP id
 w4-20020a056638138400b00323a81f666amr1346665jad.39.1649145370106; Tue, 05 Apr
 2022 00:56:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220404182129.33992-1-eantoranz@gmail.com> <b2f5d6af-8da1-3a3a-cc21-848c14a8fb98@gmail.com>
 <220405.86wng4km5c.gmgdl@evledraar.gmail.com>
In-Reply-To: <220405.86wng4km5c.gmgdl@evledraar.gmail.com>
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
Date:   Tue, 5 Apr 2022 09:55:59 +0200
Message-ID: <CAOc6etYOHeiLU_u-WxEiZSszXRHfn6h32dcXHQtEQqu=d-87hQ@mail.gmail.com>
Subject: Re: [PATCH v2] blame: report correct number of lines in progress when
 using ranges
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, whydoubt@gmail.com,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 5, 2022 at 9:46 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
>
>
> Nothing should be using test_i18ngrep nowadays, just grep is better. We
> no longer test with the gettext "poison" mode which necessitated it.

Taking a closer look at the already defined tests/files. Thank you all
for your feedback.
