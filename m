Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20AAC433B4
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 09:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99D25613B4
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 09:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235101AbhD0JmP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 05:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbhD0JmP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 05:42:15 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152ADC061574
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 02:41:31 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id a12so14694588uak.6
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 02:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FyihtsdO5RGXQP6Wfm0yxDwGB2T5q6MBb7+zCakcAT4=;
        b=g4pwZfX+jqkRhfHYvB1nLiCvzf/u5V8SzO8aMqQrL0mmlBnmSR+4EzAXhZmR2FTVX0
         jobgnT2ocagOBz1EGQ0y3ZX5IhAKpqcSiodh1yIHv1KPfEJ6WQW9QDnJ15wy9Ti5+6RK
         shOZMLoC3PtP8tyaZsvrIjUfCuFSIAgmIVX3dbx8r8EVNVyvSXq7DsS0s3t8SIXhMIwz
         Edvgzx75ZxSsx+jMIJ/ZOUk1Yf2lrld+u2WJ02W/Jf46nOdyfCFeIbVV2OZ5u7kft91e
         pybTeXOXXHP14GuH9v7YYJA6cuABoLnSgKLmR+M5KaJmqdSF3c7SY6CDX0xDQc9O6NfE
         HttA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FyihtsdO5RGXQP6Wfm0yxDwGB2T5q6MBb7+zCakcAT4=;
        b=ownc6yA7mhIhvxp4M3aufL7dHQPu/aw5AYtkqRRiDlE46kQDgKoVXQcVelA546Egzs
         GPrh9WwkS8dNTgZJ4trXGBLOMDlasZ8kniAP7h0p6RwEkQsd1pPpnyvROJVkxTHETRWz
         fC9V95dlAqnYxXSmKMrLlpJOLQ2LlhtnRFuptIow1XIGRdPs9Y9FFtWnK5XRjLkUsPyp
         aXYF4c+9GCu7Lhswwzt5h549VqDidjTv8UHaNlehIKDH6u8/I8C7oiqgy14oC5888OBD
         gezbW/Ab2Wcci8qhT7W9zwuXGdRI0cKAM5qdLODF1pI9X6vM0P+mqD299FPrPFaGhAtj
         lSuQ==
X-Gm-Message-State: AOAM531VwfU3YrmbNlb+c1+WgQpWMyD4dHc7/dNFY3AAs4gMqqvgL7hB
        lMrDQXiAbsvqvORNPKFPk3l4kO1xhGaD/2QkElaPiQ==
X-Google-Smtp-Source: ABdhPJxT3dqPBbADdRx3j86FYOr4BKaWFNVkbe+yxZaNwtyZDT2OHR7ZYsXpjG1raBNTU8jmKfmcyaXzrviWhl7yagQ=
X-Received: by 2002:ab0:6398:: with SMTP id y24mr841284uao.112.1619516490172;
 Tue, 27 Apr 2021 02:41:30 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
 <2b3021c4ba626033cde3b28dda7e5a83b85be2b1.1618829583.git.gitgitgadget@gmail.com>
 <87k0ow3yvq.fsf@evledraar.gmail.com>
In-Reply-To: <87k0ow3yvq.fsf@evledraar.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 27 Apr 2021 11:41:18 +0200
Message-ID: <CAFQ2z_O=aHW=fwwdCmyN-bMeuwBeLM_pLBNr7xhjP+M7e=k70g@mail.gmail.com>
Subject: Re: [PATCH 15/18] t7900: mark pack-refs tests as REFFILES
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 21, 2021 at 9:00 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> Re [1] maybe this is ok/fine for now, but I think we should really split
> out the "is specific to file" part more narrowly (not just here, but in
> general).
>
> E.g. I assume that "pack-refs" is simply redundant under reftable, no?


I've expanded on the commit message to clarify this.

> Should the current behavior documented in
> Documentation/git-maintenance.txt change with your series under reftable
> etc?

No, not for now. Once the reftable support is landed, we could update
the docs to not talk about loose vs packed refs, but that seems
premature at the moment.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
