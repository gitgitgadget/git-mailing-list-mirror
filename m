Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF3F9C433EF
	for <git@archiver.kernel.org>; Tue, 31 May 2022 17:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346608AbiEaRkJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 May 2022 13:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238878AbiEaRkG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 May 2022 13:40:06 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5835762BE5
        for <git@vger.kernel.org>; Tue, 31 May 2022 10:40:05 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id d12-20020a17090abf8c00b001e2eb431ce4so2964906pjs.1
        for <git@vger.kernel.org>; Tue, 31 May 2022 10:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+DXdrvHwTlVI+OXCRlsdkE3PxgSWMCAQxkuJkJHgsrU=;
        b=VhJPniyTn904YaaOCTGXcR6nLPQdl9aRK5Mr7mCq7qtIDdnNVRcNxJaa6vdZ9EAFLH
         UAudzA/pb9rwKJQSDPmEl7NnxirUM8Q9FcEfSsP6hG/G3pwdos2BJQb3/bOQVxwzT9me
         v9bBHBejFwvj3LmtYMVLw8P/lYBWxLpDPZigFY+BGAih+FVkY7/bu9CuLriF4GojNNgP
         +YLgRNdGMMHLwtb3YftpLEQK9+Y42Dd4ZWxohSfxAG5b9o2UTMKARjGo9x5+TU9i2la5
         T4stPZbzs/oeQ6s7zVx6oKRaZHpTkFTXaoTjcVdpN7JaJaNFjDvbAc3NFGwo27BQRhz+
         QqzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=+DXdrvHwTlVI+OXCRlsdkE3PxgSWMCAQxkuJkJHgsrU=;
        b=Qiyn+occgA896X7GwOGYiN5uCl+/smcG2747JgMOfvVwplPV48b+qe+cziO/vA4onr
         Pr/8nED5ndID7ODeignVbLjaMb3H8f/u/fnG7wWQVkW2ClTB/87x1Fmx6JD5Q69G/veZ
         MitEuItBUHwrGpMVK1mG5M4tv9actJhcHgiD75nhfLQ1lrjcR8/12PjUJDJQDZolG2qC
         CMt6OO4vJStkhQSQ5pfaWF+Aso+eNMEO/kBtjwfnpjCGtWmDtIjyAXfv+a/7akPTFI3b
         D8bqjLTt9ScZF94IR6DCQK13NaTtBJ+dm8lly5Lh+pXRTmbqS6LNBaRPLtM/7JgB6uno
         BDZA==
X-Gm-Message-State: AOAM531mV7OpOqnywN5yX6n6G6/kq4sXWlBAinscOwk8JNhdwHxuomGl
        uD3EtEYdo8ANO/q6uL68bzjKULKW66Mg+g==
X-Google-Smtp-Source: ABdhPJwH9zQ4nG25uq4vv+JAwcMZ0M2wXrMWzHu4/tj8b08x9SXAw+vLqz+/wdgYWX+sLotW0xu+Aw==
X-Received: by 2002:a17:902:d58a:b0:164:f5d1:82e9 with SMTP id k10-20020a170902d58a00b00164f5d182e9mr41342plh.3.1654018804581;
        Tue, 31 May 2022 10:40:04 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:42f:67e0:2ed2:1f46])
        by smtp.gmail.com with ESMTPSA id s24-20020a170902989800b00162523fdb8fsm11314407plp.252.2022.05.31.10.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 10:40:03 -0700 (PDT)
Date:   Tue, 31 May 2022 10:39:58 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH v2 0/6] usage API: add and use a bug() + BUG_if_bug()
Message-ID: <YpZS7sYGfWeDJz6o@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Glen Choo <chooglen@google.com>, Andrei Rybak <rybak.a.v@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
References: <cover-0.5-00000000000-20220521T170939Z-avarab@gmail.com>
 <cover-v2-0.6-00000000000-20220531T164806Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-v2-0.6-00000000000-20220531T164806Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022.05.31 18:58, Ævar Arnfjörð Bjarmason wrote:
> This series adds a bug() (lower-case) function to go along with
> BUG(). As seen in 3-5/6 this makes it much easier to handle the cases
> such as parse-options.c where we'd like to call BUG(), but would like
> to first exhaustively accumulate the N issues we spot before doing so,
> and not merely BUG() out on the first one.
> 
> Changes since v1
> (https://lore.kernel.org/git/cover-0.5-00000000000-20220521T170939Z-avarab@gmail.com/):
> 
>  * Move the exit() wrapper to common-main.c, I tried to add a
>    "common-exit.c" or just rename "common-main.c" to "common.c", but
>    due to how the CMake build system declares it those changes would
>    result in a lot of churn, so for now just adding it to
>    common-main.c makes more sense.
> 
>  * Typo/grammar fixes in commit messages, as pointed out in review.
> 
>  * The BUG_if_bug() function is now optional, and the docs have been
>    updated to reflect that.
> 
>  * The BUG_if_bug() function now takes a va_args like BUG() to
>    indicate what the problem was.
> 
>  * Updated 3/6 to note that the exit(128) code changes with a
>    migration to BUG().
> 
>  * Fix logic error in 4/6: We now "break" after calling bug(), to
>    behave as the previous code did.
> 
>  * Fix logic error in 5/6, which now makes use of the new argument(s)
>    to BUG_if_bug().
> 
>  * There was some suggestion of ejecting 6/6, but I've instead
>    replaced it with the implementation Glen suggested in
>    http://lore.kernel.org/git/kl6lk0a6mzp0.fsf@chooglen-macbookpro.roam.corp.google.com
> 
> Ævar Arnfjörð Bjarmason (6):
>   common-main.o: move non-trace2 exit() behavior out of trace2.c
>   usage.c: add a non-fatal bug() function to go with BUG()
>   parse-options.c: use new bug() API for optbug()
>   parse-options.c: use optbug() instead of BUG() "opts" check
>   receive-pack: use bug() and BUG_if_bug()
>   cache-tree.c: use bug() and BUG_if_bug()
> 
>  .../technical/api-error-handling.txt          | 19 +++++-
>  Documentation/technical/api-trace2.txt        |  4 +-
>  builtin/receive-pack.c                        | 16 ++---
>  cache-tree.c                                  |  8 +--
>  common-main.c                                 | 30 ++++++++-
>  git-compat-util.h                             | 24 ++++++-
>  parse-options.c                               | 67 ++++++++++---------
>  t/helper/test-trace2.c                        | 22 +++++-
>  t/t0210-trace2-normal.sh                      | 52 ++++++++++++++
>  trace2.c                                      |  8 +--
>  trace2.h                                      |  8 +--
>  usage.c                                       | 30 +++++++--
>  12 files changed, 217 insertions(+), 71 deletions(-)

Thanks for the updates! I have a minor question about 4/6, but
regardless of if/how that's addressed, I think this version looks good.

Reviewed-by: Josh Steadmon <steadmon@google.com>
