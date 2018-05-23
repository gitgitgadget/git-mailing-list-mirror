Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED2AF1F51C
	for <e@80x24.org>; Wed, 23 May 2018 03:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753820AbeEWDmO (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 May 2018 23:42:14 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51720 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753787AbeEWDmN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 May 2018 23:42:13 -0400
Received: by mail-wm0-f68.google.com with SMTP id j4-v6so4992107wme.1
        for <git@vger.kernel.org>; Tue, 22 May 2018 20:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=rro1e1wH67xJz1xSLwOAm4S3x2RzmyQ+tSs1yCb3wXQ=;
        b=kMF5Q3VxTMa1aKrzkkRon4VmC6TuciYbv2zOhdOsCYW/cbEMmpeevxfra+WMgogdAM
         s2JEBBfJLKYIk7oU979mpByb6oNXXFJDeMk30uZyt/L4GY1aVhSU78anmrTtn9CzEWT5
         TA/YX4qiXLEoawxmyYtXS/A3/ZXbp7v5uvHvgH4vxLoi9vtXqgadSyoBrAScXhCspwB0
         r6hVOkZ7ILBhPLB07JhC+Yb4ByK440e29CAkAmDX8MPLasYNh2BU7DgQuTylIQ3OgwZo
         EY8dGC7rOV9+vU380r9Fqv5RYsuYCBmx+7xYMpq/1R0j+++B+tXp6S1QODNnqVnplE0j
         93yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=rro1e1wH67xJz1xSLwOAm4S3x2RzmyQ+tSs1yCb3wXQ=;
        b=hsS0Uqm1DLuh3KMCZojmbuymkePpPL/b91WVFuA8QiP7ma4AqAMzkevo90ZznI4tvl
         nXbO8vnUiqN58VscQ4rlfss56ktBcCATOmfBVEElRn2Cx17J9zCVg1ur4+wVgvYwhb83
         vJzfCPrO85WLsJH06QmNB76q4Hb8XZnVFmh77OOjU79bhhSqKnp8Dc130dXssEftM+OW
         Uv8kkNoSgZ/PrDF+RgwFOhgPZbTRFTSZoDOlVrO27xVv7nX02JSc/9+2rTJvu831MTfR
         EuNsmWxZn+7g8+yJf453deVHxoVeQatnNBUpVcOPvr4S8Z8qu8qOHwL1icNchqRN2lBp
         +Nxg==
X-Gm-Message-State: ALKqPweqHy1bf5a/FsT6nz7H/lPmhr8Ypie0sWnVQr7HYqUqEYOQcSXE
        fasWf6RF1J49V/Fh59gaDXQ=
X-Google-Smtp-Source: AB8JxZrBYC7+kvIUAhb3wt/9aw8LxhNjc0rlJy7w1zSj7ZeKxql0o97/5ioTq6cstGto5RPM9XDbIQ==
X-Received: by 2002:a1c:6a0d:: with SMTP id f13-v6mr2616495wmc.1.1527046932180;
        Tue, 22 May 2018 20:42:12 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id j13-v6sm1596072wre.38.2018.05.22.20.42.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 May 2018 20:42:11 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] fetch-pack: space out sent "haves" in negotiation
References: <20180521204340.260572-1-jonathantanmy@google.com>
Date:   Wed, 23 May 2018 12:42:10 +0900
In-Reply-To: <20180521204340.260572-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Mon, 21 May 2018 13:43:40 -0700")
Message-ID: <xmqqwovvujfx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>  Makefile           |   1 +
>  fetch-negotiator.c | 309 +++++++++++++++++++++++++++++++++++++++++++++
>  fetch-negotiator.h |  40 ++++++
>  fetch-pack.c       | 174 ++++++-------------------
>  object.h           |   1 +
>  5 files changed, 392 insertions(+), 133 deletions(-)
>  create mode 100644 fetch-negotiator.c
>  create mode 100644 fetch-negotiator.h

Somehow this feels more like a WIP than RFC, primarily for two
reasons.  It was unclear what "edge" computation is trying to do; it
seems way under-explained, especially the part that takes min-max
while. merging two candidates.

It also was unclear if this should be organized as a "take it or
leave it" patch like this one, or eventually should be split into
multiple steps when it gets polished enough to be considered for
application, the early ones introducing a separate negotiator module
without changing the common ancestor discovery algorithm at all,
with later steps refining that negotiator and add more efficient
common ancestor discovery process.

> diff --git a/Makefile b/Makefile
> index ad880d1fc5..8bbedfa521 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -859,6 +859,7 @@ LIB_OBJS += ewah/ewah_bitmap.o
>  LIB_OBJS += ewah/ewah_io.o
>  LIB_OBJS += ewah/ewah_rlw.o
>  LIB_OBJS += exec-cmd.o
> +LIB_OBJS += fetch-negotiator.o
>  LIB_OBJS += fetch-object.o
>  LIB_OBJS += fetch-pack.o
>  LIB_OBJS += fsck.o
> diff --git a/fetch-negotiator.c b/fetch-negotiator.c
> new file mode 100644
> index 0000000000..58975e1c37
> --- /dev/null
> +++ b/fetch-negotiator.c
> @@ -0,0 +1,309 @@
> +#include "cache.h"
> +#include "commit.h"
> +#include "fetch-negotiator.h"
> +
> +#define NO_THE_INDEX_COMPATIBILITY_MACROS

A totally unrelated tangent, but will we also benefit from
NO_THE_REPO_COMPATIBILITY_MACROS eventually?

