Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E903DC43217
	for <git@archiver.kernel.org>; Mon, 24 Jan 2022 19:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353442AbiAXT7T (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 14:59:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352198AbiAXTwp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 14:52:45 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5931BC061392
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 11:26:04 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a8so24220757ejc.8
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 11:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=FdAoVl8XsaIV/FVN863adKabLKpwiyQifzYp98eGONo=;
        b=ahV0pbghXhCU12S/uzQhqTrUM+pnEoLEXjat/z0YFCrLV5hH8GQqvgVSWjKFTl4lJi
         NOncseMUvVZwK1RpMhnwfYndMKvZIa2M9qiCDnSBalO0TE7z21ZGxmPYPnQ2On+6OSgd
         ZSG+2Nluzbou94AgDacUPrp5hQU/lDRd+gxLQPcRYR3R1BSQO+EA4X5CAY8owr48xNfV
         QOKMcci9gzxMn9fCb51OIMA88vL1U7tjkjCxwO5oL0fuAOopZWOQ8RrX8dZ8Po0ufGzw
         LU5kPqtkaAl3HfCe1mtK+qZugd+hO/Z5OZCxBZEiuHVVW54PCwnfPXtYCc1voQFo4xRW
         K80Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=FdAoVl8XsaIV/FVN863adKabLKpwiyQifzYp98eGONo=;
        b=CgK8vk3hbDXRBU9lwCk8PYv0VpIJMD84LuR5x4Bca7Xo9SRx3xkRUhiU8lF+iQ3WyT
         m6Xn0VgtqURu+F35r5+yeLFzsIwL6HmNXvkQetp7m8RXBpe8+V0Q2aXtqAygGed7sXKY
         i19ycQ6xC4r8ZdEeMuTnpkIH7asYzwTlfgtJ46dFLINhXy0/4v12n/BipbcTr34E+Pb9
         IKwkKOcmh8ZKp5/Oh+hWNEMuy+FV0RqDY6kM6qhSnEDOgwGgRV9TrzwI5M555tiq0+IE
         39rsW0Zf/tAeDvrSR08KuSEmQzMRs2H0LqitB1vLKQSj3IzJzM0jPlzeqRQVLWzrVTyu
         iNxg==
X-Gm-Message-State: AOAM530BkhadL7Psjtm0IFbKQmiiErC9HZxzOh3S1HisGkgvtcjscnZC
        qSy+818GQdbXG9Xn4TQj8OqvE9x/f4A=
X-Google-Smtp-Source: ABdhPJznJ1J6WW7VLxLZ0NXB7wrTuHWxLlXAY4dVXafgA8YAiEOGJE9FUMTrXHkzX75Lm9Ce+YA+eQ==
X-Received: by 2002:a17:906:c1d8:: with SMTP id bw24mr13850652ejb.286.1643052362667;
        Mon, 24 Jan 2022 11:26:02 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id by22sm5243985ejb.84.2022.01.24.11.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 11:26:02 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nC4yX-002ZXe-FH;
        Mon, 24 Jan 2022 20:26:01 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Neeraj Singh <nksingh85@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v7 01/16] reftable: fix OOB stack write in print functions
Date:   Mon, 24 Jan 2022 20:24:50 +0100
References: <pull.1152.v6.git.git.1642691534.gitgitgadget@gmail.com>
 <pull.1152.v7.git.git.1643051624.gitgitgadget@gmail.com>
 <cc47ec7a50b44e6734a36e1fdb7c21e798efab7e.1643051624.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <cc47ec7a50b44e6734a36e1fdb7c21e798efab7e.1643051624.git.gitgitgadget@gmail.com>
Message-ID: <220124.86mtjlgcl2.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jan 24 2022, Han-Wen Nienhuys via GitGitGadget wrote:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> Remove /* BUG */ comment, whose meaning has escaped my memory.
>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  reftable/record.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/reftable/record.c b/reftable/record.c
> index 6a5dac32dc6..1f236b47d1c 100644
> --- a/reftable/record.c
> +++ b/reftable/record.c
> @@ -254,7 +254,7 @@ static void hex_format(char *dest, uint8_t *src, int hash_size)
>  void reftable_ref_record_print(struct reftable_ref_record *ref,
>  			       uint32_t hash_id)
>  {
> -	char hex[2 * GIT_SHA256_RAWSZ + 1] = { 0 }; /* BUG */
> +	char hex[GIT_MAX_HEXSZ + 1];
>  	printf("ref{%s(%" PRIu64 ") ", ref->refname, ref->update_index);
>  	switch (ref->value_type) {
>  	case REFTABLE_REF_SYMREF:
> @@ -586,7 +586,7 @@ static struct reftable_record_vtable reftable_obj_record_vtable = {
>  void reftable_log_record_print(struct reftable_log_record *log,
>  			       uint32_t hash_id)
>  {
> -	char hex[GIT_SHA256_RAWSZ + 1] = { 0 };
> +	char hex[GIT_MAX_HEXSZ + 1] = { 0 };
>  
>  	switch (log->value_type) {
>  	case REFTABLE_LOG_DELETION:

FWIW it seems to originate from
https://github.com/hanwen/reftable/commit/62bbd28 and first appeared
on-list in
https://lore.kernel.org/git/pull.847.v4.git.git.1607522429.gitgitgadget@gmail.com/
(i.e. any /SHA.*BUG/ in this code). Probably just in reference to having
to hardcode the "2 * " and/or SHA256 which later/now is using a more
generic macro.
