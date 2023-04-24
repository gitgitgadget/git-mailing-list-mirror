Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96208C77B61
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 19:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbjDXTZM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 15:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbjDXTZL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 15:25:11 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC8AE58
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 12:25:05 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6a5f6349ec3so2076911a34.0
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 12:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682364305; x=1684956305;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j58IDzlwRje/FZhrG1C/B//aOrheWurS/+BBtfnbNnE=;
        b=NDOxZ0+44EqBvFxqwbZIP2K6r9s4+5OeCiHxyIbGCZ4yiRPho/SIxCfggV3zI9Dokn
         RAR5tjN8PjPvNr4Ov8Rx6AqgXw20V64VVLvp9xEe+YK+W6lPFZybm/cesxoY5dkg3KeU
         Se6BfTq5tctps3XvirrYG5l9y5EvRbI2VomNW8RjORRBDjYjIrNfmtlpRHOnsMQVRBuA
         LPNdxNpslDF1Of/9u+st5OHYd/rzPW2R8uAbTjHIXAp8uNTTv50WjjRmwr+fYLyh91Gx
         +2L8loSOdWbVut7v1tZ6Mc0guQmhQHNOb2w3S+ah4Tbp8Dzxt2xatmkzWwgesoGuAR1a
         3wDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682364305; x=1684956305;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j58IDzlwRje/FZhrG1C/B//aOrheWurS/+BBtfnbNnE=;
        b=MKuBEBGtCuK9bhKUT5aS5MgljS3FEKjPWVZza3wj1tAIfinqVx8nYyIgbtRVMnL8D1
         KJw9GeEt6OanpEnqRRxmBg2ROhpNwwUBT6BJNy6NS8ENnbN/1HT4C6EucJB79Q4ehbpj
         R/roVBHq7TJ+pk3deARCF2/80W12Gs73MdHbdTgOQ/H6e/S6c/rW8JIce5zP+5qs+Ux5
         J0FlosPI8x3Z2mBYgzeJXOmObVO1PUm0jz77MIUJfTv8mFS08Tc1wII2oZo2DFBYVB5Y
         PxeoccthfjGcMuL4tzsmYVMNgfVopU15r+TifHRvtQx5Ogm/fPjWN1G1yPaRtthmG+Tx
         w+FQ==
X-Gm-Message-State: AAQBX9dflWq+rD1U5Oq/qIShWIJI96YPkJ+WHcZANjehSe/1ZkqMDCgp
        XG87vncIwsAThT3hfqebIO6HAwxrzLs=
X-Google-Smtp-Source: AKy350a7GJfRiFSFDKzPWZbiScdKOg1Gb2WGiHoIFWcuyX/W4ZmTOaaM2chs8SD5tuqwcJuf8SvUEQ==
X-Received: by 2002:a9d:66ca:0:b0:6a6:51d1:b162 with SMTP id t10-20020a9d66ca000000b006a651d1b162mr3929967otm.7.1682364305009;
        Mon, 24 Apr 2023 12:25:05 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id p8-20020a056830130800b00690e990e61asm70777otq.14.2023.04.24.12.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 12:25:04 -0700 (PDT)
Date:   Mon, 24 Apr 2023 13:25:03 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Erik Cervin Edin <erik@cervined.in>,
        Jeremy Morton <admin@game-point.net>
Cc:     Chris Torek <chris.torek@gmail.com>, git@vger.kernel.org
Message-ID: <6446d78fbbe82_cd61294e5@chronos.notmuch>
In-Reply-To: <CA+JQ7M_Lv1acopOpPoHxp7mPwWMFj-7wwwDPpV7KUbwFsjpoxA@mail.gmail.com>
References: <8fe188a9-c01f-9fb5-5877-8ff508094b22@game-point.net>
 <CAPx1Gvdc6bqzt2PpqD1Z4e5w+b=8gZhUSyfUQC1n8QazdBacEw@mail.gmail.com>
 <74a361fd-4ee6-f362-8d49-92417f0e2dac@game-point.net>
 <CA+JQ7M-1YvZFzE_CtBQa5_eEXa1sPqK4xsTxdwpAQo_YcmW+-A@mail.gmail.com>
 <91dab444-5f65-31ae-c0c6-0b84313bcd94@game-point.net>
 <CA+JQ7M_Lv1acopOpPoHxp7mPwWMFj-7wwwDPpV7KUbwFsjpoxA@mail.gmail.com>
Subject: Re: Proposal: tell git a file has been renamed
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Erik Cervin Edin wrote:
> On Mon, Apr 24, 2023 at 1:17=E2=80=AFPM Jeremy Morton <admin@game-point=
.net> wrote:
> >
> > There's no getting away from the fact that this adds a lot of (IMHO
> > unnecessary) work if you've already done a rename that git can't
> > detect and have both that and a bunch of other changes sitting in the=

> > index.  What feels like it would be a natural resolution in these
> > cases, though, is a "no, this remove/add is actually a rename" comman=
d.
> =

> It can definitely be both arduous and non-obvious how to deal with this=
.
> =

> The problem is that such a command cannot exist atm. because renames
> don't exist, they are only interpreted. So the only way to achieve
> this is to revert enough of the contents staged to the index such that
> the rename is detected. The only way to do that in a foolproof manner
> is reverting all the staged changes except the path so that the moved
> file in the index is identical to the old file in HEAD.

I agree recording renames explicitely might be a good addition to git, bu=
t the
real question is how are they going to be stored in the object storage.

My guess is that it can be added in the commit object after "committer", =
just
add a "renames" field with all the renames, or one "rename" field per ren=
ame.
It would be backwards compatible because any field can be added this way.=


How to generate these fields is a separate issue: first things first.

-- =

Felipe Contreras=
