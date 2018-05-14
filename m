Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCACC1F406
	for <e@80x24.org>; Mon, 14 May 2018 04:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750991AbeENERN (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 00:17:13 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39756 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750748AbeENERM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 00:17:12 -0400
Received: by mail-wm0-f65.google.com with SMTP id f8-v6so12443523wmc.4
        for <git@vger.kernel.org>; Sun, 13 May 2018 21:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=juwCejhIYdtjUcG26TtkeoupPTYNrjh0W0RNqiLuryQ=;
        b=KYujNle+5QO4Rx6qS00eSXPyoYce1XAMfkOAcM07DXp/IZon2Qn2WV9KStqnr40hu0
         8EWYDpmU27buhkyjk/03c+SUZO9hrLvzRN6h/CuPG0e6bjKG+WRc84joZv/IafHPS4tB
         ahbuzWAEQvz3P3YzkfO9Mgv3EaPARpq6rlD8iS/DrctBO97+BdxvmnR2/s6wEpb5mb3G
         54k4o6j5YPoQVVHvlYhBOUIbv9qbwnXA0PGe3WjpkHjxuYrW2ZBm0HTJhHrHLJJg/xlC
         Tc0oIhcCtFNeMR/yJP8ntNsGqb8YU8cj1C+Kfg3vKyF5ACqBVUrF7y6PPkadvRSkA7IU
         6tnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=juwCejhIYdtjUcG26TtkeoupPTYNrjh0W0RNqiLuryQ=;
        b=HIyG95xhyT9ffousJ+kdSjDfZo1j1WVzv+trKRr+u1Ik6AO+dn+D/t/n5UYfHFtqqu
         xCL2tLwSKCYSvUNqxB0fltI83Y1BXgJyl8bNwd4Ou6ocdwQsxhngVMF3bpcf8J6Y0Fuf
         0SM9aBq+o3nM0oRFp0kiG+6OoSuOV6nt9RNyTBmqjGYdGb5rZCvdfNKORJksUxAjeQS2
         oeDlBFCWmFu0tl0MtopoVRGq1p48u68YKkKGoQXNYEpiBppjOgaHFhmUEaXWtsGmNxap
         0yH8ajO+YYGXwfcJPYLsQByK0fqZSjYkfs5WnSHOMsZT0HSF8tvGZrfz6cihllze4u1U
         PJ2Q==
X-Gm-Message-State: ALKqPwfSbcVD1yzLAGAwbubtHxaSKthM4Cv+xG7K4kG8su7Hoa6I4YKP
        w5xqC2WE7YDIh4epvKElrXI=
X-Google-Smtp-Source: AB8JxZpgU2uAGAmsq6dl07pxsTjFxuXmE9kW8GoCaTHLJLNITiLNiXVpgyGoElWCcJ2F+/FhZ0BXuQ==
X-Received: by 2002:a1c:d212:: with SMTP id j18-v6mr4069891wmg.29.1526271430717;
        Sun, 13 May 2018 21:17:10 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id p7-v6sm9655385wrj.85.2018.05.13.21.17.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 13 May 2018 21:17:10 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 06/14] sequencer.c: use commit-slab to mark seen commits
References: <20180512080028.29611-1-pclouds@gmail.com>
        <20180513055208.17952-1-pclouds@gmail.com>
        <20180513055208.17952-7-pclouds@gmail.com>
Date:   Mon, 14 May 2018 13:17:09 +0900
In-Reply-To: <20180513055208.17952-7-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Sun, 13 May 2018 07:52:00 +0200")
Message-ID: <xmqqk1s6dg6y.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> It's done so that commit->util can be removed. See more explanation in
> the commit that removes commit->util.
>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  sequencer.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index 4ce5120e77..6b785c6c5f 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -23,6 +23,7 @@
>  #include "hashmap.h"
>  #include "notes-utils.h"
>  #include "sigchain.h"
> +#include "commit-slab.h"
>  
>  #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
>  
> @@ -3160,6 +3161,7 @@ static enum check_level get_missing_commit_check_level(void)
>  	return CHECK_IGNORE;
>  }
>  
> +define_commit_slab(commit_seen, uint8_t);

Because it makes no difference on any real platform that matters, it
is purely academic preference, but the user of this code does not
care about ensuring that commit-seen data is at lesat 8-bit wide,
which is where we should use uint8_t.  We know this is a simple
yes/no field, so use of "uint8_t" here is quite misleading to the
readers.  "unsigned char" or "char" would be a lot better.

