Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D0BC0015E
	for <git@archiver.kernel.org>; Thu, 13 Jul 2023 21:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234241AbjGMVoc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jul 2023 17:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232955AbjGMVob (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2023 17:44:31 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC83B4
        for <git@vger.kernel.org>; Thu, 13 Jul 2023 14:44:30 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-51bece5d935so1424648a12.1
        for <git@vger.kernel.org>; Thu, 13 Jul 2023 14:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689284669; x=1691876669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RVtArw1KUStQc4UcUJGE6J7CHru44OA0HmiCqCOx/yA=;
        b=YOcMxW0F6cWqxR72l4DqYbUBi/TPC0sCj7746PDC46+9/fzn1b1BRFTWF/ItgKDOAH
         FDe2ZWbNBWbcRDuCubMjntAYAZI6os0qRtZhaOsvVQnKMoS9PDxrAPhKQBJ3Q2raQ8tb
         SzS7tc8yYVAOKrz5SWhTRPASsfPM5HDaCgyiBfCZTvgr8z02C+jvVZzsvEjFYjwpVTE+
         iTSnCizWv7cTB5g/z9dir8uf5mFq1tgsTVZsHikiycG6IX8qwmOGnphkpfbDTxeC0xSw
         o4F6kgsW1HV7Y3YogGwGHVDP9nGLxyB1+zxKCJ3tPsSnjdixvUCPWCeR5Q7iU23rPu3k
         dESQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689284669; x=1691876669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RVtArw1KUStQc4UcUJGE6J7CHru44OA0HmiCqCOx/yA=;
        b=KJzyN82X2s2RDdDB8CrMVltclBH09oUTnxB80h5ji0bJ611yaXH7Xa9s6ec8LnJMy5
         4KDDTiVmrh3viKfrrVyRGYKSLXyqeVegQLJmSdDwUchnNLBuCs1nkQFwl4v44sFh7hit
         2XvJWND15J1iexpsKgBgXSmhLLft9Bk7FLleVOQ5VmvEzeDfM2syvS2bRCqXW1E18UKy
         +15G2OtPZzDSoE8BPw118hp5VNDt0Nuqahc/5pe4/Vw79eAgSJ2niesfFP7kOtuUECiq
         DrOw9Tan/8UxC/7n+D1OBExOopMC4utMaSg7rn+BOYaaVdLDpk62ZgDwsz9AaFeLhRV2
         9A/w==
X-Gm-Message-State: ABy/qLYSqK9lABx4GNAx12eRBk80hV9NAej3YPnWNT7Y03cuZ59Nh59j
        8K09JRYVmTD45pZVjlgRXyXHImjKzLtIqYOy1C8=
X-Google-Smtp-Source: APBJJlHN9r1dKHg17N96AC/7RvX2qsPxowBLXh1ynlpb9dkVybG4ZjWixwCJf1uPjevOENM+vxnJ7WSTsRafwy+f3yY=
X-Received: by 2002:a50:ed8e:0:b0:51d:d280:6c51 with SMTP id
 h14-20020a50ed8e000000b0051dd2806c51mr3138729edr.1.1689284669036; Thu, 13 Jul
 2023 14:44:29 -0700 (PDT)
MIME-Version: 1.0
References: <CALnO6CDryTsguLshcQxx97ZxyY42Twu2hC2y1bLOsS-9zbqXMA@mail.gmail.com>
 <CALnO6CCc-J+fe9qKaoyYUMM3xMEUnV5w7NKWSbn6xTgEjbac5w@mail.gmail.com>
 <xmqqfs5ro8v7.fsf@gitster.g> <CAPig+cQvr-HuJBQsjt0jW0G95SmyzTc74R6JiznNeKbHmfu9PQ@mail.gmail.com>
In-Reply-To: <CAPig+cQvr-HuJBQsjt0jW0G95SmyzTc74R6JiznNeKbHmfu9PQ@mail.gmail.com>
From:   "D. Ben Knoble" <ben.knoble@gmail.com>
Date:   Thu, 13 Jul 2023 17:44:18 -0400
Message-ID: <CALnO6CAFC23b2NYCsfcuuR3cHnLy2vm_vZbjDEEBP+nDFurXSw@mail.gmail.com>
Subject: Re: t2400 on freebsd12
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 13, 2023 at 4:43=E2=80=AFPM Eric Sunshine <sunshine@sunshineco.=
com> wrote:
> > By the way, is this really "blocking" use of GGG in any way?  I do
> > recall seeing messages regarding gitk from Jens Lidestrom that are
> > shown in https://github.com/gitgitgadget/git/pull/1551 but the CI
> > run report at the end of that page does have a failing CirrusCI.
>
> Failed CI doesn't block GGG (at least not last time I used it). You
> can "/submit" the pull request to the Git mailing list even if CI
> failed or is not yet finished running.

Hm, I thought I recalled that it did, but I will try again. Thanks for
the attention.

--=20
D. Ben Knoble
