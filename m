Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DD7C2D0A3
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 03:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39433205CA
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 03:01:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0QTK1zd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730205AbgKJDBb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 22:01:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729243AbgKJDBb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 22:01:31 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C9EC0613CF
        for <git@vger.kernel.org>; Mon,  9 Nov 2020 19:01:30 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id j31so7638395qtb.8
        for <git@vger.kernel.org>; Mon, 09 Nov 2020 19:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Jag1TmBTxmHD8xdJMx4NPPWB1PXAz4F/33JtnWqMW2I=;
        b=b0QTK1zd1i760kX431S8ojL13vmdfw4ONIDLICBDGBndiw3VNmWrSFmhHzmYvt1Rd/
         cKEqwgmB2taco5929cCkNNglcqvG5xLPXdqcvp/b8pVV1jKFSHv06uiJX9jFiDhGDzJU
         NRu521PNU0C5yklIcbuwRAC3P1QEX8Rg6GxB6kP8rIPe6oJDyy78NDnp5E+Lor6mI9Vf
         gSmftSi90dguXKosOrQESHZk/21OLxX0jmvASfhk3uRstsV1V8mGhepF7IrR4HaT6yzZ
         CXurgEoPbpHXeQhJ6ARv9e/A/ndRDRFPvT0UgLeX7jurEhV8eoMEcE1IBAmRk3Mf36pz
         li4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Jag1TmBTxmHD8xdJMx4NPPWB1PXAz4F/33JtnWqMW2I=;
        b=cKSkkKbTwCblHJQ/katXS7tOSsmWDBLJxwSro1b1vFuJ3D/GyKO6LZlEhpf/7iX8Zn
         qhND3zr0vP+Zcz6SwFS1t8pAJKoiJtc6x+wGM42XLtq4C72kZy9hoJKXS/fCoix/FJCM
         7SQLCE46fVi+c1sC2PWQhX4cdACjkAHcmppdJq8MKULoPKMR8Kw3HJXR+chhnRP1OlTt
         3iiHQhWh9eUoxbJ943wh9vGEPXsLDmntrke7ZcWGh4UKoF0ZP1ceVZxcDO4o6ZqLAUfi
         LEGt/ia7mwRtP6CJe20ndSs540SAsxBIoFSA60B9kXh29riwXkXEOtjWHVCg+i2uCfgP
         f0gw==
X-Gm-Message-State: AOAM531+4ZDVn6okPATBrD3KO+46d7czRFrOLW3LzbtGwizZOy6kuqY4
        QTNs0U4eXUgbhstLQMujGug=
X-Google-Smtp-Source: ABdhPJzLS2TAfgES8rnO9/EYDu1ZRXX84pl1wahoskgNMPhmh62Ka/BEU/ckQyT30Kzd4rUeO49vFA==
X-Received: by 2002:ac8:3417:: with SMTP id u23mr15720354qtb.80.1604977290227;
        Mon, 09 Nov 2020 19:01:30 -0800 (PST)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id v15sm2797657qto.74.2020.11.09.19.01.28
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 09 Nov 2020 19:01:29 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Completion for aliases that wrap aliases that wrap Git commands
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <CAMP44s3ZPJhej9JQir+Vo6LEQKDfgvJBVyUNPEEze0YTnTxU4g@mail.gmail.com>
Date:   Mon, 9 Nov 2020 22:01:21 -0500
Cc:     Git mailing list <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6E9B97F3-43AC-431F-9B9C-5962F126F697@gmail.com>
References: <9717A684-9304-4A65-8566-19F946098455@gmail.com> <CAMP44s3ZPJhej9JQir+Vo6LEQKDfgvJBVyUNPEEze0YTnTxU4g@mail.gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
X-Mailer: Apple Mail (2.3124)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Felipe,

> Le 9 nov. 2020 =C3=A0 16:56, Felipe Contreras =
<felipe.contreras@gmail.com> a =C3=A9crit :
>=20
> Hello,
>=20
> On Fri, Nov 6, 2020 at 4:46 PM Philippe Blain
> <levraiphilippeblain@gmail.com> wrote:
>=20
>> I know nothing about Bash completions, but I'm wondering if that =
feature would
>> be possible at all ?
>=20
> Yeap. I just sent a patch for that:
>=20
> =
https://lore.kernel.org/git/20201109215248.461167-1-felipe.contreras@gmail=
.com/

Great! thanks.

Philippe.=
