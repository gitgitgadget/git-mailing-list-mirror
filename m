Return-Path: <SRS0=ylBF=6D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C916C38A30
	for <git@archiver.kernel.org>; Sun, 19 Apr 2020 12:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4399A214AF
	for <git@archiver.kernel.org>; Sun, 19 Apr 2020 12:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5CDnE33"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbgDSMZy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Apr 2020 08:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725990AbgDSMZx (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 19 Apr 2020 08:25:53 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E18C061A0C
        for <git@vger.kernel.org>; Sun, 19 Apr 2020 05:25:53 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id j65so4149314vsd.12
        for <git@vger.kernel.org>; Sun, 19 Apr 2020 05:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hX9f4mgPdv4koOpql9208jKWaQam+24X8L3JT/aFZ7Y=;
        b=c5CDnE33u9ZlCNPrY6VDxxxQmT2SBdfdeCr3fc9J2fpyONQ7GAGFR/PXqcmonoO9Cb
         0uHRYJvyTdUHZ4LLF7v3drdrp9br78N18x/K5t3dFlU/V+ZexZ58cWOnVNGOWwe/GioY
         GXBZPbcfIdF4Js8WDBVVlKU0JPS3tZLr/mqPjtCEycFuP8i53UaKoTvu5QrVen9eGfZt
         Vr39sG04pM++aE7k1E5xPk3bCyFKAk1EIdK5Fn6GtB/MOhp0mI1kAyZF22ry+1aocQjZ
         5dP144HYrVrBp6LSDUiWzNaCySUFkLk8ldW63xVY5458+ZBA1ZSrpkLafMViJLEXkgcc
         vbeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hX9f4mgPdv4koOpql9208jKWaQam+24X8L3JT/aFZ7Y=;
        b=Q22ISUhqkfTaO1oCluV7rYa9nrqzh5s5LdaCj3DqfYTUtXaH7mfZrgv0/CxBSGc1tN
         s3XYgCxvi7kF3N8uzgIykb6Iq1vZ/ApA3BKUHwJk6Td+4+GT5ZrWigABOR2+afiFpKmz
         DUSNpH2Ffgs8Zx/c3dHN1hsO0xLDNE4myYo+BFjGItDQcEt03aIxvB1hplJoDw/daiuJ
         kSdyyEeIvYAujTdyue3m+tneYg0Dz/tUFmiLUahay6ZTuCjHSlz1QEJKUn7xQ7i5H1eo
         51iskJlLdkcH/XUDeyW8EgGLCSrgHg7bRFES9ktEOSeJrhMRaCR1uF2dwozVHg+orDA4
         x8Kg==
X-Gm-Message-State: AGi0PuZI2VHSmxp8jU68nNQho8mfctcT/OJ9sTES+22j4K3OLU2PAz+v
        iDn3ugVGsrTGYofDlkr5DKhEv0B41Kli9EuOX/U=
X-Google-Smtp-Source: APiQypLl/KTBoZXikJW2qb1oLn1q8KJCFHptxaTuA2gMdszY+EYBK+xe1lATjyxF96BU70b/FBVM8eEJgyMuFZSbUlU=
X-Received: by 2002:a67:fb4c:: with SMTP id e12mr7307807vsr.79.1587299152849;
 Sun, 19 Apr 2020 05:25:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200418035449.9450-1-congdanhqx@gmail.com> <cover.1587289680.git.congdanhqx@gmail.com>
 <d1bc31e692d08d73bc577f737b0190e163440ee9.1587289680.git.congdanhqx@gmail.com>
In-Reply-To: <d1bc31e692d08d73bc577f737b0190e163440ee9.1587289680.git.congdanhqx@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sun, 19 Apr 2020 14:25:41 +0200
Message-ID: <CAN0heSqnKfepx1c-7Exy1bj3_p_JdAuBLyt5WtkwZCSkOuroMg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] t4254: merge 2 steps of a single test
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 19 Apr 2020 at 13:03, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <c=
ongdanhqx@gmail.com> wrote:
>  #   fatal: unable to write file '(null)' mode 100644: Bad address
>  # Also, it had the unwanted side-effect of deleting f.

(This comment looks a bit unnecessary, but that's not new.)

>  test_expect_success 'try to apply corrupted patch' '
> -       test_must_fail git -c advice.amWorkDir=3Dfalse am bad-patch.diff =
2>actual
> -'
> -
> -test_expect_success 'compare diagnostic; ensure file is still here' '
> +       test_when_finished "git am --abort" &&
> +       test_must_fail git -c advice.amWorkDir=3Dfalse am bad-patch.diff =
2>actual &&
>         echo "error: git diff header lacks filename information (line 4)"=
 >expected &&
>         test_path_is_file f &&
>         test_i18ncmp expected actual

Makes sense. The first mini-test used to just set up "actual" and there
was only one test using it, so it's hard to argue it was a "setup"
phase. This looks better.


Martin
