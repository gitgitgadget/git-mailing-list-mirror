Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1A9EB64D7
	for <git@archiver.kernel.org>; Tue, 20 Jun 2023 19:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjFTTMk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jun 2023 15:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbjFTTMj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2023 15:12:39 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957FD1712
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 12:12:37 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-51a4044b7a1so6243524a12.2
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 12:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google; t=1687288356; x=1689880356;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9f+S0PnuJ3pxA5SddhYVDdSYqDabBhrGR7XnaAy1TBM=;
        b=JUASjPraZM4A20tte7msocq31lpFpOjfEBvQwP6dGO9TfZVMvdsrPlxougZClTMxMK
         822GVjAyxjljuOWwhFcYZLvBWrOC1qRGvHNlg7q+pQZHch7evFBZ5/A8g9dgpNnTZLMG
         ngNclnVZUhYGiujh+qFZODDgW07QeQI+2INSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687288356; x=1689880356;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9f+S0PnuJ3pxA5SddhYVDdSYqDabBhrGR7XnaAy1TBM=;
        b=E6eTSUXMe9Wl1n808Y3TMtqonmtKt2ETJQwUmETIIfR9gNT7ulLSbae/jZhyRLrG86
         w+cHtKXH5PibDvfxaf8DyiW5cr16hmVtnumYD3R2RRWnrUiR/GS/d+MyHJSn43dC2g80
         lMWkGTxdm1nfJCsAR/SMZ3FFxDd7d9CGFyuTULdBVK67U+5SuPFKEIZWz0392jleGxRS
         +gz+5y+swbwjA+OtpoGYKcK074/F+gOuwTpSNqm9C4j4w6SPWK6LkUUztNGmzSJMTqkH
         76c990R5lrxhy97ygaN9SzM/ALZz34ipaWGxf31oxHcp4l8ZPae+PxGRJw08jEpXkB+g
         bkqw==
X-Gm-Message-State: AC+VfDyeK0r+7k6LlVWrjuxNpwX/my5ZpbUJVgkmG/vieGaPLCCOcw9b
        BTphgJUHbzWkue1iOR7u4LknpFQE2gaFnGrX9YVZqylV9xUkn99aEosYkQ==
X-Google-Smtp-Source: ACHHUZ7IPaAD3AOVev8REymKL8hLmx1OFq/jFs/L6ReKPmgA161BCtg95Yb+t/ay6O1PlhT5Rz6bdzX/T1RcB/L59N4=
X-Received: by 2002:a05:6402:759:b0:51a:7bcd:a82d with SMTP id
 p25-20020a056402075900b0051a7bcda82dmr3926486edy.23.1687288355575; Tue, 20
 Jun 2023 12:12:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAPMMpohiTzANyhzL-mS-gg2kzbOEOiDktNbdwEXBKy9uL0-JgA@mail.gmail.com>
 <CAPMMpog8Hv_KcjNxbh_wzjwrFYt7TuTvrVy1XEtJMm6RWSKzRg@mail.gmail.com>
In-Reply-To: <CAPMMpog8Hv_KcjNxbh_wzjwrFYt7TuTvrVy1XEtJMm6RWSKzRg@mail.gmail.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Tue, 20 Jun 2023 21:12:24 +0200
Message-ID: <CAPMMpojUpJD21x2i_hshTB96TBFVd-_WRV54KHT2-4R8DUh8=Q@mail.gmail.com>
Subject: Re: Determining whether you have a commit locally, in a partial clone?
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 20, 2023 at 2:04=E2=80=AFPM Tao Klerks <tao@klerks.biz> wrote:
>
> On Tue, Jun 20, 2023 at 1:26=E2=80=AFPM Tao Klerks <tao@klerks.biz> wrote=
:
> >
> > * Is there any way to run a single git command in a "don't use
> > promisors" context?
>
> My apologies for the self-reply, I did find a workaround here:
>
> git -c remote.origin.url log SOME_HASH_NOT_IN_REFSPEC
>

Another self-reply unfortunately: This workaround stops working in git 2.39=
 :(

I haven't understood exactly what's going on, but I guess the fetch
failure was explicitly curtailing *something* extremely expensive that
gets to go forward anyway as of 2.39.

I imagine it's related to the changelog entry "Remove error detection
from a function that fetches from promisor remotes":
https://github.com/gitgitgadget/git/blob/79bdd48716a4c455bdc8ffd91d57a18d5c=
d55baa/Documentation/RelNotes/2.39.0.txt

I'm back to begging for any hints here: Any idea how I can determine
whether a given commit object exists locally, *without causing it to
be fetched by the act of checking for it?*

Thanks,
Tao
