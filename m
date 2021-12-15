Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A12C433EF
	for <git@archiver.kernel.org>; Wed, 15 Dec 2021 20:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbhLOUpc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Dec 2021 15:45:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbhLOUpb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Dec 2021 15:45:31 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240EDC061574
        for <git@vger.kernel.org>; Wed, 15 Dec 2021 12:45:31 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id b11so21429568qvm.7
        for <git@vger.kernel.org>; Wed, 15 Dec 2021 12:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gitlab.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+2/eM47BJiSzUyC4WwfyMybc3m5BfBdb1YU9A1xP8w8=;
        b=KGfXNLUlPH+dh6zz5X5elLcHLJBpbmBD5QNBfptj4y/A8J1uabTgA4hxCHvR5mAwSa
         iOkxOrVGNMStAQ/45ZEJ82lRpYCyVkvSNgUcPrp/SrYj8F9bZ91OM18ssl+d9Vl1Uh5s
         UrABD5/d7Pwp0NRkScocMYSvA2dScSxyYTzHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+2/eM47BJiSzUyC4WwfyMybc3m5BfBdb1YU9A1xP8w8=;
        b=q3I46H5LSoqTYUwGjufsorBJbOm8MJ1ETrc6fAbp4EF+KByzt9cETBYUCi8kuicEO3
         HxBjUTrYYKtFwfqncWbfujcRvzoHf2AvMeRay3rv7ZQnQnXR8cD+cZex++9/e1TcWZwW
         gxIu4PUv3ROhSlNsX+4D3/DoFjtl95nsyWPsEZ8slu/SH5xzCLS/KU1fuoo1hw/8rOdE
         o8fGDzrNsg2+OAG4x18foUTCLIButayeYYN4B14xmmIEM5DXX/mgIyCBAxleUBgCri25
         M2W1AUe1+Z58p4bL5a9LjaIPULS9LglpqX5wBuUuaBKmNKowC+dO3t8FtTgBK48d4V6R
         zqrw==
X-Gm-Message-State: AOAM531V7jk2hZvlEO+WtHuJ+B18g9maXQjBOOpCvL5ZWdg3aIS/ckuQ
        LEY2V0myKIP8Zcw51ucqARoVy6uS85Ou9c/y9ex/pQ==
X-Google-Smtp-Source: ABdhPJzr4sjNDiJQyz1OsjtXyZZOCNM9tIXE+uket3SbM0OuXeHbC5wx0OldxucbCssDuUuaeLaHe+UpvNcI87Rl8aE=
X-Received: by 2002:a05:6214:27ee:: with SMTP id jt14mr13067643qvb.5.1639601130303;
 Wed, 15 Dec 2021 12:45:30 -0800 (PST)
MIME-Version: 1.0
References: <YbizfdGq+RSu9BGe@coredump.intra.peff.net> <20211214194626.33814-1-jacob@gitlab.com>
 <20211214194626.33814-2-jacob@gitlab.com> <xmqqa6h16414.fsf@gitster.g>
 <003001d7f1ee$48c88410$da598c30$@nexbridge.com> <CADMWQoPUEMGvhg-gqZHvsModKGomTYOP7h0SGv=9CaLMJdEm0g@mail.gmail.com>
 <003301d7f1f3$c1e24f20$45a6ed60$@nexbridge.com>
In-Reply-To: <003301d7f1f3$c1e24f20$45a6ed60$@nexbridge.com>
From:   Jacob Vosmaer <jacob@gitlab.com>
Date:   Wed, 15 Dec 2021 21:45:19 +0100
Message-ID: <CADMWQoMJ_BBzwSsaCBwLjaWuu=L2=f_nWSemR-pctBMpMTsgbA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] upload-pack.c: increase output buffer size
To:     rsbecker@nexbridge.com
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        avarab@gmail.com, peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 15, 2021 at 9:38 PM <rsbecker@nexbridge.com> wrote:
>
> The maximum I/O size on the platform is 56Kb. Anything larger will fail. That's why we use xread and xwrite for non-buffered I/O.

That sounds like it's orthogonal to what this patch is changing.
Regardless of this patch, the actual writes are performed by
write_or_die, which calls write_in_full. In turn, write_in_full calls
xwrite however often is necessary. We are not making any assumptions
anywhere about how large individual write syscalls turn out. Git
packets use userspace buffers so we can read and write them no matter
what the underlying IO sizes are.
