Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D56DC433EF
	for <git@archiver.kernel.org>; Fri, 21 Jan 2022 11:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380203AbiAULmM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jan 2022 06:42:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350181AbiAULmL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jan 2022 06:42:11 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694A2C061574
        for <git@vger.kernel.org>; Fri, 21 Jan 2022 03:42:11 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id b13so42123979edn.0
        for <git@vger.kernel.org>; Fri, 21 Jan 2022 03:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=B3nB0YMeY3UXn1A+l6wPqyl09ybTgF8YyS6puSU1CFQ=;
        b=n1gN9mxj7V2PVuX1TSQ5DfyETEUz1de8uQr3yrZNWXB0uf1HQue0/pr+PRjrul+fwO
         SvX2l24Q8769ectxRACaO3w33JXqaksBRZpyxcv+0ZvVPkt+rwkStanTzRThxODQcENW
         gK+RLpuIJS05T9Uivwynp+Gd7Gu49toYnzJ4kIlT5DkJ4kT9gOacl3CbILk/jV0d/gG+
         NQlj0rWtEPLHqBsGYizXi4j8c8rbwk9plmV1vFPfvDq728bdJ4Z22/dI4s1TA9OlrI7I
         RL/XN3fG0GervfMM/nkBRYMECtW1vWHt/kX7xg0ZB8CFBOUY54YLQRRxwLjV0VfY86as
         cJnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=B3nB0YMeY3UXn1A+l6wPqyl09ybTgF8YyS6puSU1CFQ=;
        b=lW4ALJ+ZSU3UNh3eOmalZthvFD+zL4GX81amPcNiSPLuGXGWHW9ldoNyJPZlsh/wjY
         09WYstgta6847/9cf+OswbCr6OZk2y9J5vbNyS3C1BUjoA5JEDMojm04N9M8WpS+C/Sd
         9fezZGHH5B23MJU7pR74GcjYXndwd/rczVcHpyZz/f1VNI8MMj9VrkW0mA1FeB298BIc
         tUpj9VXCbWulY0jfKz7dgNjjlQK6+JqrralLrcbm25Q2DL08fAHpbZeXdyaE1+5oYjwN
         YQa36t+Mp+zcpVB9s81YiEqUUbbghe1VXwndqAj14V+aZtjS4d5CWH4vgHRVRK1ZUf9i
         v4uA==
X-Gm-Message-State: AOAM5310n7AqXGvZ9Infjtssv7Yf297RrZtpZrHq/8JV6qL31kwISnMH
        gHpvR8n8OjOrUGezW93B+HHBeF38Cxi8RA==
X-Google-Smtp-Source: ABdhPJysGEs9NV3zXBkZOZRI0oQmzVgX1Hv2V6z2vfJVqZotIPGaHycLw62twAWa0kcCMvo1AbXS1A==
X-Received: by 2002:a17:906:9b91:: with SMTP id dd17mr2931509ejc.185.1642765329749;
        Fri, 21 Jan 2022 03:42:09 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id f11sm2507950edv.29.2022.01.21.03.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 03:42:09 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nAsIy-0027LE-Ow;
        Fri, 21 Jan 2022 12:42:08 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Neeraj Singh <nksingh85@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v6 01/15] reftable: fix OOB stack write in print functions
Date:   Fri, 21 Jan 2022 12:41:57 +0100
References: <pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com>
 <pull.1152.v6.git.git.1642691534.gitgitgadget@gmail.com>
 <9218bd59b2570ab08f3a2e5c0b590656d00482c4.1642691534.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <9218bd59b2570ab08f3a2e5c0b590656d00482c4.1642691534.git.gitgitgadget@gmail.com>
Message-ID: <220121.86a6fpl3hr.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jan 20 2022, Han-Wen Nienhuys via GitGitGadget wrote:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  reftable/record.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/reftable/record.c b/reftable/record.c
> index 6a5dac32dc6..8536bd03aa9 100644
> --- a/reftable/record.c
> +++ b/reftable/record.c
> @@ -254,7 +254,7 @@ static void hex_format(char *dest, uint8_t *src, int hash_size)
>  void reftable_ref_record_print(struct reftable_ref_record *ref,
>  			       uint32_t hash_id)
>  {
> -	char hex[2 * GIT_SHA256_RAWSZ + 1] = { 0 }; /* BUG */
> +	char hex[GIT_MAX_HEXSZ + 1] = { 0 }; /* BUG */

Is whatever "BUG" this is still current after this change?
