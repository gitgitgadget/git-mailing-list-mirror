Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29372C433E1
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 07:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 029DF2071E
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 07:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BxFIz654"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbgHYHz1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 03:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgHYHz0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 03:55:26 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBD8C061574
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 00:55:25 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id di22so10365337edb.12
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 00:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=fxVKlF7WqoK49uHVGGzftXgbvlc2TtVk6PPDBqU1Crs=;
        b=BxFIz654LJZhB5oiFPYtUBbq7Fkg3QqU3ZzBDTpFA3HzCOJNOvGsvNU8zqm5F7o0th
         MwhDRp7jyO7unL94dzzLEe4EbJj2CLDKS3EEYJLzm8AlGKSUob1M/TiSnsksXuQn1w25
         bna4OCWoXYHxnkHocOaNLTCTHNyc5WUHo1tFdwke2Lq5vvESXQqcvPqnqGT7+3Z6M6WT
         zCs+zxTfdz5rUT+27t9eChR2TD9C1YLltS8yBquboLueZw3w+RHZ8zoykf1gohUpJBDM
         TVmXgTByfBgMtwARf1gY2us47YZXrnHrgafqSHqkj1hsKZ3/1C+h/ZAJazHfsEcJMV67
         Fgew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=fxVKlF7WqoK49uHVGGzftXgbvlc2TtVk6PPDBqU1Crs=;
        b=t5YTGHLsDMNc/Ya5UPgg16EmwnvfH1DH0zw7gfOSCW13WVc9LhwQotB9oR06aoEBIM
         Z2ZGHkiT1/gQsUsC0QvbsrtbwL58V3tePwFFgfijAnaUGHE2VMS1dz2mSZrqy9tZcGYU
         qFLBA/9pcXI9vTcUubPulNTuieKu/BGMKIxStsnYWBNC/l/n2L3/04DMz6IUH/aP1ir9
         8EUQuY3VhSC6bnEEDBlHnNePpLqKO2HCmP6d5VLa8K1F6Q454jDDw9p+N5/RK2DX+FJK
         v8ppq6rWF0hDW4jftQF+6CBYCoPIvC1XDdYBgcplo/R7DYRFjYjuGhhO8Q5KHDjLj5FA
         nknA==
X-Gm-Message-State: AOAM533GQgNWK+dVD19UDHLfOK3265Q+mPlI1fHWlExBDEl9a8PuFy6R
        YuqzeeRYeMf8v2jFpWGVhGh6EPRl06aVFg==
X-Google-Smtp-Source: ABdhPJy+/qLVGJWXuQbUKVarjofVkEGFGCVvmcNb8v3+jVjPvvLmveuAnjy47e9RIpxEbuCFJnFFtw==
X-Received: by 2002:a50:954d:: with SMTP id v13mr9125076eda.337.1598342124091;
        Tue, 25 Aug 2020 00:55:24 -0700 (PDT)
Received: from ?IPv6:2a02:a210:ca2:9c00:ccc3:b285:13cc:4289? ([2a02:a210:ca2:9c00:ccc3:b285:13cc:4289])
        by smtp.gmail.com with ESMTPSA id x8sm8590513ejf.6.2020.08.25.00.55.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Aug 2020 00:55:23 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH] builtin/repack.c: invalidate MIDX only when necessary
From:   Son Luong Ngoc <sluongng@gmail.com>
In-Reply-To: <ef9186a8df0d712c2ecccbe62cb43a7abadb9c96.1598320716.git.me@ttaylorr.com>
Date:   Tue, 25 Aug 2020 09:55:22 +0200
Cc:     git <git@vger.kernel.org>, dstolee@microsoft.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <CB6B70D3-5FC6-43FE-8460-33F6CFC123E6@gmail.com>
References: <ef9186a8df0d712c2ecccbe62cb43a7abadb9c96.1598320716.git.me@ttaylorr.com>
To:     Taylor Blau <me@ttaylorr.com>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Taylor,

Thanks for working on this.

> On Aug 25, 2020, at 04:01, Taylor Blau <me@ttaylorr.com> wrote:
>=20
> In 525e18c04b (midx: clear midx on repack, 2018-07-12), 'git repack'
> learned to remove a multi-pack-index file if it added or removed a =
pack
> from the object store.
>=20
> This mechanism is a little over-eager, since it is only necessary to
> drop a MIDX if 'git repack' removes a pack that the MIDX references.
> Adding a pack outside of the MIDX does not require invalidating the
> MIDX, and likewise for removing a pack the MIDX does not know about.

I wonder if its worth to trigger write_midx_file() to update the midx =
instead of
just removing MIDX?

That is already the direction we are taking in the 'maintenance' patch =
series
whenever the multi-pack-index file was deemed invalid.

Or perhaps, we can check for 'core.multiPackIndex' value (which recently =
is=20
'true' by default) and determine whether we should remove the MIDX or =
rewrite
it?

>=20
> Teach 'git repack' to check for this by loading the MIDX, and checking
> whether the to-be-removed pack is known to the MIDX. This requires a
> slightly odd alternation to a test in t5319, which is explained with a
> comment.
>=20
> Signed-off-by: Taylor Blau <me@ttaylorr.com>

Cheers,
Son Luong.=
