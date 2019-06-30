Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,URIBL_SBL,URIBL_SBL_A shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 678B71F461
	for <e@80x24.org>; Sun, 30 Jun 2019 19:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfF3TtL (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Jun 2019 15:49:11 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33043 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbfF3TtK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Jun 2019 15:49:10 -0400
Received: by mail-wr1-f67.google.com with SMTP id n9so11489039wru.0
        for <git@vger.kernel.org>; Sun, 30 Jun 2019 12:49:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Vo7jIC3oe8mwMj4loiD4SoUrmlb8gzR96OFRJRod3Q=;
        b=dO8kky+UTepp+pqiYREF9gutm2luOxbuxfidyhhydTQAq0xuJXeAxz9j4vmrGuSITp
         xWIeqb5i2xzaPy/1VxuHFKKMsgLYpGM6M2m6dA554W9+DpqVQZNHwY33qv4hqjDuB0rv
         5wghBB4zj0jgKuYQgEYavaGqsNyqT3fOGR92ymBa8/HBZaFyeWZUMv28l1CKzK8/4I8h
         8Jrz8VZopC27oVd7+57RgBsBvOm5xYmCdGW/Uvc4NBO3WaZTs4rln3PLgZTdaCS0tUuz
         CX4GuuCaa15zqwpcoGfO2NZUxDJLrMBHscgcVHENGNf8RfnPSBG5NczMxNQ4wD+zjUQb
         Uy9g==
X-Gm-Message-State: APjAAAVfB5AC2kDhAx0nKWZJk3XZodpDDXn0GTGDDSnaR4Rbw7w++iUU
        ydJztrfhatavYBzFwsS9bAbG+QlZ6mfn9K4QtfLktQ==
X-Google-Smtp-Source: APXvYqw7VTM6vK+7ZDnla8HGPghk6qiPRMeL8PyuCOjzB1qRsgmCwjx+uJKEV7zOtcOm7Frm8ldxIuU1Xqd1JWvIlPE=
X-Received: by 2002:adf:f98b:: with SMTP id f11mr10514481wrr.231.1561924148809;
 Sun, 30 Jun 2019 12:49:08 -0700 (PDT)
MIME-Version: 1.0
References: <pull.261.git.gitgitgadget@gmail.com> <d4a3f56b-5eaa-1325-f8c1-be6797a9ac03@kdbg.org>
In-Reply-To: <d4a3f56b-5eaa-1325-f8c1-be6797a9ac03@kdbg.org>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 30 Jun 2019 15:48:57 -0400
Message-ID: <CAPig+cRpOHRgtCXXiqAZtmEtkWnMy7=4GsTVv0XB9R3fF0-66A@mail.gmail.com>
Subject: Re: [PATCH] t5319: don't trip over a user name with whitespace
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Derrick Stolee <stolee@gmail.com>, Git List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 30, 2019 at 2:57 PM Johannes Sixt <j6t@kdbg.org> wrote:
> On my Windows system where the POSIX commands are provided by MSYS2,
> I observe this output:
>
> $ ls -l Makefile
> -rw-r--r-- 1 Johannes Sixt 197121 101780 Jun 30 09:33 Makefile
>
> Notice the blank in the user name. Obviously, extracting the size
> of a file by counting columns won't work. But two tests in t5319
> do that. Use the stat command to print just the file size.
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
> diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
> @@ -443,7 +443,7 @@ test_expect_success 'repack with minimum size does not alter existing packs' '
> -               MINSIZE=$(ls -l .git/objects/pack/*pack | awk "{print \$5;}" | sort -n | head -n 1) &&
> +               MINSIZE=$(stat -c %s .git/objects/pack/*pack | sort -n | head -n 1) &&

Unfortunately, this is not portable. While "stat -c %s" works on Linux
and MSYS2, neither that option nor the format directive are recognized
on BSD-like platforms (I tested Mac OS and FreeBSD), which instead
need "stat -f %z".
