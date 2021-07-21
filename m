Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC3BC12002
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 17:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44C1561244
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 17:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbhGUQZ4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 12:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbhGUQZy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 12:25:54 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804FBC061575
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 10:06:30 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id v6so4207193lfp.6
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 10:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q/oxdRSKI/AkeGYWD+phTbL5ZmxEXeN8MVn8KRvSMsU=;
        b=EYyMwVwEPBQPShfrK98GjIoWfCenF4gpR+EQYQ03b/RV2NucQG2M+6E7VVp7yMmutM
         UrVkfegI3k3ZbEy52w9BIaQrATRu1e8NVcBd70bwsjOkk0cc/2CusbnWfg9C2FbByGGT
         eDRlzbUDFeDdTFogRWxgSnBDajOiOIedJV8Rw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q/oxdRSKI/AkeGYWD+phTbL5ZmxEXeN8MVn8KRvSMsU=;
        b=NJvTQPTF62LNWgpClE1GXNm8bynCuBs7DUTgcu1KORqP5ZfJVROzT4CqGguctvVkof
         EvWeZdvFETj53uT/Xge7n7qfVZRvrpAo0sFYzULqBeBj57dQg9F9bhyhRVDCPFMa9kax
         S1NXnNTrVKIKZP0UNkOR0YrcekPt9eofQMrqPnVfjXgAg57CHYeZk8E8E2DvSg1DNQsl
         xs+WgFTI3MGCZ+WTEoAcI2v+pDVL9SllttjT8JHiv5MQb0ajKrKSZ5yfZI735huulRkz
         8mG90ntLTk3DddDud1hCgrJgC/5y4H3ZcsGUyLXAdMn+tyoZ6nPWziuFpKNzDkAS9YIE
         GpMw==
X-Gm-Message-State: AOAM532qlOVwMM06e+2riFQDNwWKwIcJ3SAJjGwOc7d4FntzDV7uhz91
        l/8EC7Y8MauSqdv31C4f8nWKHYwGsNTT4cJU
X-Google-Smtp-Source: ABdhPJyf85EqDDSLjELvMB28owJoXDDXa7wVJtQOrKblWk44vTeHqC2jAJSRLNH6bDnrAHuJmThTug==
X-Received: by 2002:ac2:4c13:: with SMTP id t19mr27010332lfq.394.1626887188531;
        Wed, 21 Jul 2021 10:06:28 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id k5sm1922592lfu.120.2021.07.21.10.06.27
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jul 2021 10:06:28 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id a12so4198956lfb.7
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 10:06:27 -0700 (PDT)
X-Received: by 2002:a05:6512:2347:: with SMTP id p7mr26740309lfu.253.1626887187615;
 Wed, 21 Jul 2021 10:06:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210721134650.1866387-1-felipe.contreras@gmail.com>
In-Reply-To: <20210721134650.1866387-1-felipe.contreras@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 21 Jul 2021 10:06:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=whf-9kNV3y5G-VVA2K5EZCnvv94paAEj6p=i2R4RM2emQ@mail.gmail.com>
Message-ID: <CAHk-=whf-9kNV3y5G-VVA2K5EZCnvv94paAEj6p=i2R4RM2emQ@mail.gmail.com>
Subject: Re: [PATCH v2] pull: introduce --merge option
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git List Mailing <git@vger.kernel.org>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 21, 2021 at 6:47 AM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> Users need to specify if they want to either --merge or --rebase, but
> unfortunately the former is missing.

Ack. I think it's just historical, because long long ago it used to be
that 'git pull' always merged unless told otherwise with --rebase.

               Linus
