Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C91FC4332F
	for <git@archiver.kernel.org>; Mon, 24 Jan 2022 20:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442195AbiAXUxo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 15:53:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390186AbiAXUpD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 15:45:03 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73AFFC06138F
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 11:55:05 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id j2so58379837edj.8
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 11:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=SRIYjgasUR5jZKAARL93/e3s7LIAO1Fa4TTS4bfPrBI=;
        b=lAwBZXbDEjbkL5+vxbQ8DB14rOkgZTTA2jcTKY0XY1xR8OQNg5q6yNOOsJ9rFzUZlC
         ESh19fGcDUUuEbOCdWi1FmBFaNOM7s7N9USOk7Yy1nF9vOX/Ps31FdO9bOWtMtXkZAoF
         Bb1Rd4ol/MGfgQcw2GrSflIh+6bBibYGCUEAnMM9LaS+3cE5Z2iGqJS/ZvzyMU95ybC5
         wuTqDMSHoyUXLzFIdpLK5W7f21Sdhlgbyesg9cTi/NZ6NGH7R9Hne+B4ChEE3aTlR7sY
         Eg0BiyHuJF05VOy9LkegjitaGWAam3vLXe/e4nQasq3Q42EcdriXhLRG5O9olMYYg4L+
         DM0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=SRIYjgasUR5jZKAARL93/e3s7LIAO1Fa4TTS4bfPrBI=;
        b=kkmGHVZyadifnaYOi6dfKpE9BwD5P9jjsc//tET4RMlGgMMwfKMd+FfzrX7FEuv52g
         txvLIrjs5bwe2qWF+Xhe/wfTJYxHE6Ys6B1h4DuYfNYcL6o/UhuuSP3BtZpi/9Kw2Q0y
         mz+3E+I6JRoYaT5oSec3IruqXTzGSqr0JTGU4Ex1wf1zTjSpUC0pb4y/48l1y9sOHbcf
         PkqDcoPeF92nUrmssurZ5M5S7b9kdfYlcyHl0Eca4vpP0oSs4ksnfXGNoAkx93FuBwgo
         NEJwL0xZX51QNfdQf78KqH6/AnZl+yGQ890h/zMsj9nWIs8Ksu9fI9rup0xinG0U+4AL
         1HEg==
X-Gm-Message-State: AOAM531SKi0Qn9PqDgscgFDEA05WVBnFE5bSEvH8/+xgaVrkiKngRTgX
        soEBfK+qCbHPeS9vGW//ikF5LKgiii4=
X-Google-Smtp-Source: ABdhPJyHKAEOv5gRbLWZ6cZMbrKEod5xMb4HuWLDP+XATDtEVffzlnyKsaW2ghVRsUJWxBJYKjaKzg==
X-Received: by 2002:aa7:c950:: with SMTP id h16mr16903282edt.85.1643054103724;
        Mon, 24 Jan 2022 11:55:03 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id eo4sm3888988edb.80.2022.01.24.11.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 11:55:03 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nC5Qc-002aJM-3A;
        Mon, 24 Jan 2022 20:55:02 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Neeraj Singh <nksingh85@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v7 00/16] Reftable coverity fixes
Date:   Mon, 24 Jan 2022 20:48:54 +0100
References: <pull.1152.v6.git.git.1642691534.gitgitgadget@gmail.com>
 <pull.1152.v7.git.git.1643051624.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <pull.1152.v7.git.git.1643051624.gitgitgadget@gmail.com>
Message-ID: <220124.86ee4whpt5.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jan 24 2022, Han-Wen Nienhuys via GitGitGadget wrote:

> This series was targeted to 'master'.
>
> This addresses some complaints from Coverity that Peff reported.
>
> v7:
>
>  * address avarab's comments.

Thanks. I just had time to skim it now but this overall LGTM. I noted a
compilation error on xlc in another reply that I'm sorry I didn't test
before, but provided a hopefully easy fix for.

>      @@ reftable/record.c: static int reftable_ref_record_equal_void(const void *a,
>       +static void reftable_ref_record_print_void(const void *rec,
>       +					   int hash_size)
>       +{
>      -+	reftable_ref_record_print_sz((struct reftable_ref_record *) rec, hash_size);
>      ++	reftable_ref_record_print_sz(
>      ++		(struct reftable_ref_record *) rec, hash_size);
>       +}
>       +

Just a nit, and only noting this since you seemed to be adjusting your
clang-format settings (or so I recall), but I think the more usual
wrapping in the codebase is:
    
    diff --git a/reftable/record.c b/reftable/record.c
    index 8330b7a2589..ee42897460d 100644
    --- a/reftable/record.c
    +++ b/reftable/record.c
    @@ -464,8 +464,8 @@ static int reftable_ref_record_equal_void(const void *a,
     static void reftable_ref_record_print_void(const void *rec,
                                               int hash_size)
     {
    -       reftable_ref_record_print_sz(
    -               (struct reftable_ref_record *) rec, hash_size);
    +       reftable_ref_record_print_sz((struct reftable_ref_record *)rec,
    +                                    hash_size);
     }
     
     static struct reftable_record_vtable reftable_ref_record_vtable = {
    

I.e. to "keep going" with the initial line until we hit 79 characters,
and then wrap it. Then for casts "(x *)y" rather than "(x *) y".
