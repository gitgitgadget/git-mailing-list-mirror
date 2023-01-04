Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A32C4332F
	for <git@archiver.kernel.org>; Wed,  4 Jan 2023 06:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233497AbjADGh6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Jan 2023 01:37:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjADGh4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jan 2023 01:37:56 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB25E164B1
        for <git@vger.kernel.org>; Tue,  3 Jan 2023 22:37:55 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id v3so21606039pgh.4
        for <git@vger.kernel.org>; Tue, 03 Jan 2023 22:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VX61AFnVEzYpHqlRQ7C5bciKYVenko4mcHQoqFNH8xo=;
        b=UVbqPIzij7TVSXo/jM00lnn9TwWcJczU62Ln9aexnqV3nJvjQ5i58Plrmtdn9cBYG2
         hZv5lmZU9/TLcmhvOTZC87FOznFblxQWXan6f+wP6MmpPTR6mQp1Un7qXw80Plc5RfH7
         R0PFKpFMEQekIX6IFU2JQ6QK+9AkGcONKu7NWohBiF/tBfw5muNXgk6LEQoh6lRMi+6T
         dZeBb264VTXBj1dGXFfFwHcZSoXkrK+8o39pQjw8n/dWutFA3wfc3+vKVrNQAj636aGy
         kHzy2kGw0jXazjJANR1RRxphnDYTMFfrY2JJGofKZ3S67HRf/xQXc3I/4P8OX+F0Lta0
         50Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VX61AFnVEzYpHqlRQ7C5bciKYVenko4mcHQoqFNH8xo=;
        b=gJsyCSNKmyjuM8u8Jkftkypv6X+93nUYgapf4h3Mf9+n1/jRWNJhfXyKq2qWPleOxU
         +YCMrpSHtsBXiTbUWJK66sxK0ASkez0nnhAtXV1yhkr8eDroGtz/z1vTavPiJU7/aFkH
         nMtc3XvknI7yHqZ2t0AhSzCTlfaWNY9OnD+HDEaxLl+ukFEc6+15XdtYmp00T3DMYhLC
         j/KpIW/5p+wtIuHF5ficjOXmGWiTXyzV9uCxxQrfI2QL4nqHTFdGE3i4m1/vl2340OHd
         1HvpI27J+pLyc60zt5oG/1pddRLLE2WuQ3FtL5uApmg1ZIBPKcJwIya63MhlGi6EKudd
         8mEA==
X-Gm-Message-State: AFqh2kq+vXRstyFwFm+JdaLZlzBT3kprRMe+tiMnU8ay1cjbB03iMZTe
        XDpxf9FuUm5vJQccjc4zCKg=
X-Google-Smtp-Source: AMrXdXtgdfzrURnZEILEZx3borSd/tHYWxViEHhiG3F2/OH5Mr4KfZjiY/8cyaXBEdY4+skb5ynleg==
X-Received: by 2002:a62:6d07:0:b0:581:b3f4:21f8 with SMTP id i7-20020a626d07000000b00581b3f421f8mr20437012pfc.31.1672814275075;
        Tue, 03 Jan 2023 22:37:55 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id y13-20020aa79aed000000b00582cb9d9ad3sm2412881pfp.178.2023.01.03.22.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 22:37:54 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/5] environ: GIT_FLUSH should be made a usual Boolean
References: <xmqq8rmkpsit.fsf@gitster.g>
        <20220915160659.126441-1-gitster@pobox.com>
        <20220915160659.126441-4-gitster@pobox.com>
        <c58476c9-f7d1-bea4-17eb-c5346790df2e@web.de>
Date:   Wed, 04 Jan 2023 15:37:54 +0900
In-Reply-To: <c58476c9-f7d1-bea4-17eb-c5346790df2e@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Tue, 3 Jan 2023 18:18:32 +0100")
Message-ID: <xmqqwn62u7nh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> Subject: [PATCH] environ: use git_parse_maybe_bool() for GIT_FLUSH
>
> Accept textual boolean values like "true" and "false" for GIT_FLUSH by
> using git_parse_maybe_bool() to parse the variable's value.  Here's
> how this changes whether to flush:
>
>                        before                  with this patch
> ---------------------- ----------------------- -----------------------
> (unset)                if stdin is not a file  if stdin is not a file
> GIT_FLUSH=             no                      no
> GIT_FLUSH=0            no                      no
> GIT_FLUSH=1	       yes                     yes
> GIT_FLUSH=false        no                      no
> GIT_FLUSH=true         no                      yes
> GIT_FLUSH=bogus        no                      if stdin is not a file

The above looks easy to grok, but the following caught my eyes.

> GIT_FLUSH=10000000000  yes                     if stdin is not a file

Is this because the int is so large that git_parse_signed() notices
that it is out of bound (hence "bogus")?

> Requested-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
>  Documentation/git.txt | 10 ++++------
>  write-or-die.c        | 18 +++++++++---------
>  2 files changed, 13 insertions(+), 15 deletions(-)

I may have suggested it, but don't think I requested ;-)

The patch text looks good.  Thanks.
