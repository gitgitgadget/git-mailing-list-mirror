Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28AEC433EF
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 16:45:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241012AbhLMQpy convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 13 Dec 2021 11:45:54 -0500
Received: from mail-pf1-f177.google.com ([209.85.210.177]:42781 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234892AbhLMQpx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 11:45:53 -0500
Received: by mail-pf1-f177.google.com with SMTP id u80so15415389pfc.9
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 08:45:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uoG/4ku3t5dEtqjs1PZItqHbEDxRRjt8HnnfVMbtPZ0=;
        b=FJc946ckuSCmwx5CnpyNiFa1on28f5xt1fYCEou8nxdYbYKYcb4UCwuZBnHs7fEOWw
         hHFhJyPGDJY+AR4A4RSz3QbTMX+tKxqvC90VmD/pUuih+O/m64DK24JkOWO/NSh1JV7U
         +LuuL3OBhrB0ANqi+GbNu5huHGXa/pgKzwmG6bJayNh/6h4CfeQr50eqWHnWjDZMHTP1
         t9ycP2GkBcNXKZeKi4hxKSUzdo0O2e2DLFuJIW9tLwiuHCw1c8yK7feYZwovqVhIzeVZ
         Mf3YngQI4BRXLMZ9lGP0i4czvnCgbR2kYPmJcNAltIeCKil3x/k6KW8niz3AtJGH7FYD
         UMdA==
X-Gm-Message-State: AOAM530SrtJE2oepqkwONl3ADSDGUt4RPMVyCX+oS4Ea6P+ah49kHWQp
        Udzlvymd5iNMav2XVkOgvpJNyugtZoyyO5X67yU=
X-Google-Smtp-Source: ABdhPJzPhOJlquq/ZO6fzK/g12KNmYwIamvIuHUoPAaTBhU0mKrzkFSJGYAh8ac/lfCR3wLgCu3l8i2NWUiPidLxcHk=
X-Received: by 2002:a63:380e:: with SMTP id f14mr52346942pga.227.1639413953307;
 Mon, 13 Dec 2021 08:45:53 -0800 (PST)
MIME-Version: 1.0
References: <cover-00.13-00000000000-20211212T201308Z-avarab@gmail.com>
 <patch-10.13-ca55471d134-20211212T201308Z-avarab@gmail.com>
 <CAPig+cSkiFd27o8uACdX9ftg=N2XukqNSU_Tt+7rWT08JD7CAQ@mail.gmail.com> <211213.868rwo8o3q.gmgdl@evledraar.gmail.com>
In-Reply-To: <211213.868rwo8o3q.gmgdl@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 13 Dec 2021 11:45:42 -0500
Message-ID: <CAPig+cTDu+gXOTeBHALCuS9ZqvuqxQW-gXdYUsyAxTOT=gHEnA@mail.gmail.com>
Subject: Re: [PATCH 10/13] test-lib-functions: add and use a "write_hook" wrapper
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Adam Spiers <git@adamspiers.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 13, 2021 at 11:29 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> On Mon, Dec 13 2021, Eric Sunshine wrote:
> > It's not clear whether the intention is to maintain the &&-chain in
> > this function...
> > ... or not care about it since it's broken here before `shift`...
>
> Thanks, those should all use &&-chaining. Will fix.

By the way, the new chainlint could be made to catch broken &&-chains
(and missing `|| return 1`) in test script functions, as well; it
doesn't have to limit its checks only to tests. The reason I haven't
done so yet is that it's not clear how much we care about &&-chains in
functions, especially since we have _so many_ functions which don't
maintain the &&-chain. In the long run, I think it might be beneficial
to extend chainlint to check shell functions too, but fixing the
&&-chains in functions probably have to be done incrementally, thus
would likely require some sort of whitelisting or blacklisting
mechanism until all functions have been fixed. Anyhow, it's food for
thought.
