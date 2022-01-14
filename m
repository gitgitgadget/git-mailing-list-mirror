Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3277BC433EF
	for <git@archiver.kernel.org>; Fri, 14 Jan 2022 08:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236951AbiANISq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jan 2022 03:18:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239560AbiANISW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jan 2022 03:18:22 -0500
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7006C06173F
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 00:18:21 -0800 (PST)
Received: by mail-ua1-x935.google.com with SMTP id o1so15678728uap.4
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 00:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HkdPUe07Snwwrc+a1qsT4lUFLGTOS0ECne/uv1zXfsU=;
        b=DmpwfYknUUnvzsoqmAkEsfmpzgn75DqJQ9Mn2VBxlfUpcjwx2HQFE2Q6jzy/FH/w+7
         C84MYLsA05XKLCJJkp9xFIOfFB1EJbvA3rYplrl/jv/POc8wy0KruH974Pyqw51Ax4oZ
         Jc8MzFoCF5Zp60dJp+woYSnZUTRJkQd1grFqJZG01p0ZMo15nVV0XbukzuhmCfEl6pc6
         +0GtDdpHo/llVgTgjrXf25RhQWbvfDE4QTUhlBaRExNqd6fHVgn1C7kRPnOob37Fq3IH
         nEeIUXwIz0CsofjSmAz/pLtPdet6CNViFq014Kud4aBDz+S7OKDiuZZZbhm5YtHK4r1G
         dJtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HkdPUe07Snwwrc+a1qsT4lUFLGTOS0ECne/uv1zXfsU=;
        b=j26bSFOk55y3zppmGTQpPb34ve+yBg4SRIenyez4mad8TmM4qYu+jiwX4ievky83Jl
         460QXyc5JQBw9uNSM5V7W4khRqt3fM2/VP+71WnrnnacS9sqYWRBfS7DKFI/VWqSoe4r
         XmEUgK2l9KkzMJEctUTM6xYZy7N/w04HVWGFHEaUdsXPRcbQvHqcallfx6tUa2zCBg6b
         depRSWT+8U0N9EJRznBVj77/SsrqpRnz6BSIEqxZPl8Y3HUVmZxmYf9XDR5Bj2Za89SP
         K8nMzT395duNNhd0zogMCf1ONuKwzKuAmQbjkgIp/e/cBdKd3f/KMmzV673HMbS8s6kJ
         z6iQ==
X-Gm-Message-State: AOAM531aX/bInQOteL5LuuPow2qmasQFQcHVIbgEuSsRn5wmOq0/pIHc
        0Nu66pqpKy7z7TOAOgYcyjvz+QlSzsqkBsVLLoA=
X-Google-Smtp-Source: ABdhPJyOER/ydsZLOiTcysRZM/UGOAP/1Fj5bPxA+AkzyqtoTsY+1ASYUnxaBUX2YZjYeztxXjoY3bMfF7IdxKTVPzg=
X-Received: by 2002:a67:d615:: with SMTP id n21mr3974673vsj.43.1642148300992;
 Fri, 14 Jan 2022 00:18:20 -0800 (PST)
MIME-Version: 1.0
References: <cover.1641978175.git.dyroneteng@gmail.com> <bcfbc935b80b889273e3e54fec2a896e44acd2b5.1641978175.git.dyroneteng@gmail.com>
 <220113.86wnj4w228.gmgdl@evledraar.gmail.com>
In-Reply-To: <220113.86wnj4w228.gmgdl@evledraar.gmail.com>
From:   Teng Long <dyroneteng@gmail.com>
Date:   Fri, 14 Jan 2022 16:18:10 +0800
Message-ID: <CADMgQSQXLydvgpW+Vm_b-rkSWAuj9FezwveY-iRZnKfsGkOpCA@mail.gmail.com>
Subject: Re: [PATCH v10 6/9] ls-tree.c: support --object-only option for "git-ls-tree"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, tenglong.tl@alibaba-inc.com,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 13, 2022 at 3:02 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:

> In the RFC series I sent this was first implemented in terms of the
> --format option, and I skipped the custom implementation you're adding
> here:
> https://lore.kernel.org/git/RFC-patch-7.7-5e34df4f8dd-20211217T131635Z-av=
arab@gmail.com/
>
> I think in terms of patch series structure it would make sense to do
> that, and then have this custom --object-only implementation in terms of
> not-"--format " follow from that, and thus with the tests for the two

Sorry, the "not-"--format" means?

> (we'd add the tests you're adding here first, just for a
> --format=3D"%(objectname)" or whatever) we'd see that the two are 1=3D1
> equivalent in terms of functionality, but that this one is <X>% more
> optimized.

Please allow me to understand your advice,  if we put the commit of
introducing "--format" before the commit of introducing "--object-only", wi=
ll
be better because it's possible to supply more optimized performance
(if we have) information in the commit message.
