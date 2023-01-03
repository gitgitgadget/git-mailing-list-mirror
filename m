Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B296CC3DA7D
	for <git@archiver.kernel.org>; Tue,  3 Jan 2023 09:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237257AbjACJqK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Jan 2023 04:46:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237170AbjACJqG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jan 2023 04:46:06 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07982E0E3
        for <git@vger.kernel.org>; Tue,  3 Jan 2023 01:46:05 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id p12so14506303qkm.0
        for <git@vger.kernel.org>; Tue, 03 Jan 2023 01:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ChsMQ3mHkSS7XzqAEfMnvmFyc8jVDScLytjVponmUCw=;
        b=RTQ6hpxP0DezAOiPcTEYZnBpLC2ZYuOhoGrPzo5kHIxBZQMEtzElZ2/wGCxdVrQdZw
         GVyVrw6m6OMwqyt5FDt5WYYAmVPERcC5b3r/Sf7Ad5vA9zFbqjBvvQy/pMVKz2ov1e5d
         +niT1rBY6GAl0KQMR+M1VpP3tFVsObinjaCwPCKMAK0esPH9Ii8gs2bVVgoyBOp3F4Ob
         kknA1750g0rdHVMR7kwNkCfjaokfW36q4U6XHUMb5WcrsmM+xGaTmFB6ub0VWcw5h9Ih
         g+ZmsEXWr0V+OMM7uBqyVHni7H0sTJC/R3+a9WXplNNtmWkGBzj0R5yUltq7BQg8Ryi3
         DY/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ChsMQ3mHkSS7XzqAEfMnvmFyc8jVDScLytjVponmUCw=;
        b=A6/7wmP4fjwkiL6fvAA2ysbLGwhrna3fTjFHf6ajeKFf1h7this2olhcIpkdCiaPT7
         FrAJ7sHwXM0xnPo5AQ2xhNHzk39E9wGuytJ/8/zcmq6fWXMk2yZj/jn9rSxLNqN4Yu4V
         QGMP9lQPDRP2ZGs24PyE/a6C995dQtA5MG50672oKV6z/HasK2k6N1PbhlJMZD5FafS7
         DKxi+aGGgrFsbtCe9Ssr3aGZG6XimoWtAWnM0ZxWCw3N2WJhuVJNyfVwnKvD/S4/XzGp
         3UJlankzCqNr5oN7S3911XRtXbHZJ7cMFvtNUbmpqLSsvkbQCHIrKIon7NTuiBaTMtJv
         M1Qg==
X-Gm-Message-State: AFqh2kqQf1iidRZd6BbR735HI/tM/cbDiygT7asJg1HJufDtRx3TzJ9F
        mJ7k/BdU2boB9yWiNqvk9I8D+o0EKZWjCHDkJcl1bFJ4+b75zg==
X-Google-Smtp-Source: AMrXdXv5dz2jjdEJoxKyizxgxIqtv74Y77zPuLcuqS8QxGlWnnjzwnRQEmP01nSa30ZI6a71xkC3YmDEHu8oNeMPKmo=
X-Received: by 2002:a05:620a:99b:b0:704:e9e8:98bc with SMTP id
 x27-20020a05620a099b00b00704e9e898bcmr1769711qkx.229.1672739164132; Tue, 03
 Jan 2023 01:46:04 -0800 (PST)
MIME-Version: 1.0
References: <7hfRSnKTRnT4uJh5Pok8U8gfLm_NXzCS6w_7_Rc9OH3a9Lv8hpjySZqxDglBFC-fTOdZHi-ODCihiEHlQD9nIhUmld5jYvRx_JvB0z2IAL0=@164.ooo>
In-Reply-To: <7hfRSnKTRnT4uJh5Pok8U8gfLm_NXzCS6w_7_Rc9OH3a9Lv8hpjySZqxDglBFC-fTOdZHi-ODCihiEHlQD9nIhUmld5jYvRx_JvB0z2IAL0=@164.ooo>
From:   demerphq <demerphq@gmail.com>
Date:   Tue, 3 Jan 2023 10:45:53 +0100
Message-ID: <CANgJU+V8VpM8sL=wmBnuTRzZzz-0hwzj6gP6tGhf5OhGv=K9Gg@mail.gmail.com>
Subject: Re: Request to remove Junio C Hamano as the Git Maintainer
To:     Filip Lipien <aaa@164.ooo>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 31 Dec 2022 at 19:52, Filip Lipien <aaa@164.ooo> wrote:
>
> There are more than one million questions on Stackoverflow related to the=
 usage of Git.
> This is not normal.
>
> Git is in its current state not a tool that's made for humans.

Any tool sufficiently advanced to be useful to experts will from time
to time surprise beginners who lack context knowledge. That is normal.
Designing tools to be unsurprising for beginners usually just ends up
limiting, frustrating or surprising the experts.

> It's realistic to assume, that millions of working hours were wasted due =
to his ignorance of developer experience.
> The financial damage goes into the billions.

Yeah, business has adopted it wholesale because it loses them
billions. That makes sense. Not.

>
> I hereby request the removal of Junio C Hamano =E6=BF=B1=E9=87=8E=E7=B4=
=94 as the Git Maintainer.

That is just rude. Having a free meal in a restaurant does not give
you the right to demand the head-cook steps down because you didn't
like the way it was laid out on the plate.  Whatever it was you
intended to achieve with this post, this is not the way to go about
it.

Normally I would ignore a post like this as trolling, but others have
engaged, and I wanted to express some support for Junio as I know
these kind of things can get even the thickest skinned hacker down.

So to Junio: Thank you for your contributions. I give you strength to
ignore the trolls.  I have stated this previously, but thanks again
for add --interactive, that is a super useful tool which I use and
appreciate pretty much every single day.

cheers,
Yves

--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
