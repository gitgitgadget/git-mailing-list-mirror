Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E92AC77B7C
	for <git@archiver.kernel.org>; Fri, 26 May 2023 21:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236228AbjEZVTR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 May 2023 17:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjEZVTQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 May 2023 17:19:16 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86259C
        for <git@vger.kernel.org>; Fri, 26 May 2023 14:19:14 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-559c416b024so16497317b3.1
        for <git@vger.kernel.org>; Fri, 26 May 2023 14:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685135954; x=1687727954;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fUZtGMHfCVoFj1TvclSJxdxNWuVV80PgENXsA+SwB7k=;
        b=xSWQx2w250W/Fy4kghASY7afmenc2wn0eQevp/YIJdaRibVOXt98oQbJRPopdhUAdQ
         L2XiGi77J0tlH4AzrEqU0D0ZzCcrXTdJmJ1U2vvBT/oXjn+LHyZZXlNh1KfEsyMtILoc
         2rJwJNAPCwLQVfMyv3ziypFnpJPSYNMZ/QgHwt7yoUsJ+NuypWKOoWs0t5Siu7oyS2bn
         VfjtdBWPb1HW65QY1zHmlV/vDeQvoJ+MKHtgDN7nOcTL3q3maKp1H/z6lHPlWfYLBXoc
         d6cGT1jdfqOg3AnO1q/L15WSTT7ZJRwyI/QWnbG2OBgJc2oOikXrMzA/hmvzd+98PY8H
         /zrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685135954; x=1687727954;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fUZtGMHfCVoFj1TvclSJxdxNWuVV80PgENXsA+SwB7k=;
        b=Y4pggDQXDbHmusUMheZeenTRXwmk+dA1PD+61Fo4DynPQnxyIAbD1GPzbA5gQRKnET
         Hg9UlJRX/9KADcksgJCqnx/fVPzYIl+fY/MnGCgZdYRppRU3Dz7GzMPjRcVOm88sZwn1
         E3TJGRSp2OQ4slsSUqz+0+TJHPiEcd992muCyoUxtwqQttw5YO8mTSCa8dKfIsnhw4tx
         36p5VnrxpFoGPMoDgFm29owg6LixOGN8XORiDo2yL9ivwvqOXv+kqC6r6xH62SKLsNjy
         KImE8Y9dzk9FLckmeHVi2Ry54bCs4PdDNKIVZo4vYY7G/YqMGrR8EAcBYW2X2ycHASJ7
         9N8w==
X-Gm-Message-State: AC+VfDy73irwB4tcHNrVvIwcBnXy5yEo/yQ9IEfBiSp2QtKvhFD4Ai0o
        cd0e3CjwgDaDZ6dkCmf3KRNFITsiBlOgfK37RPq8
X-Google-Smtp-Source: ACHHUZ6XAV4mK/L5kam0hZmJWz9Xi1+3ZuBLIazRYQ1aGLHE5orUhPjvdc/WZdoM3Aq1qesxFHe/DGhPg8Qn6naLw1sd
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:4ab8:70ac:b28a:a7ab])
 (user=jonathantanmy job=sendgmr) by 2002:a81:bc0d:0:b0:541:61aa:9e60 with
 SMTP id a13-20020a81bc0d000000b0054161aa9e60mr1784499ywi.6.1685135954202;
 Fri, 26 May 2023 14:19:14 -0700 (PDT)
Date:   Fri, 26 May 2023 14:19:11 -0700
In-Reply-To: <20230523192949.1271671-3-calvinwan@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230526211911.2291886-1-jonathantanmy@google.com>
Subject: Re: [PATCH v2 3/7] sane-ctype.h: move sane-ctype macros from git-compat-util.h
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:
> Splitting these macros from git-compat-util.h cleans up the file and
> allows future third-party sources to not use these overrides if they do
> not wish to.
> 
> Signed-off-by: Calvin Wan <calvinwan@google.com>
> ---
>  git-compat-util.h | 65 +-------------------------------------------
>  sane-ctype.h      | 69 +++++++++++++++++++++++++++++++++++++++++++++++

Any specific reason for the "sane-" prefix? I think it would make more
sense if it was just named ctype.h: see below.

> -/* in ctype.c, for kwset users */
> -extern const unsigned char tolower_trans_tbl[256];

I'm not sure what this has to do with sanity, but this is indeed defined
in ctype.c, so it's easier to justify moving this out if the criterion
was "what's in ctype.c" rather than "what's related to sane ctypes".

> -extern const signed char hexval_table[256];

And this one has nothing to do with ctypes or sanity, but rather, what's
considered to be a hex character. I think we need another patch to move
this to hex.h.

> -#define isxdigit(x) (hexval_table[(unsigned char)(x)] != -1)

Same for this one.

With the above suggestions, I think we do get what we want - a split
between things that make ctype more sane and between other compat stuff,
and also a split between those two and more platform-agnostic things
like what a hex character is.
