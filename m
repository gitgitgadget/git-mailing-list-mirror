Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54153C433F5
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 05:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiBXFWv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 00:22:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbiBXFWt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 00:22:49 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCE88B6FB
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 21:22:19 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id vz16so2046489ejb.0
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 21:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pMjVYM5Xu3ZcOGqfM2ZORGT+OJFtjcF4h1WkK4cUyxM=;
        b=FgnMDC7ZQQ2yvsIcW1eKF97rJpnjuJPLKi7FvnmmsQmFCl19Dbuhf6vJ8kcwJy2Pwa
         +A015dKkltx1BFjtaCEAtm83vDxV0Oo9S1Wkg40H1RI6ODsrnay/a1bGW4OHtFEVW/JL
         syN89ZTlyXkLQWyEyPB2BS1fgHpC82IQcLNgt+QDXb91quLrzNhDiOZP2zNYJpYpcKJa
         /60vrr3hhHKzuY5/0Mtc5GlNCddvxiDbeMGwK8mdjMSjlhBPserwiHI6MzPDm9BOu8j6
         TuwL1YSitnPY9L424kswK+wAsrO427H93hNSXac3eF+0v/FqLffegm5Az4Lye5xfbYLh
         UOaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pMjVYM5Xu3ZcOGqfM2ZORGT+OJFtjcF4h1WkK4cUyxM=;
        b=ekigu37RDg9XFfKqjCK9h5htdjiqmgZuz29aKmLY2e7LNk0/uG5rG7GksXrwCLCnk3
         BunA1/g30YKfXTJZVSTZaaW1luLj0FMB22SY1RWUyq7DPh9Sw6vw6s2qBcUZ4a1k/6YF
         UFpd/WdiRdZvanEXVpMXGni3ybdnH3NUqFQYbAO2xLH/vYksoU0s+QFi6/xxntvwViKL
         gi1lx+1gjWUH04hxMe6z5cI6CzZU9Cqs45PqPffnjJA8Adtl91DVWDQtyJyDEEmKztEW
         8R6c4tGXqETEzpzwtKCSZQfH3dJZFHMily1LU4p/DMh3K8gkFh4ICXO4gD4QKu3jdBTw
         QXxg==
X-Gm-Message-State: AOAM533rZDJuGf6bp9c4KDX2zLrDfK9RWwkXW3kWiFRhoIAtWZe08eas
        1b6WpALXdedp/uJVVDmfmkQmNPLq+5h73pcQY3QUm6uxXiOQeiTD
X-Google-Smtp-Source: ABdhPJz4aQl+AG7G8lv/Gfwzen77isqmeumU76fGMcVe5kcxt/yHqwU18KBw5zaBcqfYMpKwWTatFkJVNYnMuOlNBK4=
X-Received: by 2002:a17:907:334c:b0:6cd:76b7:3948 with SMTP id
 yr12-20020a170907334c00b006cd76b73948mr942563ejb.55.1645680138014; Wed, 23
 Feb 2022 21:22:18 -0800 (PST)
MIME-Version: 1.0
References: <20220222114313.14921-1-shivam828787@gmail.com> <CAP8UFD2wNSJmiohfAGrihm5sO_q4a6UpLMsVNAF5uWyuWt7R9Q@mail.gmail.com>
In-Reply-To: <CAP8UFD2wNSJmiohfAGrihm5sO_q4a6UpLMsVNAF5uWyuWt7R9Q@mail.gmail.com>
From:   Shubham Mishra <shivam828787@gmail.com>
Date:   Thu, 24 Feb 2022 10:52:06 +0530
Message-ID: <CAC316V5x54Ah566haa5wZ8zE=gkhYtziC+FVjXoBXn7xY_-WsQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] microproject: avoid using pipes in test
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> (Others have already rightly commented on many things, so I am only
> focusing on microproject related things.)
>
> As the subject of this cover letter starts with "microproject:" I
> would suggest taking a look (or maybe reading again) our page about
> microprojects: https://git.github.io/General-Microproject-Information/
>
> Please note that we ask that all related emails start with =E2=80=9C[GSoC=
]=E2=80=9D or
> =E2=80=9C[Outreachy]=E2=80=9D or something similar, not "microproject:".

Ack.

> > This is my first contribution that's why I am keeping diff short with a=
n intention to understand the process instead of making impactful change in=
 first attempt. Later, I will send more patches to fix the issue for other =
files.
>
> Please read the "Only ONE quality focused microproject per student"
> section of the above mentioned page.

here I mean in next patches, I will be fixing the same "Git on LHS of
pipe" for other tests. I think that will be considered as the same
microproject and I am still eligible to fix the same thing for other
files?

Thanks,
Shubham
