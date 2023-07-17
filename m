Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45E0EB64DC
	for <git@archiver.kernel.org>; Mon, 17 Jul 2023 06:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjGQGd1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Jul 2023 02:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjGQGd0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2023 02:33:26 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6559ED9
        for <git@vger.kernel.org>; Sun, 16 Jul 2023 23:33:24 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-51d95aed33aso5448450a12.3
        for <git@vger.kernel.org>; Sun, 16 Jul 2023 23:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689575603; x=1692167603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WXzcpfZ1kBHGWnw4GDNZvb8ulvh+p8R4DakPjfzpeEw=;
        b=QDRCwO6sBi5mfpG6/sDLV51XnWpw5bzl4AtA4TZc0hNYXJ7RpX86gvPO39XuqyU6ZD
         jjCfwAiVgtDliX/OIISsDOmO0VP2xmfBgWvoEUIsihpWUXxqr4ld6H97lZPtIIeHXqyi
         chJ7ppVzYyMUqffF5XtveMULbVtLRbKWRSqkquIjCPqeJT9J3DU63zb0E9L1yxtfC+cJ
         dn0v4Xe/Av71A4CY5ozr0bGd0gGP3FF9sM2rxjEISgTFMZJPG23sjUlCSHE89S0WmD53
         zOu90skDRgaYmVNB2eeQAJgXdLY1Kffd3Tz/qZSEfQchjjhgmvOXupSbFxdWwI0M3b8d
         EAeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689575603; x=1692167603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WXzcpfZ1kBHGWnw4GDNZvb8ulvh+p8R4DakPjfzpeEw=;
        b=UCo5Lxv85rdTBPHgk1D5ReThK09y0MHPnp3NHm187BHzNtxRgkK0raW+EV1MrpKH6A
         zzYrB51H9cDSdaKSur/Fa1zGoZdT1jEOSpq42IkPYQ7CoRu/lBFZT4JXZ4R6ZT7KlXtW
         sGzgvJZi7QC6BrS1hsOWJw7w8yc765/ZubmLT/G5AtERA8Kz8PcCjhCafSXRv3Y0Ic2u
         zRY1wUBjuL/Hi7L6/iD1QoahUbU/VHawm88wd0WmuNeMF/60NBw5xuRDkOn+e9be20NN
         yfveGJRS4ZzQ8abgI71FcTtUupkub0jbucBPoyqDiX80y+UvEhPIb5MfhIaKGzElPO4d
         OIbw==
X-Gm-Message-State: ABy/qLY1O0iG75pwq9DCeIs7i+p4ohMtadV4Dd5sBl1/Vv0ui6olqSX6
        KextX3Vso/YqtMSO4Gmi+wBhsfCeURQLZ9Pv4w/OdW2+
X-Google-Smtp-Source: APBJJlE8weIo4QtZk/vA+EYkBXb4yxrNdThB9wJxGRcJ4ZbJIu46ET6r8P8AHsr+Wn17MywZDEiLj6zta4eZb+BsLGA=
X-Received: by 2002:aa7:c519:0:b0:51e:34a1:8bf7 with SMTP id
 o25-20020aa7c519000000b0051e34a18bf7mr8889043edq.39.1689575602632; Sun, 16
 Jul 2023 23:33:22 -0700 (PDT)
MIME-Version: 1.0
References: <cbc22750-af93-9274-2ed4-6dfd356568e8@web.de>
In-Reply-To: <cbc22750-af93-9274-2ed4-6dfd356568e8@web.de>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 17 Jul 2023 08:33:10 +0200
Message-ID: <CAP8UFD0pjX1Pz9bq+CqiR-M85KVOWdGnBvgQJ=NDA4voC2n30w@mail.gmail.com>
Subject: Re: [PATCH] t6300: fix setup with GPGSSH but without GPG
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        Kousik Sanagavarapu <five231003@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Jaydeep Das <jaydeepjd.8914@gmail.com>,
        Nsengiyumva Wilberforce <nsengiyumvawilberforce@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 16, 2023 at 10:17=E2=80=AFAM Ren=C3=A9 Scharfe <l.s.r@web.de> w=
rote:
>
> In a test introduced by 26c9c03f0a (ref-filter: add new "signature"
> atom, 2023-06-04) the file named "file" is added by a setup step that
> requires GPG and modified by a second setup step that requires GPGSSH.
> Systems lacking the first prerequisite skip the initial setup step and
> then "git commit -a" in the second one doesn't find the modified file.
> Add it explicitly.

Right, acked!

Thanks!
