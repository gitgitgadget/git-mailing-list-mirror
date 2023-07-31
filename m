Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86844C001DE
	for <git@archiver.kernel.org>; Mon, 31 Jul 2023 17:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjGaRqh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jul 2023 13:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjGaRqg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2023 13:46:36 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D079109
        for <git@vger.kernel.org>; Mon, 31 Jul 2023 10:46:32 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-98dfb3f9af6so771789166b.2
        for <git@vger.kernel.org>; Mon, 31 Jul 2023 10:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690825590; x=1691430390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y3kghFADKVVDT/x6lGG4NbGBjyfQuymzZE2efMu0ikc=;
        b=VzF3MJdKtBgznHaEN6bppdNTIWJXEOG374ShBRE0XrpWy65PeYGOcOB2+7sX0a79m9
         3DdvnQ2JoaZmA0txkAtJ2d1NhlmsVWM4W1VkZ/cw+I4MXXxP4B0FOi/DD3B0rgkJbaBc
         iGuCDiWJ6Lr662ARAL1DxD4LGjSWra3JFL4dTSov1Jnvm4WmuyHmtQQ4FnfA1cAiE7lQ
         Z2acGq0nEqZg7V39CvBFffE3tqQ1Uaa8TUB03FHdYv+y/ZF1aJPV7s8uVTj9HodkLX9t
         MB0f7bxMX4fJi1WFq6NoRfWR/7gCWbTOWAE3W22Ui+JlMqNye0BgOQhZSjwapLsRlv4W
         Z3/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690825590; x=1691430390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y3kghFADKVVDT/x6lGG4NbGBjyfQuymzZE2efMu0ikc=;
        b=AuheiVGYSbLNHbhUF1I/ACeJ5LCpP6LVLIyyzXaVZkNo9e7TW1nxfkDQdVn0MibrAG
         9pJtayTtn54ReNg/w3CpjFm+PF+ctVcIDrw2AH1+bou6UXtKjHB5a3r/wnvwn+kBfxtW
         TGBgiea1iEKNr8kL1oRh6H/UjMuSPDz86JZbsvcjn7rMmg313z6gWfc0cOx9kwgJ0/sT
         zN0ruOiZjQnS5MTWNGritAY7CNZySZbLG/IJW3qAhyIEcn4gE612i+ApLjTdp8D70lT0
         L0fGhcS7D8xsOeyp18LnaahL2whzpDxYBXmva6HghJZrE5MeSVVnSfa0+zHZe7dCfdD5
         ZJnA==
X-Gm-Message-State: ABy/qLZPHvImFV8GR/kyTzYKLQZ0xCz8KhfMLW4YnUHiGfaH88QCe+Zi
        U5IU+cL3BD0+wmq5wEdvrB2MtG+eyJDpUqGVyeFfIQ==
X-Google-Smtp-Source: APBJJlFVnl9Ha3FjXhD14qZHIFRq6GkoKBfDhJDIbLMvOJEk1g9Az17X0/tJh4cgmd9J4fzAP6QL8JIaSYWFerNUjNU=
X-Received: by 2002:a17:906:29a:b0:992:91ce:4508 with SMTP id
 26-20020a170906029a00b0099291ce4508mr395505ejf.53.1690825590423; Mon, 31 Jul
 2023 10:46:30 -0700 (PDT)
MIME-Version: 1.0
References: <858rfnb770.fsf@gmail.com> <ZBy18EBE7WM/E4KF@nand.local>
 <851qlfazzp.fsf@gmail.com> <CAPOJW5x+yQsPxdwCWMT9AkMQhJyxKp5BiPXp_1PT6WwF7yF4YQ@mail.gmail.com>
 <85tty8afvy.fsf@gmail.com>
In-Reply-To: <85tty8afvy.fsf@gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 31 Jul 2023 19:46:18 +0200
Message-ID: <CAFQ2z_P2HkT8grAFk=6Mr05rJRfsh_sXypVFPyHr0v5xkcjYTA@mail.gmail.com>
Subject: Re: What is the status of GSoC 2022 work on making Git use roaring bitmaps?
To:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 25, 2023 at 6:40=E2=80=AFPM Jakub Nar=C4=99bski <jnareb@gmail.c=
om> wrote:
> >>> Abhradeep promised[1] that he'd include some performance work in his
> >>> next version of that series. I think the main things we'd be interest=
ed
> >>> in are:
> >>>
> >>>   - Does using Roaring provide a file-size advantage over
> >>>     EWAH-compressed bitmaps?

I modified JGit to write Roaring bitmaps instead of EWAH bitmaps. The
resulting difference in file sizes are small, and actually favor EWAH:

$ ls -l {ewah-repos,roaring-repos}/*.git/objects/pack/*.bitmap
-r--r----- 1 hanwen primarygroup 26257386 Jul 31 15:04
ewah-repos/android-pfb.git/objects/pack/pack-b14c35ec7fc3bb20884abe51a81c83=
2be5983fdc.bitmap
-r--r----- 1 hanwen primarygroup 27621579 Jul 31 15:20
roaring-repos/android-pfb.git/objects/pack/pack-b14c35ec7fc3bb20884abe51a81=
c832be5983fdc.bitmap

-r--r----- 1 hanwen primarygroup  1037356 Jul 31 14:46
ewah-repos/gerrit.git/objects/pack/pack-fe46c7f96a2910f5775a2ff3bef7e4fa0e7=
79f91.bitmap
-r--r----- 1 hanwen primarygroup  1242608 Jul 31 14:45
roaring-repos/gerrit.git/objects/pack/pack-fe46c7f96a2910f5775a2ff3bef7e4fa=
0e779f91.bitmap

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
